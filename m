Return-Path: <netdev+bounces-85961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CF589D088
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 04:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A78282191
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C015464A;
	Tue,  9 Apr 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SshGmZ0G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6663EA64
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712631337; cv=none; b=VD9ohhtuuMf7Ek1KG4QHLb1wn5MEOF/ryr7MtndOpquGzecd29fajSAEkgu76or2KLbB21aYlOX+/VrsNfN8lVZH3Z7YTukDU64fVFNn90KoTAD3Ja+MHImZb+rWyKLqzsWceeprjJXYx6gWcOVSOHGiZWj6ut/HhLP89vBxyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712631337; c=relaxed/simple;
	bh=Ctcr/60VcVhr29zkSiqQyVDLjs/s87r4vMKk0oUC7I4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBZ3rw+pPZ+SpRf7L9yGjq4vW55G6yYx5ovS7IiUuzTE+npCrC/FoCg9mtpk5h0zyUupHBUlrX/t5ecg2T76csxvdr/6nDi/hUyKk13z02E44Jh1VhUiWFjC1ZbMFvtqd+0yLPZ2cTeNFqThsvQ9+Fo0Q0ehjnAxueCr6hIKo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SshGmZ0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F80C433C7;
	Tue,  9 Apr 2024 02:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712631336;
	bh=Ctcr/60VcVhr29zkSiqQyVDLjs/s87r4vMKk0oUC7I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SshGmZ0Gdm2fXSfZD6RRDtxtILCkvRi8A+RCj2O2FspP5rcIG/mzVPakkc0uBX0CK
	 q+LnKPMFIFxBaT7y5/4PSa4qpD87gA9dXaOJRvEsq5LkvvUEMDqIcM3lbCp4ZKPQBR
	 CyqnyvysYd53eywYzDB84bhNnJMO+H+8bu4Wvqojxjx71w2YCHOAEBHlsuKjMaTsyf
	 jqoy6V2CZgowIYzLUmbcCgeKi2yMhmQ6H9igtzw95vakUQqNC0V6w+IUQww/v3Rzz3
	 QGYqv21JvLlA4GlJ7n76gvRAjQSmg8CgXKXv6ovtFmnc5Jt5FBJffd1JyWeORognK7
	 7gogzJpVhetCA==
Date: Mon, 8 Apr 2024 19:55:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Fei Qin <fei.qin@corigine.com>,
 netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v4 3/4] dim: introduce a specific dim profile
 for better latency
Message-ID: <20240408195535.0c3a6f1d@kernel.org>
In-Reply-To: <20240405081547.20676-4-louis.peens@corigine.com>
References: <20240405081547.20676-1-louis.peens@corigine.com>
	<20240405081547.20676-4-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Apr 2024 10:15:46 +0200 Louis Peens wrote:
> From: Fei Qin <fei.qin@corigine.com>
> 
> The current profile is not well-adaptive to NFP NICs in
> terms of latency, so introduce a specific profile for better
> latency.

Let's drop the dim patches for now, please.
Adding random profiles to shared code doesn't look great and Heng Qi 
is re-working DIM to make it more configurable:
https://lore.kernel.org/all/1712547870-112976-2-git-send-email-hengqi@linux.alibaba.com/

