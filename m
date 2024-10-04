Return-Path: <netdev+bounces-132160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526A39909A8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0580A1F22099
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE3D1D9A52;
	Fri,  4 Oct 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdgYVM5T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93728DD1;
	Fri,  4 Oct 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060394; cv=none; b=lJ9n2cU/JAoKwFiodm1j/goTfAlCJPYZ7chZBneJN+NT25yNofYkCFOF/fizt2wnVO/x/dG8MB3gK+QPazCBTL+iQ1XDZr4D8Fk5R2r5SpldK5lc+KkK9KSVXbV0eIy1R5QR+DMwVctLHCc6XhZey38iP2ONzUB11SWrmUe7Xb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060394; c=relaxed/simple;
	bh=T3m5jdz2S+xKL18B7DRLszJy20kHNGtH15Uwibzhszs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJVsEOpJMDTL3jbvPD8Q4+MYmdAifb/KEYvJZUh5OtNk5RsrndtI/bGiLiLNIWJmGxdkE2ecbY7XTrrn5Nb7GNUuZm5KOMmgXA82W/HR0zoSEgddWpgrvIncUh+jf5+ZmS+uwm6hnQ5teMVurgTcBml5zVUgEf0QiljL3d2nKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdgYVM5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF570C4CEC6;
	Fri,  4 Oct 2024 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728060391;
	bh=T3m5jdz2S+xKL18B7DRLszJy20kHNGtH15Uwibzhszs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SdgYVM5TJMBnNcjhykW71Ou9Dv2m/ms7aoOVDS/6iNPqUF2UwoCGinrJcsImOOfBu
	 ntgHvo0+p9MxGJjNG7bDyOQFzZoD/rLr3S4xUpRmktGsnjMsKv+kzEiuDBq9MkYeaU
	 bv1BngRYNzCXcHAyluSVAnt6xkHJD4mfNRFFJE+aLPb4RW++tEsJ7FbEvgedpNSvXQ
	 UFQMKc3arGcaZPKlDZHAJsPYMLWGV/diur7bIkZjnqUL4F1laWqZEU7edteL8h6jbr
	 N2x8LVE3EvvuTtFI2dWt6uiGflq5h0SvH8olUmU0wLmZ5ylTrSfRJGBMiNQJlG1eY0
	 nPYLY+XxtWgQA==
Date: Fri, 4 Oct 2024 09:46:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, aleksander.lobakin@intel.com, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
 gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
 razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 07/12] net: vxlan: make vxlan_set_mac()
 return drop reasons
Message-ID: <20241004094630.129b900f@kernel.org>
In-Reply-To: <20241001073225.807419-8-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
	<20241001073225.807419-8-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 15:32:20 +0800 Menglong Dong wrote:
> +	 * @SKB_DROP_REASON_LOCAL_MAC: the source mac address is equal to

capital letters: MAC

> +	 * the mac of the local netdev.

mac -> MAC address

MAC is a layer.

