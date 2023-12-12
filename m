Return-Path: <netdev+bounces-56490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F22680F1CE
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED431C209BF
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762597762D;
	Tue, 12 Dec 2023 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCRmmo05"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A487762A
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 16:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63252C433C8;
	Tue, 12 Dec 2023 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702397110;
	bh=shND2JWB5x3Z+S1RTbK6XSI5qan81/apFSZ9av6syEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LCRmmo05GoXe35HGbVELJxl+iJSKsbGcS7DMz5/zRrwrkJ1Asc4O1ckCoCzGQm2Vo
	 bnS/b8JK2m3bO/xGfj41wH03YUPrU1mOhXh5Wy3O7gwX1z1BYasvfAB3ffFyeH88Ba
	 6A3kLUpE0b0DaVkBStOVm135c+L49bR+zm90kuHQKMafGzNTghxHwSWlfMtROxmAYG
	 1tiMHGc9G1/W9zN5mcgqCzB+AzZMwG0Qn6n93X5QijNvpQYIo2EjPUMjfCzSFJGbuN
	 BJjToaL+zoR7L0YJQX2DwS25QxM3xA99ATkdXZm97k0FQQ9Gnjrykxtvw4dBw3HRMM
	 d5+Lvkq9CJ4ig==
Date: Tue, 12 Dec 2023 08:05:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 edumazet@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v14 01/13] rtase: Add pci table supported in
 this module
Message-ID: <20231212080509.48ec4931@kernel.org>
In-Reply-To: <0d8195d3c1aaec85e74d7ae2bf5b1a5b9c1a0b78.camel@redhat.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	<20231208094733.1671296-2-justinlai0215@realtek.com>
	<0d8195d3c1aaec85e74d7ae2bf5b1a5b9c1a0b78.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 10:36:16 +0100 Paolo Abeni wrote:
> > +static void rtase_remove_one(struct pci_dev *pdev)
> > +{
> > +	struct net_device *dev = pci_get_drvdata(pdev);
> > +	struct rtase_private *tp = netdev_priv(dev);
> > +	struct rtase_int_vector *ivec;
> > +	u32 i;
> > +
> > +	for (i = 0; i < tp->int_nums; i++) {
> > +		ivec = &tp->int_vector[i];
> > +		netif_napi_del(&ivec->napi);
> > +	}  
> 
> You must unregister the netdev before napi_del or you will risk races.

Or del them in the ndo_open / ndo_stop... Note that ndo_stop is always
called if ndo_open was called.

