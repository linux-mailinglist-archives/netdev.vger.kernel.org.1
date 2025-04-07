Return-Path: <netdev+bounces-179585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7638CA7DBC1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1AF3B6737
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F62376EC;
	Mon,  7 Apr 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="GANJAHfR"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-22.ptr.blmpb.com (sg-1-22.ptr.blmpb.com [118.26.132.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D623A58D
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023570; cv=none; b=A/F4XEFKahAnJfQ670F1rwQ9jIIk4rhgVrkHjyw7HdbmxyLXjIBi3KTxwuCbm5Lnmc80oCqNq8UQdfsexAOrgpKcuuXr2gqBwq+bHEd1tSpfXcHmRSBWUevSIeQHIK77sRQk35i9VcqW23OUoDe21B67MKRL6rm38gpAEEwOO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023570; c=relaxed/simple;
	bh=6sL2CZIXv+N44JAKimkqplUrhw0W/KlE6h5gtMjzmRE=;
	h=Cc:From:References:Mime-Version:Content-Type:To:Subject:Date:
	 In-Reply-To:Message-Id; b=hxq4GhmWq8S0bTif/qVMEiKxDfJeD73xukpjrtbyuzachfaBcWaZ1h/LyxWBOex0N6y4f6LVQi0HvGRGiZIFR2KSmubrDqHoqX6Nmh6yQZXkZt/cM9ekFStAvavEF7jyi8D6e9t8/h9p/Ef6SxCBvSkFe+tfAAt7aFF54CnV1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=GANJAHfR; arc=none smtp.client-ip=118.26.132.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744022655; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=q4zzdVxS0PlhMiMHvlZrIS6R/gRIJakLh3a233/nFKU=;
 b=GANJAHfRWESv2dPcICyNL2BNrFH5oLXP3eFk6fhZ8wrtaC3hIOvkxUITxoHybH4Jnno7MU
 R3jiDRTeTm1xfNy4wJgzuUSA/Muew6b0fO5bI96xixB4FW8BKALHhfvQw9j70g3z/mItAJ
 roZx/msMJCFtAZbwdtOd5aBj6BZZXu1tw5I90I9hLdFjdjF10OcN2LsqkQkA8+d7NsdnIi
 T1f7Ry/roPBiCItsSKk45Tdpu+eNY8dC4S8ACKTrpRC7jUrWpVQJRqC3JZPitwmNyZ38gN
 Lt48Bu498euFJAjIdSMb+IWfruQ1Jee8wD3/aLbX8XZMX6P2MpgDECdXfa09JQ==
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>, 
	<kalesh-anakkur.purayil@broadcom.com>, <geert+renesas@glider.be>, 
	<geert@linux-m68k.org>
From: "Xin Tian" <tianx@yunsilicon.com>
References: <20250318151449.1376756-1-tianx@yunsilicon.com> <20250318151515.1376756-12-tianx@yunsilicon.com> <20250326101419.GZ892515@horms.kernel.org>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Received: from [127.0.0.1] ([116.231.163.61]) by smtp.feishu.cn with ESMTPS; Mon, 07 Apr 2025 18:44:12 +0800
Content-Transfer-Encoding: 7bit
To: "Simon Horman" <horms@kernel.org>
Subject: Re: [PATCH net-next v9 11/14] xsc: ndo_open and ndo_stop
Date: Mon, 7 Apr 2025 18:44:17 +0800
In-Reply-To: <20250326101419.GZ892515@horms.kernel.org>
Message-Id: <93753d38-d924-43e4-ab42-1336b7d2e715@yunsilicon.com>
X-Lms-Return-Path: <lba+267f3ac7d+449300+vger.kernel.org+tianx@yunsilicon.com>

On 2025/3/26 18:14, Simon Horman wrote:
> On Tue, Mar 18, 2025 at 11:15:16PM +0800, Xin Tian wrote:
>
> ...
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
> ...
>
>> +static int xsc_eth_open_rss_qp_rqs(struct xsc_adapter *adapter,
>> +				   struct xsc_rq_param *prq_param,
>> +				   struct xsc_eth_channels *chls,
>> +				   unsigned int num_chl)
>> +{
>> +	u8 q_log_size = prq_param->rq_attr.q_log_size;
>> +	struct xsc_create_multiqp_mbox_in *in;
>> +	struct xsc_create_qp_request *req;
>> +	unsigned int hw_npages;
>> +	struct xsc_channel *c;
>> +	int ret = 0, err = 0;
>> +	struct xsc_rq *prq;
>> +	int paslen = 0;
>> +	int entry_len;
>> +	u32 rqn_base;
>> +	int i, j, n;
>> +	int inlen;
>> +
>> +	for (i = 0; i < num_chl; i++) {
>> +		c = &chls->c[i];
>> +
>> +		for (j = 0; j < c->qp.rq_num; j++) {
>> +			prq = &c->qp.rq[j];
>> +			ret = xsc_eth_alloc_rq(c, prq, prq_param);
>> +			if (ret)
>> +				goto err_alloc_rqs;
>> +
>> +			hw_npages = DIV_ROUND_UP(prq->wq_ctrl.buf.size,
>> +						 PAGE_SIZE_4K);
>> +			/*support different npages number smoothly*/
>> +			entry_len = sizeof(struct xsc_create_qp_request) +
>> +				sizeof(__be64) * hw_npages;
> Hi Xin Tian,
>
> Here entry_len is calculated for each entry of c->qp.rq, prq.
> Based on prq->wq_ctrl.buf.size.
>
>> +
>> +			paslen += entry_len;
>> +		}
>> +	}
>> +
>> +	inlen = sizeof(struct xsc_create_multiqp_mbox_in) + paslen;
>> +	in = kvzalloc(inlen, GFP_KERNEL);
>> +	if (!in) {
>> +		ret = -ENOMEM;
>> +		goto err_create_rss_rqs;
>> +	}
>> +
>> +	in->qp_num = cpu_to_be16(num_chl);
>> +	in->qp_type = XSC_QUEUE_TYPE_RAW;
>> +	in->req_len = cpu_to_be32(inlen);
>> +
>> +	req = (struct xsc_create_qp_request *)&in->data[0];
>> +	n = 0;
>> +	for (i = 0; i < num_chl; i++) {
>> +		c = &chls->c[i];
>> +		for (j = 0; j < c->qp.rq_num; j++) {
>> +			prq = &c->qp.rq[j];
>> +
>> +			hw_npages = DIV_ROUND_UP(prq->wq_ctrl.buf.size,
>> +						 PAGE_SIZE_4K);
>> +			/* no use for eth */
>> +			req->input_qpn = cpu_to_be16(0);
>> +			req->qp_type = XSC_QUEUE_TYPE_RAW;
>> +			req->log_rq_sz = ilog2(adapter->xdev->caps.recv_ds_num)
>> +						+ q_log_size;
>> +			req->pa_num = cpu_to_be16(hw_npages);
>> +			req->cqn_recv = cpu_to_be16(prq->cq.xcq.cqn);
>> +			req->cqn_send = req->cqn_recv;
>> +			req->glb_funcid =
>> +				cpu_to_be16(adapter->xdev->glb_func_id);
>> +
>> +			xsc_core_fill_page_frag_array(&prq->wq_ctrl.buf,
>> +						      &req->pas[0],
>> +						      hw_npages);
>> +			n++;
>> +			req = (struct xsc_create_qp_request *)
>> +				(&in->data[0] + entry_len * n);
> But here the value for the last entry of c->qp.rq for the last channel, in
> chls->c[i], as determined by the previous for loop, is used for all entries
> of c->qp.rq.
>
> Is this correct?
>
> Flagged by Smatch.

Thanks, Simon

The result is correct because we currently allocate the same buffer size 
for all RQs, but the logic is indeed flawed. I'll fix the code.

>> +		}
>> +	}
>> +
>> +	ret = xsc_core_eth_create_rss_qp_rqs(adapter->xdev, in, inlen,
>> +					     &rqn_base);
>> +	kvfree(in);
>> +	if (ret)
>> +		goto err_create_rss_rqs;
>> +
>> +	n = 0;
>> +	for (i = 0; i < num_chl; i++) {
>> +		c = &chls->c[i];
>> +		for (j = 0; j < c->qp.rq_num; j++) {
>> +			prq = &c->qp.rq[j];
>> +			prq->rqn = rqn_base + n;
>> +			prq->cqp.qpn = prq->rqn;
>> +			prq->cqp.event = xsc_eth_qp_event;
>> +			prq->cqp.eth_queue_type = XSC_RES_RQ;
>> +			ret = xsc_core_create_resource_common(adapter->xdev,
>> +							      &prq->cqp);
>> +			if (ret) {
>> +				err = ret;
>> +				netdev_err(adapter->netdev,
>> +					   "create resource common error qp:%d errno:%d\n",
>> +					   prq->rqn, ret);
>> +				continue;
>> +			}
>> +
>> +			n++;
>> +		}
>> +	}
>> +	if (err)
>> +		return err;
>> +
>> +	adapter->channels.rqn_base = rqn_base;
>> +	return 0;
>> +
>> +err_create_rss_rqs:
>> +	i = num_chl;
>> +err_alloc_rqs:
>> +	for (--i; i >= 0; i--) {
>> +		c = &chls->c[i];
>> +		for (j = 0; j < c->qp.rq_num; j++) {
>> +			prq = &c->qp.rq[j];
>> +			xsc_free_qp_rq(prq);
>> +		}
>> +	}
>> +	return ret;
>> +}

