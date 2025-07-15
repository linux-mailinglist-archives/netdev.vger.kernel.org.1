Return-Path: <netdev+bounces-207184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E29FB06212
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D14418899A9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938D1EB182;
	Tue, 15 Jul 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGzoChP9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6A13AD1C
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591200; cv=none; b=JQVMpkx40QxLBv0AdZe2MPd76f2/J+DCFRVtkoCSf5QYU01fSgBNFC/9ioiyAqk0byAnWn+OCukBj8o5a5jMkrWe+ZunwCN+1XdphBeQDGf5dA5+TFUiR1Z427gtiZDSYhrD1UmOGLSqHqgbJZ4NYaSiaCIgv3mWxZJedqZ9DOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591200; c=relaxed/simple;
	bh=KkrX6iJrmxqI3Jaa/B7/x1LpDwS6hAp6PN8Eet5QlAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bk3E9y5vi5mUeKaU39g8THUxO0bBXvDNw3f4pr1gVHU0BY5r6ktuI2UscJzJMJg/+b6vwV0wiGRRCEBae8LsprgLM6PmWvP7qnkBFbajRhmcth3DT+rsu6N0Lyy3BtgynPaTV7ZkPPpsGNiQgGuI1Ei/XFrWOUZFtsG7qiR52/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGzoChP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F29AC4CEE3;
	Tue, 15 Jul 2025 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752591200;
	bh=KkrX6iJrmxqI3Jaa/B7/x1LpDwS6hAp6PN8Eet5QlAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kGzoChP9zTZ6qLZprxzHh50Rn6sX/8tkhO4uxUTPzM/4X0hMjHB9vPi+skLMtU9h8
	 wY1KEUsuzGSgXS1/Benu8jOkuqskJ+a1FtmTXNpsIaugZ9mgEXsMD0a1XR6gyBgssN
	 PHrQqV7UpHcNGEt2ZUpcJw9U00vAFRgqoLbmbI60GclQEZfg2vHuePC80/XHEux4mX
	 KaqrM7vRSrUj0iUBo8xajNKXxkxWW2EtF/wa1qfWhZz4+tB4D/6l/I40Ddm4bsl5/t
	 9Yd1ZEdV5XvUfhllEtTjVwggza5uYTEfYGcGCFMkCHoXK2wW3eqzxZRRMWHzgdKoJh
	 Z/rsEA9TmDf+g==
Date: Tue, 15 Jul 2025 07:53:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 00/11] ethtool: rss: support RSS_SET via
 Netlink
Message-ID: <20250715075318.042c08a0@kernel.org>
In-Reply-To: <7f9b4414-a972-4256-953e-103e3055276b@nvidia.com>
References: <20250711015303.3688717-1-kuba@kernel.org>
	<24aa8c69-89bb-440c-8d63-79d630800c88@nvidia.com>
	<20250714093537.438fc6fa@kernel.org>
	<7f9b4414-a972-4256-953e-103e3055276b@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 09:33:38 +0300 Gal Pressman wrote:
> > I'm planning / hoping to get all of the functionality implemented
> > before the merge window.  
> 
> Are you also working on the userspace part?

No, TBH. My target is container management daemons.

