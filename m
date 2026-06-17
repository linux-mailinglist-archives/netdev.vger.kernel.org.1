Return-Path: <netdev+bounces-300081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f4W3GERhMmoCzQUAu9opvQ
	(envelope-from <netdev+bounces-300081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:56:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A23697B44
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:56:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=M0nS8XNR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300081-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300081-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 731513066187
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F8738C41B;
	Wed, 17 Jun 2026 08:55:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A96311C1B
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 08:55:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686509; cv=none; b=GyHH7EEA31fNQFWdw9CbdCtGRyp98mD3ENc1BaKELpbIR3xWPuatnYUflOAjTeUuR2OKo4L4aIvY/BZL+BNZXHkIPXDCGW5+GtIakuzqymIncBuX1z41VIWPU2K6wuf+96ZD7L6jNPplm5g1tB2qQBgntzoCF9m4m7HpacGwCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686509; c=relaxed/simple;
	bh=VYojiFvkgd7DZg48Kjc6saIaOOo+1LnPh+V9F6p7Lb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WipBN6UaP71b6XvhJauIjiuqT08dbqu4c+EbmI2yvzv1UjAEmuXKxbdnx2u1zSpVoy5BVtbR6YFje2i0F1V9RvGz+Zui86BrTFf9zBMAhRHbteGhWL8mUEHTYc0P8y9YibTOh43Eg2zuu6WCIoKaOBx/l8ZzLxxwHqvNjJvvkew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0nS8XNR; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8589498839so2370495a12.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781686507; x=1782291307; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jU2lF5D8WsZ49yodI+DbJaHAzFovQXJU1C8q9EyojGw=;
        b=M0nS8XNRYmxyYDBSpAlZpwkoZQQM3xmjZpxjagFKCXf05PuUEGY4g9uC3YSO6r8TIv
         Rs4ydm62hAcMm9OzqW15PPX8NSjlfj/5Qygj8EFS/QMnL1bMXZWO5ncIHUQ80U0++R2M
         fYrVAYuzaHgjx7uAiihHvCCtBXwsbEE9bT3s4gfXWW8dWfd9nRrP2w5FVThHGu5qdXoh
         M5WqtnglYzOv72T8UYrH/ASioWzj1jh9isj3Bftq0azAQQ1XahxRuSTI6bNWUOv7Jc+B
         HIwuxsOvFkMf1ugMaHaBsVV4mrDoBRXtZK6TKeMDYKPlAuSIAXpA/01SZd1mpWqFLOkL
         ufSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781686507; x=1782291307;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jU2lF5D8WsZ49yodI+DbJaHAzFovQXJU1C8q9EyojGw=;
        b=buq9VbsiqkibwujH8Qjz/K4gttIfWCRr2PvvHCW9S7APZN1Ym4D9/mBr1oqjRH2HZ3
         SzLcp2CIWDAay/PVU7uvWAPZjdpHVQMgdc65xNKLJ9nH6QedenJ8ppg97c2c5F/zFXKN
         n3kh51zH7hE4Bun2jm9PPBP6btfJ3eNPI2m+UoaXLlWamaaab42+sADbeChcnqzqJOsH
         NsXDG6j5l9gs3mugflT/c7DBoZeCp44X9zXMMNgBsl0v6l0i9ZuXQKzxcBPv3iOA28Gh
         Neb39ueQwN7HDqcxenJq6B+3EGKtcNW4SJVta0iNRdcJMha/hHCr+IMoMavzObOqHUHz
         Q1HQ==
X-Gm-Message-State: AOJu0Yx+fqS7/qOnP3fj0ZFqboEmcDF89+eUiWCLrBJd2d0cuZ819asA
	QyuqS+kSzjQDZEAg4FAGypgTzdIvWXRzDAcWbmR5/TMStoC5YVTkNgrcQT32MGag+48HfQ==
X-Gm-Gg: AfdE7cnkm7m8SMz2rjnf46mX+DR6qBGNTW7YRpkd+1T9R/BTTziEuNbZ6F43auQIZhg
	xh2Nf1sURIp2DIMW0dj5wJ7DA5o6Z2r5uO9UYkMm7zJqg2MDZU+GqSZk3hmShZtedBl3bh+oZuR
	KesqSt6GoVmCxh+VPkZoU3mUoyvZIxrlkwU+Zfd00D6MYSZKX4pdvRcH5x/EP5D1xoTyxbFO6I6
	f0GmZUTAqlaGWYcrFljzokPBJwNyFBaa+vUaA5d8te4igCvICqBZlVyDivxHLJ1bR1/FxtJCby1
	vKAYPWk5axF/ZqJsmk8eCafTOdReeiQq93gx4xYTZYeX+vgxmOr6OXRZdcBg9XEyCGvuW+I5EIU
	jIM7z3W/0PrXkRFYG1ow5mDaEJUwpA3Ns6zrMM/4xkX6PnDedtkSVGpwvmoh0/eyjKVp8Pfosx0
	k4OgWHaOF9iPIo9DsO
X-Received: by 2002:a17:902:f64d:b0:2ae:450c:951e with SMTP id d9443c01a7336-2c6bc0e9707mr27907285ad.17.1781686507025;
        Wed, 17 Jun 2026 01:55:07 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6be262b93sm15031735ad.68.2026.06.17.01.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:55:06 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: lorenzo@kernel.org
Cc: netdev@vger.kernel.org, nbd@nbd.name, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: Fix TX scheduler queue mask loop upper bound
Date: Wed, 17 Jun 2026 16:55:01 +0800
Message-ID: <178168650178.2224380.3950331731013129336@gmail.com>
In-Reply-To: <178166704952.2212140.11002626760717132754@gmail.com>
References: <178166704952.2212140.11002626760717132754@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300081-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:netdev@vger.kernel.org,m:nbd@nbd.name,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1A23697B44

On Tue, Jun 17, 2026, Lorenzo Bianconi wrote:
> Even if the current codebase supports just AIROHA_NUM_QOS_CHANNEL (4), the hw
> exposes 32 hw QoS channels (AIROHA_NUM_TX_RING). Here we are just clearing the
> configuration, so I guess the current implementation is correct.

Hi Lorenzo,

You are right that there is no functional impact, and I agree this
should not go to net. Let me explain the register layout I was worried
about, and you can decide whether it is worth a net-next cleanup or
should just be dropped.

The two macros are:

	REG_QUEUE_CLOSE_CFG(_n)             = 0x00a0 + ((_n) & 0xfc)
	TXQ_DISABLE_CHAN_QUEUE_MASK(_n, _m) = BIT((_m) + (((_n) & 0x3) << 3))

REG_QUEUE_CLOSE_CFG() masks the channel with 0xfc, and the bit macro
folds the channel with & 0x3 (mod 4) shifted by 3. So one 32-bit
register holds 4 channels x 8 queues, 8 queue bits per channel:

	channel 0 -> reg 0x00a0, bits  0..7
	channel 1 -> reg 0x00a0, bits  8..15
	channel 2 -> reg 0x00a0, bits 16..23
	channel 3 -> reg 0x00a0, bits 24..31
	channel 4 -> reg 0x00a4, bits  0..7
	...

In airoha_qdma_set_chan_tx_sched() the loop variable 'i' is passed as
the *queue* argument _m, not as a channel:

	for (i = 0; i < AIROHA_NUM_TX_RING; i++)   // i = 0..31
		airoha_qdma_clear(qdma, REG_QUEUE_CLOSE_CFG(channel),
				  TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i));

Since each channel only has AIROHA_NUM_QOS_QUEUES (8) queues, the correct
logic is to clear the 8 queue bits belonging to 'channel'. With i running
up to 31 the BIT() shift instead walks past those 8 bits and into the bit
ranges of the other channels folded into the same register. For channel 0
the accumulated mask becomes 0xffffffff, i.e. it touches channels 1..3 as
well.

This is harmless today only because REG_QUEUE_CLOSE_CFG is written
exclusively here, via airoha_qdma_clear() (RMW clear), and the register
resets to 0 and is never set anywhere -- so clearing extra bits is a
no-op. Functionally the current code is fine, as you say.

The point is just the loop-bound semantics: 'i' is a per-channel queue
index, so the bound should be AIROHA_NUM_QOS_QUEUES (8), not
AIROHA_NUM_TX_RING (32). The two happen to be related (32 == 4 channels *
8 queues) but mean different things.

Since there is no functional change, feel free to drop this if you would
rather not carry a cosmetic patch. If you think the clarity is worth it I
can resend against net-next without the Fixes tag.

Thanks,
Wayen


