Return-Path: <netdev+bounces-176205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC3BA6958C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE90886478
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9BE1E1E01;
	Wed, 19 Mar 2025 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf5BegEu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E7A1DF248
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403222; cv=none; b=Y3K5TnWpj648swccg/j1SFuA8esNXkEK6Nx/E1uPG1k2Y+sBgRpbW9CksOCDxsQxfno0u75cGuWVYCUnDL4Jt1AVBJnn6DDfnWFUiXl/ZQv/Dr2UFUsFVjDgOnuJ2rniPN4L2RCIpHxtnSzp8TrH+wwAINpYA9ZLIS7ptkU51YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403222; c=relaxed/simple;
	bh=oz+OFIGWSJQCLzloFMS5sii2D0iTDhSONOD8RtUSsOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOg77lpEnjw4su0vY7nrcg8lFyPZyM9FvyzZyhu/1PFcxkghv0HWLRvODX6L9zQF6LIG7JYFUO7UYbncuCN3hlF70clUWiZyFDB3XwpIhFsW+/7l0/Znrymh9jEbpcDWRYFYWu4FD4ZSH+DPz+c2VtGvKC+CZgQVlVz/6jjrGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jf5BegEu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742403220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lh4LVotVsrWlMGgk1KmT3ER5dUQjkNY6mvUaXMFckIg=;
	b=Jf5BegEuKx5Pq3xt7Lb4E/wT23GfaD/ZcrU//Owp5FcsAf1SptkGW38Zj2mkJ2aNR39YwA
	eNVYxrr4/wLLscJ0rGLqDRuPJQCFBafIBkgs6yddVMIcq6UX7KQAo1FJnsVYabvCenusLq
	BMyzWvv1JN/I9rrQOfOr9LxmdnH6LME=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-ia_sF9EeMUOdwwFz_wNr1Q-1; Wed, 19 Mar 2025 12:53:38 -0400
X-MC-Unique: ia_sF9EeMUOdwwFz_wNr1Q-1
X-Mimecast-MFC-AGG-ID: ia_sF9EeMUOdwwFz_wNr1Q_1742403218
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-399744f742bso309672f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 09:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403217; x=1743008017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lh4LVotVsrWlMGgk1KmT3ER5dUQjkNY6mvUaXMFckIg=;
        b=jXEeJmCmkjVYoLiTiEWe60ECvl2E79UgTdTqYc3mEyc6d6b0yispcozi2DiBQlHbXR
         LXCiD0yoAejNJMGlQEdU4XJnI5VZxWBBpqLwdeiF4qoSFV5x69CSkHrShGFGVVecGUTp
         0iAHobuXzxaalNu5SBZ1HvysKlZ56yO634KuPP8851NlWErU0lwllez5Ej7otiZEipkC
         LOhizUxTk0RJYXVRuRDFIOCqy563VFLCvK2Pe1n6Q8gV4m+qdr9kdOkypaJEYZl7Ogpa
         Dgmhv+QTozie1WQqu8Y3+Wt4CS1YzhEqer/7IwJ4ZGvsMGdHi1pS47c1JS2KsbMn3zxj
         W3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDBdO8aicN8h/4McggArFGSza7j1qVxPMm3S9VKzNjsPKjpMM/ohk/VwjZ8yYqo9Jaoy4LpCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuX1z1fM/Ce456pJ02PM+SOkczdVXVVdx8ZXBl4qYMZiFMW8oP
	y+Re2tfwTvnWlJoF9nkXrdiHBGKTR3HbjOzQnVTbTTJl96MImHNGzb1kCl3eJDBiiW6ZXAkogpA
	5SPAhq3FvWDMzlBFXdnwj1MYiBnao5fd6x8Kg8fqibseUiDmuN8QLIg==
X-Gm-Gg: ASbGncsO0wvU31rNyOH1yYozJFRXhgIUUnVK3q+r/d3nI6AwZ29GLJ+9jmKD2Qk1A8E
	LYqVmQHDGiFtuT2zJjJo8KQRKKXdb9ynpwxECykVdxPb7oqVSZrroBQTQXjJHfGkfdIcss0dN+7
	RqEc5v1d7ehfo8w2xDTrNy6U4izCrVauBo6HuFdy9gYwf8Jww0vkmZ2XTHJPS7NHLvBhhZMtfsY
	HHlCDIl7lXCaFuPb6rInAH1MIRvz25wV00zjTkcuLOQB4zcPQwNMxdclN4om8UHIuf4bUBGTNR6
	yez5go+YfoE50p33DPWRk4U98TL0J5oepdOFOzkvCF1Odg==
X-Received: by 2002:a05:6000:4025:b0:399:7916:a164 with SMTP id ffacd0b85a97d-3997916a1a7mr758720f8f.31.1742403217591;
        Wed, 19 Mar 2025 09:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLUmDOWNSsSJgvpfazJk+QouBdD3+MAKJs0286Fi6yxL3Et+VD4N/CZt1FsN80KWfRnOy+TQ==
X-Received: by 2002:a05:6000:4025:b0:399:7916:a164 with SMTP id ffacd0b85a97d-3997916a1a7mr758680f8f.31.1742403217067;
        Wed, 19 Mar 2025 09:53:37 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb8c2sm20989176f8f.85.2025.03.19.09.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 09:53:36 -0700 (PDT)
Message-ID: <ae626131-20e6-4d7b-b5ec-5a9804917e51@redhat.com>
Date: Wed, 19 Mar 2025 17:53:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ieee802154-next 2025-03-10
To: Stefan Schmidt <stefan@datenfreihafen.org>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, netdev@vger.kernel.org
References: <20250310185752.2683890-1-stefan@datenfreihafen.org>
 <91648005-0bf9-4839-8b8f-5151056c9f9a@datenfreihafen.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <91648005-0bf9-4839-8b8f-5151056c9f9a@datenfreihafen.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 7:37 AM, Stefan Schmidt wrote:
> On 10.03.25 19:57, Stefan Schmidt wrote:
>> Hello Dave, Jakub, Paolo.
>>
>> An update from ieee802154 for your *net-next* tree:
>>
>> Andy Shevchenko reworked the ca8210 driver to use the gpiod API and fixed
>> a few problems of the driver along the way.
>>
>> regards
>> Stefan Schmidt
>>
>> The following changes since commit f130a0cc1b4ff1ef28a307428d40436032e2b66e:
>>
>>    inet: fix lwtunnel_valid_encap_type() lock imbalance (2025-03-05 19:16:56 -0800)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git tags/ieee802154-for-net-next-2025-03-10
>>
>> for you to fetch changes up to a5d4d993fac4925410991eac3b427ea6b86e4872:
>>
>>    dt-bindings: ieee802154: ca8210: Update polarity of the reset pin (2025-03-06 21:55:18 +0100)
>>
>> ----------------------------------------------------------------
>> Andy Shevchenko (4):
>>        ieee802154: ca8210: Use proper setters and getters for bitwise types
>>        ieee802154: ca8210: Get platform data via dev_get_platdata()
>>        ieee802154: ca8210: Switch to using gpiod API
>>        dt-bindings: ieee802154: ca8210: Update polarity of the reset pin
>>
>>   .../devicetree/bindings/net/ieee802154/ca8210.txt  |  2 +-
>>   drivers/gpio/gpiolib-of.c                          |  9 +++
>>   drivers/net/ieee802154/ca8210.c                    | 78 +++++++++-------------
>>   3 files changed, 41 insertions(+), 48 deletions(-)
>>
> 
> Friendly reminder on this pull request. If anything blocks you from 
> pulling this, please let me know.

I'm just lagging behind the PW backlog quite a bit. The PR should be
merged soon.

Thanks for your patience,

Paolo


