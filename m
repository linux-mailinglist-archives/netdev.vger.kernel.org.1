Return-Path: <netdev+bounces-155021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19239A00B0C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350FA16404C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183301FA84F;
	Fri,  3 Jan 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdOceuwI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6421FA156;
	Fri,  3 Jan 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916657; cv=none; b=DWzAaMyPeSw+UuCT4ff04rjrSy9B+TuuFL8qb/rZo5cfH336oDB1ZKDqohFNLWOjd/lUTSVT0MkHqob1983Yuk81maHG4KapVQjBb2clOrVwq1C9W0wMdb4cuKKTExyG/oXs0IP+QBYlz0a2Mic3na4X138ZfTKkdts/qjvZn2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916657; c=relaxed/simple;
	bh=hTM4fY+CEchNJukG0pdAy3y7/+l6QgwDz2y9uH7R7Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3ikYqfyQuVrPq8sQhhQqzdzuq3juU7ea3HGAtBICmkm7308sSqN5Y9/PBeRlpvAm+ce0Q6DznigHEOPwdR4X/pQs466epCfraqorA/2U9bLi7PaJ0Xg5nNViJsg1Q7m0YJEsEce53Yp4KY8UwfoQuBewRSpRAMuQ/r+a19hdR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdOceuwI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21669fd5c7cso174498945ad.3;
        Fri, 03 Jan 2025 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735916655; x=1736521455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiVDEzJGRG7GNszOmxw0+7tPL+XUGWUYLAewIjAaUDY=;
        b=hdOceuwIdkc1aQXJu9cvPi9h3tXYFlf0whXR/FVgdEHaj5SWJZ2KkYe2s2TNG/NyHw
         W5/EMNW0C/Qj666MwoBTe+dDWptHVZYKOGLsKzTwVLV0V4SrMOoURAsMRexfVd3avZ20
         GT1MYd1xtenSx7wd0TxAKfGuaWMnJDkfQ6fwSWw7yssYs3cg7X8FERNEjZ39iMnJK0sl
         KpyO+9UulwFpI3vTgarUcKDEqx3JMl5EEstGT1DpIMAORJQpg0n66IIclT4fK0SYbyEF
         9ysW4u1u44XKpb37ozrjbgsBa2jqYFtK1I5Xt8LjqPnyHYa/KXERB3wfOMI8AqZMxoIE
         mw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916655; x=1736521455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiVDEzJGRG7GNszOmxw0+7tPL+XUGWUYLAewIjAaUDY=;
        b=OruGjUB2H+2KxlKGVRWqf4MgCzj70P3yZz9vn+Bg4zuJ06rFcsVbzs6ykBwQG2t1bF
         Y/w7zMIoPg4MWvJ6x1r9lijt5j2593AJT3y6e65XUPufP+d3JVlHYEOKKG7UX544NM68
         DvpRyG1CzJYKzAasKH2i2oOMZPzmUMLqqgvTCkCqwzG+j2Z9LrlabSSDtcIta2pYhkcC
         4j5IfNLnzkuhIgi549hvqDLi31YabAOWEgNEjZRwDyTnjsdKCVLgXekSO+RviJwNzDdJ
         NgSmxOhhLFFppLQRUU4lUiiSA1Md5pT847Y7mTZbb/8b30YOCm9tCWmTzj0QwtD5Uz6+
         zx/w==
X-Forwarded-Encrypted: i=1; AJvYcCUa+qiiaJMoH/R7ZSUOkSJaCyPbjDuFtyzvj8G4Afur7Rbd7JygcEgXNu6kc6UGZqzHWxG7NKvy@vger.kernel.org, AJvYcCWz8K1wg5E6QXmpQIC/Fp2P/aWWu06bbwsHc5ECenDEDTV/MaQ9mgx7FftXzOR3IQqTwJfcma9wEP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU6t/3YWnSbifJIR8dNw72vNy2nxw6WTIlRwWF4L+dLm0jIUyN
	8CW1pnkAah+TzNVB7Pcgg5I0DK9rsX3AwC57gHkpCFLWkaTueOJG
X-Gm-Gg: ASbGnct7kmwuPZJRorRk6R0ScHhl10rbm8vlIWdBgfefwY47pdig9F5FRk6yjJbOC01
	77Xl+8E14ad55iQMyRimomhVmL0EZ2/JLMqdb99RyU10dqdq7Tgiglmo6AuxYH5D7W2ZRwOlH5I
	g42yaV0SK45aGE7mEhloCBDRYciyIM33cr5G8+fkDLGyiuS+eUNzYSnc8/1vO6Q5YcqKSFjmShj
	26XLbWWSq937JCTAfBc9TNu1tHSd0vc/xZYrtqVD2w8Iw==
X-Google-Smtp-Source: AGHT+IGBrlHa1J1iboiih9dgBvP7s9cGnNOd2xYQbbtLPyR+HgUG/VcODg5fd6JwTzoXBXRLwTGLxg==
X-Received: by 2002:a17:903:1209:b0:216:36ff:ba33 with SMTP id d9443c01a7336-219e6ebcfc7mr648739525ad.26.1735916654653;
        Fri, 03 Jan 2025 07:04:14 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629d0sm247047255ad.41.2025.01.03.07.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:04:13 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v7 04/10] net: ethtool: add ring parameter filtering
Date: Fri,  3 Jan 2025 15:03:19 +0000
Message-Id: <20250103150325.926031-5-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103150325.926031-1-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the devmem is running, the tcp-data-split and
hds-thresh configuration should not be changed.
If user tries to change tcp-data-split and threshold value while the
devmem is running, it fails and shows extack message.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v7:
 - Use dev->ethtool->hds members instead of calling ->get_ring_param().

v6:
 - No changes.

v5:
 - Add Review tag from Mina.

v4:
 - Check condition before __netif_get_rx_queue().
 - Separate condition check.
 - Add Test tag from Stanislav.

v3:
 - Patch added.

 net/ethtool/rings.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 9236de041271..bbb43322845f 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -252,6 +252,19 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	if (dev_get_min_mp_channel_count(dev)) {
+		if (kernel_ringparam.tcp_data_split !=
+		    ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+			NL_SET_ERR_MSG(info->extack,
+				       "can't disable tcp-data-split while device has memory provider enabled");
+			return -EINVAL;
+		} else if (kernel_ringparam.hds_thresh) {
+			NL_SET_ERR_MSG(info->extack,
+				       "can't set non-zero hds_thresh while device is memory provider enabled");
+			return -EINVAL;
+		}
+	}
+
 	/* ensure new ring parameters are within limits */
 	if (ringparam.rx_pending > ringparam.rx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_RX];
-- 
2.34.1


