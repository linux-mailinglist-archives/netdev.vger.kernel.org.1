Return-Path: <netdev+bounces-303331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YjwsERANRGrYngoAu9opvQ
	(envelope-from <netdev+bounces-303331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:38:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4806E738B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:38:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bRvwnvvi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303331-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303331-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A26430470E6
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A090F3DE451;
	Tue, 30 Jun 2026 18:37:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309F3DD537
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:37:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844642; cv=none; b=N0yZA3dBnLSUGTOU2EwkJOzHYC5ItpbMJVap+hQplfy4xMT4OHdOSO3V31DIhxjrvLgOjEEql8U02WUuAC4+4itGrCVgn8Fj1uq81l6Y+a5X1TlsyFjlwX+d90tQ0KqDCP0vihPAcEtHhLoNTROQ2fd4cQ4cZJteFv6Oem3nsZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844642; c=relaxed/simple;
	bh=DYD1JUeHIQBn+tSBBpX4SXFw4uV7JZpeKR5pyZgwgpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lLQI7nVi4GK9Dh6uTGTZEw6AYg/OgBeIzdPG8iMrpeAr/lEyCHhPF1rwZgLbAWiocqhA02xS8P3wTu/nF8wG2DuSJfaRn08gbpISccAC3ivXePw4la5dwcWVwsLnlEh+ZMHz9KG09xtzP5uYgM2NKJbwcA6UKXslD2BYRZy+dLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRvwnvvi; arc=none smtp.client-ip=74.125.82.170
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30e9eefa268so1321172eec.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844641; x=1783449441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ih45vlyCqTdxWz3Y+8yYeJgcebBFtFeu2WVvm7KcQZ8=;
        b=bRvwnvvifNqRu+ekKhHbQ0XuskXSyiiQTubAZV3rcDjHWY06eMMMAIglEbTCnTo1Ab
         uQcogMaXac6/ORw1lpsfPg2Vg4h7MxEzwmU8Nrow9F00v+GCPbpBG+9+QQgTcen2T0sc
         ve8BadPXiZERTSTjzbnuMeNQiFCwQDNjXKPPaTYQ2TxEDa50DPQ3dsK9EfOX+tqtATjT
         R9qqbWtkngpL9wYdImTh23HR+ZMMfv917VZ49NIGVv/Ldt8Xtu1KsFc+6j6OKfDbLDaC
         5OeFOr5Hd6PY1NUBs+e3iJZLdzb7Lrs7dCxZinlj5/L46ZUkwWaf/+ZES/EiwpBaAGPy
         kq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844641; x=1783449441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ih45vlyCqTdxWz3Y+8yYeJgcebBFtFeu2WVvm7KcQZ8=;
        b=SwkWP37YeBX6+V0TMHmy+x+otKq1KAR0TkSErnnK1RH62mPyfivVCM3lYUJgkBWOMk
         0+OJo5be1goNVRxnWnYXOh81ijqcCFt79yPHc2Cn6Q+vcLN+kqcg5XWc/OHbUTiSDnmB
         6Bw4IPSAgxT9UiWwYnRLrGD/I378l/bABBP5u7EKN3Ldu5xlHAhVgGsTP2O0DGN3r9en
         9228BK7QUA6ym17lRwiHZbEFpCU5ueQuEnf1YrBIiCFHrJW745fzNjxC4f+2XyhuP2VY
         tYQRYQtSMeUX9PhjrSh0j72RUZX8Il8IEgexJ77zrBpisEMRbqSL41F5wQ1vuhfmhxDp
         0yNw==
X-Gm-Message-State: AOJu0YxNHMWcyCiZXW+u9rY9JnrIAMowhYIv/4tjTu3kpkhyZUr18coj
	sxF9OZ6tk34yPG3Hr7oUNHEp79o3clMJymgy780jA+ChDsRy88pcnzPZJJNi+Fl+
X-Gm-Gg: AfdE7ckH9HO1Z0NxChL7fN5uey8BridnHegDlJD33pXXSpNgwovDgmftnElBcFOqEjV
	dRewoTtPCF0kipdGM0x5fdVz5+4nTZUE2uH8UMLsKEQSTrtwRtG/PAKe/H7W09YcewBBbIY/nov
	Y5B5qlcBd5z4LXlHatMgdzQnqoiZRZqDjmTjpfrmdG3hvnNAx6IiOAN2Uuy/ya0t2YJ3KNwmpek
	Yagj6c+T8UQKn5uxPFPMESShtvkikgJg1wMc2ZOl1Ax0VM3NOHj1np1dNYTdzDuXWRBBk07atBM
	G8a3xcq+MsIvEBZV64xNangPi1fLovxBHYlu+7+Ozfa0QFuB/lyGUuGAAChTIKfKBGzQBl7U2am
	rHJYfmbfj18f+zDGgKs7J+ubS/wdfjXo/pX2uJBOY3ygDmvel54/9kap0ppIlZ7RMla/CU4loSi
	BCb9kzilCZ2R6OpPol/tleS46rC1E=
X-Received: by 2002:a05:7300:6144:b0:30e:c24e:2f01 with SMTP id 5a478bee46e88-30ee1404a70mr3317602eec.35.1782844640668;
        Tue, 30 Jun 2026 11:37:20 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:b5a1:965b:86fd:756])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3205993sm10888191eec.24.2026.06.30.11.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:37:20 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v3 0/2] net/sched: sch_fq_pie: add per-flow class statistics
Date: Wed,  1 Jul 2026 00:07:00 +0530
Message-Id: <20260630183702.170798-1-hemendranaik@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,vger.kernel.org,gmail.com,nitk.edu.in];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303331-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:jhs@mojatatu.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:vishy0777@gmail.com,m:tahiliani@nitk.edu.in,m:hemendranaik@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B4806E738B

 FQ-PIE runs an independent PIE controller per flow but exposes no
 per-flow statistics. This series wires up fq_pie_class_ops to expose
 per-flow AQM state (prob, delay, deficit, avg_dq_rate) 
 via 'tc -s class show', following a similar pattern as FQ-CoDel.
---
 Changelog:

 v3: 
  - No changes since v2.
  - Resending as the previous submission was deferred when the net-next tree closed during review.
  - Corresponding iproute2 patch updated in response to review comments; no changes required for this patch.

 v2: 
 - Addressed ABI backward compatibility issue for tc_fq_pie_xstats. (https://lore.kernel.org/netdev/20260614125000.6058-1-hemendranaik@gmail.com/)

 v1: 
 - https://lore.kernel.org/netdev/20260531125314.22492-1-hemendranaik@gmail.com/

Hemendra M. Naik (2):
  net/sched: sch_fq_pie: add per-flow statistics via class ops
  selftests: tc-testing: add fq_pie per-flow class stats test

 include/uapi/linux/pkt_sched.h                |  29 ++++-
 net/sched/sch_fq_pie.c                        | 118 +++++++++++++++++-
 tools/include/uapi/linux/pkt_sched.h          |   4 +-
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    |  22 ++++
 4 files changed, 163 insertions(+), 10 deletions(-)

-- 
2.34.1


