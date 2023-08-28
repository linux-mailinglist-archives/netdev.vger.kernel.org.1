Return-Path: <netdev+bounces-31090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABA078B577
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 18:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E386A280E4F
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A885912B72;
	Mon, 28 Aug 2023 16:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09011CBE
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 16:40:24 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19570F9
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 09:40:23 -0700 (PDT)
Date: Mon, 28 Aug 2023 18:40:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1693240820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UtNLEsXLPRLi38M8lWck0Qg9HdGFFcbWIszXI+UmdQ=;
	b=PkS1ycTN0CkMpg9fVI+BDRmDE2IE5vm3hPTTrQ9VAmICYcdFu+feLv5ilAPfm9zlY6/CQP
	dbqvCESZVCld4rXmYpyDgDfYnDWo729lXFoE2GYCx55LiggFcT85cIZ17TAi+6ZDpNr1am
	m1U4IPtqi3eAcbJDFKtrp6fjP1eDCxSJSLCAqKYHTMq5UmBZV/af3+fQcxignE83NXv/Ea
	b0KoCiN9jozO7+PuK0DRmPtIG7ftMehKZ6I1vtpmkoqFbKqYGr7oj3XHp0+jACUcsYQ+Gk
	UOLQIH/q2KGD6g4RPw+FMjdTCcAD7z2mHLoW6WnW6csV4dEB8Duk4BwgHIcDYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1693240820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UtNLEsXLPRLi38M8lWck0Qg9HdGFFcbWIszXI+UmdQ=;
	b=uFF0ZTZvZ/hUK4642mKGpr7ud8MN+8iJplZUO/E3btCryy3BewyXtwS+qGVVkQsGjP6xtQ
	GVZNwLyKdyj7rSDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hariprasad <hkelam@marvell.com>,
	Qingfang DENG <qingfang.deng@siflower.com.cn>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Message-ID: <20230828164016.pAgzg9XK@linutronix.de>
References: <20230823094757.gxvCEOBi@linutronix.de>
 <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
 <923d74d4-3d43-8cac-9732-c55103f6dafb@intel.com>
 <044c90b6-4e38-9ae9-a462-def21649183d@kernel.org>
 <ce5627eb-5cae-7b9a-fed3-dc1ee725464a@intel.com>
 <2a31b2b2-cef7-f511-de2a-83ce88927033@kernel.org>
 <d1f43386-b337-db94-7d9d-d078cd20c927@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d1f43386-b337-db94-7d9d-d078cd20c927@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-28 13:07:12 [+0200], Alexander Lobakin wrote:
> > Looking again at the driver otx2_txrx.c NAPI code path also calls PP
> > directly in otx2_napi_handler() will call refill_pool_ptrs() ->
> > otx2_refill_pool_ptrs() -> otx2_alloc_buffer() -> __otx2_alloc_rbuf() ->
> > if (pool->page_pool) otx2_alloc_pool_buf() -> page_pool_alloc_frag().
> >=20
> > The function otx2_alloc_buffer() can also choose to start a WQ, that
> > also called PP alloc API this time via otx2_alloc_rbuf() that have
> > BH-disable.=C2=A0 Like Sebastian, I don't think this is safe!
>=20
> Disabling BH doesn't look correct to me, but I don't see issues in
> having consumer and producer working on different cores, as long as they
> use ptr_ring with locks.

After learning what p.napi is about, may I point out that there are also
users that don't check that and use page_pool_put_full_page() or later?
While I can't comment on the bpf/XDP users, browsing otx2: there is
this:
| otx2_stop()
| -> otx2_free_hw_resources()
|   -> otx2_cleanup_rx_cqes
|      -> otx2_free_bufs
|        -> page_pool_put_full_page(, true)
| -> cancel_delayed_work_sync()

otx2 is "safe" here due to the in_softirq() check in
__page_pool_put_page(). But: the worker could run and fill the lock less
buffer while otx2_free_bufs() is doing clean up/ removing pages and
filling this buffer on another CPU.
The worker is synchronised after the free. The lack of BH-disable in
otx2_stop()'s path safes the day here.
(It looks somehow suspicious that there is first "free mem" followed by
"sync refill worker" and not the other way around)

Sebastian

