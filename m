Return-Path: <netdev+bounces-134512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A56D999EDE
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E83281CB8
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B2D1CB334;
	Fri, 11 Oct 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="OvhaCEQC"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9D20ADD9
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634895; cv=none; b=Y38DFYhxxECUUvWH8gCGcnecE6nmvnszCpeEi24kWmeqhl9cZstgDvCzmlgJvQm1C4wdKWqre9knMrs/kjkXv1b9T5DwGsZXd24LwW6c1JAr3qb6g9yjhbMmymjMJBvoQAuWECBuI5JpKbXkdO0SXP7Vf7e6jL7ysMKLkk9lGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634895; c=relaxed/simple;
	bh=I+irFqq5nkTmvQ9EGuRqnq1jXWjgYgmxZKc46tI/ACc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0wGpQZgL6/j+GIqdoMSNLmkNQTKAbtYhvMwRJbNuQUx8NDL7W9lVkK5ylbaD31UpGD9XfDY7iv0j0vBD2wCLXJFtiOdMul1L+yWfk3qa64amvMOnWs0cJPhihQCBIbd8CjUORFmybqmWQyN0vikVU8T4Ewy+w2XTwnk3xuquN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OvhaCEQC; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2FBE220897;
	Fri, 11 Oct 2024 10:21:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c4f5dgfxoe-6; Fri, 11 Oct 2024 10:21:24 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AED5B20885;
	Fri, 11 Oct 2024 10:21:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com AED5B20885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728634884;
	bh=NhnTfhuwkm47lbAyfKHQrCmMQJbeI7ACWCMBgOki6/g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=OvhaCEQCogc6jjleC4g10HvjVKefOcUm1OzulHQ9KspEeFji3rH4pdpivw8JVLQWF
	 CnyesDBkPUSlrCT9GCGl2pCPz28YWvA2pVMrVsYtb9GhHf1ErQXgMW675ejMkKJ3ja
	 0eof8Pj1qiAFhmNhdt+4bHpjNHf2Pc9kY3yig6wccIK2mBpKPrAkW0Qym1NsWsmyR4
	 Kn66PL4EFswt8sVZeFYMnmRqoLOLvPTuujkuxKbJS335mU0K67qc2aR/IVYVn00d9c
	 SCmZn3GQYjZRA8JnEelx4QT/3ah8+BHUeGsnsUfcoTEC1mH3LcFBoZozecWsnwKWws
	 QHuHwGvAERong==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 10:21:24 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 10:21:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 29AEE3183E58; Fri, 11 Oct 2024 10:21:24 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:21:24 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>, <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: Re: [PATCH 2/4] xfrm: Cache used outbound xfrm states at the policy.
Message-ID: <ZwjgBH347AB51bRx@gauss3.secunet.de>
References: <20241007064453.2171933-1-steffen.klassert@secunet.com>
 <20241007064453.2171933-3-steffen.klassert@secunet.com>
 <20241007072623.1b7b24f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007072623.1b7b24f9@kernel.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Oct 07, 2024 at 07:26:23AM -0700, Jakub Kicinski wrote:
> On Mon, 7 Oct 2024 08:44:51 +0200 Steffen Klassert wrote:
> > Now that we can have percpu xfrm states, the number of active
> > states might increase. To get a better lookup performance,
> > we cache the used xfrm states at the policy for outbound
> > IPsec traffic.
> 
> missing kdoc here, FWIW:
> 
> include/net/xfrm.h:595: warning: Function parameter or struct member 'state_cache_list' not described in 'xfrm_policy'

Fixed, thanks!

