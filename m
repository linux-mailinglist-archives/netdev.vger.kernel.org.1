Return-Path: <netdev+bounces-205940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B06FB00DF9
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912FD1C8532E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCCB28F95E;
	Thu, 10 Jul 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SndQuwTW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D13258CE9
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183618; cv=none; b=lEMXtuR8Th2WHtY/Yc3gONr++pJD91ksl8b/3/jwtH2NAgfnUnfP9ppxxuPH1zchece/uo/SSqcbrodUaSwO+AgiYYE6XDF/qETUKCJHHHJKzI16Q5lZxnb8SwVL3Wof37zTIfyXDqtslR88hTSZq4ezF7XevaNlgFYGH0hwoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183618; c=relaxed/simple;
	bh=Aq2/GxGT19aYb42kMHS+Puax2AG10TTtn71MwiO9e8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnOtXrGDwt2tCSwEVzs1/REWIsswQrXzNxcfngzhJHuQQjDrogSY+kXEA/2V8sIpOfoPNez+ItzU94lWnSQgoumuiH9FlYDz1t7lQ2/GIyrEDQGBHOy9phSDfgdTgv6RJuqnUvWHv8Y2zdZX6sMAN+jJNz/5Mwwe8X6ZmUavOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SndQuwTW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b31c84b8052so1827451a12.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752183616; x=1752788416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30fos2mn9COFDHXFRenavs2n0SOZC8LaJNXsFgDkYJ8=;
        b=SndQuwTWD7+gp6JOsTZrpFDBiJCeVUa9n6at2jNeARTY2R0ccSc9EfEBH/Rx3RhSgh
         XbKLIAOqnOS88SKGxE6hYc7oUhouCAfL1zB+18NPcxB7WUPGd933qNfxpZkgGI4v8isL
         xFuL8KIWdC51TJWMnQpnp/fCSZWTQNUjVe1Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183616; x=1752788416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30fos2mn9COFDHXFRenavs2n0SOZC8LaJNXsFgDkYJ8=;
        b=LxNLujjM7s89rlaBgdcIoyXOilq+nbrk2YeD8Vodo+9OIsKqmFWpbLVHy1ZMWkvIwG
         SIdSKbocg5j4k9Ul3rsXSzP/YDJCYgIBP81rvhiyrY4jYPMaCflQQ6lg2weCRQPjRMF4
         sE2ZUx/HiO4FoOScx1rziLQWMRdDEOkxPT6iDcFp+PV4HlBiGz4AkSkLYMWOpGqpZj+u
         8C9jo+jYMxr3SPXeDNoJGkHn+/4M/KjZuOZ1zQZunF2AViXr4EELUqNwzpjPGH6imFMO
         Tq5hG4EAgvqh0sv10nEdD9UCCtvWH/4kt4YyKkSq4+Y9ck2PP8nXYebEmx/Bfz7BLQdK
         ssUA==
X-Gm-Message-State: AOJu0YwBlVehGLEqDXyduBbRD/PxLkvj1CARv+XdDL1/rBQVgLXgHNw2
	fF5TFK/JbPEJmcOKAloRxCbIyQDTv58EVV8TDH4/vyT7fJaIGvRC9X/Yh/QfTHo5eg==
X-Gm-Gg: ASbGnct2+gfrf3+nTAvWEBwTWk3pkeZm7QMfpVHhddfdQUNGvKEWBESGAhTqUjAxy9h
	L+3er+4srPubn4j3/2WjU8kDHgEdPQs/XDeumUYEHwCXG7Y4Ro7yv9rM5ujt13xBceklPsldQdq
	bIVNSnp4Ov27Rp/KLiZQWDgs4GUebjoKXxYkT72tlNlbQG+V6lLUvgxMSfLfbNKZXo+RcdzLWTr
	ceExtNDi6+XQ3wcpRPF194lq8J32qZzw2Lxscj9umN+ckUreCzRuAfpfNDIlSUY0qEX7ABmjc1K
	P+IJwcjbbDyublNn4Fco1ZMYrdNKW/Z17pZyEQC5tkkBONFwIHeXGIPXTE74yDr06bgFqolnQe/
	VFWjMjWvOELKJdd3fV93gKEhnkXvQeUv218LGDg==
X-Google-Smtp-Source: AGHT+IEGFulL+IW0KBMA2EapOrEjGudL2CZPN/7cYH/Np9gUhD0nnfaBIEqIjUs54fDOtLHlUt3htQ==
X-Received: by 2002:a17:90a:d006:b0:31c:15d9:8a5 with SMTP id 98e67ed59e1d1-31c4ccea797mr1194921a91.19.1752183615705;
        Thu, 10 Jul 2025 14:40:15 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e9581d8sm3358208a91.6.2025.07.10.14.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:40:15 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH net 1/3] bnxt_en: Fix DCB ETS validation
Date: Thu, 10 Jul 2025 14:39:36 -0700
Message-ID: <20250710213938.1959625-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710213938.1959625-1-michael.chan@broadcom.com>
References: <20250710213938.1959625-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shravya KN <shravya.k-n@broadcom.com>

In bnxt_ets_validate(), the code incorrectly loops over all possible
traffic classes to check and add the ETS settings.  Fix it to loop
over the configured traffic classes only.

The unconfigured traffic classes will default to TSA_ETS with 0
bandwidth.  Looping over these unconfigured traffic classes may
cause the validation to fail and trigger this error message:

"rejecting ETS config starving a TC\n"

The .ieee_setets() will then fail.

Fixes: 7df4ae9fe855 ("bnxt_en: Implement DCBNL to support host-based DCBX.")
Reviewed-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index 0dbb880a7aa0..71e14be2507e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -487,7 +487,9 @@ static int bnxt_ets_validate(struct bnxt *bp, struct ieee_ets *ets, u8 *tc)
 
 		if ((ets->tc_tx_bw[i] || ets->tc_tsa[i]) && i > bp->max_tc)
 			return -EINVAL;
+	}
 
+	for (i = 0; i < max_tc; i++) {
 		switch (ets->tc_tsa[i]) {
 		case IEEE_8021QAZ_TSA_STRICT:
 			break;
-- 
2.30.1


