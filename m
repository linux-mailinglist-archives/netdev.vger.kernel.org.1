Return-Path: <netdev+bounces-105242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8D39103C4
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E3B1F211F5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA9917C21A;
	Thu, 20 Jun 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBMFUmBx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D1FC0C;
	Thu, 20 Jun 2024 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885512; cv=none; b=EOS5Zl7IhiDQRtfwS9sheDMNYy+Yh5XOee6/Z6JoQZrwjUYeaFndVaFzqVq/r37LISrKGZPSwegsFK6L5N+EWhat+Ea2auejxviFnUtqvWyl0wda/bFhnUSGCXNZ0kq7vb51Da4UdCCIvMdhWdaVPCrBQ8sixwpcdG+nKplsvMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885512; c=relaxed/simple;
	bh=+xYBr2Rr5YSVaIHplFN3wqSJxfH77GiL3F9P2UWtFh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqOh8wjr8c9AFmWEAu2AB7qSKfTBObBvPTdQBA5KUggPKQpMWYow8PVHl77PRJle1mkxMFxewJZmSFapag2SltvVfjzDxP0zjEgJDqx69l2zBJm9Chr7aL4lpBVy6aQ25mR0/zas839p1gyZ8Bi9sUXIiiosNJuy/sG6bHUjZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBMFUmBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D0BC2BD10;
	Thu, 20 Jun 2024 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718885511;
	bh=+xYBr2Rr5YSVaIHplFN3wqSJxfH77GiL3F9P2UWtFh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBMFUmBx+gFpFj5YHgkh26jqBZvKOK6I/BJlg5vx3P3ur2Q304GUcQ2OIuGt/Ru38
	 9afPSDvXXuVWOc1p13Bc4MNZ9xfRbzq2s7OjRlto0z2WeijEt4E6bRZqwusc8p0fxp
	 o2vvkoAYAecckotoiCnGGGRuHbxIkE+rnjbJvasya7ueV1wPCdb9aJsoeQQt6VYApn
	 DiGSC50dUYMIJILBcfKJhCgyRqwiwrSHKcVnJBpZGWSj5/s57HEel18SQoJcRR6nai
	 +6gcrU24DtbPlZu65rzGsjF7O/z0T1Ck/GxYRFiEEvath/XMCvPgwLPqSKcOzzybqE
	 IUoibJe1cjkDg==
Date: Thu, 20 Jun 2024 13:11:43 +0100
From: Simon Horman <horms@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com,
	donald.hunter@gmail.com,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	awel Dembicki <paweldembicki@gmail.com>
Subject: Re: [PATCH RESEND net-next v14 1/5] linux/dim: move useful macros to
 .h file
Message-ID: <20240620121143.GA959333@kernel.org>
References: <20240618025644.25754-1-hengqi@linux.alibaba.com>
 <20240618025644.25754-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618025644.25754-2-hengqi@linux.alibaba.com>

On Tue, Jun 18, 2024 at 10:56:40AM +0800, Heng Qi wrote:
> Useful macros will be used effectively elsewhere.
> These will be utilized in subsequent patches.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


