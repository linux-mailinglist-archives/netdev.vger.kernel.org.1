Return-Path: <netdev+bounces-277813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJzWFDa522keFwkAu9opvQ
	(envelope-from <netdev+bounces-277813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:24:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A213E475F
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36AA63004214
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC9C37DEA0;
	Sun, 12 Apr 2026 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="T0hVbtHS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3426738C
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007475; cv=none; b=YeaA8i0tc/xxqPSAT3KVk9SryhmRHefBKqWgKvllv/ri+tb1yTpSspcXeb5pyA85TombNfVYwOqZ6ItMJ1uYUKbZsVTPTyvZiWiK5k+GtJUiRau8543F60bC3PZTrgNBzKCYm7CZw9ejnskTqcFut4K4FomvGIOajVF9amGLhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007475; c=relaxed/simple;
	bh=/8aC2+o7608tkd74825Iy/1QRWlTZuDhAhCmCcAY4YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EarWK/g4OBbqqo1D0YCIQrPtfHmb53HXylK4dieI0NnBtK28Gr+Pl2yhGLj+9/l+0vxLqOzUQAA1BHnPmIe127zHcA9cjRVkSp0xYPlyeZwRqgi/wBZkzJnExLqdnvJeQUa4B2yKInZIx5dFM9zUF3WT3o5zZqkturRyuYSFlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=T0hVbtHS; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45f053b7b90so1981228b6e.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776007473; x=1776612273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JIew2K3QCtHGU2fhekFg36o9nAeGzmNaQgb5qGqa+ng=;
        b=T0hVbtHSYGhTbVs8Niyp5XeH3G0JHa2+4ZP1wfdYCIrTgcpbJRO0jmMMv2AjMAej1E
         hMjSZVQoC56tedp45THwURAPyuA2J6GqzC+mrsHPBvqeToL73DAlree3shhfH/MbhNIx
         26pjUZwe/YwfL/bnp2kooZavP0bQ1F42iacx5D03hqsc3BdXMBf6H6uvhmPu+SryKnBQ
         qH3steNIjvZR/OZiv6Fl5HeOjgF1kRHMbr73KZ/2j/EC2tO4uqf+MdpPtqj3KGKz03Rq
         wdORN497/dpn9J30lCmBnWggPo5PmF2hoR/cALeFhnvB+LNRcmOGG1KpeavUFHEv6DD3
         uybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776007473; x=1776612273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIew2K3QCtHGU2fhekFg36o9nAeGzmNaQgb5qGqa+ng=;
        b=TSs4XuLD6Hh8NTWM3ohHhUbqYkNimlNSRynQtmgwuC89EUfqvfaaRH2+AFJw/NUIlr
         ZNLKAWCnHBPzLA/Sg1jGtqcLyhhpB0ozuFtyO3gFpE7gQ4HV1N9+8s1/FwNbs09ZEkVl
         7VmOXEFm+tu10mLOhumaZyIMau1q9ma7gUDazzbtHPe0dQRDzb06Xm2bS6ELj7/nlLaP
         +3dMA0fosz6IqaF/NIQFeCKzdPq/tDKRctsVcUjoy8qEaybkgNO7nVvKNvMEish1kTLq
         m4WMZSJGB2TehG+YGNxoYIc0A6eZMBXw44zpuwZdYyK8x0Pro2akyuMZWga+rz8PZzFx
         NPbg==
X-Gm-Message-State: AOJu0YxHqyE5ZtULVCmIphzN+V1g1kTvccOuOWnYeI8oi00TmUCoQN1c
	qeiPYLj4Il1nqUZ2beB0JlGlnLsRxv7ZUyDW+Y28/36Q2V32FuMro6RMqo575VUKUprJP6n9ASW
	5troz
X-Gm-Gg: AeBDieuWlaJajs9apE/ZTCj9LiCi+nBJbQSa/JzpoorX++mKK91Og3m/a6IlgcX4r1L
	Q/+5jHF2K84bqOSjlysLxN8fPw9fcmxukPiPgo971eQZNMrcHCV6OA3L4+zMqxxgMHIRYguv4H1
	ogJFpkRRrV2LQr2WeNGqKkZNH8lyo2OP/FgNEG7yMB480Uvjc5OoJ6ISo2ghsvUsu+fVVURmbc7
	2MKMAOb5r5phSQijbGKTNodwv1RCpyGSQ6JgkdwrfjDxDfcYl1BAoYoCSlmnxJiDjaC8tHBccpR
	x4yDhht9o740A3X12z7dhv1+lsnKrWRSwihlw9tz6fCj5OMaFu6KmOThsnjAm3WcwvH9nHAT2FY
	xKmjKO/cae8A4gt7gbXfxAH5JiDIYEVRH3wcAk4Yju5EJUV/rPwFV4Yf8WGpJ6AXzMHfaa87SIE
	ClEsKaxJPrxBO6bADtXmKue+PylbvkkrOm
X-Received: by 2002:a05:6808:1441:b0:463:c56f:a45b with SMTP id 5614622812f47-478a04fe131mr5757378b6e.28.1776007472948;
        Sun, 12 Apr 2026 08:24:32 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a2f557b5sm4911726b6e.11.2026.04.12.08.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 08:24:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATTCH net v6 0/5] netem bug fixes
Date: Sun, 12 Apr 2026 08:23:50 -0700
Message-ID: <20260412152429.143474-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277813-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:mid]
X-Rspamd-Queue-Id: 77A213E475F
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

v6 - drop 3 unnecessary patches; focus on real bugs.

Stephen Hemminger (5):
  net/sched: netem: fix probability gaps in 4-state loss model
  net/sched: netem: fix queue limit check to include reordered packets
  net/sched: netem: only reseed PRNG when seed is explicitly provided
  net/sched: netem: check for invalid slot range
  net/sched: netem: fix slot delay calculation overflow

 net/sched/sch_netem.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

-- 
2.53.0


