Return-Path: <netdev+bounces-299973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V+iFFHTJMWqCqAUAu9opvQ
	(envelope-from <netdev+bounces-299973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:08:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF22695881
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:08:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=H2jFpREN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299973-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299973-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3806A301666B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801FC39B954;
	Tue, 16 Jun 2026 22:08:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AAA3A784A
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:08:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647728; cv=none; b=u34cJFmWswIgSNXsAnlIt5glKp7NbupgBspcbOmEN71bDY8k82o8AuRkbH0fiV4AJIV6RTiYA444gurGhr1aSyOGH/DME2s4Mg6jH8W3vXiOKhOWu9vYfUpjLNxUhL3jAH51fkH17UhuUq5KX3mjtApighFk+O76Q9oaOrIDQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647728; c=relaxed/simple;
	bh=SKgopEELXliDYEnHr78+JQLJh0P0326vhJMTd9xstWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJm0U3FfaH+ZJ3eX95SmTYZm0vZ+7QzqA9HN9Aan9vHvEuP4l7/R3bzOUZlo8Wl8d20JSRLAP9qbraxmYUQUwiQUV4ji3efQm0ZKs0UNoia7MsBOah96izDX1mVsBUyUqDVulOB5kzb80+X1+Zw9W/CynIbxsnkahzKS6WtgQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=H2jFpREN; arc=none smtp.client-ip=185.125.188.123
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C45B03F4CA
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781647717;
	bh=CBS56heam/bNhQd7KKFmAXc3hG0sdhWG+2CEZpuomPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=H2jFpRENdrKnHwVrvGyK4NwOMXlnEVSziXy68wpwcYgKTpiH0BmfvZwoHzNg7klL8
	 qjWwPTju0OtacMFwQKMuDja3NDUyrYegbOrPaU7B/QuK/tf3mA0hOe6RM046UrGHvt
	 lEdeE9eX44Kyxav93c/yCkcojQVBk5m0tiivyFz78k6u5SjWAOTbap3dm64GdLTMWW
	 c1ejdOtem18lunoL4hEoVpfAKKqmQq3Q+BQMzmIu7zRV7LsQnMoGVsLTRZ9xNo8DiS
	 +VWJPhLMM9O5Sk5GM5G7M95u4FiyiQZS+Cownwu6XUX3+QSzITwcCJejHLqwV6RcgC
	 nIOThxFWVNWEvtc5CFOpOpmFVLBdSq1fMbD7KFwqFEutFFfDS9p5IjfRomrouNV3sS
	 sjSecFmUQswcPdSqjpLESBrPhFHCt8sfI6TKoOAYX62006ZwRfJI8efuyZFFahLbk4
	 JhxOzvTlO1RbWn/ksC30h0g0n+cUZ7MxVaD5sMwjg+hVaALVozsVGYhaZaeobQYHGE
	 9D7ik5n1utP5/h159i4ud7B0KR6hu3S0vnM+zK9kV5gDAI2BfHZL5jf1b23/PRwTXW
	 +fP83I0Bbg1MNVSuyIYJI1IlxAvQkya7pterxAwnAeds2KKtVnf6/NAfBIPDz/ITvj
	 k4WKelM2n7/g4z/nmQa1Kjhg=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4923411f041so958615e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781647717; x=1782252517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBS56heam/bNhQd7KKFmAXc3hG0sdhWG+2CEZpuomPM=;
        b=fzHuju3sguFu4qgTsFdiIKqtKNk0gTSwf1NQd8J+vsR/ss9FBZ0vjGA8xvhGD2AQW7
         s+Rm3fQA8ghzp5Q7dLSpZQwUZssBDFr4pagqke5RmCDbxo0BHDkw72DeBokY/29UhQb8
         YGp1EI/ZAYe1k5DKwuRxLJwzlqzA/r+wqN8FH8XhUhNXKxhvQ2YgUsF8iGMwk4rO2Sxy
         1QTvlrS2rwBZiwVYJLiOZlbTS0eW17wbFPorIik5sUhm74fHzxPkhrkt1d7p+RMZyP20
         f2b99tUi7nLuAF1iddWu64rXm2zfstKi01KgAi2xww9vSGsuw+jpqGneEzX/RmdD6zcc
         KREw==
X-Forwarded-Encrypted: i=1; AFNElJ8+OoSrtMnv12pc+qXiWCgzkznCNjh+ZDzSbX27gAwZTPrnQbupAfwAjQG6G1vOd/YGfz6IC7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZksMvVwHGI1mOVqch9YPRo5iV5b0h6ZSgcx+yZRRNzcbzmA8
	SaeT2GS04c1o29407goTIECtakq6YGlhaZu3UmhQ05RJmPW6eebMtXRGTtBo4k+6d841lU5eU3n
	pHj+w9pJmSkkUA0d4CPk9Kkzydwsk4I1Po2aZJC7erXnH1Jg6jvBM789jX+XcqLqwlmMIhc+XmA
	==
X-Gm-Gg: Acq92OGBFX6bIlBliOeUE636gxFwAblbb5zRhktjWzv8uIcadxfx7L/cgARZmhAtNQM
	Oy8GFlVAEeVhRaTwwjIjGEMTFSjFXt/GFDS7YH35Dbm6kD1ucso5U5luA/gkp5mrqrIReX4rZtJ
	Ywj9qhQ0aNhz/cC/1W2iRGaBHP2taIaDAiQqQXOKEclsWodpgBXvVhPB8CUiitI+YvRMFzYBHwz
	0Tc34oT+IpFFpjdj2hA0BKhlWNhBsigJJOCWflqSUIhKQCUvybqDqSqx1wZBl/H8lRw7A+26Meq
	hWKd/G1jILEBh9vO7/cr6GBvbglPsn9YIfo7sYb5xR4RS0eY3vrNkLuD0ePfGD9gB3lxwDiO02r
	EWOOJWpAszOQ04z7s29e92sYnXchW71NggcZoJbusPjLuCsmZ/dUlEi4o/yf1WkDl3HI=
X-Received: by 2002:a05:600c:6091:b0:490:52fb:12dd with SMTP id 5b1f17b1804b1-492333a97cdmr22062185e9.10.1781647717335;
        Tue, 16 Jun 2026 15:08:37 -0700 (PDT)
X-Received: by 2002:a05:600c:6091:b0:490:52fb:12dd with SMTP id 5b1f17b1804b1-492333a97cdmr22061955e9.10.1781647716996;
        Tue, 16 Jun 2026 15:08:36 -0700 (PDT)
Received: from localhost.localdomain (77-236-28-43.static.play.pl. [77.236.28.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4601esm106328265e9.1.2026.06.16.15.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:08:36 -0700 (PDT)
From: Robert Malz <robert.malz@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH v2] ice: retry reading NVM if admin queue returns EBUSY
Date: Wed, 17 Jun 2026 00:08:27 +0200
Message-Id: <20260616220827.1647052-1-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299973-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[canonical.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,canonical.com:dkim,canonical.com:email,canonical.com:mid,canonical.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFF22695881

When the admin queue command to read NVM returns EBUSY, the driver
currently treats it as a fatal error and aborts the entire read
operation. This can cause spurious NVM read failures during periods of
high firmware activity.

Add retry logic to ice_read_flat_nvm() that handles EBUSY responses
from the admin queue. When an EBUSY error is encountered, release the
NVM resource lock, wait for ICE_SQ_SEND_DELAY_TIME_MS, re-acquire it,
and retry the failed read. The retry is attempted up to
ICE_SQ_SEND_MAX_EXECUTE times before giving up.

Code was extracted from OOT ice driver 1.15.4 release. Additional
change was made to reset last_cmd in case of retry to make sure that
all commands are retried properly.

Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
---
Changes in v2:
- change ICE_AQ_RC_EBUSY -> LIBIE_AQ_RC_EBUSY

 drivers/net/ethernet/intel/ice/ice_nvm.c | 25 +++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 7e187a804dfa..b3120605d66f 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -67,6 +67,7 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 {
 	u32 inlen = *length;
 	u32 bytes_read = 0;
+	int retry_cnt = 0;
 	bool last_cmd;
 	int status;
 
@@ -96,11 +97,25 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 					 offset, read_size,
 					 data + bytes_read, last_cmd,
 					 read_shadow_ram, NULL);
-		if (status)
-			break;
-
-		bytes_read += read_size;
-		offset += read_size;
+		if (status) {
+			if (hw->adminq.sq_last_status != LIBIE_AQ_RC_EBUSY ||
+			    retry_cnt > ICE_SQ_SEND_MAX_EXECUTE)
+				break;
+			ice_debug(hw, ICE_DBG_NVM,
+				  "NVM read EBUSY error, retry %d\n",
+				  retry_cnt + 1);
+			last_cmd = false;
+			ice_release_nvm(hw);
+			msleep(ICE_SQ_SEND_DELAY_TIME_MS);
+			status = ice_acquire_nvm(hw, ICE_RES_READ);
+			if (status)
+				break;
+			retry_cnt++;
+		} else {
+			bytes_read += read_size;
+			offset += read_size;
+			retry_cnt = 0;
+		}
 	} while (!last_cmd);
 
 	*length = bytes_read;
-- 
2.34.1


