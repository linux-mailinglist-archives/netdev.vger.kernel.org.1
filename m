Return-Path: <netdev+bounces-122452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDE961645
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2062B1C236F1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7418B1D31A5;
	Tue, 27 Aug 2024 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7ywF6uF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A81D2F7A
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781798; cv=none; b=JULNRUrvZk236U65MvWoC0pBvkdzegbP0VFOUd33mHNq5M0wormuwkSysAWocoLFB/BPd8xPQz52jAiQsGMpqSmBUHVvSqO+WlJZQd2ErmOARZRsquCS2/fJTkmpNISWc+sn93WrjlN2pli2lwYzspKTVBJjHFvX6jTGc+k59D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781798; c=relaxed/simple;
	bh=FF9mY4DOg2BPKdXJQ5eiGZaB0qoS+e9hXmMBLwt7B7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmH9tFXhWAbm7/MiIp0yDHRYSfAlr6DPPvwdH1iyiRZiGxHLfylcm00l5mnoxfBJLe9jExQ2kWTlAAFM5Bv/+Hv/8aMTXkxpDwuftmpaEfbYdj4KhIIDcdIku6WsyAODbp/jGyDbba0zv+/ehoICCCNLVkv5ofKYMS+c8IvBHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7ywF6uF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724781796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzGuFcOvuGGjMxt0Vp2I5r88XrXxRE/WxxnSQWtNRbA=;
	b=b7ywF6uFdn6C4iklOWyAGcL6FuMDPWSTTmzxrLx+GY6B/bmmjTSHvUc4DdnE9KEZ3TI5sh
	xx8rZHDsY2ggbqPvFKwMWn+FwRNtUOXvKQ3aQDFBbrPLqRIced7Na5DgPFmxU1+lYa2xgX
	GSYqNsJFAjIqDWevCYtvxngd4QIl8Zs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-hggUF37uM7-y7lXoaC8zdg-1; Tue,
 27 Aug 2024 14:03:11 -0400
X-MC-Unique: hggUF37uM7-y7lXoaC8zdg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 770E21955D58;
	Tue, 27 Aug 2024 18:03:07 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B92D91955F1B;
	Tue, 27 Aug 2024 18:03:03 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	agruenba@redhat.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	netdev@vger.kernel.org,
	vvidic@valentin-vidic.from.hr,
	heming.zhao@suse.com,
	lucien.xin@gmail.com,
	paulmck@kernel.org,
	rcu@vger.kernel.org,
	juri.lelli@redhat.com,
	williams@redhat.com,
	aahringo@redhat.com
Subject: [RFC 2/7] dlm: fix swapped args sb_flags vs sb_status
Date: Tue, 27 Aug 2024 14:02:31 -0400
Message-ID: <20240827180236.316946-3-aahringo@redhat.com>
In-Reply-To: <20240827180236.316946-1-aahringo@redhat.com>
References: <20240827180236.316946-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The arguments got swapped by commit 986ae3c2a8df ("dlm: fix race between
final callback and remove") fixing this now.

Fixes: 986ae3c2a8df ("dlm: fix race between final callback and remove")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 742b30b61c19..0fe8d80ce5e8 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -30,7 +30,7 @@ static void dlm_run_callback(uint32_t ls_id, uint32_t lkb_id, int8_t mode,
 		trace_dlm_bast(ls_id, lkb_id, mode, res_name, res_length);
 		bastfn(astparam, mode);
 	} else if (flags & DLM_CB_CAST) {
-		trace_dlm_ast(ls_id, lkb_id, sb_status, sb_flags, res_name,
+		trace_dlm_ast(ls_id, lkb_id, sb_flags, sb_status, res_name,
 			      res_length);
 		lksb->sb_status = sb_status;
 		lksb->sb_flags = sb_flags;
-- 
2.43.0


