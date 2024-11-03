Return-Path: <netdev+bounces-141339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373B29BA806
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9953428179E
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C918BBB8;
	Sun,  3 Nov 2024 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmqL4GR+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5283CD3;
	Sun,  3 Nov 2024 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667036; cv=none; b=FdpAev7162OqkDtVdEiAIsCyALQ91CZt3Ldcufon+JQcTiYrw+MKbQ0LkQ85jRDASKLnicRclIjONW2Io6hpKedi+aY8XCOEZTWlhgNCP3nVIrND5jjtWgvFyyh5m1uMCCz2qwtaLb3uv62MNy4YIjskuP09ZDY15nq6ICC49Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667036; c=relaxed/simple;
	bh=0XUV0VbcIRK0revMTo8r7QUXU3/XHGnvm9TNClNnFVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXdtP6Bqzcrny8/2ocNtgO2hsPZhOhGSo7Gj5ZoBUyYlRORbzKNOclDckI50Tstnkwl6loeRK4VOfP4nRoElx7+oZ9rNc/s8Cgkyb/6NUhaT0rKtFm+iUwYb+McYWCwyEXPddFKx1HQdgTv+kcIFGO+m7poa+aEHMBLj6uAx5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmqL4GR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B821EC4CECD;
	Sun,  3 Nov 2024 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730667036;
	bh=0XUV0VbcIRK0revMTo8r7QUXU3/XHGnvm9TNClNnFVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QmqL4GR+ldvCw/9MNJqu6/DT/SoZWrP8wJtwZKrQNZPeadrGkpWCjdZvBRDEmh+m4
	 GjdCEmjtqQD64NuswLMN+UzIxO+1H8iz6k4CjEXZEmEArR4cox+9ykhra4hIzkAUe8
	 AUEbmq35eMBGKuGtz4k0RKw2+r+6AraeolDcHWD+4X8LL0zmilX9C6nuZK+5ceMKQ6
	 VLR+PKogOtin4UdjnDHWFWmPKhSNrL8fooG4pI3QO1bB3vz6LheKN1g/ATTW5teqwC
	 MafoEnhLYDxhIpP/qEIiDFnw6CqDbBtlMy2fU05MPcaQ7QpEL0x0ufaew1de9EJ/e5
	 IruML2peqXoTA==
Date: Sun, 3 Nov 2024 12:50:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net 0/2] Fix issues when PF sets MAC address for VF
Message-ID: <20241103125034.27c43c51@kernel.org>
In-Reply-To: <20241031060247.1290941-1-wei.fang@nxp.com>
References: <20241031060247.1290941-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 14:02:45 +0800 Wei Fang wrote:
>   net: enetc: allocate vf_state during PF probes
>   net: enetc: prevent PF from configuring MAC address for an enabled VF

This combination of changes would imply that nobody sets the MAC
address on VFs via this driver, correct? Patch 1 fixes a crash
if address is set before VFs are enabled, patch 2 forces setting
the MAC before VFs are enabled (which would previously crash).
Which leads me to believe this will cause regressions to all users,
if such users exist.

The fact that the MAC address is not picked up by a running VM is
normal, I'd say even maybe expected. IIUC hypervisor will enable 
SRIOV at the start of day, then allocate, configure and assign VFs
to VMs. It will FLR the VF after configuration.

Your change will make it impossible to reconfigure VF with a MAC
of a new VM, if any other VF is in use.

Long story short, I don't believe the patch 2 is necessary at all,
maybe you can print a warning to the logs, if you really want.

