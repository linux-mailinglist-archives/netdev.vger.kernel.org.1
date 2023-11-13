Return-Path: <netdev+bounces-47477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9208C7EA61A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31476B20A29
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30A73B2B0;
	Mon, 13 Nov 2023 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVm0VlNu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B82D607
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 22:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9939C433C7;
	Mon, 13 Nov 2023 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699915112;
	bh=OP3I7fpOVYpk/z9dNWNGPuMZiLtZS4ZdqSK6+IzmD2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVm0VlNumMuPkfY6BPByX96F51MOtPGk1twkJwdP1Ns2MVOGSc0AINj7/5JlJNvij
	 ZYzLEyCOLONmbcd+eOm1+NRR5C6tRNoXKPsMvtxc7D4tsbx7WrdcVQM1x/AzjUIXxg
	 P3wThId7CL2F4JfFiGcKJe/+mVgXTP29Fk8qFfy8wLtbcGrfEJ6SWLT6uF9iETJp0x
	 qo/zXXGBFia5UQGx/W9xw+yB+elvOMSHFJHUiAf+OnU7B86v6QUWHHcYICccoSRgpQ
	 d8u/48dHQTqbllD0ElOzkBHuqnaUHUPX0yHCqRAyttan0AOqdN2fD6an699vW6AY1Y
	 ADO3uaIcNAL+w==
Date: Mon, 13 Nov 2023 17:38:30 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: <mchan@broadcom.com>
Cc: <alexey.pakhunov@spacex.com>, <vincent.wong2@spacex.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <siva.kallam@broadcom.com>, <prashant@broadcom.com>
Subject: Re: [PATCH v4 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
Message-ID: <20231113173830.4c01d551@kernel.org>
In-Reply-To: <20231113182350.37472-1-alexey.pakhunov@spacex.com>
References: <20231113182350.37472-1-alexey.pakhunov@spacex.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 10:23:49 -0800 alexey.pakhunov@spacex.com wrote:
> This change moves [rt]x_dropped counters to tg3_napi so that they can be
> updated by a single writer, race-free.

Michael, do you have a preference on the using u64_stats_inc() ?
Since we're only doing inc here the conversion should be pretty
trivial. The semantics of local64 are a bit murky but looks like
other drivers think that it's okay to use inc without
u64_stats_update_begin() / end().

