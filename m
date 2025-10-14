Return-Path: <netdev+bounces-229112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B00BD84D4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4575E1921BA9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03432DCF65;
	Tue, 14 Oct 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrCF4ZsQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BCA1AC44D
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432097; cv=none; b=IkVNn7oknil364XK7FwKxvBjZ4qCDirYeAb0Es5qml0teeH2f9pV4UMaEVsoJLxHfghdub50+9jOZvdY3j5LiUsf7TrpuztbWk3IMxMiLM3xc8VAOjSYPMGD2n8wIU4lktk4RBlGvWM/LY9MN/z6V6g4ncVjdXWoTnzh1lzjSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432097; c=relaxed/simple;
	bh=iX6E6+YxRDwUo/T30nKPqiL+qYTIhbpnXBcRNSEmfHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Elk/bwT86w6OU7zHlXpocvtJqHGqMVED3VrKMOxtB/7W3DjFoxJ/wdbf0TomAmaDBYLZiSBVNbLGHqZnoMYlzE+CdG2a6g2QaYQkI8Ny2WIdmoK/nTu86fXW4n1oxbaYrhtdjU5Cd5y9DL0uu0dYwMWEK7RoU8K4RTyvJHLo2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrCF4ZsQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760432094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3ePW8DmjVhMlthty30rI8us0wQNWvGq1RuzdSVHC7M=;
	b=ZrCF4ZsQfL6lRX9Ac/EUwZ1U0NF0/s+FiYDo787jVP0vcRK0/4oQSM1kgM67tW46wisszi
	YpcZhgMouVMFgovc/XPhdfexcMLVbmkSCOs6E7dYj7sggMk+OvNhBF9lqygLG4cnyD4rSO
	xLVJbem1/eCa5dwH78e7XGO+XyP5XX8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-RR7o9_7HP3-pGFIKLYy4uw-1; Tue, 14 Oct 2025 04:54:51 -0400
X-MC-Unique: RR7o9_7HP3-pGFIKLYy4uw-1
X-Mimecast-MFC-AGG-ID: RR7o9_7HP3-pGFIKLYy4uw_1760432090
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e3d9bf9e1so34093085e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432090; x=1761036890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3ePW8DmjVhMlthty30rI8us0wQNWvGq1RuzdSVHC7M=;
        b=SAz8eIcA1znCmutsWhM0KuNPsyrNA61QRJZaJcTlgHbRMDhixF1eSCnZ0t5fYabwBB
         pTA42n1e5ARP6XCd6IJanhP4fho2C0X2J47DI6lZddC/ZCQL80x6p4I4QqcLcO00f3mZ
         loCYgqy2+VjMWAz5iCdHHWTWs1i6PQdVLy8U9bRU2pf8hCDiZm6R6A01wGZAmBY6aXXQ
         VhPD8fuj8pBqxIpuSUuIC+iyfvXZ7DE1NcGfY2kqb69GcD8zrVNB3aU8MgWJGLB4rlNg
         LqRzq8PW+TJyAc+Bm09uZe/7Q9jNGNHgQkSB5FvQ0fNtx2D22tAGPn3sYHgDzZrveeNC
         Z5vA==
X-Forwarded-Encrypted: i=1; AJvYcCVqgjdTxyij5NwgFx+jQIgSTxQnuJ0LC10ddrbnz6mKeJnTb+jlX1qOby/W8GRaglHjKdoB0R0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzampw6BTdQ/uV2M9gG8E0eW9mqYbHFn+Fd0tBpQ0g1f92T3CT
	0u9jpTiAug4eRJJmC9pkoYJSCaEVJ8yyCfQo6UQs3OE21AqjJkaJi+EHqzqhP2V+tMTzJDxeW3w
	udsczEpshE8Vi2yAq1mK0uXH35aHvPayh41pw0GRR32K+BjLH+BC0dDR80A==
X-Gm-Gg: ASbGncs8abNs8XcI99ELrbmH3s8H2K5HQT5uomEdANAMmykQsQ8dcFTX3xQAatDlEiG
	UHKHJM0hm8mBoVIwwHTtAOSTksn8tTwEXQOPYxnaF7J1OO8sXmWVclFu/Ey6aFPJxAqDmdfhUwQ
	KoS0yFtBzIGwly88BNV+/Oo5m+o6yW+u5/H7P2r7wvXc06xHTsCtRrpGxdPlIp9dUfasnUzwSCV
	ax29dzx4KcNK7hDSaXU1wyU9L8XK9o3sYNpyRF+FZ+lpk01f9QjiZvFjjvHYG6gpjfMuozbjKE6
	V7Qz7IojuU0TylFkc5LQYfWSL1hY/cKPuosdT/GAwVkNCA92PXfVgVakwUwN3nh80chvA6j0ryT
	bBTU=
X-Received: by 2002:a05:600c:6383:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-46fa9a8b48dmr175305655e9.6.1760432090036;
        Tue, 14 Oct 2025 01:54:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBAxEVuWznXYrtCAfwzB3hkJ+PRTe54mZDm2xs6IpSViayrzrzE+Zj57deGdejp9cH6//nGA==
X-Received: by 2002:a05:600c:6383:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-46fa9a8b48dmr175305415e9.6.1760432089597;
        Tue, 14 Oct 2025 01:54:49 -0700 (PDT)
Received: from [10.0.0.23] (ip-89-177-97-11.bb.vodafone.cz. [89.177.97.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc1c5227fsm162559065e9.9.2025.10.14.01.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:54:49 -0700 (PDT)
Message-ID: <6e7b63e0-65f5-4920-8908-f6f6ede9716b@redhat.com>
Date: Tue, 14 Oct 2025 10:54:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net/hsr: add protocol version to fill_info
 output
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20251009210903.1055187-6-jvaclav@redhat.com>
 <b25a73bf-1309-4f9f-9cd7-795e0615635b@suse.de>
Content-Language: en-US
From: Jan Vaclav <jvaclav@redhat.com>
In-Reply-To: <b25a73bf-1309-4f9f-9cd7-795e0615635b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.10.2025 10:48, Fernando Fernandez Mancera wrote:
> On 10/9/25 11:09 PM, Jan Vaclav wrote:
>> Currently, it is possible to configure IFLA_HSR_VERSION, but
>> there is no way to check in userspace what the currently
>> configured HSR protocol version is.
>>
>> Add it to the output of hsr_fill_info(), when the interface
>> is using the HSR protocol. Let's not expose it when using
>> the PRP protocol, since it only has one version and it's
>> not possible to set it from userspace.
>>
>> This info could then be used by e.g. ip(8), like so:
>> $ ip -d link show hsr0
>> 12: hsr0: <BROADCAST,MULTICAST> mtu ...
>>      ...
>>      hsr slave1 veth0 slave2 veth1 ... proto 0 version 1
> 
> I think this is missing the 'Signed-off-by' tag. Other than that, it 
> looks good to me. Not sure if it can be added while merging.
> 
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> 

Yes, it looks like I dropped my signoff somewhere along the way, my 
apologies. If it's possible to add it while merging, please consider 
this patch as:

Signed-off-by: Jan Vaclav <jvaclav@redhat.com>


