Return-Path: <netdev+bounces-290312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOlgKf/ODmq7CQYAu9opvQ
	(envelope-from <netdev+bounces-290312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:23:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB845A23ED
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 630EC30170B8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC26370AD6;
	Thu, 21 May 2026 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KizWIuuc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318236C9EE
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355030; cv=none; b=h6f9bwA4WQoMfjyRgtsHaNc4RfCD7/N8FwqSb3GPqaRqQitUIweRdV2aIENb7Y4FjWGwohRLFueBGEsHXLRZkZAqOMkC+xzAilmlZ/yLtvbJiU0SJhxkE2QfJyHRn0874C3rCrJELFyki3LBdQLODhoTv1vp0SNY+AFf+JRlYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355030; c=relaxed/simple;
	bh=e4E9ApxuKnHL6gEt0l9i18QERzbyiDlwx9esv+XQqcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l06kimMI6RzsohvUqgmMaWIqL/9M/JkiPk2iIOWHyrhpqpi2bROsaz3lt77WsIUF52g+ekYeo+090bLswQXHlJOMZ3whqmHBEbCt0o909bOMeVX+Lj0ne8aI23B0C7spZVGIyg4bCB1eLX61z6zTikPqpFi4Y7phmGEbVfnsy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KizWIuuc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779355027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZC77d7mSmvyQZQpaB0KYORR6eKaPrKgUruY5Qci0Z8=;
	b=KizWIuucBPGBntbVAYCZVmq6I79Fl+X5wsTm0FGTm1c3PHKNx+MixZ/j4wXqmt9KB4IQaS
	sg8AU7oONZPOBEq7tGsQACIjqFU5xsPGbERE4ihy/RFSiUeIb+kDHPXpd3tHe9VK/mm0cX
	hX0VcLGWhhFc8PT77S+Ti6eal3o6hHQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-Rzjuf-hSPqeW_WHY5-Q7hg-1; Thu,
 21 May 2026 05:17:01 -0400
X-MC-Unique: Rzjuf-hSPqeW_WHY5-Q7hg-1
X-Mimecast-MFC-AGG-ID: Rzjuf-hSPqeW_WHY5-Q7hg_1779355018
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC2FD1956096;
	Thu, 21 May 2026 09:16:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.233])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 840DD1800347;
	Thu, 21 May 2026 09:16:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: akiyano@amazon.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	dwmw2@infradead.org,
	tglx@linutronix.de,
	mlichvar@redhat.com,
	andrew+netdev@lunn.ch,
	guwen@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	dwmw@amazon.com,
	ysarna@amazon.com,
	zorik@amazon.com,
	matua@amazon.com,
	saeedb@amazon.com,
	msw@amazon.com,
	aliguori@amazon.com,
	nafea@amazon.com,
	evgenys@amazon.com,
	netanel@amazon.com,
	alisaidi@amazon.com,
	benh@amazon.com,
	ndagan@amazon.com,
	darinzon@amazon.com,
	evostrov@amazon.com,
	ofirt@amazon.com,
	amitbern@amazon.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH v3 net-next 6/7] net: ena: Add error bound to PHC communication layer
Date: Thu, 21 May 2026 11:16:32 +0200
Message-ID: <20260521091644.84928-1-pabeni@redhat.com>
In-Reply-To: <20260515164033.6403-7-akiyano@amazon.com>
References: <20260515164033.6403-7-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,amazon.com,linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290312-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33]
X-Rspamd-Queue-Id: 4AB845A23ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: ena: Add error bound to PHC communication layer

This commit extends the ENA PHC communication layer to retrieve an
error_bound value from the device alongside the timestamp, and adds a
phc_err_eb statistic to count error_bound retrieval failures.

> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> index 257910460bd8..832c4c1d0e5e 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c

[ ... ]

> @@ -1882,14 +1888,15 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
>  		}
>  
>  		/* req_id was updated by the device which indicates that
> -		 * PHC timestamp and error_flags are updated too,
> -		 * checking errors before retrieving timestamp
> +		 * PHC timestamp, error_bound and error_flags are updated too,
> +		 * checking error flags before retrieving timestamp and
> +		 * error_bound values
>  		 */
>  		if (unlikely(resp->error_flags & ENA_PHC_ERROR_FLAGS)) {

[High]

Once req_id is observed equal to phc->req_id, the function reads
resp->error_flags, resp->timestamp and (now) resp->error_bound from the
device-shared DMA buffer. The updated comment explicitly states that once
req_id is observed updated, "PHC timestamp, error_bound and error_flags
are updated too" — which is the producer/consumer pattern that normally
requires a read barrier between the index check and the dependent data
loads.

The buffer is declared volatile and the req_id check uses READ_ONCE(),
but on weakly-ordered architectures such as arm64 (which includes AWS
Graviton, a primary ENA deployment target) neither volatile nor
READ_ONCE() orders dependent loads against DMA writes from the device.
Without a dma_rmb() the CPU may observe the new req_id while still
returning stale or torn values for the 64-bit timestamp, the error_bound,
or the error_flags.

Could a dma_rmb() be added between the req_id check and the subsequent
reads of resp->error_flags / resp->timestamp / resp->error_bound, similar
to the pattern already used elsewhere in the same driver?

For example, ena_com_handle_admin_completion() in the same file does:

	/* Do not read the rest of the completion entry before the
	 * phase bit was validated
	 */
	dma_rmb();

and ena_com_aenq_intr_handler() has:

	/* Make sure the phase bit (ownership) is as expected before
	 * reading the rest of the descriptor.
	 */
	dma_rmb();

The same shape applies here: device writes data fields, then writes
req_id last; driver checks req_id, then reads data fields.

This ordering issue is not introduced by this patch — the timestamp and
error_flags reads after the req_id check existed before — but the patch
extends the same unsynchronized read pattern to a third field
(error_bound) and the new comment now documents the assumed ordering
that is not actually enforced. Would it make sense to address the missing
dma_rmb() while touching this code?

>  			/* Retrieved invalid PHC timestamp, PHC enters into

[ ... ]

> @@ -1897,12 +1904,15 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
>  
>  		/* PHC timestamp value is returned to the caller */
>  		*timestamp = resp->timestamp;
> +		if (error_bound)
> +			*error_bound = resp->error_bound;
>  
>  		/* Update statistic on valid PHC timestamp retrieval */
>  		phc->stats.phc_cnt++;

[ ... ]
-- 
This is an AI-generated review.


