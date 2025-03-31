Return-Path: <netdev+bounces-178285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0778AA76640
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2C6188915C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A420202979;
	Mon, 31 Mar 2025 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0hm7OUA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645C1E32A3
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743425062; cv=none; b=tKtvJErPAbA3EtTJOBIIaEe0ZRRRMncoRsCXh48MviaVWCkfdHNF8YzOZSTgTeAQwsKGy2YzyuYD/WDtafr1pm4UPy4J5mHAjcBXrQ3HF0qgNq6BjevhawUoRjtnMLs2tGEJw3eVDZiTbnIC7/COizwzCgxNmIxODowAPMmUKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743425062; c=relaxed/simple;
	bh=aWKuAcjkPK09JdPcFjyNkwxjOob7bYo2Ezmy79mpceI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7cD2vlkiVtl30QPag0u6Tcojui9lHqFvCCnXOnjUYSK3vMMtdwd4YptM6G85y8SUHTNBqPMPV0oproq4wtTRmIMtGMFjnG5mwpAwzhNKeO6VUqKkPR0B3euGjiYnwYjdU/cnr4EO5hsxnC4n6FWxHZWjqo4gEx7k4eaZdz+GTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0hm7OUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B21C4CEE3;
	Mon, 31 Mar 2025 12:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743425061;
	bh=aWKuAcjkPK09JdPcFjyNkwxjOob7bYo2Ezmy79mpceI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0hm7OUAeDeIi8eEDtMPNIFr4ScWb2ZLf96Xcnjx850/pzOaY/AzdTHxPf/PI27bt
	 DU0pB9+1hUrQJ9O/UijUkzOLAphq1P6aV2KpATW1VW8MchkacV3rurMJdnOvIStNCn
	 Gh6yv/vvm5HeA8nJDyhQ0+ZFIvuSTGDsH67g3kpCPXpm5nXmz/fJXxKRHJJgFUa0Va
	 1fB9O4JJINqI8hDVEpcu0jYzs6Hkte7gIc3CUFAEg3CotrGQ1lJP9FlD/vP3lnfeb3
	 ZviGP1xwWrujPubASZ045KYuguYYWVFI9uO8AHUMBEKOAvEhhOW+1WKiMyphFOp8YS
	 1QaZOFalabIFg==
Date: Mon, 31 Mar 2025 13:44:17 +0100
From: Simon Horman <horms@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	jdamato@fastly.com, sdf@fomichev.me, almasrymina@google.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net] net: fix use-after-free in the
 netdev_nl_sock_priv_destroy()
Message-ID: <20250331124417.GB185681@horms.kernel.org>
References: <20250328062237.3746875-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328062237.3746875-1-ap420073@gmail.com>

On Fri, Mar 28, 2025 at 06:22:37AM +0000, Taehee Yoo wrote:
> In the netdev_nl_sock_priv_destroy(), an instance lock is acquired
> before calling net_devmem_unbind_dmabuf(), then releasing an instance
> lock(netdev_unlock(binding->dev)).
> However, a binding is freed in the net_devmem_unbind_dmabuf().
> So using a binding after net_devmem_unbind_dmabuf() occurs UAF.
> To fix this UAF, it needs to use temporary variable.
> 
> Fixes: ba6f418fbf64 ("net: bubble up taking netdev instance lock to callers of net_devmem_unbind_dmabuf()")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


