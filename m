Return-Path: <netdev+bounces-206344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6E9B02B85
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 16:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B12F3BD998
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A17283C93;
	Sat, 12 Jul 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQh4Yzng"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59DB27935C
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752331873; cv=none; b=AkT/2n0A0SiU15I/6fEfVGVw+J9aSZc2o4TMpKumbZq6KjDoh/iafeuRwftQNR84ruvStyfA35YRSA1zmqBS+79jx54bzs9XxhUTJso8bH48ZiMv47LERsvM3KrnMc77K6BLXUpBFgnvFcXc0zCZE9NI7tygwYuR/rKfMYkBPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752331873; c=relaxed/simple;
	bh=JCQ36ecTRipAMCONtmj+7DvQ43/rzhcePHgld41cBac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HF34aXR98ggQYzuSI0g3VHtpH1Evnpr8wlvYco3KNAp2Q7mwUvWTVlK7nHQ2ZrB06CU5PGPhIzNTdFnRCUlG5IZUYjYE+XU/4rYvLiu7YeuR23TBk3CJDzDvQNyRHa3MCkO3FlBR6Lxi0z5d19wEiHM5LTdXT7T5uBFWmK5xL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQh4Yzng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5433DC4CEF0;
	Sat, 12 Jul 2025 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752331872;
	bh=JCQ36ecTRipAMCONtmj+7DvQ43/rzhcePHgld41cBac=;
	h=From:To:Cc:Subject:Date:From;
	b=cQh4YzngzMI1xHIDPVhSLxLDbRi3MkFIsLi431DRV4DrX3QIhuz2Qgmr8EC2Gaa0g
	 hTfShsPWsRdNpHNlQwTYqFFnw3Jp7OHm2AjkHAcwQTPNsdqWHyiaM+z0qLaT4QRRjj
	 G/3NrnXCpAF2DYNr1Zr1wIYchEkelI4iOBiveAYrvmwr7Q0fyYII1n7nPtjept1nTV
	 INNP4DaeZkc3t3ciVg1kUbAYQffZY7afoM+rIFMimdZYbY71a/C9kWLxUnCIvmDt2c
	 Pn68+1o2jQNwncGPk7EQHw3U8O4a5kSgGKojY+4+0aD2Jz4PyIF4FGbE+g6a2Mei1Z
	 99inIe5zcXL1g==
From: Jakub Kicinski <kuba@kernel.org>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	ant.v.moryakov@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH ethtool] netlink: fix missing headers in text output
Date: Sat, 12 Jul 2025 07:51:05 -0700
Message-ID: <20250712145105.4066308-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit under fixes added a NULL-check which prevents us from
printing text headers. Conversions to add JSON support often use:

  print_string(PRINT_FP, NULL, "some text:\n", NULL);

to print in plain text mode.

Correct output:

  Channel parameters for vpn0:
  Pre-set maximums:
  RX:		n/a
  TX:		n/a
  Other:		n/a
  Combined:	1
  Current hardware settings:
  RX:		n/a
  TX:		n/a
  Other:		n/a
  Combined:	0

With the buggy patch:

  Channel parameters for vpn0:
  RX:		n/a
  TX:		n/a
  Other:		n/a
  Combined:	1
  RX:		n/a
  TX:		n/a
  Other:		n/a
  Combined:	0

Fixes: fd328ccb3cc0 ("json_print: add NULL check before jsonw_string_field() in print_string()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 json_print.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/json_print.c b/json_print.c
index 4f61640392cf..e07c651f477b 100644
--- a/json_print.c
+++ b/json_print.c
@@ -143,10 +143,11 @@ void print_string(enum output_type type,
 	} else if (_IS_FP_CONTEXT(type)) {
 		if (value)
 			fprintf(stdout, fmt, value);
+		else
+			fprintf(stdout, fmt);
 	}
 }
 
-
 /*
  * value's type is bool. When using this function in FP context you can't pass
  * a value to it, you will need to use "is_json_context()" to have different
-- 
2.50.1


