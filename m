Return-Path: <netdev+bounces-155689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC61A03579
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF4A3A3908
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290E8132111;
	Tue,  7 Jan 2025 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB0drO3c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05AB7082B;
	Tue,  7 Jan 2025 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218342; cv=none; b=CxBjh/RKfiXOgiXp28gaA9rMRc7tFJwud2Ev43JU0g19dLEL0im8tgkSlqxR0SE35Uzifw0YAifW3WDA4Dcjq+MrTqJeZ4RX7wyrt1U/fOQYwWbI5yzlzFewN27YRJ5S9EwAAqH6HA9s9cH4pv2656sjmFSZNKQkpmn4OdB2Ps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218342; c=relaxed/simple;
	bh=XVJJMqKAu7+VbR801LY1pXogtX3xd9vplo928xn2JKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DITd+EmXqTr9lNyB/yWUT/FnqIHXPKqE0hT/8s/7EuziYm5hdxd/TzmsprMBc604SIN7a/p45XZ1DPa4M19QiyoNYVgGcbw3iIiZe7ob3ecTg0rcmN6WO9WnEDIXbkeqPEIaVTxK3xA7Bt8tZ/FR8RfJw0op4SmA04tDedQliUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pB0drO3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C8CC4CED2;
	Tue,  7 Jan 2025 02:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736218341;
	bh=XVJJMqKAu7+VbR801LY1pXogtX3xd9vplo928xn2JKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pB0drO3cT2vWvb6ISuvGRV34VXnYNx0MGox3/mmkNgnqV+NcLwp5MDa4kTJSNalnZ
	 nSJ91tROQvAMbRbZaFu5r8evnb3r4afp7ExAi/wF1poYcrHmSWTsTmqSVx7J35fcPC
	 /KJXfSJlq7yyb0tWb72d0gazDYdjU3nhpxj7P2HPIEAgL1oyDtWtoDEtBSZyFUziMn
	 HaZV9GoZEOai4GGLvXjZdLWUWAXJ1dzD3gQP2hM9v03gvegQnn9fDaRJfBjPgztGxL
	 0Q3HABiGa1LR6+zfhjNrSOjnjyFRk3VTAoDpjWJgXcdxwylZS4zDUjlUxslJDi1Fog
	 x2PhRJBhFtCMQ==
Date: Mon, 6 Jan 2025 18:52:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v7 05/10] net: disallow setup single buffer XDP
 when tcp-data-split is enabled.
Message-ID: <20250106185219.74f93c7e@kernel.org>
In-Reply-To: <20250103150325.926031-6-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
	<20250103150325.926031-6-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 15:03:20 +0000 Taehee Yoo wrote:
> When a single buffer XDP is attached, NIC should guarantee only single
> page packets will be received.
> tcp-data-split feature splits packets into header and payload. single
> buffer XDP can't handle it properly.
> So attaching single buffer XDP should be disallowed when tcp-data-split
> is enabled.

Acked-by: Jakub Kicinski <kuba@kernel.org>

