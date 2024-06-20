Return-Path: <netdev+bounces-105281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585089105BE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4331F1C21397
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168D01ACE9D;
	Thu, 20 Jun 2024 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YzW37JrZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C81ACE61;
	Thu, 20 Jun 2024 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889835; cv=none; b=aju5LaAhrFBRUZ3/Hlca6x75lZxCzzG3Sesh4Qr1rW0TzxgJSrKSmH6W6d23Z7/wlsaonK6/t7XxNqRshrwEi3Gxsx0z4gsf8seXru3FKtJjZdZMQuAqnJF+Jmzb5ljFT8ScyTq55vB3AIb9GuSnb7M4tbwqgJsM/bqkkam424g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889835; c=relaxed/simple;
	bh=Tej9zsAke5lq0hO16R7v5ZqMFpprL1ytb9oN9bDv+Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfza/Q/M/UwluTF063hAkqvnfvggBh9XKIQwXCANUMgveI7g3FtD0fKCcrL+9qdaG25UmiIlzgeZK/50mKKYXCSTn9BH3YXBSu4C2YAls35YdSz0yLo9dINlEbVfJzJTUFjdjlOjNUhvlbfpwoiyFCMqD6+vlD/Z+dUYvtJUOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YzW37JrZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sratUd5R2hWjhwpQ23mEYUMIULKrtn60WH+Wdm6JIeY=; b=YzW37JrZMJlGKseB67gUI1DNGO
	P/dtWHQKHqDG3+nOfLViH1AIXSPHmOEfBg3ksrrbyjl2nwIrbX2Hklk9YYo47+eTKDnBFDLulMeSG
	/wMBIi8zRMrAcYq7142+MoKjT8dJX/ElvWKta3of14jPX8ns1Hs5U/4dJUC/lr9Cg3KQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKHlI-000Zj7-1g; Thu, 20 Jun 2024 15:23:36 +0200
Date: Thu, 20 Jun 2024 15:23:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1] net: stmmac: xgmac: increase length limit of
 descriptor ring
Message-ID: <8b60942a-0ab5-41b2-994d-594e09eff8cc@lunn.ch>
References: <20240620085200.583709-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620085200.583709-1-0x1207@gmail.com>

On Thu, Jun 20, 2024 at 04:52:00PM +0800, Furong Xu wrote:
> DWXGMAC CORE supports a ring length of 65536 descriptors, bump max length
> from 1024 to 65536

If anything, you want to be reducing the number of descriptors,
especially for TX.

Does stmmac implement BQL? If not, try adding that, so packets are
kept in the queues for longer, and only passed to the MAC at a rate it
can put them on the wire.

    Andrew

---
pw-bot: cr

