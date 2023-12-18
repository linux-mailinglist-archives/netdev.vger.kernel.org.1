Return-Path: <netdev+bounces-58541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FF5816DA6
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 13:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9461F1F22248
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 12:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2E6200A7;
	Mon, 18 Dec 2023 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBWD3xup"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1546257329
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 12:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0984BC433CB;
	Mon, 18 Dec 2023 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702901343;
	bh=5T8VNG0SXY77I499chQGBaQNatxLNPqrynNliZvOJrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBWD3xupk4+m+SCJsXi49aIaSlqk65+7PrxYDFLV1eYaiB/c7ndk+d2nOgLErI/nz
	 rs7Dkq/jxP/mYct5v+Q3uLgnWomh0nu2fAOGWr/KW2ciBY90/kmiUgngc4V1+C/p12
	 dqd8OUY0k/BLyg2iGcHk9qavrFGODkM1Wkfo1BlgiWjf1G0iEAJAufdeJfrfJYmy2x
	 DEsxM2Ko8LT9Gj+NPUlvS2Z9Fc3KTB8HFLHq4rWQhP26K2SBzjf5O40TX0N1sxIrZb
	 8bq5y+P75jdepzrBMhYteGC9tR0Jyo8axxVCtgfEYh/J+OEhejeAsRKw+/qksg17B/
	 vRMMeYIITHFfA==
Date: Mon, 18 Dec 2023 12:08:58 +0000
From: Simon Horman <horms@kernel.org>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	larysa.zaremba@intel.com, przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com
Subject: Re: [PATCH iwl-net] idpf: avoid compiler introduced padding in
 virtchnl2_rss_key struct
Message-ID: <20231218120858.GC6288@kernel.org>
References: <20231215234807.1094344-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215234807.1094344-1-pavan.kumar.linga@intel.com>

On Fri, Dec 15, 2023 at 03:48:07PM -0800, Pavan Kumar Linga wrote:
> Size of the virtchnl2_rss_key struct should be 7 bytes but the
> compiler introduces a padding byte for the structure alignment.
> This results in idpf sending an additional byte of memory to the device
> control plane than the expected buffer size. As the control plane
> enforces virtchnl message size checks to validate the message,
> set RSS key message fails resulting in the driver load failure.
> 
> Remove implicit compiler padding by using "__packed" structure
> attribute for the virtchnl2_rss_key struct.
> 
> Also there is no need to use __DECLARE_FLEX_ARRAY macro for the
> 'key_flex' struct field. So drop it.
> 
> Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

