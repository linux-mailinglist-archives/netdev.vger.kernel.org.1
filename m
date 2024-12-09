Return-Path: <netdev+bounces-150104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA439E8E9C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D4F1883BE8
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611118DF6B;
	Mon,  9 Dec 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wdeWat4F"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF061EB3D
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736205; cv=none; b=X7cqkL4a/MWqgdHBO9/jutCJBq+R6amUogYOShxAfk1+YA7mESr9Y/5J9KbIXeoni3QupUO3KJpiPyBhXZhc4+lEt4gQnR1TNqos575NtYDwUX/QldikVaoFhnr/xHrdiZ9HD++2nZyzJyOQSK7uTJLpsGS4aJkLnf1or24vjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736205; c=relaxed/simple;
	bh=8Ew4BBvAXemkPigVeGnxbMfDgFtapeaJvJzDM+/aDUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4hM6SO2gkt2bx4bL8hmKZIIqJAtz41gzW+c3JUPqsKrVCdP0ovY8D1qIDw1TInR5wPnjso9sCq3gvcbYbzRXyF0ARikRimypjcUDUghTlL09vLNs1uLj4zZiKIcbvo5lWTbd/jyPOIB+Etd9Fb444micpziTdB3FJAhG3zEiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wdeWat4F; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C5E4620820;
	Mon,  9 Dec 2024 10:23:13 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S39gGarPBl_6; Mon,  9 Dec 2024 10:23:13 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E123220684;
	Mon,  9 Dec 2024 10:23:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E123220684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1733736192;
	bh=H7aGOsKjgMrtCsRI5+fUB29AsGxw8rDr02LOUv+Rpsc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wdeWat4FvIpxA4AXpWvudkwLbbNLmwROH3JFcDLzpy3juZCKeR8B64H83piUJrHj9
	 Plw7bfskw6CLRWt8LNKk4b7MqIYPKMcZMbmYsaGqm8KxrJF6V4EDTXJs6bhkyLY+9d
	 WBKukf+oL4w/mZ/7JMSMojiFb2hSiNYQT9vUZaxbcu9RxENlNkFobf2ZNfMxLj6Ol5
	 5qTIP5ni9i7A/wm0bMTBXzayF3Gg3/LviiOQu+U172kl/hQm31i9cr0uDke1AiUPSz
	 GrJ0fAVQ0L1L2ke7QKUUM+q6hL+7KtjtWYxSUGj3AgtUIAdESZBAp6348uo9iTCfFP
	 8txpJP0yRF9BQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 10:23:12 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 10:23:12 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6042331843C8; Mon,  9 Dec 2024 10:23:12 +0100 (CET)
Date: Mon, 9 Dec 2024 10:23:12 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: <devel@linux-ipsec.org>, <netdev@vger.kernel.org>, Florian Westphal
	<fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
	<horms@kernel.org>, Antony Antony <antony@phenome.org>
Subject: Re: [PATCH ipsec-next v14 00/15] Add IP-TFS mode to xfrm
Message-ID: <Z1a3AKjJuARAhHih@gauss3.secunet.de>
References: <20241114070713.3718740-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241114070713.3718740-1-chopps@chopps.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Nov 14, 2024 at 02:06:57AM -0500, Christian Hopps wrote:
> * Summary of Changes:
> 
> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
> (AggFrag encapsulation) has been standardized in RFC9347.
> 
>   Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> This feature supports demand driven (i.e., non-constant send rate)
> IP-TFS to take advantage of the AGGFRAG ESP payload encapsulation. This
> payload type supports aggregation and fragmentation of the inner IP
> packet stream which in turn yields higher small-packet bandwidth as well
> as reducing MTU/PMTU issues. Congestion control is unimplementated as
> the send rate is demand driven rather than constant.
> 
> In order to allow loading this fucntionality as a module a set of
> callbacks xfrm_mode_cbs has been added to xfrm as well.
> 
> Patchset Structure:
> -------------------
> 
> The first 5 commits are changes to the net and xfrm infrastructure to
> support the callbacks as well as more generic IP-TFS additions that
> may be used outside the actual IP-TFS implementation.
> 
>   - xfrm: config: add CONFIG_XFRM_IPTFS
>   - include: uapi: protocol number and packet structs for AGGFRAG in ESP
>   - xfrm: netlink: add config (netlink) options
>   - xfrm: add mode_cbs module functionality
>   - xfrm: add generic iptfs defines and functionality
> 
> The last 10 commits constitute the IP-TFS implementation constructed in
> layers to make review easier. The first 9 commits all apply to a single
> file `net/xfrm/xfrm_iptfs.c`, the last commit adds a new tracepoint
> header file along with the use of these new tracepoint calls.
> 
>   - xfrm: iptfs: add new iptfs xfrm mode impl
>   - xfrm: iptfs: add user packet (tunnel ingress) handling
>   - xfrm: iptfs: share page fragments of inner packets
>   - xfrm: iptfs: add fragmenting of larger than MTU user packets
>   - xfrm: iptfs: add basic receive packet (tunnel egress) handling
>   - xfrm: iptfs: handle received fragmented inner packets
>   - xfrm: iptfs: add reusing received skb for the tunnel egress packet
>   - xfrm: iptfs: add skb-fragment sharing code
>   - xfrm: iptfs: handle reordering of received packets
>   - xfrm: iptfs: add tracepoint functionality

This is now applied to ipsec-next, thanks a lot Chris!

