Return-Path: <netdev+bounces-149669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7479E6C57
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C00016E9B5
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D472E201036;
	Fri,  6 Dec 2024 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="M43cOeYo"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8AB20102F
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481068; cv=none; b=gWPUcBrK4Gs0jizCA2YymewlxvK3Ojku9y0PnS2IczMfGFCuSbEA9AXKxdbQtaFNGsP6PXJoVDITJDOBuhL+98YQI/HKEAe8tTVEK7Vthnoe+gpB6G7U/v3Y/zKHr26L62vRx6DeC6c4U+4ky2eOF5bwIXqQnP+bFPTW2Q+XTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481068; c=relaxed/simple;
	bh=wC6a+ChsD6IhVMWBVHRpM0RPp5o9ufethiV6stIsLCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqHaSDmQMsPhEuu+DfcatIzsJuVdsaVdvI5u/2w9ht7EntyWsy6YqvAtxT23groMcgZbQ5j71MFt00hdLh0LKCTr/+OCeqpC7zzyIiVHRI+31qIu5pR0Qdq5JxW3ckRSQVjw/6LEdkv7Y7tHghoDjaYk1EKsMFYGvADnVYKBAZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=M43cOeYo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=feueyYy5EHoo9KUpy5AJh3SGdxqLmt4BKls8dt9mphM=; t=1733481067; x=1734690667; 
	b=M43cOeYodb5irHesB/Fem6QoUPdHs2mfXTx6q3SuM0I60DW/K7zBFIiqw7Hdlw6GsExmdyzO9kd
	mrvGQN9V7MLMB88k14DqvRrXNQLgRrRA4tLTTVUwR2+2mPANDqQtmcl8RyUN7bBVRvWLHgmuKgMMF
	P7sYfjaM+yKuhGu3hSJeo1Pu80xDx5yxpdWT2j/IbpuFaBUH9XxkgNViaLJim5vlVHqbgZiTUBvlA
	A7tq2m6Ow+AByJGCmPfiL9qyqgUpT7oVL2uif7CD7RelhXVr3FGosBe57SYnLKU2jwsUsvT9BsVMf
	d3fIg/nhfxWTb/odw5OTboN8/8Gl3Y+S/nLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tJVbz-0000000FWya-2aCr;
	Fri, 06 Dec 2024 11:31:04 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next 1/2] tools: ynl-gen-c: annotate valid choices for --mode
Date: Fri,  6 Dec 2024 11:30:56 +0100
Message-ID: <20241206113100.e2ab5cf6937c.Ie149a0ca5df713860964b44fe9d9ae547f2e1553@changeid>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This makes argparse validate the input and helps users
understand which modes are possible.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 tools/net/ynl/ynl-gen-c.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index d8201c4b1520..50ec03056863 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2635,7 +2635,8 @@ def find_kernel_root(full_path):
 
 def main():
     parser = argparse.ArgumentParser(description='Netlink simple parsing generator')
-    parser.add_argument('--mode', dest='mode', type=str, required=True)
+    parser.add_argument('--mode', dest='mode', type=str, required=True,
+                        choices=('user', 'kernel', 'uapi'))
     parser.add_argument('--spec', dest='spec', type=str, required=True)
     parser.add_argument('--header', dest='header', action='store_true', default=None)
     parser.add_argument('--source', dest='header', action='store_false')
-- 
2.47.1


