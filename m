Return-Path: <netdev+bounces-267160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLp/IXXqsmm8QwAAu9opvQ
	(envelope-from <netdev+bounces-267160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:31:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8D275A20
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DC0F30DB16F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912C3F7E74;
	Thu, 12 Mar 2026 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKarVSqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEEF3F8DE1
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332857; cv=none; b=dE7dIEZJbCAfoowV2zG4ZJA5I6OXiRavQJGDO0dv6zdFRE0WshYkM9BgFw/R1eRVPYptqaFBlF437rHTGgT5n0BsZ5E8iNolmSuAcVLdx6k5ZuNeiDYzoO0otP3SYCWv45Rnojvhj+SWlKxO6Swq8JBmBHHdrAZ+vGIh1+Xcs/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332857; c=relaxed/simple;
	bh=WeQpqP/v10mjvRkvyYzZra3V13Co+TToHr/5ahM3+PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Je77BFvWr9r6Hu3M8tkaakoiJL9/vC0EUtVSO+xPOmZ+dcOwHSo0R1PfmTlsx8p/XKPIL6sHs0e+5us4DuUOPPj1NjYxn6trDA+dqKlnWVxxJXN9JoSiDpxKd1ggxxZKO/3XjVDiUm1pW4cog7SVLqR1+LqFEquURBJ+SstfhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKarVSqJ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d556c1a79eso1348415a34.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773332850; x=1773937650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kiqYOLmfZfFjTgPDhXLBnWofyj+zIF22cbc29XYNUiY=;
        b=gKarVSqJkvfTCfYntfz4uST/2a7YroBLxxK7YxJoiWVRr2eU3YU7BoEoLl91u4Yrsm
         WfiIB5/gA/s82IVoaLhb36glMSeqHldklUEAx8IyAWGZ6noUzZGMNlnGmkC+Odf7l48Y
         mgEzxg+DVFsyX9KOoRc28yqoicF8l08sYvqs03th8LSD4PIslGDASyQOwevhjkTW7pR0
         RwcXVSvSXIjcuMBdmkdaTg/zFMWPNhSWcKGFE2QjHArQ+NpS8BU52mXEG4qDw3eXHSAf
         blKc7cejTIpaQ4KrHK7p4gDe3PeRuSNEzDSFjB/179FAEswrNNfJ4M81Vmi5yLpKu2js
         P5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773332850; x=1773937650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiqYOLmfZfFjTgPDhXLBnWofyj+zIF22cbc29XYNUiY=;
        b=GcNfQOPYHxl7Nnl9dSA37O/svbUqvUSrLaLm+iCgd2tGZ08r8zzvibjePqT+obSglr
         V4lrFkp3nyEE5rBddMW2xMDul2LIxgaNRewYr2R84fYEbIxXy3frJcqWcxFwEFR5xTTE
         IE8QK5H3XwiPtCP6tI/M/kY2OGb/WoV2ce2jfhvsMAGcwPHTvYIX48NtH13VkAZrBXwB
         sSSU+/a0EoDYnqKl76XcBxqkAv+8oakTZ5ckdY2f006cX8dBQdN9T54Ktap2crSdbMuj
         82MSZborXhdVYgbsYxtDf/oBcFE070hupf1zJLQKwUgM/6wD5ytC1TgSoKbWA6phEQr3
         Ky7w==
X-Gm-Message-State: AOJu0YwVLlmCVAUi9UlHvjNYwYIj4Q+vdmIlv4NE+ANPhuL2g+39LMIl
	A02cYvGlDiKqmSjRttYaHvM8kFkNAMtYc7zXBmhpS8avaUR5FLJWOxAu79SpeGEWJz0=
X-Gm-Gg: ATEYQzwVGldxEl4kieITFAbUjqfuB4pGjjIa3E4onq0Mtam/3GkGY3p6C+sqnUcDJgA
	rGtFr8OJO6NGztdYpO+9JsYF5DYu9KX9GPQ46w56PadPpiVUtMfE2IGVdA/3uDdIhkFp1Nlj/d7
	U751QebN2SDyuMQz8klrdQgFJkugHpIBeeBIA8tgy/bckxFW88pcWxPfM43qBpVDdo0JADO4DvJ
	3aHrrDePkSvlsNVupJD7236n2aQoow7f3KmldRo+8mPFFylB8J12dLyfVKd4fuSqMz9suTl6x6X
	YgmaQXhM9psNTgcILkzXEUpb1/Uh2+pu/6GH6736zbsU4jtejKZmTfPcd35m+376KcuPenPyCp4
	BPnwXuf8jsZHnQ5iP9JZz8U+qwHNfz6+8RqXN+jnHWdeeYi089UX9Gc9X6ZbUo2tPnN8HUmeD4N
	H5HEjGs7F1C8Xq8cp102+iHRJp40TKfmRME+mBe+S9zE+iAIvhqAc6eGTsUsvLMiuQZOTh9+Rqt
	zG0RiMs21ic
X-Received: by 2002:a05:6830:34a5:b0:7d7:44f2:cf6 with SMTP id 46e09a7af769-7d76a6cd2famr4669737a34.22.1773332849541;
        Thu, 12 Mar 2026 09:27:29 -0700 (PDT)
Received: from ShravyaPC.. (r74-192-25-180.bcstcmta01.clsttx.tl.dh.suddenlink.net. [74.192.25.180])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d77c961e79sm1107766a34.7.2026.03.12.09.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 09:27:29 -0700 (PDT)
From: ShravyaPanchagiri <shravy112@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	ShravyaPanchagiri <shravy112@gmail.com>
Subject: [PATCH v3] docs: octeontx2:Fix typo in documentation
Date: Thu, 12 Mar 2026 11:27:15 -0500
Message-ID: <20260312162715.35408-1-shravy112@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-267160-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shravy112@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 00E8D275A20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Correct a spelling mistake.
---
v3:
- Moved spelling fix details from the subject line to the changelog.
- Simplified the commit message.
v2:
- Fixed the subject prefix formatting (added space after "docs:").
- Moved the long description into the commit body.
 .../networking/device_drivers/ethernet/marvell/octeontx2.rst    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
index a52850602cd8..c31c6c197cdb 100644
--- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
@@ -323,7 +323,7 @@ Setup HTB offload
 
         # ethtool -K <interface> hw-tc-offload on
 
-2. Crate htb root::
+2. Create htb root::
 
         # tc qdisc add dev <interface> clsact
         # tc qdisc replace dev <interface> root handle 1: htb offload
-- 
2.43.0


