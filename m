Return-Path: <netdev+bounces-177691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE85A71485
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB91317026F
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10B115381A;
	Wed, 26 Mar 2025 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdRrNXZV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E58C1F
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984065; cv=none; b=MXnq8LGHAlw//aottshvYZ5ZMSvnZGRTesbZWKZPpryX9WMCPKu8v5KgAwj3hQsQqBZ6p2wCgufqB5UIggJsEUKk1JI6aXP7pQPBFFb64l9oLmDlGFrU7zgRcbuUSd7oEcPrWM1/yszFjbW7gFeN2zXoR745GOjAGlUlHQ98FPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984065; c=relaxed/simple;
	bh=tOQehmepZpRcQdd2KkaK5BvBOwkhCU5kfsH1Ddm1vXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWw6SFz1H/OhEHrC1sJGo7wWEJ1kdxXIU5Ol9+fvAknONhJq+Bl9NN6WVsQgUKnk+ThwBu4BXRfswGSvClAoD5+hU7g60uRZCVixbqxNv3cQl+mTIdsMUJRn4W3/Oa7oDzyvmwiF01jdA3q+FPLcVQ04UXxtkzyiPdWghYHC3Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdRrNXZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69B9C4CEE2;
	Wed, 26 Mar 2025 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742984065;
	bh=tOQehmepZpRcQdd2KkaK5BvBOwkhCU5kfsH1Ddm1vXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdRrNXZV5HPqucwcsVaa6DRZC61Orh0fZG+PK5fHSyq48oACH5j9uRMC9tt3juBss
	 rEVbyAI7a8cnRmDetpllGUxakVNpnHIgVUiAhXc3fknAx2HbR//38z+1ZfpxXeknBc
	 9GDKA9mmZoSdpVnA2cWmc9ZaHP6QGzoH0NROBiagBIs0jXSk9UNsCSFsn6+7HgjjxQ
	 FAKX3w93isl0DhZPuLAQk7RPBWmmw3QtE0SYETVu+JlmtF5TCcQz1XlasJ/tHJhl85
	 p7ZJNSZ6OfsMjY+PLEB6XwSBzbV9jyPGQRXMwHu+P7CnuF1tD8P5xM9oxDgSsZ0wRL
	 iINFXLWB+qeEw==
Date: Wed, 26 Mar 2025 10:14:19 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, jacky@yunsilicon.com,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
	kalesh-anakkur.purayil@broadcom.com, geert+renesas@glider.be,
	geert@linux-m68k.org
Subject: Re: [PATCH net-next v9 11/14] xsc: ndo_open and ndo_stop
Message-ID: <20250326101419.GZ892515@horms.kernel.org>
References: <20250318151449.1376756-1-tianx@yunsilicon.com>
 <20250318151515.1376756-12-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318151515.1376756-12-tianx@yunsilicon.com>

On Tue, Mar 18, 2025 at 11:15:16PM +0800, Xin Tian wrote:

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c

...

> +static int xsc_eth_open_rss_qp_rqs(struct xsc_adapter *adapter,
> +				   struct xsc_rq_param *prq_param,
> +				   struct xsc_eth_channels *chls,
> +				   unsigned int num_chl)
> +{
> +	u8 q_log_size = prq_param->rq_attr.q_log_size;
> +	struct xsc_create_multiqp_mbox_in *in;
> +	struct xsc_create_qp_request *req;
> +	unsigned int hw_npages;
> +	struct xsc_channel *c;
> +	int ret = 0, err = 0;
> +	struct xsc_rq *prq;
> +	int paslen = 0;
> +	int entry_len;
> +	u32 rqn_base;
> +	int i, j, n;
> +	int inlen;
> +
> +	for (i = 0; i < num_chl; i++) {
> +		c = &chls->c[i];
> +
> +		for (j = 0; j < c->qp.rq_num; j++) {
> +			prq = &c->qp.rq[j];
> +			ret = xsc_eth_alloc_rq(c, prq, prq_param);
> +			if (ret)
> +				goto err_alloc_rqs;
> +
> +			hw_npages = DIV_ROUND_UP(prq->wq_ctrl.buf.size,
> +						 PAGE_SIZE_4K);
> +			/*support different npages number smoothly*/
> +			entry_len = sizeof(struct xsc_create_qp_request) +
> +				sizeof(__be64) * hw_npages;

Hi Xin Tian,

Here entry_len is calculated for each entry of c->qp.rq, prq.
Based on prq->wq_ctrl.buf.size.

> +
> +			paslen += entry_len;
> +		}
> +	}
> +
> +	inlen = sizeof(struct xsc_create_multiqp_mbox_in) + paslen;
> +	in = kvzalloc(inlen, GFP_KERNEL);
> +	if (!in) {
> +		ret = -ENOMEM;
> +		goto err_create_rss_rqs;
> +	}
> +
> +	in->qp_num = cpu_to_be16(num_chl);
> +	in->qp_type = XSC_QUEUE_TYPE_RAW;
> +	in->req_len = cpu_to_be32(inlen);
> +
> +	req = (struct xsc_create_qp_request *)&in->data[0];
> +	n = 0;
> +	for (i = 0; i < num_chl; i++) {
> +		c = &chls->c[i];
> +		for (j = 0; j < c->qp.rq_num; j++) {
> +			prq = &c->qp.rq[j];
> +
> +			hw_npages = DIV_ROUND_UP(prq->wq_ctrl.buf.size,
> +						 PAGE_SIZE_4K);
> +			/* no use for eth */
> +			req->input_qpn = cpu_to_be16(0);
> +			req->qp_type = XSC_QUEUE_TYPE_RAW;
> +			req->log_rq_sz = ilog2(adapter->xdev->caps.recv_ds_num)
> +						+ q_log_size;
> +			req->pa_num = cpu_to_be16(hw_npages);
> +			req->cqn_recv = cpu_to_be16(prq->cq.xcq.cqn);
> +			req->cqn_send = req->cqn_recv;
> +			req->glb_funcid =
> +				cpu_to_be16(adapter->xdev->glb_func_id);
> +
> +			xsc_core_fill_page_frag_array(&prq->wq_ctrl.buf,
> +						      &req->pas[0],
> +						      hw_npages);
> +			n++;
> +			req = (struct xsc_create_qp_request *)
> +				(&in->data[0] + entry_len * n);

But here the value for the last entry of c->qp.rq for the last channel, in
chls->c[i], as determined by the previous for loop, is used for all entries
of c->qp.rq.

Is this correct?

Flagged by Smatch.

> +		}
> +	}
> +
> +	ret = xsc_core_eth_create_rss_qp_rqs(adapter->xdev, in, inlen,
> +					     &rqn_base);
> +	kvfree(in);
> +	if (ret)
> +		goto err_create_rss_rqs;
> +
> +	n = 0;
> +	for (i = 0; i < num_chl; i++) {
> +		c = &chls->c[i];
> +		for (j = 0; j < c->qp.rq_num; j++) {
> +			prq = &c->qp.rq[j];
> +			prq->rqn = rqn_base + n;
> +			prq->cqp.qpn = prq->rqn;
> +			prq->cqp.event = xsc_eth_qp_event;
> +			prq->cqp.eth_queue_type = XSC_RES_RQ;
> +			ret = xsc_core_create_resource_common(adapter->xdev,
> +							      &prq->cqp);
> +			if (ret) {
> +				err = ret;
> +				netdev_err(adapter->netdev,
> +					   "create resource common error qp:%d errno:%d\n",
> +					   prq->rqn, ret);
> +				continue;
> +			}
> +
> +			n++;
> +		}
> +	}
> +	if (err)
> +		return err;
> +
> +	adapter->channels.rqn_base = rqn_base;
> +	return 0;
> +
> +err_create_rss_rqs:
> +	i = num_chl;
> +err_alloc_rqs:
> +	for (--i; i >= 0; i--) {
> +		c = &chls->c[i];
> +		for (j = 0; j < c->qp.rq_num; j++) {
> +			prq = &c->qp.rq[j];
> +			xsc_free_qp_rq(prq);
> +		}
> +	}
> +	return ret;
> +}

