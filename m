Return-Path: <netdev+bounces-264458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A8nHCmgqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:24:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEF521474A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBDC8303CD95
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9773C3BE9;
	Thu,  5 Mar 2026 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpPcNHh9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151DA39E6E8
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723416; cv=none; b=V5SqR3SrHGhvKU5EaRhU0IKhm/iSxQkU69lyvW4Ep0loWBBLA+ftxicU5Z3EyoLeOxy+ShRNeWqOmTt2IkK8QgW/tWZYupRVf5JJjAuOxe8NKsJPA1+GtrLBjTwAqPesopLiFoHxyeCp3tru/+JP+iqIZwQQZGCYEZ3c9UjNHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723416; c=relaxed/simple;
	bh=6BXLF5zvkJ1gM1GLpqo86t2wD6wLUEfsst7/vXdcQ/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP793l8qbOVU8ZzS2cNqIygCukcl1Ung0bjKbDmYQTadVerk0nZGf5gonpVynCnNkEK89+5T0Lq1U8mHaV5kjbrN/T+9tY5tGeyAvTRi8NAZya6pnfM1yPfFNDymreJHNyg7QK0GDsX4hs+n/MVfvMd8pAHa0XsVdbbwWkcNIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpPcNHh9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806b88d8c9so8449295e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 07:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772723412; x=1773328212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6BXLF5zvkJ1gM1GLpqo86t2wD6wLUEfsst7/vXdcQ/U=;
        b=SpPcNHh98XaWSEos+fhT6UIhJ+doYwVIMpFlAOyUPtsMuJtKhD+P/UwpVmjzRFIW/D
         RRmqSvuS4zf7fOnD0QRUBKhJjYhaIPKJBvL9gI+Fgwk2NFXLtKZq18HgPJLgPgUH8RAp
         w788HtafRToO8GNj7hMEBvNxfuGoidDJGugqjD5HaP2vm/vFoZkfARqmEnctr2i1dWtv
         +jNzYatNPOo/8y2ModpnH2k04HuhYOuTxJxvsbKRU9BOGLyu4EiIa4kFCKr0L8Nw7YvF
         H+B3/JvWvmdF0kpnBNG8blXEwOLZB5hNC1KD5WNQSi/gu6A0m4gUin6PysXz8+9zX7zZ
         GUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772723412; x=1773328212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BXLF5zvkJ1gM1GLpqo86t2wD6wLUEfsst7/vXdcQ/U=;
        b=r5BDSptY0j5PbobjhE1mrWCVzogFbrMGS/G0zCdtIdGH1K+dSWFXh6Tk5yNd0mrGMa
         DqJa9S1zyNMy8dJyaH1RlfiCZfOo5Pu/Vf9CnTOpnimPwP309YgRUeO7NadwiqVGFVbo
         YpPEVaVioTWYpHqsABj5ZKocq681YH+RZyZC8Ra0s3i8lRuhn9/7slmYmpneArigb+mN
         WDFcjXRTE2C6/znbn5dM/8K2KaCceKFz/uIllLSVH4jqLEU5DsXzCHoz8xvxDYlOWVx8
         ENSAQiFuGmjEU5QQ5t4WoJpK+KhFMlk0QA48P7hzrJZIfXMl49NbQqladp6Cz9bKKwlm
         Cvwg==
X-Forwarded-Encrypted: i=1; AJvYcCVPF7lEGukbzKI+SFDB/Q4kkEeEH8WKCoquMXow0DspMmXR4MXGRY+H6DCcJqKERv0F5XlYGX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV12Rj2dm+P946EdrOzidRwFEnG15cHa0DUihIC5+ybjANS4B2
	gPpDli8ezW5654NdC9PaUiDZYHj8clJMYti230HAcWDObpN2+S1ZJOl4
X-Gm-Gg: ATEYQzyhNDWsgE233HH1QSlUefGcgw3/KOsNQjYaF9Vetmims18VkeDPzqYco4Y2Cgc
	Am9LA1J6uMeMbQctILVY0qNlYh0s04rYj9zCFbsDiEogkT8KXkXzt3CJUyzGk+TipCGVmmcqEiV
	5Xaw1zSDQUHTsSOLGvqV7sTIcvzFts3aMZZ4e/Up4hh9DhAJ0khpLLaMovflfnLGOiAVZNlgjU7
	/ToYlx1jhPF8dFiCRWdrmX+AZ2TBTZnlW5GDETlj3lO/v38XDY3R40DgoEcpKGE8MOKDn11j3wF
	DO0gtqg2AK9PchwqNdSUdVFlt/HjVHo5+C5Jkny/sC5plKmo+AeQ5v8zN3lqoUagPf66B5pjaru
	cH/hlTIuEhtyO9K5sI5RTcs6qre3m9qLfM3WzRSeqaMJT4wA95uFXy22j/oLvxHl0klLupNJVAP
	ydSCo/lY2gz84dCfQ=
X-Received: by 2002:a05:600c:8b81:b0:477:7b16:5f97 with SMTP id 5b1f17b1804b1-485197d6c03mr58457565e9.0.1772723412176;
        Thu, 05 Mar 2026 07:10:12 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:16aa:c9ad:4288:9dcc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a895553sm99833505e9.1.2026.03.05.07.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 07:10:11 -0800 (PST)
Date: Thu, 5 Mar 2026 17:10:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
Message-ID: <20260305151008.c2gsaxwyhvtcs5ci@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-4-bff8ca1396f5@microchip.com>
 <aahWu2-3YT92vMuC@shell.armlinux.org.uk>
 <32b7267f84b60a4632eb643fd0b999d03c630a1d.camel@microchip.com>
 <052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
X-Rspamd-Queue-Id: 5CEF521474A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264458-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 03:58:16PM +0100, Andrew Lunn wrote:
> So, the best thing to do is hard code the delays in the MAC to 0, and
> pass phy-mode to the PHY.

To extend that line of reasoning one step further. If somebody does end
up needing to configure delays in the MAC and observes that phy-mode is
acted upon only by the PHY layer, and that irrespective of phy-mode the
MAC delays are always 0, then they will turn to the rx-internal-delay-ps
and tx-internal-delay-ps properties added to the MAC OF node. Using
these has the benefit that it does not collide with the phy-mode meaning
in any way, so is not a compatibility problem.

> Now, this is a switch, so there is one complexity. Some switches make
> use of an RGMII port to connect to the host. You then have the host
> RGMII MAC connected to the switch RGMII MAC. Delays have to be added
> somewhere. Since the switch MAC is playing the role of the PHY, in the
> eyes of the host, we allow such a port to add delays.

Well, since rx-internal-delay-ps and tx-internal-delay-ps in the MAC OF
node would handle that case as well, there isn't any need really to
complicate the implementation with any custom phy-mode interpretation
there either. Introducing the concept of a "PHY role" for RGMII delays
in CPU ports is rather unnecessary given the tools we have today.

