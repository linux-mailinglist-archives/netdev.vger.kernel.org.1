Return-Path: <netdev+bounces-104906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E2E90F162
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DED528A7A5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78B32374E;
	Wed, 19 Jun 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clnSvhi6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA420DE8
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808908; cv=none; b=DhTEdzI/7zFczx35U8qEU1FamF92Tmf0Kvb6yOIFk8r+dzSuj4hOViRokPYhRLAIgxVswH51knrNSUn3xDLBjxzVPObQyAn1KGLSu8cg/Htb+M9XaLG+VmxvTpFi1vvJlVW8q7QkNj2roKKKRqH+5CjeMwnNQx0z+oPYIiPSZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808908; c=relaxed/simple;
	bh=FyvO4qMd/ufg+PDtyJTaWC7ERNoFjxEhGZ04GRUEnY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2lsPm9jac1dkprVt3YjuyHv41Gz8LskshkfGhZZxgwMzhVeauJ4M5ezbCZDww9MZ3H//WbvVepIWtuwGr9vU4HFgBW0oRq++oVXJAUO6w7Huv9YQgr3xJjmtTIk1KAWktREwphGHHkKaC+UMQz0HY6hPzXBYc4UW6QikK3OKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clnSvhi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17482C32786;
	Wed, 19 Jun 2024 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718808908;
	bh=FyvO4qMd/ufg+PDtyJTaWC7ERNoFjxEhGZ04GRUEnY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=clnSvhi6v432S+ZMcWHo4yCKa0K0HzWSc1fuSyxJmyxz78jb99UkcUSQRKZYZeXay
	 NwjKKkMy7MA0RrgMux2MYrTAS7p71e+ljzonAuZfCL5qAzROz1mWYV4iVD2EkwD9Mk
	 NVGKYTUE3CnbzQw5VhXFxWPuZAuUC1FVt6wLSCB3AGL/eTtBRnIhZCof3Vgh6FcXDq
	 qzcib1VZ9iOyNmddYMIVD+WZ5MQDBeH1g6E90mr8rwyEyRytEvL/A9TAzH74Wog+Fr
	 xOxgGUHHSgAHtMmbzIOJh55nhGZNN+oA1386S9mBiNDksONwv5hnO7VUqqkLwzaSxC
	 IfRm0BTZ4J/eg==
Date: Wed, 19 Jun 2024 07:55:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, linux@armlinux.org.uk,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v11 4/7] net: tn40xx: add basic Tx handling
Message-ID: <20240619075507.1f88d395@kernel.org>
In-Reply-To: <20240619.124422.478553760916754787.fujita.tomonori@gmail.com>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
	<20240618051608.95208-5-fujita.tomonori@gmail.com>
	<20240618185000.1ecc561f@kernel.org>
	<20240619.124422.478553760916754787.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 12:44:22 +0900 (JST) FUJITA Tomonori wrote:
> >> +static void tn40_link_changed(struct tn40_priv *priv)
> >> +{
> >> +	u32 link = tn40_read_reg(priv,
> >> +				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
> >> +
> >> +	netdev_dbg(priv->ndev, "link changed %u\n", link);  
> > 
> > shouldn't this call netif_carrier_on / off?  
> 
> According to phylink doc, a driver shouldn't call them?

My bad, forgot you're using phylink!
Purely out of my own curiosity - do you know what this link change
detects, then? In my mental model PHY detects the link, sends some 
form of a notification, then MAC gets configured.

