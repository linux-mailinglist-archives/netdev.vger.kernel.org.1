Return-Path: <netdev+bounces-195483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BF8AD06FE
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 18:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8956E3AADD9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433EE289377;
	Fri,  6 Jun 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ys7VnHh9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5FE13D52F;
	Fri,  6 Jun 2025 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228578; cv=none; b=Q+vnrdpibU4Y4PRFGwH9Zt/5O45Tc6X1p0KLo0QtoTkMAM3OsQKME6yh+h3DkEVt14Ax2VTaPsFVpcvDnB87TlX8iP3Ws9YQV5pBFfpfyEADs0ce2xvU4xd2abRRGvyWFaPCeUe2LjsuPPBDVJCEFu8JK8D/x7cJQR1KMIsPxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228578; c=relaxed/simple;
	bh=CbKTrDH6DkgeqDHwB6B55ZVuxGJDKlN/CGMpI1jO7Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhrX5OGgKmN5V6ooLA5PILbaWJPTSce5uhszvDGlD2DdVmVZxQ+iF6cWTRk9wsxev6wtjJTdwhT1S/MWWjIYMGoEh+cbnln9Q/vXzIecKEkyBXR/83Z+OUhfvLINph+hxxo3cryYWV4TR5zBGqAZISLHVFt4HzlpKJALbsmHATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ys7VnHh9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vPtwpH1jLrXxNG2nETvRcGobsy3AhXLHMhEjodWgmfE=; b=ys7VnHh9d+L+WKkYBGsg1qBjbF
	I/0BIXY579y/T1T5rbPhxDYqCzBFnq2ccBi+IflYIxrnMFiQvaB1MoeG/cLzyT1vp2U1nmUzuQzj0
	L7sPDqeKy586XDsiEcCNtxkh9JBXXkFMSZHWZ7NYDuVryRdEF/BX57eF9uhzgokKTbh8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uNaFt-00EuyZ-O4; Fri, 06 Jun 2025 18:49:21 +0200
Date: Fri, 6 Jun 2025 18:49:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Xandy.Xiong" <xiongliang@xiaomi.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: add support for platform specific config.
Message-ID: <855e58a9-17ea-4baf-8686-15c9abf60a80@lunn.ch>
References: <20250606114155.3517-1-xiongliang@xiaomi.com>
 <aEMbYjmsMUqdsvP4@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEMbYjmsMUqdsvP4@shell.armlinux.org.uk>

> Also, please review the netdev FAQ, if you can find it...

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

It got renamed, since it is no longer a set of questions and answers.

	Andrew

