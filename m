Return-Path: <netdev+bounces-303762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7E3qNURARWqm9QoAu9opvQ
	(envelope-from <netdev+bounces-303762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:28:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 565996EFCB6
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:28:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=f80RQC7J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303762-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303762-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 695113038746
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15352311C2C;
	Wed,  1 Jul 2026 16:19:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F9348C44
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:19:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922775; cv=none; b=Y3l1MkjdTT/BZkx3aOSKbQ5Ay7R+x8UMtbDLe7HjELbbL3iaMg8lm2JbisfR3lRv/HkVJfGpy8994jSMPECE0xNgt6xzcLp5lIl+gKdYEbo7s2I4xsrqR2BCwzs3dAEBDFx3aJEao+FwVZJuCA2dZxLJOr0WAuflpdbmIHDij0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922775; c=relaxed/simple;
	bh=Uf/n7QKFRPpvn6flJx97otAd8DbWAFxMfSF1vaH7eo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o5QspU1QH8GM0LgCjKFPunA9Sx/dqRrsdmPv9nJaAHSO7IFB0PAQHwXYDnsyTzMEtSqsJGr/lQQlZWjsjJJJtmgoVtYe9PTkt+n4aMLbn4jQs9iVTOtMcwVyqIANDKRIRP9e4eq+6ynUEmwSrHzu4IfZ71zHbpxEeHwCinrcvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=f80RQC7J; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e65e18969so63032985a.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782922771; x=1783527571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ckI+JdAlb9UtyST/QGohWOrUDVT+c26uP+nZIENTBVM=;
        b=f80RQC7Jm5Pu6hIL0sGQdXf9RloZMK/3aX8aVDPqANSCCT4ND54+wKxp30+2TppTGd
         VxyaFP/BH0o1Y5u5YpDoTnR/hysZoPsfQW8JLW8Me0cfSWUz94iak/tyiFpEI+ppZIYQ
         5maEZI+wwfgBZqXPEsXXngOk/CFOQa1D4+F6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782922771; x=1783527571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckI+JdAlb9UtyST/QGohWOrUDVT+c26uP+nZIENTBVM=;
        b=Fz3d1t3NN6wTdosxw9m9BUdDj/zgTd9/ZNblQ/CHp0TCmylVgW2Hi0amClTzw1nvm/
         xoP6rQvJyvF2cjO+Apl6glIAcrRZSDqABA0MgzCWsoG5DqkPmZyN/Q+1w43yFfXg2cGa
         XOIUjaETdcQD8ESrHYkWbqNUqKhjnYPI8mDTekqkuqeKu4QlLTmMeV+ddCGlSlHFk//o
         FZ8fg8N0BfGyGcD4zbjnFW5wDpHJ6iMTO7tz4hSOo7BUd4mtbX15xPO6S1EGRMBRo18v
         FzY2ITrkA3pgNx99+0GhyvU2VQXE5drBGu3ZtffcBLmfDOXLIVCkSf4GZy2CF3Rr82JK
         6faw==
X-Gm-Message-State: AOJu0YyegErmDDk8ukg8xWshm+YhmbeB7XhX0AJFa244bg7Tm+qaAZKp
	9yXWWF7v2oGmPBRV/pr6riiSIvDqDJfHOXOuyT0yseIpx9nsY/D/ve0cr659fB8XWt8MlmZrM/g
	wpyg=
X-Gm-Gg: AfdE7cljdyxceeA3izjEycmj5Zq6FahcsfFi1cEPNMncDhu3A9bSoqazVeaN9vGc5xa
	z84W9guDbkpIaEWcZWx6uH1YRbFXBrQq13CAJfqIFDiMFptESvjGpQPNWX7u9pVxs8JfZykeL0K
	O/I4hcdFJ18vretUILKRED3NhIlwCI282uwcy5WYT0B9dTwN5D6r62eMI8r+HH9TRGld8UoCWqG
	9adnNkopF3H/2iSRPDsMLBKWNu4UTEiM4RQYE2Z3z89ietVEkBU+4I4TV2SPgVcHhGq9V4OeufD
	HmQImZK3ICv2X1GIeLY3r04r5YEx8GjUM7opUEnCBp8Me/ekyFFwvrOrtl20jTprSRFX761zClo
	4q7A5R/FINvKIws5aUE2qxc48mpY8S1jGUOFzitMH5CH+IwL1W9fDmqjNGILBKXysX6MFy5piSX
	VpeFpiyA==
X-Received: by 2002:a05:620a:7104:b0:918:7e9e:de74 with SMTP id af79cd13be357-92e696e9164mr915456185a.17.1782922771448;
        Wed, 01 Jul 2026 09:19:31 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6233a5acsm602066585a.35.2026.07.01.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:19:29 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	victor@mojatatu.com,
	security@kernel.org,
	zdi-disclosures@trendmicro.com,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/1] net/sched: act_pedit: fix TOCTOU heap OOB write in tc offload
Date: Wed,  1 Jul 2026 12:19:12 -0400
Message-Id: <20260701161912.125355-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303762-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:security@kernel.org,m:zdi-disclosures@trendmicro.com,m:stable@vger.kernel.org,m:jhs@mojatatu.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 565996EFCB6

There is a TOCTOU race condition in flower lockless approach between sizing
a flow_rule buffer and filling it.
zdi-disclosures@trendmicro.com reports:
The cls_flower classifier operates with TCF_PROTO_OPS_DOIT_UNLOCKED
(fl_change runs without RTNL), while RTM_NEWACTION holds RTNL, so the
independent locking domains make the race reachable in practice.  KASAN
confirms:
  BUG: KASAN: slab-out-of-bounds in tcf_pedit_offload_act_setup+0x81b/0x930
  Write of size 4 at addr ffff888001f27520 by task poc-toctou/312
  The buggy address is located 0 bytes to the right of
   allocated 288-byte region [ffff888001f27400, ffff888001f27520)
   (cache kmalloc-512)

Note: The result is a heap OOB write attacker-controlled content into the
adjacent slab object (requires CAP_NET_ADMIN).

The fix introduces reading tcfp_nkeys under act->tcfa_lock in all places
using a new tcf_pedit_nkeys_locked() which replaces the old tcf_pedit_nkeys().
Additionally we close the remaining TOCTOU window between the sizing read and
the fill reads by more careful accounting.
Rather than silently truncating the key count, which leads to incorrect
action semantics offloaded to hardware and secondary OOB writes if
the remaining capacity is zero or consumed by prior actions, we enforce
remaining capacity checks and return -ENOSPC if the required space exceeds
the remaining capacity.

Fixes: 71d0ed7079df ("net/act_pedit: Support using offset relative to the conventional network headers")
Reported-by: zdi-disclosures@trendmicro.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/tc_act/tc_pedit.h | 18 ++++++++----------
 net/sched/act_api.c           | 13 +++++++++----
 net/sched/act_pedit.c         | 13 +++++++++++--
 net/sched/cls_api.c           | 22 +++++++++++++++++-----
 4 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
index cb7b82f2cbc7..97754ea0a827 100644
--- a/include/net/tc_act/tc_pedit.h
+++ b/include/net/tc_act/tc_pedit.h
@@ -37,17 +37,15 @@ static inline bool is_tcf_pedit(const struct tc_action *a)
 	return false;
 }
 
-static inline int tcf_pedit_nkeys(const struct tc_action *a)
+/* Must be called with act->tcfa_lock held to ensure consistency of parallel
+ * reads of the same action's pedit keys (e.g. flow_offload count vs fill).
+ * Note, this is only used for pedit offload.
+ */
+static inline int tcf_pedit_nkeys_locked(const struct tc_action *a)
 {
-	struct tcf_pedit_parms *parms;
-	int nkeys;
-
-	rcu_read_lock();
-	parms = to_pedit_parms(a);
-	nkeys = parms->tcfp_nkeys;
-	rcu_read_unlock();
-
-	return nkeys;
+	lockdep_assert_held(&a->tcfa_lock);
+	return rcu_dereference_protected(to_pedit(a)->parms,
+					 lockdep_is_held(&a->tcfa_lock))->tcfp_nkeys;
 }
 
 static inline u32 tcf_pedit_htype(const struct tc_action *a, int index)
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index b68be143a067..f141634df214 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -148,10 +148,15 @@ static void offload_action_hw_count_dec(struct tc_action *act,
 
 static unsigned int tcf_offload_act_num_actions_single(struct tc_action *act)
 {
-	if (is_tcf_pedit(act))
-		return tcf_pedit_nkeys(act);
-	else
-		return 1;
+	unsigned int count;
+
+	if (is_tcf_pedit(act)) {
+		spin_lock_bh(&act->tcfa_lock);
+		count = tcf_pedit_nkeys_locked(act);
+		spin_unlock_bh(&act->tcfa_lock);
+		return count;
+	}
+	return 1;
 }
 
 static bool tc_act_skip_hw(u32 flags)
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 0d652dea4a69..d4d47a9921f4 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -567,9 +567,18 @@ static int tcf_pedit_offload_act_setup(struct tc_action *act, void *entry_data,
 {
 	if (bind) {
 		struct flow_action_entry *entry = entry_data;
+		int nkeys = tcf_pedit_nkeys_locked(act);
 		int k;
 
-		for (k = 0; k < tcf_pedit_nkeys(act); k++) {
+		/* If the required keys exceed the remaining capacity return
+		 * -ENOSPC to abort the offload and fallback to software.
+		 */
+		if (nkeys > *index_inc) {
+			NL_SET_ERR_MSG_MOD(extack, "Not enough space to offload all pedit keys");
+			return -ENOSPC;
+		}
+
+		for (k = 0; k < nkeys; k++) {
 			switch (tcf_pedit_cmd(act, k)) {
 			case TCA_PEDIT_KEY_EX_CMD_SET:
 				entry->id = FLOW_ACTION_MANGLE;
@@ -606,7 +615,7 @@ static int tcf_pedit_offload_act_setup(struct tc_action *act, void *entry_data,
 			return -EOPNOTSUPP;
 		}
 
-		for (k = 1; k < tcf_pedit_nkeys(act); k++) {
+		for (k = 1; k < tcf_pedit_nkeys_locked(act); k++) {
 			if (cmd != tcf_pedit_cmd(act, k)) {
 				NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit command offload");
 				return -EOPNOTSUPP;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 3e67600a4a1a..ffeea6db8337 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3886,12 +3886,21 @@ int tc_setup_action(struct flow_action *flow_action,
 
 		entry = &flow_action->entries[j];
 		spin_lock_bh(&act->tcfa_lock);
+
+		/* Abort the offload if we have exhausted the allocated capacity */
+		if (j >= flow_action->num_entries) {
+			NL_SET_ERR_MSG_MOD(extack, "Flow action buffer overflow");
+			err = -ENOSPC;
+			goto err_out_locked;
+		}
+
 		err = tcf_act_get_user_cookie(entry, act);
 		if (err)
 			goto err_out_locked;
 
-		index = 0;
-		err = tc_setup_offload_act(act, entry, &index, extack);
+		index = flow_action->num_entries - j;
+		err = tc_setup_offload_act(act, entry, &index,
+					   extack);
 		if (err)
 			goto err_out_locked;
 
@@ -3945,10 +3954,13 @@ unsigned int tcf_exts_num_actions(struct tcf_exts *exts)
 	int i;
 
 	tcf_exts_for_each_action(i, act, exts) {
-		if (is_tcf_pedit(act))
-			num_acts += tcf_pedit_nkeys(act);
-		else
+		if (is_tcf_pedit(act)) {
+			spin_lock_bh(&act->tcfa_lock);
+			num_acts += tcf_pedit_nkeys_locked(act);
+			spin_unlock_bh(&act->tcfa_lock);
+		} else {
 			num_acts++;
+		}
 	}
 	return num_acts;
 }
-- 
2.34.1


