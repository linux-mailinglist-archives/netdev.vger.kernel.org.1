Return-Path: <netdev+bounces-288321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AmhCmQmB2oEsQIAu9opvQ
	(envelope-from <netdev+bounces-288321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:57:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8E2550DED
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE1E3046EBB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CABE48A2CC;
	Fri, 15 May 2026 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="frA/4vE7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED0481A93
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853117; cv=none; b=D5gGR6xJ7C2LnQhppMk3ZWcyz9RE5reQSQHcXqwToo1zYT4v2/MJBte65SA0jmBL8ugtXkXbk5qB+rPl9+WzG537HtCeULIWlHEZrq6AOETyONPWTacnuBUoIEFanHd+xW/t+dVdD9KkKE0Dwzf11Xz9FxIHnBxXBKoU9GTj7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853117; c=relaxed/simple;
	bh=mwbCUn08CWMwL0woqy177gkj8PZXx4Uk/KthAashRy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SH9I/AqXaaK6tGOrCwMUVAgaJ5xl11CxdrTA686ItINQfncoaSrFBJIjoK158vao7+DdmkpTKIKBPo35dOqx9mxRXq+yH+1oNe8fUKMw4jJ4XUQllMS30NTx4p1kEPKca23B+ekVTp9624T4OL0///srRMifkrhCnRGFvt7bWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=frA/4vE7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48d146705b4so108744405e9.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778853114; x=1779457914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmJGUnALjoD0KZePhh+NZjTK3Hla1q67wmp2q20EKW8=;
        b=frA/4vE7ssPD+QcC4Tcl+xLZt2FpelSuKYFowxo51rSoM4XuJ/Q3z7jmLPusNU6bjK
         eMpAaN23JWjqy7jaoHyYtaHorGgJAcSrMqzCmWPFg+PwvjjoOj8F6aqHm4iGYdtbaW8h
         /O5lgszeW58qhpiWvdFuHMfDcaqFEyDuqoaU1hFNgUGyCx/vu0WqNP5hw3Zf1TRecngq
         I3TrYPsUS8FFq5sm5dT0o0bp/az6oEax8Tn2ktsKMfK8LpxxvsPJUcaUy9dWhfbM1fPr
         DBGs/81vh5n2mkIETeDfu+hAcJV3agQWkgnKrMiFFPSHWWlNgvh+d16Hn/7J5P/ugayu
         xa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853114; x=1779457914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OmJGUnALjoD0KZePhh+NZjTK3Hla1q67wmp2q20EKW8=;
        b=I7MOaTO5qx+9juJEF+dzFpw4Zr7wTrHGz8MpkzOi1f5pXtbGoOPCSf8YRZS1XkiQeE
         TH2pt+Pjt/UXPcqdOG/UIevS0Y0B0Z7vwgnKQUPaVMay36KRten+3GuyKp/1OPPP5KXH
         YCANknrtjyUWvYYN32xBnngxRLDFgEYp1facfy1WMyWFm22zuSdZ1PemQax0lAIW5xSu
         3/eSWKdoWBQfdNmBol05iVnu0cAyTYsRCNryzLpjuNbnvgFN4FGtu0hQPPOaQhRIT75f
         6iWr9j/JRWkFgxr/TYQkzjyzAnJhmw40E8RRSAIA0xCfkma3Nig6OcDWkYtX7JUu3PTG
         wOdA==
X-Forwarded-Encrypted: i=1; AFNElJ/0IjlmO2tvB2iR49kAYveaNbpcrcTbmL3N9I03mu7MIzKiXkw0juwtGmXMMdcZReR9bZ8XUMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz9yRRRVNvzxM/rlezx26MSPw+hYDK6mxFqkHSqOIVfSYB/LE/
	qlWn6ZHdjpKXPFmCIbSo5eEDwWcMpmvbmMNsdkwAtqu2LskyDVxgAkw0baAng6Kvfj8=
X-Gm-Gg: Acq92OEM84UgbKOUNxAg/dWw/OEAw7DfHzPOOA788KjGqYjiTqET4gSNWqaN7DPTCy4
	nO+TT1taBe4gImgleO55P4vFhf8H6wepCXpApVF08ddt6vU4Nb2t/dGokoVBF80v+pfFpK+tLTQ
	yYBlbySLoXQrsbxjvVhsApoXJaqo56ePhV+JSMdmhFTitnomwOP/F7M+AGDlFFgHvEMqrkID4Eu
	onV2v5ZU1ckSPYMAJDNS+eA9bC+5rnx12vHKxUDHbGrb7DrVeqaPiS1U1ZORdl9SZs8VYvJCWmO
	VNyWWl3dtxEPJFSJWQDhF8ze3f/w5bIr8Vg9Vak1lh/5CYonZzsUZ3In+mPiZTw+7hecOG33b6l
	piqmegHbqcoT6+aD+P8ad6TAoo5QoLACkfK2XSyOpodvZN/cwxltYRIQ7VNtI2LObofyi8UKR2I
	hQUDWHAQoZSLtbiSpR4xpSs00JAEZ82x3Qyf6UAWlHcWQb9Q3pFyKH5pvIXg==
X-Received: by 2002:a05:600c:34c4:b0:48a:89d9:a419 with SMTP id 5b1f17b1804b1-48fe60ecdafmr58940795e9.11.1778853113974;
        Fri, 15 May 2026 06:51:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdafc6741sm79592675e9.2.2026.05.15.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:51:53 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 1/2] ipmr: Replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 15 May 2026 15:51:36 +0200
Message-ID: <20260515135143.259669-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515135143.259669-1-marco.crivellari@suse.com>
References: <20260515135143.259669-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C8E2550DED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,google.com,davemloft.net,redhat.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-288321-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Cc: David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 net/ipv4/ipmr_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 3930d612c3de..867b24beded1 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -39,7 +39,7 @@ static void __mr_free_table(struct work_struct *work)
 
 void mr_table_free(struct mr_table *mrt)
 {
-	queue_rcu_work(system_unbound_wq, &mrt->work);
+	queue_rcu_work(system_dfl_wq, &mrt->work);
 }
 
 struct mr_table *
-- 
2.54.0


