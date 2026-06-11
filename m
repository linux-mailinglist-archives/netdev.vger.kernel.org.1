Return-Path: <netdev+bounces-298031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iaSWMcmBKmp9rQMAu9opvQ
	(envelope-from <netdev+bounces-298031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:37:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FE067073E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:37:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LbswKCH3;
	dkim=pass header.d=redhat.com header.s=google header.b="tx/MMc9Z";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298031-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298031-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B0A530BC961
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA07F3BCD37;
	Thu, 11 Jun 2026 09:33:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563240D566
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:33:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170403; cv=none; b=MoejKdZitgEIvNDovFIREPXQw2aobVietE5fsXwZxTnjz0MzJFxLUBcVYfdTKIRr20YuTLHo7d+q5YzvZRDp2HxmR3Qu6vgJbjs5mXMUOHSUnh3sIZMkavATm4jnRdGI2koOMlpWcIp++y+ogRu0l/Na3JF2MTdPP64MlP37xbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170403; c=relaxed/simple;
	bh=idYBE68HY7Bnrzf7iSrkEDBqvYgRO7rR0DyKisPXcIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgXrLuUxi9WBf9rSOQxPEqa/W/SB6aKQZBip3u23J98novPKbUoo35r8QGT+X+YLuOV49ps/fG+RJtzARi66NAKW9+GKGrmea9nG/idOAGenLyT5I58nis2uZajvDquT1wSES2Y7Tc+XaZ6kuxbrv1veNpqKe1//u9V4KF9PUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbswKCH3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tx/MMc9Z; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781170400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESUhmvk6p+8dcuSBRQVBhEw9baSwhvVmor5bCpqX27w=;
	b=LbswKCH3+2wIc2c8cpnktqVUb46GmBhE8l5zaYtOl0+9o342Il9Np/usocmaWY9CV2dk9b
	QXP1d0GtzvsuH2evKZ92QBELmWODuJhrBxNR41upSLUuOuarNDM65QGW5j6t3CxlrU5npW
	/F8Y5IEWzJwmm/lJTvLErtFgGcAFigI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-3Eq4CFqHPnqjqqaTh5fGsA-1; Thu, 11 Jun 2026 05:33:19 -0400
X-MC-Unique: 3Eq4CFqHPnqjqqaTh5fGsA-1
X-Mimecast-MFC-AGG-ID: 3Eq4CFqHPnqjqqaTh5fGsA_1781170398
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490abeb7298so80557655e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781170398; x=1781775198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESUhmvk6p+8dcuSBRQVBhEw9baSwhvVmor5bCpqX27w=;
        b=tx/MMc9ZMvXvN0wFVJ2X/NrnuojMKltMwuZpA2mPTzAyTIudLFZuJEDBTivS1Dhloy
         fSl2HRp1X1NDduAsu4qtyHRkITUhpONeb/hWhgQxyTfpKlw7h2I+Tt1xEbs0cEd7OhB0
         V0Z1ULe26P3iOxZk5uxoPKLjW2nVu4ases01TX2FwkhZ8Tnx/+jcubiLTaQL02uNXUXA
         kLzPyaQmPSNhH6KAhjVyAb3BNzLO94ct/9PUY6SMrnbxaL4iND677L/+lREN3Br9m0DM
         uTwGw6swiGoJAZtulNAZkyOIftCLHrqpG3jjyZd8nzUvFUpKl21eUx6riJ27qpIaVHxr
         GByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170398; x=1781775198;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESUhmvk6p+8dcuSBRQVBhEw9baSwhvVmor5bCpqX27w=;
        b=bfZ4//LqThjAcVLpN+qx5Wm3njYRc9IKpq5LvS3SXeIB4Qlr6C1BV6RMzA3Rvlp2o6
         H/m+S1D3IcF4USZfzko82vopopyQSQs2I/2r/PSpf9yb5p1uyMOaHTgB1DP8CGk9Q3/c
         o9iHEIpXRekOOqgs4ATwEWTyAZFxhaO6JEfvpvX+3ao1kH1zuM7h1Dk9RIRTvX86EUQL
         8f+ncX1E9IFrgYpO3RlVroLFHB24jRP+JuUfuhiIrGxeC5mYhb/mvlR+eILF76Q6yST8
         hPgEh4xw1f8ETSSH+fu/qpj6fBUgVGXmEaCdPylAOLJnMmZEs2z3A/XxAO0JDVPUfP40
         U/ag==
X-Gm-Message-State: AOJu0Yyl62P/Eqg+BC7Io6a2FYxDVB/o1Z+TpZ9F11Ww85tV4P8oEX24
	yAfonaRoH97d3LIoTG52L3E3s3XqT+mPfsIFUVU2CrT1WeRHKCbT+hvuIgbFBTfKCDfIS/iKXby
	F/vb2YN1wA0x45dXDR3EjhBbZHLNvZWgjQIBIm2IGa37Ibrppp5GyKsrILQ==
X-Gm-Gg: Acq92OECmIARxO5Z+p+h4pFOEYhT7TwR+4/6952HXrx/PbGLU8SoftGhfx8wFVqyHv1
	2n8aPU5gWMdB3RmOda7ulbNE4JB0P076zEkH5TQlapaFzdeGXPoFIP1VAXJ0Q0Ud7QYifH8OEr4
	O5jRBz93bcJ7+2wFm/qKSIJb5yRAcu4qodvXkpBsahIeNzlL+oNBepRCcjYfnJ/oPtHY+AVGD0M
	VHiW2lxRKPh8oveMgrBoGaOU5dX4w4NaKaoXyEK4wZaXkdg0PKBHGgmES2shOQ0TDhRV74p+lTv
	n3RiO9nbdn16ZKdVNkh9+AigZmEAtwbKkzcmm6jpISp2T9v71HgcRTBkw0SGPdUBKpXYwgfWuGE
	9RJYZ+mA0z/j/H3mH42WoykJGuUoGaFrin1eA6jjO0OB0gEeo9RwR3S6dYV0h6m0qyQ==
X-Received: by 2002:a05:600c:6b4d:b0:490:b629:286c with SMTP id 5b1f17b1804b1-490e560b2bamr15029825e9.12.1781170398057;
        Thu, 11 Jun 2026 02:33:18 -0700 (PDT)
X-Received: by 2002:a05:600c:6b4d:b0:490:b629:286c with SMTP id 5b1f17b1804b1-490e560b2bamr15029365e9.12.1781170397450;
        Thu, 11 Jun 2026 02:33:17 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm79279082f8f.20.2026.06.11.02.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 02:33:16 -0700 (PDT)
Message-ID: <c515433a-a43c-48fa-a313-e83715646b01@redhat.com>
Date: Thu, 11 Jun 2026 11:33:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: dsa: qca8k: fix led devicename when using
 external mdio bus
To: george.moussalem@outlook.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260608-qca8k-leds-fix-v3-1-a915bb2f37ae@outlook.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260608-qca8k-leds-fix-v3-1-a915bb2f37ae@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298031-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:ansuelsmth@gmail.com,m:f.fainelli@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65FE067073E

On 6/8/26 9:22 AM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The qca8k dsa switch can use either an external or internal mdio bus.
> This depends on whether the mdio node is defined under the switch node
> itself. Upon registering the internal mdio bus, the internal_mdio_bus
> of the dsa switch is assigned to this bus. When an external mdio bus is
> used, the driver still uses the internal_mdio_bus id which is used to
> create the device names of the leds.
> This leads to the leds being prefixed with '(efault)' as the
> internal_mii_bus is null. So let's fix this by adding a null check and
> use the devicename of the external bus instead when an external bus is
> configured.
> 
> Fixes: 1e264f9d2918 ("net: dsa: qca8k: add LEDs basic support")
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
> Resending this patch as v3 with an updated commit message. There was a
> discussion on removing the notion of having an external and internal
> bus which was never followed up on, yet the issue is still there.
> Link: https://patchwork.kernel.org/project/netdevbpf/patch/20250425151309.30493-1-kabel@kernel.org/
> 
> Changed in v3:
> - Rebased on top of tree
> - Updated commit message to reflect renaming of slave_mii_bus to
>   internal_mdio_bus
> - Link to v2: https://lore.kernel.org/r/20250425-qca8k-leds-v2-1-b638fd3885ca@outlook.com
> Changes in v2:
> - Fixed c/p error from older kernel version: slave_mii_bus was renamed
>   to internal_mdio_bus
> - Link to v1: https://lore.kernel.org/r/20250425-qca8k-leds-v1-1-6316ad36ad22@outlook.com
> ---
>  drivers/net/dsa/qca/qca8k-leds.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
> index 43ac68052baf..ef496e345a4e 100644
> --- a/drivers/net/dsa/qca/qca8k-leds.c
> +++ b/drivers/net/dsa/qca/qca8k-leds.c
> @@ -429,7 +429,8 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
>  		init_data.fwnode = led;
>  		init_data.devname_mandatory = true;
>  		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d",
> -						 priv->internal_mdio_bus->id,
> +						 priv->internal_mdio_bus ?
> +						 priv->internal_mdio_bus->id : priv->bus->id,
>  						 port_num);
>  		if (!init_data.devicename) {
>  			fwnode_handle_put(led);
> 

@Andrew: are you ok with this? I *think* you may still have the same
concern WRT the previous iteration.

/P


