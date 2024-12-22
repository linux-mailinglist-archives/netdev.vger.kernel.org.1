Return-Path: <netdev+bounces-153958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB9C9FA4A4
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 09:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F6B37A06FF
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7521607A4;
	Sun, 22 Dec 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yDW9pINl"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20F944E
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734855321; cv=none; b=lfYcD6X+qCowMemSJ7RNz8glNfMCPxf7abC+NDfpxvUagDepH4WwWZhUnGHHQClsEevyN7mkPvKCC+F5wwZfYEzy0+NGXrUVkeC889fXnjrFLvWAHzZKYffgdWt5KiMerhMO+0quVegVh+VXM7jDEzzNdrHMeqt9WAHEduAVaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734855321; c=relaxed/simple;
	bh=C23CMRnpAAEcmfcUDidwWT3Jdt/KwEfPHTsLhTYB65g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kltwmOsy20K/jDUCOcnDP0+MM+zWEk6TuEdP0cABsU0ykk1nCoL/8S63nddJcs6fYJC+ORy01yMqOydapS8KDPLRtQnCb+oqUsERWUL7PEtSJbzFwOwdVfiNzxJNe4rIsd5CIp8eGCM/pxKNccxdu+sR3ww/+7g+VccHs/RMxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yDW9pINl; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DF45C1140182;
	Sun, 22 Dec 2024 03:15:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 22 Dec 2024 03:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734855318; x=1734941718; bh=2ABOyTwxAqtSCONWRtyb4tlH3zfRy1l2f8Z
	vcnVtZCc=; b=yDW9pINlUiKR7kU+jZ3IRILrIfNu4W9u9m22hd3vDNEN7Ykh/vW
	uc+IzU17XDJEepLPJSE1tAoZ/58OZgCMITgh52nzx48+jOUOLYyeFyCLf/Y5Odhu
	ibZL7NiyQwLgYF/13Sq8wZ3Hc5KbmUggTwH2Y2SnGDNVZJyourw4nX9x9RUACt9W
	g2rEzpWCKorUk3VuCCnaAZ6pzJaTYtr7ngMNFiRqoF+YdRmIzZ8bxKaxzHQmVzv1
	DXXaDF9vmmLT/hrNDy/oTIx2Xm3Iv8iExlnsHSPifRkv0s73+D/A1Qmt4FmRmFrp
	5CekPlpZadrR37T7ggPnY6Nzm9qhDVpFyoQ==
X-ME-Sender: <xms:lspnZ3hRPiVdC8boMm45HYeSH__ssTAz0SpfUe1uo7o8eHX9tohJxg>
    <xme:lspnZ0CcUEvecreP0H-1Wo73GMMQVyw1b7tejbxdO5VKYte5n5MA0iVNmrND_hZS9
    3SuBA4ogyEXYus>
X-ME-Received: <xmr:lspnZ3FfFAAYPgLg0yzBvH8jCNFigvVqVUaLotoh3WNfZ-Odecq9_rhJc_fY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtjedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrhgvnhguvggtsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
    pdhrtghpthhtoheprhhoohhprgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghrih
    gughgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepnhgvthguvghvsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomh
X-ME-Proxy: <xmx:lspnZ0SVe5XOsJOqnk1bLc3rbrrsS8yrfzAvQs1Ym_AYWlfXWjIL7w>
    <xmx:lspnZ0xqrXyOHOCckEg3b8PCBIz7nFaeJ1i5NchH1S42efi2BsTRTg>
    <xmx:lspnZ64mTUpj_aw6sPJGvZ0-DddSocyie5smrf7MBDHW6HzQwbsA6A>
    <xmx:lspnZ5xdn_I0wDIlaTVSebKybgKfBbY1PvqSgrNV8wBKqTjU7WLYcA>
    <xmx:lspnZwePcCvWCcUgZkBSAKoGHN-NWGs1qSm-vpEk4StqU3LjgSEzQlMy>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 03:15:17 -0500 (EST)
Date: Sun, 22 Dec 2024 10:15:16 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Radu Rendec <rrendec@redhat.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 2/2] net: bridge: add skb drop reasons to the
 most common drop points
Message-ID: <Z2fKlF_IFfcNZq6P@shredder>
References: <20241219163606.717758-1-rrendec@redhat.com>
 <20241219163606.717758-3-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219163606.717758-3-rrendec@redhat.com>

On Thu, Dec 19, 2024 at 11:36:06AM -0500, Radu Rendec wrote:
> The bridge input code may drop frames for various reasons and at various
> points in the ingress handling logic. Currently kfree_skb() is used
> everywhere, and therefore no drop reason is specified. Add drop reasons
> to the most common drop points.
> 
> Drop reasons are not added exhaustively to the entire bridge code. The
> intention is to incrementally add drop reasons to the rest of the bridge
> code in follow up patches.
> 
> Signed-off-by: Radu Rendec <rrendec@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

