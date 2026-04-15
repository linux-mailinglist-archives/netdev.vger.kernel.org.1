Return-Path: <netdev+bounces-278814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBEvObWl32miXAAAu9opvQ
	(envelope-from <netdev+bounces-278814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:50:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA81B40583D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF8093004D28
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B013D6496;
	Wed, 15 Apr 2026 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEe84pmT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAC3D522F
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264582; cv=none; b=usbDmNBcVkgML+UccPA+Jwd0x2056BEXN1h0IlHxislNLLSlOZChGTKkRs5n+jMbErG6q9kPXI/UbBr3HZKIz+QQsNv4lAN460ZBU1VNPR1ZMCYt+0SYKKpO2aVMVvstWTkAaZFmmJ2pl9h2hkvQNS3YoHPXqoU51m4mrjrLxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264582; c=relaxed/simple;
	bh=Rvw0RMpCeT0kdBKno0YfvWy1SQW2RXTBUHrxl1ziZmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHSGneO3GDoNT4earO38VJwhwlvikU4wtVnKDPo12H445wvPGKfJDOU3AACkh/VVaqNYri2x88hsb4h+p2Utp+o4FItWHQAoaP17YCWp9dHoKixCNXwWY3JpiY9kHbA3rq/96SJWtMDakCqjhxtW3lBOgpnVWBpG6WWdsZaWkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEe84pmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E172CC19424;
	Wed, 15 Apr 2026 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776264581;
	bh=Rvw0RMpCeT0kdBKno0YfvWy1SQW2RXTBUHrxl1ziZmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jEe84pmTSW4EbZkpz4QG3TRZwH1VeDdDuYk6Of7y45xGl6kfi8QLjJmvd9K4RcC9m
	 j9SOKQcBCLRQevKR8Da8oqhK2Qn17LIysXI4UnLWelgCKYXQONSimDI9P0gii02Ioy
	 pWPXAmd9/Ztv33KkfuW2OojEiB4HVAqY7Frd4az/RK3l6ccjzgnBvQBy8VvF0u41rk
	 O7TsufUJVdPzO2PhbRDaGHCoQnGp/UjnBTqmEs4RXy3JA3ruIT0S926GcPNsDsRETs
	 worYRKxj2h3fMlUIwT+2MgAfCGsog2zaw2rLMokqa1vPAvBz1wBvBFDQJWGNA2dvsp
	 kLbTkwxyhkL4w==
From: Simon Horman <horms@kernel.org>
To: n05ec@lzu.edu.cn
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	ylong030@ucr.edu
Subject: Re: [PATCH net 1/1] 8021q: free cleared egress QoS mappings safely
Date: Wed, 15 Apr 2026 15:47:28 +0100
Message-ID: <20260415144727.810720-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b877895cd02d35254b5c05d3c40abbf130cd87eb.1776039122.git.ylong030@ucr.edu>
References: <b877895cd02d35254b5c05d3c40abbf130cd87eb.1776039122.git.ylong030@ucr.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,lzu.edu.cn,ucr.edu];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-278814-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA81B40583D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
8021q: free cleared egress QoS mappings safely

This commit converts the 802.1Q egress priority mapping lists to use
RCU-protected pointers instead of keeping tombstones. It deletes mappings
when vlan_prio is cleared, deferring the freeing of removed nodes until
after an RCU grace period.

> diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
> index a000b1ef05206..bbe7cbd97939d 100644
> --- a/net/8021q/vlan_netlink.c
> +++ b/net/8021q/vlan_netlink.c
> @@ -260,13 +260,10 @@ static int vlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  			goto nla_put_failure;
>  
>  		for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
> -			for (pm = vlan->egress_priority_map[i]; pm;
> -			     pm = pm->next) {
> -				if (!pm->vlan_qos)
> -					continue;
> -
> +			for (pm = rtnl_dereference(vlan->egress_priority_map[i]); pm;
> +			     pm = rtnl_dereference(pm->next)) {

Is it safe to use rtnl_dereference() for this traversal?

The vlan_fill_info() function implements the rtnl_link_ops->fill_info
callback, which is invoked by rtnl_dump_ifinfo() to service interface
netlink dumps. Modern netlink dumps can operate locklessly under
rcu_read_lock() without acquiring the RTNL lock.

Using rtnl_dereference() expands to rcu_dereference_protected(), which
might trigger a lockdep warning when the RTNL lock is not held.

Additionally, it omits the memory barriers needed for safe RCU reader
traversal. Without these barriers, concurrent updates from
vlan_dev_set_egress_priority() could cause the lockless reader to observe
stale or uninitialized list nodes.

Would using rcu_dereference_rtnl() or rcu_dereference() here be more
appropriate to ensure safe lockless traversal during netlink dumps?

>  				m.from = pm->priority;
> -				m.to   = (pm->vlan_qos >> 13) & 0x7;
> +				m.to   = (READ_ONCE(pm->vlan_qos) >> 13) & 0x7;
>  				if (nla_put(skb, IFLA_VLAN_QOS_MAPPING,
>  					    sizeof(m), &m))
>  					goto nla_put_failure;

