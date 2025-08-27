Return-Path: <netdev+bounces-217309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA5DB384C9
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA1334E388D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EC2FDC56;
	Wed, 27 Aug 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de/8ANp0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401C2F3C0E
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304392; cv=none; b=EfA+xPMBkZ6J+FEU+u2BSGUzK33NT+ELige1iR2ysk0tw7SWSzBemIcHfxPAnnv5HvcNs4Sti/d0OlKxjzphom/tvP6ohUGcf4vxDsDYCu9SzgYPSwDkJyrgK6RrwqOMrpCMNw9gQ2w1mrD2q8N4oLD2spMsRxcuMhnHdWPZnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304392; c=relaxed/simple;
	bh=7Fjd3YmS5c4fVv5YW2uewpd700LeWpLhFBANrfL+JxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUBQ4vydob2EmXgBUcvJzclTnY1S2n7QKHjI0yHlAksRQ6AXci2u9TLfFeriwHNvdTIYbVXE4596lxCxU2RRHUuSkQD98ztA1Zpvuv00WnOZ4pNsGi5TUOiEukE1UqNz4qEDaVrNleyHr5f2U9Uin4mtrjYikCaUxPvfxbdmLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de/8ANp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDF5C4CEF0;
	Wed, 27 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756304391;
	bh=7Fjd3YmS5c4fVv5YW2uewpd700LeWpLhFBANrfL+JxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=de/8ANp0nKe3x0iZQO1ror8mFuAYVHw7KCtG9bXkJnO4i/xRnCEHMH7j8y47SG4ks
	 AmpbmxfAERWrd3cwKrss7H7Sq2oQAYZj8+4yVfKeaJovuLlt5geMgfz4hlodeYd5r4
	 yEO0fhciCDcIXR6eD10+FQnq2qlH67N8iD0tsFWXrIgRUfWUwFF9IByQLEy/+AqnJS
	 cz8kLr3w7lvR69T3RgGaglpAyyIZHtrk7UQSH/lWlqs36U0yHkF/HLmQtv3d5wqydS
	 CZ0xgfM8Gerrf9IsLzrVWS59/ggC/9/OpA/bdHkBVv0deN4SgO+4z2VjOJYoBFun+f
	 daU8hxfHjtvlw==
Date: Wed, 27 Aug 2025 15:19:46 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, decot@google.com, willemb@google.com,
	joshua.a.hay@intel.com, madhu.chittim@intel.com
Subject: Re: [PATCH iwl-net 1/2] idpf: convert vport state to bitmap
Message-ID: <20250827141946.GC5652@horms.kernel.org>
References: <20250822035248.22969-1-emil.s.tantilov@intel.com>
 <20250822035248.22969-2-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822035248.22969-2-emil.s.tantilov@intel.com>

On Thu, Aug 21, 2025 at 08:52:47PM -0700, Emil Tantilov wrote:
> Convert vport state to a bitmap and remove the DOWN state which is
> redundant in the existing logic. There are no functional changes aside
> from the use of bitwise operations when setting and checking the states.
> Removed the double underscore to be consistent with the naming of other
> bitmaps in the header and renamed current_state to vport_is_up to match
> the meaning of the new variable.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Chittim Madhu <madhu.chittim@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


