Return-Path: <netdev+bounces-222469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E828EB54663
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95D91635BD
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1485226FDBD;
	Fri, 12 Sep 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT3M7BzY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296622F74A
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667800; cv=none; b=uiv5uauPY/m3e7YrL1zHRVSxbELM1+KXROuZAkpYno8+wmvCRwMdfzVo7f97PUd5TEuR5dGRVoEuXipAhoflyeM0BItdsvthO3RxgFNviQS2flr9jWQDd1Xp8or2TUZ6t0NyVqwv1Knn74cb1khoRUy09mRNHiMJ1kwQov9UMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667800; c=relaxed/simple;
	bh=TGBF9kfFXPbq33CGNF0hdn+YkJQ/pyRa6a0HaCpCKD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j68DHDButTzuLiHRuZh5pmUHsrbH4Ae1pRyUO71WPDpNmiLPIzv6vomE25zwZQLS8NlAMdKls6PlEwnMk70DUA3tQUmtceDsV64WNanQZQjnuORd6ok9jA4DfPuLToR/CQIjsBjeTZdlY/pA2lrpNRAfxw/dr9cigdEYX01Y9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT3M7BzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ECAC4CEF1;
	Fri, 12 Sep 2025 09:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757667796;
	bh=TGBF9kfFXPbq33CGNF0hdn+YkJQ/pyRa6a0HaCpCKD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pT3M7BzYqPCV+EbNPePpgMcx6reAU8ASo6Lt4/fESd1haOrCFCfushMbCXfAo/SfL
	 koI2Iq6h3jUor2n/eU44dHRdK+BwQh8ITNYihZf1mlPXDQr0bM3e17XBvyPxviEAJQ
	 2gMpAcZk7UYY3ssrIz9KPhgWwJeWp1KpQpcYRyqcodtlXRnzCRbpORTnb5lLzj5o+G
	 tAcGvCvUheZHfqxQ7zLA5Dr465JuFexZzTTAPQd8x4z8T9J3m48P3IKJU3IKjG3e2v
	 /KVXaH47XPPzfnor4BECTQnkiiz4pjevXXLiG+j6FxXFVLn3qpHmaxXLaDvLiBeX99
	 VMzoVyv0TpqIA==
Date: Fri, 12 Sep 2025 10:03:12 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, mschmidt@redhat.com,
	Dan Nowlin <dan.nowlin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v4 1/5] ice: add flow parsing for GTP and new
 protocol field support
Message-ID: <20250912090312.GV30363@horms.kernel.org>
References: <20250829101809.1022945-1-aleksandr.loktionov@intel.com>
 <20250829101809.1022945-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829101809.1022945-2-aleksandr.loktionov@intel.com>

On Fri, Aug 29, 2025 at 10:18:04AM +0000, Aleksandr Loktionov wrote:
> Introduce new protocol header types and field sizes to support GTPU, GTPC
> tunneling protocols.
> 
>  - Add field size macros for GTP TEID, QFI, and other headers
>  - Extend ice_flow_field_info and enum definitions
>  - Update hash macros for new protocols
>  - Add support for IPv6 prefix matching and fragment headers
> 
> This patch lays the groundwork for enhanced RSS and flow classification
> capabilities.
> 
> Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ting Xu <ting.xu@intel.com>
> Signed-off-by: Ting Xu <ting.xu@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


