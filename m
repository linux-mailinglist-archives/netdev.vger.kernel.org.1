Return-Path: <netdev+bounces-225746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23D1B97E71
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959E84C094A
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67117A303;
	Wed, 24 Sep 2025 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbJppIum"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7919067C
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674080; cv=none; b=KN7ELqMuAc+IVSVCYUqsBykg4eJjMXzqii71+qQTsWeXkFgpPDABJsKFx9Up6kNHNhANMb1HxlNR+7l9fkdQEivkC3DD9pdvA5cNRwaJWVD4r5z2dMP7VMd0Xyre7zOjjv6IuNDNwycGNtj+jj/wNGG2m3/Wbtgnu+rTAKO5/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674080; c=relaxed/simple;
	bh=MUlCGvOcXs2ZvAxkuV33/94+CLAsgJdQJHeAek6wyO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8oz6Q4D5Ip8Z9yhjt8uJH7AX7YzDvPhgsecS/l+XNCEjUzS7dd+FBVIYEzTU7/qgDDpEz1gSFx3CXX7fbkBmiRrupw1EL/ya80iMvJdrF+M85fpvNQqhvlceevFbh8vTzT8AQ/+mvY176np3XW2fDeOdHoNQUKmQFo1ajUH9ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbJppIum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878D3C4CEF5;
	Wed, 24 Sep 2025 00:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758674080;
	bh=MUlCGvOcXs2ZvAxkuV33/94+CLAsgJdQJHeAek6wyO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NbJppIum9AUbc9jfG7SSRc5VapzWaebxLtM4yWjg9XGlT2hys+zV8WlkQEk1bZFvr
	 tdESol+ad08A+JZzUJ3iAYmDgn2ZSGy5i5nIhzVt90OdIwhtZtrqPsPjhRKhm6KSdS
	 cHtlt+6F1QI6vwasX10wdn+t8cuyP3/tanSI1w5e3LnxLPl1oq2tELCUXK+nE24r5O
	 f+DV/tiPt48PkoRr9QduPlMERlWxnFfExHWqlIAn0wMighVMtdrh6XyRmtSHmvjU+x
	 972NKGCYPSE5ZBMngNw199xJFj1lBa14dxh5A1vGBGnnTHGJIWzux5vSxUHSifyAJI
	 9hb534oVsNdEQ==
Date: Tue, 23 Sep 2025 17:34:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Yael Chemla <ychemla@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v5 3/5] net/mlx5e: Add logic to read RS-FEC
 histogram bin ranges from PPHCR
Message-ID: <20250923173438.70295e44@kernel.org>
In-Reply-To: <20250922100741.2167024-4-vadim.fedorenko@linux.dev>
References: <20250922100741.2167024-1-vadim.fedorenko@linux.dev>
	<20250922100741.2167024-4-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 10:07:39 +0000 Vadim Fedorenko wrote:
> +#define MLX5E_FEC_RS_HIST_MAX 16

I'm guessing you insist on the checks because 
struct mlx5_ifc_rs_histogram_cntrs_bits hardcodes the size of the hist array as 16.
Please make this define use ARRAY_SIZE() or some such, instead of this
random looking number.

