Return-Path: <netdev+bounces-56500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D940B80F224
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835F01F213AA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8437A77F02;
	Tue, 12 Dec 2023 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFO16y9F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB29F5
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702397709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2Jz0Vih/peGcNEFAH1I/vwL9Zvjs9OTM4jvQXkmuKw=;
	b=fFO16y9F2qN2JUXzDAZoz9j0yEJeQmSPdOnBRYWkRHbTKtJaVyJWY+AmLwRuQt/UuQYeg1
	hTPYxllOoh5ftkW9e0nEfd6mVN4BVDHxMgRTnwB0iz9eFDQeiqaM7Z3YZa6juEkGvGRkmG
	3lvvi8Q/KmuhL/LlgQkPpGaKl//m3RY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-SUgpKy47Pqa1QiP4V9vFig-1; Tue, 12 Dec 2023 11:15:07 -0500
X-MC-Unique: SUgpKy47Pqa1QiP4V9vFig-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33634f9130bso329755f8f.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397706; x=1703002506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2Jz0Vih/peGcNEFAH1I/vwL9Zvjs9OTM4jvQXkmuKw=;
        b=HTaUXFV8DkqKRNVomCJVWRFTnMSnV2zxQk9QyvJIYGc9tpbtuNbO5OhxXT1baAgw7Y
         ZJRwNTGyMFnY4FO1C2U1VGS8R5pXeyVBz9XgH2pH4FHu7Wjc8M5KRCqIFdNcdmmgq9ii
         Psp6mo92yPe9+na8WkrJbBjFPqRxjYoGh55GMWRtsjV1xvgD3PQ8vCS+Lf7VYURCTnht
         7iWWunjGTu0/HpnkObFAa38uCgLkR7HZnvyrGZ8KzNZkUP+ohpTKqOwjVmWWzmAXuOVP
         799ngeEmu10q8HmucwgF5Ia3T1wyiN5UFRfA9K3iJyAkzhVYNcHr8RfJkwhywrJyztPy
         hOjQ==
X-Gm-Message-State: AOJu0YytWnle1DgPXKWWA6s+G/1sIwIxsgICqWd9yzfbqkd8zUs3g4rw
	OoS5xzchtzckESWjhdqStw/qEvmD193i7h+B6uM5EK5Hw2DpyBK4W+sWEViOewXqqaCRo5kvTmo
	MkYhH84vAQMJxYC0U
X-Received: by 2002:a05:600c:4fd3:b0:40b:5e56:7b44 with SMTP id o19-20020a05600c4fd300b0040b5e567b44mr3106308wmq.141.1702397706191;
        Tue, 12 Dec 2023 08:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfYaO9aerEATODsvvXvfPwf/DmeS9S4RdZVSfiTQn3TL+p+4u6edQ/gY6/zAQL0WCJWMCW2A==
X-Received: by 2002:a05:600c:4fd3:b0:40b:5e56:7b44 with SMTP id o19-20020a05600c4fd300b0040b5e567b44mr3106296wmq.141.1702397705901;
        Tue, 12 Dec 2023 08:15:05 -0800 (PST)
Received: from redhat.com ([2.52.23.105])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b004053e9276easm19320264wmb.32.2023.12.12.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:15:05 -0800 (PST)
Date: Tue, 12 Dec 2023 11:15:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Tobias Huschle <huschle@linux.ibm.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231212111433-mutt-send-email-mst@kernel.org>
References: <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org>
 <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
 <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>

On Tue, Dec 12, 2023 at 11:00:12AM +0800, Jason Wang wrote:
> On Tue, Dec 12, 2023 at 12:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 11, 2023 at 03:26:46PM +0800, Jason Wang wrote:
> > > > Try reducing the VHOST_NET_WEIGHT limit and see if that improves things any?
> > >
> > > Or a dirty hack like cond_resched() in translate_desc().
> >
> > what do you mean, exactly?
> 
> Ideally it should not matter, but Tobias said there's an unexpectedly
> long time spent on translate_desc() which may indicate that the
> might_sleep() or other doesn't work for some reason.
> 
> Thanks

You mean for debugging, add it with a patch to see what this does?

Sure - can you post the debugging patch pls?

> >
> > --
> > MST
> >


