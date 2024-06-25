Return-Path: <netdev+bounces-106676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E95C6917341
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7659AB2478A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7F217E447;
	Tue, 25 Jun 2024 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Q55TxjVF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F017DE32
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350319; cv=none; b=Ol6UIBqhKQowYsMsnZx4pnLPs4aEVraaPrMiiADeA/N5aOgWhLs6ZKyXOeYvByA/em4iuamj1E8NU6Vt1q0yk7fpf0TDjQe5YD3Cni7hyF2RteXdBuDCRRrBorWoyjvgZjcqLkv5EbBt9rpUaTb3WvJbr6eTbsTDRKYQs9wXfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350319; c=relaxed/simple;
	bh=kxA6NnpFHQwSELnxv0oMHhwVHSYVIIUu9R9ZhSreu3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjAkZ2zsKSK22aX7OIp5BCl20nwolI6NYDWKDg82/BJR81opOmA7jme4WqQj+DWx86xGvzt9be+EnpHUlr8H6UX9/KT4U0Ab0MHxDvG7YLnvI0OdHREUIBrgxMGFMlxfxm+Tzpm94p6l95hQqt0a53Eg0DrOWCmAMv0NjbNXcnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Q55TxjVF; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-80d64c817a7so1732350241.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1719350317; x=1719955117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cM5xSkNvWbTRl0y0pR9aKmtKBGEwZkaWxbDZYlEW64=;
        b=Q55TxjVF9oRZLeTHcAoyvnjJ9TrinGOjk6wJnCizCRW9bnrSyDGGmjswlIeekP7WQl
         /jfnyUUYjjvwO7eYalg4VnpL79x6od5jesiY/6KiLhDzlC62NAGP6bqAQKGIOvwYA8zh
         5nbzAAigiZkfWze61ZYVXwyiSRiafMyMZ3vrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719350317; x=1719955117;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cM5xSkNvWbTRl0y0pR9aKmtKBGEwZkaWxbDZYlEW64=;
        b=xReMNdpWbF6WL5rDmBr89gnowUHh8uCGWqIBA7fvCMuJAme3A1n6z6WE0ClYfHe8ZB
         Wzzu+qiVevkyuITcxh2l6jW7RivEs7IPTjdAFf3rY1H9NFsfWhcBCzIG8xt5sImWXQv/
         ipzpEguLEDoiownWwcrufd/FDqzQrmwW1+kRObFXGkIHCJlVNp6Iq+Uts2qlIph/t+Ig
         VCA2A1jTgnlsG5Du4SCEiWVx5QHIv/UrShakp12F+TBaw6LbakTYmnu67GD/uGF3+5KH
         uS8lauP7NjpuAlfGKq1mJ4U+24cgqBL8+3z+xt5Hz9U/I7wGWLvrB5eRA6Gp4YjC2Af3
         JCEw==
X-Gm-Message-State: AOJu0Yzqd/3PCW580QJ752lV1w3boyyxj4EkKgpI5SLG+J1W5Rd5t5Zs
	kwT/92Pmct2TBsY0C++if9YHytFefD2B90xDhHHgvZldaK/cK7iQ5tz68tCet8w=
X-Google-Smtp-Source: AGHT+IEsunHMrT8jdRYAeIDGdAWrttYLEawllAiALJOZ3Eh/9hDFCTqwTuH2Mool4duoUZp7NKkrxw==
X-Received: by 2002:a05:6122:411d:b0:4e4:eda9:ec32 with SMTP id 71dfb90a1353d-4ef6d88e925mr6947160e0c.10.1719350316732;
        Tue, 25 Jun 2024 14:18:36 -0700 (PDT)
Received: from LQ3V64L9R2 ([208.64.28.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef30e6fsm48393076d6.84.2024.06.25.14.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:18:36 -0700 (PDT)
Date: Tue, 25 Jun 2024 17:18:34 -0400
From: Joe Damato <jdamato@fastly.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH v2 07/15] eth: fbnic: Allocate a netdevice and
 napi vectors with queues
Message-ID: <Zns0Kjv02mjC-6oU@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
 <171932616332.3072535.5928220031237925415.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171932616332.3072535.5928220031237925415.stgit@ahduyck-xeon-server.home.arpa>

On Tue, Jun 25, 2024 at 07:36:03AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>

[...]

> +int fbnic_alloc_napi_vectors(struct fbnic_net *fbn)
> +{
> +	unsigned int txq_idx = 0, rxq_idx = 0, v_idx = FBNIC_NON_NAPI_VECTORS;
> +	unsigned int num_tx = fbn->num_tx_queues;
> +	unsigned int num_rx = fbn->num_rx_queues;
> +	unsigned int num_napi = fbn->num_napi;
> +	struct fbnic_dev *fbd = fbn->fbd;
> +	int err;
> +
> +	/* Allocate 1 Tx queue per napi vector */
> +	if (num_napi < FBNIC_MAX_TXQS && num_napi == num_tx + num_rx) {
> +		while (num_tx) {
> +			err = fbnic_alloc_napi_vector(fbd, fbn,
> +						      num_napi, v_idx,
> +						      1, txq_idx, 0, 0);
> +			if (err)
> +				goto free_vectors;
> +
> +			/* Update counts and index */
> +			num_tx--;
> +			txq_idx++;
> +
> +			v_idx++;
> +		}
> +	}
> +
> +	/* Allocate Tx/Rx queue pairs per vector, or allocate remaining Rx */
> +	while (num_rx | num_tx) {
> +		int tqpv = DIV_ROUND_UP(num_tx, num_napi - txq_idx);
> +		int rqpv = DIV_ROUND_UP(num_rx, num_napi - rxq_idx);
> +
> +		err = fbnic_alloc_napi_vector(fbd, fbn, num_napi, v_idx,
> +					      tqpv, txq_idx, rqpv, rxq_idx);

Mostly a nit / suggestion (and not a reason to hold this back): In
the future, adding support for netif_queue_set_napi would be great,
as would netif_napi_set_irq.

Apologies if you've already added that in a future patch that I
missed.

