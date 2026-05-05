Return-Path: <netdev+bounces-284391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIJVHBDv+WlqFQMAu9opvQ
	(envelope-from <netdev+bounces-284391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 749C74CE5F8
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56A3C302AF65
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458F1D9A5F;
	Tue,  5 May 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="DcY6VX2G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450FB40DFC9
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986981; cv=none; b=PqqQbtCwjX9JQbprwz77hZINqxueVPmO16wPWoy3u8gbvLhDAREy86Oly9VIcP5oqji+doQ+mRk/FQsOqUsO0QZcJ1eT24hXQ08j4SzlFvMak/1xIlkRaDC59N54UriymTa9ZYH+B8UYYpRJ15NT1x8nTyOGfWEdB4P4rBztHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986981; c=relaxed/simple;
	bh=NuTkhQb/yaFpEfsB/uWznsZvvXPiwya/XdiQX2zly0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zizu+N46eh3qotBU+Fa7ACRqC016u3TjtCtcfSueeZcnpXQiKinG/wa7ZGdvFP7srMvJJ9sRXoamTroIXNQULXoR8fi3iafQjtT4UH34qV2XL2Z3WS0soVU57pUEnJ53+hBko1KgXiXEbuNb/j8+p03sbVpW4ZDklTbw8hqWVAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=DcY6VX2G; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8f15e900586so257320885a.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777986979; x=1778591779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYFiRoBcIxqbrWqZ6izWXMuYp7YAiDi6q8KNXqhIvLM=;
        b=DcY6VX2GxACNKFSw9fXNMDKxblOEMkvJ+kp9LE0jeszlTXjJ4Dezija12EdmJH2tKc
         op3BR1MkyL+TjTUkoH2jlfWDBANSW+durzzEGA6wLlA2nZYY7PJ8AKM/0/yD9mfWeDyv
         5ua18zTXnvJ3lj8x4zUDGkTbSI/JX0YtpXrpvN0czwbE/j5AyHOKYjFHcqSvuPY4ZqsG
         F70ov6SiQf5BaInZCI9oCQRq5vLtYu297nc5uXcfFLi0VndPJVvIhsPegmbXcnnAlHmQ
         83JSc3KiO8731tsDRh5GN49d/VZfaXkn23R3LVUmi5Ik7tWdeW1BT/nA7Dx9pJDdKzpQ
         ecdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986979; x=1778591779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYFiRoBcIxqbrWqZ6izWXMuYp7YAiDi6q8KNXqhIvLM=;
        b=M9nV3sVAvocdANLBLGfxVbT4r0ppBnbxjGlgIuM2+KzWFnvKMJBDgYayCgDmIIYBXU
         EGx9rMPFDqJEXCMU6uRihosxIk79cjgnr6qnHqegiJYSV4+ToRL0H40gr4Q11v3F2z7x
         d2e3/eyOm7WWNLhJC/uk9r+Ljgn1cpgbGWJX423oq0G3KuF6nF052GO6YD4e8Pp83jDH
         osNOB5/bX50xUlC2osUSyqb1jmnCA1uhs6TPyDdr1BXeYPb6Ow5D0uA8MrbyN6jJvDfW
         VC868H0yOIGSSoHhH6383qX2t9xMXMVNBhYOnm+E4hXcH+qezMuDbC//IzuSAY5uddiw
         dwjA==
X-Gm-Message-State: AOJu0YyJvwyeYySbDpkcRBGr0twv1ssKwhY7hmeYV6iiw0myUMJ9/vCy
	GuRxwz6V9F3mR7btH6x0KgJ6RUAe8svNXnPJ9hrOB4dV/VG7G8UmTBhdMR98FL195+1ytZmKIBm
	PlVA=
X-Gm-Gg: AeBDieseG8jr1wm0Dee/s+SEcdk1pIv4VcfsrZvie9nQukkYB+ewTjmuafEXBROSWH3
	Z+UnlcOwVSaE3BvIxDFikTkO30FhEd3c9G+nrKUjmZCSfLKIBaSz4rrn1sXTydNY6BSxBs40eGY
	rcH2gM+IudIi9XnAn/0UwyigmYs0pE5+a4CxUl6VEV0ju5MEUJUxJFD3H3+L/3C6ewpW8b900kn
	VOW1P6DskwqTI5P4fgJcpvwvQuTZ6l3coHImbgp0pAlGmA4pLFNoK/YwCrp46wnLnoGOxUCv7uf
	F/zThWrz/tytSXwYgmNqoBhLhjNTGulG423Y+iMyYR7tsk54Qy5ckq0a5e3nLxO/Ts+Em3cVpdl
	9537sPZza10HwXDeZVrT5P4xtsWsDJ1T+TQ9JeGrgyWU4Y2RdOFkuUO5UhSiEsFhQ5AW17JF0n0
	XhEY/jB6vL5up0IGb0NEWmDMAMo9np3KBfARGAYQ==
X-Received: by 2002:a05:620a:2996:b0:8ee:dc47:3b70 with SMTP id af79cd13be357-8fd18137bb2mr2122395785a.39.1777986978678;
        Tue, 05 May 2026 06:16:18 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd06f16sm1364219285a.42.2026.05.05.06.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:16:17 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	horms@kernel.org,
	vinicius.gomes@intel.com,
	graypanda.inzag@gmail.com,
	victor@mojatatu.com
Subject: [PATCH net 0/2] Introduce CBS reset ops
Date: Tue,  5 May 2026 09:16:02 -0400
Message-Id: <20260505131604.128605-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 749C74CE5F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284391-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,davemloft.net,kernel.org,google.com,redhat.com,resnulli.us,intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu-com.20251104.gappssmtp.com:dkim]

QFQ uses qlen to check whether it should reset pointer q->in_serv_agg.
When QFQ has a CBS child which has a netem child it is possible to create a
scenario where QFQ's qlen goes to 0 but the computation makes it underflow.
This then aggrevates a null pointer deref.

Jamal Hadi Salim (1):
  net/sched: sch_cbs: Call qdisc_reset for child qdisc

Victor Nogueira (1):
  selftests/tc-testing: Add QFQ/CBS qlen underflow test

 net/sched/sch_cbs.c                           | 12 +++++-
 .../tc-testing/tc-tests/infra/qdiscs.json     | 41 +++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.34.1


