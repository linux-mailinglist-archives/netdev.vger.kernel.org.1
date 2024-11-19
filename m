Return-Path: <netdev+bounces-146228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EEC9D254B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F481F21B67
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D001CBE92;
	Tue, 19 Nov 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="jkp7E/eo"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604071CACFA
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018242; cv=none; b=i+FmUtKjJ64cTBimwGLziOR++BXvyYGW4Ue50JIqgVsUd9MTIhU5Zom1SiHU+iEuU10ZQm1eq9XsaFcUo+vhxHxIvQ+Sq6a5+ypGYsvf37WkSGse76RJPdOeFm4/50G3Yg1l18eMHpK7Yf6ZhNc5PlNmjnSaUdpIk+o0rqvlfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018242; c=relaxed/simple;
	bh=aoiTAVNu0L/o2+glOeEGnKXxQbXq574jildBqVT3SiY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkfP1wuI+e7oaiOMuFKnx5vKPVXfYH3W+aneLpyZ9mNmufqIV8cEaxfhNxLFqotaKR53FYIHYXDfpDYaRn6GQwt67UiXkAyzpNe96jDOFQHnC1h8gZSxPNyUySHSmlTocEnxIXK0Q1vnNNG7FEDAJ58IiA8ByyAnFbMw02kwRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=jkp7E/eo; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BC0562074F;
	Tue, 19 Nov 2024 13:10:30 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QIUZdkMRhFCm; Tue, 19 Nov 2024 13:10:29 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D8A2E206F0;
	Tue, 19 Nov 2024 13:10:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D8A2E206F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1732018229;
	bh=LQgMRATZaSVOiKCujBqs73jTJv7TQwPNfjl6DFx0wuc=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=jkp7E/eodftu5ppdHI/Uyxal567dcQfpm4f6BlFLE2tNfQnvHU/nFCRnbILX8xWdY
	 /VtjtRxXku2zeBZ/s6aEtqrtz9iKG5hXJwdu6F9wzIpUy2BjjiIv6eQpUNJTgA58MW
	 xdmm4yw340rttUFn2ixOdLQTBpeVi5eT7yn4FDgyEf/EAWOE7hjLDTxrOwHsu0GWnw
	 +0hFwpSqB0hWr9OxTLqWuV/QS4BilPbs41Vs+e9sc3DFyiMo3bd2YXFGr7x882C7MF
	 n4ZQ4ruKrOGgFnAzIcsCPUa+kW9sT8FtMzWfx9KMUJyTKe3TD6aPgowlO+LqnPrxfN
	 aoHavAwAwCYqg==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 13:10:29 +0100
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 13:10:29 +0100
Date: Tue, 19 Nov 2024 13:10:26 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: <devel@linux-ipsec.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>, Florian Westphal <fw@strlen.de>, Sabrina Dubroca
	<sd@queasysnail.net>, Simon Horman <horms@kernel.org>, Antony Antony
	<antony@phenome.org>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v14 00/15] Add IP-TFS mode to
 xfrm
Message-ID: <ZzyAMsShJSt8nyZU@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
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
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Nov 14, 2024 at 02:06:57 -0500, Christian Hopps via Devel wrote:
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

I did several functional tests with the entire patch set.

Tested-by: Antony Antony <antony.antony@secunet.com>

Feel free to add this tag in the next re-base.

thanks,
-antony

