Return-Path: <netdev+bounces-22053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF01E765C41
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826F72823F5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979A11AA96;
	Thu, 27 Jul 2023 19:42:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3EC17AC1
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32ADC433C7;
	Thu, 27 Jul 2023 19:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690486950;
	bh=lVBGitSBH0UUWzp8t6PVFAintZEkv7EOGgKhc3Mo3Fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mCExJIrYp699CXvOZBndvVmw3D8exNV89IaUv82TzBnRXZNGgNO3hj/4/1CJgA+BQ
	 U1An3IX4GlBBCS63L7o4uPhbowOL/XZhu50Rzhjv0QhTz+Vpf6I9As+WpJgC0vNnfK
	 HYeUbVrgY8FF86TH1XsPwttFWlOYtgtg01FubWLR+9NylNYlLB6ajcf0X6VxKxuSQ6
	 tfyBSb32ZvSwDkWEc/DkQBiy023uFxiu9swSaKdDfpo6iI6XFndAiyjhaeIEIN/IjY
	 md7emi49s/FHmRV+X2GK9kSAY+vkUiPmfVMSevSUbBvNjEwuUPy8fP9gOzqYCfU0PV
	 Ar2380rjsLDKw==
Date: Thu, 27 Jul 2023 12:42:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com
Subject: Re: [PATCH net] bnxt: don't handle XDP in netpoll
Message-ID: <20230727124228.01a9bb0a@kernel.org>
In-Reply-To: <CACKFLikORos5OuSfmrBpayaHx2usz_CR1hryYT3o8ZOvkhfMsg@mail.gmail.com>
References: <20230727170505.1298325-1-kuba@kernel.org>
	<CACKFLikZfjMnK3gwJ=xP8Hb3Bfu8CYa1NMGqHJj7ChcJTWwjmg@mail.gmail.com>
	<20230727120522.392fe60b@kernel.org>
	<CACKFLikORos5OuSfmrBpayaHx2usz_CR1hryYT3o8ZOvkhfMsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 12:29:24 -0700 Michael Chan wrote:
> > Do you prefer adding a return value to tx_int() to tell
> > __bnxt_poll_work_done() whether the work has been done;
> > or to clear tx_pkts in the handler itself rather than
> > the caller?
> 
> It's a bigger problem.  When we transmit packets, we store these
> packet buffers and advance the producer index.  The completion ring
> tells us how many TX packets have completed.  We then walk the TX ring
> for the number of TX packets completed and free the buffers.  If we
> cannot free the buffers now, we have to save this information (the
> consumer index).  We won't get this information again in the
> completion ring.

It's already saved in bnapi->tx_pkts, isn't it?

This makes me wonder if the bug we were seeing with unexpected
completions isn't tx_pkts being stale. Because it's not getting
wiped on reset.

