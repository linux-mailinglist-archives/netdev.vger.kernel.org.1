Return-Path: <netdev+bounces-77957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138388739E5
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AD628A5D0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8A41350CA;
	Wed,  6 Mar 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXZc1qat"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA8A134CC0
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736965; cv=none; b=cc81J2EpBGs1scravmCEVPp9aDbA2WsXdoSYV9cz3ekQvjJmrR3zxjIzl60VF/N5dX6u0avHpTFyMfX6PnGN+pqL+SxMp0Nzxv0eLevIbhJsjO+KBKksveKV74KM0XYXDelP8dZT0mwI8yC5eNECyGv2cBBUn3BO3ArcR7PRs1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736965; c=relaxed/simple;
	bh=RdTiIkDMrFW65Zg7/Xw8wZlLn0Iy+Mcc6gyfOoJsdto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amZmnOj6leRaLCAYU+0l6hza+S/EBEBEBUEBq3FHq64LSbtUek6T6lDy4sab3XjyzYSYNtNv0Uv9KsamR11G/fMECb/FQW4M8iqq9NYepkujU69D9cPUlMVZCwa5PPBMJ4jLKFEnCg0DPOTphD7nzpjEMUqhuF2zUtfq1icLDrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXZc1qat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6DEC433C7;
	Wed,  6 Mar 2024 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709736964;
	bh=RdTiIkDMrFW65Zg7/Xw8wZlLn0Iy+Mcc6gyfOoJsdto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mXZc1qat7ORQfUYsZ12L3in45CtB/qjuyD4Jz9Z6g8jrKcDVj4H4eOnjgTYPRFctA
	 0qokqha4laeREfzoLdz62m2LseXQXBM5eXJw/3piEXqSBj+9dut0Ej7eoO2RI8NW0Z
	 9P+9knf20/j00kXLc3+ax7zsOAdRk+89TR9sGJ7KSEr6T3kGuUkLexkvCWKXejN8lE
	 i0FqVmmgOJ3ZSqGyej2NVoQHVYjQHFJOSzQyWaAH/7bZwysg5J/fDPfoyASi1w1C/8
	 bYA3kX7DDTKhQjGFjyCI1LtrWif5TcSL1LX7XogXjh/4gYTWilz5ILa5HaFXr4CFLG
	 jwmyNOuuly0+g==
Date: Wed, 6 Mar 2024 06:56:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, amritha.nambiar@intel.com, danielj@nvidia.com,
 mst@redhat.com, sdf@google.com, vadim.fedorenko@linux.dev,
 przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next v2 3/3] eth: bnxt: support per-queue statistics
Message-ID: <20240306065602.791c298f@kernel.org>
In-Reply-To: <CACKFLin4dUL9eOrH_=sZpc26ep5iZe5mgOHAxyWEAHwVWuASTQ@mail.gmail.com>
References: <20240229010221.2408413-1-kuba@kernel.org>
	<20240229010221.2408413-4-kuba@kernel.org>
	<CACKFLin4dUL9eOrH_=sZpc26ep5iZe5mgOHAxyWEAHwVWuASTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 19:40:01 -0800 Michael Chan wrote:
> > +static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
> > +                                   struct netdev_queue_stats_tx *stats)
> > +{
> > +       struct bnxt *bp = netdev_priv(dev);
> > +       u64 *sw;
> > +
> > +       sw = bp->bnapi[i]->cp_ring.stats.sw_stats;  
> 
> Sorry I missed this earlier.  When we are in XDP mode, the first set
> of TX rings is generally hidden from the user.  The standard TX rings
> don't start from index 0.  They start from bp->tx_nr_rings_xdp.
> Should we adjust for that?

Hi Michael! Sorry for the delay, I was waiting for some related netlink
bits to get merged to simplify the core parts.

Not sure what the most idiomatic way would be to translate the indexes.

Do you prefer:

	bnapi = &bp->tx_ring[bp->tx_ring_map[i]].bnapi;
	sw = bnapi->cp_ring.stats.sw_stats;

or simply:

	sw = bp->bnapi[i - bp->tx_nr_rings_xdp]->cp_ring.stats.sw_stats;

or something else?

