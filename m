Return-Path: <netdev+bounces-75104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E058682E2
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF54B2215F
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA4B131E5A;
	Mon, 26 Feb 2024 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pagb6Spr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9436131739
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982430; cv=none; b=eTvQNvQtkmBYlQ6rLBF8a5pndHOCK3iHVw5xMD2nH+NLbvBeZGQx8tmcuGT1tlw4xT7NH2KD1o+7o6NBc0JgD+xTNRW611HFhhHW5r1ySHlfqeSodGpZznIEih3F4p31tQwzE2BxTgQZaOuBmGhpeWK9VZhqD69Q5PIOwpDoRoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982430; c=relaxed/simple;
	bh=3m4tpVEuLWeMx4iO2ks7IAiO72eHCXKYksI3Pm3BULc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRUhLD5a23dROpwV7sTnuYKc69rJZQMVeu5bYEfvY7aTF7GMnmqeX64E5l63SjV360B8osa5dcIyyoRFO+vqc+N6V+gDoVSEdvdqqM64y1OkXmf4SOAwTwzscwAR23vcSRQIFRJKIMxRjThoJcPTm8oLCrj2ldhBggeQl//0XsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pagb6Spr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACDAC433B2;
	Mon, 26 Feb 2024 21:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982430;
	bh=3m4tpVEuLWeMx4iO2ks7IAiO72eHCXKYksI3Pm3BULc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pagb6Spreu/kltOjkk7hsQFXCC71utHkcvJ0b3eAZCqiBBzBxdnyfqhzGrpdEsv8F
	 7K2vc007M3wRFJciZ7u/+/A460Hps78XYmTEK9J0DfN/u+uYCLHaNKEOpVAMAc3Ajj
	 bkDvk0X/2XWZrdV7EXqj3vaWJs2UEyU5iJkH4WNX+9cIDu57/9liNa23WQOnqVI04C
	 mNlaXhkJGH1X2UUCpx643RSpFcinVZ8qSkZeYAQwTGxjHq+X/qhDM2HNI6/10W6FKG
	 9YSgmPD4QEGVMbcN3OUPD1zC77BQSeaLoJa8tlu9aK4g9ibJ0TnzZA9PFvR0VxtacR
	 0vBnGqZEc6Z6A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 05/15] tools: ynl: create local ARRAY_SIZE() helper
Date: Mon, 26 Feb 2024 13:20:11 -0800
Message-ID: <20240226212021.1247379-6-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226212021.1247379-1-kuba@kernel.org>
References: <20240226212021.1247379-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libc doesn't have an ARRAY_SIZE() create one locally.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 3 +++
 tools/net/ynl/ynl-gen-c.py   | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 85970df350ee..c893fd5aaf27 100644
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
index 90d7bf4849fc..407902b903e0 100755
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


