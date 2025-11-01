Return-Path: <netdev+bounces-234826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D116EC27B1B
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 10:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74C61A25535
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DEC2D594A;
	Sat,  1 Nov 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABdQt3g0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895C2D320E
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990487; cv=none; b=tgOgUELeXDeVxJPKyoPr28ceNMIJ6VoPwaUBwajgJdmPagdtXt8a3Hs+Q6FStE7EUGEGBMT074kToZpk5nYM4aFeLciP3oqZN81MzaseslQFsmbTckkXwjA8DRVvXIROst6kG8zv2ArlAvzAm+neDpe9blSf5mXLzbyz9heY4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990487; c=relaxed/simple;
	bh=VFD6GtIua5YG7zFmjDzL7GA/HqAr0MELlfN71DmH60w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPRQxmSFXTtT7ah4cO62RaIYG/hUgwgGscCNkZUGIP80vMLic6+HxrNpas0JX/RwvOgWbMdzsEuUcOD8n7yOPmE6hA6e6ZSYsAZmCfroAkUQYLeYG31vkFtatn0ZA1ZlH0Z9/dakE4F1HXOqPZqT5dyDVH+duaEncwmrhmwzzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABdQt3g0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34029a194bcso3310175a91.0
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990485; x=1762595285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i163pqyR8qyoX26TG357PYVJu78JzhXd/RDPq6ZRj24=;
        b=ABdQt3g0TTlpYbMo/ARof8OQvjUtMB9l/em7aVs0+wNr3lVgeNbcOcvF5Lqm9n7VVD
         vTvFntx52tMokyCjK4vCOvaS1p8vHy4YVC3qyFa6MhkZqbWaLBELOxsvMsMcYbaRwF6h
         rB07DSBxfK59rWuOm7a+bvr2SXGSUBJmBid9R3kM8DFZ24y4UaJB31OZPtNiM8mWxCMS
         sSK0sTPawyD0exRkqKY0XMwyOeodnBaSUbzdF2AnSjBtUgOPGX1n/+6YXAe7dwZtrvAG
         pYrsqIhEPD+/L+eCaQkdEagedk+UqnuEtZqxFzTfvACRNtzB5mz8CbAOJE6LVC6LKuJO
         23Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990485; x=1762595285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i163pqyR8qyoX26TG357PYVJu78JzhXd/RDPq6ZRj24=;
        b=OW9OExeGmHaLU8UTFd7qUHA6c1k4SdYqWTb3huRlmuLFSD0//1GjtTC6iQ2l0yUoFY
         8Pd4B7p7I3hz49LzqGMOU2l2iDjR0lLgVQwjHKnC2rSBoIW0Sf/e22FqaOMAyyGQ7rqc
         s7o8qVkaeo1tl2pY27Iyfw061ejao+Zl6VuALm82+JHyB6RxF/fGKEl6kG2lNpjw7P/I
         aLgEdmYBVl9YgbhnMF55iaYbTfuWCOaqtG0MFQKFinkawFTKFyeNBZn64rhElbVW0tuQ
         TYX6C/yODIhPHeJ1gihAss9k75nOSvu+zpPISCBrswJ2xHeXP63E33IwMS78QFvcvXGk
         SUnw==
X-Forwarded-Encrypted: i=1; AJvYcCWpRZ8KPpuL/VAXubygBphzdmupCZSLI3IAResMFihO+Bj5eXOvfl7Lpv/BTCCUn8eA/gdH91s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEL+EPWKtcipSBEGlp1OrOs+1oLL0iEgKXCamiFi0O1GYU+dX5
	qvpIVo/6nzPlX9+RKRS8Z+khqa6F0mf7x5bNhMWQ0uEcbbA7lo2ZGMMe
X-Gm-Gg: ASbGnctiqqEvKMSlCuupMpudIPgS16x1PHmkRQ4W5lUioPDI2XWzibwfur0ltcIbBCX
	CEFiJDtkxTmwLDY2QFJthS9gfhNNKqs2UuXqw+tsz8petzOPt9zd5k5FvxmwcImWXxAkeB5tjCK
	RM/vvsFZ2QLXT3SP5q3r9GGDATgnzzXbK0VmAyLE1b4/nBFEFicraL5WwfXWBM8D3HRTQf4GgKG
	HKVjUBGT/NjqxVeKy3qaIoVk5942JvrQDxqXZ0yP0kajV+yzLeRM5XUFjlwmjsfxYh7LXofcGhv
	PaJoeounqF01sPwcoEiLhRa4Jk3JXMLlvlN/emNCyim6nS6ttaEjsJDhNN311q7AeA4pxmNMpro
	L7CtCFa+ObQOO7C+CORZRYY61Hf0DxQ4iGocawX8cnhkukIvlMl+6gYsAZgj/RxRlRULsVOjtpF
	9M
X-Google-Smtp-Source: AGHT+IGGaTpxpgNC8ciQSQqiqJUywpj2+O3W4oFH7FhMd41eXjxSmQvEhN4sZcxR4XzrFlG6iXv0kA==
X-Received: by 2002:a17:90b:1c07:b0:340:d511:e163 with SMTP id 98e67ed59e1d1-340d511e58amr540915a91.8.1761990485008;
        Sat, 01 Nov 2025 02:48:05 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982117sm4722357b3a.15.2025.11.01.02.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DB82841FA3A8; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v2 6/8] Documentation: xfrm_sync: Number the fifth section
Date: Sat,  1 Nov 2025 16:47:42 +0700
Message-ID: <20251101094744.46932-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=bagasdotme@gmail.com; h=from:subject; bh=VFD6GtIua5YG7zFmjDzL7GA/HqAr0MELlfN71DmH60w=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms1/J61eMXh5r+5VtpuJ9Vae2HZ5pck3/9ZC9+wrTmo CDvkzsLO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARUUNGhp2cd7vve3/YPVXf p5gnfWOM2NMCjeUTV6z6s+aziv7rI38Y/tl3/V3BVPIkw0ZqYnR3IM8kj2mXPBdYrq8qvHHN4sh LWy4A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Number the fifth section ("Exception to threshold settings") to be
consistent with the rest of sections.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_sync.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
index de4da4707037ea..112f7c102ad043 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm_sync.rst
@@ -179,8 +179,8 @@ happened) is set to inform the user what happened.
 Note the two flags are mutually exclusive.
 The message will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
 
-Exceptions to threshold settings
---------------------------------
+5) Exceptions to threshold settings
+-----------------------------------
 
 If you have an SA that is getting hit by traffic in bursts such that
 there is a period where the timer threshold expires with no packets
-- 
An old man doll... just what I always wanted! - Clara


