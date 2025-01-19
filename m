Return-Path: <netdev+bounces-159585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F148A15FCB
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BE51885921
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27740D2FF;
	Sun, 19 Jan 2025 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWmIR3vg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F576FC3
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737249862; cv=none; b=ZkrzUK10ABPcxB0satSKA4mRRxXuJsMUe265k/6B+tVMTyWQNirz239OgEbofPQm7yIuZG0GXeiVAzNxEK2NVgJu4CDzM5ivFK7bAKDqolgdv7k+o2G0sEB+im6zbd8jauCVibXhG+hRU9z2hS3/vNFA1IfRsP+L6S8aZqHu30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737249862; c=relaxed/simple;
	bh=T8abCAcQ2DajTPiWjTVdRDL6e1WKJmm+B/mnjbzyScE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDXgFDl5O3HZCg5EYOyovm3b0Kemax0aPQ1q8QIyQdmpBcr+JQn34ZaTSOfaUePt8TV3JvqX4+6qooOls6IuLPYQkTWztHE4CJ/19OpUULqD6JEZAqyjWmUCV7P7QZO4gU7jTpBSJhbjjG/pkGihGbne/bOtvJrZaOTTefiFKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWmIR3vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F033C4CED1;
	Sun, 19 Jan 2025 01:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737249861;
	bh=T8abCAcQ2DajTPiWjTVdRDL6e1WKJmm+B/mnjbzyScE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pWmIR3vg61+TJKZu/ddVW6uzstfKpSoO0hbtX+GfaPteq+NVK+wB0KKMrgr2upFQJ
	 LN9QIDLXCuSyPXx2zXjOSOQtUoBw0cRyeTTKBqG4E2JssMe0aPPWWKTVtKzc4XDMUE
	 QRZ8YsH2YErzCTZhdUB+8cS3kNZwve4Y0CaeJtRvi/Y9gVZ9tZ9932osLjwe4mW5kI
	 46EvdIvb3iCB5ncV8rSKWw2AVlxbIn0F4Obe5Fs434x8UjBoYZcUptpnNXue4n6ga8
	 hfQSVfBx8qU4NpffPXGUoJ8oZXXtivacYl4wPfQlkgEOM4j6rNkOjg4x/P/lXqVeMk
	 pRdVurzgdIgVg==
Date: Sat, 18 Jan 2025 17:24:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next v6 3/3] enic: Use the Page Pool API for RX
Message-ID: <20250118172420.48d3a914@kernel.org>
In-Reply-To: <20250117080139.28018-4-johndale@cisco.com>
References: <20250117080139.28018-1-johndale@cisco.com>
	<20250117080139.28018-4-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 00:01:39 -0800 John Daley wrote:
> @@ -1752,6 +1763,11 @@ static int enic_open(struct net_device *netdev)
>  	}
>  
>  	for (i = 0; i < enic->rq_count; i++) {
> +		/* create a page pool for each RQ */
> +		pp_params.napi = &enic->napi[i];
> +		pp_params.queue_idx = i;
> +		enic->rq[i].pool = page_pool_create(&pp_params);

Aren't you missing an error check here?

>  		/* enable rq before updating rq desc */
>  		vnic_rq_enable(&enic->rq[i].vrq);
>  		vnic_rq_fill(&enic->rq[i].vrq, enic_rq_alloc_buf);

-- 
pw-bot: cr

