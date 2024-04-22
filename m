Return-Path: <netdev+bounces-90249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D748AD51F
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 21:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3341F216AA
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416BB15534E;
	Mon, 22 Apr 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCEBy/La"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B015534A
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815217; cv=none; b=toZ4pabX1bmKMk9DUusB/PGgrU0i3z/QfpNO6Xzh1YnTxjK1vHSzIBV/9vNrrj+KzHDPK2w0tlWHbzcvLLPtoS1D3uotYMjAbezGGBLH+QcUVwPbO2l9bzpMQetAbHIL9KYYK5OdnFwm35R0IQ/urW5so/ODE1ZIW4o2No1BAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815217; c=relaxed/simple;
	bh=k/8X/LY9uOYcAbonLvKHd2WwISfJh3vZsijQHfaMYxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcsRgnoYxPZdvjfCSzGYcn8bqTQrFwrt2FKSloNruCVGHmg9l9SMP81r41gQ7OVNDcNQsWp6MEjeomnfzYH/ZhVAXeZmfVZTF7yMsvq+MaBpRFD6frBsV6U08aygFH3gH5yTbAlO/dSO+kmLWgVDBglwYUteWcJiw/y2+m5iz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCEBy/La; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D07FC113CC;
	Mon, 22 Apr 2024 19:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713815216;
	bh=k/8X/LY9uOYcAbonLvKHd2WwISfJh3vZsijQHfaMYxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QCEBy/La7t/aCocUHEZphhbN31L2VHFDDxYhx4SCYpfMmE1j4ApJaGEMQUZcpCv/0
	 zcnUp0gXJCjmjaVi7gdxzLUB/Iazl9WcVmjtWKy+E2pMmegGmv6Hys+RLs8vVKp+A1
	 bFwtN6Ebfz0k3g8N+IicvbgfrFbhNg4MIRCV/Kt9BfB9XjxhdNgddujXT6c8xXJx36
	 8D6epm1Id2jo/+JDjTnF1O6LDg/C73/p/Y2pOX33RccgMu8nV3xT9wD+DOp46EIS++
	 wD4Ny4qYB0PF9EVcs5KmlDLSWnC9ZfA8yhQGk33lfhVxvPhob5srrDnKjc+ZgfD4ZY
	 bWAcz8AzP13hA==
Date: Mon, 22 Apr 2024 12:46:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: zhulei  <zhulei_szu@163.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: Kernel crash caused by vxlan testing
Message-ID: <20240422124655.30a9b39f@kernel.org>
In-Reply-To: <610c7229.e38a.18f05295d5d.Coremail.zhulei_szu@163.com>
References: <610c7229.e38a.18f05295d5d.Coremail.zhulei_szu@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 17:35:48 +0800 (CST) zhulei wrote:
> According to its stack, upstream has relevant repair patch, the commit id is 7c31e54aeee517d1318dfc0bde9fa7de75893dc6.
> 
> May i ask if the 4.19 kernel will port this patch ?

You need to request the backport form stable maintainers,
or the author.

