Return-Path: <netdev+bounces-60177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 434FF81DF83
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 10:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F612816CA
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BCB10A32;
	Mon, 25 Dec 2023 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3PG6Q2/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884BE13AE5
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 09:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2448C433C7;
	Mon, 25 Dec 2023 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703496986;
	bh=T5YjMMovrIer/GCTYaj9RNBTfKwPMQu1VtHaEVx7Wqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3PG6Q2/+aKEOkiQoCMmG929B1hderAbA59IrvC0DETtYVUGh4+AJ+uYiwX3I+U+h
	 mwM+3o3STsP1BympsCy09r4JSbB8UEUNYW/x3IvvgZ+WN9GfRO9FBz+d4gDY0YhlPO
	 x8tjHu0BtbzdgwlC2w3crLkFqUXMOxUO+5jFcYAHj1fIeVe7/2wKhkH0Z/ck025rOV
	 bXl0SeVfpLrRdKLb4FJtmQuRmbVK044/ANH3FKAthVvhmrEqA+PcYe4w4f2VSd9cbq
	 bJ4/topkG6+peTvvo3655cDaa4dNFUUAqAHSrPtNLDovMwczlS4LFFMWGgXP7C8SQ/
	 XFa6qYs9k9rjQ==
Date: Mon, 25 Dec 2023 09:36:22 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH iwl-next v2 15/15] idpf: refactor some missing field
 get/prep conversions
Message-ID: <20231225093622.GF5962@kernel.org>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
 <20231206010114.2259388-16-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206010114.2259388-16-jesse.brandeburg@intel.com>

On Tue, Dec 05, 2023 at 05:01:14PM -0800, Jesse Brandeburg wrote:
> Most of idpf correctly uses FIELD_GET and FIELD_PREP, but a couple spots
> were missed so fix those.
> 
> Automated conversion with coccinelle script and manually fixed up,
> including audits for opportunities to convert to {get,encode,replace}
> bits functions.
> 
> Add conversions to le16_get/encode/replace_bits where appropriate. And
> in one place fix up a cast from a u16 to a u16.
> 
> @prep2@
> constant shift,mask;
> type T;
> expression a;
> @@
> -(((T)(a) << shift) & mask)
> +FIELD_PREP(mask, a)
> 
> @prep@
> constant shift,mask;
> type T;
> expression a;
> @@
> -((T)((a) << shift) & mask)
> +FIELD_PREP(mask, a)
> 
> @get@
> constant shift,mask;
> type T;
> expression a;
> @@
> -((T)((a) & mask) >> shift)
> +FIELD_GET(mask, a)
> 
> and applied via:
> spatch --sp-file field_prep.cocci --in-place --dir \
>  drivers/net/ethernet/intel/
> 
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


