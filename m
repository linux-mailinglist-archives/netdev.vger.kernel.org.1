Return-Path: <netdev+bounces-293679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMGTNu5jHWpHaAkAu9opvQ
	(envelope-from <netdev+bounces-293679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:50:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 451AB61DDF2
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629F5304E43B
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AF8399CE9;
	Mon,  1 Jun 2026 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="priaKdKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DF392823
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310444; cv=none; b=tP6QJJ31WXC1mxsoWlHa63F5YywxKhYp6G5aZ5X92vmf7D7cX2LcLW72f/4p9NyXj55mJmdjNmhnqCLSEd1lWV2HrSJRjHJ0Ixby4S2Im93gqfQdWuMl4OnjU11GIFz9vhsUQuJKW/sPcNflQUvu9Tiuhue60iYnaPFrtg/agPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310444; c=relaxed/simple;
	bh=EkCsVuOS3etedE64cU5lX0jbTdkAp04wTWAI6ZlqVKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8m7hHSokBg+a2Cffqdhu1QPD3WGBWBGPCRimVsFnDnbtEGtSWOVH/P5SsATqDP1/l2P64UF4bFzP1ZlbZaK+W0rJ+PsKw2qwMYUyMzT5yPX4NA/Oxipo+9ndXqxf5rMTo/ZKw9p5hMBvKUk4lqMogFDMfMlJWw6WRRW1GSdZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=priaKdKm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so2932975e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 03:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780310439; x=1780915239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJiKzGg+XgzIdTa55YrtzezJxfroZkkm8edW9QS1BLY=;
        b=priaKdKmslSbMiI8n5US3NE/6QDvofetu0jTV1/3oXolLwPqtnHDBoAoc4JUSnDmaS
         ctfSIGuDSlGV+zkkWjDSIIKlPbrlQ7/I26rjyonk3g40G9UEeG6isKmfLP0hKsmlkBKM
         O3Xjl3bLxJfRhq5m7p/krWUX0R5ZDw7FBNqrSmKz5wlSwV+FIyba0A18i18z2aT8Yv8R
         CnKF2p89XUbw7UZKjG9T3u/ShaDPc/WFMRxAMcKapdReEkWfhAENNxn1i4MpK3l3l6cX
         ihBRfq08V9T7IVCVtvNP/CtxFy/x5OYr7O4SUvKRZAmSb3YBWt3N+6tjOjOS/LTOM7bc
         yqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780310439; x=1780915239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJiKzGg+XgzIdTa55YrtzezJxfroZkkm8edW9QS1BLY=;
        b=ZI+SamraJ4mh0Nyn1yecHEpoogILqbaxSdU9w5NpOkkOpfRG961nP23QOL8mpW+u54
         qWMvNhS5wl1IU5B+oMVLsrdAhXifzuJMnrLjhXGNgAvI+vHY7CH1oN9PrlAKfd4IuwwQ
         w4fTGJeeOTjakCmwBg5uLW15gTstUcaq7uOvwLOVVgm8t22x59qMtruyYZxJzrSNr7PG
         URYR5fvFbLdrSEGNodJoG4AfDRik5oF7MHT6lvy+LVpfhaiONrBux3lgtSeKu0sDXeRV
         vRD9ieP4LJXTHqJmRviFes3HEB34bFP7Ln8DUHS1uDhJuX8SzdkQfSUiQKyl6ju3FvRc
         0zgA==
X-Forwarded-Encrypted: i=1; AFNElJ+2VTmicZCEiLYFjitTHYSgw1AbL2b1aImnLvYv5AljD2rYVMK3IxeEVWqm48bXCUD1N05f5+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoKRrqesJZ+6S1mhqfPb2zy5sniWi0hBbXp4PBofWK6HnBue6
	6ynkS1ISFSZSiDjQwyknD4PAe3G+EFUNzUHMYlYJuRRCpprOwIPsJI7b
X-Gm-Gg: Acq92OFD4DCWjy8vo29gD5BZ4rjO76qJw3Il/9mIhwVxwwN1vMn2jWeIC4gcK9HxX+J
	Z25f3QocrnB9zAhBwy02hxRrVv4qh6hIPGcwK6MlOvF7LBm+1EB5KHO2B3SuluBHrIl0KVj68P9
	sr19NGBceSWW8sh+jeG5fhY4+kD4Euw7cN8e3/NubUCkfy8wUmq3iHrKukvfCKeHHMQfyxdc+9C
	FDKPIfwqq0l/y0KycQB6HVrtbcVg7mQNEPiMnw8CZTyotCDk4lYKR2a8q4JNXxCOQ+RxAWBxIZ+
	40T9xFz/JycgZLuMWz8bC20Mc59kWEXfs6z79T9VxuNc9hksVhFZm8y142MyNEGLyYu1ydrOpgX
	EoKpQhQtU819Ywf3JwYN1guxXuBV/OhRMJXVS/cgBU8pE425J0Lrq8w+x2autx7ZSIZf4Dk+9Dx
	7BMkx+mC4pG7AhTW7Hslowaj9CvK3aUhvKlgvscYYyhsdBS+I23+cDcD3m1P6ZW90bdDH8ynNv0
	3aNrffffXcyBY5T+pJW
X-Received: by 2002:a05:600c:35d1:b0:490:af90:f9c2 with SMTP id 5b1f17b1804b1-490af90f9e3mr2266775e9.12.1780310438751;
        Mon, 01 Jun 2026 03:40:38 -0700 (PDT)
Received: from [10.1.0.164] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68980csm265739915e9.1.2026.06.01.03.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 03:40:38 -0700 (PDT)
Message-ID: <9c28fb8e-da52-40b3-8dd3-c0bd06ac3434@gmail.com>
Date: Mon, 1 Jun 2026 12:40:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/3] net: dsa: microchip: implement KSZ87xx
 Module 3 low-loss cable errata
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha
 <Tristram.Ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
 <20260524-ksz87xx_errata_low_loss_connections-v7-1-1cd49cfa24f0@exotec.com>
 <fbb60fec5bbeb5fb83e215adbc2dcbb3@tipi-net.de>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <fbb60fec5bbeb5fb83e215adbc2dcbb3@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	TAGGED_FROM(0.00)[bounces-293679-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 451AB61DDF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Nicolai,

Thanks again for the detailed testing and feedback.

On 5/28/26 13:43, Nicolai Buchwitz wrote:
> 
> The cached state lives on struct ksz_device, but ksz8_r_phy() is
> invoked per port. Setting the preset on one port is reported back as
> active on the others:
> 
>    phytool write swp1/1/0x1a 1
>    phytool read  swp1/2/0x1a -> 0x0001
>    phytool read  swp1/3/0x1a -> 0x0001
> 
> The commit message already notes that the erratum applies switch-wide.
> So writes from non-primary ports could either be rejected or at least 
> produce
> a dev_info_once() so userspace can see the setting is shared?
> 

I will add a dev_info_once() to inform userspace that the configuration 
is shared across all ports.
> 
> dev->eq_init starts at zero from the kzalloc, but the header added by
> this patch defines KSZ87XX_DSP_EQ_INIT_FACTORY = 0x0F as the hardware
> default. After a fresh boot on my setup (no writes), the read returns 0:
> 
>    phytool read swp1/1/0x1c -> 0x0000
> 
> Should probe set dev->eq_init = KSZ87XX_DSP_EQ_INIT_FACTORY (and
> dev->lpf_bw = KSZ87XX_PHY_LPF_90MHZ), or read the indirect registers
> once on probe, so the cache reflects what the hardware actually holds?
>
Good point, I will fix this by setting dev->eq_init = 
KSZ87XX_DSP_EQ_INIT_FACTORY and dev->lpf_bw = KSZ87XX_PHY_LPF_90MHZ 
during probe.

Thanks,
Fidelio



