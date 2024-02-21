Return-Path: <netdev+bounces-73770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EF585E489
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC4B23563
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147F83CB2;
	Wed, 21 Feb 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkNrUne+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF283CAC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536508; cv=none; b=S75zIjb5UJ+f0pTirfYoJdv/t8KDO3xfdqnuysJmI5+e7ag5ccyg0Jn5TQGaqtWCku5/W7pH6DsErKxBcuW7XDTTgL1WFqVH5i+r1fRSdDKONnrtvKv2oOpK46pi1MQZSkogWXQwRQicxupgi5yiAcyO68kBPAVWYAhBOG2WGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536508; c=relaxed/simple;
	bh=JsYoEPqCzKzzp+mPDcCyqpgbdQJnkUADUqYdmI9vhhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSZL2rL1T2URl13WHI1Ri0ZBHUvdZ5LCWmr7uI3JiVjupHqOKjke5mmKQKe7jTNfS7eMJIM4BHIpF7bBvnFMICzvejzYuPc5SyKAclSU0gOm3AqRpw1UEdNDFFZGZmm7aIegPoOQ4Tc74WYQeF57ECxlRhRVm3GGoQ2sxpjVdL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkNrUne+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E26BC433C7;
	Wed, 21 Feb 2024 17:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708536507;
	bh=JsYoEPqCzKzzp+mPDcCyqpgbdQJnkUADUqYdmI9vhhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkNrUne+lx1G9zpE+DCe7MZMCA/0FfKzKAhF1fojydiIelQ0AktutRVgB4Vb80soh
	 1l3s0m1Gwab7Y5XMWef3sIHjQMuc5A56tnvpiODLakxxlv10woaxxibT9MKAhqxrMj
	 P0SW3chMdwUzChP1irXXPdeAH5+40FqE36udCNHW9Svoq+Cm82ftkRiqXrhyc1jO4f
	 dWluQA2nAqp3oN4qqdKpRMOaPdOQ0hGDZhK75enf+ugBt4rzGLRzz9I7V8qeh6KPjd
	 DESlsMYYDBrzZQcMK100L/Y9F2c0K6hjpOVOb1z2RTIvGadcpUY8GyJOQYS96de9y4
	 wf+penMecYTvQ==
Date: Wed, 21 Feb 2024 17:28:24 +0000
From: Simon Horman <horms@kernel.org>
To: Geoff Levand <geoff@infradead.org>
Cc: sambat goson <sombat3960@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 net] ps3/gelic: Fix SKB allocation
Message-ID: <20240221172824.GD722610@kernel.org>
References: <52f5f716-adec-48bf-aa68-76078190c56f@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f5f716-adec-48bf-aa68-76078190c56f@infradead.org>

On Wed, Feb 21, 2024 at 11:27:29AM +0900, Geoff Levand wrote:
> Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures") of
> 6.8-rc1 had a copy-and-paste error where the pointer that holds the
> allocated SKB (struct gelic_descr.skb)  was set to NULL after the SKB was
> allocated. This resulted in a kernel panic when the SKB pointer was
> accessed.
> 
> This fix moves the initialization of the gelic_descr to before the SKB
> is allocated.
> 
> Reported-by: sambat goson <sombat3960@gmail.com>
> Fixes: 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>


