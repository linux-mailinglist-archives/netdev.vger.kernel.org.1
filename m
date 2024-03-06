Return-Path: <netdev+bounces-77770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9734F872E53
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 06:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9B01C2325A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 05:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3C918E27;
	Wed,  6 Mar 2024 05:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSv2Czub"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9D25381
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 05:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702913; cv=none; b=gBvxeVwTi8eivnllgT5rRAeeHQBCZsSa/BKdZq8J3V8AxdYf9Km+ka1etp85o/dV4vlV9dfWXELXGFY155pWBTAwYlhVrVAcKN0WcvpYXK/Q9VnTfgv7cMJa03NgDbxBDvLzoYTgOcQAO2ENJwD8Cy1exEoRELhy+RdGcEQYlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702913; c=relaxed/simple;
	bh=3hxZI4emF1wYSHuHobZcbBk1gscMxJ+EA04ne/SQOYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0oiGq+5LhM/zDi7ivOdwX8ZlyFf0ZZLfjyoKonhKwOsBi4SSoUpdelpO98CQvmuvE9tRitFXxwypzOnUyUlmmD5LcMb47btYNS/4Jdd+jTfwacpixdcv/9fc8kMPXPDqrSAOaJ9+r1MrZ2PrfNYyGMk0nkzsiex+P/Nx7mbSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSv2Czub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709702910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hxZI4emF1wYSHuHobZcbBk1gscMxJ+EA04ne/SQOYA=;
	b=LSv2CzubTrTbByxduuh4pZfQ0Q/gBUjOswhm9ioU9E+W1CNf0KRk9c/obrgOLptBRlQohp
	7uIQzGQbh6sOUKAxfMBQA8IrSu6EfSCDQJEq183AJRB+xCXehDg+CZTPrx20dXPMVc2Ckj
	Sa01suLJ78gzQrt2ifpO54A8Zx3yO/s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-DUrLxIRzNaadAkvxaQQ2NA-1; Wed, 06 Mar 2024 00:28:28 -0500
X-MC-Unique: DUrLxIRzNaadAkvxaQQ2NA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29b27e71d7aso3100775a91.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 21:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709702908; x=1710307708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hxZI4emF1wYSHuHobZcbBk1gscMxJ+EA04ne/SQOYA=;
        b=WO9O8C9BS8zhyXTNtHY52/qxOgJSbFf1fyFPHsk2DcScGvSYDf9ON5N5C3DLbjCjFK
         0Glgg3/nS68X2p8aZ0Q4tDM9Qh7uaUgyhKwldMD0wVZOA1s9FTvtnuNUf74Kq4tbxMft
         uDMkMfQ4ea+s/Iu8Zg5/uC5Rt2y4nGIhzlMXxFzNCYWhO9ysbTOjWDC7BpIcd1mNeRZR
         t6bN9HKlGxahZrCpWPEz8cUoSmtm9+1c3vJfRRq7fk189hV61bVggfMGX8yt8xN5zfTY
         gLDt227gEczKTqIrlMPoiRMLEhFC2AvMWegDbF8BI939RWTJGJrwfgzuzytnrXxAJ6XP
         FMfg==
X-Gm-Message-State: AOJu0YyaWuANNiYZtaLYy0Oypx4dgFabGDBxZb6L/QiD+zhoZJGQc0TJ
	/iZKzMTO6S1LD7h6JyA5s445LD20JB7eSxXpZEAHosa/DVFidGn3Tzf/c4lsa6ErqY6+penHpZW
	/t2wZrn7khUibETa5td9YS8M9Rkp3NiW26+ZxZvmyMezFJjXgQ4n2WQfgGa9jQUAV+0Q/WMI8uF
	TVtfNXAgGGJiyzMfhDzOzMJ6CRdAvT
X-Received: by 2002:a17:90a:fa96:b0:299:8957:9898 with SMTP id cu22-20020a17090afa9600b0029989579898mr11177780pjb.42.1709702907977;
        Tue, 05 Mar 2024 21:28:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3Aj9fYblNSHqZkWcccQqlzqUYhtj/+FONgyoU5B6Vd3h9SCF/s0WtuY4Kuj8YPdnUmWlVkzWj361ddQrkNHc=
X-Received: by 2002:a17:90a:fa96:b0:299:8957:9898 with SMTP id
 cu22-20020a17090afa9600b0029989579898mr11177772pjb.42.1709702907704; Tue, 05
 Mar 2024 21:28:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228093013.8263-1-linyunsheng@huawei.com> <20240228093013.8263-6-linyunsheng@huawei.com>
 <65c3503409c0e1670bdf06fecfd58ec483a114b9.camel@redhat.com>
In-Reply-To: <65c3503409c0e1670bdf06fecfd58ec483a114b9.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Mar 2024 13:28:16 +0800
Message-ID: <CACGkMEts-S7=p8aY+p+1JcTGZdLO65ug6t7c_yNj8xwRrhg9tA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/5] tools: virtio: introduce vhost_net_test
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, Yunsheng Lin <linyunsheng@huawei.com>, 
	davem@davemloft.net, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 5:47=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Wed, 2024-02-28 at 17:30 +0800, Yunsheng Lin wrote:
> > introduce vhost_net_test for both vhost_net tx and rx basing
> > on virtio_test to test vhost_net changing in the kernel.
> >
> > Steps for vhost_net tx testing:
> > 1. Prepare a out buf.
> > 2. Kick the vhost_net to do tx processing.
> > 3. Do the receiving in the tun side.
> > 4. verify the data received by tun is correct.
> >
> > Steps for vhost_net rx testing:
> > 1. Prepare a in buf.
> > 2. Do the sending in the tun side.
> > 3. Kick the vhost_net to do rx processing.
> > 4. verify the data received by vhost_net is correct.
> >
> > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>
> @Jason: AFAICS this addresses the points you raised on v5, could you
> please have a look?
>
> Thanks!

Looks good to me.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Paolo
>
>


