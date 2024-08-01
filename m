Return-Path: <netdev+bounces-114926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF2B944B1E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D091E2884C4
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF2918A6B0;
	Thu,  1 Aug 2024 12:18:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C94E16D9A8
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514698; cv=none; b=ca0Cr8lMNCWqt2FeMkngczC0QPOUkI/TWCBj443nsEHGX/0CDzoBmrmBRxm3bfEFaFn7omnrEC5QxANeccaC4JnDRZRfTTEG232dZckjg3YxyjBTYeIFn8lp6/HD3PzzVGq8WddyKk2oJ5sS+RxkcruBR04LZ801DTVs7GgKADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514698; c=relaxed/simple;
	bh=rziyeIWI1hbSh9ej85dGgAAJ8u/Y5eqaXpA4OlQtacs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiRMmm6BDKz1bbhLI7+6UAP7q9lPBtbiaJaAX2+cvzdmCNsIfsLpZNO+o+BpLgt+r6qUUqGWL4oHepkgI5qMBiuc3nAfMwQdYUzJZbaGOlnw92SSDthm5vqOBiNqlGN5bw/4zRO7ry/WhQGoSF9MZQuW+WFUqya0a3VqCLo9BmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sZUky-0008B4-O5; Thu, 01 Aug 2024 14:18:08 +0200
Date: Thu, 1 Aug 2024 14:18:08 +0200
From: Florian Westphal <fw@strlen.de>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v7 08/16] xfrm: iptfs: add user packet (tunnel
 ingress) handling
Message-ID: <20240801121808.GB10274@breakpoint.cc>
References: <20240801080314.169715-1-chopps@chopps.org>
 <20240801080314.169715-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801080314.169715-9-chopps@chopps.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Christian Hopps <chopps@chopps.org> wrote:
> +static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
> +{
> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
> +	struct sk_buff *skb, *skb2, **nextp;
> +	struct skb_shared_info *shi;
> +
[..]
> +			if (skb->dev)
> +				XFRM_INC_STATS(dev_net(skb->dev),
> +					       LINUX_MIB_XFRMOUTERROR);

Nit:
Here and in several places you are using dev_net() helper.

I think that if xfrm_state is available, then xs_net(x) makes more sense.

It also avoids the skb->dev conditional.

