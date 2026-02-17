Return-Path: <netdev+bounces-258971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBK7F0wOlGn4/QEAu9opvQ
	(envelope-from <netdev+bounces-258971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 07:44:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2991490FB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 07:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97FC83013D6D
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 06:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F92C030E;
	Tue, 17 Feb 2026 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayul4VRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD51298CC4
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771310654; cv=none; b=NRC7yndu6tPKpmTv4Zaz1BF1GE3YL2LpaiQyNXqmNmgWWC44IGIU4f9jfIEu+kMngdansGe5cmJRagFu7HTLWgn64Vj4KGFv1Jtd4UrXJlG0YtnH6AhBZHg4umJLfVrTTCgn4gb8lTNavRbaPS1uqe5zkL2SkZIqc3AUfNGPPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771310654; c=relaxed/simple;
	bh=npmqQVA/4JwOdZ6QEDJEhIYkP6MlS7UGasvW70d2jcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1xStZ3/1JWQm9UX1dJ+omQDP3Q/8s4NECKbJTmK+5nlHn4yKgZdc0yjAKOY59+HTjJ6ubKdpQsMW5su+0wecG+vHxzhMRCoN7kRVLrwAlTkZIRq+qDGBW2EZk7EoIL5Jne7Dy/zucC9ESUqrkG/z3lOPkuKiJj9BXEoWCY/jjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ayul4VRV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4837634de51so12463695e9.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 22:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771310651; x=1771915451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=saKIiw+4AyLrznzS3TxLvq+C62nRvoYeLYS+U1QU67A=;
        b=Ayul4VRVU9UArz5teu5/l9o2wz8yuJrFTrz5RPii/Z5jaW9k/415iImM/mzqbQv9BW
         cDXKwtkDekGfQNpBbqrq+BC9Ohjj32Ony0noZkzNpyMUsMJm4MR3YJjDICN1WijrThvB
         0A0501oR/0IhY1ithv9I7iQXKPDsOueJhrcuNRQtkqWXAfJcCvVIsas0zevwo9Pxc1pt
         5uWKTK6UXqjABD78bREAABGazzDL2CTU+EjMJBPRcLn6RL7Tzm3Cc/zWLx9ApeKdbrTp
         LE6CXYwX8oCMx//e9LhAJrE74CjwoLTKneDpIMah8uQfFNbnSFpd4vLML1VOB1OUTwyI
         u5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771310651; x=1771915451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saKIiw+4AyLrznzS3TxLvq+C62nRvoYeLYS+U1QU67A=;
        b=M89iaK9TbO0vE/CgrSD4NFmDLSfE6Uz55+fMwLxBrLIinrjndvTWoukhv8r4/r2b17
         djUTkb3rAK3pGq9KPHnBQekADSs/kdd2GOfV52riwfIx+2sw+HqGyYI0HaaAAjCoD0wW
         yz/4yfwulqCpiMqDkYhbq/pP64bLHYHsIH+UZbsL64a5fgJKVbLrQ6GW/FEqMrYhSNrA
         nqDNdc6KnEC8OTq85iU1nl5uNCEDlnZxJJRjf7I6SvMJVi4o9hvXOLiqcRgT+3QlTfzy
         fXGHGqj8GRTNPFFfVyIptjw7hHwfrDVdLjQQJobfqApEkNNntlkkpTHp2Y0/sJz2T3J9
         g1Qg==
X-Gm-Message-State: AOJu0YxWSnkKC0Lhp08kWGMOCrzh7xP+3amAJgu2gwC5aV0wGQ6zvel3
	IUclrVGfAPAWdt4M1KB8YJ8gpCX1ZGdjcijOaH+Wf7fHyvm09tVE9K0M
X-Gm-Gg: AZuq6aLWRgZ2Sx/DFmIJJpwFwyT/+W5gEmgIiZqQsyN7wNGpJJ19e7EXVOk324St+sW
	JQF6U219BCgc8ktKDtcofxM2QhrpwZlC6jP04VnLK3n8YPuF9IZLIV7Iob3agscAWaFj9gnm58h
	y3WtfAjfD198cka4F4vHbYCN37gA81orRwiKI+oNqdOpVlQdFyc9hSosy9Gc1Zw7S3kjYQI96nA
	TOMK1vgofzelrSLDmyQ+/aATXC8JeQbcjlU0cVpPdztVLBCeJU6a26rlESh5KtwqaBWgJwvnV/r
	D2iE7WW1o2I4Vp+jftOOVctuaR8T5akQZyNHlq3mT5m3Fn2qS4as5PM/shIQc92eKCrIr6+3N/v
	t58ceFj1QdXDE7xm/kRSRMWaKUAEc25F1aaNkk7QFLzQA6ouWm48KJ2esEAyPqhKoFbG9H5PtUS
	HGjjyaViPhEbd4aL9jzc3KgIisLj8SQ+WFGa6sgWJhiVwmsvCk4FwZ+qzy
X-Received: by 2002:a05:600c:8411:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-48371051b20mr186531715e9.11.1771310650743;
        Mon, 16 Feb 2026 22:44:10 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfafcdsm752842405e9.9.2026.02.16.22.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 22:44:09 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0702EBE2DE0; Tue, 17 Feb 2026 07:44:09 +0100 (CET)
From: Salvatore Bonaccorso <carnil@debian.org>
To: Michal Kubecek <mkubecek@suse.cz>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH ethtool v2] man: ethtool: Fix small typos in manpage
Date: Tue, 17 Feb 2026 07:44:04 +0100
Message-ID: <20260217064404.2817775-1-carnil@debian.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258971-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[8.in:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC2991490FB
X-Rspamd-Action: no action

Fix the ocurences of 'allows to' with 'allows one to'. Adjust as well
one occurence of 'withing' to 'within'.

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
v1 -> v2:
 - correct the subject for the patch which on its own contained a typo
   using a ; instread of :

 ethtool.8.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index a18e40ccdf43..e10a252f70b5 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -1901,13 +1901,13 @@ support. It corresponds to IEEE 802.3-2022 30.9.1.1.5
 .TP
 .B c33-pse-extended-state
 This attribute indicates the Extended state of the c33 PSE. The extended
-state correlated with the c33 PSE Extended Substate allows to have more
+state correlated with the c33 PSE Extended Substate allows one to have more
 detail on the c33 PSE current error state.
 It corresponds to IEEE 802.3-2022 33.2.4.4 Variables.
 .TP
 .B c33-pse-extended-substate
 This attribute indicates the Extended substate of the c33 PSE. Correlated
-with the c33 PSE Extended state value, it allows to have more detail on the
+with the c33 PSE Extended state value, it allows one to have more detail on the
 c33 PSE current error state.
 .TP
 .B c33-pse-power-class
@@ -2075,7 +2075,7 @@ If the PHY's upstream_type is
 , this field indicates the phy_index of the upstream phy.
 .TP
 .B upstream_sfp_name
-If the PHY is withing an SFP/SFF module, this field contains the name of the
+If the PHY is within an SFP/SFF module, this field contains the name of the
 upstream SFP bus.
 
 .SH BUGS
-- 
2.51.0


