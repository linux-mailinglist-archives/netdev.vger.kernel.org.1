Return-Path: <netdev+bounces-163200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B406A29903
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA2B1883168
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF60A1FDA85;
	Wed,  5 Feb 2025 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVGdjx6I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC201FCFEF
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780077; cv=none; b=mRIlie5n5MKaIr4rN7Ac53RexvwdTjmFlRWMs2NXnqFRUddx2EKAuLT6ug/lid+cbU+dKUQnKXDcvLgerfFtKIREABkbQe318qG1Nj5Nc0EsH2Q21/NaSmPz2aP3kvLFdWCdJZFXB3yMxIAltr8tmhoJyEKrByFhTUkDdyjR3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780077; c=relaxed/simple;
	bh=W9AM+4Mhc0bGprB0aN1CX/IkWezisF2Uew7nsyGG23c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fs98umeEdEjOoVgNjdbXedHrXsWl5ib0vHfTQHV+JwqqAALUB4j8orAmnGrrM/VqOljNqFlHvmsTCDwkiPsICuy9RJewV/OqRfh21/ijD8C5M6w9joIeyxueHpMK+VKCv8GVhOsq5f+SEYCPHtF1MMNSw05jMVljnXuOn6tnT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVGdjx6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3CFC4CED1;
	Wed,  5 Feb 2025 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738780077;
	bh=W9AM+4Mhc0bGprB0aN1CX/IkWezisF2Uew7nsyGG23c=;
	h=From:To:Cc:Subject:Date:From;
	b=gVGdjx6IRG8fEpi13VjVaa06PyioZuSTL7NGw0LAeGvOD94wpLnmqM5fx3UuITgAA
	 w893OlrOw3JmN8J+bqyFD6E4iJ7ujFZBabLYtXtAyTWVcYb1i6LCtapIDwUB65Wh7g
	 UZK8lNI79jVKBgSrB5gRb7kNE7OyYhKcXBDNq9vKGvA0D+clbyEjiN/DTVlRYfm5mH
	 oMIPKSSLM5qRM7ieRiQGBBnQX/uBbeW5CNfwS5iWWRCcyy9K+3auYz3kvFFvnTDn25
	 vMZFomUdJBP2TNSrOEvM9Y3kgdMmBhI8EGkeWkS5zqE1yMMVTeTuBN3o4TOeMFdfYz
	 4EWOU+6odDe5w==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH ipsec-next] xfrm: prevent high SEQ input in non-ESN mode
Date: Wed,  5 Feb 2025 20:27:49 +0200
Message-ID: <36514f25843ca070b2820c650a5510cb158bbd41.1738779970.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

In non-ESN mode, the SEQ numbers are limited to 32 bits and seq_hi/oseq_hi
are not used. So make sure that user gets proper error message, in case
such assignment occurred.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_user.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d1d422f68978..784a2d124749 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -178,6 +178,12 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay seq and seq_hi should be 0 for output SA");
 			return -EINVAL;
 		}
+		if (rs->oseq_hi && !(p->flags & XFRM_STATE_ESN)) {
+			NL_SET_ERR_MSG(
+				extack,
+				"Replay oseq_hi should be 0 in non-ESN mode for output SA");
+			return -EINVAL;
+		}
 		if (rs->bmp_len) {
 			NL_SET_ERR_MSG(extack, "Replay bmp_len should 0 for output SA");
 			return -EINVAL;
@@ -190,6 +196,12 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay oseq and oseq_hi should be 0 for input SA");
 			return -EINVAL;
 		}
+		if (rs->seq_hi && !(p->flags & XFRM_STATE_ESN)) {
+			NL_SET_ERR_MSG(
+				extack,
+				"Replay seq_hi should be 0 in non-ESN mode for input SA");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.48.1


