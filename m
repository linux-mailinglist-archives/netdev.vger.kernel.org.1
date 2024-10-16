Return-Path: <netdev+bounces-135924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668999FCC7
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BEE1C23A62
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530EAA31;
	Wed, 16 Oct 2024 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFqZDjiU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B14C91;
	Wed, 16 Oct 2024 00:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037204; cv=none; b=KPdnvzjb7MKhaheCpcImNewUVp3F3oFBF70gTPc5hAocD5GqXFlEffWN21hbqdqOASvwafXY4ELDtyAfTWzNEbfufsT5MugBHkuppeG8yt7nr/uBfwg+d/RfVYBbwLUqflz/iz2vVXmY7yBLjnRPWxdseoDB+0WOXr6komCu6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037204; c=relaxed/simple;
	bh=HG/5Lf4PN8ZwfOLHeb7Pqn9YbCXldMzqVdPyn+SXG4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Js6w/xoZhg8SnsLnzclsF55UKpDPZ4y6uUeujpJk0vGVdykWMEKgrhLJT5Mhe8obQOA/qI7pB1vUj2PNw/vRwX4EJnrchYpovgWpwTItBvO/gE6pyTprEymVlMW12Y+anK4qijIUx9BMMwXz6r3You7jJGi6ND3SR6ukNpreVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFqZDjiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33946C4CECD;
	Wed, 16 Oct 2024 00:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729037203;
	bh=HG/5Lf4PN8ZwfOLHeb7Pqn9YbCXldMzqVdPyn+SXG4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EFqZDjiUPmdkaOmaHtl1KJLKkq4CCKgPwYVv9MkOpp0V3JMEiY6VpF3iepC2+B/12
	 Y63UobablX2Awm72leh+BhyHzZLO4lKgWzYkRe8tMI+C5sywkbItgXAxbtlZ/7QK1c
	 JbRhc8tOm+W/Jb7nsWCKkwot4yqYqv+N2vCM4ZpKM835BMGJ2K8ih7GwAEr4ZU+qbR
	 sPlya9WHXfC99BZ+GusLgCthJa9rpT05K6akJhNpFKcNEUdIaL0fyJTwt3dRxbrFYr
	 iWHZHQ/KlAI6Gm2drwXTvBoERjdwqLp/xEw4SCj8c2Yb7Mfmf3JeaJK+07LcVrldJ3
	 mHreeFIWIcmEQ==
Date: Tue, 15 Oct 2024 17:06:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 00/10] Lock RCU before calling ip6mr_get_table()
Message-ID: <20241015170642.190cf837@kernel.org>
In-Reply-To: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
References: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 17:05:46 +0200 Stefan Wiehler wrote:
> v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241001100119.230711-2-stefan.wiehler@nokia.com/
>   - rebase on top of net tree
>   - add Fixes tag
>   - refactor out paths

Please add the relevant info (from patch 2?) to the cover letter.
Otherwise it's hard to figure out at a glance what this series is
fixing.

