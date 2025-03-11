Return-Path: <netdev+bounces-174035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5714CA5D1AB
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 22:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C29189D577
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E03822A4D3;
	Tue, 11 Mar 2025 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5Cwa0BlJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F60199FBA;
	Tue, 11 Mar 2025 21:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728147; cv=none; b=K+oQcXiwiFAY/lTV7uchvDE0GaUcsz94oMtOgOBeaQy3/J2PtsLev8w1x9oPjQzoxvH5rzFfTCkL53Oz0Pro3TtzdG4Q3YjMPacGxMjng92ud+No6hbtH5s1uLRES4/UU7sdtQ3DlWKzxTq9iqjsPHZYkn2X8a3+trgd54eiA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728147; c=relaxed/simple;
	bh=6FmHrZ28nxIM9+DQ++GJcTP+dTBWDxQyO+o6uzF7GO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKpDCHtdME90ECWO9NzhMd5zUsZ7VOrv2GDg9QczF0syu4bU/3GiDvGhPZsBAhQ3zer9ZAqO2jTW2C+hdf32GP1Vvv/EZQZOq2/jreHHhXlnN6VmaRUyqEIb/ROIrC5o2qQo7IlJDdpOb4zafESAWsFktRZPlSpfdLcglOSx9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5Cwa0BlJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zHOpgl0ZDBsyqGRYxODkAkcWkAATucDMx8mPREh5p6Q=; b=5Cwa0BlJ3ukKnoZ3ZNphT12BRT
	fkyZeCdsWNr62Uyyl73vQlHTbQEa+4f6eSGunOOrpZkbXsY0QSM5saAtURZsWepBBKckRD3zjf5rr
	QVE+54Ck6OX9iI7CSeke2OehbcH084VB8+ktkYXljabuhDJZCKjxsUwPeQ8ed71OP9oI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ts73I-004Sku-QD; Tue, 11 Mar 2025 22:22:16 +0100
Date: Tue, 11 Mar 2025 22:22:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
	bbhushan2@marvell.com, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, llvm@lists.linux.dev,
	horms@kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH v3 1/2] octeontx2-af: correct __iomem
 annotations flagged by Sparse
Message-ID: <7009d4cc-a008-49ea-8f50-1e9aec63b592@lunn.ch>
References: <20250311182631.3224812-1-saikrishnag@marvell.com>
 <20250311182631.3224812-2-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311182631.3224812-2-saikrishnag@marvell.com>

>  	if (mbox->mbox.hwbase)
> -		iounmap(mbox->mbox.hwbase);
> +		iounmap((void __iomem *)mbox->mbox.hwbase);

This looks wrong. If you are unmapping it, you must of mapped it
somewhere. And that mapping would of returned an __iomem value. So
mbox.hwbase should be an __iomem value and you would not need this
cast.

>  	for (qidx = 0; qidx < pf->qset.cq_cnt; qidx++) {
> -		ptr = otx2_get_regaddr(pf, NIX_LF_CQ_OP_INT);
> +		ptr = (__force u64 *)otx2_get_regaddr(pf, NIX_LF_CQ_OP_INT);
>  		val = otx2_atomic64_add((qidx << 44), ptr);

This also looks questionable. You should be removing casts, not adding
them. otx2_get_regaddr() returns an __iomem. So maybe
otx2_atomic64_add() is actually broken here?

    Andrew

---
pw-bot: cr

