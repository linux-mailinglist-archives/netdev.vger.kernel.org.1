Return-Path: <netdev+bounces-267038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOK7BP6usmlGOwAAu9opvQ
	(envelope-from <netdev+bounces-267038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:18:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA942718E3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D58D30713E2
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB403B9DB9;
	Thu, 12 Mar 2026 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/TL+ZzM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V439FLrF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06163BC67F
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317653; cv=none; b=Goutr3+Z/16s1Dlqh2vXwju81I7jBsWc7tQdcUtihil9mZzixToLdUmHByX4ru2hZrSvZnwFf4O5APMkOguPDtgOaQaOc6+5RGzMjZt3Xwceeh0kUG3DS39FboArof3zfVdqTk9Y9AMc9TECkCKQil4QEBKoJR4h8+v0PErwi3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317653; c=relaxed/simple;
	bh=/5WC4DtB+P33LkUFjXpc3RwWaJ5s/itNh44N3ZhlLkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oi7T1Ol7AX6OuNDINcdGeg2Wuw/QVgUPOY1y73dXuQ8TwUws76rhaltuBcfmu0DEstClpp0bpywqaSxXC2PRoVhFZ/+4n15g07vB2uea3VvgkE4h8uL+wZN4CPao5k1FhBapjzOw0fcSG6PPAzxSP50e8WmTcp5P6DCO9z7GSZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/TL+ZzM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V439FLrF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773317648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxIY7QiuvILNkB7fWkebqkMSgc5l1psPdBFz/v32Yew=;
	b=O/TL+ZzM0fGUbmMxCPz3eHEuMqUdoXtWOGlWIjGpUzbUVCCbDU9JmSV75wlQ202ou8CruN
	GoovoE5vAndgbdBFRoyrc12dZxb+NYLbDSfoBjFXce7kiKLfCtMPRGWOqX0Y4fnrkbMbWb
	fwxRbq7yV4qCK3hpnNp9lA5f3Wk0H68=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-JzswaUQcM2GpJqif2vZzQg-1; Thu, 12 Mar 2026 08:14:07 -0400
X-MC-Unique: JzswaUQcM2GpJqif2vZzQg-1
X-Mimecast-MFC-AGG-ID: JzswaUQcM2GpJqif2vZzQg_1773317646
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4853b0af42aso12173295e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773317646; x=1773922446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxIY7QiuvILNkB7fWkebqkMSgc5l1psPdBFz/v32Yew=;
        b=V439FLrF8XBBlE3vLcl9B30V43O9fpcc9HlRhVEHpJkLHyXndCq04XxaMpboT6GZgc
         d5CyYhQcpllHE1hlTnABB+KDZhjDKZJN4LLqRSmyH5xeDr2MeTrIYL/4xSi/OKkG4vuQ
         X/NtIoBLkc+3FfA+3L32vbk8A6fc1JEPfn4fuETi643WVEI/9j+sBME6LS6Q8A//x9Yd
         lg3NOGVwEpXHtCbkteMauOnl+q51dAjidR3x1TZS1S2FFupkHzcqp43mHZ2sghP0y7Q5
         vN3uAUFowZBljocKKYMQvaaZ6th/+kSOJImVIw1riTwQJNdWCW+5o2z6P9SDv8Yn+60C
         uPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317646; x=1773922446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxIY7QiuvILNkB7fWkebqkMSgc5l1psPdBFz/v32Yew=;
        b=LZc7KXF0gkgzMnIQyACD+wPGcwBVWFvdZU4bFgkaA2cTrkQh/qK/zW0Al272CJTcim
         6Bq8jtwE6GjJSXy+5iYd8GF9/8dyuXXsPdgvDOq4sXV2RjIhVfZl/vAGsTjPZ81QpUB4
         luBc+CkA+Vdp+Ov1seEtVg2/TfjO7ryexgrowoVBRsT9lF0S4q3N/PHIkAlUdMP3zajQ
         BXHcamtmdyKTwLhbANid1WlCuZ2JAozP1O8Xc01lfx68wqmqynt/YaX+cxtiQRGjbjZK
         H3DZKzx2prI34AXRt0PKtwqIVtA39pPFW5IAJZ29PXVpTEYe5QOPJUe2ig5K9Xyyx3pR
         cA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdQURMb2yC5lpYdVRBonQpNEDeTQ87+qfRsXq8pYPxHkG5oHg49mufifxUG/GoKbwPKEwBY7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoefTwOCZWvMGLitE0tYAjiVAuT0uINHfP7y+oi2MZ8NCZvxU
	EfNTLatQ1fVydrTNYxN35dKTqcs4PrUUwvwjoMLsjbmfJf9484IveeYAgDhrL/rQvHHf2jsenXy
	i4DiomcG4pHcag8qJnW0X37eWvAhMkZWvYJUTxHTwpiLXr+OpeVm5aDW5EA==
X-Gm-Gg: ATEYQzwXZcB/5r1d1jDC1YAqsLmHQRRR3wk2ODqqF/POrBwiiAOj84JypiN6pQ8m+3M
	wF9ztvX3SZ588QoeymuZKQkrJG9CPChJ6AOwQhgx8bygus+Zo3Ht26LXm3JVsAT7wGD6kJR3unp
	ybjkBf9ztwwDogKp2JSGuHk7IP3kEsXs1w/j9ERwkN0AJ1xIBxUE76Z3fKPpQX4mwMuv82mTxDn
	GcgqEuD2SN9BD6NBI8IC/QLpuwKCYmT5mbNdQawVbMm3RApgCEp4RFxlK5tN8WEpxMUgafakRWs
	HvahQZg3e9O2R+hiZRWjjMBVgGubBTCBtygVtwaEdwTKJhrmS2TKStxOpzZMXtZK6pe81rr0nd8
	/gc4caHm+CoUK7Ne4TJn9vAwBOrwoq9TUEScEs74bbhs7dTV7hrmo/Lc=
X-Received: by 2002:a05:600c:46d3:b0:485:35ba:1d8a with SMTP id 5b1f17b1804b1-4854b111768mr102221125e9.27.1773317645548;
        Thu, 12 Mar 2026 05:14:05 -0700 (PDT)
X-Received: by 2002:a05:600c:46d3:b0:485:35ba:1d8a with SMTP id 5b1f17b1804b1-4854b111768mr102220745e9.27.1773317645070;
        Thu, 12 Mar 2026 05:14:05 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541acea11sm257299255e9.7.2026.03.12.05.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 05:14:04 -0700 (PDT)
Message-ID: <a4a6ae7d-fdab-4533-b56a-af9425bc2bb1@redhat.com>
Date: Thu, 12 Mar 2026 13:14:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 10/11] net/nebula-matrix: add common/ctrl dev
 init/reinit operation
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, edumazet@google.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260310120959.22015-1-illusion.wang@nebula-matrix.com>
 <20260310120959.22015-11-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260310120959.22015-11-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267038-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[illusion.wang:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AA942718E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 1:09 PM, illusion.wang wrote:
> +/* ----------  Dev init process  ---------- */
> +static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter,
> +				    struct nbl_init_param *param)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	struct nbl_dispatch_mgt *priv = dev_mgt->disp_ops_tbl->priv;
> +	struct nbl_common_info *common = dev_mgt->common;
> +	struct nbl_dev_common *common_dev;
> +	int ret;
> +
> +	common_dev = devm_kzalloc(&adapter->pdev->dev,
> +				  sizeof(struct nbl_dev_common), GFP_KERNEL);
> +	if (!common_dev)
> +		return -ENOMEM;
> +	common_dev->dev_mgt = dev_mgt;
> +
> +	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	if (ret)
> +		return ret;
> +
> +	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
> +	common->vsi_id = disp_ops->get_vsi_id(priv, 0, NBL_VSI_DATA);
> +	disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_mode,
> +			     &common->eth_id, &common->logic_eth_id);
> +
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
> +				   &common_dev->clean_mbx_task);
> +
> +	dev_mgt->common_dev = common_dev;
> +	nbl_dev_init_msix_cnt(dev_mgt);
> +	return 0;
> +}

AI review says:

Is the 'param' parameter actually needed here? The function signature
declares it but never references it anywhere in the body. All the data
comes from 'adapter' and its sub-structures.

> +static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter,
> +				  struct nbl_init_param *param)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	int i, ret;
> +
> +	ret = disp_ops->init_chip_module(dev_mgt->disp_ops_tbl->priv);
> +	if (ret)
> +		goto chip_init_fail;
> +
> +	for (i = 0; i < NBL_CHAN_TYPE_MAX; i++) {
> +		ret = nbl_dev_setup_chan_qinfo(dev_mgt, i);
> +		if (ret)
> +			goto setup_chan_q_fail;
> +	}
> +
> +	return 0;
> +setup_chan_q_fail:
> +	disp_ops->deinit_chip_module(dev_mgt->disp_ops_tbl->priv);
> +chip_init_fail:
> +	return ret;
> +}

The 'param' parameter is also unused in this function. This will produce
-Wunused-parameter warnings when compiled with W=1.

/P


