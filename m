Return-Path: <netdev+bounces-148325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE59E11F8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13D0164CFC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40343166F29;
	Tue,  3 Dec 2024 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPZ94+HI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC63211;
	Tue,  3 Dec 2024 03:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197419; cv=none; b=LD15aUydSBdjA25pCsnP0QrAotuny/Km48l/t3i26wz41gUHjPkTo0evUSVP9azLrDty+C5S9xI71SAa+/LXeZhSch0nU+ArYgc/w/p0hgK0cZBksiP8sTVFd8QmBdztudRRm02yOwDtAmMa9HK+hjpVDpQmmI7WbQQOIix9HdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197419; c=relaxed/simple;
	bh=A7Wc4NneFrybBiX8iyYnU0ah2oIfrIrHdpOy7ZiBue0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VI9Zohmwa6LGWMawRqQqfxp/hNnFhP4Zl9PbwU2/LaX09AEmhfESIUUY1H2xIQRSO6XqbPdjsL2RZYSCy6BknLsoAATf1ML1hNimh0J8bdOTMV4v6+e9UmqRZykXc1Btb3V4zpJFiRmi7x21zLyKJ5j7nECRbZm5e70JxM7jDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPZ94+HI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B703C4CECF;
	Tue,  3 Dec 2024 03:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733197418;
	bh=A7Wc4NneFrybBiX8iyYnU0ah2oIfrIrHdpOy7ZiBue0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fPZ94+HIY1XbzM0SH88aIhAHyak1qYlRbJoo1cmys0p9hlsNrhkc+Rwc3qaUKDRHo
	 +ZHs60hQbI76uY1ys8lwpHL2g+7ZOAa2tLp4QNbHHQdgVDy43fiL5sRdNVv0Vzdbsy
	 HHBLcC7q+3N8QgI2PwSvNNPekN+61ijmAGdxCuF9WRKZQRechZasNzqKFQRRPKoKSa
	 mIt7DHA/03O6SqO5LUanzxx1OFmyyDo7ZK0OpbLCY0zKHwFS2vpNmt04XLQibWgVZE
	 oKb8KdRWRwLGRfSESC/yCzcdxxYDQ/EFH3JrZToE26GKsOpakdhiarfYM9RhBMgXWA
	 pDETV0sJkwLQg==
Date: Mon, 2 Dec 2024 19:43:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/37] rxrpc: Prepare to be able to send jumbo
 DATA packets
Message-ID: <20241202194337.305e0c22@kernel.org>
In-Reply-To: <20241202143057.378147-11-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
	<20241202143057.378147-11-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Dec 2024 14:30:28 +0000 David Howells wrote:
> Prepare to be able to send jumbo DATA packets if the we decide to, but
> don't enable that yet.  This will allow larger chunks of data to be sent
> without reducing the retryability as the subpackets in a jumbo packet can
> also be retransmitted individually.

clang says (probably transient but since i'm nit picking anyway):

net/rxrpc/input.c:696:25: warning: variable 'capacity' set but not used [-Wunused-but-set-variable]
  696 |         unsigned int max_data, capacity;
      |                                ^

