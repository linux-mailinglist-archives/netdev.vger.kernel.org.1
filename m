Return-Path: <netdev+bounces-209358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17110B0F588
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9A83B189C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F2B2EF297;
	Wed, 23 Jul 2025 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D5FyOuva"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6F18C034;
	Wed, 23 Jul 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281528; cv=none; b=kpQ02iEyLJDYy443xpDWqRsl49iDXX/sXZGovVucwoIx8p5slX9tJ64AJFeuG+579fjkhifIsy4d9QGSHJn2BSAHBeZh1Lb4l4378lx168KU39/Ms9Wh2b1K0nTIKMnYR29iwXeaPX456GdOcptWueBQu6MmOGrax6LNfZAzKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281528; c=relaxed/simple;
	bh=bqqHVuhers+AnG1p9ntDVF//PggK43OA3jZgm4ETSzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VebfWRyo+a0m5th8JcC4CKWQYzGtLlT1nip+S0t2WiSdpuA1pl2pDx8F35Ph5Uh6Qs6EBPIwTlXwQl/BFnBqx9UN+g3c2xtWh1oCU3wn0IdDJhVv+FrljJWUejdEECc7aLWpVVYoeVnhHJ/wJWV1xrBnO7FPkiZOBAparTxRzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D5FyOuva; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k7MPESA93PHf8oceULlQeB6X4xM6287bZxnzkilj1yA=; b=D5FyOuvaris3yqB6ASe3pMFMjQ
	aT2YJMOFEzN//jdnRrzlAeMndmwpFTewlXeI1sD3V+4YbtOA50plfLfpNr1KsTV6wXlhE7JVbesjF
	pzBy8MznGCzLcs8/ljSCkLef8ljPWtrwt4BiHHEv6x9jSt6xv/VCSEmqKZ1UfABTVwAI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueabY-002bVQ-1b; Wed, 23 Jul 2025 16:38:00 +0200
Date: Wed, 23 Jul 2025 16:38:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: Simon Horman <horms@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, gur.stavi@huawei.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <7d191bc9-98cf-4122-8343-7aa5f741d16c@lunn.ch>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
 <20250722113542.GG2459@horms.kernel.org>
 <78BE2D403125AFDD+20250723030705.GB169181@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78BE2D403125AFDD+20250723030705.GB169181@nic-Precision-5820-Tower>

> > Flagged by W=1 builds with Clang 20.1.8, and Smatch.
> > 
> > > +}
> > 
> > ...
> > 
> 
> Got it, I will fix this.
> Maybe my clang (10.0.0) is too old, I will update it and 
> try W=1 again.

10.0.0 was released 24 Mar 2020. That is a five year old compiler!

Try something a bit more modern.

	Andrew

