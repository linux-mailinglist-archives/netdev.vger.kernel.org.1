Return-Path: <netdev+bounces-273632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ9BBi7My2luLwYAu9opvQ
	(envelope-from <netdev+bounces-273632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:29:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E2336A444
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EED3E30209CA
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16B314A82;
	Tue, 31 Mar 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xv8Qufrq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkkXWSJ7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A21A135A53
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963480; cv=none; b=koem2jyH577HUvxNFlgtemyfdtWEc3Ti9/e0YsWCvkobE8E4XohHA7xt+LOWbKQ1Rs5uT0Jpl4oVyidUITqVrvZWYeq3VJuy/T2/eJv6lWIyDpHSxs/HKzwLEWpvOfBlgnrQBqcwKEfz44duerP6Th6feqR+SmD6mhFQHuiHkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963480; c=relaxed/simple;
	bh=Uhy4axSEFW2Qezt3TBNhyBcjDSrK7116X2GQnMj67Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0iNIczTudH6oXLXwFkS/Skvdzu5BjExEeDZBF17jnWXi+n1tmiTSh9aoBS71B3hTBP9ZaVz14IujI0A1Q71cd3C/Dm+Kh4UTVKsGcUFeAwYP3i76W7xLbdSrd0b07HMiho1W/kNWaS8dzKV7/RY2qXgRMKj18i7IInwdM1RU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xv8Qufrq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkkXWSJ7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774963478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eAEdH/RFIKcmDncsXTS+NqcpAUMnQKgVC83ZaxUTu8=;
	b=Xv8Qufrq42HFTUgwUYxxxJjD2lbnCVcT/RrLdx3/X2gNU7me4JtfSQp2Laq6NP8hz063+0
	+N7ogW/i287KrXTdeZbaAan3CcDdwFO7Ev51rDZ9FJdtmBHHkhj/NN3CXROZEevOUXRB+B
	+kpIC3LYARwm5B/Aouktpe5RLuwypfg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-eVl8gUDjNlSF3nXUw50CVg-1; Tue, 31 Mar 2026 09:24:36 -0400
X-MC-Unique: eVl8gUDjNlSF3nXUw50CVg-1
X-Mimecast-MFC-AGG-ID: eVl8gUDjNlSF3nXUw50CVg_1774963476
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48532df52c5so62015885e9.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774963475; x=1775568275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9eAEdH/RFIKcmDncsXTS+NqcpAUMnQKgVC83ZaxUTu8=;
        b=HkkXWSJ72hOcCnB9JF0AiZf5Mufa1jDsLMfgMGCEsUoVXMTxM/4HNWMrU8MbW9OEYp
         vZcWrl/PXnG43wLQVe8hfrfWyedQOBMjuVAo1Vv6LRRkaa3+S9w2UIs8R8KFhsI+RClD
         FDxmOOqxim71GjEGO9wWm2D+ugU53tdWrHgGHvP7m83h2tb3ikCNhVb0xJW2Ixb2YSR/
         YVC31/zYiqzIfzpgHpfjxydHZyKfi2FE+OPGjiqLqFeEL1ep27MjGnwXcAcXmgS5uC0f
         MURB89EFuF1PB2pxZyOW59H5MNux8FvyhDf2WMV5w04RLz0CqYeP+x4bx1umGi7pLdHV
         QFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774963475; x=1775568275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eAEdH/RFIKcmDncsXTS+NqcpAUMnQKgVC83ZaxUTu8=;
        b=MDkuImoUyVm0UEdsyA2FM1Pitvc9I3aSwzqbe479X7tmv38Bk50pC29JZ6xrAanad/
         CDqXaBX/xd2PJvQcA6H4u9vejND/KSs/twe43j7dXW+Q4z1vDP4QGAg+gTbWWwsLsoaV
         R0M517y/FKltaL54nYZzD/NGzrSUoDVpKyu/oTc9SpFyY3kliAnh9IgndmLPzXhH1MLJ
         06WCxG5KY5xo3c8FSEn+F05WWOCci697+96ayGsV1VVr7nhub1ai4TTBhhDWOXXHUXlA
         OoCLwM2ZAi89L6xRz+u71s7yJawP+96uIGQKC8za98sN75AgGluET8880t5SgtO3vGS9
         pDRg==
X-Gm-Message-State: AOJu0Yx3kGQX1AeyDOH8oNLSJ7ZWUXydU7Kp7zPjq2lP77MgkMm9kncZ
	C8OJTxOBIntadv8VOSjmIq/bMgSjgN0V2yNEnQcyftUjzrW6tYNawECTQzXSfvZvyNn54E5Wsfm
	feQ4C0ZIT7rRmg8Y4hFlXb+f5bSBgts7Gq17MSl71B+ysTu7EMQagwMUzQg==
X-Gm-Gg: ATEYQzxmiEfoFrI4NHl2NM2oX66e6/W/oC+ZCW6FS5MSbapJlJ7/Q0JK8ph6NrujpHK
	521nAP6bmIYbPn7Ev52CvU5CqbMGw8bGYmLvEET5ZC1FxkS5V3VG66VGu2nshsu4gy3xPmABbkj
	MNONfXkDixOuZUUpmylQrRVLrvbhDdKSd6OScGUnbfxOpsvVVwdzWFmVZOYd2eRjy6bkdkGk8aP
	OSQumK2YW+YzIeWRgAbUYko9X743v6Wm6qlmHxBCkFOnEpX+TkEbfxChyGwgy38ZNg+9fq04DMy
	D3mBNa4twntw/v0/E4PHg6GMM6wD5/Ezfq4Mx65DOP0evFkwIQ8Gv/Qc0M/vrfiKOcpkUYmma8e
	G0X/Hbpjn2qko4J9vIWqbY+Y1n5XF0662UZuIU3ESyDEuu44XkJswt9+f
X-Received: by 2002:a05:600c:8b31:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-48727efabdemr333299355e9.31.1774963475452;
        Tue, 31 Mar 2026 06:24:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8b31:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-48727efabdemr333298965e9.31.1774963474986;
        Tue, 31 Mar 2026 06:24:34 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c536a7fsm37452055e9.1.2026.03.31.06.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 06:24:34 -0700 (PDT)
Message-ID: <4c7118f6-425b-4584-86fb-97f2a68c4474@redhat.com>
Date: Tue, 31 Mar 2026 15:24:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: realtek: support MDI swapping for
 RTL8226-CG
To: Jan Hoffmann <jan@3e8.eu>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Markus Stockhausen <markus.stockhausen@gmx.de>,
 Damien Dejean <dam.dejean@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260327202001.413280-1-jan@3e8.eu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260327202001.413280-1-jan@3e8.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273632-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[3e8.eu,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,makrotopia.org,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57E2336A444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 8:32 PM, Jan Hoffmann wrote:
> +static int rtl8226_config_mdi_order(struct phy_device *phydev)
> +{
> +	u32 order;
> +	int ret;
> +
> +	ret = of_property_read_u32(phydev->mdio.dev.of_node, "enet-phy-pair-order", &order);
> +
> +	/* Property not present, nothing to do */
> +	if (ret == -EINVAL || ret == -ENOSYS)
> +		return 0;
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Only enabling MDI swapping is supported */
> +	if (order != 1)
> +		return -EINVAL;

I guess some existing setup may have "enet-phy-pair-order" == 0, and the
above will make them fail. I think you should just pass with no action
in such a case.

/P


