Return-Path: <netdev+bounces-245282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F71CCA7C7
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 07:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C17B5302D582
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 06:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66E329376;
	Thu, 18 Dec 2025 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqKyUEXf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C3329C6A
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039743; cv=none; b=QwLCL99rbBarTPXea2y6HmOsRCeMKwdm0LGMnZh5B0pZ6AjU7HFQ/2SBxww6B/v2c4mzsrOINm9ybXbAhiw0CtWQF+cUd6LpYZl8fIpd6udDH7CjGGXUC5KiTgA+TRLFhfyFhYPcxbBUwh5utsq3rz/kF73aDt1CdtlqI8HDEJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039743; c=relaxed/simple;
	bh=9pG1kIWkXMjIVH6mjO8VQg8g7XNDxmEr7Vd5Kye1VSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KG10h2yOBSq7OzR81J7jJXRkt6KmLf4BqjRF7pYJz1xGuAcuBmkqKFoyZu1wu/drohMk/1QBSc3O7fqj+cdPdQyNh7XWa8Tyd/H9WQD+hzRrhwq8HIxAt82cJAYYuC+LroWDtln5dhldOqurDJK1u4RjrBI645XSHVinfmOc48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqKyUEXf; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4f1aecac2c9so3018581cf.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 22:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766039740; x=1766644540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zGRJ7a3IeqzAigwVIl1G2eWAbLLevGhMz6Z9M3NSQXo=;
        b=GqKyUEXfXo8RZUJLqk/H22yXmjOM2VlrKFXiExedHwgK11294Ctf7Zt2cfW9mJWnMw
         MZvgRTsNQUpCom/CvBZa63TZHu62h0G5HN8ASCpPRyyaUxo9EsVqh2VSs1QJyaBhNiLW
         /+j1YOZ3d5HbGnPN6If74bpO7XbTW9/8KpkPRhdB48IoH7R13lhvrAGsa3GJWQ/StA85
         oqeGFDhCOn44ZTUW8pOniZFxVO6y+Zd2P05GTt2yAnEYXvVbD9OwXR77hQdq804hu0YN
         ZMGSwKItmKma/ZhYUkPjZ43d4UsZ/p6bbQ2iKesa5hwwQKGiatTczvR8fWI1VERwtsdR
         2tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766039740; x=1766644540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGRJ7a3IeqzAigwVIl1G2eWAbLLevGhMz6Z9M3NSQXo=;
        b=HPFcvSIPL3JfuyQZ+7FTGzkWiWoccPuZA0IrsgWNpxJJlCV38mOvK9tuK6Hh5G5cyM
         ycZzQwBTF4Gd418I8/ADoIpiUSSUimNe99qmq+Vw6bc+6MH9iez/yAzfsxERfnPvNIJq
         EewZDaDESJv/0KIEQhZF5PNNCvbVIj53blDrZw20Y5mA2/kDdXJLtqVf1vdx7d9/iSjo
         SXXLl1auJhIrBOfEkWbfO8LWAL0Zd8EftsJKCcrQ7D2w5AZOS/T6b1FAqrZIF6KVtBgU
         faTAlOJyk5O6PK8bhPouPJijk92mlGTC8lCcQgbSPLseYuyjJga2ASVjmMrZvmoc+5ie
         YZEw==
X-Forwarded-Encrypted: i=1; AJvYcCUPNR209B2i+4xcKGilQ/03CGeWkbfBYPXrpSj70GQ1XhfZl6x5qlltRFj+0I3jOlPpWGS2Ndo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuXD9dbbeMCK+E6yUo2UC7LmnOo/vSYrCzaPRBJNBoaUjDLwz
	AggcNTxECmmjqQY3skSANvb/W0hZfjlr/yES/zzozjRQYfc/qLAoBJgly9opxgGA
X-Gm-Gg: AY/fxX7GcxC7tcqFOhMDdna3Wo8VWHDjr6lyXSfUQnWca7m9v66gMTIuasVUozwblYD
	QIIo2CoDC/+xzZZP8kvA+XIYZZ0srWgsN4iivPe0rhYsQcjAuuLS3XDOh9s7pQ6Ir0F/+dFMZFx
	cHLZ1Ff2BaYlcPrDOJrKrk9SQYbbyF2hR+Z5UhsunfL6nM1vsbtgPS/Wknl5nxk9G8lI1SAb4oJ
	4TiIQSzbLhmAA7moNG/Op7zFNrOFbvFowh+1+czIgI52Oan+F2+YyIkGjLjwObO65frcSXhEoqc
	g03L3INJdkrWl5GYfUTN0lRrWz3lWbDXCqJ32OBQOB/MWulL1u7LfBUNZfPuIAKxjCOIGpDBFbx
	k8kjK87ItWuhFVniNKvubgCOGo2NIMC7Z0PrY3a5sgI85SMTTjZGmP+jSz12TF2Tr5+Ci42HPPl
	8A2g0zLMkOmIc=
X-Google-Smtp-Source: AGHT+IGYIHAW3nPGzo47m27bNrScNDFBaV1o6DunxcTyMRjHDlriB/Dh3QvCKFippaVaxsDF28jRkw==
X-Received: by 2002:a05:6a00:a210:b0:7ab:2c18:34eb with SMTP id d2e1a72fcca58-7fe0c0fd913mr1584640b3a.12.1766032197769;
        Wed, 17 Dec 2025 20:29:57 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe12128ea4sm1046399b3a.27.2025.12.17.20.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 20:29:57 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D032B425580F; Thu, 18 Dec 2025 11:29:54 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	bridge@lists.linux.dev
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net v2] net: bridge: Describe @tunnel_hash member in net_bridge_vlan_group struct
Date: Thu, 18 Dec 2025 11:29:37 +0700
Message-ID: <20251218042936.24175-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=bagasdotme@gmail.com; h=from:subject; bh=9pG1kIWkXMjIVH6mjO8VQg8g7XNDxmEr7Vd5Kye1VSU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJnOTauvrPurdnCSTmmGW9P5D7xt2xbHzzrMH7dfePeGH dOe92z50VHKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJ3HZiZNih6pi/QO23ClO1 6pFNBlVaZq9ZZn5Kenz4X8+RrOObV8czMux3Lv03tbD0WwSnamH6hJcMlekytR37DE4LyWTXPlY 25wQA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./net/bridge/br_private.h:267 struct member 'tunnel_hash' not described in 'net_bridge_vlan_group'

Fix it by describing @tunnel_hash member.

Fixes: efa5356b0d9753 ("bridge: per vlan dst_metadata netlink support")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
This patch is split from assorted kernel-doc fixes series [1].

Changes since v1 [2]:

  - Apply wording suggestion (Ido)

[1]: https://lore.kernel.org/netdev/20251215113903.46555-1-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/netdev/20251215113903.46555-15-bagasdotme@gmail.com/

 net/bridge/br_private.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 7280c4e9305f36..b9b2981c484149 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -247,6 +247,7 @@ struct net_bridge_vlan {
  * struct net_bridge_vlan_group
  *
  * @vlan_hash: VLAN entry rhashtable
+ * @tunnel_hash: Hash table to map from tunnel key ID (e.g. VXLAN VNI) to VLAN
  * @vlan_list: sorted VLAN entry list
  * @num_vlans: number of total VLAN entries
  * @pvid: PVID VLAN id

base-commit: 885bebac9909994050bbbeed0829c727e42bd1b7
-- 
An old man doll... just what I always wanted! - Clara


