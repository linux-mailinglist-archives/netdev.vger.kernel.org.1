Return-Path: <netdev+bounces-193668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4DCAC508A
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC7A163494
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC70826E175;
	Tue, 27 May 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfpV69Fp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4136B253F3D
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354976; cv=none; b=PGu/WlLUMcwHC6OIDoQTFfV1d1wlN54MUmska2ISk3dn6w+PZazT50YScjDfar01K65g3IgnzaEDgNFj9iHbrc8jOL4SBp+HoF7XMQFHGBcOVD94NJt4pD2H7Lt4ZEHAiVdtMq4YnVl73uYR7HAaRdflBkhxVNhv/Qr4E5Kwdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354976; c=relaxed/simple;
	bh=NOseXHWaH8xtv+s9mM0rHXN4eiwUy5P7KWXSYlc/E/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGNlCwqs6x4/q9I4fFVUMxlO2ZEzFaI8Evd6ziXzs5WNQe+Z4LUAhnZ4EPvLx2NWwcHhjlm090cIdZTQl8+qlLjq41HEBnZMEkcaDt4pZQdQKiqOTixRnJ+F7DiDV4hP0/NsegmasfINiVYxilUbljznM9nLXm+2LjH6XAiXuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfpV69Fp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748354973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DA1BqB9QphFy+FmDX97ItVY4ucMKIE6RucblNOsl7Ig=;
	b=SfpV69Fpnrdt2KVO9YYVG35EeaY8b2eZwDFzo555lcFSUGAEwya2mwZ2bxA3laKSH95vEz
	GMcS484XNUFoXgnmjKlD6Osti+32rBV6L1FqxwXJL2sRYF2YCWeEk/ViG9vUyk3SKRsCSl
	XxyNisPJB+xdnkyjx+foI89ndcxrfa0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-EibyQuTIOHqlfu6o4kEt3A-1; Tue, 27 May 2025 10:09:29 -0400
X-MC-Unique: EibyQuTIOHqlfu6o4kEt3A-1
X-Mimecast-MFC-AGG-ID: EibyQuTIOHqlfu6o4kEt3A_1748354968
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a375938404so2299497f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748354968; x=1748959768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DA1BqB9QphFy+FmDX97ItVY4ucMKIE6RucblNOsl7Ig=;
        b=Tv2kVXOxxbCObDKzd454Z+SRMr8aERRQYvMDKBRm2YhpCcWUDZafpWU4oPCjU2ov/R
         k9zSGFRw4t+y319KFkxIPLc2Ox6BURno5x8akA23Lp52Pcfwo5j+FFOyQmnIT1c4AOUZ
         mm7yQ0XtfQP+MzZFWqt3ieLuKszNksgDSBCRFO5CynYqctfohKgHY5dcyRZqGK952LfT
         pYK8IXOE3/m+3InlIP7vQlqntJWAbp4fPoDkF8OUCaD68g3K535TDomKaqnlR1RskVHE
         RHn7M+ZECilOg1pn5WuJerKNuEyFSSyNlMxI7kGPaiVpgu/ki11eL6cEhfwbisyjBUyx
         XMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDMw16pcoVg/gI2AntfBA2pQ1Bk1FLQHQSCrNULGfqdTJuqu932qBsaISibTI+TwDRaw+7M4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQbFpYOTjUxUYHlRA+4u/bIAid9h4D7mH3Sx7lv9KN8J9rCm8
	bNj5+OEiuwGnwRDGYTL8x77zgtdo5XXCQe+T6EfndbD19kdUm2J5X1D5vYyZqyut/X72nTQaJtH
	UmZKoxyIAtTV8/9n5f98uy81GkGp1nGec6geVHyx4yJQK5MmpY17KLlMt1Q==
X-Gm-Gg: ASbGnctIBU//F/1Dxtt38tUHmoVkbEA+XQ/RvE2pP8woJkez1mFIvtMsxvQ88t1Y+Ea
	tiOZYH9ppkttUzGWvU3ST70B+GUmgjUSQQvs7lyQwdPpr+6LkR4ZkZYz069xI41fD6W8ZNZh61u
	MZv3i1rITZDh7EDpoWbnj3Lw7OmIoKrTUqwuKr/fa98U9gVSaX9EuzealiyGL+PEakdJNYt9Qni
	MVDU+CTBcqHpavWaFMl1POJY1ciqLTeGO6uafAWmkvkVEJGlneZt9dMhaQHuYGJDYJziUteEaF9
	x6wt8WTwprW91rKmGMo=
X-Received: by 2002:a05:6000:26c9:b0:3a4:de02:208 with SMTP id ffacd0b85a97d-3a4de0204a6mr3759578f8f.25.1748354967836;
        Tue, 27 May 2025 07:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq3geR+GdE1RtxbDNm0UoAA8srbpCnChqlA9NaXHezO6UZZnt6B9elqGF8VpeM/9ZFqVAsuQ==
X-Received: by 2002:a05:6000:26c9:b0:3a4:de02:208 with SMTP id ffacd0b85a97d-3a4de0204a6mr3759546f8f.25.1748354967477;
        Tue, 27 May 2025 07:09:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4de9c9853sm3867716f8f.27.2025.05.27.07.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 07:09:27 -0700 (PDT)
Message-ID: <8865be45-e3a8-479e-b98a-b06e5ed6ee65@redhat.com>
Date: Tue, 27 May 2025 16:09:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v5 3/4] net: bonding: send peer notify
 when failure recovery
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250522085516.16355-1-tonghao@bamaicloud.com>
 <20250522085516.16355-4-tonghao@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250522085516.16355-4-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 10:55 AM, Tonghao Zhang wrote:
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index b5c34d7f126c..7f03ca9bcbba 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1242,17 +1242,28 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
>  /* must be called in RCU critical section or with RTNL held */
>  static bool bond_should_notify_peers(struct bonding *bond)
>  {
> -	struct slave *slave = rcu_dereference_rtnl(bond->curr_active_slave);
> +	struct bond_up_slave *usable;
> +	struct slave *slave = NULL;
>  
> -	if (!slave || !bond->send_peer_notif ||
> +	if (!bond->send_peer_notif ||
>  	    bond->send_peer_notif %
>  	    max(1, bond->params.peer_notif_delay) != 0 ||
> -	    !netif_carrier_ok(bond->dev) ||
> -	    test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
> +	    !netif_carrier_ok(bond->dev))
>  		return false;
>  
> +	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
> +		usable = rcu_dereference_rtnl(bond->usable_slaves);
> +		if (!usable || !READ_ONCE(usable->count))
> +			return false;

The above unconditionally changes the current behavior for
BOND_MODE_8023AD regardless of the `broadcast_neighbor` value. Why the
new behavior is not conditioned by broadcast_neighbor == true?

At least a code comment is deserved.

Thanks,

Paolo


