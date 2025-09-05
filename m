Return-Path: <netdev+bounces-220503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F121B46724
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC1F1B28CF2
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 23:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE828A72F;
	Fri,  5 Sep 2025 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZu7iGUb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053F274FEF;
	Fri,  5 Sep 2025 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114855; cv=none; b=EazxjuvjswbwHeeLgZ95DzVfJDVZFZW7BTXrQ2gTQK2ZEB733B25TeAGOOdXFusq5rXc1MTFLsS6TREUNdNv0/+R9705XbMn47CT8g7Gw9AioVPL1E2gfE4ldnydcWGR6ZbaTDnG+3R6DIW8TvUpv0uCq64eABy8uDpSADbb5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114855; c=relaxed/simple;
	bh=de3DELoqU1QVbo8+sfxRodFFDeMvFlxJwwCtP1Zds8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lfo60j/FDSh2IBBNaFw1veFnp+3v6UBThCjBR9hv2vA+wydCXFLYlBMnv1/oO5SYO7+lD2UpcsKsLK/glp+Slvm6idvxp4NtXWPBC6QI0+GSd3KW68+qESMnehbkftxmX8PunTMRTPumpCFAASmGK0WA04nhdE93QT9ZmbFawOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZu7iGUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAE0C4CEF5;
	Fri,  5 Sep 2025 23:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757114854;
	bh=de3DELoqU1QVbo8+sfxRodFFDeMvFlxJwwCtP1Zds8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jZu7iGUbjLSdHZyzp3pInDGC3R4Kwnky7Uy1DNQOf4ZkgWPvNqYwn89ywpQYshWXu
	 tN7+dSfbV9JEe+/o55WXDHCynPkM5D0WU18fUpvcWpForcWNcoiLMcT30qnxIas7gD
	 pbzS2VFtXV5ziLZgSo8U7s7YSlFI0ZqxPgUsBWcWLUePbbYu5AJUhaYLx2qTnNFlsh
	 nAtRCYshixgXTi1R8cWBP+KORuL9SFOVvGu2VVWnouYcGHqOnR6N8M2/cgYxooJ2jG
	 BidQxkb08GAFmC7wOmWmCKocCwOTG94EE/0zHKFX1htO6YXe7VZFk0RHX3VZEfSkHm
	 EfnRunOOIvgjQ==
Date: Fri, 5 Sep 2025 16:27:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Carolina Jubran <cjubran@nvidia.com>, Kory Maincent
 <kory.maincent@bootlin.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, Kees
 Cook <kees@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net] net: dev_ioctl: take ops lock in hwtstamp lower
 paths
Message-ID: <20250905162733.6e1c33d5@kernel.org>
In-Reply-To: <20250905130716.GC553991@horms.kernel.org>
References: <20250904182806.2329996-1-cjubran@nvidia.com>
	<20250904235155.7b2b3379@kmaincent-XPS-13-7390>
	<154e30fa-9465-4e4e-a1f4-410ef73c04cf@nvidia.com>
	<20250905130716.GC553991@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 14:07:16 +0100 Simon Horman wrote:
> I think it would be nice to note that in the commit message.

+1

