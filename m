Return-Path: <netdev+bounces-71153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157DC85279A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 03:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADD0BB23FA7
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F14F8BF3;
	Tue, 13 Feb 2024 02:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V6JqHE7u"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A568BEB
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707793011; cv=none; b=Se+t7+oYBBf0Um91xUmJ4xetMLAovexa9W5MhHs4pAPmeIFBpa6Jnd7QGoA+bgL9sOIWam6obBsf4J/fBETIcwjjLbkNrCy8cmr9rsntnFl36xitpNav5SzIod43ZE3Ratri3eTVeWPrByqGY7smqLMcC1q4arQcLRhHpezfybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707793011; c=relaxed/simple;
	bh=zrZF5YnWEa0DTGY2qlywnS4c0id/zqFdXNzQt6ZRJzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8cWQg4ujh4rODw65q8quUyRYcEKzK8bYaKL1oxBKrsX+4E0pYiiz+hPyY1WNMmkMXKC2+PZlwx7r6VE2KFt1amG4FPA3jkHIExR66DK0rJcRLvWjKfStCLYNisypYFC5ll3pe3UZfcGo29uUzhxPL1KwzMej/xmYHfibXa6scg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V6JqHE7u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cE5u3amZh8rtiPinjBXs09RbBiYA/SekhFc8Nd02b3A=; b=V6
	JqHE7uwWnf2gX5oGZiPlHZPMSWa9MoTXt924F04VxLxktiEF5Qn01GQg6IWCodWwi/h7kwopqejYu
	Hgr/dUcffBijaRt5MAo4P4BGNKB6xt9/7LngXvp/Fh3C4T7NgOvAFpnUoUiCufZMucEva3btYCKcA
	DCkVxv9MjQtohpw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZiyZ-007ctn-R3; Tue, 13 Feb 2024 03:56:51 +0100
Date: Tue, 13 Feb 2024 03:56:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH net-next v4 1/2] net: fec: Refactor: #define magic
 constants
Message-ID: <20f9be2b-910d-44c9-bc4e-3eb0a49df2fd@lunn.ch>
References: <20240212153717.10023-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212153717.10023-1-csokas.bence@prolan.hu>

On Mon, Feb 12, 2024 at 04:37:17PM +0100, Csókás Bence wrote:
> Add defines for bits of ECR, RCR control registers, TX watermark etc.
> 
> Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

