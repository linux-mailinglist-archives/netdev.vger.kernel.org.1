Return-Path: <netdev+bounces-262126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKbWNqXuomny8AQAu9opvQ
	(envelope-from <netdev+bounces-262126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:33:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE021C3443
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88F163067750
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71502BE043;
	Sat, 28 Feb 2026 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nhs8jmK/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928FA1EE033
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772285527; cv=none; b=NFcxBmRaaY+pqod7ZJXjJ/pdeh09qEUPMPd/ceavoFxfHNLMJj7+yFTq230PL9Bm/M2x5GqUZAJq8uPK2QxIIhbuvHZ8vTLajgzwFxYh5XqhWnF6II+Ze5h3rWM2IzBMexwB6o0cfB1Y0brl8pMeo543ZaNnSgTRsRSLlJodIXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772285527; c=relaxed/simple;
	bh=PhHuUu9iuNN6f0u4NGXuq592Wlo743s7MLGebYKQeGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBV+mJIj2keHnrG4qXav/dY2VNu1zAm9qe/luiL8vWW8P6CG5Sp0BVYtWjqGi1bep3LzdEU+u187AnmiWagGqVGqwp8M8A4+A3D27P48vY6sWGKHB97cBJewtaWEcq7nryntKZeAjpiaY/rrOgQSRGW/XxhPav6d2ARPtvvrdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nhs8jmK/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48069a48629so32138615e9.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 05:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772285524; x=1772890324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JI7TLLSl99LPgXU49aZzYXGzm70nyMbapJzO62R2hbw=;
        b=nhs8jmK/cWYLNhVChLZ0OoGe0sb5P7VT8UR6+dRzqkMUM4L7Izrzj+lp79JbnsSEhJ
         6OfeBvxPbOlB9T60bnNgE+4mEYMdxPcPAYmiyujyk3XEsiJVHIiW+mbA11ywAiXL8jhw
         h7SVf7QAA8wyiY5hpTuQRnLvVFBqzUaaP3U41mpO0SlkDqBEyJme2WUeKuCEb7dGlOSL
         esVFG/8ymv8Qjb/3U4LrhS6MoIzhNfpqSe0M/h45NtNWhoyFqTO0Vn30CI2thVWzGr12
         T05lN50XCh+TU9ERPA8H1xFSIHlydAbMczvZ7D88RNfsC9RMKZcSJiiQh8Ji/MouzMoB
         M4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772285524; x=1772890324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JI7TLLSl99LPgXU49aZzYXGzm70nyMbapJzO62R2hbw=;
        b=Vx2g/ZeU1LsW139HIArhscSQ1fMY/eJ5L/mpEJ53b/0Bpe1bz51nPc9TMouAnWI0c8
         u01Bi9WQI8Vmrr+FppvE4fVQoIjDA54Iv9NznKxKQ+FIqtkaQL1UVGj7iS8hyUg0R8RT
         MDU0xqZAJZbd3UEF0ldzAlvcQXhZjMCo17sAV10EOM2NzX9I+NG1wMzeTIfte5/P2gZT
         nxkaeAWDJSgf9a8kPNlLi+xSd3YnHafY6+McEKP2eRNiYEgfMqxpi11vqgxNenn71TvS
         WAwnB8pR01axC+8JkUIQkuW+mdw+3tU8SSBMfXzRg6iYmOw8gUqyh5wJgSxr1RqgZZcl
         sisg==
X-Forwarded-Encrypted: i=1; AJvYcCUyKQ74Q+3SDOfcFU48YcoSKl3GwhfB0SNzBqqIHcs8SV6YYpr8Oyl9HxxgLc2TMs64fEumEfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcXNedPLzzLZbSdx54B5oSnOwIT8JBNFBEPlyGw44BxS7+lqp
	GFsu4IW/PTH8HPhYdcWOEYD6jJPMII4TeOsCq2poC0Qxo1V8CFf9Oc1Wm20vRgpjFWI=
X-Gm-Gg: ATEYQzwkSm69YFbAyO1SKLp6Q928bPXkBOHMOdFXbyecn1XSBBZS94CKFxAONuAAUsA
	aWDgNX24zoud6MxPX/LlL9aATXqw5JbC2Sv+aMTZrvNIoStDJMiK/BmaibD3NrVV45WQh2DtOoB
	kPcUdTH99c+bjlTJ+54Nfu3aCaQRLRgnbNfTR5bEalwjeKMKwPlYqdY0ADk7GD7b9bU6jYQkHl0
	Bm44WQUCOF1sUyj+rtGDC1SkDJkzIx8pmB++5ofMY3KdptTXB47xHk5HNDnA+BdqjOEJvUcIEMK
	wZqB028Y1JGRIqz7rNthCgCU9CjEOLB0g+S/FGeMNrx9717dmiQMw85QvJAM4lOOgEOeOUG2gN6
	Rj96u9xyyiODpekJwBOgrBwIUsgqvzLB0qX7HNW00iwdecMuiyQSK95An0YC+zN8g6OFiFq/Mzs
	RS8ZaigrbfxsPzYa+qQx1iex2d6nBNmGFKpmfkCzBd
X-Received: by 2002:a05:600c:4592:b0:480:6999:27ec with SMTP id 5b1f17b1804b1-483c9bc03b1mr112029205e9.13.1772285523446;
        Sat, 28 Feb 2026 05:32:03 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9566sm129482745e9.3.2026.02.28.05.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 05:32:02 -0800 (PST)
Message-ID: <905b0bd8-dce4-4921-b7f2-4d694a02533f@tuxon.dev>
Date: Sat, 28 Feb 2026 15:32:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] net: cadence: macb: add ethtool EEE
 support
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
 theo.lebrun@bootlin.com, phil@raspberrypi.com
References: <20260227150610.242215-1-nb@tipi-net.de>
 <20260227150610.242215-4-nb@tipi-net.de>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260227150610.242215-4-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262126-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxon.dev:mid,tuxon.dev:dkim,tuxon.dev:email,tipi-net.de:email,bootlin.com:email]
X-Rspamd-Queue-Id: 5BE021C3443
X-Rspamd-Action: no action



On 2/27/26 17:06, Nicolai Buchwitz wrote:
> Implement get_eee and set_eee ethtool ops for GEM as simple passthroughs
> to phylink_ethtool_get_eee() and phylink_ethtool_set_eee().
> 
> No MACB_CAPS_EEE guard is needed: phylink returns -EOPNOTSUPP from both
> ops when mac_supports_eee is false, which is the case when
> lpi_capabilities and lpi_interfaces are not populated. Those fields are
> only set when MACB_CAPS_EEE is present (previous patch), so phylink
> already handles the unsupported case correctly.
> 
> Reviewed-by: Théo Lebrun<theo.lebrun@bootlin.com>
> Signed-off-by: Nicolai Buchwitz<nb@tipi-net.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>


