Return-Path: <netdev+bounces-282593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJCPEKi38mnLtgEAu9opvQ
	(envelope-from <netdev+bounces-282593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:00:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1BD49C2B9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F9B130276B9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1327224466C;
	Thu, 30 Apr 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvTO2+mC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF550B672
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777514405; cv=none; b=mVca7U5ViNczCgNlC2l0I5QCHln0ND+Il+QSVcDi3rDOWE5ThR3JbNhgTLKi0yIp6fyY+y6fQKodrBTW8tiCo1vjoxPgZOr7PaYkVpYoSdxD+Tv5M6uvR9MbRF26rd4YNx8EmvKMHzJzRAoXbKgqLuOUFPzD/J+pMYB0BZaVvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777514405; c=relaxed/simple;
	bh=B6FsFeB3KyWWTfncPSh42chuXWXna92iSyPvit3Meuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJHV/vAijM7XZv21BC99mlkA1yOxnqDJekX9KJMlUH/U+rdMwFylHn/T3l4fJIrfc3kU2amqVbqa0yUvmqj8kto+smMbsCsHB1FtpRTylf7w5/KQUTnZloNLlkciOfi4m7XC3oJZYEM2EsywU0P0jRFSIWzBMx4K+VG9EkUlCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvTO2+mC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C58C19425;
	Thu, 30 Apr 2026 02:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777514405;
	bh=B6FsFeB3KyWWTfncPSh42chuXWXna92iSyPvit3Meuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvTO2+mCZgHNeKQnM073vj9syWAhE3ncwhmGNe4DF0av1pucviT/JTNoyrSXY9aAd
	 nv+EdTZ4GOGnwYWUVw2feBhAhczsbLc1wuKkO20NgnbGjDo8CzEObeWDKLbnPRNra4
	 to1SRhEXBhxOwLCh03ecwH3oofV6lUvCqKj/Xj6Umuvd2Mb2tzMtnSmJqvEd05c7/K
	 m8ht9O1X7cPESi2gJteezHBtJUEUOwU2ePAEAMIfKimrtEqV4hLiUrnn+GG6iUKyFI
	 SPd08+SVK8JLhdxt4nRW3anmVw9Tj28dAaFmZacfvfMPzDGWrNhOCmjgd95GreWhm0
	 1j9887D0Bnf4Q==
Date: Wed, 29 Apr 2026 19:00:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 3/4] net/sched: switch tc_dump_qdisc() to
 for_each_netdev_dump()
Message-ID: <20260429190004.2bb674d4@kernel.org>
In-Reply-To: <20260428170414.250566-4-edumazet@google.com>
References: <20260428170414.250566-1-edumazet@google.com>
	<20260428170414.250566-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CE1BD49C2B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282593-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 17:04:13 +0000 Eric Dumazet wrote:
>  static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
>  {

> +	struct {
> +		unsigned long ifindex;
> +		int q_idx;
> +	} *ctx = (void *)cb->ctx;
> +	unsigned long s_ifindex;
> +	struct net_device *dev;
> +	int s_q_idx, q_idx;
>  	int err;
>  
> -	s_idx = cb->args[0];
> -	s_q_idx = q_idx = cb->args[1];
> -
> -	idx = 0;
>  	ASSERT_RTNL();
>  
>  	err = nlmsg_parse_deprecated(nlh, sizeof(struct tcmsg), tca, TCA_MAX,
> @@ -1896,42 +1896,40 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
>  	if (err < 0)
>  		return err;
>  
> -	for_each_netdev(net, dev) {
> +	s_ifindex = ctx->ifindex;
> +	s_q_idx = ctx->q_idx;
> +
> +	for_each_netdev_dump(net, dev, ctx->ifindex) {

compilers point out that s_ifindex is set but not used since we iterate
directly on ctx->ifindex
-- 
pw-bot: cr

