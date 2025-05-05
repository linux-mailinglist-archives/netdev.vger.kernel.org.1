Return-Path: <netdev+bounces-188149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A23BAAB772
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6F74E286C
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3C234568C;
	Tue,  6 May 2025 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSfbiVJr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B342F3676;
	Mon,  5 May 2025 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486942; cv=none; b=pK5SVtutyd9pErXt9GnaR0gJ5weWGIjauRLKQM2zTmFjs6tzzSYfABmSxtrjvLFdOJYXmwcUfEw+hM3q5e6QL/tHk/OM0aAs8deNe1Eo6pIV2FWMNMm3oqYh4t4aadtixtG/W+2ta6yN5pU9SBwDzN1baYrWKvHDKWc2nU1XApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486942; c=relaxed/simple;
	bh=naximBUSjgAyJt61O8PSusdEFY9hAobTJ9zOocSMYUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bA77VHpgeJBKzyoU1ZxJup5HYnEvZUWzmLhSmRlq1HbcrLeMmDZcxaWpABCvpL2Db5z8Z176UvIs+BoU6gMDV6hbWZIeM6R8mZDfyRr14ss+xZBkF6G7nLRPzBWJkISw4E47Y92VReAvAKZd/CchN/1wEiFVRhN5mqdUJkda98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSfbiVJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC94C4CEE4;
	Mon,  5 May 2025 23:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486942;
	bh=naximBUSjgAyJt61O8PSusdEFY9hAobTJ9zOocSMYUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSfbiVJrD+8WJ0UD/gmYgcqqULsJTpVrmXnxAx5F6acHO6Bf4GSMWVpzThoGS5cNB
	 0e5DnHgBWdvRGX2XiOo/SqoyzfiVu8KZrn4Nqa6wTIsRk6+dx521Jw+nF+ixKWD4zn
	 ilNhYnGOoznkhDrdbe6226LeFAnfaDWm0NnoWoS9VxxnbzBSdjEDQicA5JDVMfViE4
	 TSViYUmil+2YGtfG7YhshZL8pXYeL4vn8ytGkNyZ3S8Pcquw0OnUIjSlXwSslFxQcF
	 nybcc3HEVNa7VA5FlgYco4hciBHkDg0dUkV1aytBo1eqF1YMORw3avtcgLcE7TFDg2
	 iclxQQ61Xik1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 070/153] net: pktgen: fix mpls maximum labels list parsing
Date: Mon,  5 May 2025 19:11:57 -0400
Message-Id: <20250505231320.2695319-70-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Peter Seiderer <ps.report@gmx.net>

[ Upstream commit 2b15a0693f70d1e8119743ee89edbfb1271b3ea8 ]

Fix mpls maximum labels list parsing up to MAX_MPLS_LABELS entries (instead
of up to MAX_MPLS_LABELS - 1).

Addresses the following:

	$ echo "mpls 00000f00,00000f01,00000f02,00000f03,00000f04,00000f05,00000f06,00000f07,00000f08,00000f09,00000f0a,00000f0b,00000f0c,00000f0d,00000f0e,00000f0f" > /proc/net/pktgen/lo\@0
	-bash: echo: write error: Argument list too long

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/pktgen.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 5d5f03471eb0c..28417fe2a7a2a 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -896,6 +896,10 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 	pkt_dev->nr_labels = 0;
 	do {
 		__u32 tmp;
+
+		if (n >= MAX_MPLS_LABELS)
+			return -E2BIG;
+
 		len = hex32_arg(&buffer[i], 8, &tmp);
 		if (len <= 0)
 			return len;
@@ -907,8 +911,6 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 			return -EFAULT;
 		i++;
 		n++;
-		if (n >= MAX_MPLS_LABELS)
-			return -E2BIG;
 	} while (c == ',');
 
 	pkt_dev->nr_labels = n;
-- 
2.39.5


