Return-Path: <netdev+bounces-37712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1BE7B6B41
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 831471C20860
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1EE31A6E;
	Tue,  3 Oct 2023 14:20:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB42137C
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673EDC433C8;
	Tue,  3 Oct 2023 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696342849;
	bh=kijvf7JbMse2Pa56drfQ4oD20Lx+m2oWU3VtMOZGsPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSgAGnbQfr7tHgoiwKO/rNA1dl/Zxqmh0lmh3HxZxe8HEsShwZy9yRL7Vu7TsUcI7
	 GIwvAnwtlUHJt5YOLVp0kn2Q37A4g1GNVVSqQ1V0URKg0k0GAhFUnTIGw6tTwYe7cJ
	 gUs1GFE3wzu5vyIEhvVrOhKGw0h9FD5DMnDQ3ypJhIXHnab7Cu0T8kAoQFjZ+183/Q
	 Evnlvxy764/PuXtXIS42FdnS8ZjMOJ+WiVXc8Vh/teYch7gYVAMA8JW9wNZl0nbT5E
	 wHSykFeXb8Dd21N/Z2QG7800lXgnH7hHmmxyt6hDpR2cfb7hGPPMmGIJnbvGq98LbM
	 rWlW1ZMrarLvw==
Date: Tue, 3 Oct 2023 16:20:45 +0200
From: Simon Horman <horms@kernel.org>
To: Mahesh Bandewar <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
Message-ID: <ZRwjPegND0V4jF6U@kernel.org>
References: <20231003041701.1745953-1-maheshb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003041701.1745953-1-maheshb@google.com>

On Mon, Oct 02, 2023 at 09:17:01PM -0700, Mahesh Bandewar wrote:
> add support for TS sandwich of the user preferred timebase. The options
> supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONIC),
> and PTP_TS_RAW (CLOCK_MONOTONIC_RAW)
> 
> Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().
> 
> Signed-off-by: Mahesh Bandewar <maheshb@google.com>
> CC: Richard Cochran <richardcochran@gmail.com>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: netdev@vger.kernel.org
> ---
>  include/linux/ptp_clock_kernel.h | 51 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/ptp_clock.h   |  7 +++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
> index 1ef4e0f9bd2a..fd7be98e7bba 100644
> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -102,6 +102,15 @@ struct ptp_system_timestamp {
>   *               reading the lowest bits of the PHC timestamp and the second
>   *               reading immediately follows that.
>   *
> + * @gettimex64any:  Reads the current time from the hardware clock and
> +                 optionally also any of the MONO, MONO_RAW, or SYS clock.

nit: I think a '*' is needed on the line above.

> + *               parameter ts: Holds the PHC timestamp.
> + *               parameter sts: If not NULL, it holds a pair of timestamps from
> + *               the clock of choice. The first reading is made right before
> + *               reading the lowest bits of the PHC timestamp and the second
> + *               reading immediately follows that.
> + *               parameter type: any one of the TS opt from ptp_timestamp_types.
> + *
>   * @getcrosststamp:  Reads the current time from the hardware clock and
>   *                   system clock simultaneously.
>   *                   parameter cts: Contains timestamp (device,system) pair,

...

