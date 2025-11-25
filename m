Return-Path: <netdev+bounces-241488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E82DC846F6
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6913B109F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C412F25FE;
	Tue, 25 Nov 2025 10:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC82F12BB
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066000; cv=none; b=QKSulsPehdvS0vIw5TcuKVx6EbzdFcUzCOwp/FCxRZ6hycN5k2U4NvJyuBrOK49R7wVCkLDz72rdmzhvgem4TQ0bXiZk7eafx4+VzXzrzfGwuJx6U9V4XINjuuLQT6suFgjoZ7LkPlVTua1r3RZiZArfejZTOK1+ywR0NMI2siE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066000; c=relaxed/simple;
	bh=xnhB3QD/pUGnQrTJXaBFG/oDYpB/BeGm+/VZM80nzu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F7NiC/2b88i9sVnkpqyVgJNqC969oPQMn5aejN4Vbp1Fj97qTyHSNFfLNIodjwsR3sLzB8Df9P0ULsVd2dx+ZuZ+c25BzZDEHP1BKFP7mT3nBEHFavG8pp/jYCZ9WxFZS3lzdhgLpzf4RNpK6TSa7+fqJfAQh4vBnmyKIV3J+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3ec4d494383so3222204fac.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764065998; x=1764670798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ul0k1GgM/c5rCraOnK8Dvxg0D7FDaM0Ol4h54SDXmY=;
        b=GthxZrMnvFxjnt5upvd+fAjjvE5wSsJIPrFkgUx/Ovf0/9U2yjnb8Ss/DvgztInVuI
         Jo5/LSpx6PCKPi7xbr7E+DNENDBFegwshdVHsfg8290ADWwI7BcNB1H6u+fzgwZjkDca
         h+sriwhsks5YUyGAGKKgZss3aLE3qerBeuy/raseGxGgHImcTveAaudweej3BeMINX06
         F8Pz92Wy/uJTjwfKFlD/dE4l44Ebv1hBYH2DbnrHT5+RctFWOKMmdKtQQwMbkTvgsXbW
         B6Znm0MXB02DnRjTK8YUhVWOiHPvAQD56NXm58TZmUK6Le3tuKpcsHfplVBZ3HJq80TZ
         tpyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuua1rR84SA3JEqHh/NUwREXai8jmtmvu1ONnSEa1UTvN3bB4HXAKnyIiXhVZX1cNyzQtcYYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGO7tWimlE4OFqCLNanBgLhlDuec3QN0kGKDnR/YrV1QCLz6SY
	2p3bhJueZlY9RxteyP6aIoH3Y8eZZ3EGnzoDG0dsZ1/lu02zVXuDFzgH
X-Gm-Gg: ASbGncuPBNeaDQUnHKc3Ktlyjcr1D/UrCv1CHgsvOl//OdKhVzkO9ctTALvrD0tIqmf
	B8FOH5uYXWo3AVBC+Cy7ohMQBOvc+TK6aFSjGZXnfw3rbXSLU1hhyiqlueDADMavyJ0nqoDQgd5
	gw+6vsPtfC3Nnv9UchmaoM1rc1xa5ZnXkxdglmorRm3fmLivZbtiv2w55qeo+a4r/m7rVX+z7Fh
	TlBTR+SQvsx9xfqX0uMngcg3Zdq5/sjlfghFvVTcjtWgv78h3QKPa+59ADRDDYmW6/GoeeG4a6l
	MuISVDGk6LaXnnkfuMfRr3tXZ2XaBtombD/cgeZPqKGfoeJFqEStL91bbFO5NEhvAXOUUfKYfWg
	p1KVxwhDZtHACTSoQd+VMVl1W0VMMNddMZxb4M6sH702JcxGX/pBwkge9ZDCZ9sYBCYtvgOdQxx
	k+0MpV4n6gnZW03CxNS9HUgyw=
X-Google-Smtp-Source: AGHT+IFtyiOuX8iw1pCACYNN8QG3Yfj2mFNz7FsdX3NPuCOLpPFhjIhc24EJOKd6na0bNrNHM798PA==
X-Received: by 2002:a05:6870:70a4:b0:3e8:973e:e011 with SMTP id 586e51a60fabf-3ed1ffd81b2mr1082088fac.47.1764065997707;
        Tue, 25 Nov 2025 02:19:57 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9dc8e103sm7393177fac.19.2025.11.25.02.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:19:57 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 25 Nov 2025 02:19:46 -0800
Subject: [PATCH net-next v2 3/8] ice: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-gxring_intel-v2-3-f55cd022d28b@debian.org>
References: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
In-Reply-To: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=leitao@debian.org;
 h=from:subject:message-id; bh=xnhB3QD/pUGnQrTJXaBFG/oDYpB/BeGm+/VZM80nzu4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJYLIarQOjd6mqF5tJPKnLM4/NSSLPVvrfC+mv
 DN4vMU/f9GJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSWCyAAKCRA1o5Of/Hh3
 bV1TD/oDDTNgkychPS/hc0OyTMeB+NP0a4nHhkbxqBQkDc9MC7hz8QGJNE8ZGTmo8wAZFarpJjK
 XGSGxwl6f7QnLSx9FbyvhDanDz8boT5Hqptb0ONXknk5cFIl4lSJ3T8oGNdya40mc5oD8fPWkzh
 aGrSBZFkl1FyBnJkDflgBYfYwzuoC0kiGZ1rfQqLhVAW1V82npC4c7OS2RCDcJ7gvyb5FDBKKyv
 582a6QflL/QwzFjOBgqfFrGzXrkm4tTn0qL2jfkc7/BQX1I7ryUjbbczdk8M1tOCU7Sp7+cbCvg
 HsK4nIp2SVtC91B34qC0eCFF0Pqcp6TYpRAxAVqS58/nzpmka5xWIyrsfzM5t3Xh/nNzOXlyOP+
 Z0ybXcOGTW6fANvuzAO2SkRYgWRzUr7BQI8bbza63e5tiUXJByTp/U7bjOyEtXUk4jSs82c0e2M
 Nktj/eY7KlYtAERe6988DtUeSk+uK+qE+FocpeDTfuwWt8OR6qdCjUXCN0K+wtEa86E/922Pq0O
 iXVqN5XfxyRdAiKKgr8BT2SL99pN6Li1cCa9r+u/ML25RhrNmCtchsE7uul07C+Dt+VDl44VHy1
 zDJVOc5jEROWD2MglOOYxLjY453J0yIQjB/cZ5BHUQdqpdimYaQZ4aZIK9WhCYJxFhHl2c1zvCr
 eUFn/QhPrDrhX3w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns ice with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a1d9abee97e5..969d4f8f9c02 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3083,6 +3083,20 @@ static int ice_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	return -EOPNOTSUPP;
 }
 
+/**
+ * ice_get_rx_ring_count - get RX ring count
+ * @netdev: network interface device structure
+ *
+ * Return: number of RX rings.
+ */
+static u32 ice_get_rx_ring_count(struct net_device *netdev)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_vsi *vsi = np->vsi;
+
+	return vsi->rss_size;
+}
+
 /**
  * ice_get_rxnfc - command to get Rx flow classification rules
  * @netdev: network interface device structure
@@ -3103,10 +3117,6 @@ ice_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	hw = &vsi->back->hw;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = vsi->rss_size;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = hw->fdir_active_fltr;
 		/* report total rule count */
@@ -4853,6 +4863,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.get_sset_count		= ice_get_sset_count,
 	.get_rxnfc		= ice_get_rxnfc,
 	.set_rxnfc		= ice_set_rxnfc,
+	.get_rx_ring_count	= ice_get_rx_ring_count,
 	.get_ringparam		= ice_get_ringparam,
 	.set_ringparam		= ice_set_ringparam,
 	.nway_reset		= ice_nway_reset,

-- 
2.47.3


