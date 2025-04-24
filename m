Return-Path: <netdev+bounces-185364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9EBA99EA8
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C402944653F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CA61991D2;
	Thu, 24 Apr 2025 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaU86yJj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED79198E77
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460737; cv=none; b=cxx8SlPQiZZn3cckuVx28z1Hstrm83YajxhZhZtdxSMFs2f/tmjojtGoZ6uWqBV6ipKn8UPo8n08XONjw7SdLyZcz7s33ZhPw4zG0uU5Lq1MiVtzdjUD455T7UU8ditudiZ7jL/JE9ehbDGSwGEfAjGBJAe20LOQnGg9iAMam+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460737; c=relaxed/simple;
	bh=TGnhzEJYoJdrK1y2xQ79ph5O4FlBRVVLEY9VNUUx4dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNaa5T/Th/pBl0jp9QYaRBJTe4iEcP/3NR95Hu3s5eCEkeGHRomM3i/urhK5kpdwoWZCWIhkp0dT6qT4TUjLFSv36MlqUA7t7v7QlEi+4YqzcKfgo8QL71kAv/PK1IJ9N4v57n520c8QK22yE3OUcPuzOsnBauZ+C/nAVN4SVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaU86yJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E42C4CEEF;
	Thu, 24 Apr 2025 02:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460737;
	bh=TGnhzEJYoJdrK1y2xQ79ph5O4FlBRVVLEY9VNUUx4dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jaU86yJjdpp3Ccjy/2KE6FRgo6n/oVinzzKuHSXELTFeRFYQbZUQMOOYBtzEagziO
	 vObQRtUH1ifpnffqToc4FOf1qVdOTEVeiBHN7DEDiQxb2bheVLr970jwA45dbJLaSr
	 /s2396glrOOqvZdt/juhm1z6XLpNv2pLeDOKkEUrqIsVZWztG6KTqRHU1feUR7NhP2
	 W1g76VyVORa0zinlPVlYaMY1ZPPiiQV5jdFfQGbxuslQtSiLzSJ9RIbJi4GfeLpmFV
	 +ViCzePcqBFNggSZXWfWpKGPN6UO9Mh8TjMxj9bbhRnqjhC/VhhJ8PEZgqC9kbVoEo
	 uOJ6h4hdKbIPQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/12] tools: ynl-gen: fill in missing empty attr lists
Date: Wed, 23 Apr 2025 19:11:58 -0700
Message-ID: <20250424021207.1167791-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424021207.1167791-1-kuba@kernel.org>
References: <20250424021207.1167791-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C codegen refers to op attribute lists all over the place,
without checking if they are present, even tho attribute list
is technically an optional property. Add them automatically
at init if missing so that we don't have to make specs longer.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 90f7fe6b623b..569768bcf155 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -938,6 +938,16 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
 class Operation(SpecOperation):
     def __init__(self, family, yaml, req_value, rsp_value):
+        # Fill in missing operation properties (for fixed hdr-only msgs)
+        for mode in ['do', 'dump', 'event']:
+            if mode not in yaml.keys():
+                continue
+            for direction in ['request', 'reply']:
+                if direction not in yaml[mode]:
+                    continue
+                if 'attributes' not in yaml[mode][direction]:
+                    yaml[mode][direction]['attributes'] = []
+
         super().__init__(family, yaml, req_value, rsp_value)
 
         self.render_name = c_lower(family.ident_name + '_' + self.name)
-- 
2.49.0


