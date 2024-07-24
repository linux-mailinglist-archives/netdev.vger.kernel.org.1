Return-Path: <netdev+bounces-112880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411B393B965
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 01:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0062283C02
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 23:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA2813D881;
	Wed, 24 Jul 2024 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UJLDTxPL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82EF13A40F;
	Wed, 24 Jul 2024 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721862759; cv=none; b=nU0Qm3quX/XsmYlRdGtpek7sTZH+DFykrIJa97Mn4Mh+xavV3qXiBf6ts4TrnyxSd4yzXqw+5gL/prgUZiHe4SOAkSx/i2ffgaysj88/fqA5w8RjC+Dm4D8DmcJ6EOFBGmTG3AhG5jk5JfYRR6ZJE9TiNF9Hx39zEKKabuQ97v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721862759; c=relaxed/simple;
	bh=1OKNq4M7uG6CoqfxzGc4SF6xblNtiouPmAQzALmTbkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ2fiMhrEbvuZkqyzZJ3lhBaJPWd8ldrIZlSrUOR88/hENJa036a6zC6sWBYhgmsOGaZQddmtNcBPUCZMac7oHlvxIsFhlQOm9wVUL75C0oFU21i6Pw2UK5dsIWV1nY2pyTureRNrJ6FkLVjhlrsR5ufiVMknCAe6axIocOo6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UJLDTxPL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GjbnnVqC66fvfkXajlXOjpoXlEGx98ju80H31GTzwf4=; b=UJLDTxPLfi2WfGPuLQrOVcheCe
	Gh+sJsitgWE/QPjMwPYvMLcdNeqyhHxBfO8Gn3VDS2UxlU03/k23y8Y0IhApy7ihOpdGhUPSWrhjZ
	TjkSNChdHFl7hzPovcESwQlwFHA+x9EOpFCLSiU3+SM7N127KefzbAVNlFCl6CgubtkE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sWl9g-0039qK-NH; Thu, 25 Jul 2024 01:12:20 +0200
Date: Thu, 25 Jul 2024 01:12:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, liujunliang_ljl@163.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: usb: sr9700: fix uninitialized variable use
 in sr_mdio_read
Message-ID: <b944909b-1e75-4ec2-9c0e-e90269d7bf84@lunn.ch>
References: <20240724011554.1445989-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724011554.1445989-1-make24@iscas.ac.cn>

On Wed, Jul 24, 2024 at 09:15:54AM +0800, Ma Ke wrote:
> It could lead to error happen because the variable res is not updated if
> the call to sr_share_read_word returns an error. In this particular case
> error code was returned and res stayed uninitialized.
> 
> This can be avoided by checking the return value of sr_share_read_word
> and propagating the error if the read operation failed.
> 
> Found by code review.

For V1, you were given the comment that there are other functions
which also suffer from this problem. You don't appear to of addressed
them in this patch, nor replied saying you won't because....

Please don't ignore reviewers.

	Andrew


