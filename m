Return-Path: <netdev+bounces-68879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4646848A2C
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 02:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76EB1C22BD0
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 01:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53D64D;
	Sun,  4 Feb 2024 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWxgAFRx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91E15CC
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707010048; cv=none; b=ScLruib7YYl7Iaq+Los/eUY5l4/sdoKcPbCRQ+083q7rHfiB8FLNvh07h4faLMGnAuFd+QfHczB8TFlSWYLJc74SOrqZyuZroQ6FjVXDTj7FpwsDnAUTl43/0W01WbK0zLeHYoAGArXQ68hUOHH5YpASeRqISNejTCNzv3xkZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707010048; c=relaxed/simple;
	bh=C2iaeOFXYpDh1pgAfITwdaN8Gw9hOmWA6JpkGL/Xp4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2LVY+0+Z7j8eVAJzbPREcGFKn4VLGGoOU6KEWKa1TLkprmNsWubSogaaz1nfpgmQlXFrXQgH8ynlnMBvJ1DWz43NaX8F6sDdCLNK8p0tAm5ZpRdY7AA6cCwKf4XiO6gdFX0VJI57p2DteddDz4ERP1oVeGXsXtQKlNGSxJgb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWxgAFRx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707010046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDU9do/S72QAfTFtnTp/XvI11FLMd8x1l5eXuy6iPJs=;
	b=FWxgAFRxyvYDeuRFtT6ETQgejDjaQkA3zuOC4F+BF8bYRHk8hN5cXg7rXoLiO51AHoGXQ/
	g1sPSapHiwVih/t3hXqBb57rh+stnLQ2IZEFcGVCPjGOw6HyNZzp57i+XnGoG5W+3EPkM6
	V+sB8Pw2JV5rMcrcX0Gw2buKaThk7m4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-c5BaHnPYOV-R78DtgcausQ-1; Sat, 03 Feb 2024 20:27:24 -0500
X-MC-Unique: c5BaHnPYOV-R78DtgcausQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c670f70a37so3734664a12.2
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 17:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707010043; x=1707614843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDU9do/S72QAfTFtnTp/XvI11FLMd8x1l5eXuy6iPJs=;
        b=Pt3FcLdfRXGrqr3MKbab4vp7Dr2UZ3ugS/eTu3rVnV+gMWspwnZGXilpXw4YcUeVBV
         jhzuWsxRqMLRJGSh9cjZAgd7wHJGUB7dEVmXKg+TkS30DSHEdSZSo6Z9aHhj9Q04Xbkf
         Zg5fqIA6MhUYoA8yVvRM15PqQTQ9fTHy9EOnJfA1UF5nulao25ICVe2eCD2baI2D/2pA
         PLjTPfBVNpvXYcssi3e4D/yeQ8Fm+nbzuU26PxCtUW3X584yWxCh6G2LYL0uRvEP2zC0
         2iSpcLjR+yPLAhJhhGDnVrN48niUAMNsy8PowcjyWpyW65A/iMXwvQcH2rmpqEsEh390
         GKwA==
X-Gm-Message-State: AOJu0Yw8lY+rEWW9G6g/AMPWtPv+3TvZS0wexEhMFp1smb9DVdQif9/O
	EPZfXQF7DtwmOY9Ql97msPFRo7w6KZJD46d7HO/ye3t2epmFxie2jgGyGT7fd4xuEeeN5WUySG3
	VLeAG+sseyHNjqLD4zZme+T2DZ56/adb460evE9lhM8poWrfguBBsOHNzSzwhHFCXKZJvILLvq7
	WQuQKzuYIu5+Or5LM+cEYPvuLgFCGg
X-Received: by 2002:a05:6a21:998c:b0:19c:6cee:fc33 with SMTP id ve12-20020a056a21998c00b0019c6ceefc33mr15448582pzb.18.1707010043580;
        Sat, 03 Feb 2024 17:27:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED1R1TM8U8UO1Bj+V5vOzhoMT/QrJZl7RDJ7RsXlT4MddjbAwHHI7yztzKREXPa3j7e1zslg9CjnswRjioqKY=
X-Received: by 2002:a05:6a21:998c:b0:19c:6cee:fc33 with SMTP id
 ve12-20020a056a21998c00b0019c6ceefc33mr15448581pzb.18.1707010043349; Sat, 03
 Feb 2024 17:27:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706860400-61484-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1706860400-61484-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 4 Feb 2024 09:27:12 +0800
Message-ID: <CACGkMEseJJE7=yhMi_7xTeR4jrNiZwDoJte7zPv1smyAY-KH4A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tun: Implement ethtool's get_channels() callback
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xudingke@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:53=E2=80=AFPM Yunjian Wang <wangyunjian@huawei.com=
> wrote:
>
> Implement the tun .get_channels functionality. This feature is necessary
> for some tools, such as libxdp, which need to retrieve the queue count.
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>   v2: add conditional on IFF_MULTI_QUEUE
> ---
>  drivers/net/tun.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


