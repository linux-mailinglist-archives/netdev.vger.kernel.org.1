Return-Path: <netdev+bounces-68578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44D184746F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886A51F2F187
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7D145B13;
	Fri,  2 Feb 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT10U7PS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0755114198F
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890513; cv=none; b=gWuE867WP7gR8a6aHcQiC8sOZNtTteBI2cyvLIPWmTFt+Fo1SJ4Oyi4CNb6eGqIuahy8rqjdi+K5p7KZTzw34zvvpxFyFcyzpVJQ+WAeXVOgAe9iR8tWYv2h2DWMiHN3xc4vtU+SjElWGbpRyV02JPuLCMkpEwcqTtPv0oPjvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890513; c=relaxed/simple;
	bh=bXhDZcD0YYOvVaCv5v5BI2OisTBd/lQs5mOu6uLdWRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDUsutQ1FxPaAokxatlOLqWf1Bz68VY/1QgS0iaYzN3GxzUb0tbZyRAMUGhCOovekn1vV6LdtTQOxtisJUl5GmJ2eYP9u/mchtR7ScRl0QvxQePX/ADW56Dk+GQsUFPVLAvG0fXSTWZakhHoJb0TSfrA4RPwGB9e68ZFw+dxgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT10U7PS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2F6C433C7;
	Fri,  2 Feb 2024 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706890512;
	bh=bXhDZcD0YYOvVaCv5v5BI2OisTBd/lQs5mOu6uLdWRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jT10U7PSiKq+sZ72cwPOLQe7cEU4dWH2m8i+KvkNhTBQuqgG6hdrd117Fdci5tuQX
	 jn2umvYUQiVCt3xtre6pNdmhe2Tt/pwnHd7z6hGF7aL5eb4hWgfDao57QDyc1Al+S8
	 R8E0za4ea0Lfj9SitBwU+K796XIH8Mk0kgSiZvj41YAvw8GAkp8rs1drCDTi9weiql
	 2DdwNUwc9xXixa4kZ28bd4lcR55iDythiD/igXx+4CivSeyEcwKshR2oeA6H55ieaM
	 /yMcTQMgSc1luLRQA7D8qKoQqPSLYUE5Myzs3R5MtheY80fNqnDDStOpFM+h4hbd61
	 u/MpwH46edxiA==
Date: Fri, 2 Feb 2024 08:15:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Realtek linux nic maintainers
 <nic_swsd@realtek.com>, David Miller <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RESUBMIT net-next] r8169: simplify EEE handling
Message-ID: <20240202081511.3d4374f4@kernel.org>
In-Reply-To: <7122d90b-cdfe-4733-bfad-45ce63f75536@gmail.com>
References: <27c336a8-ea47-483d-815b-02c45ae41da2@gmail.com>
	<d5d18109-e882-43cd-b0e5-a91ffffa7fed@lunn.ch>
	<be436811-af21-4c8e-9298-69706e6895df@gmail.com>
	<219c3309-e676-48e0-9a24-e03332b7b7b4@lunn.ch>
	<7122d90b-cdfe-4733-bfad-45ce63f75536@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 17:06:10 +0100 Heiner Kallweit wrote:
> >> Alternative would be to change phy_advertise_supported(), but this may
> >> impact systems with PHY's with EEE flaws.  
> > 
> > If i remember correctly, there was some worry enabling EEE by default
> > could upset some low latency use cases, PTP accuracy etc. So lets
> > leave it as it is. Maybe a helper would be useful
> > phy_advertise_eee_all() with a comment about why it could be used.
> >   
> Yes, I think that's the way to go.
> To minimize efforts I'd like to keep this patch here as it is, then I'll
> add the helper and change this place in r8169 to use the new helper.

Sorry for being slow - on top or as v2? :)

