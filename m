Return-Path: <netdev+bounces-183552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD7A91009
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 02:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DB55A1E3E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD4DB665;
	Thu, 17 Apr 2025 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd9dhpK6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA4360
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744848957; cv=none; b=Ly8PzdvebeaeMngJ5uhT6drUMVC+W9SkUn+DteyMDI4klA7qk3/QL7pKRt+76+6nJU7YcxrquAEml89W3W1PhjaRYpp55gnur87KaNxNB0xp+5FAaC38qQBtPJHDSTu4uDGRk5P1ZPZgI+zj1YeYs+Jof9kVGpqxCPgg2mI0TU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744848957; c=relaxed/simple;
	bh=lPi9Td3AwvDKmedynM2RVY365orBF6qJSIDwNc4vmKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaCQurPaW2GzVweac2xIxP+j0mXikOPUfoTqtZB/2tWrjLyjwPgba1Ol7ZfSef5xLPR4x1i4OcatVnE+vCExkDpVVa75TozDYu6APWybxNB/Ms91q+dNnHdPShTxz5gpQ0igtqdFb2pVyVqiRp5j67I31fCjn1Dj8Ls8faUcRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd9dhpK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30EDC4CEE2;
	Thu, 17 Apr 2025 00:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744848957;
	bh=lPi9Td3AwvDKmedynM2RVY365orBF6qJSIDwNc4vmKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dd9dhpK6aFXsFYFYB/tW4+Pg3lhYXu1aq2BsPafl3vPIpBHd7OeR/S9OuqNz4zlkd
	 OIYx3NQZzVkQtRgK7lzTs3aLfrBMmy+Bc6zetlSTDli8YEd8qAAb5Sj8HEtsAvRE9T
	 EoTU2LGx4JBRci1CI9qeM3ObKvDeuDvW8hE5gdqFkISxz+eEIYduNNVWI2H9P6O7Rt
	 wDF+r7KE+a1syskAHc1kYbhcdaLv+Va89nv3tPrm+O/A3vhS1EiOtuz9QhEfAp5I4Z
	 A8xpvCxnLjuVtphoIGiH0QB+CklLvfYE2fyboR6HK/HRyJl0aE464Y81xLnuX3u05V
	 Wf6ceEA47J+Ag==
Date: Wed, 16 Apr 2025 17:15:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, Taehee Yoo <ap420073@gmail.com>,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, asml.silence@gmail.com,
 dw@davidwei.uk, sdf@fomichev.me, skhawaja@google.com,
 simona.vetter@ffwll.ch, kaiyuanz@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <20250416171555.11cf612c@kernel.org>
In-Reply-To: <Z__BRyblHNHhnui7@mini-arch>
References: <20250415092417.1437488-1-ap420073@gmail.com>
	<CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
	<Z_6snPXxWLmsNHL5@mini-arch>
	<20250415195926.1c3f8aff@kernel.org>
	<Z__BRyblHNHhnui7@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 07:40:07 -0700 Stanislav Fomichev wrote:
> > The socket close path would probably need to lock the socket, look at 
> > the first entry, if entry has ->dev call netdev_hold(), release the
> > socket, lock the netdev, lock the socket again, look at the ->dev, if
> > NULL we raced - done. If not NULL release the socket, call unbind.
> > netdev_put(). Restart this paragraph.
> > 
> > I can't think of an easier way.  
> 
> An alternative might be to have a new extra lock to just protect
> the binding->bound_rxq? And we can move the netdev_lock/unlock inside
> the xa_for_each loop in net_devmem_unbind_dmabuf. This will make sure
> we don't touch the outdated 'dev'. But I think you're right, the same
> lock ordering issue is gonna happen in this case as well.

Yea, I was wondering about that but unless we're holding something that
prevents the netdev from going away - a lock or a ref - we'll just
circle back to the same race.

