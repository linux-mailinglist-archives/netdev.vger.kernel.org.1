Return-Path: <netdev+bounces-102343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3EE902906
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 21:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3BD1F22BEA
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE614B973;
	Mon, 10 Jun 2024 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5aP73+kw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF81B5A4;
	Mon, 10 Jun 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046822; cv=none; b=MHFZ29rl9l9/HbIFxRMDePiOlm0mXb5srnzAaxO6pL0kr3i5T5j6lFpRyiLzdtSxHw5Vsu/Re+0hRYEMffF+GOJBL24np/praDWpAF6bBlcMftlXAdLXxo3lZPE29BzEOTryfZUKK2RySup4yQWCN+KnloDPqd3fp+o4+kIIKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046822; c=relaxed/simple;
	bh=AIikY8Zt4bR3WdbmPQmzJMiu+nURhz3vU1h42i2It0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvbgFSUUqfiEMXvMzzJUYUYZcZBFoZYcaNUaL85EdCLrtiy3oxuqYR5PTbLvVQPUFZ3UGIV3BJMI9rS6X35AX9jT0NELgjA9a3eqjJbPOfLk9QqQaYMnGkrj4X4zzwCbShB0jnEIOdQ9xxyrxoSRxDeGl5WG3qzZbqDwfQrF4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5aP73+kw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=AYNYny02sf2EkWpNfBeMRhNn7kSp/uaRJn+SOxkY1hY=; b=5a
	P73+kwPC10IrXJyX47Q3y2/DDRLl3LzwAvE1iPPwgvRDwSlXSa0qbWvy8BvHwQTJx3hF5w5Ih49LF
	+EpWVFu+27YFXsiJhwxwfGh6U5MDW4I+wO0TQNc6zul41IFLBwsmKlRuAgLhmmDza2in5raQCWmUC
	6074SkGHwoJWRIE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGkSV-00HK3I-QV; Mon, 10 Jun 2024 21:13:35 +0200
Date: Mon, 10 Jun 2024 21:13:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588
 being cleared on link-down
Message-ID: <46892275-619c-4dfb-9214-3bbb14b78093@lunn.ch>
References: <20240607081855.132741-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607081855.132741-1-csokas.bence@prolan.hu>

On Fri, Jun 07, 2024 at 10:18:55AM +0200, Csókás, Bence wrote:
> FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
> makes all 1588 functionality shut down on link-down. However, some
> functionality needs to be retained (e.g. PPS) even without link.

I don't know much about PPS. Could you point to some documentation,
list email etc, which indicated PPS without link is expected to work.

Please also Cc: Richard Cochran for changes like this.

Thanks
	Andrew

