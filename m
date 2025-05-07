Return-Path: <netdev+bounces-188533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3056FAAD3A0
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 04:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E26577B4C6E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FC717C224;
	Wed,  7 May 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCuK1NjK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288879E1
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586528; cv=none; b=SGU026ZnMf1P8O5/WYA1ZrHM9zuyQULMlCifmoqSvJywth4MWHOUiTrjXh5T9Pz3Sr82XIPigRcfJ4PAJWsutM5ue2AuUTrfE7qcTi8GTa7/x5QWMF+bGYFR3X4OSWZigzpFlanPrx88GLsqsvYPJumTEwDI8b3iP+6drhVjTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586528; c=relaxed/simple;
	bh=L1qVy4hAFBneyVAlDpJZ0I6LWy7/rFNUNeeEYKDyisQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMXhGmxMJgD+2yqqSFS+daqAcOWVVZdQ6dW2/v80zN3thO5xzfoZVqVfC7VegeKzFnGPMaznHM95TnzusssdS3nm+U3fL6t15z4RYUm0J369kN15g8bFO27rMQA9ggwBTKEPG2xR4ywRtunsaub7T09ePuu5McTr8uMOQ0NG8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCuK1NjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAB0C4CEE4;
	Wed,  7 May 2025 02:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746586528;
	bh=L1qVy4hAFBneyVAlDpJZ0I6LWy7/rFNUNeeEYKDyisQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mCuK1NjK7qX9Fe38qMgbiEffY8GcxO7bV2fDIhSjuvf8Jz6OZKNfC8pBghxN+C/qF
	 3GPcC5QO0AwytHPIwwt9o04GkJjxpHYbaK0UYZ2UNuXAuUjMfE9cIhKsbHW/yVFrDN
	 eK+fsB7buRha8kQ1OQ7XbsrgzW6gMj0BKnO9ttTFd1c79a2RoEauaEfvVCGXAv+J4n
	 /VzLYc6Udye87Zv1Ir8aVDEgkP3Z/AxO+BQPLILa/7YxRypGLJFG2cCKDDC7fQ1SYJ
	 FjJ6GpuF8lDfkEn1ZtO3buHUWN6QGCTgB0KCSD5gFHEM4yi8PBdPWmYumJKceN94uq
	 oPOOSab+K9Wuw==
Date: Tue, 6 May 2025 19:55:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, almasrymina@google.com,
 sdf@fomichev.me, netdev@vger.kernel.org, asml.silence@gmail.com,
 dw@davidwei.uk, skhawaja@google.com, willemb@google.com, jdamato@fastly.com
Subject: Re: [PATCH net v2] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <20250506195526.2ab7c15b@kernel.org>
In-Reply-To: <20250506140858.2660441-1-ap420073@gmail.com>
References: <20250506140858.2660441-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 May 2025 14:08:58 +0000 Taehee Yoo wrote:
> +	mutex_lock(&binding->priv->lock);
>  	xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
>  		if (bound_rxq == rxq) {
>  			xa_erase(&binding->bound_rxqs, xa_idx);
> +			if (xa_empty(&binding->bound_rxqs))
> +				binding->dev = NULL;
>  			break;
>  		}
>  	}
> +	mutex_unlock(&binding->priv->lock);

Why do we need to lock the socket around the while loop?
binding->bound_rxqs have its own lock, and add/del are also
protected by the netdev instance lock. The only thing we
must lock is the write to binding->dev I think ?

Would it be cleaner to move that write and locking to a helper
which would live in netdev-genl.c?

Similarly could we move:

	if (binding->list.next)
		list_del(&binding->list);

from net_devmem_unbind_dmabuf() to its callers?
The asymmetry of list_add() being directly in netdev_nl_bind_rx_doit()
not net_devmem_bind_dmabuf(), and list_del() being in
net_devmem_unbind_dmabuf() always confuses me.

>+	mutex_lock(&priv->lock);
>+	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, priv, info->extack);

We shouldn't have to lock the net_devmem_bind_dmabuf(), we have the
instance lock so the device can't go away, and we haven't listed
the binding on the socket, yet. Locking around list_add() should
be enough?

