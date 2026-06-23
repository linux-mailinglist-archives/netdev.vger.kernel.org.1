Return-Path: <netdev+bounces-301332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RioVEfVdOmoS7QcAu9opvQ
	(envelope-from <netdev+bounces-301332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:20:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 874186B636D
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:20:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hhfP43c4;
	dkim=pass header.d=redhat.com header.s=google header.b=XkblIAM9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301332-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301332-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 353F23154E66
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E00370AE6;
	Tue, 23 Jun 2026 10:15:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F6360ECC
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:15:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209728; cv=none; b=NOc2I7Cj+ArQnCPixyjzFBmmD0m0s3FlKEOVPoVmP5/PYdm6JqzVYVBLbhRf93tpePSZteVUITdjzDz8Bd7A3M4yGdipU/mQQKwrVqoPlN9KDC69XU1+mZGQrvF6hjY1LkRVoT2g16MFtuapLDEtm1wtEf1qbCZaPmiKYQlNkyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209728; c=relaxed/simple;
	bh=+W9b9/mk63xgykDNsp6FtMdtjEKzT7LDGD3p8gmWo2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulstF1p/rCFSQZW1JeuJXl48g+f+ivIVd9kc3sTce+IM3Lh0EDzLu5jsfJqK739xTqEr+sO/t9bGUyb4R9dSdqsPBJ9XLFYNrl7qmWrFR9t8fE7LnGGRlsxEZH2B2m5kBTYXRO2DRxZ0pcpoN+CQt0P8iONZWu1ajDzSlHvY0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhfP43c4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkblIAM9; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782209726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cb/JwTi0oOwO3g9cvb2qcr2Dryjn8qmfB57Ud7IR7yk=;
	b=hhfP43c4gQmKgcAtgPgFPGNuP5qBPq4VmS8j/LxnhZ9Rd59fqwgZqfrtnlUPea/IlfIpyE
	qSNn17M+SAOWFek6H/G0bVxWpfWYHvA5QApL4dmdcHQBQKd6SFaIEm92sRoaDDTyk0pYde
	vVdtLZfq2F19NdKimbynlwz91WHnns8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-LsRiZPkvPsiQX61KA4RZnA-1; Tue, 23 Jun 2026 06:15:24 -0400
X-MC-Unique: LsRiZPkvPsiQX61KA4RZnA-1
X-Mimecast-MFC-AGG-ID: LsRiZPkvPsiQX61KA4RZnA_1782209723
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45f3d008865so705190f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782209723; x=1782814523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cb/JwTi0oOwO3g9cvb2qcr2Dryjn8qmfB57Ud7IR7yk=;
        b=XkblIAM9w4Gv/G9duhHO6PhwXXAhx/sTQj6Ws4uV99A4DdCczjZgrf+2hhMd6YQMlM
         MG7RdANID/+2oQn0JtbrPgtQG9AiCklQCSpE5jPnxarP74JITRXRndZdNaqpRaOGRJgi
         NCVSqNA7lczN7qFGqYcwlQnNRzS4u/RPW096t+4HjfNcIamZv1ERiopAA/7y2oGPwTq4
         15YnIFxp4fThG594FX5xBJ00vk/t0nypN44U9vXo7xQzYIV3PHr8BB8p/1ojstnKM9ZT
         K5drwvoMIusFsTsmIaQDmvmOx8r6PEv3jJNrClsN8vLlOdGcRuFq9TIauhn1sA2TNglV
         3VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209723; x=1782814523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cb/JwTi0oOwO3g9cvb2qcr2Dryjn8qmfB57Ud7IR7yk=;
        b=UnNr0ryotNb1znGagSYNzUfefkXUzIpCeLi+vGnIi9ldl2B2kP0LoGMfgvooV49ony
         WdBTk37sUNcuuU8Gnr1qI0wSjrU6rgZAwaXzhcVn2kZgh+7tewTih8VY6UY330eJDbtS
         4wa1B750F24zWJTnR0b15Un7HdxEizIZ1WCuYbbyVJQPuvLEDGUVF0026//6sq+1W+zk
         qifpp7K+rWBWVPW9muNJf3+7ISKi4v0x4j2jzZeBaDy4vYjGpfQnL+vziGF4Xzjordn+
         q5zy4FucQ1tw6itqj48CXfpEdG0dC72G9S5yAN0uiPCUqMLfabBmx5Uax5NRtCaCthnM
         aCFQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHNXgTn7bHMz/OUHGKfNYz4aI7DpfElLrFOxtFpKOgZtE2Uoq/lXHnMaUVr8fkCKMXT/zId6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfuYK8pqLHG37I/vazx1uh5dTtGObu2A05bmwa9eqZDP/TG1P
	6aA2mKkQtC2qkoj4kbsd4AT3rZLKXd5Rbv3L9Q6rx3md2sY9oN2/MeleYsHrMkQTP8tZnFMOEKe
	xfbGAzoLYF7ljFjdsz7UkwVrIacamOl50+tbW+xyB4AGA1ACWEufOEaybOQ==
X-Gm-Gg: AfdE7clXdggrH44biJgXsCLr4fCWi3EJZu7HGHNMk6e5oysHyMXSIA22xy+d2Xc9FwJ
	tBRjzukmwKBYqoVdXHK0L/t90IPQvE9CgY8H5vTBOjdIYca1pOB4SfpZTn3t6qhSu3j9YOZgPhn
	RAYYwBXWzFjXThKQH/wqZoyzXhe4Ei3Bpct+JBhv//F1Ywcflpbr+wHkaW+o425X7+XYSei/+pn
	k4+Y7KrTLh9ueSNbscgS5pmTosd4bbqPb0Gq0gLbpVOr9kgjC964Ne+cYLN6GDUrPs+6Mqs5S+X
	+AzB5SkojFOu1O04GuGuK4lp47nln3GzV9vpC7xq8UeONp0Ajn05wilTGHCvtvH+gFx5lN4+YnY
	60TZZPRMtVNLgB2P4p3nmF/e8nmu3XM4D
X-Received: by 2002:a05:6000:46cf:b0:461:a15f:7aa5 with SMTP id ffacd0b85a97d-46a806bd4e0mr3008034f8f.21.1782209723372;
        Tue, 23 Jun 2026 03:15:23 -0700 (PDT)
X-Received: by 2002:a05:6000:46cf:b0:461:a15f:7aa5 with SMTP id ffacd0b85a97d-46a806bd4e0mr3007964f8f.21.1782209722591;
        Tue, 23 Jun 2026 03:15:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e93sm37008028f8f.7.2026.06.23.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:15:22 -0700 (PDT)
Date: Tue, 23 Jun 2026 06:15:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Longjun Tang <lange_tang@163.com>, netdev <netdev@vger.kernel.org>,
	xuanzhuo@linux.alibaba.com, jasowang@redhat.com,
	virtualization@lists.linux.dev, tanglongjun@kylinos.cn
Subject: Re: [PATCH v2] virtio_net: disable cb when NAPI is busy-polled
Message-ID: <20260623061128-mutt-send-email-mst@kernel.org>
References: <20260623091901.118315-1-lange_tang@163.com>
 <CANn89iLrOTKQNqJA_oZKPjkHb1Xyqm6LS9tDn72X4az65isDGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLrOTKQNqJA_oZKPjkHb1Xyqm6LS9tDn72X4az65isDGQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[163.com,vger.kernel.org,linux.alibaba.com,redhat.com,lists.linux.dev,kylinos.cn];
	TAGGED_FROM(0.00)[bounces-301332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:lange_tang@163.com,m:netdev@vger.kernel.org,m:xuanzhuo@linux.alibaba.com,m:jasowang@redhat.com,m:virtualization@lists.linux.dev,m:tanglongjun@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 874186B636D

On Tue, Jun 23, 2026 at 02:55:30AM -0700, Eric Dumazet wrote:
> On Tue, Jun 23, 2026 at 2:19 AM Longjun Tang <lange_tang@163.com> wrote:
> >
> > From: Longjun Tang <tanglongjun@kylinos.cn>
> >
> > When busy-poll is active, napi_schedule_prep() returns false in
> > virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
> > The device may keep firing irqs until reaches virtqueue_napi_complete().
> > Under load (received == budget), it will lead to a large number
> > of spurious interrupts.
> >
> > Fix it by disabling the callback at the virtnet_poll() entry. This keeps
> > the callback off while we poll and re-enable by virtqueue_napi_complete()
> > when going idle.
> >
> > Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> >
> 
> I added netdev@ to get more attention from networking napi polling experts,
> 
> Please add a Fixes: tag as this will ease code review.
> 
> My rough guess is:
> 
> Fixes: ceef438d613f ("virtio_net: remove custom busy_poll")
> 
> Thanks.

Exactly. The old custom virtnet_busy_poll did napi_schedule_prep + virtqueue_disable_cb itself.

I'd even say CC stable interrupt storms are devastating to performance.


> > ---
> > V1 -> V2: Remain agnostic to busy polling
> > ---
> >  drivers/net/virtio_net.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..0a11f2b32500 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3008,6 +3008,11 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> >         unsigned int xdp_xmit = 0;
> >         bool napi_complete;
> >
> > +       /* Keep callbacks suppressed for the duration of this poll,
> > +        * busy-poll need.
> > +        */
> > +       virtqueue_disable_cb(rq->vq);
> > +
> >         virtnet_poll_cleantx(rq, budget);
> >
> >         received = virtnet_receive(rq, budget, &xdp_xmit);
> > --
> > 2.43.0
> >


