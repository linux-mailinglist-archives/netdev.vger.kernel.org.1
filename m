Return-Path: <netdev+bounces-291660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDPqMMZ6FWp8VgcAu9opvQ
	(envelope-from <netdev+bounces-291660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:49:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 433CE5D4638
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 469963028CB9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9846E3DD856;
	Tue, 26 May 2026 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZN0FtFXJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8pQOHMv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C513D16EA
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792580; cv=none; b=o9YkHyjEIjh5R2Po3T1bNqcdkmQXqlO4FfBBX4IawxG14t3kRxn+SLdRhuEj0MaCTdp0/Vc8DEfETM+1jrucFhLyeLdCuFgY8uaY25bla8o/ZD9DgOWdaVW1mKGvi1inOeBFSA1vSr/4zyLsdOUQhaWcqGktvVUVhbrU8YUr4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792580; c=relaxed/simple;
	bh=JQ5BrlLA7NRE52ecTfeDwXHuvHRkEmiz2LzsJBj9lv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGtXRx3W008ihSJzQoRJ6dQixMZykTUSBKKP4A4bFKZT0WlMfYG1EMQjC8rhRSUmlcYFKD7QiNtS/7tA7+mNgN7DHct0V7mlrFH+LfmlxgWHYuqUDcCvwf0A9pVZPmGZLc362c7bbiiBrc2iJ9bszkFQHrCOoqTIoRCMCiopngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZN0FtFXJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8pQOHMv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779792578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Xb91WiXPazwge7GQc97YpLKCGyGlIds3mAgEY7YBag=;
	b=ZN0FtFXJ707EpvevpD4F4MVJFq3N1lpJQEJcE14r2LbZWsc+F5m31heDt40GZ2IjFtp5IO
	5yQ+2iVZ64NOgLssFqRBb8UF5utS1eFgYuFbEkgFJ4+WsHEZt2oxM70atBBfuWIQpHfGuI
	P9Cyua7zJGNDr1I/nRIQt6IfbrWUbzE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-CD6b-n7NN1yrzEc3Ssi1QA-1; Tue, 26 May 2026 06:49:36 -0400
X-MC-Unique: CD6b-n7NN1yrzEc3Ssi1QA-1
X-Mimecast-MFC-AGG-ID: CD6b-n7NN1yrzEc3Ssi1QA_1779792575
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490479c2911so43953415e9.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779792575; x=1780397375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Xb91WiXPazwge7GQc97YpLKCGyGlIds3mAgEY7YBag=;
        b=V8pQOHMvGZvMPjcn8dU1zSLhridApTsW8NLudsCkBKUv4sycjzdiWk8m9ly1Lwq1wh
         EXr8hh0gwqCTntIy4sFULArqYMbOgEPuMmB9BOWirpgoaDZ1BZtQ0950qIHclUg/A2iH
         qAYM/8DPTjxaCBzf1FFbkix5yyy3efKVyNsfpUi8WXudTUDDyiOAtxeJBO2t1Y9pB/2X
         nqO1kI89mi30kK06azQar72rEb4E5u2yAzHmewQpLXWVdhE/IQ3Y8Ukzanr2HeSaLyWL
         ssOh/kpNmqGjHsP26ph2pDhN67FTYkRLW7N2mI2R/o7/YpfCvPO4YeiqCaZyN4YurQZi
         iO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792575; x=1780397375;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Xb91WiXPazwge7GQc97YpLKCGyGlIds3mAgEY7YBag=;
        b=gSnrhRDMV37RJBxID6ZbqKM0OdERYCed6I7ABV7ldhnRoh2JvxGWtM3rV2PifNZEVM
         yFtLBPcIjl59PqotqZOY2DCES7Pj0XgQR+VRlFiUCYRNRCu9povQFtPlsEJIQ/0P/wPi
         V5uC6bCcbZuLWAdK0cCz+7DyoKhKAV0TCMEEBkOQqC2DCu4G30hVVZjoD3PLQJb20l4d
         OnO6g76Yz5klXFr0aM8k6SaUdPeo3w0pj440bDi9VIH4fEpaRPSlU0MqwJTJ0sbeORQZ
         lNGyWGiwYJlDsCEDT3XsXdnLnqMx51PITVl/STmEZd0ZPY4S12SpXNr+7p1i/uwehfRi
         MlVg==
X-Forwarded-Encrypted: i=1; AFNElJ/M314qpfubkl8xcwX67fle8j4JDOZ6me/Wh5ArDllvvPDKimkBcfr2XM6pey8errKPCnr1t8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQrrhiyWAbGuHLO/db9rf7y1v1DYqXtEaPcwguZb30wFNkO8q
	UsYkaXz4iFk0Tp+p/8gav0plgvfwU7vsVW4ee+VzHP2AP7Kvz1oeT7uPLo6UA/79wxRgvmN+fM4
	G6eAbacAQca+RonXrW/PBlk2jcskYFIj5WVqKv4q4purXoj5SvHx6Y/1sRKRPrJtCkA==
X-Gm-Gg: Acq92OHYn7uXLqTVS3LilyshlVAq76xrUmB/lMErr+tzDpYjDMGg+qDXjvxf/OLOwGx
	GqCPp/vHcLYPK5cYUlkk1aeGVXHiQPrjRfNr8JkvSRhcw6RRC9jFaBGfc+O8M6fqUuhMhuWN/UM
	kusWk5kreqAob7TnOfS9QhrD5GkfPKiJyokQpK8yj0Bk4Fr3E6H0UaFcCgimfv6Hm9lTBPPVu5c
	jC01LFzYctwCpSvE7DCSqB3qTC4vkNbU6q2jeo/2YGYdioJAtgyaaONsSCJf1me838ZxBpDjShB
	6G4piTo24f2kanlGisaa7Yl3EXDMLkbrP8fWa4tHmzeBCxLA/yBBFaymXzt5Y0RDLAlm+BYCq1Q
	I9ZLv6vRhTNu7TklZ5Un/K7WXnwjBxhbHy9Fnw5LzEl3scBxCaUadUsvh1w==
X-Received: by 2002:a05:600c:8b12:b0:490:5191:6e1a with SMTP id 5b1f17b1804b1-490519170d7mr255826025e9.24.1779792575167;
        Tue, 26 May 2026 03:49:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8b12:b0:490:5191:6e1a with SMTP id 5b1f17b1804b1-490519170d7mr255825705e9.24.1779792574774;
        Tue, 26 May 2026 03:49:34 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904174a145sm148632185e9.0.2026.05.26.03.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 03:49:34 -0700 (PDT)
Message-ID: <e86545c6-d647-44c3-be72-5390a211b9d4@redhat.com>
Date: Tue, 26 May 2026 12:49:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: fix RX DMA leak on TX alloc failure
To: Abid Ali <dev.taqnialabs@gmail.com>,
 devnull+dev.taqnialabs.gmail.com@kernel.org
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org
References: <20260522-stmmac-rx-desc-cleanup-v2-1-76e78eb471e1@gmail.com>
 <20260523121708.564-1-dev.taqnialabs@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260523121708.564-1-dev.taqnialabs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291660-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dev.taqnialabs.gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 433CE5D4638
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/23/26 2:17 PM, Abid Ali wrote:
>> 	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
>> +	if (ret)
>> +		free_dma_rx_desc_resources(priv, dma_conf);
>>
>> 	return ret;
>> }
> 
> The sashiko-gemini analysis [1] flagged two issues.
> 
> 1) Double-free via XDP path:
> 
> stmmac_xdp_set_prog() ignores the return of stmmac_xdp_open(), so
> if alloc_dma_tx_desc_resources() fails inside that path,
> rx_q->buf_pool and rx_q->dma_rx are freed for Rx queues.
> 
> The interface stays UP, so a later stmmac_release() calls
> free_dma_desc_resources() on the same freed pointers.
> 
> Without this patch, the same failure path leaks RX resources
> instead. Either way the root cause seems to be stmmac_xdp_set_prog() not
> handling errors from stmmac_xdp_open().
> 
> The reported issue seems to be valid, but I'm not sure why XDP doesn't handle
> a possible error in reinit in the first place.
> 
> 2) NULL deref on partial queue alloc:
> 
> If alloc_dma_rx_desc_resources() fails for queue N,
> e.g. rx_q->page_pool = page_pool_create() fails, buf_pool is NULL.
> The cleanup free_dma_rx_desc_resources() iterates through all
> queues and will hit a NULL pointer deref in:
> 
> static void stmmac_free_rx_buffer(struct stmmac_priv *priv,
> 				  struct stmmac_rx_queue *rx_q,
> 				  int i)
> {
> 	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
> 
> The same could happen without the patch, and similar risk exists for
> rx_q->buf_pool, rx_q->dma_rx, and rx_q->dma_erx which are all freed
> without guards in __free_dma_rx_desc_resources().
> 
> I can add the necessary NULL guards in __free_dma_rx_desc_resources()
> for V3 if necessary.
My take is following: even if the sashiko reported issues are
pre-existing, they are so strictly tied to this code path that it makes
sense to address all of them together (different patches in the same
series).

Also all of the above looks like 'net' material, deserving fixes tag in
each patch.

/P


