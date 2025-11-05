Return-Path: <netdev+bounces-235776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAA4C35548
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 12:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FB294F6DBC
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108003101B6;
	Wed,  5 Nov 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Ko0opDpO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409130FC1B
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341616; cv=none; b=VKAXrSfMmLypOfiAIKr3o/98tmLwkI7D8beEU4ejNs0usk2cl0U4jkrcHqiAk2Gw0I2D9V0HDXqjx0hlkMyvv5QJIlXvkibCCmAwv3Uv0B1InhqCmgWELH6//eYSee4g+k7l/Qcd3DTn3pv0l8Fx5tYrPXnrDeTYrWGoarBfveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341616; c=relaxed/simple;
	bh=a401LttyQ75fGtqxWKsOWl7Pv3QSIHLvklmCC6Xv5E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVnaIhvZ3wPmjPtfVLQ75azLyLRS4++PEeh8jdWjlSAqCGpBU2TiCdyafb0wJPpF8lZ+bKQrYbpMjU3QgOFEDLYpqeWt0DzBD+Kb4Lc8Yb8V8gAGneRVsaK3aGlInrw7UxV26MPWpSg6+lbMozTB7VlChZufC6wQT+jM53jTeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Ko0opDpO; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so6155150a12.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 03:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762341612; x=1762946412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXuQLmFLJRmL3IxiXo4AbgeD2yxAF5Mj/ARWDStmAfA=;
        b=Ko0opDpO4dIgc8DdsUoaGCzOmi0OY2dqZwxxEZIcc8FD6yMDC0NVQOjdJ7mFMBtuxO
         8Ev5kZkR2SSKbNzQFS5TqcddMBLHflzBQx4l3h2VMJFB8qKCHBU9VLefjKO7SlReL8nu
         Bp3r7lIdrI3ljlCjeMfV0FVMhN/T8TIj6gEDpLledXTzczzrp1dEqPpx1nc29EOcw+Cm
         EZadqtk6xqSVmtdoLjNLZvcVcRAyo7gMbiqsBmh4bNMVZrh2cF15iJ6ZFTK517Og9dcy
         V91J1iZhqUj8kk/BA79tIqgyvpeoTpmAv+t8El3umXchgX675X0iSX3Eu9HSrCZyc29x
         Oh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341612; x=1762946412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXuQLmFLJRmL3IxiXo4AbgeD2yxAF5Mj/ARWDStmAfA=;
        b=q7Y+PFopcxwoigJRS1D7LksjFGK02kmBxwJjOgAXpN8FC5co6s8ML8TppLwRtpBM3+
         lmOpmhn1cEq01ns8/YTOupClp8Rx2HERKd0WrLWqCsLhOEi7tWctJlLSemJn68j/Aq5C
         WiaKSc6K4dlvTeIMxYfrM7/GrZpX1a68nrQWDg6muqIxbJBJjcLgi/TzhfupX2opQqac
         e/gb+gFaF5JHU9hzez4UgjHEVUIzbXlAxetpegYWI4/sUheEGy8t7SzfArhdqzb3W+TU
         SWUqJ0Qi62sGNPSREzuWPoXR+Tc1J+MxLXr+4npqjUFvJ2NLnVp1CjKt8b7t6Fa3hCa+
         OdzQ==
X-Gm-Message-State: AOJu0YwHQHcf79RrZoGHYxpzIm1+oHieCF6soMXqn/ITK66pZ4dV2K98
	VqAFSK28GztLi2/8TXuNDgFvoiA+3QApYCk1E7d8o8hBRjp3Y+rGm4+6eZ+otBAhmFt11s9mk6E
	jU1uvDopawQ==
X-Gm-Gg: ASbGncubrAEHPMa2Nf5kQart+cf6mAgJPG+snF0Sob6vV4NczDp63eiOymcShiRGXJG
	F0anvLaYIIHPFiJGQ+nyrL0LU/vlvtufdG6KNR/EgjhaDIqWbzHbnxUcssxZT4Abf2GYFG79SIu
	c+40oFCvl8+X/RvUWtYJUJBjQzachSYVKftgzQHDPsHLkeYOevbiYcVehDq+hWMS2uV+iF1TTHF
	XuMMXD4MbIIcANrxDS4wpqC0wAlXhKGIvDKTYwbpc2yuzfNCSW2HVCvXS6LW2Dq13WSe47NWphk
	Q5QYUb7HJvulT9cdu0Hd9leu2R1dCpi1Iz+U+ullRLd2OjKhKUp2vMKQs420KOhY/JH8ejzYRL7
	FtCNUydnIwjHIqZZs+N6dKicuYZs8GjpMQDeeBVw1HErz0sZOV2VI9AGIrr8l5xC1KNJtlFdXXP
	GaPeDai7i3F1Vj8TWSRz23EQ61c+kHINsK6g==
X-Google-Smtp-Source: AGHT+IHTjDVCx2Qm0j6PAJKMcvlD9wlV3gnSH90GhrBjX1D3t7o2Y5SBx2BDZbWvHZ8eBLNWGGFQqg==
X-Received: by 2002:a17:907:97d4:b0:b70:edaf:4ee5 with SMTP id a640c23a62f3a-b7265297d83mr264651266b.16.1762341612063;
        Wed, 05 Nov 2025 03:20:12 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724064d25csm455208266b.72.2025.11.05.03.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:20:11 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	davem@davemloft.net,
	bridge@lists.linux.dev,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v2 2/2] net: bridge: fix MST static key usage
Date: Wed,  5 Nov 2025 13:19:19 +0200
Message-ID: <20251105111919.1499702-3-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105111919.1499702-1-razor@blackwall.org>
References: <20251105111919.1499702-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Ido pointed out, the static key usage in MST is buggy and should use
inc/dec instead of enable/disable because we can have multiple bridges
with MST enabled which means a single bridge can disable MST for all.
Use static_branch_inc/dec to avoid that. When destroying a bridge decrement
the key if MST was enabled.

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Closes: https://lore.kernel.org/netdev/20251104120313.1306566-1-razor@blackwall.org/T/#m6888d87658f94ed1725433940f4f4ebb00b5a68b
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: new fix

 net/bridge/br_if.c      |  1 +
 net/bridge/br_mst.c     | 10 ++++++++--
 net/bridge/br_private.h |  5 +++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 98c5b9c3145f..ca3a637d7cca 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -386,6 +386,7 @@ void br_dev_delete(struct net_device *dev, struct list_head *head)
 		del_nbp(p);
 	}
 
+	br_mst_uninit(br);
 	br_recalculate_neigh_suppress_enabled(br);
 
 	br_fdb_delete_by_port(br, NULL, 0, 1);
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 3f24b4ee49c2..43a300ae6bfa 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -22,6 +22,12 @@ bool br_mst_enabled(const struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(br_mst_enabled);
 
+void br_mst_uninit(struct net_bridge *br)
+{
+	if (br_opt_get(br, BROPT_MST_ENABLED))
+		static_branch_dec(&br_mst_used);
+}
+
 int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids)
 {
 	const struct net_bridge_vlan_group *vg;
@@ -225,9 +231,9 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
 		return err;
 
 	if (on)
-		static_branch_enable(&br_mst_used);
+		static_branch_inc(&br_mst_used);
 	else
-		static_branch_disable(&br_mst_used);
+		static_branch_dec(&br_mst_used);
 
 	br_opt_toggle(br, BROPT_MST_ENABLED, on);
 	return 0;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b571d6f61389..7280c4e9305f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1954,6 +1954,7 @@ int br_mst_fill_info(struct sk_buff *skb,
 		     const struct net_bridge_vlan_group *vg);
 int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
 		   struct netlink_ext_ack *extack);
+void br_mst_uninit(struct net_bridge *br);
 #else
 static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
 {
@@ -1989,6 +1990,10 @@ static inline int br_mst_process(struct net_bridge_port *p,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void br_mst_uninit(struct net_bridge *br)
+{
+}
 #endif
 
 struct nf_br_ops {
-- 
2.51.0


