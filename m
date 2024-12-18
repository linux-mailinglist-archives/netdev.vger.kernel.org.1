Return-Path: <netdev+bounces-152849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C2E9F6024
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3967818808CF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757A4154C04;
	Wed, 18 Dec 2024 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="vHwOb7ii"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4BCF50F
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510751; cv=none; b=V77i/mO5PAl8OPZA9OHK1KkNI1HwumIWkQZMLxVK8JcHSml/KG70yGoNVN6HMd9SywktQKyBBrW1UX1yzzdQUr5bJFEP5VK8uqRcS83OCLx6Pcp6ZMlJTCMUKZKynpC+5Yjd3TExAenfjo2Hr+aJ5m2mWfn5WXqyUgt+0LXowrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510751; c=relaxed/simple;
	bh=YHflM6F6NaYA8v2LYdwLPp/dWRWgesJq2aEZ1myhM4s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGgS6BqNpYILfe4M8krLyZBpFc8gH5kilRXunReYwogDTP0+k7epOYOnGjsH+U9NDsG+kYUoZIHV2AVdbAX+oTCIJ8lEDcQN+z3AafajX5GRQfGYVWb54fAlf8gBp1pCvH3bJIlbDX/YXvX11oPnn4UzvN7+ZxcqOoHieBkkZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=vHwOb7ii; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2278F207C6;
	Wed, 18 Dec 2024 09:32:27 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RcuppyzJTY5a; Wed, 18 Dec 2024 09:32:26 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A638B204D9;
	Wed, 18 Dec 2024 09:32:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A638B204D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1734510746;
	bh=VYs3pbNLvfRCH6s3p+3N9PqlP49GXLuyPWZKv2Maa34=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=vHwOb7iivOV+8bvFI05CfDuE/2JcAYUp4ib2oSLW54J3RNJ/njUT13xrobxwRT/ic
	 R3XY27AUTEZaayzxt11IteRbk3xGtW9ZRncNLALqO2A161Uc8bkgYhGH2NtuUlekzQ
	 lmARgmZfx6VPp9uzilsPivLr8RIyXTyM8Q+dofHr8z6ho44HW70DbHab9MMAJsAu2C
	 6puFkKcPsGizrgt3cxIvB8foWkjdRXAFvaickN3wQ6M/FMonQxbVwQ2jGu5a1unD/D
	 nNhXC5swYiAWFhsuCha178OntI9WYLPffPB+nSCKYKAShPkDDzSuwcEQq4cVaJw/+C
	 0Mr0AYOHmjm6Q==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Dec 2024 09:32:26 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 09:32:26 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 1F562318103D; Wed, 18 Dec 2024 09:32:26 +0100 (CET)
Date: Wed, 18 Dec 2024 09:32:26 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Sebastian Sewior <bigeasy@linutronix.de>, Network Development
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: xfrm in RT
Message-ID: <Z2KImhGE2TfpgG4E@gauss3.secunet.de>
References: <CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Dec 17, 2024 at 04:07:16PM -0800, Alexei Starovoitov wrote:
> Hi,
> 
> Looks like xfrm isn't friendly to PREEMPT_RT.
> xfrm_input_state_lookup() is doing:
> 
> int cpu = get_cpu();
> ...
> spin_lock_bh(&net->xfrm.xfrm_state_lock);

We just need the cpu as a lookup key, no need to
hold on the cpu. So we just can do put_cpu()
directly after we fetched the value.

I'll fix that,

thanks!


