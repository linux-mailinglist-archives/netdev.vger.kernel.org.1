Return-Path: <netdev+bounces-224116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F34B80F49
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68870321679
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9682F8BFA;
	Wed, 17 Sep 2025 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1DFMw3x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227231DB122;
	Wed, 17 Sep 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125591; cv=none; b=OIlafAJIzNlJFjTBGmW9T08I3LKrMDXLxsYk0uXBd2+lQuDrf6+cMXkR/r5eEejGh0nL+29+SGc1AM1DQFoBVyKpDFY7zK3VDDHuOUFtbdjAXQYHq/dttV3qFtKvhnAf4jF3AHpJi6THdQpF+Ky3FScjFsCVomzGo3Z8+K9Kzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125591; c=relaxed/simple;
	bh=fjXFj100kCYcN8S+gIoosDEgDMnT4aunE8QVxO3yRb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EA/fIVOFZYxumLIl4GmMkltuzrORPEL2Pjtt/esDnIbxz6H74Bu+3v3AzoLAgq7j9055Pt4SOnoNq37k9paq1Yt1ntqO6fUAHvQPCZRqvUIzfn7ZyBuGGU+dG/K9MGSp9WqRr9MOVdw4oS3ZCsJ4PjifkAs7/RJ/GpgKZsdUD4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1DFMw3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5365C4CEE7;
	Wed, 17 Sep 2025 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758125590;
	bh=fjXFj100kCYcN8S+gIoosDEgDMnT4aunE8QVxO3yRb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O1DFMw3xhtfOHGfeN3P4wpcOWgq9+uzroGIAuydIG3m5oFI4ycOYYUWr6kzsbBx+u
	 B0+lv8/ZCaixpZyuoNe5GbtWFIJUfiRhs99qcI8Tbu1DPa7cwAvTYreGRSIG20Odws
	 vfE0PXfzlBQFcOCxbm/UfltFyZTP4pj4YC+su8WM/DgeZIScWVvFORjpbzGiPlPq2W
	 VSUmE+gUg8LUUNJPXna0TKdFfKXXcag+0zTgpjV5YXKTCuhSn138lZBz7bG1DD0kOd
	 htuP/wxAp0t0KcYqQ8uc4G6RmG8jf/+4x54NBiW51vLM02es+yhGSGGgUmi3OqRr0U
	 P+K0vgbaTQM2Q==
Date: Wed, 17 Sep 2025 09:13:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, david decotigny <decot@googlers.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 calvin@wbinvd.org, kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v4 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <20250917091309.1149dc5a@kernel.org>
In-Reply-To: <20250917-netconsole_torture-v4-4-0a5b3b8f81ce@debian.org>
References: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
	<20250917-netconsole_torture-v4-4-0a5b3b8f81ce@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 05:51:45 -0700 Breno Leitao wrote:
>  tools/testing/selftests/drivers/net/Makefile       |   1 +
>  .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 167 +++++++++++++++++++--
>  .../selftests/drivers/net/netcons_over_bonding.sh  |  76 ++++++++++

We need to add bonding to selftests/drivers/net/config:

TAP version 13
1..1
# overriding timeout to 360
# selftests: drivers/net: netcons_over_bonding.sh
# Running netcons over bonding ifaces: basic (ipv6)
# Error: Unknown device type.
# Failed to create bond TX interface. Is CONFIG_BONDING set?
ok 1 selftests: drivers/net: netcons_over_bonding.sh # SKIP
make[1]: Leaving directory '/home/virtme/testing/wt-18/tools/testing/selftests/drivers/net'
-- 
pw-bot: cr

