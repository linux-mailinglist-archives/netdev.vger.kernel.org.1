Return-Path: <netdev+bounces-86052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FACD89D5CB
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677F41C22FB0
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754667FBBC;
	Tue,  9 Apr 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="J1tiPFsk"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73427E774;
	Tue,  9 Apr 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655917; cv=none; b=uExT/ziH95vGeclfrRrmuYp2iJPXPfB4LNqzR3Q6nJUz7UPKHGzdHVzliZ4YjtxF9bKD2w93OXdc/U6ZustW79gCaZJR5kMMtd/sX+y0tSiEl9jfPvrhyMdsgEQlwBHfllUAhVKpIXvzm3QYWTHDJIjGUA0bcnpabBLp5ggEY0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655917; c=relaxed/simple;
	bh=7OKr4HycDUeB/zx8rBNu9gxtoijefw8jgpd7xIePUfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YIRjnaEKGVex4nF4M3O2dwk8yT4SRELPfenEp7o2As30fC9i0+0APe/mGRH2sht+GskAs+u6306BaFd3cyeYxOLFU81hweIFLDD9Z988EeWibjZpevbaaWcFKSOwXX8+HmRMSA5TbiVEkG8X0eFXcm/6CpdocEomDqnSvRK1HJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=J1tiPFsk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1712655903; bh=7OKr4HycDUeB/zx8rBNu9gxtoijefw8jgpd7xIePUfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=J1tiPFsk9FCwNjYBmljWSGdsrXeJyiwirEHHvVen2Uh35VRFDdhBPVG/RTTXdPoAX
	 TMvFcJZQp1aTUYf7YWbBs0EUMw2yoFF6BqJrv0G/VR2OClsb9aGPFG861t6Y6FGrbG
	 DrFBoHao4ZKGjsRrj6QWwLz5FwetZ+g640M8Kg3QKJePV/PTEVpHUjYzoFMKLDmVug
	 c4scIHdjgRqCs4saDZgRX/EydaWn/d0G3iqKvciQ00iyzwyQip0TAig02Tih5S0jxQ
	 loYscQccqiVg93MfmS+G6HSO2UvFFznIZvVlToA+jujb58tzsTFVcIbPaRLI03zK5j
	 gNbooxZuWXj2Q==
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jserv@ccns.ncku.edu.tw, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kuan-Wei Chiu
 <visitorckw@gmail.com>
Subject: Re: [PATCH net-next v2] net: sched: cake: Optimize the number of
 function calls and branches in heap construction
In-Reply-To: <20240408174716.751069-1-visitorckw@gmail.com>
References: <20240408174716.751069-1-visitorckw@gmail.com>
Date: Tue, 09 Apr 2024 11:45:03 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871q7ehnts.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kuan-Wei Chiu <visitorckw@gmail.com> writes:

> When constructing a heap, heapify operations are required on all
> non-leaf nodes. Thus, determining the index of the first non-leaf node
> is crucial. In a heap, the left child's index of node i is 2 * i + 1
> and the right child's index is 2 * i + 2. Node CAKE_MAX_TINS *
> CAKE_QUEUES / 2 has its left and right children at indexes
> CAKE_MAX_TINS * CAKE_QUEUES + 1 and CAKE_MAX_TINS * CAKE_QUEUES + 2,
> respectively, which are beyond the heap's range, indicating it as a
> leaf node. Conversely, node CAKE_MAX_TINS * CAKE_QUEUES / 2 - 1 has a
> left child at index CAKE_MAX_TINS * CAKE_QUEUES - 1, confirming its
> non-leaf status. The loop should start from it since it's not a leaf
> node.
>
> By starting the loop from CAKE_MAX_TINS * CAKE_QUEUES / 2 - 1, we
> minimize function calls and branch condition evaluations. This
> adjustment theoretically reduces two function calls (one for
> cake_heapify() and another for cake_heap_get_backlog()) and five branch
> evaluations (one for iterating all non-leaf nodes, one within
> cake_heapify()'s while loop, and three more within the while loop
> with if conditions).
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

