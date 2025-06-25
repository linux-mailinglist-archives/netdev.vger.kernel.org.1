Return-Path: <netdev+bounces-200895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0502BAE741C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FF93BED76
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 01:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AF086329;
	Wed, 25 Jun 2025 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuzWpcxR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236C347B4
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813811; cv=none; b=MuEcLEnXayEQUN5ghhhWQXhTtRxHMN9ku3OHtObAHEvfZibSUW/bxOsJesI3rblz8bnbam9TRhvwKL6sz5ufSA6mN2c9X45QKv4ouGZW8FmeNN8soLw31oE5nsnKAWqjOr+w6fAG228kXi0yP9dURP+6TGGp7hH8iWLfh32Y/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813811; c=relaxed/simple;
	bh=5B+IVHIG46OlH2GnqyojySKTttI8ZUSaHT3u+E1BQow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaCGu01HPXzgbpI51QM0fP1+DrW5BMcXlh+4lR4/yrXTTkNad/PpXHM0USw0w5TnD9cqclZjxDTmKiwIO+jgV6MSqyEVmlc7pgd2wn8085U5GCfkGz/qCq0sjXqRa3Uxs8iYFm6riCt5YJz5c34YWtsQjCURRoXkKy2uVTd0ILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuzWpcxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F9FC4CEE3;
	Wed, 25 Jun 2025 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750813810;
	bh=5B+IVHIG46OlH2GnqyojySKTttI8ZUSaHT3u+E1BQow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MuzWpcxR4ZTP+igjgUCsm/4Sb2jIHOduEjgq13gEKOn3ukGgV6U71cfRbgVBcbxdT
	 AI0uq31aX7Qkegjo9a7EqCQuglvJe25JAM/2pJLrFTT5QVfsLvk0m5Xvek8vgcmigH
	 jcoQGUnC00PH/UbTZ3yob5pa74iLj+6gPBnrVynEWk6ktZw4Lfjncib3bU0ZPJvmca
	 2CTaZO7ShU6YOfp+kn0Eg0pUFaLmGQ9Aw0A7hrDFHSqUnpy4TfeMKvTvCG8c8bfwOy
	 ltpWZjkGYrrG4I1xkW3SUC9d1Ooff23buu01dwNzGPSZHI1WnxxqVb0OO4Wvf37PMb
	 /T3OyF1KgIGVQ==
Date: Tue, 24 Jun 2025 18:10:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9] Add support to set NAPI threaded for
 individual NAPI
Message-ID: <20250624181009.755abb07@kernel.org>
In-Reply-To: <20250623175316.2034885-1-skhawaja@google.com>
References: <20250623175316.2034885-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 17:53:16 +0000 Samiullah Khawaja wrote:
> +/**
> + * napi_set_threaded - set NAPI threaded state
> + * @n: napi_struct to set the threaded state on
> + * @threaded: whether this NAPI does threaded polling
> + *
> + * Return: 0 on success and negative errno on failure.
> + */
> +int napi_set_threaded(struct napi_struct *napi, bool threaded)

Ah, missed that this kdoc is wrong s/n/napi/

For the record:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=e5880f95a97928308845dc97fdd239605e06e501
-- 
pw-bot: cr

