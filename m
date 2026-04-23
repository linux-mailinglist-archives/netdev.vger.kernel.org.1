Return-Path: <netdev+bounces-280843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCyuAjtq6mkHzAIAu9opvQ
	(envelope-from <netdev+bounces-280843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:51:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7333D4563BE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07FE13018431
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E537CD45;
	Thu, 23 Apr 2026 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg4+YDhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21526E6F3
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970291; cv=none; b=bB5KK2K015xT/SfeYBPArj3HgTbr2JsvFChkSdKPK2Nc6R2ClYDSgVruc/m61ZK8xN5r6h0jSqaZw99WyD6dAf+roUU6LFyXrlCxUJ7osbEPIPmLRbliWGFVuMb7R2k9NdR4/Q72wFfBR9ZJDrPeiejkzFQHkYpLoRCc3fTmUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970291; c=relaxed/simple;
	bh=l950K2FlxNreTAz1ukcoZ1SUlGhJm11Uwuj4OiIkmYE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSWqxdjwKmyLTHZVmhChvNU+jSYh4NuVdZYqUxZoUY7QFT689p1pUhWJb/CeicQkc+YPMDzsTtm75eKE/W2eDqNJ8G3MASiya1xnyUXTiJP4OOF5rdjQq3e/f9rDpV3G2zsyUYLblhGV3OJ8Z9JMw3UrPFrbE9OjoFxHCD5RLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg4+YDhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E634C2BCAF;
	Thu, 23 Apr 2026 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776970291;
	bh=l950K2FlxNreTAz1ukcoZ1SUlGhJm11Uwuj4OiIkmYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cg4+YDhiFh06VsMhJSNrwj6D1J2kkM6ANisoKVW/3g/JrEgkODICXOomNCOVI1RzH
	 +ElNyZKGdlj55nInv78HZ57kwgHJae0vI8l7Hpr/amSLAhvOzR/PV+88+MWbqOHHK2
	 Yvwbqt+99wMRq7xYX83Oyw3fddr9tczyXLL7O2kF4USP8M+VsOLfXT3E+zx/mlxPAm
	 nzJrkXuBfT15RncOfJhZsF/up5Hhm3VlHVFTOF5eUQ3UZ7gOol+S71mjAhhiC4g/D4
	 xyTDZLMxq/RHYJltH6MWAOtF+Xmq5Sl4CTLu6G/sJjST9+JGJmZxEYhqXzSp6SAAev
	 6A5KpfeotiDlQ==
Date: Thu, 23 Apr 2026 11:51:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: jiri@resnulli.us
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, jhs@mojatatu.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, sbrivio@redhat.com, vladbu@mellanox.com,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, kanolyc@gmail.com, z1652074432@gmail.com
Subject: Re: [PATCH net v2 1/1] net/sched: cls_flower: avoid stale mask
 references after delete
Message-ID: <20260423115129.6d8cbd15@kernel.org>
In-Reply-To: <20260421160303.1919562-1-n05ec@lzu.edu.cn>
References: <20260421160303.1919562-1-n05ec@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,mojatatu.com,davemloft.net,google.com,redhat.com,kernel.org,mellanox.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-280843-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7333D4563BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 00:03:02 +0800 Ren Wei wrote:
> From: Yuhang Zheng <z1652074432@gmail.com>
> 
> cls_flower keeps filter and mask state separately. After a filter is
> removed or replaced, some paths can still need the mask data associated
> with that filter.
> 
> Cache the mask key and dissector in struct cls_fl_filter when the mask
> is assigned, and use the cached copies in dump and offload paths. This
> avoids depending on the external mask object's lifetime after delete or
> replace.
> 
> Fixes: 92149190067d ("net: sched: flower: set unlocked flag for flower proto ops")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Yucheng Lu <kanolyc@gmail.com>
> Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Jiri, do you have an opinion? Feels slightly wasteful (as sashiko points
out), IDK if there's a cleaner fix.

> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 099ff6a3e1f5..c1f10b4ec748 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -124,8 +124,10 @@ struct cls_fl_head {
>  
>  struct cls_fl_filter {
>  	struct fl_flow_mask *mask;
> +	struct flow_dissector mask_dissector;
>  	struct rhash_head ht_node;
>  	struct fl_flow_key mkey;
> +	struct fl_flow_key mask_key;
>  	struct tcf_exts exts;
>  	struct tcf_result res;
>  	struct fl_flow_key key;
> @@ -445,6 +447,12 @@ static void fl_destroy_filter_work(struct work_struct *work)
>  	__fl_destroy_filter(f);
>  }
>  
> +static void fl_filter_copy_mask(struct cls_fl_filter *f)
> +{
> +	f->mask_key = f->mask->key;
> +	f->mask_dissector = f->mask->dissector;
> +}
> +
>  static void fl_hw_destroy_filter(struct tcf_proto *tp, struct cls_fl_filter *f,
>  				 bool rtnl_held, struct netlink_ext_ack *extack)
>  {
> @@ -476,8 +484,8 @@ static int fl_hw_replace_filter(struct tcf_proto *tp,
>  	tc_cls_common_offload_init(&cls_flower.common, tp, f->flags, extack);
>  	cls_flower.command = FLOW_CLS_REPLACE;
>  	cls_flower.cookie = (unsigned long) f;
> -	cls_flower.rule->match.dissector = &f->mask->dissector;
> -	cls_flower.rule->match.mask = &f->mask->key;
> +	cls_flower.rule->match.dissector = &f->mask_dissector;
> +	cls_flower.rule->match.mask = &f->mask_key;
>  	cls_flower.rule->match.key = &f->mkey;
>  	cls_flower.classid = f->res.classid;
>  
> @@ -2489,6 +2497,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
>  	err = fl_check_assign_mask(head, fnew, fold, mask);
>  	if (err)
>  		goto unbind_filter;
> +	fl_filter_copy_mask(fnew);
>  
>  	err = fl_ht_insert_unique(fnew, fold, &in_ht);
>  	if (err)
> @@ -2705,8 +2714,8 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
>  		cls_flower.command = add ?
>  			FLOW_CLS_REPLACE : FLOW_CLS_DESTROY;
>  		cls_flower.cookie = (unsigned long)f;
> -		cls_flower.rule->match.dissector = &f->mask->dissector;
> -		cls_flower.rule->match.mask = &f->mask->key;
> +		cls_flower.rule->match.dissector = &f->mask_dissector;
> +		cls_flower.rule->match.mask = &f->mask_key;
>  		cls_flower.rule->match.key = &f->mkey;
>  
>  		err = tc_setup_offload_action(&cls_flower.rule->action, &f->exts,
> @@ -3709,7 +3718,7 @@ static int fl_dump(struct net *net, struct tcf_proto *tp, void *fh,
>  		goto nla_put_failure_locked;
>  
>  	key = &f->key;
> -	mask = &f->mask->key;
> +	mask = &f->mask_key;
>  	skip_hw = tc_skip_hw(f->flags);
>  
>  	if (fl_dump_key(skb, net, key, mask))


