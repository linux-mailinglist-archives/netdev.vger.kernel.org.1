Return-Path: <netdev+bounces-87698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9338A41FC
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 13:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E80281854
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 11:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5B32E646;
	Sun, 14 Apr 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkVRzQfv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6921BF37
	for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713092739; cv=none; b=bx+aUFhwXiEDM+RbO90W1wibfcae4O90fwyLUOAgi1P+8EzCuk3CAnO3s9brrzwjJ5Ulr3l1Eu1UxHuvozxL+JBT55JBMe93eXduP66CR+EjgVc7uuJOSru4a/806xDMqKnrZ2JwdeLmhYO/7n65TBVLZsRgrjHeZDkSLEPRHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713092739; c=relaxed/simple;
	bh=Po+EHAbE5Ggqd+PW5d3iYZvMiyHUsoX7RVKJVW2MmvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6i3cv1HzapStscekxpSplDlR59uxMhncndufow90zdDKBaPR4vIdZWDyXxe3a1gCUuqURtKs1aYNZhhKKRNz5wbZJIwyKdYGZFplWOyCmd39eLXphUD4Cdw4gq6fGM/8EygusVzZXhQI0BaWABgwv7a+zlmxnEGp2xVTU9kBrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkVRzQfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8876DC072AA;
	Sun, 14 Apr 2024 11:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713092739;
	bh=Po+EHAbE5Ggqd+PW5d3iYZvMiyHUsoX7RVKJVW2MmvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkVRzQfvbYCT6b2lHaq8VhOK/aG3b00ROEasYAtKcLVa5UQ8Fgl9KlsM+iEylRj7N
	 ZhOiJbC61t6Agy6bb3IveuHsSLF+PLywSuxgHNyXZwe0EM5yp4h40tG4MBHkPFosgo
	 G+3GdOCS2vF5l7d76cQlYLoj0tU/9StZ/q44bs1lrPUQCwSsEw3fTEODoAwbZ5Bvci
	 c8aSOw9MOfacIIy+pHY2AxKdC0DIeu1EYF0xQNNudKVtPxdBtr/E9zNCqqAth2zo9H
	 mO5FWt5i8S7O416yXM+HWLhlPqxZ0ciB4a+rbr+OONcq+Ls1a8N4wE+sYKNuOkJc17
	 oMcJFco+S9H/A==
Date: Sun, 14 Apr 2024 12:05:34 +0100
From: Simon Horman <horms@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org,
	Paul Wouters <paul@nohats.ca>,
	Antony Antony <antony.antony@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH ipsec-next 1/3] xfrm: Add support for per cpu xfrm state
 handling.
Message-ID: <20240414110534.GD645060@kernel.org>
References: <20240412060553.3483630-1-steffen.klassert@secunet.com>
 <20240412060553.3483630-2-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412060553.3483630-2-steffen.klassert@secunet.com>

On Fri, Apr 12, 2024 at 08:05:51AM +0200, Steffen Klassert wrote:

...

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c

...

> @@ -1115,13 +1120,18 @@ static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
>  							&fl->u.__fl_common))
>  			return;
>  
> +		if (x->pcpu_num != UINT_MAX && x->pcpu_num != pcpu_id)
> +			return;
> +
>  		if (!*best ||
> +		    ((*best)->pcpu_num == UINT_MAX && x->pcpu_num == pcpu_id) ||
>  		    (*best)->km.dying > x->km.dying ||
>  		    ((*best)->km.dying == x->km.dying &&
>  		     (*best)->curlft.add_time < x->curlft.add_time))
>  			*best = x;
>  	} else if (x->km.state == XFRM_STATE_ACQ) {
> -		*acq_in_progress = 1;
> +		if (!*best || (*best && x->pcpu_num == pcpu_id))

Hi Steffen,

a minor nit from my side: I think this can be expressed as follows.

		if (!*best || x->pcpu_num == pcpu_id)

Flagged by Coccinelle

> +			*acq_in_progress = 1;
>  	} else if (x->km.state == XFRM_STATE_ERROR ||
>  		   x->km.state == XFRM_STATE_EXPIRED) {
>  		if ((!x->sel.family ||

...

