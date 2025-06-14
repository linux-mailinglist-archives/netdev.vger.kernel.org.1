Return-Path: <netdev+bounces-197794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A56AD9E67
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 19:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9098189A041
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1F1DF27F;
	Sat, 14 Jun 2025 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuHkm019"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9D4437C
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749921199; cv=none; b=mTXpenekJrc0wq4hOJEnQrhlteQIGdZH8liBx7MWONMOsZh+fQcb+/d5QCikpe3rQ+G7QXguSk+0MbJzrid2z7RoTsjzj/tJwZaAtUbtpAXEBJdXslfHilYxpFpLI5ILilQB4VHwWylpuOs45W5oGg8OJ8K1Jd2jLod/diuQrqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749921199; c=relaxed/simple;
	bh=3R+vIiq3/7GfnTiHOiDfT++zJfhGwcq6wdsQtMGwvkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIoSj+0vkhSA30fe3jZrXmN13CQb3Gctp1PY1ZsrO6O06arMfmHF6AMbLZC9meKvVVMThKdyBlKuP8OHpdlDOIzbEHEvgz1TYzf0d6vNSHwLH6qlHMTmMIhpOSNKFxNkOLzt10tzCQ2/l6SkunAkGkJIEnaq9tlVvyiinsWr5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuHkm019; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056E4C4CEEB;
	Sat, 14 Jun 2025 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749921198;
	bh=3R+vIiq3/7GfnTiHOiDfT++zJfhGwcq6wdsQtMGwvkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuHkm019d7SbFgjwPxzYvlllcw/KGJTlRKEkMHow/wbKe8TNpCtnFRSNuzOgCelUI
	 jplUnUwc+EyhUzT6gLFLYtqTcwuNHxevca6ONMY8IvrflOuaJrYEobiaJLmlWL3ZDu
	 AcfWitAa9qMrrP8jj8VlN0F87EDi1owBF4INKT2+0yDAWTtNXFgczdBVVAJkbC5akw
	 GeZINeMRu9Y6VNhvLGinbJq2X2FFyEFtjzM0EEQsNCC/ACxolom74fhZ8eTzkxmKiV
	 hkj1raEM4ZlkBvrDnCpu9rbNq9nafIUGwOUfJcPABujQi98Gq1pG+qJCb0ZxrFXXW+
	 PkOmFAtEbfnCQ==
Date: Sat, 14 Jun 2025 18:13:13 +0100
From: Simon Horman <horms@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, donald.hunter@gmail.com,
	petrm@nvidia.com, razor@blackwall.org, daniel@iogearbox.net
Subject: Re: [PATCH net-next 1/2] neighbor: Add NTF_EXT_VALIDATED flag for
 externally validated entries
Message-ID: <20250614171313.GB861417@horms.kernel.org>
References: <20250611141551.462569-1-idosch@nvidia.com>
 <20250611141551.462569-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611141551.462569-2-idosch@nvidia.com>

On Wed, Jun 11, 2025 at 05:15:50PM +0300, Ido Schimmel wrote:

...

> diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
> index b851c36ad25d..27bedfcce537 100644
> --- a/include/uapi/linux/neighbour.h
> +++ b/include/uapi/linux/neighbour.h
> @@ -54,6 +54,7 @@ enum {
>  /* Extended flags under NDA_FLAGS_EXT: */
>  #define NTF_EXT_MANAGED		(1 << 0)
>  #define NTF_EXT_LOCKED		(1 << 1)
> +#define NTF_EXT_EXT_VALIDATED	(1 << 2)
>  
>  /*
>   *	Neighbor Cache Entry States.
> @@ -92,6 +93,10 @@ enum {
>   * bridge in response to a host trying to communicate via a locked bridge port
>   * with MAB enabled. Their purpose is to notify user space that a host requires
>   * authentication.
> + *
> + * NTF_EXT_EXT_VALIDATED flagged neigbor entries were externally validated by a

nit: neighbor or neighbour

> + * user space control plane. The kernel will not remove or invalidate them, but
> + * it can probe them and notify user space when they become reachable.
>   */
>  
>  struct nda_cacheinfo {

...

