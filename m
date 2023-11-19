Return-Path: <netdev+bounces-48986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7B87F0451
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 05:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A639280E4C
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 04:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2129B65F;
	Sun, 19 Nov 2023 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q44IyrjB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050781848
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 04:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB09C433C8;
	Sun, 19 Nov 2023 04:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700369066;
	bh=lX9jmudgE0rvRgwTmcrOlAruOBlzOUgPsTThK5jENvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q44IyrjByKDRhh0GONd6gcTiDIdmWlizpHahTFqY+F/Gk/yYNw6mwxAYr9y/rZD+6
	 uufdkAlIHr2MxO4DiCvHSGjfu7umHss+RKlEy87mxhL4PxPbflujA+QH7o1lKyw2kO
	 N9jVSvRS3AmvqySCqXTZ+tQoV9Zpz3CgjMvlCYKpg8xPdStFmXW5QdWn67WjUi1Mzu
	 WWArUiIMUsn32uwcaSan8DpCWWewRlVu9o6i7yB22yxNFcPdimHoGquq9hZ1JKt4gM
	 uajDFSuJ4QooJUS33BaCRp1sNCcAIj5WxnUq/MlNzns2nXB6sGueJQdPBc42fGhGRT
	 kTvHQhs3nzOkg==
Date: Sat, 18 Nov 2023 20:44:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 vigneshr@ti.com, srk@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: ti: am65-cpsw-nuss: Fix NULL pointer
 dereference at module removal
Message-ID: <20231118204424.21d209a6@kernel.org>
In-Reply-To: <20231116110930.36244-3-rogerq@kernel.org>
References: <20231116110930.36244-1-rogerq@kernel.org>
	<20231116110930.36244-3-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 13:09:30 +0200 Roger Quadros wrote:
> The NULL pointer derefernce error seems to come from the
> list_for_each_entry_safe() helper in free_netdev(). It looks like
> the napi pointers are stale contents but I coudn't figure out why.

Some interplay with am65_cpsw_nuss_free_tx_chns()?
It does:

	memset(tx_chn, 0, sizeof(*tx_chn));

which will wipe the NAPI instance, including its struct list_head.

AFAICT the patch as posted misses free_netdev() on some error paths.
-- 
pw-bot: cr

