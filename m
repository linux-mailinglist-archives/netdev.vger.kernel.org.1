Return-Path: <netdev+bounces-83031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5CC890740
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF46529C20E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7677251C39;
	Thu, 28 Mar 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD9VuLTx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE73C08E
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647294; cv=none; b=f0C5BwXlxGGp9C3yWw/GRxMXuWU0z491QtSYcqilNcoqcmiQB8rnD0QGlsVxPUUUFVVlIcqgWlFGOkBxLc6FXRHfVt9vdc9Lo0zBSQpepDmVD8WzhqF4egPM2OqNqjuJH9BdfQDUHb77aRzkqYDmg+hIVy8FEL+n5I1Kh1WoYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647294; c=relaxed/simple;
	bh=2KbaQrJ/pqACZSYHyINqiPVX7d7gOj7MJGipN6LUpu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrjCU9ycMIYsp/6YQYTDXWLdn1H7HB8/1eLSs+p5df4/Ewngq20MH6U48drgPgpD4+QfuyIVPgn5wkgxhGylUQBfIXThKlspepDyuZdQ2x5LdYs0EAc5S5iWT+mEIaUz6huGz7GQUAHI4nq7kSR0IldCepfUSvjSiDBmj+PEXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD9VuLTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3077EC43399;
	Thu, 28 Mar 2024 17:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711647293;
	bh=2KbaQrJ/pqACZSYHyINqiPVX7d7gOj7MJGipN6LUpu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PD9VuLTx/9ik/D00uOxp2CMmIqrCC7p2cacKEOSa78QxzbhheYbnri4IQz8AIrcOj
	 7k4Tjo+SDcVPqhzm7PXq0SDXNvXGdE6X1kgfA9cWCm26VWow2g4mSRdD3E+E80rvjK
	 VM1YO8Ww/TR+F7fBFk8EVOHGK4TTbfVJT3CqQH8qvSvqP3v+hDii7q40iuHvqfBOGv
	 aALj5cv1LwvIMR/IwOMKyocRwkc9A0GhivjDVJz6TRlOIP5Myql1VA0py6tCwmcDwh
	 bxdzYMZ+luwoZraokIEXlvSlNNYLgZmG9tHo6JNmmU2SDn5xWGhEvaw2JwtAFpKNkO
	 jo3DgT7amMvng==
Date: Thu, 28 Mar 2024 17:34:50 +0000
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	mschmidt@redhat.com, anthony.l.nguyen@intel.com,
	pawel.chmielewski@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Liang-Min Wang <liang-min.wang@intel.com>
Subject: Re: [PATCH iwl-next v3] ice: Reset VF on Tx MDD event
Message-ID: <20240328173450.GH651713@kernel.org>
References: <20240326164455.735739-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326164455.735739-1-marcin.szycik@linux.intel.com>

On Tue, Mar 26, 2024 at 05:44:55PM +0100, Marcin Szycik wrote:
> In cases when VF sends malformed packets that are classified as malicious,
> sometimes it causes Tx queue to freeze. This frozen queue can be stuck
> for several minutes being unusable. This behavior can be reproduced with
> a faulty userspace app running on VF.
> 
> When Malicious Driver Detection event occurs and the mdd-auto-reset-vf
> private flag is set, perform a graceful VF reset to quickly bring VF back
> to operational state. Add a log message to notify about the cause of
> the reset. Add a helper for this to be reused for both TX and RX events.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Liang-Min Wang <liang-min.wang@intel.com>
> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Hi Marcin,

If I read this correctly then a reset may be performed for several
different conditions - values of different registers - for a VF
as checked in a for loop.

I am wondering if multiple resets could occur for the same VF within
an iteration of the for loop - because more than one of the conditions is
met. And, if so, is this ok?

