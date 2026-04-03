Return-Path: <netdev+bounces-274974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JioMh6Mz2mmxAYAu9opvQ
	(envelope-from <netdev+bounces-274974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:45:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D40C2392F1E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FE71301B7AE
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A00391510;
	Fri,  3 Apr 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvmx2sIt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD73909B7
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209411; cv=none; b=YO/k13oocEsnDJUjZDDjrbcpsf2PoX2ATNo0NohN4bj/vuNTzZkJ+Hjf4r69gnvMzlj8KVFgXymKe6nB+qRmTwhE9M5zwXR6FX3icSekZRFnVbP4qxsIkwZOxx5vPVylOTsWvUHfrg2t4P9GdR5c/the6YMelqSkRBnl6VyBTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209411; c=relaxed/simple;
	bh=4mcXj8n21nn8IOpehKLpsbJ3K8jdzjXslOfmGaZD28U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6gOF375arZ4ZC6SnSxkm/iyVol6XUSij3HWjDXCG+sum/c/2FFRw5CIZn4zZFFzSks/uOPk5UpmQAWIpxXzaWejXSjZZ2BFhwsPoa1ZT4yIlE1Xn4oQuqgKgZ5kPr/Wz8LjnHdpU6sj7QF6wg2daDXIzLmFtNTfddm9X+61GoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvmx2sIt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4887eca00c4so11711215e9.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775209406; x=1775814206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5InlHETi+SIWgmcBrnKanh/RI7eCvH1urjB/VkUdx5Y=;
        b=lvmx2sItbCzf5zq/d8iaEK0u9Swmr98ak1Ydzhz/PQ9DuTJIh78H7O7RnKWS0wLEMy
         YvwaGO+5eJxXKElKCEGCgOl9udEzryi2iEgnIyYzF8Zr956hKc7Dk0wNcVjMsSfc60Iy
         xfwp/TGA3YTidaviVmGNItSJGhzGUGmuq0jkYpwSkpmdxplU+N/Tzys7m2700E3LYm2g
         cwMuV97gvrReUJkk36PzMrh6wixcqBF68mlkbZuCyLxK0f9kq6a3PeNwvBvwAsqie1uC
         +ivyPD1f4uYyqNdC6pnr+kytbv9sLsqouiUOX7Gk0Hnn4MmQ7lSV76jt5uzNYODNVoyr
         ROtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209406; x=1775814206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5InlHETi+SIWgmcBrnKanh/RI7eCvH1urjB/VkUdx5Y=;
        b=rS8xzil7PVegl3w/SO6iGjS6JL3PRyCZzkSc482FjvPSdy+qC9jgbsc08e25o83PbG
         sZ+4VPiILDVCpyDXur5pDgGzzrw19PcSIowp/YY/q+Usq8Yx65/MQV22o26e5YoBNtHb
         R8Sd7cwqbNF7qHNhkXB7YNT2My3icj2CRN/k2LaXIsCQt8KRAOZQuEsr/mnSDXybrTQf
         XievQuWLB0DJf06ylaCeAagr+wZ+8N9WDPrjKnya+Hz9RTXISv7Rr1Ui9rjZlOtHWsc6
         Vk33+GFZIzW7CNq2Q/LFLhtsafhs7B0nD4JIA0Zpmk+ViJKxoMMWPmfW4gCVRjfeETkk
         Ifvw==
X-Forwarded-Encrypted: i=1; AJvYcCXHKn9vTGLTo1a4bBuy3sDzAx9ha0zVigD+79MxWn3pR6HXezx60yKHn7tVpWbUD2pCDumCIbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwLlZeDzOdgC5nbMtz0lIBkqNgW2yy/6tN9yBSpLP6v8c0l9H
	jrgZP7X1G7ItGvHYXMgwHUXQV0vA82kp/buxqVR/GQji+K71GN4rW5fn
X-Gm-Gg: ATEYQzwfEajE3BGyfmm+XvPVPqR2Ux4Ox2ROhGZr8oyT7lv/dODlcpFFRMhmAkIyTut
	G00A/ndqcnLWHrIrvkV5RRKC7DODpKV/mgTaDe+a8/25NyW2N3Vf0nT/xRE/5pbC1A1Hvy0uhqb
	nDAx8A8hhGrWssb55s4q5e3l6UhqJh+tMB8GA3WKR16FfkhMu7f3Wq9//71t6fK5LDB3ggOXoBm
	MBZa76FW1VRH+ZmFXxUaLoAubwoIN/B+4jdAJovxNfKTDQQF3YGWbSOblwrg/VSfwhToEySPxYq
	wOxByohyzbcVvWpabJL0CdqC4VmqDrJ9mzULQO9ROt6QzscJM3OjsJ0dIsq6vkZDdcoBvtnpmlo
	U4IyYShEhZ8OSQJKc6jYR95dKNV+9y0EVOtcaOdJFyBSCy3RCm4LPxGkXfJBoNZ1F+bkVXHlH+J
	DGZGK02ZYD1x+rRpsR3iF4uOU3vd0OFiW1SOheRlL7ZoqfJf2xJOnYia8y8eU24XKhGGmvlukTP
	ls2PaJwFQ==
X-Received: by 2002:a05:600c:4753:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-4889976eb60mr34158545e9.13.1775209406305;
        Fri, 03 Apr 2026 02:43:26 -0700 (PDT)
Received: from [10.1.4.108] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897b8176fsm27664325e9.0.2026.04.03.02.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 02:43:26 -0700 (PDT)
Message-ID: <fe14415a-52fa-42cc-9e4c-e3876588d513@gmail.com>
Date: Fri, 3 Apr 2026 11:43:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
 <ab6a06c1-2d7d-4032-8d38-063470cd45c0@lunn.ch>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <ab6a06c1-2d7d-4032-8d38-063470cd45c0@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274974-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,vger.kernel.org,exotec.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D40C2392F1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 13:18, Andrew Lunn wrote:
>> +	mutex_lock(&dev->alu_mutex);
>> +
>> +	ret = ksz_write8(dev, regs[REG_IND_CTRL_0], 0xA0);
>> +
>> +	if (!ret)
>> +		ret = ksz_write8(dev, 0x6F, indir_reg);
>> +
>> +	if (!ret)
>> +		ret = ksz_write8(dev, regs[REG_IND_BYTE], indir_val);
>> +
>> +	mutex_unlock(&dev->alu_mutex);
> 
> What address space are these registers in? Normally workarounds for a
> PHY would be in the PHY driver. But that assumes the registers are
> accessible from the PHY driver.
> 
> 	   Andrew

Hi Andrew,
These registers belong to the KSZ87xx switch address space, accessed 
through the switch’s indirect access mechanism. In particular, the 
offsets used here correspond to entries within the TABLE_LINK_MD_V 
indirect table of the KSZ8-family switches.

In the next revision I will switch to using ksz8_ind_write8(), and I 
will also replace the remaining magic values with proper register macros.

Best regards,
Fidelio

