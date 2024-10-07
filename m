Return-Path: <netdev+bounces-132740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B3992EFC
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268511F222F6
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123D1D61B1;
	Mon,  7 Oct 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="d2q7JpoF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401715D5A1
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311024; cv=none; b=bWJizcufM8TF2f3NhpwKZmhFyUtdK1m7v91OBvrYX8fleZqWxHKzQZgZvbfpKt1wv4ud7PMfLv6V7G5zveEMnop/XejgDxeWhBLeU13QHxlJCcu1SzV8Pz7Kac9blD6y7UiwyfzymvTOJ5by664Wg4RQfSdoOlClE3SsI2ZyJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311024; c=relaxed/simple;
	bh=qPkc80T79/3wKLGesQKA66tQkMTXZTDkU/peITunfJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNlUdsI1lqS0soM0xo2BbMhDrD7fIc/ehJ4gh2Pm7F+08kpBdEn7DVCbgpWAMjAfZeF07zGMiMs05dYTP1ag1m00aIdEGk433eFngg4KxPJwHvF/4CNNbO1GcuikfYUeH4Zfbm/Vydaz7XATgoUpHupA/pwu76xAc9HDNo6zw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=d2q7JpoF; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2e41bd08bso14694177b3.2
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728311022; x=1728915822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqXbZQYfVYevus2Ea2D1rGElGIX5S/l9x3dZpDMo980=;
        b=d2q7JpoFu1oV7Esiflgkre+qnF3//vD2zcGlij8EHOwRW8SlansmTFdZz7+ILUsHZj
         sv3y5NJ4sSdTj1PL7gKAhDE+IqTwuulR0XMYcjjIWkW7vSFZJsch07nF7A/N+BM4avso
         F953L32omoJaLB+2cx774B1xWhmj9I13xAVrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311022; x=1728915822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqXbZQYfVYevus2Ea2D1rGElGIX5S/l9x3dZpDMo980=;
        b=e8NtkFY7AdfdSgqOwN57zb4d3xQaXNbLbxPysTmVEjIbUC+kFO2fZ9sB66spPDN+dA
         6UIvUZq2LFcN2R6S1CpMJ6FfiARS0G9neq2+pj3k2BTbaqXSOToBUTiHZI1amXibJCXz
         dMi3l+DX7Tiq1JXf6eHSVCZKcb32gQf7G/AIRMWJwgVMypux2wZ/KWq7HxhBG4B2tHvV
         Myrfz5KQKdTKArxP9En3XHjYaHha6xVuCjCtTBkYRqw6FB/whPDRrobyiU6YOoc1CMxi
         c1aUf7zznIJdp91oomMBny5XPZIoez1WglKGzplBNXx4Tc58CDRlNZkN1Jt0YSzJNFsZ
         q7sQ==
X-Gm-Message-State: AOJu0Yxe/r1RBHdDQjZEDsmC5KCxgUT0UbbC6NoysWcQoc8pE0XObgZm
	1fiGhNvzLEY5VyzsGKofFWloPW1+oeV1poVlmk+UHTXoFdlnGqs6rNLpmSKIgMIwcNoMh0nnkih
	u
X-Google-Smtp-Source: AGHT+IH+3lKVY8TPqMmtsQQH5l/1gFUoFYoqJHj9oZr6huCTqgMbfHMoNgylaEpPIc3DLqlRk/C26g==
X-Received: by 2002:a05:690c:2c86:b0:6d3:be51:6d03 with SMTP id 00721157ae682-6e2c7234549mr66163357b3.23.1728311022220;
        Mon, 07 Oct 2024 07:23:42 -0700 (PDT)
Received: from LQ3V64L9R2 ([208.45.240.186])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93d3e54sm10337857b3.101.2024.10.07.07.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:23:41 -0700 (PDT)
Date: Mon, 7 Oct 2024 10:23:40 -0400
From: Joe Damato <jdamato@fastly.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v3 2/2] tg3: Link queues to NAPIs
Message-ID: <ZwPu7DmYwwK_uDmD@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241005145717.302575-1-jdamato@fastly.com>
 <20241005145717.302575-3-jdamato@fastly.com>
 <CACKFLiknyPntcYXrhsVkz5Mpt9kep0cnkYBGVb1f74x5+HS4Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLiknyPntcYXrhsVkz5Mpt9kep0cnkYBGVb1f74x5+HS4Cg@mail.gmail.com>

On Mon, Oct 07, 2024 at 12:30:09AM -0700, Michael Chan wrote:
> On Sat, Oct 5, 2024 at 7:57 AM Joe Damato <jdamato@fastly.com> wrote:
> > +               if (tnapi->tx_buffers) {
> > +                       netif_queue_set_napi(tp->dev, txq_idx,
> > +                                            NETDEV_QUEUE_TYPE_TX,
> > +                                            &tnapi->napi);
> > +                       txq_idx++;
> > +               } else if (tnapi->rx_rcb) {
> 
> Shouldn't this be "if" instead of "else if" ?  A napi can be for both
> a TX ring and an RX ring in some cases.
> Thanks.

BTW: tg3 set_channels doesn't seem to support combined queues;
combined_count is not even examined in set_channels. But maybe
the link queue can be a combined queue, I don't know.

Regardless, I'll still make the change you requested as there is
similar code in tg3_request_irq.

But what I really would like to get feedback on is the rxq and txq
indexing with the running counters, please. That was called out
explicitly in the cover letter.

Thanks.

