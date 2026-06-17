Return-Path: <netdev+bounces-300250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iC2gJz8YM2qk9QUAu9opvQ
	(envelope-from <netdev+bounces-300250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:57:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AAD69C979
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:57:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QiLhRK8r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300250-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300250-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A823034B2D
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA73C5DDB;
	Wed, 17 Jun 2026 21:57:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D263BE630
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 21:57:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733435; cv=none; b=FA/i3uD7LRRIo1Va9fVdL+wedDDounSWcTBm6lSNTaisMMD+iY+eGN9rsEFIETihpwjsmpD9zgSujKoPRrhVy08cVGN2xbgNW1Mv5UsSSucDddvPUPAVf/hg+/+DEQXKN5pmvQHCvkqnxkVLMbVRGzcTwC0G4hOsnUxbVyasAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733435; c=relaxed/simple;
	bh=sOUDH/eBmJIXEIBOWDo6NLiv7IeXNalHO5VNllEyR4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjUz8msaICfH9qI75Tq8a2pymp7sBhmc4ye0ZU4d1Ea8a5qbxfT252tbCBRGSm1tVGLy2UQ0LLfMslqb/vqjxwbuX4CKdwyMFUna3eV/FgLRM5yty/BZSZHPnkR7ca6+IIZuqSnFFc4vAXw7hM3wGGFVMhP8Oz8vgnvAFWPAsUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiLhRK8r; arc=none smtp.client-ip=74.125.224.43
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-660390acd71so1527544d50.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781733432; x=1782338232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4i79txrSdWrklA7gXTPspyO0HfIb8EB9otPoipYJpQ=;
        b=QiLhRK8r51/esrPFFE3uE1dzndxQLqNKe5FwJmESKWRcY+wmASyzR9pp0KB8/NOKSZ
         bxULrhjRkcx8L/7dspE/zJM8gQIf1CdRB8L9JuTLie9yvZJXWHwl35KDUYuEzVRITG6E
         sVLPewzTgD/keq98hfWa2FZHmjbA0thQk4Uk4dGM0tBshCZ10+KZBkw6JXUfcTBvKOGc
         z7iNTUEY4tG0DA0j7iBbPQkNgvK7PV2M+mof0srraSVo4kMlIz03ioCuwvZA9siOH7xo
         b+OT5DfRm/t0fEJjTMlH6vhApxR1d1o3fa7wb4oNdzEGkNvmnPAXj43dqCnGTICYLecq
         o8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781733432; x=1782338232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4i79txrSdWrklA7gXTPspyO0HfIb8EB9otPoipYJpQ=;
        b=jvhBYDzQHtJJm9A++nWYDdwUWXN83l0uS11OMYRVm1IhYcdKqobCmXBYlABHbjYiR1
         0Bbhw2+r8KpM87Xc7e+/MrdQzHyFAg3k8uvP7wNE8Mk6B2UquaoMgYL0eG9aeRfw37Uq
         HU+5wdW8vfmbt+KnKNVPeI9oh0luLYJZAAmv4FH2DVTZ4lbgqInBxnTyhiU4VF6L5qvv
         fLsarEIrwa/JSnd27O8U32xPh46nKNs4CS2A6QukPdzMpEWUw/neJ3chmcBzKiqQxFMS
         YWkfaVPFCWQ0rZaAOJG4KyEF86thMWx53yCo13tkZ/vNmsLAYozhgWs1Ntk47gG/C52s
         f5LA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ul03L/HtqbP6DVejGynIn2TORsp1KrxQMAxEzFXG863Yahw+ufG2iKFVnsiVv6YcWwKpL3lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOnzRLpu4Op4DwCQnfWo67f0UYBdZdlcTWVyOSNfxMoInBbGXv
	8/fy2OJjqV0hRW3QuT2u+97oOvAPAFDwXEORN48x1mGYc1jrZ3kC2g1g
X-Gm-Gg: AfdE7cmhqW+IUZQ4HZ0WNgtRKDdNy/pQ/tUIw5js5RQqYJw6ZpQcE8F+cxj+zu5zlDs
	LGOhJPQeIe2GJ+FizgeGStqtdclT/GNvrEa03Mh4MpqEtdK8NjjFBUWg/gmOT8CIDSDknNsDB/8
	ly+jBFDbMeHNutGqtmMSrhQWTeoONlBSHLvjcfUuY6RtPFtNJLLkWPN/F9vv+sHkKjZqQUVNMbW
	mi679ee3pkv3ki48J5FrSlvWwLVCoijL7HEKsVLn6iMKrGiyMDKF/s08rGuJ1S3m0r27LKy9KyP
	2UwfGmaFSWHro0EmtQQ2WeqQPlX4Vv6wJAZpR04r+k7wo2snXfdUCi/Pbg/yPOdN2LUpAYIq1Rf
	dXdMUmQH9UN1FByEZHkAbQ74hWmEzu66Ptw9WRpdBdeFQljG9bfLWVSZwGsuwwBLQMdBDPSifre
	pUu7tGBFUW/A8kVIyZhkOnA5GjpGpl5uMHHaeLVYmjsBTRVtO8jNSd2RXFjSndDNHZ5WtSvht/a
	8nRPW6nBG2mFJOzsT7mA9/NPzn5sVXc
X-Received: by 2002:a05:690c:7107:b0:7dd:a645:a57 with SMTP id 00721157ae682-7ffa0a80b1bmr13574617b3.10.1781733431970;
        Wed, 17 Jun 2026 14:57:11 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7fcd3465c7csm55945147b3.39.2026.06.17.14.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 14:57:11 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/sched: act_ct: fix nf_connlabels leak on two error paths
Date: Wed, 17 Jun 2026 17:57:08 -0400
Message-ID: <20260617215708.1115818-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300250-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:jiri@resnulli.us,m:pablo@netfilter.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1AAD69C979

tcf_ct_fill_params() calls nf_connlabels_get() (setting put_labels) when
TCA_CT_LABELS is present, but two later error sites use a bare return
instead of "goto err", skipping the err: nf_connlabels_put() cleanup.
They also precede the "p->put_labels = put_labels" assignment, so the
tcf_ct_params_free() fallback does not release the count either. Each
failed RTM_NEWACTION on these paths leaks one nf_connlabels reference:
net->ct.labels_used is incremented and never released. The action is
reachable with CAP_NET_ADMIN over the netns, i.e. from an unprivileged
user namespace on default-userns kernels.

Impact: an unprivileged user with CAP_NET_ADMIN over a network namespace
(e.g. via user namespaces) leaks one nf_connlabels reference per failed
RTM_NEWACTION on the two error paths; net->ct.labels_used is never
released.

The err: label is safe to reach from both sites: p->tmpl is still NULL
there (kzalloc'd, not yet assigned) and nf_ct_put(NULL) is a no-op, so
no inline release is needed.

Fixes: 70f06c115bcc ("sched: act_ct: switch to per-action label counting")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Testing: refcount/counter leak (CWE-772); no sanitizer for this class, so
the oracle is the nf_connlabels accounting counter net->ct.labels_used.

Reproduction (UML, before/after, same trigger): CONFIG_NET_ACT_CT=y,
NF_CONNTRACK_LABELS=y, NF_CONNTRACK_ZONES=n (forces the zone-disabled
path). A raw RTM_NEWACTION trigger adds "action ct label 0x1/0x1 zone 1"
20 times; each returns -EOPNOTSUPP.
  stock:   net->ct.labels_used climbs 1,2,...,20 (get, then bare return,
           no put) -- 20 leaked counts, never recovered.
  patched: counter stays balanced (get then goto err -> put); baseline.
Control: the same loop without "label" (no nf_connlabels_get) leaves the
counter unchanged on both trees -- the trigger reached the labels path and
the synthesis is not itself the cause.

Conditions: reachable via RTM_NEWACTION with CAP_NET_ADMIN over the netns,
i.e. an unprivileged user in a fresh user+net namespace on default-userns
distros. The easy path needs CONFIG_NF_CONNTRACK_ZONES=n; the
nf_ct_tmpl_alloc ENOMEM path leaks on any config under memory pressure.

Mitigations: restrict unprivileged user namespaces; otherwise none short of
the fix. Harness (trigger.c, init) available on request.

 net/sched/act_ct.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 6158e13c98d35..f5866a364a74a 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1295,7 +1295,8 @@ static int tcf_ct_fill_params(struct net *net,
 	if (tb[TCA_CT_ZONE]) {
 		if (!IS_ENABLED(CONFIG_NF_CONNTRACK_ZONES)) {
 			NL_SET_ERR_MSG_MOD(extack, "Conntrack zones isn't enabled.");
-			return -EOPNOTSUPP;
+			err = -EOPNOTSUPP;
+			goto err;
 		}
 
 		tcf_ct_set_key_val(tb,
@@ -1308,7 +1309,8 @@ static int tcf_ct_fill_params(struct net *net,
 	tmpl = nf_ct_tmpl_alloc(net, &zone, GFP_KERNEL);
 	if (!tmpl) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed to allocate conntrack template");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err;
 	}
 	p->tmpl = tmpl;
 	if (tb[TCA_CT_HELPER_NAME]) {
-- 
2.53.0


