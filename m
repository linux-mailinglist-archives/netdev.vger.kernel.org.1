Return-Path: <netdev+bounces-205688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCADEAFFC30
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261617B5833
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005AE28C5A5;
	Thu, 10 Jul 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2TM3yYj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2B28C5B0
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136013; cv=none; b=Fovl0tXC3fmalty4YZrnOnE0+zupt/tC8mbrJpFjU4ncKwW7qJ8mXmjIMSE6u0bjE63Q7gD9lyhHYBUzb3DkQPyUrm3at0aNfTfONvz/Pb4h1Rf7hwSSg4cpP32LnS1jIKqCYBZZNlwtk72vz/W9OmBOY5ueEu2kwfrigUqsAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136013; c=relaxed/simple;
	bh=U//+v5a0o9qHscjeOG2Q3M9nP3v83t9bSkJ2x+NQAvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsMRZeTGGf7ojp7PeN6iLo5MOGMzb6wDNM+48fRBhnhVfed+A2KeUMWq1NSMRgGNyXbPgDNj0h/39LURhDa9nkcLz0PFfp+B5kKfmzJt9aIugrudWkpUAvpdiH4Wkj5Pzq2uIcEysaz64KvQFSa1VbSwDfZYQtZg4yMUcmVzjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2TM3yYj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752136011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sza+IKOP5j/hxMGakskkrB4XI5GsufRQhspoUE9PIl4=;
	b=a2TM3yYjxobPkAbXkPyQcDWhtyTWl+T/OrC/BXFyMq9m/khx4hl2/sX+CWWun+kkg4IdRm
	4k3t2fDa2+zLAu96Va6GDTCuTgVjjbZ7qpVSbb/dEP33efF4+2c/J7Xr7HhylU0XH10NHS
	yiZk777Zkv0ix7pQQE71zzbCsKzIjbo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-pZFqX9k4PtayFnBTDwljXg-1; Thu, 10 Jul 2025 04:26:49 -0400
X-MC-Unique: pZFqX9k4PtayFnBTDwljXg-1
X-Mimecast-MFC-AGG-ID: pZFqX9k4PtayFnBTDwljXg_1752136008
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so356694f8f.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 01:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136008; x=1752740808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sza+IKOP5j/hxMGakskkrB4XI5GsufRQhspoUE9PIl4=;
        b=Pz9udy8fHpxjiPoepCA/f1mbAhY9l24StLrYDqj45NF26+S3uViiTx4RMrB6SpmAlI
         IJWkY6t7hqmvFMemIPccxQ68ndERTXWWj80HOU36u2SZN+HzjmcSiK+ELp5Md28/bbjh
         KrX5eBVc2Q15zDr4tgG0014AzulfJ9by54c0+fpbNDm0RfzW3mrY31u5OZTsRmVeybBw
         nPx90Ntav1PoL2FQqTTJwq7LWB1h6gzB1EJrD0LFvzhBtjXUgDrX0KUiDSJ8rakvgc5+
         9GQa119SfE4IHuK7oPJEMnrptRzxYWSF63q4Kc1uGuXXueXfavV9qK4T4KyPkrBpSOt7
         nQEA==
X-Gm-Message-State: AOJu0YwZR7di+E37uFCe/LU+VPIeEDW0h+LsWwvg8VkT7kZDUI9qF5RM
	c4L2B7caofeABUzvhNJjTqXATZtjQse8HkLDV6330syO8LpnAhEuW+Up9pUXknn/IJWcfo9EGZK
	dvcuKbSu9ic8wpTrAxFYELFYoWIa2Xg9yQjnmOs6RlHmYfNED0LLltfdYAA==
X-Gm-Gg: ASbGncvuD/MLJyid19b2R67fJzSZ+/Kx0ZXPlQVYBkQ5AQyyhOFCsiq8PIk8GpdVw0y
	3nViNEhFriTQok5GSZknFFoAM8RLZr1g608f2Ryg3eQ7Qopk3ajIAfccxhsnAErqz+93x4KVGY7
	wMPBDlSLjrF/HPEc+htAmP3PxVRu6DrRkQTqYKmoGefkgwNhY0Lceiw36CDgzFhnQW8B/ohzTpp
	TUbZXNWEgB5W+eXLoDzVcLDbQSWHTXo4VQMuXwOF4mX7CHq4AMhfGJlLWzArHo4CPZ0K/W/QJVD
	jrD7ItYtqAVc2Sez4ztSSg6lGF6WGC/GrH0dl8G2lhID2dm7TpxAPyAmwaxTvJuwB6iW1w==
X-Received: by 2002:a05:6000:40c6:b0:3a5:5270:a52c with SMTP id ffacd0b85a97d-3b5e4472ec0mr4778870f8f.0.1752136008369;
        Thu, 10 Jul 2025 01:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgdcEh6q1I/GWA+mA5Eoi9m4dRrWkS+fzEiavqUBfv1TfrFfEGRZ2MyEm9+svQXhsbkjE32w==
X-Received: by 2002:a05:6000:40c6:b0:3a5:5270:a52c with SMTP id ffacd0b85a97d-3b5e4472ec0mr4778832f8f.0.1752136007886;
        Thu, 10 Jul 2025 01:26:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd464011sm12416395e9.10.2025.07.10.01.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 01:26:47 -0700 (PDT)
Message-ID: <9ea58b38-921c-45a0-85cc-a586a6857eb1@redhat.com>
Date: Thu, 10 Jul 2025 10:26:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: This breaks netem use cases
To: Cong Wang <xiyou.wangcong@gmail.com>, William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, victor@mojatatu.com,
 pctammela@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250708164141.875402-1-will@willsroot.io>
 <aG10rqwjX6elG1Gx@pop-os.localdomain>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aG10rqwjX6elG1Gx@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 9:42 PM, Cong Wang wrote:
> (Cc LKML for more audience, since this clearly breaks potentially useful
> use cases)
> 
> On Tue, Jul 08, 2025 at 04:43:26PM +0000, William Liu wrote:
>> netem_enqueue's duplication prevention logic breaks when a netem
>> resides in a qdisc tree with other netems - this can lead to a
>> soft lockup and OOM loop in netem_dequeue, as seen in [1].
>> Ensure that a duplicating netem cannot exist in a tree with other
>> netems.
> 
> As I already warned in your previous patchset, this breaks the following
> potentially useful use case:
> 
> sudo tc qdisc add dev eth0 root handle 1: mq
> sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem duplicate 100%
> sudo tc qdisc add dev eth0 parent 1:2 handle 20: netem duplicate 100%
> 
> I don't see any logical problem of such use case, therefore we should
> consider it as valid, we can't break it.

My understanding is that even the solution you proposed breaks a
currently accepted configuration:

https://lore.kernel.org/netdev/CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com/

I call them (both the linked one and the inline one) 'configurations'
instead of 'use-cases' because I don't see how any of them could have
real users, other than: https://xkcd.com/1172/.

TC historically allowing every configuration, even non completely
nonsensical ones, makes very hard to impossible to address this kind of
issues without breaking any previously accepted configuration.

My personal take would be to go with the change posted here: IMHO
keeping the fix self-encapsulated is better than saving an handful of
LoC and spreading the hack in more visible part of the code.

@Cong: would you reconsider your position?

Paolo


