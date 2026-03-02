Return-Path: <netdev+bounces-262680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLoYHkKjpWngCwAAu9opvQ
	(envelope-from <netdev+bounces-262680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:48:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F09AA1DB241
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A1CF30557EC
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F1C38F654;
	Mon,  2 Mar 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNUQdBxF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A203E5581
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462600; cv=none; b=ErLvAyZT3BvJFwK09ITlagrFZTxva4Tg0YlpXbYEcBOZeKGWiLzhLF5hYxkECs21CW29Tw4hmVPa17VrHpIbXwojYc/mPX8Hg5bpLPDTGrzF7jWZU/0vq2em1ORrsTJoP8q4wedZDjeZSo6TzCjw0ZEVivPJlGGcc0BGWETqBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462600; c=relaxed/simple;
	bh=HyZ/X+XkjYMqup66IEVA1KUZDRvk694MUw+2hwZ/CIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqPdbjVzPw9mxPQFwaFRzCCmHZRS4xlDTNpUm0amxMHfUHpCIng+UP9usodwYww9xAEusXoYdXY0Ce6njkn2ftl5gfmUUOzB+Cv6mGnaPxwM98hpZ3OeWV5eSAj3Wt7u+ceYPUmlU4xCCMlFnweuZuyyi1EU0EcwBHYFYnhmI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNUQdBxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFBEC19423;
	Mon,  2 Mar 2026 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772462599;
	bh=HyZ/X+XkjYMqup66IEVA1KUZDRvk694MUw+2hwZ/CIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XNUQdBxF+L+WpkeliCDi37gjxI2Xxcb+C6qKxF8j6gFPpm1oYuWAP9DJyjhj9xXdd
	 JIwwAa8dAle6+q6/zxaonsxTd5IyqJfR7cIBbvWO/yJEQBcKaCr3Td/g9c0lJAh6Ve
	 S47m3S3kkhJhy+LcRM+l4JbetZObLJ08U+SDadjMzZ7ZD2uEVA228LtFpI/PXk0/vL
	 lUF97JrH6q7OZK73yQwXwB49PcTt+gFUmNMoLgw488wWjM19qrMYFV8C8WCpBItGHm
	 wC4iJxYqvDt0dNPJtoNjpgj5kaH+kfQH1tAlMkQsdt8Fevl9nRIDWRmKi0NZnGNBXt
	 SGJox18ymFoVA==
Date: Mon, 2 Mar 2026 06:43:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net] ipv6: fix NULL pointer deref in
 ip6_rt_get_dev_rcu()
Message-ID: <20260302064318.6d55533d@kernel.org>
In-Reply-To: <859d39ff-cb1e-4f3f-b154-d8bf2c7997c9@kernel.org>
References: <20260301194548.927324-1-kuba@kernel.org>
	<859d39ff-cb1e-4f3f-b154-d8bf2c7997c9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F09AA1DB241
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262680-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, 1 Mar 2026 18:38:53 -0700 David Ahern wrote:
> > @@ -1063,7 +1063,8 @@ static struct net_device *ip6_rt_get_dev_rcu(const struct fib6_result *res)
> >  		 */
> >  		if (netif_is_l3_slave(dev) &&
> >  		    !rt6_need_strict(&res->f6i->fib6_dst.addr))
> > -			dev = l3mdev_master_dev_rcu(dev);
> > +			dev = l3mdev_master_dev_rcu(dev) ? :
> > +			      dev_net(dev)->loopback_dev;  
> 
> how can the flag on the netdev say there is L3 master, yet the device
> not be there within an rcu window?

1) We call netif_is_l3_slave() twice, once here and then again in 
l3mdev_master_dev_rcu(), the flag may get cleared in between the two.

2)

static int do_vrf_del_slave(struct net_device *dev, struct net_device *port_dev)
{
        netdev_upper_dev_unlink(port_dev, dev);
	// No sync RCU here, also I'd say the order is inverted?
        port_dev->priv_flags &= ~IFF_L3MDEV_SLAVE;

