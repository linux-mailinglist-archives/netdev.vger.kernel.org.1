Return-Path: <netdev+bounces-67504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D03843B54
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D100E1F2A26A
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AA660DCC;
	Wed, 31 Jan 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLnIxU0c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B269960
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694199; cv=none; b=koRJ7Na9lL2Dubu2ewGsupJPB7TmNZ4+h++Z5P5IwVqKAebvd08gBo7jK1ZSfR9dhSENsNp7UOSKQe/J4ps+aclfRdnartPisl4TYM4H8RGfgq4O10vR63TsYJPz0GISaX+tgK77HbUwgjZzmudUuLzSM17imRk7Rvt0IoBAFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694199; c=relaxed/simple;
	bh=gkIae8l+H2+F/jXvpvISUQcIXBcbsucEp1aonIBdbjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpLh22HD7xIAivPt27LbkHOLCcU0UnqYmEnlcDr/iDpQXORTtI60+9w5DEomYvs8tZrqtk2IIcWOVO6judgWTiqbMBORykGm/PYGE4fqG70Dbx09iWxiY4jS/AMQSnrb1Ya7mZ2qNfxKL7GA/ERc1eBeJosqC+TvFAbsowG9A5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLnIxU0c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706694196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oza1LRHp/M5RIj8Nm47urKrF572FUv22z3v7KOgdQu8=;
	b=cLnIxU0cbeHtPMXhbPMhNdSTxan7Ox4fuZSF5+1ncnLt/f2+yZUEiMcHQE4I39Upkb03zV
	mpkfF+THSvN4I2vwF1YmpAV/XA2lokqqw9RuVogk97RjLp2iTo7poWtFEfipsGWZqh3HCY
	FQavxRZAaj7KfsVmTTwRug3Q7z27Sp4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-aiUJqg7eOLe3OihRmUWoNQ-1; Wed, 31 Jan 2024 04:43:14 -0500
X-MC-Unique: aiUJqg7eOLe3OihRmUWoNQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ae2d2fffaso1753023f8f.2
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 01:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706694193; x=1707298993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oza1LRHp/M5RIj8Nm47urKrF572FUv22z3v7KOgdQu8=;
        b=MbV9h/snhhfGsvgy2O7uyrIcbCPlKrQ+gDWjmV6PYJcUNpFfpuYMBbfPdw/NZk5iJU
         5smSn72FdVBfGHrKiaYsxaqWjst+508ifXnzYdUm57FwzWBBACMosRtFofk7SN89ONn2
         Udz35rYVtdMIPTandgCfAGPvodk62dfIbadqmeMJDOVAyRcJ/UG9mpMyDwy6nIf/L8mV
         N9lu8I6+1jtKfagvbJ56VmPXKh2ewF3IxweM3hRfZ6WqAFnbXWEai+RBw/bm1RN68Mn6
         ymp3Sn6nVy/xEpO6DofJDKBQIN31ySCCGn1v9g98rr7QEPe9iXofPoYQw9N7ck6ct0ju
         nyMg==
X-Gm-Message-State: AOJu0Yw3xEqECb46U4duySxAYmRdw+mkbs8pJUBmBalLL+U381Pdgh0i
	aZf5Aqkdwy+1ZKoVlYftsbAcfdpVULTElDIGQALAPWZ/UktQKdXJQudPlDovt85SKKiyFLuwf4l
	N/G7SeQkvp/nkGNb4zL4GZzqN+4hjFI1z5bOiidn1OB9CLEDdWwff5g==
X-Received: by 2002:adf:fa05:0:b0:33a:e919:f406 with SMTP id m5-20020adffa05000000b0033ae919f406mr679885wrr.52.1706694193229;
        Wed, 31 Jan 2024 01:43:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3NLeG1aMawKGEQVu/0aqBjSNNGqzZmjOJyBzgiQ4QC6+fT4S4tC5TcuNgzowV5ynPiQEAwQ==
X-Received: by 2002:adf:fa05:0:b0:33a:e919:f406 with SMTP id m5-20020adffa05000000b0033ae919f406mr679860wrr.52.1706694192871;
        Wed, 31 Jan 2024 01:43:12 -0800 (PST)
Received: from redhat.com ([2a02:14f:1fb:b2de:3c63:2a5e:5605:4150])
        by smtp.gmail.com with ESMTPSA id cx18-20020a056000093200b0033935779a23sm12937651wrb.89.2024.01.31.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:43:12 -0800 (PST)
Date: Wed, 31 Jan 2024 04:43:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org,
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH vhost 04/17] virtio_ring: split: remove double check of
 the unmap ops
Message-ID: <20240131044244-mutt-send-email-mst@kernel.org>
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEs-wUa_z_tGYEwBf7EVJAtuJdkX4HAdjqMXHEM1ys-gKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEs-wUa_z_tGYEwBf7EVJAtuJdkX4HAdjqMXHEM1ys-gKQ@mail.gmail.com>

On Wed, Jan 31, 2024 at 05:12:22PM +0800, Jason Wang wrote:
> I post a patch to store flags unconditionally at:
> 
> https://lore.kernel.org/all/20220224122655-mutt-send-email-mst@kernel.org/

what happened to it btw?

-- 
MST


