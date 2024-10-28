Return-Path: <netdev+bounces-139562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AE09B3132
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 14:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0047C1C21194
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7F1DA2E0;
	Mon, 28 Oct 2024 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IS41XOy3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41181DA10B;
	Mon, 28 Oct 2024 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120372; cv=none; b=i6PuZGxXFh1G4or6cwxLOAAaVOI95MHXLrmwTIiKqTiSHaq1pMRUa1Mr2uk3cWhzYqEp0CnPdN+qp9/UhoGOynxSCX0wMXdKAaWE7zeL3qwcAhK11lLKLUXqzcDfFW/9Gd1AoRNB2zN8ytTo4+FLbp6sjWC+FO8AHOLm2/bUFbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120372; c=relaxed/simple;
	bh=mq0gb7RG5wMIIwqrKec2YnIA6seOcj4ZWsVJ7YagKO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6dsU/yh6qGvjmT1rXYzCG23jMJTo0cpnZaOBxgZ7Z8idN2Lvq79/stAvwRb6XhOub7unihOaxFITfWf5TzpHlIx1gud73xUf9994kQ68wfrlCpVrM7qMhZNdf6FJJpQYBqU7TmelpjjsIjdM0jVNJlBOuCxJMrsR+TjqvfkXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IS41XOy3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jzRfsORNZvsjrYssNca38SOvtAL4bIuf/RDFrDeFoV0=; b=IS41XOy3kWGvXgWiQkdJVqIqhP
	P5ZWgMaxOmti1evlonFJvqk3PovM+95v1BM6GU3LwA8sTYQ4g/4u4VRvj3VMHvM7ZEBD3qIbMTboK
	s2zY3DNyDJxkUGD4anKRqQKVNHsU6fJ2EvpyIR4XkW9LuFVKJtAMrcEo1UGXAcfhGTlM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5PL4-00BRmK-E7; Mon, 28 Oct 2024 13:59:18 +0100
Date: Mon, 28 Oct 2024 13:59:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andy Yan <andyshrk@163.com>
Cc: Johan Jonker <jbx6244@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	david.wu@rock-chips.com, andy.yan@rock-chips.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1 2/2] net: arc: rockchip: fix emac mdio node support
Message-ID: <0a60a838-42cb-4df8-ab1f-91002dcaaa14@lunn.ch>
References: <dcb70a05-2607-47dd-8abd-f6cf1b012c51@gmail.com>
 <f04c2cfd-d2d6-4dc6-91a5-0ed1d1155171@gmail.com>
 <250cdfef.1bfc.192cd6a1f72.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <250cdfef.1bfc.192cd6a1f72.Coremail.andyshrk@163.com>

> Hello Johan,
>     Thanks for your patch.  Maybe we need a Fixes tag here?

What is actually broken?

	Andrew

