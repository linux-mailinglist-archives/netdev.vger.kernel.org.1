Return-Path: <netdev+bounces-88539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF2A8A79DB
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 02:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2001C20F69
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 00:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4A164C;
	Wed, 17 Apr 2024 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dko3bygC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900B394
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313921; cv=none; b=Tfkp9cyTRKMnU7/fNf3RR4MmnzFCW9crBjR5eaKMXnMngI6cVo8xGSWQ89GY+59Qb2NgdoW/bcglALaiVplOVn5KD290fbxRHPjFpEfdV7RTXXceQSnVYDftOTklSerRf9115swVLa24zLpWaprWuZqpeeOLPYlzA2zTOqhw05g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313921; c=relaxed/simple;
	bh=kiq7aHzuemSUveIKOdQF3d4tZdgVsQOhEiGw1DTYQK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6j7o2KRpreA4s7kNqSu5gXw2khOFZjn8y3xBlsd6DNXLmHa85AwsN68ca8VmFLz8wT6JH4CZ2FF8A2TCDwm8912MNhKqmTzuISjj+oU9Rz45zCjcqQclp0L9broPpvLcI+Ua2VBUCOJOX1Uu3fMgHkAZlX3N5pWFCECVwIKppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dko3bygC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1417C113CE;
	Wed, 17 Apr 2024 00:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713313921;
	bh=kiq7aHzuemSUveIKOdQF3d4tZdgVsQOhEiGw1DTYQK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dko3bygCHx5cfhn0K5hqT2dtfB0FzekW5nLhsRC2ZfGdTN9gO4QOg1P5ZM/vpiAZp
	 JDpwAqt5Rwjhxclrh2bW5UCcI4/m0u/fV/dUTNjtvy8ULdq2QisF0K3skXLEE8pUeE
	 ZAQRm375lfIdhRLY4Yf6s0frOxEQocNP95965p7PzgCgqVs7IlUUCFjDeyteEEWfVL
	 WLPhLRF4NyxDZMKefnX37anAhT/TlBRpltX8vVXPKociW+NxzAvM1sQ/c3f12ev8Bn
	 V6nCkKxb2EiVVFSKrC2kWZmgg3dj8G74IrFy23UhdSET9XjhKPBl6d93c4auab/A9g
	 l43E2nPOD6ghg==
Date: Tue, 16 Apr 2024 17:31:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1 2/2] net: selftest: add test for netdev netlink
 queue-get API
Message-ID: <20240416173159.38a7818e@kernel.org>
In-Reply-To: <20240416051527.1657233-3-dw@davidwei.uk>
References: <20240416051527.1657233-1-dw@davidwei.uk>
	<20240416051527.1657233-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 22:15:27 -0700 David Wei wrote:
> Add a selftest for Netdev Netlink queue-get API. The ground truth is
> determined by sysfs.
> 
> The test works with netdevsim by default or with a real device by
> setting NETIF.

Nice!

> +    def dev_up(self):
> +        ip(f"link set dev {self.dev['ifname']} up")
> +
> +    def dev_down(self):
> +        ip(f"link set dev {self.dev['ifname']} down")

Let's ifup the device as part of env setup instead?

> diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
> new file mode 100755
> index 000000000000..de2820f2759a
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/queues.py
> @@ -0,0 +1,67 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_in, ksft_true, ksft_eq, KsftSkipEx, KsftXfailEx
> +from lib.py import NetdevFamily, NlError
> +from lib.py import NetDrvEnv
> +from lib.py import cmd
> +import glob
> +
> +netnl = NetdevFamily()

Would it be cleaner to pass this as an argument to the tests instead of
using a global?
-- 
pw-bot: cr

