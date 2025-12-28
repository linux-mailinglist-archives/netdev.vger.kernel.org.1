Return-Path: <netdev+bounces-246176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64349CE4A9A
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 10:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30BB93004C83
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 09:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CFC27AC57;
	Sun, 28 Dec 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnEarbEJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rugiwqoI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998891EEE6
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766915207; cv=none; b=LyyDoc8HUqhovWFScGOxnT3iNG9xuhvj2Rxr/qQb+76Ya3RqYKnzH2F731fXJ3Q5GO5B4GIJ9al/NYOED1myFJc2gMpS2G4xxkg6LY6tUAFMI7DnRP5CCabJnL0G2xrfR/S7zTMxZgno9ivzUCYlsO0XkKfd0mkHwlaeqPp+oP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766915207; c=relaxed/simple;
	bh=OodS2yAnBIFA852Zv5YiSE+wbMBAqvugwCjE7HunCII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFa/ADBOvHAc9WSPQSe27Bo5AOWxoMeQgZhnPWQgdnQOO6WuWBo1sUeJYvYLIIVoweTqA9gwyok4TXw96HmzUmtA3Jusn1cvIkE0EQwDqeCaj936C4TKP7X7pwsaWJjesgg/8VgCzA7Zzym2LqCKMsdZ3SY8WG7+Oru+85p91jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PnEarbEJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rugiwqoI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766915204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ge5SdlXBdYhEP4en3o5QRhcTOGiZL41XI4QQuSQIjgI=;
	b=PnEarbEJxfowWSsV20MADcU/3G3b3/1oNWtxgFJ4kOsEIjCtV/7UOSOA0wDJBpKanso2pL
	OJLoit5h0ZizbJtwpDCDulg8Qquvkv/zJcTog0QsMi3ZBZESUAICWPC9VhC+O4aY8zBWpx
	qCEWVBXZcKBE85YYc4zuDh2AUhPVU9A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-dZrU0qW5MPm46FMJ7yJ67w-1; Sun, 28 Dec 2025 04:46:42 -0500
X-MC-Unique: dZrU0qW5MPm46FMJ7yJ67w-1
X-Mimecast-MFC-AGG-ID: dZrU0qW5MPm46FMJ7yJ67w_1766915202
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fe16b481so4346629f8f.3
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 01:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766915201; x=1767520001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ge5SdlXBdYhEP4en3o5QRhcTOGiZL41XI4QQuSQIjgI=;
        b=rugiwqoIe/si8swmHLw1Xal4PMMfzsrSpfJoaKRAtC1wJtMCWSGpF2W5p/8clA+PTo
         9sDpWlZome38EKPeresS6iQpDm4mavWDAVkBeTQh1ib48e/bOjtX9VmKXoB+WKyWwd6k
         exKYWOaYEgWUHhHpqjoI7kNEjugo7/z867qfOsQXDqgy8ym6gWhUqgoKMc9YhXFK0Xux
         QTYAvjGxKknsMkKJNEnRPRpzh4UTJ+X65OQv0ZoA5pE0BshH6O7xlFiL1n/irSrmhjE3
         QJMpVAogA6SGi6IR+x5T+zH1QvclbFNfFDwciKa1izjdTLiMrKAri1C8oVfu/VSNKR9P
         pggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766915201; x=1767520001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ge5SdlXBdYhEP4en3o5QRhcTOGiZL41XI4QQuSQIjgI=;
        b=RxLHhYgpLb3/oKGCh+bhwZ9vUYZwvjfTIbvOmymyV2l+3xWF5e3TAJpqWgyp/b0Cta
         BTk94imZ5laG1Uowusp1r8O2QIV4+J0SMaEcYq0wlmwXZbjZKbHtK1jSgHpoXzn8YDSL
         vBOuvJFBZxKT1+ddVE2sy7QgdlIrICRdKp181jE1yvrf9qPELDDituzNnl3ggu1gdIxx
         sZ8D+bHPo++PxbdCVZ45utf3idy3AZM0F8ZQA4AtDftAuAXWAz/mYzyHY5aZXDijtJJe
         2CsW1YvrayB6Nb+lxqval3csT8Zy3UkOexraAN/1T1NSla87GJzufR67Nz26Y4Bqgo96
         MxQg==
X-Forwarded-Encrypted: i=1; AJvYcCXiQdKyLdauqw4xMaR9Yhbj3ec1m/axYXROaN8OlUqgH59ckHETiBuwgLYtFpfOla06i7KIm8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANoizACsGOxuf0VsgRFeMe+7nzZWTo+2GPtqt2WThk+eViqih
	spUz43eHb5O831bAiXoW2Yp4Wy5lAOQ3DN2z7vyeYxLXErSyvGCkPf2scLCqXDHg/btuTbCymHb
	EsVJntkdttcZRgWnHFCi8neeK+PigLKp5t9canjPCBP8+x41IeMrKeClvUA==
X-Gm-Gg: AY/fxX6pOy3EViJwNw3Nj97QOa4gCgGsUHpAo/iG4aul6pKW9KE8QhKCSYPUcaMpyEn
	tig+syWyXzqCd4uZuOQgrvRi66FP8QTQBCdi5j4j59k7gp5BLqyssh/xZ2e9IeG0ODMgJBfmunM
	A7OMzHghPgER+V8Xw9VnI9ypZ49s/6YhtuGLMmtbNgwhzV3R5UMS/GvEv68AsHxnX1mGz+2rZGf
	2JadHNH85iX+1QytLx3EFsgp63o0+eWB/XwJCjn3erjilQDr0VB15NGBc8H+DMgKfavnvGUcOfO
	PDjxFy0mL/u8zdsQIeDgpo0mH2uRnAY6YLvyxQSUpoyQs8KgXAKyanECFzv6k7M9z5dh4gzAgR1
	rLQMUw9vtQeXuCw==
X-Received: by 2002:a5d:588a:0:b0:431:266:d132 with SMTP id ffacd0b85a97d-4324e50e072mr32720671f8f.46.1766915201545;
        Sun, 28 Dec 2025 01:46:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5g2n2Aco1N9BsfglndZJfK1etXD5OPcu22hlHIV94p7V2/oelZwGloC2kMyE0ipuuTsdQRg==
X-Received: by 2002:a5d:588a:0:b0:431:266:d132 with SMTP id ffacd0b85a97d-4324e50e072mr32720644f8f.46.1766915201068;
        Sun, 28 Dec 2025 01:46:41 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm56516824f8f.35.2025.12.28.01.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 01:46:40 -0800 (PST)
Message-ID: <e9d342ac-75da-4efc-98e3-67bf43bc7487@redhat.com>
Date: Sun, 28 Dec 2025 10:46:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ipvlan: Make the addrs_lock be per port
To: Dmitry Skorodumov <dskr99@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
 Xiao Liang <shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Julian Vetter <julian@outer-limits.org>, Guillaume Nault
 <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Etienne Champetier <champetier.etienne@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
References: <20251225185543.1459044-1-skorodumov.dmitry@huawei.com>
 <20251225185543.1459044-2-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251225185543.1459044-2-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/25/25 7:55 PM, Dmitry Skorodumov wrote:
> Make the addrs_lock be per port, not per ipvlan dev.
> 
> Initial code seems to be written in the assumption,
> that any address change must occur under RTNL.
> But it is not so for the case of IPv6. So
> 
> 1) Introduce per-port addrs_lock.
> 
> 2) It was needed to fix places where it was forgotten
> to take lock (ipvlan_open/ipvlan_close)
> 
> This appears to be a very minor problem though.
> Since it's highly unlikely that ipvlan_add_addr() will
> be called on 2 CPU simultaneously. But nevertheless,
> this could cause:
> 
> 1) False-negative of ipvlan_addr_busy(): one interface
> iterated through all port->ipvlans + ipvlan->addrs
> under some ipvlan spinlock, and another added IP
> under its own lock. Though this is only possible
> for IPv6, since looks like only ipvlan_addr6_event() can be
> called without rtnl_lock.
> 
> 2) Race since ipvlan_ht_addr_add(port) is called under
> different ipvlan->addrs_lock locks
> 
> This should not affect performance, since add/remove IP
> is a rare situation and spinlock is not taken on fast
> paths.
> 
> Fixes: 8230819494b3 ("ipvlan: use per device spinlock to protect addrs list updates")
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
> CC: Paolo Abeni <pabeni@redhat.com>

Not so minor process nits: you should include the revision number in the
subj prefix, and you should include the main changes vs the previous
revision (and possibly even link to the previous revisions after the
'---' separator,  it will help reviewers greatly.

Patch contents LGTM.

/P


