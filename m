Return-Path: <netdev+bounces-165096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA45A306AE
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 10:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB92B7A229E
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5061F03D2;
	Tue, 11 Feb 2025 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dncp8XJx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542426BDA6
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739265140; cv=none; b=C3v7qoaAVLBTLCOiOEosQbWPWRz01iGFIctKCyWPVI5acH+4Ez9qS2Sqw6FAbWk3rdw78PsCmMH84NAoEEHRDkWywG6do/3w1W/DqStqLsli3po/boaz6TYRuoaAe4epkcQ991goM/HmOURP/YNdHm+j+TJLw9RwB1apBXulojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739265140; c=relaxed/simple;
	bh=NhwlTUXIj7yyzmg24IsX2W2CXzFsDWUHHY5PNW7DIio=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ed97Y8f4Nkue55c6E0+lAal/i8lzLXT8LNDQSIU6HSiRl2nyEN/RTDurb3rTsO5u0ku/WVfklBvhPbTlWDMy4rJSOwknLrudkmuGuD4gLmeVBjj9CHrbkgrktyTFJRlfrKbpiVNNxe2+qG34w2uRf4MtgEIrRXnpmukbcj51DZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dncp8XJx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739265138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7zYp0aE1/AT7My9gGTVYIn4NVYUz/DCgEYzci8JuU4=;
	b=Dncp8XJx0K1WUj5dbGaOLcoK/bai3R0y8FrC/tj9WpjCY88MMR9I0QuvlrfjqA19GvSvWj
	nrxlDcFx3yKoG+cL4ZY1fzhEThpKNkoiwOHo9fxTtnj3kstf+jukuj6FvpyfMskBJ5U+Sc
	VOrnPh7OI6dpIY/U9vXgenhgXwrr+Gw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-QfYQExRgOFOqMBboLI7hLw-1; Tue, 11 Feb 2025 04:12:16 -0500
X-MC-Unique: QfYQExRgOFOqMBboLI7hLw-1
X-Mimecast-MFC-AGG-ID: QfYQExRgOFOqMBboLI7hLw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43933eb7e1dso18976695e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 01:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739265135; x=1739869935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7zYp0aE1/AT7My9gGTVYIn4NVYUz/DCgEYzci8JuU4=;
        b=h9wAWbpLgNjK146u85l3zJK/TtKKDnLstcfsLdgjpn+X9zsic8CxQnGiMkpg/wS+wz
         XBT9VtQgUwtHusIOw72ZiNv3kPFQt0BgIEmI/E8AG7aQcL6ciw8pBmIMlxWitN9xD06l
         j7VgTSetx7BBJ6Lrhib3K+03b28TYwB4dhXJAfXifGwCW7uiKiWT1Fcc52FSXyDjHd8u
         txhvD3bp7BJwXr45QVkyxNLzVPWiiSjRx4EYChlC94LNWFcSwoo+D2K5BIRf6pikLSYz
         oNAlaj+5Nn0mUJDBoYmmiu1yzwYK8gMpotG9qvaqpogeA6cw24JOGm6iS9XpqkQLw9l8
         cguA==
X-Forwarded-Encrypted: i=1; AJvYcCUBHCmXpBNC7AU2AqAwU67hCQXUZc2dRAQ57NvH23F4PonhR4xYqFF26UMccY6M2RoRVVdYigs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3Hnyil+g8K9j7lFCnbXH95yyks2AqWb4AggRIUNl+wFVEE10
	9XTyn/1lWt79z+9/mx5erW6vTLEYyHtJCgbak74Q4UZag2n7yuIW0hPygxizbJd8OrALXCIZEpJ
	suv4ICvDgZP6hUqn9zM1e2YMHYF+5OySe3DKRpo4HWdD0pWn6lU67Mm2Rn0JBzA==
X-Gm-Gg: ASbGnctgXT2mcA3ntflyxOWCqzTk9wWjVp7n+0Jm5kUlhBuIAMsZJ6QBEsvZfZalcjx
	trBKdO8O8aJrkgkDEzkyeuK2OIXX08EDrfeSivPtKKS7/VBwRkfLIO0RH27N1dETAP6rmtuX3no
	/TeuMZGytsQb9k9mwbogcStUn0x/4wPRYZ05ma24fIUSC84QAImeJYY/hA1OIWJOLNqFGjVDIUk
	fBYV2fphuJfOOGpyEj6GGg9nliaTr8sG9BgPHRPmxvGpbMjPoIfoZZL/fWn2/mrZQNBeJd8PHe4
	QOD1MZdoGDNWecF4YEvfUKOK8gzXedegkCM=
X-Received: by 2002:a05:600c:1e21:b0:439:3eed:1cf9 with SMTP id 5b1f17b1804b1-4393eed2360mr80626935e9.17.1739265134982;
        Tue, 11 Feb 2025 01:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLd1KuZ86QqoelLRtvt0R+BxUp3UQrAkuNkZ87NGVRH9NTAh2bXSXPnQXKhTP6jWz4JZmjEw==
X-Received: by 2002:a05:600c:1e21:b0:439:3eed:1cf9 with SMTP id 5b1f17b1804b1-4393eed2360mr80626725e9.17.1739265134703;
        Tue, 11 Feb 2025 01:12:14 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcd21fe18sm11190310f8f.91.2025.02.11.01.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 01:12:14 -0800 (PST)
Message-ID: <c3aec7d5-8c28-49f8-ac0c-18436d5b4da5@redhat.com>
Date: Tue, 11 Feb 2025 10:12:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] icmp: MUST silently discard certain extended echo
 requests
To: Will Hawkins <hawkinsw@obs.cr>, netdev@vger.kernel.org
References: <20250206015711.2627417-1-hawkinsw@obs.cr>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250206015711.2627417-1-hawkinsw@obs.cr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 2:57 AM, Will Hawkins wrote:
> Per RFC 8335 Section 4,
> """
> When a node receives an ICMP Extended Echo Request message and any of
> the following conditions apply, the node MUST silently discard the
> incoming message:
> 
> ...
> - The Source Address of the incoming message is not a unicast address.
> - The Destination Address of the incoming message is a multicast address.
> """

I think it would be helpful mentioning this is for ICMP PROBE extension.

> Packets meeting the former criteria do not pass martian detection, but
> packets meeting the latter criteria must be explicitly dropped.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

The patch should target the net-next tree, and you should add a related
self-test (i.e. extending icmp.sh). Also even if the new behavior will
respect the RFC, changing the established behavior could break existing
setups, I *think* we would need at least a sysctl to revert to the old one.

/P


