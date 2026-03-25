Return-Path: <netdev+bounces-271509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEnXKk/Ww2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:34:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA85B324F0A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0E3930C0033
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3673CFF4A;
	Wed, 25 Mar 2026 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxCfiD5L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F120341ACA
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440499; cv=none; b=qpsO02wqKTKndMnM+E+P4Za4wwBNVG0fKFv7kj51B7iLDnymMoMYIVeH1o5yytX/Smwk7EdhzWBntaChtexfBqqm60ZMFB2R7zzHEKZP/1kr0CgdT+8lf0Fknfv3JCG1hh7hBuX4y+keR/dru/9rsSLDPY/CIzKaKNVKJdQn8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440499; c=relaxed/simple;
	bh=+cMoiw6D/IN3IntDhoppbwqa4lsSaKo8wfRqQOkKgz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3MM1nxIOmSPHqRTg1Md1lEWgOVM05SFeRfclMc7sw3rJKFsawHnC8QsSCE21m9r4i8rYoT+SfbSPByZR3oUnne5wWMlExkI/1dgygFUqpJA59wm5mW03TfTznX2dgDYM6d5SMiobg4fP9L2O9OaN9YwjV/2U7QHdezrMQhSZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxCfiD5L; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so750351f8f.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 05:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774440496; x=1775045296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdYUqT0vzhqUOzwuw5MinoVNdtbVW6KIxEy0tW7Lyfs=;
        b=oxCfiD5Lpv7n+ZOtCaO5DUJR1M9E0ChfUX0Afr9QslGia9E7TFgFC3dMdEvveEKMK1
         FUipD/qgIIpMO1o9BRwSVznkT49iTxs4FRJiC+yBfAN4OXm6Q97zhbUPTMmYQ5eKe383
         SALugI9/fTD7PYiNHgXBAqdlr1DHY9SZCnUYlLI6vf/AJE5vrWl2oaRxmUyPU42siMVo
         gELgs1CFFKzHiU2A9n3CleurMb/kLuEdciWyzQPw2/j23kB2SIifAHKXIJl3sapl3vyZ
         iBWj8rrodcvj6skaUrKIXyK2n3Kz274Cs1TV8ihXz4qAof4WS1LyU7E4h4mdj+C8K6nt
         22Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774440496; x=1775045296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdYUqT0vzhqUOzwuw5MinoVNdtbVW6KIxEy0tW7Lyfs=;
        b=Ob93q0KoVXNpOexvznW248Qz85kGaeiFGgSmhYytbPuHoW0OGBnAtnCrAg1h4BHd8a
         pbwfTLyZ7D4zdZTK2lup1r6jsKcAX+Zbi7ZOU7Xgp7yFKcaZ4A4wMv8WwJlwDLql7Rbp
         PDJSq+jiBimYigG9fpzn1UykD7H1rD0hHlsP8vEtb12fFsvfmt+NP1g/6n9IqIesIBwX
         vPXbHOe4fG1HkmajilemlU9hcyNJf56WO7Nbi28RJYuSh6kueq7uwV3Uk3Yru6DYayeD
         4fuCfMHeSn6cFdSpGmNY102Pohh9ocD44mKbK1T7PLA7VrtcEspQ7EolWSEs6SB/NZz4
         Cauw==
X-Forwarded-Encrypted: i=1; AJvYcCV3eAuMNIsBZgN+eC+29IE2Ic7OvwJ+GNxuD+Bsoqp1+B3U49ElT5r27fSzMhI0EFl4bPSZThQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNXm6+XZa41/N4ioCjPZ/WdsgUs0mMeV9Abvrv31GY3Kzvrb7
	lVUYqflrxQE/Stkb2VlUSIDOcM4CL2L61kAstRNOCrxWw2D2Uv0n1xZa
X-Gm-Gg: ATEYQzy3657k1KfRYfu93DinHIu79kbi3nywOjXEQTEA6HeG1Qd9bHjZBQcczdpsrQB
	2XkB7E7GcL6TBlHV5jfftu6huGFxu66VYRAF/iFQR5AtI6hV/c0ZIcgeljLZC3JNBEdisxDl99K
	UvDVre5WX73XjgsH/0/6I/dootj9aSvAmlDN6BpLW09rwoe+MZWuuU4I/jxMaLealSOXCcT9KzP
	SU975aTz3QNIJZQLLkw1I8KKEiYhH7+O+kxZSD1eGwMtKJrizhi2yWiqwqN9I4P+UHt02fkV6wn
	j7rUxrlgJTaqDYPUharc+gDlyRW8hKJMxv+nF7udQ86b5vKHBN4KLmhjOdwxaI4xIxDVjwVJfVO
	0fh1OTAqLvJJpG/yIpfnSdQr5N4UWt9UoJyMyzrnJDF8bJVOMz/NKN2OC/dFOfQrtmBYtykUp5A
	McVKpnCbQbeOpmgfkELXzxF9iW2edsuNLHbbGg4tXw1BYB/oLsKqa4XE/W+iLVsSKhMFJwq3EKN
	5hyRm2r/w==
X-Received: by 2002:a05:6000:98c:b0:43b:3c53:283d with SMTP id ffacd0b85a97d-43b805a1754mr10585982f8f.21.1774440496367;
        Wed, 25 Mar 2026 05:08:16 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm48618289f8f.2.2026.03.25.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:08:15 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 0/4] follow up zcrx fixes
Date: Wed, 25 Mar 2026 12:08:17 +0000
Message-ID: <cover.1774439286.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-271509-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA85B324F0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Follow up fixes for the recent update flagged by review.

Pavel Begunkov (4):
  io_uring/zcrx: don't use mark0 for allocating xarray
  io_uring/zcrx: don't clear not allocated niovs
  io_uring/zcrx: use dma_len for chunk size calculation
  io_uring/zcrx: use correct mmap off constants

 io_uring/zcrx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.53.0


