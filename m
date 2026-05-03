Return-Path: <netdev+bounces-283638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCEiGBh892kpiQIAu9opvQ
	(envelope-from <netdev+bounces-283638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:47:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 051214B6937
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52F163003348
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED503CBE93;
	Sun,  3 May 2026 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATPjrw10"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDFB391E7C
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777826835; cv=none; b=BRzf7CPDAyXt/EHg9Pn6FEwt5Q3f6qBnYx8PGPd09uFSf9aj/nXUkmJAHRmaEDZFMWF9hQaJda7wK/T+T0D6tDDXxjogXTi2BH49zDpn3bwPojEGSM9nm7eRvoUurNaS0oeKYAt4NBEXNgFvuvA0Iqi5D6H9vLw20vy4LnDahd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777826835; c=relaxed/simple;
	bh=ebx9DytCjEe5hkX4lMtfi5pzQvgPYCMmi4NGe2LpsWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ndq6hUajZ6jdFg2FAD6BmIF9ivxxt+3eMcWQhcnYpgU3yX221cjaSDUfRs6FNDAxg5JdiI2cJK8a9XG+fMSZXcqnmSUUmgpvJlDGkLbn1mnHXVGIxMsXfFYJ9zfMOhJDPtXpOs0cg9IElTRtfeFWtxtrfovsb/m16/pSBfEeadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATPjrw10; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e7d983f79so33621891fa.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777826832; x=1778431632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebx9DytCjEe5hkX4lMtfi5pzQvgPYCMmi4NGe2LpsWw=;
        b=ATPjrw10h1EqCjqyBDFmFmTj42m+UPelzagG60oKl8aoaXllRLR+UKCV5CGZ0r9ZJY
         6ts3iCFXIOwLceciqZ2VNGskSoACul1ce+u757TzkEm7PmAk04AfTSECOmZ78jbfQQA9
         9USvWXdb9x0DTcF0wXCtPpnzT0//gpsX6xrK8oVzFHP5qpxdVOcx+NyHAncUFkS839hP
         3y6jCU5I808hXXIrQ+/eF2UH5VRuMQe4Zym2GFor4mS8HezxRQyRSgz+ZPNz2QrIdEvF
         AlKttAWACApdH96SNEzHYvt2GmVdgLBASR7Apc+UfxB9ssj3OSmY/c2VobeZ74QYIEmh
         ZwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777826832; x=1778431632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ebx9DytCjEe5hkX4lMtfi5pzQvgPYCMmi4NGe2LpsWw=;
        b=iLf21FVvYvUZZjpIxyzMXBNv9aL6ieYBLl6f0leW1gIg7TQ9gcxZwCFflKtB4xddYu
         BiSDophN5lTNMEc++NdZf1iKB/8ejojm/79ElQd3bwXhkfm/OLhGSte/cBN7gMjqFvkc
         hIVzjmRiv4Hw+GBT79tWdyCa+UeKK58Edku44IGzmcAEwm4CsI4ViYJCVLhWfPP/Ovg0
         9IguJTkYFQdCO4Yz5vXVA6wWK2kA1v+8lKoEcKaI9HBjs97WrXMxIdL5rri6OSdbllKG
         67qwibYAtgTJR0bW2HD5MyUnTc2VwKppLVGxRDwucQH13ePejBPKGF/koYbckDs7NkoU
         4Liw==
X-Gm-Message-State: AOJu0Yx+1PAAnYUORCzQ6VnJxNaC6eHVV8od69eHzsqhrz02P8mom144
	5ZcrgNGqplDt7I7v7oARKBelW0we08hOoYNCSQGqgmJVsnlgijTGe+23
X-Gm-Gg: AeBDievAg4luAKyaYmoqxPAgPNnKIBP+LA3QeCqNjF1SOleFXrezu88oCj7BNGcTq/o
	x5bqbhJ7iY2Jkb6h7qmvYSU1VxbNPG29XVwbsId1oEaaKFCWXVasGUqvZj4ml5vnY/oH6NepFvF
	iWQAhwCnmogtEtbEVs2d1rtDeEK+4I/XEoKn9e2xU3iMiAlnixMfT0azlB1ZbPHbV522ccJg306
	vpxn3ojCUVChaE/BdAAa0HbJ+ps0uvDw/69vA4dm0MNYz763+sRRhWLf2bQgFX2LGOPSLWMN9Oa
	c73+sWUpOMLRC7Ysgkh29kI9Lp3MBlVN+Df1/QG4fCJFO/RIHx0zRwVpmqBOFe3vaMIncfpMwic
	jzsJ/eKsr0Cr411duEazS6KzlPNU+laV9w6o0noAGi8NKaYGYUqhqeKR1Gd+SB2eF3TJVyQJipr
	FpHI6jEcHHxqR2/H4vKkfHoYROkMYp958LXRmzrOKlsPVsVwVGwswDKkc4NUdzwgGrVGZOnCs=
X-Received: by 2002:a05:651c:1501:b0:38a:aba:9bf9 with SMTP id 38308e7fff4ca-3937849422fmr21458861fa.8.1777826831339;
        Sun, 03 May 2026 09:47:11 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39361323f4csm23033091fa.32.2026.05.03.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:47:10 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: idosch@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: fib_nexthops: detect kernel splats from torture tests
Date: Sun,  3 May 2026 19:47:08 +0300
Message-ID: <20260503164708.348543-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260503061740.GA98182@shredder>
References: <20260502122219.262611-1-vebohr@gmail.com> <20260503061740.GA98182@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 051214B6937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283638-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]

On Sat, May 03, 2026 at 06:17:40AM +0000, Ido Schimmel wrote:
> Do you have a trace?

No. I did not run a KASAN-enabled kernel before the fix; the commit
message stated "would have been visible to a KASAN run" as a fact
when I had only inferred it from the code. That was wrong.

> The netdev CI and our internal CI run the test and look at the kernel
> log for splats. Both did not flag it, most likely because per-CPU
> allocations are not covered by KASAN.

I did not check what the netdev CI already does, so the second claim
in that paragraph ("the torture loop just did not bother to look") was
also wrong. Combined with the percpu/KASAN gap you point out, the
patch does not close anything.

> I prefer to avoid such random markers and rely on the system running the
> tests to catch these issues.

Understood. Please drop v1.

