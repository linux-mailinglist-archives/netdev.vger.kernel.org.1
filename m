Return-Path: <netdev+bounces-86914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B28A0C6D
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E0428437A
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D6144D19;
	Thu, 11 Apr 2024 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="FhyIW+35"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED813B2A8
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827901; cv=none; b=pUo/4z4fCc9opU/+iUuAuyfOMd9JZNOaZzg+bpP9thTW+JnHT1ZeR364T1xQ4HRt4+7pFW+FF5Aw92Vnw+Hs1+GtDk+TSMxc9cwMx1LEzzJmJGVDNnhpibu4jEYJL0d1y1OZ35atnaVfAttsPQJBpubAwpVEvMVa2ka7oMmjuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827901; c=relaxed/simple;
	bh=MqgdrLb1XKviJBoVEBurqhjlajOhlpDJpzp1XqDgF54=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrdTriM8UmHD+RdhogFtt6mvixYXI7eOvU/f7nUB57KLwT4fPW4MqooOM38PxpEqx2IonE5UMMfEakbH0h8z23vZugilfh/DnJkr+HYuAlGt/IjkgF9vvEY4Csezl1MuixSp6W0hCVSBqsdYgg+BJd9O+ZhzzU3rReFhCRRoGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=FhyIW+35; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 7FD342084C;
	Thu, 11 Apr 2024 11:31:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id clN1KAoZMlAt; Thu, 11 Apr 2024 11:31:36 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id F3A53207E4;
	Thu, 11 Apr 2024 11:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com F3A53207E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712827896;
	bh=lSavN5uk+GLldazV7PVC1raK2FpcwjGwQCrZOPJGwxE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=FhyIW+35U73DzeFlZkhGA8pq45/MHRnMiRM18CGoM6YG/D8ANaO7KCgEsLeaNqJqf
	 h5TL15pG/gRFOCBThxdidNr+bfLGSRhcYKWbSBlLwgee1j9Jr3rYD2mq1HkZ0fEDHp
	 1RRlCBwBaKjZ+u1NXibk8UIxS5YU/HgIBeLMjC+4Vg1/5aR6fcevY5LYvLhcqQ//YN
	 K/5Qbj3Cix6XOMHEt04F0VcSmJE6kfZ4kVo34z2MO6iOXpWW2y8HwDoU4BHI+HZAun
	 tLOF+iXFSddinc6ygR6FoxXqTIFtYADgXj9/CvVBoCmQQrvd9gzZIno5SJiGvZ+c5A
	 jB057XupJ+dwg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id E650180004A;
	Thu, 11 Apr 2024 11:31:35 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 11:31:35 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 11:31:35 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 473053181B3E; Thu, 11 Apr 2024 11:31:35 +0200 (CEST)
Date: Thu, 11 Apr 2024 11:31:35 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
CC: Sabrina Dubroca <sd@queasysnail.net>, <antony.antony@secunet.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<devel@linux-ipsec.org>, Leon Romanovsky <leon@kernel.org>, Eyal Birger
	<eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
Message-ID: <Zhet98MkJUQeAcFC@gauss3.secunet.de>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
 <ZhY_EE8miFAgZkkC@hog>
 <f2c52a01-925c-4e3a-8a42-aeb809364cc9@6wind.com>
 <ZhZLHNS41G2AJpE_@hog>
 <1909116d-15e1-48ac-ab55-21bce409fe64@6wind.com>
 <ZhePoickEM34/ojP@gauss3.secunet.de>
 <4f23c994-5f1a-4b91-9af9-d9d577a6121a@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f23c994-5f1a-4b91-9af9-d9d577a6121a@6wind.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Thu, Apr 11, 2024 at 11:05:02AM +0200, Nicolas Dichtel wrote:
> Le 11/04/2024 à 09:22, Steffen Klassert a écrit :
> > On Wed, Apr 10, 2024 at 10:37:27AM +0200, Nicolas Dichtel wrote:
> >> Le 10/04/2024 à 10:17, Sabrina Dubroca a écrit :
> >> [snip]
> >>>> Why isn't it possible to restrict the use of an input SA to the input path and
> >>>> output SA to xmit path?
> >>>
> >>> Because nobody has written a patch for it yet :)
> >>>
> >> For me, it should be done in this patch/series ;-)
> > 
> > I tend to disagree here. Adding the direction as a lookup key
> > is IMO beyond the scope of this patch. That's complicated and
> > would defer this series by months. Given that the upcomming IPTFS
> > implementation has a lot of direction specific config options,
> > it makes sense to take that this patch now. Otherwise we have the
> > direction specific options in input and output states forever.
> I don't understand why the direction could not be mandatory and checked for new
> options only (offload, iptfs, etc.) and reject for legacy use cases.

Because every state has a direction and it should be marked explictly.
As said, IMO it should have been like that from the beginning.

