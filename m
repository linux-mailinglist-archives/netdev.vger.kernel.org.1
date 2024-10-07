Return-Path: <netdev+bounces-132591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A62992514
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3251F20FA2
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAF913E898;
	Mon,  7 Oct 2024 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="L1sjRHDk"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD30800
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283727; cv=none; b=bzQ14ajhPy5rpacMP7VXzXPfhBBXV9N4OGrYqaNRUUlAOlECBFxiD22CwkYoEZ6sp2Wy9prtVKFomV9kZyatayu/Coz/PyCQbWvphYU1JRn9WZ7xTI1Qej/B+1tPn6jEqeiX/qfu2RGOpRFaPGUSljdCJs+Kuf3RmjRkfOmKMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283727; c=relaxed/simple;
	bh=f0Zm3ceRJzLspvdyqFO/Uowsgzcgb9qfwfcfJ0OGoLg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQqYZQihL7SRzMKEMw2YxfVR+SZ13QTz9EI/gD4PmzNoRLzhq963U7owmOZVzNz1m6q40iaxpfDp2/HsiH/DNRnDhSpkZqZ3KAGNo0mMgc9mfPgGJbKY55z/xyNWwTp0upvuS153EI+auP44NEHgh8In1OuIpPspRXdr7fba/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=L1sjRHDk; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E145A205F0;
	Mon,  7 Oct 2024 08:48:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGKqfUuepJoQ; Mon,  7 Oct 2024 08:48:43 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 604272050A;
	Mon,  7 Oct 2024 08:48:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 604272050A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728283723;
	bh=sGH8w2mqZCZ2GceqrEFisVDhj4jg7+zX1bkBvDMV2aw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=L1sjRHDkY5GgRoLBfkBVAj/DOHogIAj422ISG/IqutZEfnwZDquG9jwrOuGe2OthI
	 tVhiQlS37FphBmJaVO3i3IbFHzoAtZ9DvE2O1WQ5O78OYf/HqfonPTXyGYkt4gjgXG
	 ML57Q980DHKMUwj107htBCPbeU2cHPD9HXzEneNH2j0S1mmgViGOhNgQ9cYU9v+BaD
	 VQjsZ2epcaCntqrn1Ua/p8TtgS7phK1PhoOLaHkWQlr/fCMn0KTwa7KsPnPDTXf+JT
	 K73LyhNNxQlJpi2iyxHzNJAt/1WFrJjAPyEvv7lj1XYkBasp2jU5zkxeltuFcMR4K0
	 M/VPNCo5mAerA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 08:48:43 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 08:48:42 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id D290931819AB; Mon,  7 Oct 2024 08:48:42 +0200 (CEST)
Date: Mon, 7 Oct 2024 08:48:42 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>, <netdev@vger.kernel.org>
CC: <devel@linux-ipsec.org>
Subject: Re: [PATCH 0/4] xfrm: Add support for RFC 9611 per cpu xfrm states
Message-ID: <ZwOESgIy481G/3zn@gauss3.secunet.de>
References: <20241007064453.2171933-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007064453.2171933-1-steffen.klassert@secunet.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

I forgot to mention that this is the v2 patchset and based on
the ipsec-next tree...

On Mon, Oct 07, 2024 at 08:44:49AM +0200, Steffen Klassert wrote:
> This patchset implements the xfrm part of per cpu SAs as specified in
> RFC 9611.
> 
> Patch 1 adds the cpu as a lookup key and config option to to generate
> acquire messages for each cpu.
> 
> Patch 2 caches outbound states at the policy.
> 
> Patch 3 caches inbound states on a new percpu state cache.
> 
> Patch 4 restricts percpu SA attributes to specific netlink message types.
> 
> Please review and test.
> 
> ---
> 
> Changes from v1:
> 
> - Add compat layer attributes
> 
> - Fix a 'use always slowpath' condition
> 
> - Document get_cpu() usage
> 
> - Fix forgotten update of xfrm_expire_msgsize()

