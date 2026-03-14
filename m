Return-Path: <netdev+bounces-267741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPP2IPl3tWln0wAAu9opvQ
	(envelope-from <netdev+bounces-267741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:00:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA08D28D970
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85A7B3018ADA
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E137D126;
	Sat, 14 Mar 2026 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4WQH8Ne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B237CD41;
	Sat, 14 Mar 2026 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500406; cv=none; b=tYeRR4aWqu9ekyPIyXJ3NTZ/fllv7NBuvsEV9h+2GfoWv8WxFzdPNXKl4PoDKuCJ/hSiz038L/a66N7lnibb0ifCbGKNYvUEosVAJbFeaUcBfqTK1UFMHoNx2CUl03pXPPqeKAVr9+655JcwRoH6ntlTr4OY8YBI8ZjSazjlLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500406; c=relaxed/simple;
	bh=GPPo7UyZhsa34vSl+juXV9cWHndyC5ux+fomdX4hXxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAqM4LWulmfjTAS1BCbiuS/nV1BXoapdM5cqE0peqWcGrsFtU7kp4D21+Ip7BneAqxUve1a6PnB1149PakYxOV9DmtpsSbzZnN75+98Z0Jpeg335CenNV8ewN0S8SHC1lkYXmfziMzlEy8Zn6h84lHLceVukfzDaeWKennmxBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4WQH8Ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F09BC116C6;
	Sat, 14 Mar 2026 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773500406;
	bh=GPPo7UyZhsa34vSl+juXV9cWHndyC5ux+fomdX4hXxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H4WQH8NeAT2PaoMQAqqfNJ0e6dF5J9je+HIQckI7eVx5ReiBa/54cP11AJ0HDYAx2
	 7/6qkvNGzyvd8B1jm6+VA1a4/ucNTM/CY2sAOKiVNOCbJt/UrsytRYbRdJf7AcIDFh
	 EbInrsUs/+XrMrXla93s/LrPDFfGIc3U63t3qlrnwZaa6FAj7UJlrnrCH4AMt/Z73C
	 bh/hHbBvSCjVrsGvjDFAvT9oHnwO7iVVMLXPcgZjL1/k/S2RIEaHg00Puw+SI/lfMi
	 wzV5sI9aeBrwwbTi20Qbg7L9+Qcuh722fsoVsTXeT2t0rDoH8ujqiwI67+np6uMkaQ
	 Vk6xjVH4cXlZA==
Date: Sat, 14 Mar 2026 08:00:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk,
 vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com,
 cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com,
 km.kim1503@gmail.com, security@kernel.org, Victor Nogueira
 <victor@mojatatu.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot
 delete
Message-ID: <20260314080004.3e8575d8@kernel.org>
In-Reply-To: <CAM0EoM=KinOanha9nKJ=GyT2FU_o3Hg-tY5fWDfFO+PBuQfXpA@mail.gmail.com>
References: <20260307212058.169511-1-jhs@mojatatu.com>
	<20260310184713.7e810431@kernel.org>
	<CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
	<20260311175249.54abe1b6@kernel.org>
	<CAM0EoMnv14pSaJWW3ZQuegkbQEqqye0zp0-_tCaOEWEg=C3xCQ@mail.gmail.com>
	<20260312165113.773a5f44@kernel.org>
	<CAM0EoMm0dMRKJyfCH80G=q4PnnTzzKVRvSrAU204FFKMn9NOtQ@mail.gmail.com>
	<CAM0EoM=KinOanha9nKJ=GyT2FU_o3Hg-tY5fWDfFO+PBuQfXpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267741-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,toke.dk,intel.com,networkplumber.org,nvidia.com,lists.bufferbloat.net,gmail.com,mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA08D28D970
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 15:36:28 -0400 Jamal Hadi Salim wrote:
> In this specific example, the issue is that the classifier code path
> can't release the rtnl_lock while the qdisc's refcnt is bigger than 1.
> 
> Does this make more sense?
> The reason we went with the "mark for delete" approach is at time x+3
> the "qdisc add" wont be able to find this qdisc. This is the common
> observed pattern - for example described in the commit message where
> we get have a slightly different flow with "qdisc del" before "filter
> add".

Maybe a (completely untested) diff will help illustrate my thinking 
better than words:

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 99ac747b7906..c13c9e8619e4 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -27,6 +27,9 @@ void unregister_tcf_proto_ops(struct tcf_proto_ops *ops);
 #define NET_CLS_ALIAS_PREFIX "net-cls-"
 #define MODULE_ALIAS_NET_CLS(kind)	MODULE_ALIAS(NET_CLS_ALIAS_PREFIX kind)
 
+extern char *rtnl_load_mod;
+void rtnl_load_mod_check(void);
+
 struct tcf_block_ext_info {
 	enum flow_block_binder_type binder_type;
 	tcf_chain_head_change_t *chain_head_change;
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 332fd9695e54..c21dd2e36592 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1368,11 +1368,15 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
 #ifdef CONFIG_MODULES
 		bool rtnl_held = !(flags & TCA_ACT_FLAGS_NO_RTNL);
 
-		if (rtnl_held)
-			rtnl_unlock();
+		if (rtnl_held) {
+			if (WARN_ON_ONCE(rtnl_load_mod))
+				return ERR_PTR(-EINVAL);
+			rtnl_load_mod = kasprintf(GFP_KERNEL,
+						  NET_ACT_ALIAS_PREFIX "%s",
+						  act_name);
+			return ERR_PTR(-EAGAIN);
+		}
 		request_module(NET_ACT_ALIAS_PREFIX "%s", act_name);
-		if (rtnl_held)
-			rtnl_lock();
 
 		a_o = tc_lookup_action_n(act_name);
 
@@ -2107,6 +2111,9 @@ static int tcf_action_add(struct net *net, struct nlattr *nla,
 				      &attr_size, flags, 0, extack);
 		if (ret != -EAGAIN)
 			break;
+		rtnl_unlock();
+		rtnl_load_mod_check();
+		rtnl_lock();
 	}
 
 	if (ret < 0)
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4829c27446e3..1b0f762d6e4b 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -46,6 +46,19 @@
 /* The list of all installed classifier types */
 static LIST_HEAD(tcf_proto_base);
 
+char *rtnl_load_mod;
+
+void rtnl_load_mod_check(void)
+{
+	char *mod = rtnl_load_mod;
+
+	if (mod) {
+		rtnl_load_mod = NULL;
+		request_module("%s", mod);
+		kfree(mod);
+	}
+}
+
 /* Protects list of registered TC modules. It is pure SMP lock. */
 static DEFINE_RWLOCK(cls_mod_lock);
 
@@ -255,17 +268,15 @@ tcf_proto_lookup_ops(const char *kind, bool rtnl_held,
 	if (ops)
 		return ops;
 #ifdef CONFIG_MODULES
-	if (rtnl_held)
-		rtnl_unlock();
+	if (rtnl_held) {
+		if (WARN_ON_ONCE(rtnl_load_mod))
+			return ERR_PTR(-EINVAL);
+		rtnl_load_mod = kasprintf(GFP_KERNEL,
+					  NET_CLS_ALIAS_PREFIX "%s", kind);
+		return ERR_PTR(-EAGAIN);
+	}
 	request_module(NET_CLS_ALIAS_PREFIX "%s", kind);
-	if (rtnl_held)
-		rtnl_lock();
 	ops = __tcf_proto_lookup_ops(kind);
-	/* We dropped the RTNL semaphore in order to perform
-	 * the module load. So, even if we succeeded in loading
-	 * the module we have to replay the request. We indicate
-	 * this using -EAGAIN.
-	 */
 	if (ops) {
 		module_put(ops->owner);
 		return ERR_PTR(-EAGAIN);
@@ -2459,6 +2470,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		 * of target chain.
 		 */
 		rtnl_held = true;
+		rtnl_load_mod_check();
 		/* Replay the request. */
 		goto replay;
 	}
@@ -3230,9 +3242,13 @@ static int tc_ctl_chain(struct sk_buff *skb, struct nlmsghdr *n,
 	tcf_chain_put(chain);
 errout_block:
 	tcf_block_release(q, block, true);
-	if (err == -EAGAIN)
+	if (err == -EAGAIN) {
+		rtnl_unlock();
+		rtnl_load_mod_check();
+		rtnl_lock();
 		/* Replay the request. */
 		goto replay;
+	}
 	return err;
 
 errout_block_locked:

