Return-Path: <netdev+bounces-246698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A57CF0789
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 02:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D30D03010CED
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 01:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FC985C4A;
	Sun,  4 Jan 2026 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwMAuOum"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A784273F9
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767489695; cv=none; b=oFoQBtWJKR0zAwsR4GxyvmYwOuLlsi44Ws86gzeRT5/94vKgXeOCYBYBAB6QJFRkBEg3n9W80Au5I0FxlTkp3/Fq7O5BNQ7FgOnedTWFpnNjfgD3i4BnTix5VSJLWZaH5no6ROzDJplJR1/x/A84aNFjIOLguGwtuBnrp5eu2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767489695; c=relaxed/simple;
	bh=VcSvpLpbh0fEnPUOq/GhltLFqOdrvS6cj4/rV17TS0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V8DtP6QNFMzZWcQceqNvRDYP2HKMX4UPZ1BDWxplvoiriEFOuc9gD77z6sjt4m4w5SGjRjCupm9jUKAR33wK6N2/Pnfw6NLwL/U+8wLmAtrdO9pb+TPzzSt30rPRnj2LGVYEvsA9eyTcAyPaonSdH2fGNa0Gk533hy3Neqlemvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwMAuOum; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0834769f0so127372705ad.2
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 17:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767489694; x=1768094494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdvP8ECgpBcOdlKiEy0yoAm3c9IvL3YKmio/VImfYxs=;
        b=fwMAuOum8vN8tlJlrqRCuhx0Y3bwubDE40gVMc4w/oRkwNMiY/FFxLcqs5uw2Zs5X8
         4sUo+psoRJXP+iENQobe5Bs3Mp3ziu4MacXRZ9vLVrZ2S+8YoCKmGyscvPARQGkeaL9L
         8RtOIppNTAhAO4NPdDlIqZk/NpbzbF7HhdOJBB4cnARWc7dzy3jqSk9RwY63diNCBHfg
         umLJAgzilB1YGSW+dtP62+HtT2+YziDy+WbLWt6X48wolZhvs8lZKABNCY6Q2NAbC7hl
         qQCamFgfPHzQ+ABPzJzUZE6jwCp5xTCr9r06oWk+1Ao2GQQNDswQtf1nDfdqxTlWWOgw
         uD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767489694; x=1768094494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdvP8ECgpBcOdlKiEy0yoAm3c9IvL3YKmio/VImfYxs=;
        b=eF6IlptGOQhQYTzRvX7ZPxpPxWUix7SSojtSM9u5wsrxDkqLYCRSt5gs7BVEcubp8I
         PcTFaDjHM+9kLHtgs1QOwo81Unti9Iw8L9S01T1ctZyspnklE7oXSGz4ROIdk4XtH/RF
         zO8jPFvrsVNI5j123POpgARj0nGYE/yX9GCfp4sY0/jofxjTTAuXvytE+J01F+Dqil0Z
         skS2cjY5upoHKYvrbKRLLwS6h9sLbF3e5d9pi4C305IJzVPhAB7wPwa1s/+zfk48KyVr
         6M2a9JwvC9GFWQTQyA39U1mdaB3egXF0xMfIOQEGunfvdnyWo47bTbSOiMU17gBpv8Tb
         8TWg==
X-Forwarded-Encrypted: i=1; AJvYcCXYAEWNzLJAm9z87ogypiRzEg0DS2uR9MzNfr+5tOcKccjBcik4belfvedYuxTQodaW9J/Zlic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvMb0PHp2nOrJleyShNYeyo5HPoZADxYpzjhvgvsHMhALGGzM
	Ezbun2YAzozm4S8zEkGE8G0XlBmlStsSh7Mw37GsNtffQJc6f5TwD3sG
X-Gm-Gg: AY/fxX4Z6n1GipCd5Z9C7B3lEyCC71Z8FOmCUii9+Pby1tMJ+RyUYLuVST21aJs0BNn
	PB8G/ZutDHMH5ljtZ7gfDlHAKW8RcmT8azUUroZjuze2Xi9dYb8H2k6Ud7xlKCmFsqgTzPNDW8Y
	XoK08PRM4QwRlt+n+8++CJ92DKI2Ut67PCOe78QWQTJ2Q3YmhNpd5DtTVJVhSjgvB3tmlXcAySr
	Xbtjc7HttKTS+tZqJgtPkVmws9mLI6AVpj/9ogdxeCEg07ZNdSFtpquUUrtNrDX3bgt4Un6Y2K4
	iXufjFSmmOhP/usfHOMd9J+rSwD/FJtmWDH9uiVScvWHUGHGIP9+dg16elIdTBwq91UKM+KSjKq
	UfrP271bfh9Kt8E5faWKG+6bY7N+XhtvBDQstf98Si1zum1QXRMsqo4+YcDkJMN5zjlN04VkM7k
	xL3nGg2lX4T+5VmP390e76HDf5TYSS4Zhv6jdw8VhDWdVJM+Isq0XGmgcknA==
X-Google-Smtp-Source: AGHT+IEa+CYDyN8yb6jg12hX7SncnSJaXO6QEUHvsIW8UiXvYemlAddXr8JbMLB9PBsjFHNggSAGbw==
X-Received: by 2002:a17:903:90b:b0:294:f1fa:9097 with SMTP id d9443c01a7336-2a2f2735321mr373864505ad.34.1767489693694;
        Sat, 03 Jan 2026 17:21:33 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f3d7sm44484500b3a.51.2026.01.03.17.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 17:21:33 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 0/2] xsk: move cq_cached_prod_lock
Date: Sun,  4 Jan 2026 09:21:23 +0800
Message-Id: <20260104012125.44003-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Move cq_cached_prod_lock to avoid touching new cacheline.

---
V6
Link: https://lore.kernel.org/all/20251216025047.67553-1-kerneljasonxing@gmail.com/
1. only rebase

RFC V5
Link: https://lore.kernel.org/all/20251209031628.28429-1-kerneljasonxing@gmail.com/
1. From what I lately know from the repro at the above link, application
can use the shared umem mode directly but the kernel will eventually
return error that is reflected in the xp_assign_dev_shared(). Advancing
the check can avoid the crash in patch [1/2] and be good to avoid
unnecessary memory allocation.

RFC V4
Link: https://lore.kernel.org/all/20251128134601.54678-1-kerneljasonxing@gmail.com/
1. use moving lock method instead (Paolo, Magnus)
2. Add credit to Paolo, thanks!

v3
Link: https://lore.kernel.org/all/20251125085431.4039-1-kerneljasonxing@gmail.com/
1. fix one race issue that cannot be resolved by simple seperated atomic
operations. So this revision only updates patch [2/3] and tries to use
try_cmpxchg method to avoid that problem. (paolo)
2. update commit log accordingly.

V2
Link: https://lore.kernel.org/all/20251124080858.89593-1-kerneljasonxing@gmail.com/
1. use separate functions rather than branches within shared routines. (Maciej)
2. make each patch as simple as possible for easier review



Jason Xing (2):
  xsk: advance cq/fq check when shared umem is used
  xsk: move cq_cached_prod_lock to avoid touching a cacheline in sending
    path

 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 15 +++++++++++----
 net/xdp/xsk_buff_pool.c     |  6 +-----
 net/xdp/xsk_queue.h         |  5 +++++
 4 files changed, 17 insertions(+), 14 deletions(-)

-- 
2.41.3


