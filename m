Return-Path: <netdev+bounces-224221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495AFB82711
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 02:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114CF4641C0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66612B73;
	Thu, 18 Sep 2025 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKgGoUg4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E8F63B9
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156519; cv=none; b=mX+gYe0U9jZ7MsnzG9f2Wd6lO8KTramIAq34ncaiL7r5Xm3xXjnTCAetiXSAgN/wgb51ydRZJvfTbqO/WKBWjhGsxbKlhwPV3aj8QxPVfPHqaPRfYO6ZYcLFsnpUbeUzZ/1wDWuh1jqwGsMnRLv2bDnNqlPYFIwmlScl3NDg0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156519; c=relaxed/simple;
	bh=GD5aoVFqOzRHltwdnVafVh1v4ZGt9FvpsfbbTashgf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtJLlwmsF9Zc+7q1siAFE2KJeDaXHz/9ntcuOt4p/fVCX5G4qISWfg1kUTdKi3UsY3pxDaniGXuBeLQCazi3Bix/vpZa6oPFhn+kXUGGJgxESni3nEvk2dI9tnQugKwA1v3uzwPpwWaPfpHqtmqyzNekUQpfxQV8UpLMPOYcwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKgGoUg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D43C4CEE7;
	Thu, 18 Sep 2025 00:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758156519;
	bh=GD5aoVFqOzRHltwdnVafVh1v4ZGt9FvpsfbbTashgf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PKgGoUg4OjxXuuYlbg7tV9gKw+NBi4cdOEfgRS9h996WZujh/4yKWrRGAHV4M2706
	 ffYksum9eNd0Lizcimn/ryLHmTQo1hg5Qx5vUSZn+Vfos26irVispaqdPk/noRpKZS
	 fkdC2kKp0xnGwm1OjxS+D/r/ExH+YsBMjfkSo4nmDpf56G0iyqS7446kke8SfKgvn1
	 eVF7aB92Uh1hJxdjb1JQsHsH9cKBg/3w8GPTVtNaQ1Oj2I4dI3X5x490P+2jYJzDmQ
	 nQp0FN6NyOAgC4YG08MK6mE1IH/cJOeKPvKAOwTlrH7yagyXIAwCIfmmPHEUAQxyzx
	 mgWVSLw7X6E6g==
Date: Wed, 17 Sep 2025 17:48:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Yael Chemla <ychemla@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v3 4/4] net/mlx5e: Report RS-FEC histogram
 statistics via ethtool
Message-ID: <20250917174837.5ea2d864@kernel.org>
In-Reply-To: <20250916191257.13343-5-vadim.fedorenko@linux.dev>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
	<20250916191257.13343-5-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 19:12:57 +0000 Vadim Fedorenko wrote:
> +	for (int i = 0; i < num_of_bins; i++) {

brackets unnecessary

in the other patch you picked u8 for i, good to be consistent
(int is better)

> +		hist->values[i].bin_value = MLX5_GET64(rs_histogram_cntrs,
> +						       rs_histogram_cntrs,
> +						       hist[i]);

could also be written as:

		hist->values[i].bin_value =
			MLX5_GET64(rs_histogram_cntrs, rs_histogram_cntrs, hist[i]);

