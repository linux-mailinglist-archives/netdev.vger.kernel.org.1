Return-Path: <netdev+bounces-252825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAp4Drdic2luvQAAu9opvQ
	(envelope-from <netdev+bounces-252825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:59:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6C375763
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B25CC303AAA3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B1C30E835;
	Fri, 23 Jan 2026 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ZwmBXZYQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B194A2DE6FB
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169559; cv=none; b=aNm0COZoFwJpLNQ1J491wrvwO/2FJsE7yYoPcTiI+zg6eWrcjZRf8+YhWm5UR3EsqBt8dES262CNwYfQKhYSj+aTTXyDoifV96O2S4d3AfSoD8BDlVNr8E7Uk8HbLWpKfNB2wUM9CYNMvcwYLq2048LP2O1t5c2VaK477ptKvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169559; c=relaxed/simple;
	bh=+4mDY+PSxuL8KtzgHSzjX7bnUBBm5qiiX5aQF7iCl/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbtLZVM+KUNmJCIdgA31moe7sQtTxg7Ye9+235vxoQkTBhxuaJJYT6uOZ0ut1BteHOZaygU3nLvgZ02j3wLqdLrKNaRhEwt+wKPGZ7zg3AwpWSbjSRSQRf1YZUgdtX5w2r1K78m9oQrM5mgIW009zxhmBiuor3n4ROi0LQr2pYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZwmBXZYQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47edffe5540so24678165e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 03:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1769169556; x=1769774356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+b6fOuz0LREagMxB0K43QFT/p53NB16sqx82YQjYv8=;
        b=ZwmBXZYQJlbuSV+JswK7Ps1Ij0sibN57Mj0ZalUcxaA02BP/Sl/EeqTN8IHI47NLlO
         dJCHTyKgXzvmKEqX6D3xrFRnmCMncO2B8PLl3HQQRvNgrRqhpPBxzr1YddfJ24Y/bLHR
         bfq7P4Oy+OrfavxpqttjPwiJATWgXFGq51w8QX4ZC2DAmxsEHVYdtvJIpzn7LTcxa64p
         XrYMgG6QrVw0WLACfBP4FeaRMMjKp+Dq+pbFeGCFCV2z7G+QFtmrkrzKL1vkwhBRRK+m
         KT5zxc75sed8dFdu7/AADV04UyrXf7JWx16OINArQBoc748jq6z0+l8V7Pq5VpeJ1zWe
         KGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169556; x=1769774356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+b6fOuz0LREagMxB0K43QFT/p53NB16sqx82YQjYv8=;
        b=Xd8Gcg05Ia6vAjbBkKwcqu9gyuTeW4vON0exWnTuX0LBu2xjJe3OU8lnEByLCkvrWf
         Xmfe+mJtdaLh+zf+zEkVoKAS2HJIpomdZQhukk68U/Fvx6CK/kW6v75YEYWx0ZRwdfwc
         C4x15IbuPX6+RvbRw5SJ4Hq8AqKnBAVS6crp33znRtg+gynKUUyjH5tUjDvI0C+OQUIM
         ax1NEFkUIMd5fb15dI/J8ovw2fm0Ve2NNNjcXnsUSeX1ABX6OLLtuHDRUQASYgiNDDNl
         tNulJ1BMHktCzmDoIrMk6ZN835C6nX7X4V6Hng0IrJBgxPf9R671GiI054ieutS2tCLc
         01Iw==
X-Gm-Message-State: AOJu0YwUTMHRo8m0PFH3Xxem8nNlHkyezhN5/6T/dy4uuVzQlr4JtUSs
	AhduuNU4Yfh+tbFNjtvAiqQ9vQw0Rrg6Et+QkuF1IHejp9ME6DSM5+EAmCahjsspwi8=
X-Gm-Gg: AZuq6aJC5nBitvtdECLJ3qG2J3rNkCNUg1lqDduqwGBrToupGw/VA61L+mu3wlYQr3I
	J13ymFpaFwbbtZ3A8YbbNrMf3t5JAC0vA4mzX5z9H8SJUEov7FiNC6Y9Li89DtayD64chHa6A4c
	u90un+7fG/sxmFS7/rc83/UxiPShfVOtvOJfZwpW0zo3JKF5g8HPVdulEt4A+FhOenMUE8OsS0B
	GdYgVcdH9nIXyQovX/+trleyd3CMubOuJcgwpcrCGwkHgme6rUFCYvvTPoLDYu1yFHASgZ6J3V2
	r/ElozKE1lweCMZwphHuQAXsUtCN/w3iwkRHdyl5bSsf6wDbobF8/cqip2BxfTDsGD7lDXt6tRO
	k29nABXHKqplP81lg19D7i8QGEoKGntC05FO4GzlTPaAr/+l+tlF7pte27qTK7gFUsZfPgAeDOp
	uU8TzF1Iyl7n8ciNcO9tCEE/KQlo0CZI2Vd2XTKka+xtM8m00euBu+CGSihfszh3X0WuF/TA==
X-Received: by 2002:a05:600d:640e:20b0:477:7991:5d1e with SMTP id 5b1f17b1804b1-4804d3c9da2mr32480535e9.25.1769169555766;
        Fri, 23 Jan 2026 03:59:15 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745e6sm6228819f8f.33.2026.01.23.03.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 03:59:15 -0800 (PST)
Message-ID: <26e1fe2c-d067-4d4d-81ad-742fd2789dcc@blackwall.org>
Date: Fri, 23 Jan 2026 13:59:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] KASAN: slab-use-after-free in bond_3ad_xor_xmit
To: Chen Zhen <chenzhen126@huawei.com>, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com
Cc: netdev@vger.kernel.org, huyizhen2@huawei.com
References: <fae17c21-4940-5605-85b2-1d5e17342358@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <fae17c21-4940-5605-85b2-1d5e17342358@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	TAGGED_FROM(0.00)[bounces-252825-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A6C375763
X-Rspamd-Action: no action

On 23/01/2026 11:41, Chen Zhen wrote:
> Hi all,
> 
> We found a UAF in bond_3ad_xor_xmit() with syzkaller test on stable 6.6:
> ==================================================================
> BUG: KASAN: slab-use-after-free in bond_3ad_xor_xmit+0x104/0x2f0 drivers/net/bonding/bond_main.c:5340
> Read of size 8 at addr ffff0000c267e000 by task syz-executor/1084
> 
> CPU: 3 PID: 1084 Comm: syz-executor Not tainted 6.6.0-72.qmp_cmd_name: qmp_capabilities, arguments: {}
> Call trace:
>   dump_backtrace+0x12c/0x220 arch/arm64/kernel/stacktrace.c:233
>   show_stack+0x34/0x50 arch/arm64/kernel/stacktrace.c:240
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x80/0x118 lib/dump_stack.c:106
>   print_address_description.constprop.0+0x84/0x3b8 mm/kasan/report.c:364
>   print_report+0xb0/0x280 mm/kasan/report.c:468
>   kasan_report+0x7c/0xc8 mm/kasan/report.c:581
>   check_region_inline mm/kasan/generic.c:181 [inline]
>   __asan_load8+0x9c/0xc0 mm/kasan/generic.c:260
>   bond_3ad_xor_xmit+0x104/0x2f0 drivers/net/bonding/bond_main.c:5340
[snip]

Hi,
I saw the problem and have prepared and tested a fix that I'll send in a minute.
In the future please reproduce these bugs with latest kernels, 6.6 is old.
I'd appreciate it if you can also test it.

Thanks,
  Nik




