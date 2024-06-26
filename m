Return-Path: <netdev+bounces-107079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8A919B66
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 01:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736BE283A59
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 23:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2AD17E917;
	Wed, 26 Jun 2024 23:49:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447015E5B9
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445780; cv=none; b=AhpbWYobVRxF0p8GAZKpPXdyRTVmQ2bZGt5JbUaVeQDWftY+EW5laEHS0kex95extEOs0zXzpcitzDBULKC00MLDHWp00M4O++yHGsq/YqArNKKURmVgE1X5LfQM2LaXOyGiy3ih5hlkATVTeSpuzSEIYi6zymnRPH3tuEZeMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445780; c=relaxed/simple;
	bh=8SW+GxZo5Q4/2zIuMR8732zGeW2vwfctVU/bsTrW/xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAJLEeZxfXLx5tGOw68BdlqL5E3UtbN8ZdEYd3ta0gb98Kh7KXNiOVCnTWFCsCnUl98uIG1/QtUi0b3LmZkqjwzqvOr1X4OinPHpEU12JUAP/eL0NmgavQe64B1V9HerAZ6YDuvNxqvgNkAxK7YWh7aImabQxDx7371Z6B1Bm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=49806 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sMcOK-008kc4-Pw; Thu, 27 Jun 2024 01:49:35 +0200
Date: Thu, 27 Jun 2024 01:49:31 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, willemb@google.com
Subject: Re: [PATCH net-next v2 0/2] net: flow dissector: allow explicit
 passing of netns
Message-ID: <ZnypC7iOx_qtUH37@calendula>
References: <20240608221057.16070-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240608221057.16070-1-fw@strlen.de>
X-Spam-Score: -1.8 (-)

Hi,

This series got applied to net-next.

But I can trigger this splat via nftables/tests/shell in net.git (6.10-rc).

As well as in -stable 6.1.x:

Jun 26 02:19:26 curiosity kernel: [ 1211.840595] ------------[ cut here ]------------
Jun 26 02:19:26 curiosity kernel: [ 1211.840605] WARNING: CPU: 0 PID: 70274 at net/core/flow_dissector.c:1016 __skb_flow_dissect+0x107e/0x2860
[...]
Jun 26 02:19:26 curiosity kernel: [ 1211.841240] CPU: 0 PID: 70274 Comm: socat Not tainted 6.1.93+ #18

I think that turning this into DEBUG_NET_WARN_ON_ONCE as Willem
suggested provides a workaround for net.git until Florian's fixes in
net-next hit -stable.

Would you accept such a patch?

Thanks.

On Sun, Jun 09, 2024 at 12:10:38AM +0200, Florian Westphal wrote:
> Change since last version:
>  fix kdoc comment warning reported by kbuild robot, no other changes,
>  thus retaining RvB tags from Eric and Willem.
>  v1: https://lore.kernel.org/netdev/20240607083205.3000-1-fw@strlen.de/
> 
> Years ago flow dissector gained ability to delegate flow dissection
> to a bpf program, scoped per netns.
> 
> The netns is derived from skb->dev, and if that is not available, from
> skb->sk.  If neither is set, we hit a (benign) WARN_ON_ONCE().
> 
> This WARN_ON_ONCE can be triggered from netfilter.
> Known skb origins are nf_send_reset and ipv4 stack generated IGMP
> messages.
> 
> Lets allow callers to pass the current netns explicitly and make
> nf_tables use those instead.
> 
> This targets net-next instead of net because the WARN is benign and this
> is not a regression.
> 
> Florian Westphal (2):
>   net: add and use skb_get_hash_net
>   net: add and use __skb_get_hash_symmetric_net
> 
>  include/linux/skbuff.h          | 20 +++++++++++++++++---
>  net/core/flow_dissector.c       | 21 ++++++++++++++-------
>  net/netfilter/nf_tables_trace.c |  2 +-
>  net/netfilter/nft_hash.c        |  3 ++-
>  4 files changed, 34 insertions(+), 12 deletions(-)
> 
> -- 
> 2.44.2
> 

