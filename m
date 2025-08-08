Return-Path: <netdev+bounces-212290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460CB1EF4E
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 22:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6389B5A2662
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B0921CC58;
	Fri,  8 Aug 2025 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2BhD5Md"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9A1F2BBB
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684123; cv=none; b=YqnwkVL/sWpBuE1mzvqgSIZ9sOLwH3aLRZdtf0JnLOOC5maiV7FlFGmUJk7aQdSuR8cFDJ1BBrRaYFHz+s8uK9JWXHcB4CZi8jIaoVsUItJWjRRUtp2r+zBbNBTgQBMt8B6SrkCLCSS55Tz6t9QS4EgzfJ/sIvix89oXjuS1w1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684123; c=relaxed/simple;
	bh=b0vC1D2LWBsSz1Gq4TjUw1tPlccN4Nq4ISgtAe4DlFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgQSvct2u511vaLiKRQrbD+TGlhDQuy/TzIDlgU4NSMBeGaZdv3zQ1QptJqM5z2SGstgUd+7n/vuvmSgBY8SxU6xgjQ+Bdb2gQk9CXQXLSjm5wEyWC1cqP9iJhVoFWDxDAJ2T8xnouyZTEkNOAQtznGHAcZOIQAJZ5S/dZrSUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2BhD5Md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271DDC4CEED;
	Fri,  8 Aug 2025 20:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754684123;
	bh=b0vC1D2LWBsSz1Gq4TjUw1tPlccN4Nq4ISgtAe4DlFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V2BhD5Md2HU5mz0K7D853WNotiUvhi4qNx/WfKoz7Y5NwhYelP2gk39VIr8kuDM4+
	 Rw8Eb5/ivEHBa5xvNzjoRoC+TIQRNMvQW9BJP547vcqR6e8mI1HPP/0k6IQbSt9La7
	 G8gXFsyfdBzVxa1zIUeBpkfG0SVQy6vHnopM1rGCaPdCkhpCM7S2ybaVXmV6cPDFXY
	 esotkpwVHTBY1TW36nZRWQB5OHg8t7/4lvoNaep6ZH9rQ0VGFcN38jVP+o72B2YWy7
	 sYBur4K3cGnxp42uHV0AS0S8QF2vVvIAGyZ+jvCO1PCOs5t9AOM30ZTl0mrIBvMJ6L
	 LaCvwiy3R1fNQ==
Date: Fri, 8 Aug 2025 13:15:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, <intel-wired-lan@lists.osuosl.org>, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 <netdev@vger.kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH v4] ethtool: add FEC bins histogramm report
Message-ID: <20250808131522.0dc26de4@kernel.org>
In-Reply-To: <20250807155924.2272507-1-vadfed@meta.com>
References: <20250807155924.2272507-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Aug 2025 08:59:24 -0700 Vadim Fedorenko wrote:
> +		/* add FEC bins information */
> +		len += (nla_total_size(0) +  /* _A_FEC_HIST */
> +			nla_total_size(4) +  /* _A_FEC_HIST_BIN_LOW */
> +			nla_total_size(4) +  /* _A_FEC_HIST_BIN_HI */
> +			/* _A_FEC_HIST_BIN_VAL + per-lane values */
> +			nla_total_size_64bit(sizeof(u64) *
> +					     (1 + ETHTOOL_MAX_LANES))) *

That's the calculation for basic stats because they are reported as a
raw array. Each nla_put() should correspond to a nla_total_size().
This patch nla_put()s things individually.

> +			ETHTOOL_FEC_HIST_MAX;
> +	}
>  
>  	return len;
>  }
>  
> +static int fec_put_hist(struct sk_buff *skb, const struct ethtool_fec_hist *hist)
> +{
> +	const struct ethtool_fec_hist_range *ranges = hist->ranges;
> +	const struct ethtool_fec_hist_value *values = hist->values;
> +	struct nlattr *nest;
> +	int i, j;
> +
> +	if (!ranges)
> +		return 0;
> +
> +	for (i = 0; i < ETHTOOL_FEC_HIST_MAX; i++) {
> +		if (i && !ranges[i].low && !ranges[i].high)
> +			break;
> +
> +		if (WARN_ON_ONCE(values[i].bin_value == ETHTOOL_STAT_NOT_SET))
> +			break;
> +
> +		nest = nla_nest_start(skb, ETHTOOL_A_FEC_STAT_HIST);
> +		if (!nest)
> +			return -EMSGSIZE;
> +
> +		if (nla_put_u32(skb, ETHTOOL_A_FEC_HIST_BIN_LOW,
> +				ranges[i].low) ||
> +		    nla_put_u32(skb, ETHTOOL_A_FEC_HIST_BIN_HIGH,
> +				ranges[i].high) ||
> +		    nla_put_uint(skb, ETHTOOL_A_FEC_HIST_BIN_VAL,
> +				 values[i].bin_value))
> +			goto err_cancel_hist;
> +		for (j = 0; j < ETHTOOL_MAX_LANES; j++) {
> +			if (values[i].bin_value_per_lane[j] == ETHTOOL_STAT_NOT_SET)
> +				break;
> +			nla_put_uint(skb, ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE,
> +				     values[i].bin_value_per_lane[j]);

TBH I'm a bit unsure if this is really worth breaking out into
individual nla_puts(). We generally recommend that, but here it's
an array of simple ints.. maybe we're better of with a binary / C
array of u64. Like the existing FEC stats but without also folding
the total value into index 0.

