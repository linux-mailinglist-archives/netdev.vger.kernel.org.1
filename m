Return-Path: <netdev+bounces-142935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 566199C0B5A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AFC1F21848
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1764721F4B5;
	Thu,  7 Nov 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smbjUmDQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ED721F4B2
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996096; cv=none; b=X9s5/GakRDZt3BM4yq5BakG1W02VQ8kwh6N0JPE8MdIInsrTnvsbORc/BTrjdvvl4/iZTCO0kVbHiEV3pH4JhLrkWpW7tJtm9pQqyIABGqjWpPpTqy2vQ3V0wh8GOeNHuKpts7l1x6DiaLgaX/mckP0qgNQBmCtq/j/dIpllJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996096; c=relaxed/simple;
	bh=pl8/mt2FE8FgUn1nREFVdbx2iJgnPh1rlWjtjBa0xmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dt/h31vckkXFSysTyHA5KnSEAoInueyuh1PxlQPdGJlCzYO2YAhg1CuzBT/FvY2PPrM82jkuv1gyK6/YkRHsZB6PAugDNwE3VUaMEd8iyWND/oiAdNvXi0Vo2BWtocHk39YaZiSf57mx5xXPtcYVh15KDFrWc6SWsvqfFjvXCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smbjUmDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B5BC4CECC;
	Thu,  7 Nov 2024 16:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730996095;
	bh=pl8/mt2FE8FgUn1nREFVdbx2iJgnPh1rlWjtjBa0xmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=smbjUmDQFfvBH40omfkTCIhvEOu8OSGx/36uuT2Y/zxtgMwi8LB4j2AgtYVxC7cNl
	 CNAnVn7JrkBRin96DoLqzAMd7XWYHpTaHTra4z+0eDKfln+lc6ceGFzKXs1U9iwfrK
	 mc+JL9wYwvNjcFmP3KyScNJa54kTX6v4y6oWlPHna/yWARmWNSnZqiz6YT1zVFD2ax
	 d0BPgxiOgMsE14hh8gDTNWYBcTiz2GBHLG/0yak8SmW/zJvSe9HpZJBCyjsCwPu7LG
	 JbLm2g9v4256JUM0Dk+w96HTRzaIsc4oLxtH6flG+yq3XWaWyfKtDj3L+1aQ7/lZOU
	 jzrzPFrPtzINg==
Date: Thu, 7 Nov 2024 08:14:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, irusskikh@marvell.com
Subject: Re: [PATCH net] net: atlantic: use irq_update_affinity_hint()
Message-ID: <20241107081454.2dbf2724@kernel.org>
In-Reply-To: <20241107120739.415743-1-mheib@redhat.com>
References: <20241107120739.415743-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Nov 2024 14:07:39 +0200 Mohammad Heib wrote:
> Subject: [PATCH net] net: atlantic: use irq_update_affinity_hint()

Hi Mohammad, I see you're sending more off these. For future postings
please make sure you use net-next as subject tag (instead of just net).
We use net as a tag for fixes, and this is not a fix AFAIU.
No need to repost the 3 patches you already posted just for this.

