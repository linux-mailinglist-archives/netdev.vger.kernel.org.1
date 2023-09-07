Return-Path: <netdev+bounces-32449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9954F7979CD
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8A01C20B43
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F144B13AD6;
	Thu,  7 Sep 2023 17:20:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DF134A3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:20:52 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A41BF1;
	Thu,  7 Sep 2023 10:20:31 -0700 (PDT)
Date: Thu, 7 Sep 2023 09:09:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694070597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIT9Xuhbk14VJ0zyJUrybkF4mAQdzknKv/CgR0FkJGw=;
	b=g5Mv+7zaP+i2El3XQgqNJMVFfUYY12W+IFev7OYLnxzl5qCvqqXy+RJqoXV7+sv7RVgcdP
	PddiT8DRGjA1dK96RNyyt7hpMscuoHF0Zg55cq31VhfkheWQzGDh/78NJ4oRgzBhvZd0fq
	t3nFL6vP6ruoilWWyB8V8KLvZzw8m1oNacRx1clkGKgNTIjz5zeYRWSq+ql/chmSLOuV+Y
	avi8zviQsoP5Vupr+3gK8Sfpr1urCNW0Dj3hqxJdNVW1NVwPQdiXyPm32iBaIMuTxqRRSk
	d3fkQqry8d6yMD7PzaBk9VqAav10IlY595vKcgAEnh9lc7wd4sw+UCGmBIO65w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694070597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIT9Xuhbk14VJ0zyJUrybkF4mAQdzknKv/CgR0FkJGw=;
	b=t2Jf6L8XqYLZBFzvsoCbEmUUYl0tcrjK7pV5efW6dU6O4UAeDnmiQ5u4owzSPxQvHGwNO2
	GiHfMXZrX76B6sDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
	alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: Re: [PATCH net v2] octeontx2-pf: Fix page pool cache index
 corruption.
Message-ID: <20230907070955.0kdmjXbB@linutronix.de>
References: <20230907014711.3869840-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230907014711.3869840-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-07 07:17:11 [+0530], Ratheesh Kannoth wrote:
> The access to page pool `cache' array and the `count' variable
> is not locked. Page pool cache access is fine as long as there
> is only one consumer per pool.
>=20
> octeontx2 driver fills in rx buffers from page pool in NAPI context.
> If system is stressed and could not allocate buffers, refiiling work
> will be delegated to a delayed workqueue. This means that there are
> two cosumers to the page pool cache.
>=20
> Either workqueue or IRQ/NAPI can be run on other CPU. This will lead
> to lock less access, hence corruption of cache pool indexes.
>=20
> To fix this issue, NAPI is rescheduled from workqueue context to refill
> rx buffers.
>=20
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 8511906cb4e2..997fedac3a98 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>  static void otx2_pool_refill_task(struct work_struct *work)
>  {
>  	struct otx2_cq_queue *cq;
> -	struct otx2_pool *rbpool;
>  	struct refill_work *wrk;
> -	int qidx, free_ptrs =3D 0;
>  	struct otx2_nic *pfvf;
> -	dma_addr_t bufptr;
> +	int qidx;
> =20
>  	wrk =3D container_of(work, struct refill_work, pool_refill_work.work);
>  	pfvf =3D wrk->pf;
>  	qidx =3D wrk - pfvf->refill_wrk;
>  	cq =3D &pfvf->qset.cq[qidx];
=E2=80=A6
>  	cq->refill_task_sched =3D false;
> +
> +	local_bh_disable();
> +	napi_schedule(wrk->napi);
> +	local_bh_enable();

This is a nitpick since I haven't look how it works exactly: Is it
possible that the wrk->napi pointer gets overwritten by
otx2_napi_handler() since you cleared cq->refill_task_sched() earlier?

>  }
> =20
>  int otx2_config_nix_queues(struct otx2_nic *pfvf)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/dri=
vers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index e369baf11530..b778ed366f81 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -561,9 +565,24 @@ int otx2_napi_handler(struct napi_struct *napi, int =
budget)
>  				otx2_config_irq_coalescing(pfvf, i);
>  		}
> =20
> -		/* Re-enable interrupts */
> -		otx2_write64(pfvf, NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
> -			     BIT_ULL(0));
> +		if (unlikely(!filled_cnt)) {
> +			struct refill_work *work;
> +			struct delayed_work *dwork;
> +
> +			work =3D &pfvf->refill_wrk[cq->cq_idx];
> +			dwork =3D &work->pool_refill_work;
> +			/* Schedule a task if no other task is running */
> +			if (!cq->refill_task_sched) {
> +				work->napi =3D napi;
> +				cq->refill_task_sched =3D true;
> +				schedule_delayed_work(dwork,
> +						      msecs_to_jiffies(100));
> +			}
> +		} else {
> +			/* Re-enable interrupts */
> +			otx2_write64(pfvf, NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
> +				     BIT_ULL(0));
> +		}
>  	}
>  	return workdone;
>  }

Sebastian

