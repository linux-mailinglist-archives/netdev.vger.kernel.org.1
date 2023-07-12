Return-Path: <netdev+bounces-17043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60774FE2A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 06:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0902817D3
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 04:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608C520F2;
	Wed, 12 Jul 2023 04:24:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F920EE
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 04:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0A2C433C7;
	Wed, 12 Jul 2023 04:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689135862;
	bh=sApkGTxVppJpeqLRY6wnIYcim0hmFTc9eOUAzv5VBXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B/OIz9bWDCKAf6llHq0XijZV3b2JTwo1EdyITVhEWoKqa5BhJRSOsT4uzvZ32hStf
	 XU7b1L6fKFk/FOZ+vQx4G5OcZoiCsWBsmsUeGMUqrwOE+l+pS433OgUsb8xUGTVldJ
	 kE9ayuKO6wtjSUeHj7Jmbjl0HGaWGxogveL8xzIl2spbFGbIo288DIzxK8kNv7Rfxf
	 nUz4HjtygUWt7KED6xbOMMfgyhd2Sf+1un9MHJAx/7Frip/+ZQcuSMtabDbf8EkK+G
	 iedFzxvc+lMJ9WGYSQwoDCKdxA1sim9ExgCH6ceYarbQdbU0RbGsxGs0TbSZ/Trfxn
	 NECAPOSa1djmA==
Date: Tue, 11 Jul 2023 21:24:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 3/3] eth: bnxt: handle invalid Tx completions
 more gracefully
Message-ID: <20230711212421.02a36ab3@kernel.org>
In-Reply-To: <CACKFLi=5U_vpBL9tF6wv9WR_ZvuQzQnW+ETKAwUV_eD6xXEgOQ@mail.gmail.com>
References: <20230710205611.1198878-1-kuba@kernel.org>
	<20230710205611.1198878-4-kuba@kernel.org>
	<CACKFLikGR5qa8+ReLi2krEH9En=5QRv0txEVcM2FE-W6Lc6UuA@mail.gmail.com>
	<CACKFLimD-bKmJ1tGZOLYRjWzEwxkri-Mw7iFme1x2Dr0twdCeg@mail.gmail.com>
	<20230711180937.3c0262a9@kernel.org>
	<CACKFLi=5U_vpBL9tF6wv9WR_ZvuQzQnW+ETKAwUV_eD6xXEgOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 21:11:02 -0700 Michael Chan wrote:
> These are per ring counters.  During complete reset, we free the ring
> and allocate a new ring.  So re-applying these counters to the new
> ring doesn't make sense because the new ring is not necessarily the
> same as the old one.  So I think we'll need to have a total for each
> of these and we'll save the snapshot of the total before reset and
> restore the snapshot after reset.  Does that make sense?

Not entirely sure what you mean by total. The counters are reported 
in ethool -S per ring and (aggregated) in ip -s -s.

Are you saying that in ethtool -S in addition to per-ring counts
we'd report a "total" which is sum(current per ring) + saved?
If so - that makes sense, yup.

ip -s -s sort of follows so no need discussing.

You mention reset but the errors counters should survive close() /
open() cycles as well.

