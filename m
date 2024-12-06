Return-Path: <netdev+bounces-149670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817DD9E6C4C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4BE28A894
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4307720103B;
	Fri,  6 Dec 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rmRrZUOW"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E27320101D
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481069; cv=none; b=pyyI/Kj2JKmV0ZcV9QHjglDTgp8I5rQ1mazwF60jtb5nl0EMElXo1NjTlKH4pEc2vkOqPsabyV3QMycp/JtKCnrZST8mH4hd+gp+RU7IrRSCCCiU/a349Gcqyp0nirKpDdE3EkMx+5hsUmDrNhFWf563mVZXR3bIukaYhr5nEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481069; c=relaxed/simple;
	bh=5wHuSkoTKs2fs8huMIMitY6ncKHaYkO7sSm8q+QCNJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAbJ5ffJfVldpaf0rdyl5yE0EgmgqOzAwaECl33xkLZqaQ/2EvtFCv0rFfM/EthdqHiuJV5HzLIiZ3C5GdGDINzYFxKsytPQf3KeKTrtFAOM5Fas2HLUEs1Agi/+WfN2oLHlwpriy5irNt1ocTIvdhFypLVN5hQDre0Jgbx5oBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rmRrZUOW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DOywnkMYG+BOUZIFGmHoIM9+SasyqyM3GklWGnWOV4w=;
	t=1733481067; x=1734690667; b=rmRrZUOWzc6jbY0//sPdVWJYXrw4uSkxLItvVqiaXtjgPLw
	+zNcl+lzDguIEz8meITudYq3gWNl2LNRlOCN4UBjQOKvQ3xf5k5yZYMw+/Di1pVs2xFiamzaFdb78
	9I3WqzHhTWfLYRYKSIsmDT05cFj0/VkLkse0Xz10xb+/1GAoU5bSA9GYEL3aRi1KjWe0eDUSncjfp
	Cibdfia4YxWbQWY/hfl5sx4dCZwcB0x9xfk303AP4m4JZ69pbqCbySMEymhcJVySDL3wH/U4NI5FD
	hrPacxJCA2Y/wfcJi3n5td/pdhlVtqsIWzcKSKGa86LgNFPryyWrawXldQg/a1Wg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tJVc0-0000000FWya-2RZN;
	Fri, 06 Dec 2024 11:31:04 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next 2/2] tools: ynl-gen-c: don't require -o argument
Date: Fri,  6 Dec 2024 11:30:57 +0100
Message-ID: <20241206113100.89d35bf124d6.I9228fb704e6d5c9d8e046ef15025a47a48439c1e@changeid>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206113100.e2ab5cf6937c.Ie149a0ca5df713860964b44fe9d9ae547f2e1553@changeid>
References: <20241206113100.e2ab5cf6937c.Ie149a0ca5df713860964b44fe9d9ae547f2e1553@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Without -o the tool currently crashes, but it's not marked
as required. The only thing we can't do without it is to
generate the correct #include for user source files, but
we can put a placeholder instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 tools/net/ynl/ynl-gen-c.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 50ec03056863..5df3370bfc74 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2697,7 +2697,10 @@ def main():
         cw.p('#define ' + hdr_prot)
         cw.nl()
 
-    hdr_file=os.path.basename(args.out_file[:-2]) + ".h"
+    if args.out_file:
+        hdr_file = os.path.basename(args.out_file[:-2]) + ".h"
+    else:
+        hdr_file = "generated_header_file.h"
 
     if args.mode == 'kernel':
         cw.p('#include <net/netlink.h>')
-- 
2.47.1


