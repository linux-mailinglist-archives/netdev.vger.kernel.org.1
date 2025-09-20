Return-Path: <netdev+bounces-224997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED919B8CBC4
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D466B1B23762
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C453221FC4;
	Sat, 20 Sep 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="euKpAvoa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC7746B5;
	Sat, 20 Sep 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382733; cv=none; b=hjlZImPHFEFaPbBhkMzesOamud325nKq+NxcJV/oJJvbb8Yi2dEZJMyssSFPDmkVK5s9r8A1UOiqySQrXcQkTj3sTsBknSyzhVrrpxTs8q1j0VniM5fATK7BYExI/IIAzRoQhux/pvZRI5ck4iDbffLXue2DsoF//XnHGJfiUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382733; c=relaxed/simple;
	bh=aoyucU21XYvw23LjbsacMXWhMuUF0s6WiAs6Pyn26Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYGEuPRaE0Zc/BVC8uwmlfe1RCMdut59mqopRrkro1NSHV1HH0yQMlCp8xs9Kbo0lC5ZM2q/Vfn2H+/22eFa7E+9nz+8uI7iFsacq/mWFhDTzUEfjFdjwJxqM/1EAmNnlmAj/SV6hykpOd4OhSXDvK46Q6+EzLTkarebluZznv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=euKpAvoa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BuNCCt9KtSw9j9PEamLhH1YTxXmkI6ZRhCi5Hi/fgl0=; b=euKpAvoairSvf0rtviwhdk5PlE
	xnl3pen22yIiXQw263kcsw8rRilgXZ/lx72+o61iKaG0v4mqO2vIK7e+fsNfwmrEtsxFFwrp4G82O
	XUDDfcuIxfnmM6lCejDdYTFIqjJjyfUyz5rdv9q6zrz0f/hmJ7Z+K8hE+sGBbE+2ivbw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzzfZ-0091Ir-67; Sat, 20 Sep 2025 17:38:37 +0200
Date: Sat, 20 Sep 2025 17:38:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, willemb@google.com,
	kerneljasonxing@gmail.com, martin.lau@kernel.org, mhal@rbox.co,
	almasrymina@google.com, ebiggers@google.com,
	aleksander.lobakin@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: skb: guard kmalloc_reserve() against oversized
 allocations
Message-ID: <34a4e8db-b0b8-4ad8-b8a2-bdfd69cc8b00@lunn.ch>
References: <20250920113723.380498-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920113723.380498-1-kriish.sharma2006@gmail.com>

On Sat, Sep 20, 2025 at 11:37:23AM +0000, Kriish Sharma wrote:
> Add an explicit size check in kmalloc_reserve() to reject requests
> larger than KMALLOC_MAX_SIZE before they reach the allocator.
> 
> syzbot reported warnings triggered by attempts to allocate buffers
> with an object size exceeding KMALLOC_MAX_SIZE. While the existing
> code relies on kmalloc() failure and a comment states that truncation
> is "harmless", in practice this causes high-order allocation warnings
> and noisy kernel logs that interfere with testing.
> 
> This patch introduces an early guard in kmalloc_reserve() that returns
> NULL if obj_size exceeds KMALLOC_MAX_SIZE. This ensures impossible
> requests fail fast and silently, avoiding allocator warnings while
> keeping the intended semantics unchanged.

What is the value of KMALLOC_MAX_SIZE? Do we actually want a
warn_once() here because it indicates a driver bug, or missing
validation of user space parameters?

	   Andrew

