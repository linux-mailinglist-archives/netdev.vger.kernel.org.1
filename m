Return-Path: <netdev+bounces-75533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B45AB86A69E
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284B0B20CF5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 02:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D661AAC9;
	Wed, 28 Feb 2024 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai6GEFp1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC01C2AD
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709087757; cv=none; b=JvNyS7OryiyQVUiZ7MtPkQBloO86LBh4AkQPYLQPACDFrKDuVvFMo3qg4wfYiCW6WjyxtJx/xMI+m5TZxgazPg+hxSWq2fKL3P56G+6r1kHVa0Cx1xh8oSGEutgjI92DFxpICstfv9ZvHFUCHPp5fURewLaNQtZvccVuVrB2aBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709087757; c=relaxed/simple;
	bh=55xwUWFspAVlGcKw+GAnaKAavDfKol9w4CrzXxRxf4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AE6DF5TOdJ/A8v50/u1SxCp/ScwHQJAbK0KW6ne4JJUhEDlHEupYsyPSOoG3IUoc/4oaTFzZr3Zvak1oN9orGIFkfXXHa7PD5uLjqAZvLw1Sa+icGiOKX5v1k3Ta41cRYkQkR6GjBatcJ3PlJIVYXAdSbFGPWfLuM2S3gG3hlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai6GEFp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0213CC433F1;
	Wed, 28 Feb 2024 02:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709087756;
	bh=55xwUWFspAVlGcKw+GAnaKAavDfKol9w4CrzXxRxf4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ai6GEFp1xYU8vcxMOLc319xHH1ub41Nj1RMCJG1hTYBZo9NLTjM/4/jBAiRiQ0NGz
	 HhzG3AMcl694LkiaRMFxs0n0aBYyrUk3Ojo29w0PoECD+lQRfMeu7ZDiLEvnHyqD3C
	 5K3R1a64PKoeRwoRoBAE4NupRQ26mu+xJWSOWwY7WxHvJf329rGlvHgQ1I73iWI5o9
	 v5MjPu+uKdFdECjDhNKfjkABzH92O4P0B4MWfm8t0L5sbql2q+zE/L7pT06y3HYSkk
	 pNOLG5aVnc9uYlAsRN0pmPamcsPPXXS1j5EjSYRvUq+u1+13jL6dOjvCw3//BuhjZ3
	 ZVDPf0tAcGj4w==
Date: Tue, 27 Feb 2024 18:35:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Richard Cochran <richardcochran@gmail.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Karol Kolacinski
 <karol.kolacinski@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] ice: add ice_adapter for shared data
 across PFs on the same NIC
Message-ID: <20240227183555.01123eb7@kernel.org>
In-Reply-To: <20240226151125.45391-2-mschmidt@redhat.com>
References: <20240226151125.45391-1-mschmidt@redhat.com>
	<20240226151125.45391-2-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 16:11:23 +0100 Michal Schmidt wrote:
> There is a need for synchronization between ice PFs on the same physical
> adapter.
> 
> Add a "struct ice_adapter" for holding data shared between PFs of the
> same multifunction PCI device. The struct is refcounted - each ice_pf
> holds a reference to it.
> 
> Its first use will be for PTP. I expect it will be useful also to
> improve the ugliness that is ice_prot_id_tbl.

ice doesn't support any multi-host devices?

