Return-Path: <netdev+bounces-208202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD06BB0A923
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 19:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67A83AF15C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52A32E7BDA;
	Fri, 18 Jul 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/KdL/DE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884202E7189;
	Fri, 18 Jul 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858598; cv=none; b=bISBJ6zBgUwBXbbCz5s9n9S21gqy9Yld3N4Feb5REzAU5Q+eSUoMVPXdsci3p8aCtA16xMTYfzbm+/QI1w60iFauGWIVOK42/lSz8pSdRptkt+30ocKQGXvTebtm9Wh6kPbEa/t+sZAqmqGf2bUiFR87f5stM7RaFFMg/fDP26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858598; c=relaxed/simple;
	bh=7Z3Ol4AT6FLK1r9j8SN2UQDmXXM8ZsQwIqfdpq9rbeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLN5nNOGyvDecBABY/htn5iSlk3s7GKnqZHToAvylcICZKpY3v6CeWHTXpwSLbcp8UfyzRAO6jJ9nVf+HRYxgHzvGbXXOGKiSLvk5kIJfx6J4K7v2jlnLn9LpE0Rcy/ILQSKDiQq8fABbRt8gfIifVkFl+XR0OVJAtoWUjPULGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/KdL/DE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71B2C4CEEB;
	Fri, 18 Jul 2025 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752858598;
	bh=7Z3Ol4AT6FLK1r9j8SN2UQDmXXM8ZsQwIqfdpq9rbeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K/KdL/DExGAJS+GCbgbDo9uTGXr8rFLOrNGPxvCskLrs0hdQVhX1GJs+OWhrugDuq
	 DXA2xBEYryUiu5LlxXdFoZLa7H+q9kdxv6SQr5jQ7mnJzAVADKWXlk/wh50YdE2j+x
	 slS7ehtV7jy22FjYct8BeOiuMJN1fjbBSu2wvZqXim4cGNuP1fjGxvvo9xFYlK2+hB
	 q4Nz4Eg+bR4lCoKP3y40OUOUDH7iKoHvjeWY56ML83gMz7YjNetMH2tPqR+P2rUnnj
	 TQXnBdR7y+v2MLsa9R8T/cLUnbcSZZf/cdu3Dhhfx03b1Jiucu8HWLsNDZKVLoKkiZ
	 aGD+dDC0znswA==
Date: Fri, 18 Jul 2025 10:09:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>,
 andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
 edumazet <edumazet@google.com>, pabeni <pabeni@redhat.com>, robh
 <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, conor+dt
 <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, richardcochran
 <richardcochran@gmail.com>, s hauer <s.hauer@pengutronix.de>, m-karicheri2
 <m-karicheri2@ti.com>, glaroque <glaroque@baylibre.com>, afd <afd@ti.com>,
 saikrishnag <saikrishnag@marvell.com>, m-malladi <m-malladi@ti.com>, jacob
 e keller <jacob.e.keller@intel.com>, diogo ivo <diogo.ivo@siemens.com>,
 javier carrasco cruz <javier.carrasco.cruz@gmail.com>, horms
 <horms@kernel.org>, s-anna <s-anna@ti.com>, basharath
 <basharath@couthit.com>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, netdev <netdev@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, pratheesh <pratheesh@ti.com>, Prajith
 Jayarajan <prajith@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, praneeth
 <praneeth@ti.com>, srk <srk@ti.com>, rogerq <rogerq@ti.com>, krishna
 <krishna@couthit.com>, pmohan <pmohan@couthit.com>, mohan
 <mohan@couthit.com>
Subject: Re: [PATCH net-next v10 04/11] net: ti: prueth: Adds link
 detection, RX and TX support.
Message-ID: <20250718100956.5afe55c0@kernel.org>
In-Reply-To: <3177386.41994.1752835625751.JavaMail.zimbra@couthit.local>
References: <20250702140633.1612269-1-parvathi@couthit.com>
	<20250702151756.1656470-5-parvathi@couthit.com>
	<20250708180107.7886ea41@kernel.org>
	<723330733.1712525.1752237188810.JavaMail.zimbra@couthit.local>
	<1616453705.30524.1752671471644.JavaMail.zimbra@couthit.local>
	<20250716140926.3aa10894@kernel.org>
	<3177386.41994.1752835625751.JavaMail.zimbra@couthit.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 16:17:05 +0530 (IST) Parvathi Pudi wrote:
> We appreciate any feedback in the meantime.

LGTM, thanks!

