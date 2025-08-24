Return-Path: <netdev+bounces-216319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BFDB33163
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 18:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8B144347A
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F52DE6F6;
	Sun, 24 Aug 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aLJS7e6g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E22D542B;
	Sun, 24 Aug 2025 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756052005; cv=none; b=VqXrB00MNx+7w4hSf4zccJHzQdFXN1lOMJ9g6jAGQfYrEXCn3//daWIQHKeCRa4EzQfcrsLh3oVtjGSorgegGvXDWfsYj2xC0fpIJmcda36MtnhU4WFww5+zDkWBMU23z64//rPSAjIuPOD+neovRCR2JGUutUijeClBuwCeY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756052005; c=relaxed/simple;
	bh=p5qKT2vPMKAC/6fg2dW3jbJT0fyJ6j956HAFp2rmzXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YasBu/RjcHmRzhdzWdwXLXJyHZV5tvMnKjA9nJRDrcUPEqEe8RsRQ7JzLlsMUh/pmYhPYii05+I+hTDePiHhu7OQpS8V4lmLSbKneVMQ9gXYUx9/mudsOft6jTpDcY0or203ByNLcBubawx9KqamLkX93xLJeCKOgvrcqy3NDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aLJS7e6g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tbcujWjLVSPoIfoPR7/pBE11nNuK/PjdZ78HbRdzlgs=; b=aLJS7e6gxU25xcxKBtH303q+Dp
	bd4ZzXVDfItQ3bPMBNiBWMclK3C7iyXoCpkIBTM3oj+rm/2ZEEtD5pLg8RslW6JTLj+/vx395m38/
	MTyIBW+fat7WvvY/GnLiQ1Ramaiii2ytZnhIu7GqweYbz6XcERBp+ffs4V6/7icmdEZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqDLF-005qQi-GM; Sun, 24 Aug 2025 18:13:13 +0200
Date: Sun, 24 Aug 2025 18:13:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Message-ID: <a360fadc-0cfc-4d4a-9028-f63e2105634d@lunn.ch>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-4-shenwei.wang@nxp.com>
 <0abb2c91-3786-4926-b0e3-30b9e222424d@lunn.ch>
 <PAXPR04MB918577F27FD6521B23601219893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <6b1f5bcd-e4d7-4309-becc-de4a12bdf363@lunn.ch>
 <PAXPR04MB91851EC6E79D76E8220C5251893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB91851EC6E79D76E8220C5251893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>

> After further consideration, I think we can simply keep MAX_FL set to max_buf_size and 
> only update TRUNC_FL as needed. This approach is also sufficient, so the logic introduced 
> in patch v2 has been removed. Let me know if you want to add back the above logic.

For me, higher priority is you review all the commit messages and
comments. A lot of the discussion here has been because the comments
don't fit the code, and the commit messages don't give enough details
to explain the changes. They are just as important as the code.

	Andrew

