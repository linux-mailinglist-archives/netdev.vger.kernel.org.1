Return-Path: <netdev+bounces-132698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371F9992D8B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691D31C21E08
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9351D4159;
	Mon,  7 Oct 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fnfBT2NQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D2F1D1F75
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308315; cv=none; b=AO5DGPPceMJarPm9jmc4vC5Sl+rgiTVITxpC3P17tsq2tEQm7IF6OMl2OXtrG9cQ3AxnU6i7aD2gZ1r6/cfVfJS7mgE6/4R1RY5fjAhzxgL9qtRggsEnUYuiswcbDU1hhGlJEcxOsfH0cmVhnPfxshRiFmcZeCDfcDRTzRwmKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308315; c=relaxed/simple;
	bh=Qmu/iybC2dlNpWYgEOP0dyEFeaM6bP65c7ZbToe+zHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn/eO6Q0DkVSF9VBay1qE0imXrkKFJnbUXibeDQVslkLhVZYpjdZ3GAuWkUOuZc2vMynKcYzfhFvzGDe1brssK48IvoLuYkd2NzRwQtKmJnvPcCC0ujhKdSqghtzKJ+VnepbhOMSryO2iT2SYvnE0fIaBOifuo8DG4PZ9iH8kFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fnfBT2NQ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e305c2987bso5055567b3.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728308313; x=1728913113; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3AivlJBzplG4oio90vXWQgVH3Ngnb4VX8jsDr0R34g=;
        b=fnfBT2NQ4IwfjMyL9eN5E7ovTbpawKLlLEnu3OmULqRba4VGk51ZW2eDfdSp8bvr8p
         df4drMRXV2wiZRxi2KfqWkXszUPTVMiM6Ikt0pmaN1A/HYTAvZO3HuuFGpzM1INnMgPV
         rbto7HJbgO0DIP9gP8NSBuT6GNPBBC70FiEj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728308313; x=1728913113;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3AivlJBzplG4oio90vXWQgVH3Ngnb4VX8jsDr0R34g=;
        b=mVDLpGJmvC9z9CSN4BUfjOcn5p3C3+5BcjyukjC9VsRreKzcudBaDEYPScN1EVTG7j
         urBwv0FLf/OD6BSYiupy9eTOPJXES/uu1U2dCTAeaFA85ZjYu7KXUK+ipfdjVCLSAddv
         aiE6jDMtIeQHcnpys/W3b7V/m5RauXDXPvZlz23sznf1YP+nMptxnLhsNoGhRlyL1rTG
         7S9nrmgAcXXATxodtkYFF20JU9uodirMXD63mfQVXcQoL9XvPvUpYNUe4hrs9cXU3xrH
         mcWspglDeYFJ5/grrMRACcRdcAF8tpuTFypVBFwB/G+P7MLlGQeUuMGdhUU1/Qe5N3Vo
         md5g==
X-Gm-Message-State: AOJu0YzEuDBIGrevvi6+1b4IFyQrhBSpTQBWTaZcmVgBxnoE77MUdYn6
	PgHrWfF+MaU0rTho0h48oVts8nABy21FbKnfNrEe9jhr2IJ3rYcwfDn3AotAwAo=
X-Google-Smtp-Source: AGHT+IEgyAJ3EJ+QQzD2UtC7GCedV9NJ6gKYIGkL8o2zvbm+fEufGEtyvqohjHtA3UJud0MfnY/k3A==
X-Received: by 2002:a05:690c:f81:b0:6db:34ef:95cc with SMTP id 00721157ae682-6e2c7298c79mr92448597b3.43.1728308313115;
        Mon, 07 Oct 2024 06:38:33 -0700 (PDT)
Received: from LQ3V64L9R2 ([208.45.240.186])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93e2968sm10341357b3.104.2024.10.07.06.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:38:32 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:38:30 -0400
From: Joe Damato <jdamato@fastly.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v3 2/2] tg3: Link queues to NAPIs
Message-ID: <ZwPkVlFwFikuFI9N@LQ3V64L9R2>
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
> >
> > Link queues to NAPIs using the netdev-genl API so this information is
> > queryable.
> >
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                          --dump queue-get --json='{"ifindex": 2}'
> >
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'}]
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> >  static void tg3_napi_enable(struct tg3 *tp)
> >  {
> > +       int txq_idx = 0, rxq_idx = 0;
> > +       struct tg3_napi *tnapi;
> >         int i;
> >
> > -       for (i = 0; i < tp->irq_cnt; i++)
> > -               napi_enable(&tp->napi[i].napi);
> > +       for (i = 0; i < tp->irq_cnt; i++) {
> > +               tnapi = &tp->napi[i];
> > +               napi_enable(&tnapi->napi);
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

OK, but is this approach (with the running counters) acceptable for
rxq and txq numbering? If not, can you suggest an alternative?

