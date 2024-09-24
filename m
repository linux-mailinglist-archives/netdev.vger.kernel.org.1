Return-Path: <netdev+bounces-129508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1733984329
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A9EB22CA8
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E07157468;
	Tue, 24 Sep 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GEVk3XXz"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD8335A5
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172465; cv=none; b=B4T/fz5sYGT3GmWIWx8yjmA1mOIw69iZuhbvvH/ZBtHUYy+HP0YxrpRInGC36ttr5iFc5aRergPGrY/sqF7l00o3Rp4nWw/Q1xDIlh6vqn6mbKa6J3PCmkObEZ/tcTeSqcQJ766rFk6o1L8F2JibbvC+wYMt2S3XXvmZGuv5z+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172465; c=relaxed/simple;
	bh=scb9e49eofHq8xiV4Q3431jrufbuvC07UhC2f6jIphc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cESBpkuHQAC3x7MTXCFPFhf5buLYWQn4frwo4XjYSxW90MINSShcQZnhuUd9TqaH1F0IVI6SKdhSknx6q1lQx+LlCJitBAgcEzCZMhG4WMQiSgFlZ0EK0HIylvAtcKcYrzmggi9rJA3PNYSF/yJPJ3X5VR8Qn4REAMF9vsI6VcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GEVk3XXz; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 8E14E206F0;
	Tue, 24 Sep 2024 12:07:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yeMF0OWuYKqe; Tue, 24 Sep 2024 12:07:35 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1B66220561;
	Tue, 24 Sep 2024 12:07:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1B66220561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1727172455;
	bh=gyiVkn1ttxmCDwYtjtpkKsmEj2rNLtuc53MaBJpGg0M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=GEVk3XXzULQp/8Yq3BZVjP750bebM5kesW6S8fQy+BIjubIFH1uYr8NbaVxsjrtGr
	 RgVHacgy/MJt9u5V89BJFS7ffBSkZBp4hjPxM8hPPImvWzowFQmGKwgPl5OrUX+zDU
	 q1BCHGZbFfXOuikcoqglBu8cYsxMZ2lZJV0YW6a06bF04yk86vomWPxU3cbw2H7eJB
	 VoE75fr8RkRQiF0AtFQgIdDSwYvitfW+hdEne3LvbVCYZKtw7JaNbkyCsIZP/nSKsp
	 jtNzl4qUlz8iHsQO0B8EBPoZq/odkAxHjLYSdIALDrsEH6wq8en49mmohvIo8gCobA
	 plMvvEMKJNfug==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 12:07:34 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 12:07:34 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A277231810A1; Tue, 24 Sep 2024 12:07:34 +0200 (CEST)
Date: Tue, 24 Sep 2024 12:07:34 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Feng Wang <wangfe@google.com>
CC: Leon Romanovsky <leon@kernel.org>, <netdev@vger.kernel.org>,
	<antony.antony@secunet.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <ZvKPZvKw2hxO5GkK@gauss3.secunet.de>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal>
 <Zt67MfyiRQrYTLHC@gauss3.secunet.de>
 <20240911104040.GG4026@unreal>
 <CADsK2K_ip7YUipHa3ZYW7tmvgU0_vEsDTkeACrgi7oN5VLTqpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CADsK2K_ip7YUipHa3ZYW7tmvgU0_vEsDTkeACrgi7oN5VLTqpQ@mail.gmail.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Sep 11, 2024 at 04:43:55PM -0700, Feng Wang wrote:
> Hi Steffen,
> 
> Can you reconsider the revert of the CL? Based on our discussion, I
> believe we've reached a consensus that the xfrm id is necessary.

I did not say it is necessary, all I want is a complete API that
exposes all xfrm stack features correctly to HW.

> If
> some customers prefer not to utilize it, we can extend the offload
> flag (something like XFRM_DEV_OFFLOAD_FLAG_ACQ) to manage this
> behavior. The default setting would remain consistent with the current
> implementation.

No new flags please.

The easiest thing would be to upstream your driver, that is the
prefered way and would just end this discussion.


