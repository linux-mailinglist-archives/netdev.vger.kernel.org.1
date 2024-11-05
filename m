Return-Path: <netdev+bounces-141968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4EF9BCCBA
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD9B1C21754
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2DB1D54E1;
	Tue,  5 Nov 2024 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/hMukbG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D711D45FD;
	Tue,  5 Nov 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809751; cv=none; b=RwtOPRm+Ewg4NR7M5jonqQo8CX5UL0bY7SraPY46nz19wlRNmuwa3cWm7vEGYrrazCmlhIMaQDRIw5WRuN7/9MkG6A2KTpObDqtNRtG5h1A3gzxnY+c+GPlb41RN3g2uf5SQJxLDRlKe3ejA+BUtBKNmP3xDLnUSbNJMSD5VaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809751; c=relaxed/simple;
	bh=RxQ35wqxhRLEFVxL1E8K2yQaiN6CiJ9Er7CIu6yX6z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfR47ymP6FM9grIvBdBMRciOSe448jUaCfv5LzhucDdvcwFEpwSheZreLrpnfeW2od1Gz213v6HUFEzTrgWFHoXqhhuyenYgtg/Vn4OCn/elOScb+8yUHb6awtm/9ohW8arEbHZqlOnLZ2wU1q+QRZn7zvgIyFJVvFKxtqWPFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/hMukbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC56C4CED2;
	Tue,  5 Nov 2024 12:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730809750;
	bh=RxQ35wqxhRLEFVxL1E8K2yQaiN6CiJ9Er7CIu6yX6z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/hMukbGADKNHQRBlVpMNvRKdFys9fxwZKrZSfNLZWSTG+KPEbY3kPXeU7UnrTcyI
	 Qc7luKpVlr8QSX9/09GfIdaJ0D6UcMW8c1c7fXwiZlDiUH/SUsRDMsiR4sLxLr/5gM
	 qvH9xsfgi3nn5YuATD9vrjpO/41A842MIIpdOWKs9gzVseHb0Fjw4FSoSIRa6b2AIH
	 AXNEaCmWapB58fCNQZkp6nvf8HYF9V9NnQHNd0Pyt+geU+3sooxpcjo0/IW3bVRp1j
	 6YT7UAbQ38LYjbtYJR/c5PU0NP6ue3lZcJvy72Joz8PIdVjAda1e/7UoewbytZQl38
	 SXxOODXp4xTFg==
Date: Tue, 5 Nov 2024 12:29:06 +0000
From: Simon Horman <horms@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	donald.hunter@redhat.com
Subject: Re: [PATCH nf v1] netfilter: netlink: Report extack policy errors
 for batched ops
Message-ID: <20241105122906.GB4507@kernel.org>
References: <20241101143207.42408-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101143207.42408-1-donald.hunter@gmail.com>

On Fri, Nov 01, 2024 at 02:32:07PM +0000, Donald Hunter wrote:
> The nftables batch processing does not currently populate extack with
> policy errors. Fix this by passing extack when parsing batch messages.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


