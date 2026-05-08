Return-Path: <netdev+bounces-285567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHbiFZpD/WkoZwAAu9opvQ
	(envelope-from <netdev+bounces-285567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 03:59:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E3C4F0A95
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 03:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F4A8300B513
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 01:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813E524503B;
	Fri,  8 May 2026 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="mqkBT99e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388523E358
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205589; cv=none; b=BYliI8/3GRJG+XQxgw+8n3sur3t3JTaIRm9HVPVOHRHeIxIZLxhp/4Pg1KKxPwodJI7I4+g4v2hwspbNepQJiJqp0HAX9AwzSI+araSG9tduRA5V6tOD/lgeYFOloStKB56IWdUzVMgO1xxSyKfm80wlK5mtk+5W9BMFTlRfh6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205589; c=relaxed/simple;
	bh=alUSkI9K4Q0epj3l3VZw7nyPrAML/8wd6Z8yEJoklIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gj9qdFxSCn8CK0E55pAYLYZAn/gS3S6tu8n7DvXyQw0M7mqdi1Kb0Df03gLACBRsxwtg4ireN/ihfcyHIhB4dVSMzHnz0WH+nRl6PORQds/4CIWga6iNRpzZCSDis4FsZfcwMQv2hYDbkfzB+DCRJfftiipMTs8jXfIfzryTObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=mqkBT99e; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f30a4601bbso1683838eec.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 18:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778205587; x=1778810387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pKXo/5AR4dzKWnbZOq/iYpEXq02zZVbOqUC+ZSUDbg=;
        b=mqkBT99ewnQy4RgiqdBzvj9BzJ2qxKNZkZG5H6gQHB9YwujyAkApSURbIIjMBXcfZw
         4tmtMH/0JAAtOsGTwrLJVtZco8ETFN7/22woNIzPk/G84pHpIZEjuPRuPmj0kGghVTDK
         cE7Xc2gXt/IXBFbe3r7vXSmtRl/7xD9lU/7aC2oX6bS7V8osVrdnhOBWzpMVe5Z8PTxn
         Y4p64wlXmxwo5oOwUFLf4QwaACiORTVPx6xSKKxIW0pPOqiY0HnNM+c9jCtI2hHFRlMz
         VWK3vZyf90ZZW8nZKndHqNwUWHCo0CvamaiNhlnoGaWiQ90ZnYHXOrw3bie3txAe7Fci
         fRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205587; x=1778810387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pKXo/5AR4dzKWnbZOq/iYpEXq02zZVbOqUC+ZSUDbg=;
        b=eT/VK73SqdCIrpxq0kb0T10JI3nA6XvcLYcf7wowWikxvN8XyAC1hBWV3Gvyf0s0/y
         DPIo/OmZrupusX1cHZztXovDz9VdKE11AK4TallA+2UmEP46h30G0ljXaI0zMhpJNVNs
         8K4MELHZljpgJM1lMb5A5UoN0s47ckVAfjmlgjsnr6ZBetSTkRgsTxFu3SNf2yNI6nJq
         ql192p3vGq+p7Sih/xFWecyiP0W9WCZ5XAxQk62DRIJ0cWE2PWatKvnXglBv/HRHIKi0
         q6gDw1wk2pByV9xRJ81Ol4tEOoZkjsbjMzV+ZCRZNsklKsMpNYMRwkVUStzLazQNZ5i6
         U4aQ==
X-Gm-Message-State: AOJu0YwKNyGRFzaHZhAQWp6yVc8h4YxGjcnjcp4w9y4SblGqkwGGOlSx
	IwU1D1wpAXgy/SneUneKAG3uRgvFyC4dU5ojejPDYNYlModTsPMD91aMleDn/p+cpk+0R4Pq277
	lxDHw
X-Gm-Gg: Acq92OGP6Yi7UI4sE0a8gWrIFSA5tx0aLwo3fRlxXBt+Dqbf4FzQ5hlLdZ2HEXo3Pqj
	OhbNsNLkLgraGTDgG487l1LX/zzpJR6ulYuYr2yBrZPXbHgVKhORp/0tnVDnVQgW/4QayNxzOcn
	qDFWFSovNl6m4AW43drZh4u6pk/AODZzRBCVfdUe2KAnh0D4bPtaaJEvpTV1SKZNM2W8WbkMIWi
	9Fehq7cKtj0+uSOHApgm9dbjoZGV49yfI9px4L+KBZcVYm9q6FFXo8Rl/996ZCwdiFOrFTtSwxy
	lC9k6z/lL6hbAMilmZloqb2jDfQdtkqcIphfF3Y7/KDlVlzR6FoGnRQEJO5SfFuvG/zFYA0Oglp
	cdohNYx0RevBgReGkn5C+ntSCepPdc7ZVkezihVthzogC4E+UAqZ9aUqUSjbUoFqKCKWnqtIffb
	uzt/KHdF400RRifKLTK8HgqHiSVbZz63Ut
X-Received: by 2002:a05:7300:2387:b0:2d9:f0b3:1d98 with SMTP id 5a478bee46e88-2f54b8986b6mr5417888eec.7.1778205586700;
        Thu, 07 May 2026 18:59:46 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847504dsm324090eec.15.2026.05.07.18.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 18:59:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/5] net/sched: netem: fixes and improvements
Date: Thu,  7 May 2026 18:55:16 -0700
Message-ID: <20260508015940.554462-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50E3C4F0A95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285567-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

This is a collection of improvements to netem found while
investigating the fixes now in net tree.

v4 - address Sashiko review feedback

Stephen Hemminger (5):
  net/sched: netem: reorder struct netem_sched_data
  net/sched: netem: remove useless VERSION
  net/sched: netem: replace pr_info with netlink extack error messages
  net/sched: netem: handle multi-segment skb in corruption
  net/sched: netem: add per-impairment extended statistics

 include/uapi/linux/pkt_sched.h |   9 ++
 net/sched/sch_netem.c          | 202 ++++++++++++++++++++-------------
 2 files changed, 129 insertions(+), 82 deletions(-)

-- 
2.53.0


