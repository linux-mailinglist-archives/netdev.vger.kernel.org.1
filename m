Return-Path: <netdev+bounces-70801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D790D850792
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 02:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A311F23704
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 01:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66DB15B3;
	Sun, 11 Feb 2024 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b="nq903s3B";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JVYJlL6S"
X-Original-To: netdev@vger.kernel.org
Received: from e234-3.smtp-out.ap-northeast-1.amazonses.com (e234-3.smtp-out.ap-northeast-1.amazonses.com [23.251.234.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226415BE
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 01:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707615531; cv=none; b=V3HGVFno/wuGQ0W/LoUIN8XVY6HIX+Nx6jUqYDvI4AMW7iBmO/Usd7Y6GqQ9/tEK8Gg1JrzXXYJVL8ubo9QQgEiUpNLb1UDaCN4Iqc1BKARu2KJU7PQcHWMJgkdFGeblAjJKtfrUXIBvRgflTNojRFUwCXRLAdK7sgOtJAHRy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707615531; c=relaxed/simple;
	bh=I5guIR8VcrkzT9xLSP4mWAmUGulq2K/WIqt+tT/uhDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyrOQsx9i7QSzt95TROG6UDVuxXyHjPMLwnTNj3g7oGY9/AgvC4sPchASbLQOMEHtTt3c9tE08Fkhdpk2cJveg4thLUeUYLkaaehbwDzGMH5iF08YVSOaurcAyWQ2O9Hl0oFIOAWAa+Cblj+tpp1EglL+u67skZxyFkNZSw75GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com; dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b=nq903s3B; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=JVYJlL6S; arc=none smtp.client-ip=23.251.234.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=otpfqkfjftndw3gmuo745xikcugpdsgy; d=hrntknr.net; t=1707615528;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I5guIR8VcrkzT9xLSP4mWAmUGulq2K/WIqt+tT/uhDg=;
	b=nq903s3BWYR+htUf21O7PNRR7xreuhOpBFlurG7N6NgNs82K4btBe2AeYzaUonkI
	SSWTtwiLsQJK7jwGixwgyBPQ/PaKzX52c2gXIAyvOPe05MUtfWj8gD+ET8MVgNttQUh
	LBa7qCbEeOdMA0e//CCT2VVt8CPL3q4quGHmDTJNWhBXceZRG55iTKx6Ie71jyNMhUZ
	Zw5bVbyC53oCdW9UR69CcRPBUlD3dFSqp/tdTpY6rN1w47F19sWNFdPOPZvXThydP6A
	lGcdmFbTyqZ9gP5TJD6qsSaAPU1JuR4jHOzKBVoQNwITbxO9eV6VlHl8Gb44pE63NQ2
	DV1rS9xVBQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1707615528;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=I5guIR8VcrkzT9xLSP4mWAmUGulq2K/WIqt+tT/uhDg=;
	b=JVYJlL6SU4+LdNbuIK5RDiRkRFv3qse01GQ/XwmxIpBo2LqRvVudbhcnIGHrOrGJ
	XA0jXczMyHbCVXfS6UQLAl/DLP98YfjSHEKy4P58AnQ+cHU/FpEINxphGNHwDCED8ic
	GW57nuBV9iocXFPaN8Sl13mjvdKmaRBvIqoLabqc=
From: Takanori Hirano <me@hrntknr.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Takanori Hirano <me@hrntknr.net>
Subject: [PATCH v2] tc: Change of json format in tc-fw
Date: Sun, 11 Feb 2024 01:38:48 +0000
Message-ID: <0106018d95d12587-2a5518e8-5e89-4d5c-b7d5-93455429cb1d-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240210092107.53598a13@hermes.local>
References: <20240210092107.53598a13@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-northeast-1.rx1zlehJXIhTBJXf7/H1gLdwyBf0eKXp6+AKci1nnIg=:AmazonSES
X-SES-Outgoing: 2024.02.11-23.251.234.3

In the case of a process such as mapping a json to a structure,
it can be difficult if the keys have the same name but different types.
Since handle is used in hex string, change it to fw.

Signed-off-by: Takanori Hirano <me@hrntknr.net>
---
Changes in v2:
 - Modified to use print_nl.
 - Modified to use print_0xhex from print_hex.
---
 tc/f_fw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tc/f_fw.c b/tc/f_fw.c
index fe99cd42..5e72e526 100644
--- a/tc/f_fw.c
+++ b/tc/f_fw.c
@@ -124,16 +124,16 @@ static int fw_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u
 	if (handle || tb[TCA_FW_MASK]) {
 		__u32 mark = 0, mask = 0;
 
-		open_json_object("handle");
+		open_json_object("fw");
 		if (handle)
 			mark = handle;
 		if (tb[TCA_FW_MASK] &&
 		    (mask = rta_getattr_u32(tb[TCA_FW_MASK])) != 0xFFFFFFFF) {
-			print_hex(PRINT_ANY, "mark", "handle 0x%x", mark);
-			print_hex(PRINT_ANY, "mask", "/0x%x ", mask);
+			print_0xhex(PRINT_ANY, "mark", "handle 0x%x", mark);
+			print_0xhex(PRINT_ANY, "mask", "/0x%x ", mask);
 		} else {
-			print_hex(PRINT_ANY, "mark", "handle 0x%x ", mark);
-			print_hex(PRINT_JSON, "mask", NULL, 0xFFFFFFFF);
+			print_0xhex(PRINT_ANY, "mark", "handle 0x%x ", mark);
+			print_0xhex(PRINT_JSON, "mask", NULL, 0xFFFFFFFF);
 		}
 		close_json_object();
 	}
@@ -155,7 +155,7 @@ static int fw_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u
 	}
 
 	if (tb[TCA_FW_ACT]) {
-		print_string(PRINT_FP, NULL, "\n", "");
+		print_nl();
 		tc_print_action(f, tb[TCA_FW_ACT], 0);
 	}
 	return 0;
-- 
2.34.1


