Return-Path: <netdev+bounces-126445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9CE9712A6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F311C22003
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A01B1D64;
	Mon,  9 Sep 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="exjn0MzE"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D501B1D49
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872047; cv=none; b=L7SiRpavCzpbsNzlqFDB7NaYD9MJD9uk5+pC8TvHS/JY5UYwbAI18tOzLaTDkk/HTBHYkMkwFSRQ+/4Ks79ifz7P+Vhkur54xNUH3A5/O4Xe+9RZo3v9LHj/gdzzjY9gtu4c+LqxcxkvdRkmHUozLNo/WuI2NjX3l3RJwyaebpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872047; c=relaxed/simple;
	bh=nQxYZYtcnFpGGORmtq4FZfiifqUwywXeic2CfpW0abM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myyNLOnjN5cxFvV1DXwa0DpZgds//3QuP0T/0s3+bXg3DtH1Ig66yu0j4a+Ud4c2CoTXqsUNO604uUKbdHwzrRFlYaU9/MZZaGav268PDwmOO52mwSDnSGV8HDsqYotHYv04XLVEfwHJIi4F5eeOEy8UlucxOLlzRVXoZ+mIK6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=exjn0MzE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C24B120820;
	Mon,  9 Sep 2024 10:45:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jz-bBRPlT_JS; Mon,  9 Sep 2024 10:45:31 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 12400206D0;
	Mon,  9 Sep 2024 10:45:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 12400206D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725871531;
	bh=ZmbbGCsZ70IQIJtexdrtkUAS5QSMKKt8b3gDmq+iYfo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=exjn0MzE+eazQcHthRQO33kYSlBBZc8Kw9jED955aV29h2FluSmSbQ4tc6kHWXyKZ
	 zA517sfQlZGSMnCnDdasuOumBmOLD8KyipR4Id+xLuoYrQldb/qvMeBfKTseahkAti
	 ISwcJnxUMHRope0sHHPYDqj5mxKUli6hjo/Xrbd50JiXW+0N4ZhWxOG6Jqc4/4oL+v
	 n7dZVFF+zqlfsR7/joDRtF9iT7w7MShEyiPjy37ws15Nj5Pqky8RKFeiS8yLhZtfW4
	 /r9A9ph/sWgWtA3GvD1VO58LC1opVe/AmwRH4759XorWPPGS7Scw06X0Cw1kkrmYLd
	 LxxBu/dl5nvRw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 10:45:30 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 10:45:30 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7E24031829F0; Mon,  9 Sep 2024 10:45:30 +0200 (CEST)
Date: Mon, 9 Sep 2024 10:45:30 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: <devel@linux-ipsec.org>, <netdev@vger.kernel.org>, Florian Westphal
	<fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
	<horms@kernel.org>, Antony Antony <antony@phenome.org>
Subject: Re: [PATCH ipsec-next v11 00/16] Add IP-TFS mode to xfrm
Message-ID: <Zt61qqs0eN3m20An@gauss3.secunet.de>
References: <20240907022412.1032284-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240907022412.1032284-1-chopps@chopps.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Sep 06, 2024 at 10:23:56PM -0400, Christian Hopps wrote:
> * Summary of Changes:
> 
> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
> (AggFrag encapsulation) has been standardized in RFC9347.
> 
>   Link: https://www.rfc-editor.org/rfc/rfc9347.txt

We have to defer this to the next development cycle. This is
too complex for a last minute merge. net-next will shut down
on Sept 13th and I'm unable to do the final review until then.


