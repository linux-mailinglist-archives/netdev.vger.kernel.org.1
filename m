Return-Path: <netdev+bounces-231537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4641BFA18A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D0C19C1A2F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 05:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338292EDD78;
	Wed, 22 Oct 2025 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="g5xGRkjt"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903E2EDD64
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111740; cv=none; b=kFdQCZPbaLHD2gYAWi2wkvMOKLO1L2h345ddovwgKr/7jSqddDbvu84Bd6oKZs1QCTJ+YSDIbOxETYn8QcFIJm5ptMijMJbtSYjPAtTDZdugxmKc9vmRAKl4OgF60fmh5Dr+BFESOtBaacqXLtptqPv6s0ML6e6FrvJPMVKPA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111740; c=relaxed/simple;
	bh=yC+VOs5fLlYzWsJ1w20G4cx73MYiSWm4aSrq8t6sbvM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niFSojFPfd5dmc8JZsXeyyg1IFSw/1p9Iuy1H4up1NkEK/21YA78xPtdPw2KC2qUOz9VOHaGkTrBHOYhcYH9OAmIRxz03WTwlyRqjW46Ta5vVWTMmKD0OflcOdrjBw9bitx+SnjK7Tvo9EXH1jpzrnph3yhiQQY/5AmaehBzVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=g5xGRkjt; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C5DA52080B;
	Wed, 22 Oct 2025 07:42:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hbhMxBFw2BN8; Wed, 22 Oct 2025 07:42:14 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4BDA6207AC;
	Wed, 22 Oct 2025 07:42:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4BDA6207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1761111734;
	bh=1ldGTzaNtvziz7fgd5AsD8Iv1Y6GXF5P+w/QGU8Nyl0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=g5xGRkjtZdd7eC+BRzb9pMkyTUvlT/m/uc2La//6hWBWYcbk6w+/zDmMyf9Ie8OEW
	 RkIHOePVUJGXe94I12o2Hr720kBtYGPeRzq15omsjkUL7MqnGBSXqtiAAJ0Bcm63RD
	 Yyyt7O4dSbvLVmXADfye+MR3Ul2LzyvHt6vdveID5CDnMnEZE7Ext+g3lx4+0F7laP
	 T7b/Ga+FBeNUzf7ouqN0ApKJ5TzwZ9BeayAQ7zCqOdF2dYqgklarcw4r9HgCKDk84I
	 obEpnhVtjO55si9wds214HxfW60SF/foKGtSCbKLHF3dQs61mBhrSTu23DkPNLN0Mw
	 BhcQA4FHZww1Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 07:42:13 +0200
Received: (nullmailer pid 3628953 invoked by uid 1000);
	Wed, 22 Oct 2025 05:42:13 -0000
Date: Wed, 22 Oct 2025 07:42:13 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec 0/6] xfrm: misc fixes
Message-ID: <aPhutXcAKXilFnrG@secunet.com>
References: <cover.1760610268.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1760610268.git.sd@queasysnail.net>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

On Thu, Oct 16, 2025 at 12:39:11PM +0200, Sabrina Dubroca wrote:
> These are mostly independent fixes for small issues for state
> creation/modification/deletion (except for the 2 migrate patches).
> 
> Sabrina Dubroca (6):
>   xfrm: drop SA reference in xfrm_state_update if dir doesn't match
>   xfrm: also call xfrm_state_delete_tunnel at destroy time for states
>     that were never added
>   xfrm: make state as DEAD before final put when migrate fails
>   xfrm: call xfrm_dev_state_delete when xfrm_state_migrate fails to add
>     the state
>   xfrm: set err and extack on failure to create pcpu SA
>   xfrm: check all hash buckets for leftover states during netns deletion

Series applied, thanks a lot Sabrina!

