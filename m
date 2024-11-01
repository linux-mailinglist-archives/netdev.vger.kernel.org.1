Return-Path: <netdev+bounces-141018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A47F9B91DA
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C7C1F231A3
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0084A15F40B;
	Fri,  1 Nov 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeP8CHfs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632A4174A
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467222; cv=none; b=IFNoUNlQvCBhx0BEcwnPT22ixHB9GrRDiuLaMmVZJPp11xMiN7afXnTwzd7Ieds0uZIDGfaXheTz/8BewN7VtwSwsrp4jWojGpw3w8H0vJ0cnFRmClsHGP8JOU2vGbHdAcFfmbLySAzLLVuh65VANy4puWljsXXr1Xu/EBaQsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467222; c=relaxed/simple;
	bh=Ib8c0+yuO2W2Ly0kNs6PCZE+6yi5m+yTERQ1KrasL38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kVHLtDkXy92/6TmeZb+3cxFVyOVbQJ64eRZCk02iYxRAoLwkkrNMjTrSA9XrKT+kP4DSjjEpqVadG8PQVQFog7VZXSNisu+kPBFT+gxQVofY6Ca/uoNfTPzj2o/Zgt3NgUd3KB5iEVtxPLeARHUD9zxlXQ0ZjTfbTH8vir088UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeP8CHfs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730467220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib8c0+yuO2W2Ly0kNs6PCZE+6yi5m+yTERQ1KrasL38=;
	b=UeP8CHfsqcotZPPLvKPPdKM5UVRjgHqfOW1Sq2sB1CHTjCKzer6M5De8RXqzYQsfcMgFQS
	eTnWi52hfpUg8Ojbva3+FWY34byu5V8115sjq2zW2dD9WfRQUhNkuW/IV/8+RaQpNKrphT
	l3M9EkWy+JQctJbbyo7BVJCJnqkYMTM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-BS39ggPLM8eBOtNBOTXe4A-1; Fri, 01 Nov 2024 09:20:18 -0400
X-MC-Unique: BS39ggPLM8eBOtNBOTXe4A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5cb81481a4bso1403117a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 06:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467218; x=1731072018;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ib8c0+yuO2W2Ly0kNs6PCZE+6yi5m+yTERQ1KrasL38=;
        b=FMObgD052A/k4pmkFyZiSvoRgvvMTjhhh2k9EUPx0HWYcOCjlKhMOOXAQ2W5+i4c0M
         /rFPO0LSxOOXz3hAlw4jtkoAHi7CDzZA7O3ZEqD5D6evue7U7MLesqvi0fxRS2MejlE7
         9PNNoe68VPxzCYbW9FuIsu0GrZkIaeKoRwZ5VzbbcdYxOU5aSLGh0kFcvJqoYrO7EJwi
         1eIK2ip0T0a+JUM2N9e+G7aKU+qj/dHoFQ+5I/j+WuPzMiCG3KWleI0BJIll3gcsDBYT
         iAKNJ5u2HzApVCRhHTB0fyiMsRjpkaaApCDzDd1MsvL7UKmqwnCJG//iSG6XJ7Ky/mYL
         5FmA==
X-Forwarded-Encrypted: i=1; AJvYcCUMzvqISTWEU3hlYnYjECcRNSX34lR36iCFq1XsGprV1TzgqYMvUnPNp1dq2sdEbacw/R5eb2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ8JAptbB0jwH/6T9C6h2Q9zqx04NVGLQnCnWYbZ6COFPEo9Qx
	tGDZ81LZ90uMsr4TqB2Qg+58JymyeO5DrJyjSaYwpIxokPu8GvVlMWenxMQSKB6zh1V7AGrJtQZ
	lG/I1QMLw4p0fzf5zksFGljThvrO5NJHrVFZboS+IY9+fGfU5x5SpIA==
X-Received: by 2002:a05:6402:1ed5:b0:5cb:6ca4:f4cd with SMTP id 4fb4d7f45d1cf-5cbbf8796ddmr18547519a12.7.1730467217652;
        Fri, 01 Nov 2024 06:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn2LPy1gUSuHKruS07GtqCmqVzlHOCD3B7tPcLNUXMz/VgPBnOw/2+LoemulFTTN8uCfv4sg==
X-Received: by 2002:a05:6402:1ed5:b0:5cb:6ca4:f4cd with SMTP id 4fb4d7f45d1cf-5cbbf8796ddmr18547486a12.7.1730467217170;
        Fri, 01 Nov 2024 06:20:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac74c6a3sm1513563a12.1.2024.11.01.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:20:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1A99E164B96C; Fri, 01 Nov 2024 14:20:13 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 13/18] xsk: allow attaching XSk pool via
 xdp_rxq_info_reg_mem_model()
In-Reply-To: <20241030165201.442301-14-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-14-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 14:20:13 +0100
Message-ID: <87cyjf9jle.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> When you register an XSk pool as XDP Rxq info memory model, you then
> need to manually attach it after the registration.
> Let the user combine both actions into one by just passing a pointer
> to the pool directly to xdp_rxq_info_reg_mem_model(), which will take
> care of calling xsk_pool_set_rxq_info(). This looks similar to how a
> &page_pool gets registered and reduce repeating driver code.
>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


