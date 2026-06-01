Return-Path: <netdev+bounces-293912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7SUAGbT8HWqNgQkAu9opvQ
	(envelope-from <netdev+bounces-293912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 23:42:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF962597D
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 23:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E698C3038A54
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCFB37DAA8;
	Mon,  1 Jun 2026 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0j3Nyze"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC6372ED6
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780350127; cv=none; b=c09NrJ/xlFc8xP/0sr9auJVWMGMIhquI4rAXK8BTt7MpYfiR6eYJS0IuSBClslvHJINiKMhpVMiP7ix/1exrIo8VyGHwqyxNCfSu4qB+A8RW5YojjPKJeGNnOetfHt3DhpnRqX+UgOkRtfaIbvkHUMFwWdyQ5o4qC4EZ3mwfkX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780350127; c=relaxed/simple;
	bh=PsKdNGEJ/GEbniw8+Esy9ECKjpaaqQIGonhyoIBGdU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5g/CDDCB+p/QyDSZ6u4B+v5q+zaOHxkI4RfFcuvAn0b7Sg6cuLhBXYO8SmR1L+bNYmV2VEfZybMWIPL9Uz3gbsehtjLP8hSUCm/SD7Fg30/JsSmKR8L0bk5X/rrwMsSj1S0/bSxVGp7sR1/eUAI1fOqsWauPJKQvtBssrpqvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0j3Nyze; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4909e3fa4b2so35247315e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 14:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780350125; x=1780954925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQGOEh1bZHWnu9Uz0mQ1yk1YZrq6Rissv+4IeOd2hWk=;
        b=m0j3NyzeKJZWgxrErxSB7h7pH+5t979K8ZMKiy0t+iDQ5uoOZmII4BSr6OSLaKPwzT
         Q3G1V7CXVDVUR302w+jYayZZ81SF0/GdabZq2+svbs1QIWo5Uili7YhvSSIvGEBtfb5d
         D/eny2CteC3s1BMbpx19UGZ6OHPYHDovnlf+6oAR3OXikszm5Ep27Be6LfZXTBYUd5CG
         vHvyNJw8qzhTLxHriYlayc3hxu962eDdw90KIql4Xmfd2jr1ySQfAZ7ra+BO2Asvr553
         5tqjAbYf4IdpQ+j4Ugfsp6xSdqftp+3G0x3BUPghtzkVhuyfEDxw9qspWCExeujd5aEz
         556A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780350125; x=1780954925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQGOEh1bZHWnu9Uz0mQ1yk1YZrq6Rissv+4IeOd2hWk=;
        b=Rs2Peop4WYAAOcJnCRRx/awtL8P9/Z03lG+031W8UCy1IC0WkTMPyxAZl12KQpw4y4
         0oypU2GSyFdo4OR6RUyiHEEVoy+nnS5Oc4m8AB2Y2fIE4VOWoLxSeGaqRi2CAgnYfaTX
         O+Psv2RFQR/hPKMFKgxFf2hplTbWTdShqGEnNTuUkQV8XbLi7hcufwH6HYBgiRGnnDTw
         d8qYagT0JBLf6M2GCUf3OgQCrFispB969oC3Cu378QwSmHkk8V2XxAr/ibjq32IKBxpf
         8PEe/8hQITzZmjsjKEDsiFYGO1+JhWnC6AWomyPGCwZVq7GhQ+jk5j2rOn8iSe8rlXOe
         U44g==
X-Forwarded-Encrypted: i=1; AFNElJ+cNG1WFd5ywgIQ/sVxvGEzjbrOd5/BxmUC02WB7NfkCGw7yl3Ak5q5HKynwv4l+v0k0aQewrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOUM88AWxw/nXnTgFdOCynHT6PMXSBnSYpNama+iCWxYeo3BH
	83/ns34+LZaSSZpFzC8iC+XAzhdCVXLbIEemLMTgEKcxWooMHcd6dmJ7
X-Gm-Gg: Acq92OElngTEqBZzIc9U8BDfXYciuZX+CV8qGjTWCR+hHtFUOra7jufMr5DPGl3TmbO
	wxVFuJI48YP7Oqp042pGe4jn163L9C5ghExBdGz5T2tUFv41FLuuqrJuHm5Y+EBGrr6dwLfeeYW
	Q3xfhOffYmhqdiMDQy0xlskWxN72w9NBuGNrFMq3Hg8014KMMgYVPGcdPgOm5y7rYsnzIFpxL21
	BV3r52VM137cQKXkSDVpiw4YudSuXQ0XUpLgK/QRva7sb3E8PCXsh1zWB/Q1gCBB1woDjfnX8Kw
	OHWkfzI5b2oRcjSXfw7CulehBn05qn9+jpEgfJWKRUWlS0mM1HPbMdJS7JHXRBIE2EHxdjrRlBB
	hifCHhGVzdqZf0hYaWwp9Jlf3WTdd197eKEz1JKAv3AUFej0QcPylvR0gbnvtb9VViuQerEnzhv
	NbihwKLvbXiAxZcuav2ZFzi6bIOgPwsSUJz2U+8DwnKQpzL0ogE/rj2bfIG26kPe83GXNnR94=
X-Received: by 2002:a05:600c:4f0f:b0:490:482c:437e with SMTP id 5b1f17b1804b1-490b08872a6mr31969755e9.23.1780350124761;
        Mon, 01 Jun 2026 14:42:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e0f343sm20188985e9.1.2026.06.01.14.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 14:42:04 -0700 (PDT)
Date: Mon, 1 Jun 2026 22:42:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Justin Lai <justinlai0215@realtek.com>, <kuba@kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
 <larry.chiu@realtek.com>
Subject: Re: [PATCH] rtase: Avoid sleeping in get_stats64()
Message-ID: <20260601224203.5d282c21@pumpkin>
In-Reply-To: <f4b96c08-c6f7-422f-aceb-aa48fa2bfef6@intel.com>
References: <20260601062447.64027-1-justinlai0215@realtek.com>
	<f4b96c08-c6f7-422f-aceb-aa48fa2bfef6@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293912-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B8CF962597D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 15:14:50 +0200
Alexander Lobakin <aleksander.lobakin@intel.com> wrote:

> From: Justin Lai <justinlai0215@realtek.com>
> Date: Mon, 1 Jun 2026 14:24:47 +0800
> 
> > The .ndo_get_stats64 callback must not sleep because it can be
> > called when reading /proc/net/dev.
> > 
> > rtase_get_stats64() calls rtase_dump_tally_counter(), which polls
> > the tally counter dump bit with read_poll_timeout(). This may
> > sleep while waiting for the hardware counter dump to complete.
> > 
> > Use read_poll_timeout_atomic() instead to avoid sleeping in the
> > get_stats64() path.
> > 
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>  
> 
> Looks legit.
> 
> One question: for how long can this poll for in real life scenarios? Up
> to ~1 ms is okay-ish for atomic, but if longer, then you'd better to
> split it into shorter polls and reschedule() time to time.

Anyone trying to get a thread running at an RT priority won't thank you
for spinning for anywhere near that long.
When an RT processes becomes runnable the scheduler will preempt a lower
priority process that is running on the cpu the RT process last ran on.
The RT process won't run until the preempt actually happens.

1ms is a very long time.

-- David

> 
> Thanks,
> Olek
> 


