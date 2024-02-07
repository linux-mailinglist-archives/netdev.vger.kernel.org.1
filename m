Return-Path: <netdev+bounces-69878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ECE84CE71
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6F8289483
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788E17FBC3;
	Wed,  7 Feb 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3hRE9ns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B45FEE1
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321314; cv=none; b=Y3nnRL+qMhZm8dgQW24v/NRl6utYvK63m/OmMPByJJsAmOXM/PX/d+rrxGBZwqyiv/lpiF4CWAQmwywtr6RMi1zJtmly0diipELOMI0nIdt3F+xOYGeb3j4NZubxwpaTQrX+MOYK+3Qdxvwb0RE++j0vsQA+H7K1U2RYOyrqogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321314; c=relaxed/simple;
	bh=nLbSVH1EdeZ5dT/6SOP41mYl8vLfKMNe7Qap87vrbxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGYPVhui45uLIsN7M5iCTaIq8pNK+rfGvM4MNJWVsH/pMYbqPHVrE9hGPC7lK36zGR7JFEW1mG/LC3cQBDqeZaZioYjcmjkOPyCSRIUQmWkczQ+cJhV3lANxo/dWfj3hGPesbXSoG+yAtu3oPNvspK5r2UibwSwG93Yt0pCMM+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3hRE9ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71736C433F1;
	Wed,  7 Feb 2024 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707321313;
	bh=nLbSVH1EdeZ5dT/6SOP41mYl8vLfKMNe7Qap87vrbxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L3hRE9ns3Fw+0t4QTDGBfiEOyd35VYIJ9mV1BaAA2fxPA4eHjQCvRodM9RYj/Wn1I
	 Jz75Igc1ZZhV1Be/M8Nn9JAB1u6ukigdASMmpo0cW5R8CzRhs03UXkSPIsRIE+MjeF
	 gbKjtVY43V71Az4cHxnJYZgs1zWqNIC1kOQ28Kf6DwCt6+8TaX+m+GxYLPMPp36zCE
	 p0Ezkq4/EA3GEP5Mgsx7lThGVNzSM8U0ksBuHOkRu6eApFMGu1gLKrsM8yks0zibhy
	 qRVcBo41k5vPOCASUk1zlutpM3NMqJ3JjdW3/Xu7APTgb1RyjaYIhSsfYG8edjPy0C
	 5uczLlgoRlgSg==
Date: Wed, 7 Feb 2024 07:55:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v2 net-next] bnxt: convert EEE handling to use linkmode
 bitmaps
Message-ID: <20240207075512.314da513@kernel.org>
In-Reply-To: <a52c2a77-4d0c-48a9-88ea-3ec301212b31@gmail.com>
References: <37792c4f-6ad9-4af0-bb7b-ca9888a7339f@gmail.com>
	<a52c2a77-4d0c-48a9-88ea-3ec301212b31@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 11:43:39 +0100 Heiner Kallweit wrote:
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 +++---
> >  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 65 ++++++++-----------
> >  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.h |  4 +-
> >  3 files changed, 40 insertions(+), 50 deletions(-)
> >   
> This patch has been set to "Not applicable" in patchwork. Why that?

I'm guessing Dave did that because the conversation on v1 was happening
while v2 was already on the list. Repost.

