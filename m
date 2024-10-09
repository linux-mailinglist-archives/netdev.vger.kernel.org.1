Return-Path: <netdev+bounces-133538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3299962F9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84EC1F26721
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B918E36D;
	Wed,  9 Oct 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rVy8NJ8a"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4B18E35D
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462820; cv=none; b=FIHPfoZ5wfJdYSAx0FzWK0CWJfyLnrRFuFaH6Clxv6mmm1p08Mzp4N0E1YuhZiOPXTFEDnBX7tljIdsiHHvmFILiZ5eWiyL68MyzS5cOHj3rYzHF867QoDPZj3KYSlQKYr/r7bCDA4C7Q2yPQYOecAPBx9z71hFyzqtMoJD3EpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462820; c=relaxed/simple;
	bh=QmUzLpJwtrtXDslUOVaTb2abhIBC3dmK2TCxbaTSQjk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAr+7PhbF9wfsbdztztGGJYIwhCxMGEduRqjCm2gaGlblGvKlm1MtDFOX4JhnoNk7a9swdmowJL62QVrpHNPjnZf28wNPXvydEqNH4h3+rxe0knl4zFcJoHGeym89OuE1h2/uozX64v65tU9pv6C0ydrOXZKqn1fjR2izgH7h1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rVy8NJ8a; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CFC9920882;
	Wed,  9 Oct 2024 10:33:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id APziTYX-JqoZ; Wed,  9 Oct 2024 10:33:34 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4843D207CA;
	Wed,  9 Oct 2024 10:33:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4843D207CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728462814;
	bh=QYcRYUbjerJSEII46qvYZCVqOTLZ5/7lfq274X/x5cQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=rVy8NJ8aiT5n2Th4Zquyh3RZZIBKLlfkNBqALdWSm4eMBtSiDt9KqXGIDkY1jNk0r
	 miXUeK1nVIgmGUb43LkCHSAzk+252dkolHn+Ot/HhZ4DpKKaFUoCT7Qh4L9OEcFw40
	 ie3ThMjUnF47fvB6i42Y3yfzM6UEt7Ptp90O9BN49uNqhYP18FhaJyTgR6JR7DznxE
	 OHr1yHDkt7wBz8Gn/jWjlaxo8+YbPAp2bxpjw4WOn9OGiMOMPzt0+7S9P3HHkEZRZR
	 28+Haq1msrb8rxgr0C0cP1EsPuuLtn+pM+pSYa5OYy/v0gobcJCP2DeTc/JWygHmgY
	 FLCFu6My+DHXg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 10:33:34 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 10:33:33 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A12B33182C78; Wed,  9 Oct 2024 10:33:33 +0200 (CEST)
Date: Wed, 9 Oct 2024 10:33:33 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>,
	<syzbot+cc39f136925517aed571@syzkaller.appspotmail.com>
Subject: Re: [PATCH ipsec] xfrm: validate new SA's prefixlen using SA family
 when sel.family is unset
Message-ID: <ZwY/3SegtYrbcSLd@gauss3.secunet.de>
References: <c8e8f0326a3993792a65125fa200965e8a4580e4.1727795385.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c8e8f0326a3993792a65125fa200965e8a4580e4.1727795385.git.sd@queasysnail.net>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Oct 01, 2024 at 06:48:14PM +0200, Sabrina Dubroca wrote:
> This expands the validation introduced in commit 07bf7908950a ("xfrm:
> Validate address prefix lengths in the xfrm selector.")
> 
> syzbot created an SA with
>     usersa.sel.family = AF_UNSPEC
>     usersa.sel.prefixlen_s = 128
>     usersa.family = AF_INET
> 
> Because of the AF_UNSPEC selector, verify_newsa_info doesn't put
> limits on prefixlen_{s,d}. But then copy_from_user_state sets
> x->sel.family to usersa.family (AF_INET). Do the same conversion in
> verify_newsa_info before validating prefixlen_{s,d}, since that's how
> prefixlen is going to be used later on.
> 
> Reported-by: syzbot+cc39f136925517aed571@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Applied, thanks a lot Sabrina!

