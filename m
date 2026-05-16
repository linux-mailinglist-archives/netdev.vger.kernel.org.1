Return-Path: <netdev+bounces-288612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBg0IDlWCGowkAMAu9opvQ
	(envelope-from <netdev+bounces-288612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 13:34:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A74E55B77E
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 13:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DC0730160C8
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 11:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBBD3D646A;
	Sat, 16 May 2026 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX0ylpmC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2013D47B7
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778931245; cv=none; b=lj1OgQJFsbt8G2zIyy5WDv1A1EhE3TPrJ2TMDwzIdJy+ZJillQPSmbJh0Skp9ayz7H0XzbjpcrImh768qLJxG9NCzuQYdntAPIPeVrhzesz3oyTbXgYnaZc5eEehURl/n7Wb75FbqSkm2fxC00B0VISYfcoAOF2+cpc2ROqIUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778931245; c=relaxed/simple;
	bh=kS9Q1v0jE50HuL+kLJLERVYaxzIqhv2g23wbEVDAAK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmrKxxAawBRVMuISRlMcQaKRBNFNQpfVgo0rJQYBi74a4azjoK8jUsoLPOSc7fHA6u102968/DaD69LMOslgFlB+dPhqdEZWtBI9ExZG5KFYraRYhU/6RkFCkaLa8sxFixsZAHDz2DGQ8npVu44HwCK2813yM8CWIosi+4YqCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX0ylpmC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso4061475e9.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778931242; x=1779536042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXRm8wHLMvu7h8cKS/PMy3rIET0MllJuf9jGLxBvpQs=;
        b=BX0ylpmCyBrPOKvAE7i+QMm+Opwg8fyoDDQ27gqJTSpOL1QAyRqFdnevY2CWhRwiJL
         RdQTw09kFSD41jbtBDbGRjA0lsVrkjKSe+yXkbYfEyWV4rc4E7ryeEXeP8iliccxMRBZ
         kMuUhui0lVxR6NYzRiaZoFE2ZCrZcc9cIZyPFvyP0A9s/iHLsK/WS3gqsK63i5UoPewa
         P4Ytg89XML1rQZ6Q8XnsdlOpJTwcrb3nwYz8/XlgTwCHbhCUZnm3TIQSeO54IpuTWpId
         tqTYKjxs3jBXvHJXmUDJCz4GcZ/fUdfUyarmHv64M+DQPmejP5Pzn3YY55qZejDwnlor
         +dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778931242; x=1779536042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXRm8wHLMvu7h8cKS/PMy3rIET0MllJuf9jGLxBvpQs=;
        b=YCuTUcIRdPWOeLulCc6bEpL8dFCWtql9V5bnQKToTKqGO+h5tqf8o15giNTMgNU/5g
         TRaVv2RkdsCJtUsXxF2U5+1tLUhkm6QUeNrkg7wcCm79/5nlpZvSeQspLt/3IQTSM9Q4
         zaGXrUcBjIh1ntFqtagnd7Ut5wGjXkQnQQZzl/xf2V4xz0S8Tkk6ZX9CIM4NYE3VFoHo
         MnZq9T8mWpaTHBmIpGw3Vbi5DimTlZH86UXdoMw56Sh39gEDu3rJEh3msOOzkyU+wfal
         O2DrhqW9N83wOlled/MXk/mfL77qjQvKKecrevOG7r4xk//fHuOScNfsZeReD/Lsg6DM
         hlGw==
X-Forwarded-Encrypted: i=1; AFNElJ99xoCGGc+lSk3VOEpaGpad9Z7tWR8YOODXti2+3Qe4d4BhX84NPeePBJmcq/NEEd19+KDFS6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQN2HZnSow4ewnPGHaqqoRlX8cAoFj1x4LztRmpzE43x2bbZkp
	p0OKArjLbjBBshOj6S50aah54wxz6jJ3QEvEtMu0gZnGltEGDsAk1qWg
X-Gm-Gg: Acq92OGOC3Abx19QPNgIdQN2BQRB6Rpqa5Hth9Y+dMKTjE9bmWJtWGGhflNLE3Xpuka
	YjZxiQWJrJOREvhFiqKo6wUSuGdr6qpilzG/fG7xa4zCV0oG+3Y6oSx+5eWNEX6tL+NVi0P9Lky
	JZvg02AZO5N9pqgJWwdbw3nBFuOeEbK7L+KqX7EHArPYrN064Ke8VDmYyjZ/k/LNeQc/UIYLDrN
	CVh/bmHmfmaJXXChdFMHHdVVji79ehZ0VGvGS16chlfuPAUevzXZ4tsgyfF6ZK8naqrpPezIevV
	X81LrvelaxzZ6cfYcSeigZQ19B0NL/Ug54lQKYwl+ba/KkUYW5lSwlmVLaL51dW5b5DLelxiDXv
	6kOEH32sluLJnDmxluQ9+f6Qp8ZPnGt5U4xhJr66jFpH81UYWlHXku1kpQ9NfBbe9L2pMYx8iS1
	jC5eeiqoMTaSOwIfJsHZceHdXOiAYwOUw2B7nru0vyDOTAoCH7PYQLc0OzwN4sQi8wNVvEqDu7t
	L6y
X-Received: by 2002:a05:6000:2dc2:b0:43d:1c4a:37c with SMTP id ffacd0b85a97d-45e5c5b39admr10857244f8f.4.1778931241865;
        Sat, 16 May 2026 04:34:01 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-304-238.w86-195.abo.wanadoo.fr. [86.195.26.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768acesm22686198f8f.7.2026.05.16.04.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 04:34:01 -0700 (PDT)
From: Bernard Pidoux F6BVP <bernard.f6bvp@gmail.com>
To: kuba@kernel.org
Cc: toke@toke.dk,
	stable@vger.kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-hams@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio (hamradio) subsystem
Date: Sat, 16 May 2026 13:33:55 +0200
Message-ID: <20260516113355.24110-1-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A74E55B77E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-288612-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

On Fri, 16 May 2026 Jakub Kicinski wrote:
> It's a GitHub repo so PR is probably appropriate there.

Done. I have submitted the five rose fixes as a pull request to the
mod-orphan repository:

  https://github.com/linux-netdev/mod-orphan/pull/1

The PR contains six commits:

  1. rose: build with hamradio_compat.h on pre-7.0 kernels
     (compat shim for struct sockaddr_unsized, required by af_rose.c)
  2. rose: fix dev_put() leak in rose_loopback_timer()
  3. rose: hold loopback neighbour reference across timer callback
  4. rose: fix race between loopback timer and module removal
  5. rose: clear neighbour pointer after rose_neigh_put() in state machines
  6. rose: guard rose_neigh_put() against NULL in timer expiry

All five fixes have been built and tested successfully against kernel
6.17.0-23-generic (pre-7.0): insmod, functional operation, and rmmod
all completed cleanly with no crash or leak detected.

73 de Bernard Pidoux F6BVP

