Return-Path: <netdev+bounces-106505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB129169E4
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E60F1F2111B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4B61649C6;
	Tue, 25 Jun 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWiYkrq6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE1161B43
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324630; cv=none; b=aooJ0RiL6BH0N1KlncM37o1laYBvKe0u6viEYJd7DuOeV3QMQ119I8mvGws4Hx6ggbnAafTjQQvk0kjtOXb3U+01jUfTd81t3EWiEVEYOy1tbMhAzUgYz281q8le+/I6uUfpBG742HqvsTs5sWej9IgbOqfTitP0DbcVQGFwc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324630; c=relaxed/simple;
	bh=jOfbBg/lCQFbE10cw5jyWPRQD/X2yqi6XFw6Q2CvZqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fG27DDlKw35ufDZNMNq44MmqspBlfR584SE+xr/vgV6ObxhVpT0g7Wz8WN1WmQorGU0SbNjfz1HS8d5H1n6p+aek9bV3MfevebDQ4oy2l2J5mwjHX+JTWJX7uBZ0TDKG2QYQbBENqu/eFzie0fVwR/Jaod5SIWvXRTruVoZc6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWiYkrq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C97AC32781;
	Tue, 25 Jun 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719324629;
	bh=jOfbBg/lCQFbE10cw5jyWPRQD/X2yqi6XFw6Q2CvZqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OWiYkrq6XlalABGQOhgIKVCrYqJ7cTJtnkECoDIPI4co4jHuFiGAaucBXL1ASCn9O
	 eZby17DykwWwUm1WbZxm3CUrWiajvI4/d7jFMpiknYYAwZqckIQ4B4Su/JvmIzatGr
	 b6eJf2BowrphYKxwfqdnEiYvYuc1G9SAbI1OoHBJzLWllbMFzNoFhI5GpELKovfmGk
	 6d9XsRihzJJvQQnjwaeBJd4cWcyAJfhS0ZxhbhHe+pMuqY6fHxwoX59aVAknZnecHx
	 tEpR2eFS1vEBPcgOzSUDpPuFEJPVjTZ2Efl+82KTdXaZ2zuQktX5vgrycUkEt//jlk
	 RaZYogBtPc6Fg==
Date: Tue, 25 Jun 2024 07:10:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, David Howells <dhowells@redhat.com>, Matthew Wilcox
 <willy@infradead.org>
Subject: Re: [PATCH v2] net: allow skb_datagram_iter to be called from any
 context
Message-ID: <20240625071028.2324a9f5@kernel.org>
In-Reply-To: <1c5f5650ba2ffe99b068266ceb6e69f59661563f.camel@redhat.com>
References: <20240623081248.170613-1-sagi@grimberg.me>
	<1c5f5650ba2ffe99b068266ceb6e69f59661563f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 15:27:41 +0200 Paolo Abeni wrote:
> On Sun, 2024-06-23 at 11:12 +0300, Sagi Grimberg wrote:
> > We only use the mapping in a single context, so kmap_local is sufficient
> > and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
> > contain highmem compound pages and we need to map page by page.
> > 
> > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>  
> 
> V1 is already applied to net-next, you need to either send a revert
> first or share an incremental patch (that would be a fix, and will need
> a fixes tag).
> 
> On next revision, please include the target tree in the subj prefix.

I think the bug exists in net (it just requires an arch with HIGHMEM 
to be hit). So send the fix based on net/master and we'll deal with 
the net-next conflict? Or you can send a revert for net-next at the
same time, but I think the fix should target net.

