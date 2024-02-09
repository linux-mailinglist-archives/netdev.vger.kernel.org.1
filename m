Return-Path: <netdev+bounces-70648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D40084FDD9
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1051B28A60F
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D256610C;
	Fri,  9 Feb 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCie6C4C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EC363B3
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511538; cv=none; b=u8LOTv/Bl+Z0rWGk7maAfOjfz/qqj3k5fIH4Wyg/wXv/w4FNqfv44YISQRWEoRZUcnUXbcuEE9mXr/1lV0VPMFtZH/kyoFEqeHefsWbcnMkESzfjC1/NCoLVqMhlbaGvyYL3ra/TROEyO/vU6x5S98JG7wYqP/7KQ47bWzpUEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511538; c=relaxed/simple;
	bh=9bW4io5gvHzx/W5YXwGP3fnNXrscB/aHU5DdatXJenk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhCz+ttLxYr3qz62C/n4aS5Ph8lHQgqjoqGQjH8vW8ZZwdNPo93mVk34R2Npvm9CRuGn8ZudOQLbg9e939IRiWrFJ3ltH0W4No/y7AhxiqIrsBhRzaHH+zt6rnUsNRhx6k14uG6cPuV3OqIpb6aCQ5pMs7sRDcW/HXdyKf+JDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCie6C4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF82C433C7;
	Fri,  9 Feb 2024 20:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707511538;
	bh=9bW4io5gvHzx/W5YXwGP3fnNXrscB/aHU5DdatXJenk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MCie6C4CarHubS0A3/fb+Up2rvhDxZqX9sktBjULRyVFcTmPQeyY6nmuyvM5GKZHO
	 dFstoEPh9Yp8MHFuerALSPX+Q/lGmn9Iw66eosKSfWWKIJAaEfAlSY22i5vHgte2A2
	 6L5Vh6JRCZSYdErUfHrXjZCT9z0DPbZqwCg0ra/51PPmvsgHe4sYa5fLC401XzdLdC
	 SmACsm7IaE80hIcwzZBv7llVvC/WRJsbxjMHq+KCAMJwKMrGxj7D2dNF7fS2aZ8JUx
	 XDvsJaFIdcCdpHB1UnwToaZddAf4VpeH6zX3ko9IP8juBwjXdN1P7smbteIXdAOv3k
	 vuL51n3V5QCfw==
Date: Fri, 9 Feb 2024 12:45:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Johannes
 Berg <johannes@sipsolutions.net>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Sasha Neftin
 <sasha.neftin@intel.com>, Dima Ruinskiy <dima.ruinskiy@intel.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, "Rafael J . Wysocki " <rafael@kernel.org>
Subject: Re: [PATCH] net: avoid net core runtime resume for most drivers
Message-ID: <20240209124536.75599e91@kernel.org>
In-Reply-To: <20240207095111.1593146-1-stanislaw.gruszka@linux.intel.com>
References: <20240207095111.1593146-1-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 10:51:11 +0100 Stanislaw Gruszka wrote:
> Introducing runtime resume before ndo_open and ethtool ops by commits:
> 
> d43c65b05b84 ("ethtool: runtime-resume netdev parent in ethnl_ops_begin")
> bd869245a3dc ("net: core: try to runtime-resume detached device in __dev_open")

We should revisit whether core should try to help drivers with PM
or not once the Intel drivers are fixed. Taking the global networking
lock from device resume routine is inexcusable. I really don't want to
make precedents for adjusting the core because driver code is poor
quality :(

