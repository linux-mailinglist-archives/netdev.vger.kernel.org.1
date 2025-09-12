Return-Path: <netdev+bounces-222361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E81B53F95
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 03:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E390A16E7CD
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B28168BD;
	Fri, 12 Sep 2025 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvBcPSye"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C38C2D1
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757638899; cv=none; b=hmyNbsY8q42YMGSVxHalPrAA7z2kc5o4j2mRBVEPuwOVxPWbtPEA+y5pe7Tj3KI0IRQArFtY1i57mdPjtJJzvptrph9NjGXHDPSmOF4pKG34Jrl2U/cSRC8/Cyu1IL0GOJvpjhn3Z5yeXaYa9AgMg+xdij5wklKxv4YG7NdT2yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757638899; c=relaxed/simple;
	bh=wMUfVJOH32zY71UIXx5zhhsouFnEIoWrjaBWrAPr5xw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oif+Dija1r9BYDnqUhhs6j2tIf11U1lmfwJq3klJfnHn9czfKot+WhfIa8tAlO1sAEfMp9pDoZNrYDEEpVs72c752T5FTSUU3B7o0Y/ISNhaAi9h4cik+J/JsgycHIsPgX+23b5jwMOHs/RwfdYIkZ2ozp70dPrOKH7i1VKKAJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvBcPSye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA4BC4CEF0;
	Fri, 12 Sep 2025 01:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757638898;
	bh=wMUfVJOH32zY71UIXx5zhhsouFnEIoWrjaBWrAPr5xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lvBcPSye7PzolNnMfRrXZSyrCw1IfO8lbATdNYHxPlukFIrJRL2irQUbLwUlwpIMt
	 9uMmFsSD8qSfHhBNDZtzh/T1mItSd+DrWEIwi0vbKTQ/Ov323lgI8tTTmznrI4TQWs
	 EPnHbSP/TbLLu7koPR7KEV+vKZd1NOxiBghyogyqBfO1ukOLjh+saUqWPciZuqxKrd
	 8Tgiosvg2v3pSwafQVi8tjlgRU1qC+Mt6/jg6SulInbRXb3Xxl92L3nDPJnqWk3KLR
	 Jow2NFG5zLaGPtNZkGSiOlUklTwLCyzITWRLpwE6QD/1RTcrZCFS68Bl7BUir6HRUe
	 ZH9mZuqwgtKNg==
Date: Thu, 11 Sep 2025 18:01:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Mietus <mmietus97@yahoo.com>
Cc: netdev@vger.kernel.org, antonio@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Subject: Re: [PATCH net-next 1/3] net: dst_cache: implement RCU variants for
 dst_cache helpers
Message-ID: <20250911180137.28b076a4@kernel.org>
In-Reply-To: <20250909054333.12572-2-mmietus97@yahoo.com>
References: <20250909054333.12572-1-mmietus97@yahoo.com>
	<20250909054333.12572-2-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Sep 2025 07:43:31 +0200 Marek Mietus wrote:
> +/**
> + *	dst_cache_get_ip4_rcu - perform cache lookup and fetch ipv4 source
> + *	address without taking a reference on the dst

This belongs in the body, summary can be just 

				lookup cache and ipv4 source under RCU

> + *	@dst_cache: the cache
> + *	@saddr: return value for the retrieved source address
> + *
> + *	Must be called with local BH disabled, and within an rcu read side
> + *	critical section
> + */
> +struct rtable *dst_cache_get_ip4_rcu(struct dst_cache *dst_cache, __be32 *saddr);

Return: values needs to be documented these days (kernel-doc -Wall ..).

While at it please remove the old school indent by a tab.
-- 
pw-bot: cr

