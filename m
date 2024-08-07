Return-Path: <netdev+bounces-116556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B4994AE43
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95241C21935
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FBB1369AA;
	Wed,  7 Aug 2024 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTp2+Th+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D88136664
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048719; cv=none; b=QRpjuo1Jda12EWGL2VPneW4WdrQf00YE3MW/gSS6WJdY0d84XLrYZKGyrrKRojb8Cy8uQD5Jwa71hDpVJzNJ/spzDNWHRg3hdXSbBavdZ9VfaTA/wikryMwiS367UPXWRlZz8rOD0kzT9R+DkLfyGLPkU8ri6jj7Dp4pyf5Pe78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048719; c=relaxed/simple;
	bh=XL9tvvzgzT3PTJV1uQ++kuLn2MH/Ro8PMibEZ/9sD6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThCgEB4XYsDPZ/R+eXLn5YuLD2Gqq1XGM3h1DWX3Hg76q9zAGKIcztbD1x0FHdGNSFUQVRaC7+/uGk0vdnPRiBvJeAErSv9r7PixZXGi5gbea6MxwDIxvuA4G8R0dLGiZekbFSStKtqYd0pML7ev05/81VJ5mEiMYd+BPGZfec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTp2+Th+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7F0C32781;
	Wed,  7 Aug 2024 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723048718;
	bh=XL9tvvzgzT3PTJV1uQ++kuLn2MH/Ro8PMibEZ/9sD6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nTp2+Th+eKu2DJHqcpOnUsNVDtDflBbx9lWYUudYOR+NXKbgjli8P+FpsWaTtkCnm
	 2KpDWgFJjR37ssF17+WZ4nbAYe1jGAOjTQXGhUe1x6c+C9k823943dh9OIvNqJNwsN
	 7YpSKuYXvCXid4x/aRb2WzNP17MWLPTN4gvVQTpxFAj8wyl6SabzQTx7cAS0uAkaOm
	 uTbCP0XjaTu1ER3r0GwcHc4C0OLcWD9iWCzX5oG0g4ZAu8nFTKAi1ZDclk7gztGd9E
	 ERht4nORwH/l+M8U6jIaqqvnd5+BMDpLlwi5J9Ms2+EfpVvsbt+u308v+HNYCzEU9o
	 2iibrDFinyb6g==
Date: Wed, 7 Aug 2024 09:38:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, alexanderduyck@fb.com
Subject: Re: [PATCH net-next 1/2] eth: fbnic: add basic rtnl stats
Message-ID: <20240807093837.6aaa6566@kernel.org>
In-Reply-To: <ZrOWM_F-BZRJEAAV@LQ3V64L9R2>
References: <20240807022631.1664327-1-kuba@kernel.org>
	<20240807022631.1664327-2-kuba@kernel.org>
	<ZrOWM_F-BZRJEAAV@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 16:43:47 +0100 Joe Damato wrote:
> > +static void fbnic_aggregate_ring_rx_counters(struct fbnic_net *fbn,
> > +					     struct fbnic_ring *rxr)
> > +{
> > +	struct fbnic_queue_stats *stats = &rxr->stats;
> > +
> > +	if (!(rxr->flags & FBNIC_RING_F_STATS))
> > +		return;
> > +  
> 
> Nit: I noticed this check is in both aggregate functions and just
> before where the functions are called below. I'm sure you have
> better folks internally to review this than me, but: maybe the extra
> flags check isn't necessary?
> 
> Could be good if you are trying to be defensive, though.

Perils of upstreaming code that live out of tree for too long :(
These functions will also be called from the path which does runtime
ring changes (prepare/swap) and there the caller has no such check.

I'll drop it, and make a note to bring it back later.
-- 
pw-bot: cr

