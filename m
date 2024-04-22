Return-Path: <netdev+bounces-90137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A508ACDC3
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853021C2248F
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0196014EC7D;
	Mon, 22 Apr 2024 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMszLr0P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A814A4DD
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791140; cv=none; b=b12y2AraxevX/La/BUGQ+3ecOpg46QbniSHrBnDe8rZ+oiDDo4cRpHVhPdZf2EcnzurZjajhfGLThegTU2FvEH0OV3EPkxCOsatQ66Mm5uoG1sGU2YCA6iss9UvWbaMruakLOIYVoIEGDxBfTye9Jaq1grp+/S9sn0Pg6tFjSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791140; c=relaxed/simple;
	bh=5yzDgfivF1tKjJt/ryFcQLitUrHZ4XHW/HfH++9gf1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdV1EDbmuhd/3c3M2xflsxnF30xZx38/jaYMZUi34oVEVMMoM6mPM4ZE/6ZulcVAC9affu+p+l7ThfvvrjTsPChda8P2vWZVD5fahgnXi0DD0XJ70ZmnbytRY2VNVKNpsxtvEosGHVGYOUGCyTO6wY6PBHUH/c/o4rx0K98u9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMszLr0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD31C113CC;
	Mon, 22 Apr 2024 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713791140;
	bh=5yzDgfivF1tKjJt/ryFcQLitUrHZ4XHW/HfH++9gf1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dMszLr0PsHpYIiXP0ZcPuJhjwO3Ws/lqEZnQPCtCqbLDmaXhenlqwYb4eNT95wiK4
	 is9oa7RLL/Un+drNlJ4pxHyw8dzzR/wvkyw/OTKvzWo7Tm3dBMLtG6Wct6tEyQPY/S
	 262dhe1eHx6G6AGMeqjLCyQ3bkeIszdl6QyL6ONap8C1NskEJ05/Obohu7TQcO6ocU
	 l0uT+TKNKJg8onP2BBxZAzp9GIpcPQGrkOxBc5Kzb0lzfMuvD7WLAa9ejJwnm+0H0F
	 6V2wO3evb3Is3ZaMJKftuqsQhdKchgRdgxdtHdRVRT/KtVx6lQTVTYJMcePS5C4K1U
	 uMBhYikZ4L/Bw==
Date: Mon, 22 Apr 2024 06:05:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
 <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v11 0/4] xfrm: Introduce direction attribute
 for SA
Message-ID: <20240422060538.466f8232@kernel.org>
In-Reply-To: <cover.1713737786.git.antony.antony@secunet.com>
References: <cover.1713737786.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 00:23:58 +0200 Antony Antony wrote:
> Hi,
> 
> Inspired by the upcoming IP-TFS patch set, and confusions experienced in
> the past due to lack of direction attribute on SAs, add a new direction
> "dir" attribute. It aims to streamline the SA configuration process and
> enhance the clarity of existing SA attributes.
> 
> This patch set introduces the 'dir' attribute to SA, aka xfrm_state,
> ('in' for input or 'out' for output). Alsp add validations of existing
> direction-specific SA attributes during configuration and in the data
> path lookup.
> 
> This change would not affect any existing use case or way of configuring
> SA. You will notice improvements when the new 'dir' attribute is set.

This breaks the xfrm_policy.sh selftests.
-- 
pw-bot: au

