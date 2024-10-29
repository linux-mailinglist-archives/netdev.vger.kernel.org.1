Return-Path: <netdev+bounces-139921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BA79B49E7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2F51C20E52
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0022205AD2;
	Tue, 29 Oct 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ijjlgutL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C5A205AA3
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205717; cv=none; b=HoTIRzqxQ+8Xk7wzwabPqbD1NOVkoiAufzVruzbm+T7tKpk0ZxK6tyLHOBASfqj/amBSe6A2w8BSf/+LWzPh4yv0G932Ethcn6WrHIr+U/rdnj25Ti9KxyBA8s33ZYVl74KBa2gIbSMW1ywibztrN1iwdz7mC/mxXEow9fAgfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205717; c=relaxed/simple;
	bh=2lw3RMkc6fgRqfGrHXcSo33O8hOX0nHbMBEh0FI+x8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpuCXeO9EitO319ARikYhE4qCWTEPcDE9XMDA+XzHx7zx+KAhWGfUX/6GrBDiMyJG2TXEOzMFcqKmU7BQhRjqAYHRhFKziUp3Z9WVZKRSK0YxcAW9DkV8T0Gac3HmMT2m1X/xc2Owkfc1t188yec+79ax00cW5hr15XChMVEpaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ijjlgutL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z6YJASaTvIkM5c++DYnjuNvZ4yfAs/nyFRbB1i9Zb/I=; b=ijjlgutLIdQ2EGS7m8KavkW7GA
	K02IsDa8ASqy1tmgQMJfsbzBYyICYyv+KuDpgCpVDmU2+vjuzY9hDIT669+IbbFE/W2PHNzTFaZr5
	70+a1E0303jOlF58af83ApRedNO0sWFgE/wMnlLRUAuEm62IeiusWNZqKvKo/oXPE3QQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5lXZ-00BZfG-Jx; Tue, 29 Oct 2024 13:41:41 +0100
Date: Tue, 29 Oct 2024 13:41:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Jacky Chou <jacky_chou@aspeedtech.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: ethernet: ftgmac100: fix NULL phy usage on
 device remove
Message-ID: <aebb1d86-9beb-4feb-9c36-33f43daf8034@lunn.ch>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
 <20241028-ftgmac-fixes-v1-2-b334a507be6c@codeconstruct.com.au>
 <8780e73e-78cd-4841-8c04-b453fe664bab@lunn.ch>
 <1cd43fd0c6dd6948935cee366024ad0cb1118ca7.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd43fd0c6dd6948935cee366024ad0cb1118ca7.camel@codeconstruct.com.au>

On Tue, Oct 29, 2024 at 12:36:44PM +0800, Jeremy Kerr wrote:
> Hi Andrew,
> > This all seems rather hacky. What is the mirror function to
> > ftgmac100_phy_disconnect(). I don't see a
> > ftgmac100_phy_connect().
> 
> There are different paths in physical-phy vs ncsi, so they're
> implemented differently in ftgmac100_probe() based on those
> configurations.
> 
> If you feel the driver needs a rework for the phy setup, that's fine,
> but I assume that's not something we want to add as a backported change
> in the net tree.

Lets see how big those changes are. If a fix needs a patcheset of lots
of small obviously correct changes, GregKH will accept them for
stable.

	Andrew

