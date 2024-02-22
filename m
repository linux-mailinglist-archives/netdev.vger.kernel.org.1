Return-Path: <netdev+bounces-74198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF938860730
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B88A1F21532
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C1414039F;
	Thu, 22 Feb 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXHwVbCn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3013BAD8
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646188; cv=none; b=Rmi89hQUGyccINk7FipcAuM7vKIMKVb6G7F4bEToiqcdAZxh8Tv40kH94u3FlNat7lHOL5TNwmClzlAOjiYWzycboLJNmxU7I/0mj/r38P5cSj6+95apuS3WO59pzHh8my+VWX0v+3Ay7Bs3SCqypUGpfIg/EYnbVPRJ21rLCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646188; c=relaxed/simple;
	bh=fEsQtt18WHueDXQaMumvvAaKLSRJs3c6bFnRLYTzoFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MItXg580eQVxvaeJQMUsr4W4hkdYqZ5Uqh88ETAUWRX9GQh995FiVszW5Uvl2dpsHedgek0LqQlSnzXvAeE/Qe42m7SmQtghVng2baWynJfxfwt13eGnKLDsbN4tBt544vw+Mc466ELQZJ7JRSekMakiCWrRorHzWc9awErWXHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXHwVbCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09AEC433F1;
	Thu, 22 Feb 2024 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646188;
	bh=fEsQtt18WHueDXQaMumvvAaKLSRJs3c6bFnRLYTzoFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXHwVbCnfhV+8hYnLCkXeoRHpnHdSmuCIvCWs5J4nYTk3AZT7ceOtKN4DJfziRS+m
	 ySZBCHEZZXpeeTt6p21J2wlBA6U4fwNBJ0eBIRat47jBb4CtH0s3BE6z9siXSoChvw
	 3a0J5Kq3sDxGhMdmCv3F17+9tVimnPFf/Kbq+z6zca6xQf9SPr78SkSfSojjoBT91I
	 DYf4nb2rQs0B8gwk3ZkylwoDRlbTfFDrsJvsN+xJke+27yJ8E7J76Nme8ONVK23P3W
	 91MOfpMA79NaNGlwn1bxoPyCc7tpYV+/RTjfwqAD37XYzxFo2TrK9Cneu8ZkRhMgmz
	 Y3foXdzZIxpfw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	sdf@google.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/15] tools: ynl: create local ARRAY_SIZE() helper
Date: Thu, 22 Feb 2024 15:56:04 -0800
Message-ID: <20240222235614.180876-6-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235614.180876-1-kuba@kernel.org>
References: <20240222235614.180876-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libc doesn't have an ARRAY_SIZE() create one locally.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 3 +++
 tools/net/ynl/ynl-gen-c.py   | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 654d1e29c482..0df0edd1af9a 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -27,6 +27,9 @@ enum ynl_policy_type {
 	YNL_PT_BITFIELD32,
 };
 
+#define YNL_ARRAY_SIZE(array)	(sizeof(array) ?			\
+				 sizeof(array) / sizeof(array[0]) : 0)
+
 struct ynl_policy_attr {
 	enum ynl_policy_type type;
 	unsigned int len;
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 7b5635bf4c04..6366f69e210c 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1535,7 +1535,7 @@ _C_KW = {
     cw.block_start()
     if enum and enum.type == 'flags':
         cw.p(f'{arg_name} = ffs({arg_name}) - 1;')
-    cw.p(f'if ({arg_name} < 0 || {arg_name} >= (int)MNL_ARRAY_SIZE({map_name}))')
+    cw.p(f'if ({arg_name} < 0 || {arg_name} >= (int)YNL_ARRAY_SIZE({map_name}))')
     cw.p('return NULL;')
     cw.p(f'return {map_name}[{arg_name}];')
     cw.block_end()
@@ -2569,7 +2569,7 @@ _C_KW = {
         cw.p('.hdr_len\t= sizeof(struct genlmsghdr),')
     if family.ntfs:
         cw.p(f".ntf_info\t= {family['name']}_ntf_info,")
-        cw.p(f".ntf_info_size\t= MNL_ARRAY_SIZE({family['name']}_ntf_info),")
+        cw.p(f".ntf_info_size\t= YNL_ARRAY_SIZE({family['name']}_ntf_info),")
     cw.block_end(line=';')
 
 
-- 
2.43.2


