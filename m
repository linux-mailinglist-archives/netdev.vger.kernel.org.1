Return-Path: <netdev+bounces-122683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51C69622D0
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B0F1C244AE
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3E165EF2;
	Wed, 28 Aug 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="IgFeRedn"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8A166315
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835108; cv=none; b=DNk18VTPiSoZLvlN61GGKxmp3jUhnBj2qkeFVbuxgeI67KVpV0HDrG9b+w0ilPZngeNM0rT/OkXTZ3TlC1zJ4oEAe3aOY6MahnwUNqkjHhuxGHZXd7+59qdZ/oLimTJ9T4GmWHk/+OQ1/vyWgysfS4bLnOkQOBhfqdQI6yfowyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835108; c=relaxed/simple;
	bh=wHHcG+202ZnymULz4xcelqe5XoFs2F/bHPu3O6RxkNo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvF++Aggcj5DLScMsRnKIzGk17mMxxrqz0QmcktLz25E8IvseVPr6fcfT8c7d9Pl1pORxw6AOC5F898aY34RsmwGLw1QOKk7N1c4iF2kEksTKn0HsejU1NrQhLG+v45XJkBhCkPbwSquO2IFiKPQcGN/q0SIwPVKb9iVIWgkBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=IgFeRedn; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 14D7E207BB;
	Wed, 28 Aug 2024 10:51:44 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x4rbDeMQRtZM; Wed, 28 Aug 2024 10:51:43 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 934CC201E5;
	Wed, 28 Aug 2024 10:51:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 934CC201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724835103;
	bh=1AWBN6m+q2jCNpX3zyIeDWy7yiTK6rYQjvn8K+N6sJ8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=IgFeRednst68351uU0WgCqngzG1QEk85XlvWQINrn8q7QkKijzk5cNQUADjpHO+EL
	 kRqZB2CivauGXl/hKkWdlHe0vgm8DzD/y14p4dv30gbuat1Df+vHtM3VAmSVa7Jgrk
	 wy/pJXx6yujFkmWM7dZhEDe2gPc9K4yazGbzPstILsy18lB7E16bUT3oPX+ceKIkfR
	 jeoNpdmluUAZxwxZ2CZVZ0Rvtm2SvM2y5a6Su7Lxgwfl9bVGvrnPFzy9bFd6qvPCx5
	 MN7MIA7l8S082DTkEnysPdrTsRi7aXRTEALUq9K8zSnXFxdgOVE0nmnYj/6aKzSTqj
	 MvZTNT0WNBiXg==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 10:51:43 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 10:51:43 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id B9BBF3183D07; Wed, 28 Aug 2024 10:51:42 +0200 (CEST)
Date: Wed, 28 Aug 2024 10:51:42 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next] xfrm: minor update to sdb and xfrm_policy
 comments
Message-ID: <Zs7lHroOxv0wVtfb@gauss3.secunet.de>
References: <20240827133827.19259-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827133827.19259-1-fw@strlen.de>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Aug 27, 2024 at 03:38:23PM +0200, Florian Westphal wrote:
> The spd is no longer maintained as a linear list.
> We also haven't been caching bundles in the xfrm_policy
> struct since 2010.
> 
> While at it, add kdoc style comments for the xfrm_policy structure
> and extend the description of the current rbtree based search to
> mention why it needs to search the candidate set.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Also applied, thanks a lot!

