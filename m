Return-Path: <netdev+bounces-182849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F581A8A1E6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EA5441CC3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31C01B043F;
	Tue, 15 Apr 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie6Fx5sK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC292DFA56
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728782; cv=none; b=HrUHK17BdXfHZKgnDdjdgZQoMSE7F5lrvBIRx81K+oF6Ih5xKSCLJ/ziNfCTaUX4B5Ft/SZTIWU+1vMWqiyTDcMsgJsNJrV0KtXDtnFGO3tKrXFYUeNauJQePRAJlWVe2B9rzeez0M4j7u7WeKCL2Yk3DoScNs4eH/O62Y7ipEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728782; c=relaxed/simple;
	bh=M+/KqYLeWHDkFnt1+EQIm2cnYkuvOKb1sChNTekePCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlTOE2MBEX/zGJRDjebjU6GHX6NkcFWXEwO/m9M0cB9eLssyN5coOZy3UAd00Im+7poBInzhBaijrFZKMYYQwkjgAeN9JNYi9emVn2EdbeESUaX8XqEWxicBynhaqqM5w8KGvgqhpqoVO5f1isKSBwtkVQ7hfB3HLpljQTc7c1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie6Fx5sK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA53BC4CEEB;
	Tue, 15 Apr 2025 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728782;
	bh=M+/KqYLeWHDkFnt1+EQIm2cnYkuvOKb1sChNTekePCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ie6Fx5sKZGpJaITuRfFrWG4fvO7KuPvMN98eokJnqs9vQHj7akSlS/kmEdtj7ERHH
	 sf6zkPxCXoB0dlIZ8vR3wkphhIhbSUrSVRjf6UOG/CkugqR6XR54P+MWXO/WhpLjrY
	 a97v+/BHMZ3JB2rUJuNy9n1L5tdyNlRuHMiAmZIZsblzt/xF6eM8nw6s7X3m0nNlpi
	 IAUODDgiLgsIkrdR9IK2sR1CqDEM8QZ4Cau4f7pZ267YXEEZdRahJ2KTrX2QAbpo1w
	 BX9YuxavWPYuPP+wodg6JlhuZNynSBzJ6kyGgNTkiZTCY0KYiod5TlrjBd5wmB9jqA
	 7qBbD1w1xKD0A==
Date: Tue, 15 Apr 2025 07:53:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, syzkaller
 <syzkaller@googlegroups.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 sdf@fomichev.me, jdamato@fastly.com, almasrymina@google.com
Subject: Re: [PATCH net-next v2] netdev: fix the locking for netdev
 notifications
Message-ID: <20250415075300.5c5fcb76@kernel.org>
In-Reply-To: <Z_2yMjGtbQ0ehtDN@mini-arch>
References: <20250414195903.574489-1-kuba@kernel.org>
	<Z_2yMjGtbQ0ehtDN@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 18:11:14 -0700 Stanislav Fomichev wrote:
> > +static inline void netdev_lock_ops_to_full(struct net_device *dev)
> > +{
> > +	if (!netdev_need_ops_lock(dev))
> > +		netdev_lock(dev);  
> 
> Optional nit: I'm getting lost in all the helpers, I'd add the following here:
> 
> else
> 	netdev_ops_assert_locked(dev);
> 
> Or maybe even:
> 
> if (netdev_need_ops_lock)
> 	netdev_ops_assert_locked
> else
> 	netdev_lock
> 
> To express the constraints better.

Hm, yes, I like.

