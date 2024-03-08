Return-Path: <netdev+bounces-78801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08059876946
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 18:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EE52877CA
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D426C25625;
	Fri,  8 Mar 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPdwNSRa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A532560C
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917414; cv=none; b=gWmx+j46a9w1v/aPCgWghCdrxEZAy6aucvxavx8LlhsNNrzeB+pKhp0PV75l9Ot9S0rjmsgFf5+7M66LTkbrV4LlwsNdmdH8qFlJSIpIkw268ByD+4jVhNE3Wapidf2H2+JN0eodYswzKurvNfeHKUhNNrs0z8PNJGGhXVcRFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917414; c=relaxed/simple;
	bh=3gM3MrcI+TojdnOgS1NFhKTpwIkNDeTCg6/QsUuRYHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYdY8BPiUa724mMXnyirhftkK/EzxegE02bD3ClF55KBh+0BUfKujaLs7geHypQkG87KQ4A3ouBfhsifSFuNUlYcvbCvlo4yrtHFsAAcwAwVYPjhdRsHsMBlKJLHpjG/ZQn2M95hRXkHs4vOSD+THULrLO1ARFcjIpifDndM+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPdwNSRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442EFC433F1;
	Fri,  8 Mar 2024 17:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709917414;
	bh=3gM3MrcI+TojdnOgS1NFhKTpwIkNDeTCg6/QsUuRYHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RPdwNSRauwhytduRBgfT02vSK0IY3EX6xd9GpHy/JsGdDBlKScuUdZA3THu0RrKX8
	 r8E6dm+TS2D/Hv+6X12GqP8t0Uhe+4xjmXaMmn7W/WErA2oz822xe2l8eWqmzkxEuZ
	 MNvB7ZDooTkjAp19gySOxMti+sFwCAureSsGIjZ88CRHiJ0sJ1j0v0imu8+M0T488v
	 kbX4hYvmxeEMbKwbp5nNoOu0vAY4IbFFQP8hE6p+I+1s5yurqBku1+r/OigQl2jxp/
	 yOuFQQRg+z0PXEFIXOJBbaexnTe9J+IuYxG5Py4aBbWJYJP6nR7tJl4hWJJEUEcPz1
	 y2jc/N/Tkgm6A==
Date: Fri, 8 Mar 2024 09:03:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David Ahern"
 <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 11/11] selftests: forwarding: Add a test for NH
 group stats
Message-ID: <20240308090333.4d59fc49@kernel.org>
In-Reply-To: <2a424c54062a5f1efd13b9ec5b2b0e29c6af2574.1709901020.git.petrm@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
	<2a424c54062a5f1efd13b9ec5b2b0e29c6af2574.1709901020.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 13:59:55 +0100 Petr Machata wrote:
> Add to lib.sh support for fetching NH stats, and a new library,
> router_mpath_nh_lib.sh, with the common code for testing NH stats.
> Use the latter from router_mpath_nh.sh and router_mpath_nh_res.sh.
> 
> The test works by sending traffic through a NH group, and checking that the
> reported values correspond to what the link that ultimately receives the
> traffic reports having seen.

Are the iproute2 patches still on their way?
I can't find them and the test is getting skipped.

