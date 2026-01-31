Return-Path: <netdev+bounces-255549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rGARLtuUfmn9awIAu9opvQ
	(envelope-from <netdev+bounces-255549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:48:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3CC4677
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EDF3301051B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8758D38A9D0;
	Sat, 31 Jan 2026 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxFFzMzk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258236606F;
	Sat, 31 Jan 2026 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769903319; cv=none; b=WhEiWeWRjlUWPFDRVpryhKEX/EjY6NODqgLQ1s/e8fnot9BSkiSV3BtwmyMZk56u0PSAMKW5WzMbuca4tKHU9cTaaMUDo2m1j6L2Do/YsxSBxHJyl93FyrvH+7GJMXbq+lXBCUUdVsIcx0RtF/lgDUNfST4VWSyRTSk/tjOiwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769903319; c=relaxed/simple;
	bh=5cJYr6GlNYZ43Vw7dwNjQsA30lMlMFKZk92gLAW31SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYKugUL3P5LL43QvaxUA+K80T/gZBaLZkJzM+imrAKahbjJ0tA2Q1rYMETMkNfmr+JjrmHRJKP/SsM5nrwii2QPc/ZpoxVOt7uF3VNAuYxFRcNuBstpB+ICvUXLxY+T4/wIaHVUUnRViDDvuWfkyOjCDAd3bhOzMYAz8D3pKHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxFFzMzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82107C4CEF1;
	Sat, 31 Jan 2026 23:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769903319;
	bh=5cJYr6GlNYZ43Vw7dwNjQsA30lMlMFKZk92gLAW31SQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QxFFzMzkgNPkgJJXsdARqCFLNzwQx+e0LzxLEXfCGC/i7GsABX8qFSeqFqEmitBLS
	 LoBwbxedHTYuM+QJp2BYfTfcgdMlMTKC6HCey3S59y5oP9lVPQ98Li9mevHj+/m6OZ
	 9Y3CtWXGPzuE4gtDU3+tEhDpgeqXs3uHq5mcJiJmDpLB9miw3h6nPyqle+8maamEfl
	 R90ygYr2NG3o5LwgZGJeNldxoiFCvHYw18H48byCc5BuHncVfV5TAcvR1jhSooqQoZ
	 81UiqaZ9FQKlcgy2zoKVf4j5rlJKtPX0WJK2TxoWgkGbXVawTXdISWZy+t5rHao15C
	 QvF13MaKnTNRw==
Date: Sat, 31 Jan 2026 15:48:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 05/16] net: Slightly simplify
 net_mp_{open,close}_rxq
Message-ID: <20260131154837.312cf828@kernel.org>
In-Reply-To: <20260129222830.439687-6-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-6-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255549-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08A3CC4677
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 23:28:19 +0100 Daniel Borkmann wrote:
> -int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
> -		    struct pp_memory_provider_params *p);
> -int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
> -		      const struct pp_memory_provider_params *p,
> -		      struct netlink_ext_ack *extack);
> -void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
> -		      struct pp_memory_provider_params *old_p);
> -void __net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
> -			const struct pp_memory_provider_params *old_p);
> +int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
> +		    const struct pp_memory_provider_params *p,
> +		    struct netlink_ext_ack *extack);
> +void net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
> +		      const struct pp_memory_provider_params *old_p);

SG, but netdevices.rst says:

  For the (mostly software) drivers that need to interact with the core
  stack, there are two sets of interfaces: ``dev_xxx``/``netdev_xxx``
  and ``netif_xxx`` (e.g., ``dev_set_mtu`` and ``netif_set_mtu``). The
  ``dev_xxx``/``netdev_xxx`` functions handle acquiring the instance
  lock themselves, while the ``netif_xxx`` functions assume that the
  driver has already acquired the instance lock.

Let's take this opportunity to replace the net_ prefix with netif_,
if we want to assume that the caller took the instance lock?

