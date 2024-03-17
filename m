Return-Path: <netdev+bounces-80282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED1387E0B8
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 23:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51851C20A7E
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 22:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296271E862;
	Sun, 17 Mar 2024 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="Wma3tjnM"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773FB210E7
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710714941; cv=none; b=ByWpVEcNVyDC7BM9uv5qb1EI/M6c+kjGQVbGiuc8ktdJHTgCdSV2k1/0S/PBki79UoOV1C/1nptqm3Cq1Ox9TBa9cm3IOP9ZXnCQCxXMF/GuPUBzsVyYxNzJitC+TkIYC0QlG21heHf00Mfl88DY9oz19zynw1/HMCr6PUvIXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710714941; c=relaxed/simple;
	bh=YllBv0qSHtHrC0pFanEewwsIk2h00J4IoeEMx/KOc/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1u+K/mG7aUB4WvD4ck22XnJc5Ppiycdn8K48aAiNYGC72+bqPV7WjqjGcCUTs+WKl5Viw9F0kq+WNffbndzmT2p5LZHdbzI57//DbWWlSr846GuGoSH0XcPoxFKSyxSLj/CqgFKgM/IN1qjVOigfQ0DIpogEcfv3AXWMbzyby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=Wma3tjnM; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 815faed0-e4ae-11ee-bfb7-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 815faed0-e4ae-11ee-bfb7-005056ab378f;
	Sun, 17 Mar 2024 23:34:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=HJ+7oTpQC0fh1V1QxcmUk3qIZXC/9/b5fZfR7ZMO6lo=;
	b=Wma3tjnMw8OD6e5X/v3n5o4fsvU7Yo+dNYHxxOMtdO+ZTmhyhm1xS96anbvBzAzX9hctvt4NKsZpQ
	 qdvgEQ213z3fYnKLLpi6u9EhCMWVAnzEKP6k/cxmLPzziqkyOjldyp2iYj28Ud3+uaefxH5/zKMHK8
	 s+g9XpV073mJy7CM=
X-KPN-MID: 33|cI96wKDLxbCNEFXr6skQSiqsC6PP9D/Z6pqZ/De8QTJRrsCSW9CetmpASgvBGli
 RWS5JSTRBSjLMNmg7c7uKKFBLR0gsEsIyIQHJ2luK/JM=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|cpfrcmmuaxcJj3Ta9PCSO6GkffEDbEkyvrFvutS64Hmx26XgJ5AeXKXi2Q5zikh
 oe2pJVB+IO6vvcaxTO/T4Kg==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 822e177b-e4ae-11ee-a20d-005056ab1411;
	Sun, 17 Mar 2024 23:34:26 +0100 (CET)
Date: Sun, 17 Mar 2024 23:34:25 +0100
From: Antony Antony <antony@phenome.org>
To: nicolas.dichtel@6wind.com
Cc: antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH ipsec-next v4] xfrm: Add Direction to the SA in or out
Message-ID: <Zfdv8dLMhpwItqGL@Antony2201.local>
References: <515e7c749459afdd61af95bd40ce0d5f2173fc30.1710363570.git.antony.antony@secunet.com>
 <c2b3203b-fcc7-452f-88d8-1ef826509915@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2b3203b-fcc7-452f-88d8-1ef826509915@6wind.com>

Hi Nicolas,

On Thu, Mar 14, 2024 at 03:28:57PM +0100, Nicolas Dichtel via Devel wrote:
> Le 13/03/2024 à 22:04, Antony Antony via Devel a écrit :
> > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > xfrm_state, SA, enhancing usability by delineating the scope of values
> > based on direction. An input SA will now exclusively encompass values
> > pertinent to input, effectively segregating them from output-related
> > values. This change aims to streamline the configuration process and
> > improve the overall clarity of SA attributes.
> 
> If I correctly understand the commit, the direction is ignored if there is no
> offload configured, ie an output SA could be used in input. Am I right?
> 
> If yes:
>  1/ it would be nice to state it explicitly in the commit log.
>  2/ it is confusing for users not using offload.


I see why you're asking for clarification. This patch is designed for 
broader use in the future beyond its current application, specifically for 
the HW offload use case. Notably, the upcoming IP-TFS patch, among others, 
will utilize the 'direction' (dir) attribute. The absence of a 'direction' 
for an SA can lead to a confusing user experience. While symmetry is nice, 
configuring values that are not utilized and are direction-specific can be 
very confusing. For instance, many users configure a replay window 
(specifically without ESN) on an outbound SA, even though the replay window 
is only applicable to an inbound SA. With ESN, you can just leave it at 1.  
SAs have historically lacked a direction attribute. It has been brought up 
many times but never implemented.

Following the email I shared earlier 
(https://lore.kernel.org/netdev/ZV0BSBzNh3UIqueZ@Antony2201.local/), I 
discussed this proposal with more users/developers, and there is interest in 
adding a direction to SA for future values. Maybe I will addd one line in 
the message this is in preperartion for upcoming IP-TFS.

-antony

