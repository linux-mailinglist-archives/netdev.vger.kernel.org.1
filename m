Return-Path: <netdev+bounces-194229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F9DAC7F93
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6887B0428
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58071DD525;
	Thu, 29 May 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYkKYfPs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDDD1DB924
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748528440; cv=none; b=jYOAXC9eTWiXZD1NJ6PZwnvqKgqAGe55Klq0LlIjTbt5JhRipq48RhpAU7D0cIeGWE3Pjc78nEer3LUTecjkNLXDl8rD7hRBk/1Esn+jSQoTAPzB8OC+8PMVUWCI80gO963phF+bM4/zRM5INB8caQLFjLE1U8g3E+TSvJU/uio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748528440; c=relaxed/simple;
	bh=T3IP7NfPO2QMuSWEoV1in+80i3UOtoXzbdwqRxDyKus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SekDCqcba0HyYPxBZRKbUdQstfvxGEJv2IGq4+RGGQjL+vhsCSTuabs2QqMxUtGYbduWhuJv7+y+9ePaqUYfghn/OMc0JiyXQ22LYQ6k7LcZAkKWrqvx6gi+vROrtqKmnB8mkzsMK/SnE/chSxYxrEr2rnkVuzVCbh0ZCHHWh3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYkKYfPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF61C4CEEE;
	Thu, 29 May 2025 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748528440;
	bh=T3IP7NfPO2QMuSWEoV1in+80i3UOtoXzbdwqRxDyKus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYkKYfPspu1qsiDLv8Bx5N1TuWUlVZm5ENFNFq4OKgZYT9ACB4m9gOwpvXC0av+SI
	 ZFJWplCH2HbYzN6EsS/6OvFi0gwU9QA710yjU5k7IwRohjiWDgN4lUYHu0h/0FF/yB
	 PpZ1NUJ2mbMFGERgRbDIZIo9Yf1Y+gteX4HYN2E8zoHfQnIbPOS8TN/bCFCUND2wI3
	 0Tyeol3Etb8KSTrkmdyuW6Ac3C9pZKNVIdKhSomSD0roqT89qZ1DGuIsLUNXCYsT1a
	 7siuIDcGRhERunmkzawJVwWM/2fftSQ6dTcwsvPzYVSzW7SAe0HuxfQI/X2Wadm6Dl
	 wnSelPzKdoOSg==
From: Jakub Kicinski <kuba@kernel.org>
To: mkubecek@suse.cz
Cc: danieller@nvidia.com,
	idosch@idosch.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH ethtool 1/2] module_common: always print per-lane status in JSON
Date: Thu, 29 May 2025 07:20:32 -0700
Message-ID: <20250529142033.2308815-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529142033.2308815-1-kuba@kernel.org>
References: <20250529142033.2308815-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JSON output type changes when loss of signal / fault is
detected. When there is no problem we print single bool, eg:

  "rx_loss_of_signal": false,

but when there's a problem we print an array:

  "rx_loss_of_signal": ["No", "Yes", "No", "No"],

This appears to be a mirror of the human-readable output,
but it's a pain to parse / unmarshall for user space.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 module-common.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/module-common.c b/module-common.c
index 9c21c2a55a18..ae500c62af89 100644
--- a/module-common.c
+++ b/module-common.c
@@ -308,11 +308,8 @@ void module_show_lane_status(const char *name, unsigned int lane_cnt,
 
 	convert_json_field_name(name, json_fn);
 
-	if (!value) {
-		if (is_json_context())
-			print_bool(PRINT_JSON, json_fn, NULL, false);
-		else
-			printf("\t%-41s : None\n", name);
+	if (!value && !is_json_context()) {
+		printf("\t%-41s : None\n", name);
 		return;
 	}
 
-- 
2.49.0


