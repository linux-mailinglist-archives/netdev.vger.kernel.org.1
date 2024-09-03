Return-Path: <netdev+bounces-124330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D094969091
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 02:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697721C22653
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 00:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFCB195;
	Tue,  3 Sep 2024 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmke6cfQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D136C
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 00:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725322041; cv=none; b=oqqMPZI7cwL1ykiYqZIiKVIeqNkjJoyXaPn1ZAumvPdq0A2efCqAP/J0WEMSGx2llfzgZKo+nXl2pMesJSkmL0O2IJHTxYndyf3c4f5B3hnN4tMwTBAjsJlfvWqHOaNqgcG6MXbYaV8BDziIL47dA7O7LyHFMgJFp5N0+4mSBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725322041; c=relaxed/simple;
	bh=8a5FsqTclVj9AM8Rp9V7s9Es8Ij+kxNGi2WpJ0ruVSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IBWePDNr9Xf6F9m17stqcwBWP2E9/tU/OavTcunVu6FEiWyfCNfwHzx9s2juyA2eDyk2MJoNfsrogQCKoPMsQikH2lWAekfqYCmJaNckh+8DZBWlGR8pgLc3uydnHEktGynmpNI1qC5IUFk9/5lV7YuFZBKHl58OYX/3EzoyPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dmke6cfQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso4112855b3a.0
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 17:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725322039; x=1725926839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EScHN1BOJwl8oXLUC7KkLAPsX8TkGsj9DCDcebH6r6I=;
        b=Dmke6cfQpOrabQDtRxiPwODV8TOWxUHEYxLj3YZr0+Ou1CNDS8shxYcj3rlSxDuGPZ
         0oB/oobZQNutH34thlgBVhdRFf39dPJSDBSPOLu99tN0saBwkHpC0Hyn6WuCqSmh6Zza
         0SDiNH8zUHNbOBHyhlf12s7M8fimpJG2FJTVm1XZGeHmERWln35BLOE0MK43tjzar2F9
         sDI7dO23b6e/GvYKzypQdAfYZQQrCe/wIVSRJ34u38DSIfQpDvl0WaMYJonSra9X6LaY
         WABFTnK3e1oUN7JyXmZLW/o+DsOj+vX/1KtaaV2JAFbxapxwrjvnoJcaucpBlfZb7w4E
         mf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725322039; x=1725926839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EScHN1BOJwl8oXLUC7KkLAPsX8TkGsj9DCDcebH6r6I=;
        b=lc9Ci/PbU8RwKnQ/i0ECU15+gJrOCyDXYrmGO8pu0ghwTUn3eJqBTpRNln+CAkEzTt
         qnbDQHyLsbvUZnbx48Hc1NHjgvzseXck1XTNCJhThmJSe5r7DEy386Y1vYhNOwkHrCzK
         qK0kyeooKZXr3qPrrHUj7E9aH29onGLCQENgRAyOoDtzLj+lo14lGafLDtcxId0OF/4p
         1Fu7Tl7BgcW4QI202+66LPl2A8ljTNrMYGGKVYDaSfuW1iPdF3SDaZy4Q4aFjBw7Ufmr
         knLfWG6FF6AUEeX4oxpYl6yjMmbEb9yvfyhTg6ttnqYwyMVNOE72Kv2mlN9AaFi7x81o
         V0+g==
X-Forwarded-Encrypted: i=1; AJvYcCUns1KRCyy/1n8qUcW1o/Hb6+6bd5/TXdnEErO92CU3lZpDsUlqRHEAvrB1xr3AOMGOJ6u+esI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/AFDLp2eYyenKmLsHbGhMPw6rfDsH//M4zZRyTU4fL7zaHlR
	9dGVe0WxM2fs2hHiI3baOdvyOZ1csCDuNCPve+4lEFzzMygnCfESYf+IAsNk
X-Google-Smtp-Source: AGHT+IFJrluM9UNWmp+UbwYTzj6KAlbYeFkv6dW6TTbtXtCujVa5Xips2NG+blxu4NAlJHzz6Ldczw==
X-Received: by 2002:a17:902:e54e:b0:205:6c15:7b75 with SMTP id d9443c01a7336-2056c157df2mr93168565ad.7.1725322039206;
        Mon, 02 Sep 2024 17:07:19 -0700 (PDT)
Received: from localhost.localdomain (syn-104-035-026-140.res.spectrum.com. [104.35.26.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515556ebcsm70799715ad.285.2024.09.02.17.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 17:07:18 -0700 (PDT)
From: Eyal Birger <eyal.birger@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	paul.wouters@aiven.io,
	antony@phenome.org,
	horms@kernel.org
Cc: devel@linux-ipsec.org,
	netdev@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH ipsec,v3 0/2] xfrm: respect ip proto rules criteria in xfrm dst lookups
Date: Mon,  2 Sep 2024 17:07:08 -0700
Message-Id: <20240903000710.3272505-1-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the route lookup for the outer packet after
encapsulation, including the L4 criteria specified in IP rules

The first patch is a minor refactor to allow passing more parameters
to dst lookup functions.
The second patch actually passes L4 information to these lookup functions.

Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

---

v3: pass ipproto for non UDP/TCP encapsulated traffic (e.g. ESP)
v2: fix first patch based on reviews from Steffen Klassert and
    Simon Horman

Eyal Birger (2):
  xfrm: extract dst lookup parameters into a struct
  xfrm: respect ip protocols rules criteria when performing dst lookups

 include/net/xfrm.h      | 28 ++++++++++++-----------
 net/ipv4/xfrm4_policy.c | 40 +++++++++++++++------------------
 net/ipv6/xfrm6_policy.c | 31 ++++++++++++-------------
 net/xfrm/xfrm_device.c  | 11 ++++++---
 net/xfrm/xfrm_policy.c  | 50 +++++++++++++++++++++++++++++++----------
 5 files changed, 95 insertions(+), 65 deletions(-)

-- 
2.34.1


