Return-Path: <netdev+bounces-262125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNxHLFHuomny8AQAu9opvQ
	(envelope-from <netdev+bounces-262125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:32:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7811C33F0
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46A8C3001FFE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347C1276058;
	Sat, 28 Feb 2026 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aABqlzd+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53923EA87
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772285509; cv=none; b=m+hcgEA6FvCLJsNJaej+HmOAD2c/thG6DA/T9mRcg0TeOYXFOhlYEO+AQHvhnKdLj31g+SthXjAhF8amRevNROk3sqVKJyqG+66MvJ+Zy4erIQjycjW/3+UXocyBCtNmbypoCl5zoElM/vhAENrqCTmnQaQpnkx0xzeXOAoPw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772285509; c=relaxed/simple;
	bh=o404Ap8SK2PvrrxkuYPH0FIOL2uAreZXZ/8/yqtVAkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+Dh7IxVHQFUgZ7jkQmQQxKio4JFpEcumLaLEMzQar5oQlS7Oxs1JXm8MNQq5s/G3At3Q41SvkM2mVHOOqR5pCVAy6DB0dsDKDvRlSgAoC/HjXGY6ZnWthl8HiaH1k7L256lGmyIRfF1HA7Em+pkn/wbVgUvV0RL07JBKbc2QrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aABqlzd+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4837907f535so25833805e9.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 05:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772285506; x=1772890306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qa9C1LuUaaAGSc/FHWNbCzlyHlSHOd85hS9w2EwPXbY=;
        b=aABqlzd+cI7UY4tCpFg2rQZVIlOHAGfLpK2RT4hdJeJo/hPLgc/5KN+JvDAJ7lcXjO
         987w2eDTeXbNJEJpiqDENJWeVSj2lwxmN5knMsSyiWIyjLM+JV8zWeJNVqJ38eiIK6l6
         wRk+ykcrLARzxMU6O4+jpgCzv7nmpPyrEjxwN0QKLPhyEOxD7Yz3JvfNhx76TPJm7u18
         HHN2KuYuJDf7DRiVtjdZfrstRIYNuGB1OXj5RABtM+M2/wBgh0Ue0seXKa1LCYbQzyrY
         V7sgzrBUEJuxq727wDvzP9jn3hAgtcZk8pbPx7/YvdGQT8CNuh5ODLZEVYbL1EdlxjUI
         SCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772285506; x=1772890306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qa9C1LuUaaAGSc/FHWNbCzlyHlSHOd85hS9w2EwPXbY=;
        b=WC3U1M5gFgz1pD0pfgKuwoE76n9rTYKsebzxS04XIB9rQssvdXyTDttnUSdoO8qVDW
         M+cgbxW/geFAa5R0UEFPUIKjslh6NkYBcK2QX0wtE9Kq/D/Cnb3zmP+VfEBLYMdKsWml
         nn3V4fjMU+5lyxY+WbTLnvv4FR+rdurVNhiRYCDrmEEzn9y/EujyfvM5cl2X5ec9hqp0
         XnBVg0hkF3OR21w9MmpAEtGGW6gzzSnqioxN+wFz31Hg93sZQE7a9OxxozCEry6m5wox
         5mMVlpi9p6W6bSiadWpmT+uElcfUs9hJm0zRVXTASbpIHDc3HE2KOPxzJ8GBZwDdM0jH
         XcGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1MQWWb5j4pTk675/Xu8Cj0ZaDl80Mn1ZsDcubF1ZqOvp6yB7Yn3z63vjulhFA7g9F+ivXY0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEeAmTy2P+lQUOzj9sb3ydQr3OdcAVphZAWQjhjVd+EKzuvFqZ
	XD0jwhh0w+VdcC9jcudh8kTZetk3GznOMylCzBaNYGoA/dZUg0P14J3nBeW0XDVtaJTVnIsdyzx
	7R4x7
X-Gm-Gg: ATEYQzycH1dAZbbSm1RfYXQWB/wP0CQrsY0oThBGSrBG+nTtV5ajeTH2mEcQiILj29k
	brBKnCMd/lg1PVXO7BLr3sV3MsXP8LQ64EdDgBm1Nuuntp/0lRxEaYq+b7VO2FcBUaJqRt4kGvW
	Z3ONkixfVJI/+OizszmH6eVwLfKUkQlt+9ltaQh4BV/UvSu+wZYF2MBQOIJmlsXqbTN/9W09sv7
	tJ9kfu54Kj6n/j34a0t9w0GmwuTI0zhb1Fl1NPxkcqRV2J59wpA6UX0o/NZnQGJo/M+ooIOMetL
	S5FeWZe9cthKDqKVXapJcQR7WeBFTwNGXPh+DNYEOGCc13wGD34GDWmHxmBWugFFkAGlhI2LdnV
	9G0M/1lQH/y67nMPOAjkKw9rlNZKd2Bc1enKUhdpKCtYYeK7Qv9dH4K1jjfzCMifi1invLzpYqI
	1NtCwp8sK4mrQd5PvPlqyInBaJ4PbNwA==
X-Received: by 2002:a05:600c:818e:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-483c9ba3aadmr110108825e9.15.1772285506162;
        Sat, 28 Feb 2026 05:31:46 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb318fsm132650645e9.6.2026.02.28.05.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 05:31:45 -0800 (PST)
Message-ID: <51c23a3f-08e8-40d4-a015-6501344b75f5@tuxon.dev>
Date: Sat, 28 Feb 2026 15:31:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/5] net: cadence: macb: enable EEE for
 Raspberry Pi RP1
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
 theo.lebrun@bootlin.com, phil@raspberrypi.com
References: <20260227150610.242215-1-nb@tipi-net.de>
 <20260227150610.242215-5-nb@tipi-net.de>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260227150610.242215-5-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262125-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email,tuxon.dev:mid,tuxon.dev:dkim,tuxon.dev:email]
X-Rspamd-Queue-Id: 4B7811C33F0
X-Rspamd-Action: no action



On 2/27/26 17:06, Nicolai Buchwitz wrote:
> Set MACB_CAPS_EEE for the Raspberry Pi 5 RP1 southbridge
> (Cadence GEM_GXL rev 0x00070109 paired with BCM54213PE PHY).
> 
> EEE has been verified on RP1 hardware: the LPI counter registers
> at 0x270-0x27c return valid data, the TXLPIEN bit in NCR (bit 19)
> controls LPI transmission correctly, and ethtool --show-eee reports
> the negotiated state after link-up.
> 
> Other GEM variants that share the same LPI register layout (SAMA5D2,
> SAME70, PIC32CZ) can be enabled by adding MACB_CAPS_EEE to their
> respective config entries once tested.
> 
> Reviewed-by: Théo Lebrun<theo.lebrun@bootlin.com>
> Signed-off-by: Nicolai Buchwitz<nb@tipi-net.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

