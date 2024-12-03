Return-Path: <netdev+bounces-148306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862A99E1138
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4803516519E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81803F8F7;
	Tue,  3 Dec 2024 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4EAqaIS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C533CFC
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733192731; cv=none; b=P03SxjWVcLJ6EeJfdGgu9GX3Sq4JGA8/OqhxCvBpdpZLLXzZt9N9cLSYiNf1UOZOjK7idwX9TfPcaDG2AvlfrkeWbd8LwXk/JpPozDwB8bTOUeDx1KxehBs5wqw5ZK8YHr2Z1p10hHvp38zEKUkgICDPGaadV/CPC7MCgMvIRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733192731; c=relaxed/simple;
	bh=d6q8bGpZsfPskVwkj6L7Lml5GYk/xxetw+D0hD9cEJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UB5yiFwG/VthNCOSxIQpcX5k0Sqck1yV2KS37jV8rsitKwg067VQO+tHqpZ0qDvnJVyzxGtJIrRWjuURBJ/NKKchgw6dFqPbdtXwanuu7pYJBUD6AlqGlPu83cYGEfeMa+tqopBNKF1OVhOawZwGq9j4LPH0DyZYjt19TubQuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4EAqaIS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733192728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6q8bGpZsfPskVwkj6L7Lml5GYk/xxetw+D0hD9cEJM=;
	b=b4EAqaISwa+mJLCpjirIdOJEDEr99H45OfozaT2BnlqphUszY1aQH9E/8RbSHufGQNaM2i
	FikslVW2l2Jq4psub1JJzeJSHlE8jDI5H47GUqR2JiNSPecWDaVKxyXumrD/mHCP0Auqef
	ES8PlEtOPo9keg81GyodeKLacych1u0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-yoJqepZ_P8my5QNWVWQ6EQ-1; Mon, 02 Dec 2024 21:25:27 -0500
X-MC-Unique: yoJqepZ_P8my5QNWVWQ6EQ-1
X-Mimecast-MFC-AGG-ID: yoJqepZ_P8my5QNWVWQ6EQ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2eec0bad68dso1798585a91.2
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 18:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733192726; x=1733797526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6q8bGpZsfPskVwkj6L7Lml5GYk/xxetw+D0hD9cEJM=;
        b=vjsP76tUqCcTD4KGd+djeEk+XP+Ql2fPupuG2uPthBXvKeuRT6o8QokFq3AWbHIuDD
         +w/wLwa6VLPHNKqyq4EZX4C9bh/FfuetluThM3AryQdFqEacJdfrRc6pJf2F23bjeKKF
         14evSWaroSu7KfhfYYFLDO0IjtaGait3vWI9CHPSktiKPU1OC3BjZ+bdT0fSfHKdFzRl
         3bwk9TfLQEdSAPpUY6ot9f6OICAv+hqvNH72HoGKzQQjpA2Nndfe533ENxYmZMuayQY2
         nOL2o+dLCACOilxNTkSwdU5xsQ6CxCIf39Gm7rCzelu5ANBKANMgqQcaZz5k9vrMTL5s
         EkeA==
X-Forwarded-Encrypted: i=1; AJvYcCU7PfmGNAj/ZgLcu2xt8z95iJ2pJJQKT+Yg4vd4bNzrU1X6SkP5zNiEQuK6IPfbgiV8EIkMF60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/yLDHnyla3wKJNakeaN3g7S6dnaJxRFwH1+4SPmpGbZDmOi2
	JFaJ5vLXIKhgYS8iRotYjHYYgMQMmYgnPB4CltcDreZ3wzUVAa6L3l43yFYRAQuVbVGdUPhyuAZ
	vr4khPSR447x1KECMFHLgVOxf3HHu/diIiDFIRr77F3tFdnmWArCcQyoTbuMJ23x0RU8ieQmAMN
	xxghumPr3VfRAfwktf95lS3exkmheN
X-Gm-Gg: ASbGncucOARb5Hf9VVwfmv0Ry/8sUEFydAl9GFH4jMakVd6zQ2LKm6Wt2pqBO5Ai5kd
	abfALLyIdVlkeVUBtAAgCzBdbnyc+LVhb
X-Received: by 2002:a17:90b:3ecb:b0:2ee:b8ac:73b4 with SMTP id 98e67ed59e1d1-2ef01276888mr1136816a91.36.1733192726102;
        Mon, 02 Dec 2024 18:25:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH5qQnZ0DiMbRpH7Ik71jXULxUEUKJNASFzFHC0GxhUTgu42/8cZ6SwHvLSqsP/acaKB2ErIzMfAseQ2enXwc=
X-Received: by 2002:a17:90b:3ecb:b0:2ee:b8ac:73b4 with SMTP id
 98e67ed59e1d1-2ef01276888mr1136791a91.36.1733192725616; Mon, 02 Dec 2024
 18:25:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130181744.3772632-1-koichiro.den@canonical.com>
 <CACGkMEtmH9ukthh+DGCP5cJDrR=o9ML_1tF8nfS-rFa+NrijdA@mail.gmail.com> <20241202181445.0da50076@kernel.org>
In-Reply-To: <20241202181445.0da50076@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Dec 2024 10:25:14 +0800
Message-ID: <CACGkMEs=A3tJHf3sFFN++Fb+VL=7P9bWGCynDAVFjtOT-0bYFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: drop netdev_tx_reset_queue() from virtnet_enable_queue_pair()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Koichiro Den <koichiro.den@canonical.com>, virtualization@lists.linux.dev, 
	mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:14=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 2 Dec 2024 12:22:53 +0800 Jason Wang wrote:
> > > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > > Cc: <stable@vger.kernel.org> # v6.11+
> > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> I see Tx skb flush in:
>
> virtnet_freeze() -> remove_vq_common() -> free_unused_bufs() -> virtnet_s=
q_free_unused_buf()
>
> do we need to reset the BQL state in that case?

Yes, I think so. And I spot another path which is:

virtnet_tx_resize() -> virtqueue_resize() -> virtnet_sq_free_unused_buf().

> Rule of thumb is netdev_tx_reset_queue() should follow any flush
> (IOW skb freeing not followed by netdev_tx_completed_queue()).
>

Right.

Koichiro, I think this fixes the problem of open/stop but may break
freeze/restore(). Let's fix that.

For resizing, it's a path that has been buggy since the introduction of BQL=
.

Thanks


