Return-Path: <netdev+bounces-278795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDmMNFWh32kEWwAAu9opvQ
	(envelope-from <netdev+bounces-278795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:31:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA194054FF
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F977301E97A
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371E93D3D19;
	Wed, 15 Apr 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="F62ygimO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A748B3D3D1E
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263308; cv=none; b=WkohN1VqoecTwX4BAKpGWe2RmldaJaK3raMsATRT7ThCbxW955mD51EHj/4So5rJ737SDwhGa+1f+Miiyr+JrAP95TsWrzSOElmQhTV86b2oMWHB26YTZgXyINN5gFCu7mr8u+27H1UqP1wn8rF4S3g/ioANrrv0HL0bmXfg1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263308; c=relaxed/simple;
	bh=gv7g/IL7fh7RYs9Dj0w777sP3q54cVPj4V79X3eh2CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmgHMRM1tyqQJ4v108Mz6x9xXkJEvbQGDUCKEyY0tOt2FNiekFT4Ztyf5m8wnN2uqXpFLe/ofE0bX3H0w9p36502zInIwGt8Qlb0RD8kXtd0d1TWI9OSVk16BELNGo2R2EcoKFnoNVSoQc09+8+pACpoXNs2FQUNdzWMoXtuDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=F62ygimO; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d52c7f92b1so6089511eec.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776263306; x=1776868106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ynmHy2q5/a9WpBeRhgIWgqbB2KmgHCrbjYMeoxnu9yk=;
        b=F62ygimOBhO0hYNzm9q6aeZh/mkCWKks1b8er6GicTAREuPwnhKrJxic/7tolspx7P
         wyIenNGDwVh/7r18cypBZsOqAfEAdqOg95YgMe4UgLFKTS4JB+XL1QCGm5IYPgzLuxnj
         mfO+ErPPpheQR7rxyxpxdyZm7uuWppdFg1w8posll3YT3av3oDoPH7O5hp+J/Z7R4vif
         4gbvaemtF2wlcw4XYQ/oC856P22srUuST3nQfRk1A0FbKARd/0aMbszn6EjNCd5zpq4Q
         mKcUg0t/l+KBTbS2V0XhuxBri32tvl1eRC2N1o+1Se13NMCklXrcZzHlTCt2iB60dBm8
         EXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776263306; x=1776868106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynmHy2q5/a9WpBeRhgIWgqbB2KmgHCrbjYMeoxnu9yk=;
        b=JRKqt0VcCrd33RbsT4O+cBOrisiT2YbUKOSEj+N4LfZvzo3B4lL2f9TMUMFiemQ9Eq
         Y/fxCIr4oDGMQ/38S/jTJ1M8+Q1+h2nkDOME8Xk84kETTf9jeVGT4YywDVCjsJIw8qkR
         r19909b7+qcdGnB4dt31IqNM8J5P6OB4HonR3wy90wAXUyvKRWIBbECrU0QHLI7FGHyt
         obYPF1OzbUgBtHbyt8zr7VFmZwuCsn3btqZBTHePAqSpnqMqOVQdHxBaW0SK5h4+cR9Q
         TzrwbK7yQkj0MXS3ElrjGIESCGC8p7YkctXOmQpldIL2XMiZipqmGV03/KLBVLDQU1iA
         fXlA==
X-Gm-Message-State: AOJu0Ywty6u0vV8RfmF87UGGQVag/rpi5JW4fr3IIdMgCe/NHmqJpMCM
	9HHezOyViGrLIjlkUXv8w9V8L+eEK2v0bPT0VjVILMETHp5mF8qJn0v4BHUHRyjCtsPXMrZaJF0
	my3uS
X-Gm-Gg: AeBDievpZPSQXQ49yD451/WKw1xeOTlV80Qn22dV+qOxqjFBXN1C2jlL0R3mBv+Rj51
	qGQs7GJvfUl5vo9fjnVAsc6vLJDI5UkgC+gF7FQVqgqYP1iV5UFh7c+K4BZy/utB70/CONGy3vy
	r6D9A+0BmPHt/xXrw7nWDZFFlfpjrKS3QmzaBI44uxzx15ndwR0TFxq1ScrXyRre9gb4ncBt84D
	cV/BJ81Ntwa7Ydha5W7wq2NJlLb2JLs6OMbOVufEfMCaWi3I8Yy5F6mkIvx22KzsQO+ip0bPnF4
	HGhlMK4iqk6W5FOIjSrNbxwYRQXv6dDEoQlV3OIKq2DXSx9tECMCPCT2bqcbzAQlCtecYltj0kp
	Z2z2jXd7B7sjxN7SNqwfJcq4djCzFDa1WIT3w24VGHdkt00xLsAUVC4qSsi2w+RkUv8gtJBKLt+
	A92qHMx2DbMFqPy3U22FI1UXDQ3AclDhxcvq+1HBZjhao=
X-Received: by 2002:a05:7300:372c:b0:2b7:38cf:c2fd with SMTP id 5a478bee46e88-2d5898a7024mr13493654eec.26.1776263305432;
        Wed, 15 Apr 2026 07:28:25 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb84813sm2751347eec.18.2026.04.15.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:28:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 0/5] netem: bug fixes
Date: Wed, 15 Apr 2026 07:27:03 -0700
Message-ID: <20260415142822.133241-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278795-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CA194054FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These bugs were found when doing AI assisted  review of sch_netem.c
during investigation of the packet duplication recursion problem
addressed in Jamal's series.

The fixes cover:

 - probability gaps in the 4-state Markov loss model
 - queue limit not accounting for reordered packets
 - PRNG reseeded on every tc change, breaking reproducibility
 - slot delay configuration not validated for inverted ranges
 - slot delay arithmetic overflow for ranges above ~2.1 seconds

v7 - queue limit check Fixes: goes back further to earlier change
   - use NL_SET_ERR_MSG_ATTR

Stephen Hemminger (5):
  net/sched: netem: fix probability gaps in 4-state loss model
  net/sched: netem: fix queue limit check to include reordered packets
  net/sched: netem: only reseed PRNG when seed is explicitly provided
  net/sched: netem: check for invalid slot range
  net/sched: netem: fix slot delay calculation overflow

 net/sched/sch_netem.c | 44 +++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

-- 
2.53.0


