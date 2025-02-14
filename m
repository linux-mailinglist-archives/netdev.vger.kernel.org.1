Return-Path: <netdev+bounces-166358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DCAA35A75
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5304916BE0A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB46227BB4;
	Fri, 14 Feb 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Gjatz9tg"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1D20B1EA
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525703; cv=none; b=nG0QIsvuJouWHDxsC40clH6NQVkEBmbt8xjds6BC22PO3aYFlKCHi1NbpmA8TSF0MuWpQm8b14AGK/j2tatle7nMdOM4dLVxFtsEbQ1EYnI9XZDDkaPGh8q5uEAaJbS2thZBggGiTsyLG6NOe3s3Ruw9Lj7wlD1aMSB89stgC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525703; c=relaxed/simple;
	bh=lX42+RAzZIXS861sMWEgAZAWRRN3NZbRXKxuaFQhKKA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLIVYTqEQiQ9Az6uZE3IsEgpNMlEmF9fZPKomrbyrgsZgX7nRXtpzsthKCh0hBKSLlZjD6LK8S8VRjrsNC5EQTd+ke06KCOnQ/ooP5kr6zSP6XcIC4UH6wvq3Yprfy9esmNIn1dGLXkvyk9GP+yEbaRqR+HZv2LdHRz5JZjw70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Gjatz9tg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EAF83207B3;
	Fri, 14 Feb 2025 10:34:59 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZM8W8L01ETgG; Fri, 14 Feb 2025 10:34:59 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5503A20764;
	Fri, 14 Feb 2025 10:34:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5503A20764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1739525699;
	bh=DZQJ4C+paNp40dZKPBONXW0Hs2HXZJpMT3dUvuWurk0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Gjatz9tgt5NEeN3qhgQKf+UDJcidzZP3ir+GIg+wC/d6c9DvEJ9I2n8YKYEi6+l1U
	 RsCpLzetRSZctUHj/aTHR6HHAFJ00fN2b/ttszltrsn3Kf78AVTQ3orrnnDU6I01jb
	 wakYKnxj4lJyiraBLxU7CmG2DMrwUYqAnV6xd1Es2jQPdSnGqCbdOrkutPWdKs2G3C
	 ObKfphVJpJWwR6rwPQEivyXDWUlXrZJ0tPebDDpR+oZ8GBI4C+9EGqAEELNF9l+4B7
	 gkslYsDiUIfEcRnFFEdbpcR1Temlba4hkdIq7Lrd+rtfPmgOLeOa5JO7c6AKMusgwM
	 1fS60ljbZCDnw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Feb 2025 10:34:59 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 10:34:58 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 92BE73182F5B; Fri, 14 Feb 2025 10:34:58 +0100 (CET)
Date: Fri, 14 Feb 2025 10:34:58 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Alexandre Cassen <acassen@corp.free.fr>, <netdev@vger.kernel.org>
Subject: Re: [RFC ipsec-next] xfrm: fix tunnel mode TX datapath in packet
 offload mode
Message-ID: <Z68OQtAL2jiu/1Sg@gauss3.secunet.de>
References: <af1b9df0b22d7a9f208e093356412f8976cc1bc2.1738780166.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af1b9df0b22d7a9f208e093356412f8976cc1bc2.1738780166.git.leon@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Feb 05, 2025 at 08:41:02PM +0200, Leon Romanovsky wrote:
> From: Alexandre Cassen <acassen@corp.free.fr>
> 
> +static int xfrm_dev_direct_output(struct sock *sk, struct xfrm_state *x,
> +				  struct sk_buff *skb)
> +{
> +	struct dst_entry *dst = skb_dst(skb);
> +	struct net *net = xs_net(x);
> +	int err;
> +
> +	dst = skb_dst_pop(skb);
> +	if (!dst) {
> +		XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +		kfree_skb(skb);
> +		return -EHOSTUNREACH;
> +	}
> +	skb_dst_set(skb, dst);
> +	nf_reset_ct(skb);
> +
> +	err = skb_dst(skb)->ops->local_out(net, sk, skb);
> +	if (unlikely(err != 1)) {
> +		kfree_skb(skb);
> +		return err;
> +	}
> +
> +	/* In transport mode, network destination is
> +	 * directly reachable, while in tunnel mode,
> +	 * inner packet network may not be. In packet
> +	 * offload type, HW is responsible for hard
> +	 * header packet mangling so directly xmit skb
> +	 * to netdevice.
> +	 */
> +	skb->dev = x->xso.dev;
> +	__skb_push(skb, skb->dev->hard_header_len);
> +	return dev_queue_xmit(skb);

I think this is absolutely the right thing for tunnel mode,
but on transport mode we might bypass some valid netfilter
rules.

