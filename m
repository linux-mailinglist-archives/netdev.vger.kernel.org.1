Return-Path: <netdev+bounces-159820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBF3A17053
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F52E1881D17
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578AB1E9B2C;
	Mon, 20 Jan 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuocawU+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE1BE65
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391131; cv=none; b=iW8G7QVlQkkfQWhLAy+bom8He+leBrhQ1OrU2tIZbOToXxHaqc8GBX5VJPuDaDMbeydooKuAVWkRmikRzL43eb33fP34Za4DYVkiORZTZawg9GtEzWVoBn7zgcwD/zr8Bv4cIYQcKOojdNBtJy++LCaPxspF/6mFJz3oyryKLCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391131; c=relaxed/simple;
	bh=c0xlwRDQNm8uVGKxRC9PeZrdMybvdgoujTDDGoxlHM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXNjjK4hYKsBt47iaM0SfP2ARK1l8B77dpa/sI6uU4Vm1QtBl1qXy0HLrmqRiMoTbVBrFwea6o09yidqVV3RctOnX+xUsZ6/Xx647Un3Tvi024W1wDjaM29F9Xx0OEMplF94HWfYWY5NvIneZPDhd22ys81QRXDUwXETsyIu7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuocawU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A9AC4CEDD;
	Mon, 20 Jan 2025 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737391131;
	bh=c0xlwRDQNm8uVGKxRC9PeZrdMybvdgoujTDDGoxlHM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuocawU+BoxAJiHkULhiJo2gO//KfciOKMPcChpM2z6rabZQZkuC4UH5Ey9lqIXu7
	 gRCuOpbp2KSCISCl6BNs4Md3xmmnygvy1mlA/5d6ymBJ9spuhIQTzvKvxRc0Mn2fdF
	 oqVnQxykyq+jT2v30ps1WxI3r6KCqLRLCtZySz9gmZLLez0A2mO87DZhZFvYPtooBP
	 bwg6ul8nNm7JuJrA/eNgIolBmop9BMR68NQzOqCYDzRSF2xRtqosToHP2X8xP2nd51
	 6BC2Qyv4vdtv7BevHw9YcR34UTKbuJvdaKEpDG12bXXiW0Z/qW7pRdaDdZFGc+LlOM
	 mL7PKSA1ZdJWQ==
Date: Mon, 20 Jan 2025 16:38:46 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
	jacob.e.keller@intel.com, xudu@redhat.com, mschmidt@redhat.com,
	jmaxwell@redhat.com, poros@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v3 iwl-net 1/3] ice: put Rx buffers after being done with
 current frame
Message-ID: <20250120163846.GB6206@kernel.org>
References: <20250120155016.556735-1-maciej.fijalkowski@intel.com>
 <20250120155016.556735-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120155016.556735-2-maciej.fijalkowski@intel.com>

On Mon, Jan 20, 2025 at 04:50:14PM +0100, Maciej Fijalkowski wrote:
> Introduce a new helper ice_put_rx_mbuf() that will go through gathered
> frags from current frame and will call ice_put_rx_buf() on them. Current
> logic that was supposed to simplify and optimize the driver where we go
> through a batch of all buffers processed in current NAPI instance turned
> out to be broken for jumbo frames and very heavy load that was coming
> from both multi-thread iperf and nginx/wrk pair between server and
> client. The delay introduced by approach that we are dropping is simply
> too big and we need to take the decision regarding page
> recycling/releasing as quick as we can.
> 
> While at it, address an error path of ice_add_xdp_frag() - we were
> missing buffer putting from day 1 there.
> 
> As a nice side effect we get rid of annoying and repetetive three-liner:

nit: repetitive

...

