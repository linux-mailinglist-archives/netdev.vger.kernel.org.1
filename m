Return-Path: <netdev+bounces-160382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A59BA197C1
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36AF1690AA
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1832153F5;
	Wed, 22 Jan 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ShwbgkLo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5621519C
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567666; cv=none; b=uC3WHtS62Kd22fchOX3RQrGwUMZNXWNoC2mVWsZl/JfmeN/lC4x3JpKxX9OdM8WBySkbTo4ZZGJl+q6OPMHI70I7Ju1geOJrwJGvH1cXdDcZHLfHeNxNY6GkE18g8ZGMQBqnfMPpPpvOI6jnL8pSTh18MbRIzlImIoXc2XUGnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567666; c=relaxed/simple;
	bh=zXXrzWCLJA++Rf33uMBJnwYrM22DuyNXl1CNawXNbVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc0IeITAKu8uicy1HcUkMLffipS8nmEjgiS/xd5g2HFPSP2yvG1TrKKkUNxyvJP9LkwQ2i6PkYlt41JbnZkz1ZGk8c+eQHoDhY4K808miLH+Qz1/a1i2KvDdCvNCGrHu5asRuMLn7Ug8+69yvPYv3kuTMUzM058bO02/r9ewmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ShwbgkLo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2165448243fso157235345ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 09:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737567662; x=1738172462; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzk4EqT1xduSyCel68HG0gUHXnZnF8tcdwDmYNduisU=;
        b=ShwbgkLoJR9D8LJ2RmD0yCsUfCY6Ltv69dnB7unvEeIB9TKxHQePQubI8BV64lXsdr
         tekROm+CSTEj3hDUFZrp9iIvjKeT/rvJorcYKxx2fltSNYWdiJs5uJPJzZfysDl9A4O4
         JBhTb5LQRjg8c2GzjD97emgwB+tfql3yMviZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567662; x=1738172462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzk4EqT1xduSyCel68HG0gUHXnZnF8tcdwDmYNduisU=;
        b=qtMmqrpQF2Iew9IHXwXyDNcJPV/OMObF4nafKSSXA+z4D+YC86uZWRdKENHPu+AcVA
         +g+xI30IAQ1gT+SmQrUbDr5C73StXu66pAafwaailevRD6Yg4yE1iQWQewHrW0iHyLTJ
         B52KPBrVAOvyO6jYq52fICvvSaoTrEM1VbijcYgyeU0OBCfw9d7I0DcRtfIp1Nt7ChL1
         NgZKHURdDLGTZCvWTkp6iMDoN/YOZVHMSPUqPYGTvDlpCvgpC6Kqtg9+EzwCHZLGvkSX
         +AbDDbm0IcH1Slku/BwmkW9Xzs4Trb91nRlXqe/OWo40w3jybkXgqEn5otZj6tUUmvSs
         tLlw==
X-Gm-Message-State: AOJu0YyORnLxMUFHr6ryhiziPUHs/9WYrc97GMkHaJhUYx0gEe9frfAy
	dzgTn/qSufPHOWvCK1tYGtWI5dn84lexGeW5B6KH3pQB13M8kCdouyKwkVuu/VQ=
X-Gm-Gg: ASbGnctxEqnMJyN41MXGjCtdp4yza+DvArOHV0OpyPoC42/M7LDh5PolTLyJlfsrufq
	HwwGuTXb9fJNU7YcKal++1g4Nuim2yApVh/OkcZbwTSlRGYUW/hvIOSjzFdoVH85AwqhAL3vClE
	EJsHHjClaSOuvBkhLTanRpZf4L83/2VW7N3cfQJr6WTeIZNpw0lN02hKzN9K2xd0SzX2AKQm9uY
	GIzSwtyftTmXc7OGMxDghz0t/wcbPpLU7HDhszeW7telvaEi5jiGF/UcVgxYa39fsMlV+k6caqi
	zxmpojKyx4dUgcHgBKS5wYyOZ+ZnQIGt41Uh
X-Google-Smtp-Source: AGHT+IFIskecjwcV3BTTBpzH9S2j5V80AaBRDbVtEQoTgjHrPpiHHnoNJ2flDyZszDsdGQ6aVKgGOw==
X-Received: by 2002:a17:902:da88:b0:212:5786:7bb6 with SMTP id d9443c01a7336-21c353ef3abmr311395045ad.3.1737567660702;
        Wed, 22 Jan 2025 09:41:00 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9ef97sm97733815ad.42.2025.01.22.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 09:41:00 -0800 (PST)
Date: Wed, 22 Jan 2025 09:40:57 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com,
	leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue
 mapping
Message-ID: <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250121191047.269844-1-jdamato@fastly.com>
 <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>

On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> On Wed, Jan 22, 2025 at 3:11 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Slight refactor to prepare the code for NAPI to queue mapping. No
> > functional changes.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > Tested-by: Lei Yang <leiyang@redhat.com>
> > ---
> >  v2:
> >    - Previously patch 1 in the v1.
> >    - Added Reviewed-by and Tested-by tags to commit message. No
> >      functional changes.
> >
> >  drivers/net/virtio_net.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7646ddd9bef7..cff18c66b54a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
> >         virtqueue_napi_schedule(&rq->napi, rvq);
> >  }
> >
> > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > +                                  struct napi_struct *napi)
> >  {
> >         napi_enable(napi);
> 
> Nit: it might be better to not have this helper to avoid a misuse of
> this function directly.

Sorry, I'm probably missing something here.

Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
in virtnet_napi_do_enable.

Are you suggesting that I remove virtnet_napi_do_enable and repeat
the block of code in there twice (in virtnet_napi_enable and
virtnet_napi_tx_enable)?

Just seemed like a lot of code to repeat twice and a helper would be
cleaner?

Let me know; since net-next is closed there is a plenty of time to
get this to where you'd like it to be before new code is accepted.

> Other than this.
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

Thanks.

