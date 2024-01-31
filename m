Return-Path: <netdev+bounces-67483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF2843A90
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EA71F2C235
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884306994A;
	Wed, 31 Jan 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g79jk8iF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02DA67E6C
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692346; cv=none; b=Ij9eqK0FlGnG1R+rOpa1B3q6xTI3PfprVC1wkmRcPLp+NQ/yOWPW1ELUNQ59eSu3RQL0tsxBbSBjM/TWuRk4oLZgS+Xu5fyeTjjFMVN/bZ4UCuBzDIjxoWZSCXNQLgc0Keg0aHutLj5zQn+P0J/jDnV146ZCFmUKPddlv1ZM/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692346; c=relaxed/simple;
	bh=F+LXEdvariXw6k3eT3r4qbtwZoi+V/LnKUO9+lO8CbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjjigaisIdpeqtdbADyV4MqbmKw9/hApSLTgq3GuGcqDvCmTbPupT4Jq6+0HU1RsyxVUGB2wRWxn6PROOKirAx4kjfo3lg93w+mjLc8D+C9Ss08YwSddVJB7wOBXe3Uy8b9wIM7UnRk+gtpYQqTrSAC4HE94Q4ooHTcRqTQZkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g79jk8iF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=;
	b=g79jk8iFZdmOvfhh/W0Mo1FkDWFoc3q3M9kKmTSLP6u9PHP9ea52/dScj/QLOH2xC7jyNJ
	d9Pf5TllETOcjXbtalkOvwkQxkN3IrNGL+MJLrsRWJlsXw/rd10u5VgPMambSGG9KpN/YH
	jT1PToGtFntBITDNdwzwdavnh/lpTxw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-EXVJERKnN2eWAXkY60FwOg-1; Wed, 31 Jan 2024 04:12:20 -0500
X-MC-Unique: EXVJERKnN2eWAXkY60FwOg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6de331e3de2so710836b3a.0
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 01:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692339; x=1707297139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=;
        b=Y5sSqPSmHvd06sfTYIjai3UZw2ed6YTOgnyCHVpMS3viYe44o3nM5r3bTPyo48P5JJ
         S32RSKa4FILEnkQTS3Wct3Zb7j/yJ7tDCW5dxnE5vDtvTwxUB+Qu6uZ/vsgk1NLUhgHc
         Phse17vJ2XJ0xTAO8EDOeuO6XX55l6VlIicyhpTHOcuXsLJO0li6kmMqJaX9NpW55cTJ
         52/9vE9ps6Xm62LWDSAAlmtIy2R0hH1B5p0iX8tJpi/jQE5ZpVDsp3CT8mJMFjpcBB66
         PpnO5LiyFMjUySL2+uykmmSejzjoAgJEcU5qEQcsdkQHBqn60aWhW/SOX0Sx8/CIGxGp
         hf2A==
X-Gm-Message-State: AOJu0Yz1BmRw8FxQSh+jt/LdWWevFn6+L6Fw85He305ffu2xVUDgj75R
	GN/asMO9ndm0BmgyK2DirjZyYzINly7+i++2GtdEYah0WufIXfyTOJjIbTKUVFWh1sjQKiH/GZx
	y53A6dIlD29Oq3QAIM+yaZG7GjgTK14j9BpNZFToWoSuJOywRCsZyCxhaqYcVYeE6yl7U4+ulYk
	8Av3e17YIbGOvaP7pB1gjgq9E5gn0G
X-Received: by 2002:a05:6a20:9c97:b0:19c:93ee:b0ad with SMTP id mj23-20020a056a209c9700b0019c93eeb0admr1177490pzb.31.1706692339191;
        Wed, 31 Jan 2024 01:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmM479Cl5hy9Rh2S2MeFkPZK97XeCIQ/W+WuJDw6bc/3YGrYz5ABB3TPxpsK6OFnyn5gpDGlLKohRyPGIa5F4=
X-Received: by 2002:a05:6a20:9c97:b0:19c:93ee:b0ad with SMTP id
 mj23-20020a056a209c9700b0019c93eeb0admr1177464pzb.31.1706692338808; Wed, 31
 Jan 2024 01:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:07 +0800
Message-ID: <CACGkMEsi4B7Rz7Uu-3sTEH=9XRBRDmNSacZkVt6zxaC-FbYqhg@mail.gmail.com>
Subject: Re: [PATCH vhost 01/17] virtio_ring: introduce vring_need_unmap_buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> To make the code readable, introduce vring_need_unmap_buffer() to
> replace do_unmap.
>
>    use_dma_api premapped -> vring_need_unmap_buffer()
> 1. false       false        false
> 2. true        false        true
> 3. true        true         false
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


