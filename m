Return-Path: <netdev+bounces-17259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DF3750EA4
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DD6281B35
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9873814F73;
	Wed, 12 Jul 2023 16:35:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F091D0E0
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B445FC433C8;
	Wed, 12 Jul 2023 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689179707;
	bh=hjFx1hhmtYF4PSYrXoru+CWA33ekKwil6ULMZ1eDwLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PNvMHgsqBBgFvjf6LA6EjaXIen6JFedwcMxpeeGWVh7+bEkRYuBjWnj/yzuFcLRL7
	 1m4vDSSzaqbdGHjW1OyrWfZsLA43JVuBQlM8zesF5U9AFYkjtt6afZ/WIOZOuJOWpQ
	 ukEwL7pjn64eQZ2PfcwFKaSLdd8+JiSq+Zf0z8j3nWoqZvnU2EK7r6mpDagrC1kNx2
	 vCVJ5obyeXdHlvIPVi+xk+V2B0RO1PFpyv+nJANeaKTPpVVtvozDvohBTC7larsJIh
	 1XzNGrRK5GTx3NNHECndMVqWodcnbq8kO0byLLkfosoJ/QBciLSiGcZ6x+QD7IFFTw
	 99Qgp4qiPhRmw==
Date: Wed, 12 Jul 2023 09:35:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 3/3] eth: bnxt: handle invalid Tx completions
 more gracefully
Message-ID: <20230712093506.6a1f229a@kernel.org>
In-Reply-To: <CACKFLimyipgG41BoGb52HAFbxRdmU2HwfNw-GZr6WZ0c1v2LqQ@mail.gmail.com>
References: <20230710205611.1198878-1-kuba@kernel.org>
	<20230710205611.1198878-4-kuba@kernel.org>
	<CACKFLikGR5qa8+ReLi2krEH9En=5QRv0txEVcM2FE-W6Lc6UuA@mail.gmail.com>
	<CACKFLimD-bKmJ1tGZOLYRjWzEwxkri-Mw7iFme1x2Dr0twdCeg@mail.gmail.com>
	<20230711180937.3c0262a9@kernel.org>
	<CACKFLi=5U_vpBL9tF6wv9WR_ZvuQzQnW+ETKAwUV_eD6xXEgOQ@mail.gmail.com>
	<20230711212421.02a36ab3@kernel.org>
	<CACKFLimyipgG41BoGb52HAFbxRdmU2HwfNw-GZr6WZ0c1v2LqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 21:50:16 -0700 Michael Chan wrote:
> > Are you saying that in ethtool -S in addition to per-ring counts
> > we'd report a "total" which is sum(current per ring) + saved?
> > If so - that makes sense, yup.  
> 
> Yes, for example, we have "rx_resets" which is per ring.  We'll add a
> "rx_total_resets" which is the sum of all current "rx_resets" + the
> saved snapshot.  The per ring "rx_resets" will reset to 0 during each
> reset (including ifdown).  But "rx_total_resets" will be saved across
> reset.
> 
> > You mention reset but the errors counters should survive close() /
> > open() cycles as well.  
> 
> Yes.  It's the same reset whether it is ifdown/ifup or reset.

Makes sense, and sounds good!

