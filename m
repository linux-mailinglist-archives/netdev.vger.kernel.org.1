Return-Path: <netdev+bounces-290620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD2qBa98D2rLMgYAu9opvQ
	(envelope-from <netdev+bounces-290620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:44:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 097B75AC2C0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D86663003735
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BD33A599A;
	Thu, 21 May 2026 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="acuUPtA3"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF4399D0C;
	Thu, 21 May 2026 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779399849; cv=none; b=mZdnOj0AbOX+0l8HtFhiSyMMqdtqb59wzJGtrfVmAJJ2G0PmoDZEdsaStqlAXKtD7KkOsohMT0JefAQfcMcTwUCdqmOHPvMxdRkwtWn6gs9o7fUIBTD4QGnRpx4HKqXbZ5HxqLJmrbU10vnHaodzQcnWjoC0Lo5E1Gjw2ZKEeNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779399849; c=relaxed/simple;
	bh=l2kQofxf3ROmaHwn0+2CfVH4nvcngDxzJOCHXC6eXcc=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=Tx1eXQvHYsJmJwMp83NNcy4otUn9KSBmi5vBOY5a9DHCgL+1Je7V7ygxByy5Yksq/G5sCnZlC8WBSpsFm+Hwe8+BluuesRabnnE+iBxaSf2u46K7H3KzNBGqW3EeFeGsmBmidrrcLzdYAd7sZF/dCb7B9VtYP2yOriL0Vknqh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=acuUPtA3; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779399848; x=1810935848;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=HNyHVCCSw5AAVJ5Et5IF+MrFWuKWxqHXWbInDs0oIqU=;
  b=acuUPtA3QJFqpPvIPQ3JiVa2RMuMse/1Se10XGOxG+1thPlSqxjLGz7D
   oyhrq/DBHQ1UUE21+wODYRCYIujMYv6OAmivJfo8MZt6jsT2OgpkiTNoi
   J0llr0gO5g0Itp6E22yNnaDDma8oqh6lEsaSYKNyy9g03wSdkgpL28izg
   6ScEApAPND/U1QU0KXIdFilF28NNLNNogPlO86WTSUshJDJiOOcOeI0kb
   NFEulAIZg9jl/imryv+gP4eN3nTC8Lsk+z51dTR5f26xpcvx+Rz+gxGHh
   wUd2QMlMIAmVVIDXhbkwEZbfp+Cjmfjz5qD2XRoYmKP6vG820ISpxeKJL
   A==;
X-CSE-ConnectionGUID: 6HgviaSbQgO0EQAvLcYpaw==
X-CSE-MsgGUID: vKX6RcIrTdeQfmzSEp5JJQ==
X-IronPort-AV: E=Sophos;i="6.24,161,1774310400"; 
   d="scan'208";a="20026277"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:44:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:24928]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.243:2525] with esmtp (Farcaster)
 id ca1f3ea2-bc5b-4a46-adc2-88b2358ddd55; Thu, 21 May 2026 21:44:04 +0000 (UTC)
X-Farcaster-Flow-ID: ca1f3ea2-bc5b-4a46-adc2-88b2358ddd55
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 21 May 2026 21:44:03 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 21 May 2026 21:43:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 6/7] net: ena: Add error bound to PHC
 communication layer
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <akiyano@amazon.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <richardcochran@gmail.com>, <edumazet@google.com>,
	<dwmw2@infradead.org>, <tglx@linutronix.de>, <mlichvar@redhat.com>,
	<andrew+netdev@lunn.ch>, <guwen@linux.alibaba.com>,
	<xuanzhuo@linux.alibaba.com>, <dwmw@amazon.com>, <ysarna@amazon.com>,
	<zorik@amazon.com>, <matua@amazon.com>, <saeedb@amazon.com>,
	<msw@amazon.com>, <aliguori@amazon.com>, <nafea@amazon.com>,
	<evgenys@amazon.com>, <netanel@amazon.com>, <alisaidi@amazon.com>,
	<benh@amazon.com>, <ndagan@amazon.com>, <darinzon@amazon.com>,
	<evostrov@amazon.com>, <ofirt@amazon.com>, <amitbern@amazon.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
	<vadim.fedorenko@linux.dev>
In-Reply-To: <20260521091644.84928-1-pabeni@redhat.com>
References: <20260515164033.6403-7-akiyano@amazon.com>
 <20260521091644.84928-1-pabeni@redhat.com>
Date: Thu, 21 May 2026 21:43:51 +0000
Message-ID: <177939983124.4614.11659392626049369289.b4-reply@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290620-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[amazon.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,google.com,infradead.org,linutronix.de,redhat.com,lunn.ch,linux.alibaba.com,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 097B75AC2C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-21 11:16:32+02:00, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net: ena: Add error bound to PHC communication layer
> 
> This commit extends the ENA PHC communication layer to retrieve an
> error_bound value from the device alongside the timestamp, and adds a
> phc_err_eb statistic to count error_bound retrieval failures.
> 
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> > index 257910460bd8..832c4c1d0e5e 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> 
> [ ... ]
> 
> > @@ -1882,14 +1888,15 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
> >  		}
> >  
> >  		/* req_id was updated by the device which indicates that
> > -		 * PHC timestamp and error_flags are updated too,
> > -		 * checking errors before retrieving timestamp
> > +		 * PHC timestamp, error_bound and error_flags are updated too,
> > +		 * checking error flags before retrieving timestamp and
> > +		 * error_bound values
> >  		 */
> >  		if (unlikely(resp->error_flags & ENA_PHC_ERROR_FLAGS)) {
> 
> [High]
> 
> Once req_id is observed equal to phc->req_id, the function reads
> resp->error_flags, resp->timestamp and (now) resp->error_bound from the
> device-shared DMA buffer. The updated comment explicitly states that once
> req_id is observed updated, "PHC timestamp, error_bound and error_flags
> are updated too" — which is the producer/consumer pattern that normally
> requires a read barrier between the index check and the dependent data
> loads.
> 
> The buffer is declared volatile and the req_id check uses READ_ONCE(),
> but on weakly-ordered architectures such as arm64 (which includes AWS
> Graviton, a primary ENA deployment target) neither volatile nor
> READ_ONCE() orders dependent loads against DMA writes from the device.
> Without a dma_rmb() the CPU may observe the new req_id while still
> returning stale or torn values for the 64-bit timestamp, the error_bound,
> or the error_flags.
> 
> Could a dma_rmb() be added between the req_id check and the subsequent
> reads of resp->error_flags / resp->timestamp / resp->error_bound, similar
> to the pattern already used elsewhere in the same driver?
> 
> For example, ena_com_handle_admin_completion() in the same file does:
> 
> 	/* Do not read the rest of the completion entry before the
> 	 * phase bit was validated
> 	 */
> 	dma_rmb();
> 
> and ena_com_aenq_intr_handler() has:
> 
> 	/* Make sure the phase bit (ownership) is as expected before
> 	 * reading the rest of the descriptor.
> 	 */
> 	dma_rmb();
> 
> The same shape applies here: device writes data fields, then writes
> req_id last; driver checks req_id, then reads data fields.
> 
> This ordering issue is not introduced by this patch — the timestamp and
> error_flags reads after the req_id check existed before — but the patch
> extends the same unsynchronized read pattern to a third field
> (error_bound) and the new comment now documents the assumed ordering
> that is not actually enforced. Would it make sense to address the missing
> dma_rmb() while touching this code?
> 
> >  			/* Retrieved invalid PHC timestamp, PHC enters into
> 
> [ ... ]
> 
> > @@ -1897,12 +1904,15 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
> >  
> >  		/* PHC timestamp value is returned to the caller */
> >  		*timestamp = resp->timestamp;
> > +		if (error_bound)
> > +			*error_bound = resp->error_bound;
> >  
> >  		/* Update statistic on valid PHC timestamp retrieval */
> >  		phc->stats.phc_cnt++;
> 
> [ ... ]

Thanks Paolo. Noted, we'll look into addressing this.


