Return-Path: <netdev+bounces-81509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F8088A0B6
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC2A1F3AE6C
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7773129E90;
	Mon, 25 Mar 2024 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N12zkn30"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944314D6E5
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711346279; cv=none; b=sUwAFEMSKbIs/qkyOIerkIteJF1ou2tgQ0Rx+zrTB6/OUu0sZSEQ+CA+vbgd7qNJ+qr+GJla5YABGAeRSkUfFPCuFlAx373t+PRtID68NZasDOObAiGqOoIulDlKOGXTuPQamK59jS/Si2WjxDiDCy9EbAO3fd88c3qT/CIm2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711346279; c=relaxed/simple;
	bh=yk2CPraBaf6pstVDw2coT42i+tAhrE7QlfbtGyeM5BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqfJSYsaE3JRDxfUwTJ4WgYP0Tiozz2us8M6g+LaPZ4QUidtnU/IOKKhqozuGdMnBo4D+AQCjDXODQelEdS+hT1BapJG510fRofKPbPRHtszJIWruOgWm1WlTM2/M+gNqbmzx8uSPHNzpXh0T4S6ORenTTlI7IQGCF2mvFK2J0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N12zkn30; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711346275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yk2CPraBaf6pstVDw2coT42i+tAhrE7QlfbtGyeM5BA=;
	b=N12zkn306RVrx2gnZ0E3bywo9K6+YhPXdyCjBr3XqsfzRvepmGhOUuS+v4HrU/lgYkR5+a
	EtZlf27zA1UV6V/SU3+3yQzAYHsgDeZlX8EE07Bf8nGcN8ux7kSE9kBPj8erf8KVpM5OSC
	suha0mnM/cmhfVV+OtQApc16D5zumGY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-mdeuyGd3PJ-YZ7APDQVwgQ-1; Mon, 25 Mar 2024 01:57:53 -0400
X-MC-Unique: mdeuyGd3PJ-YZ7APDQVwgQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e0ac20246bso9920825ad.3
        for <netdev@vger.kernel.org>; Sun, 24 Mar 2024 22:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711346272; x=1711951072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yk2CPraBaf6pstVDw2coT42i+tAhrE7QlfbtGyeM5BA=;
        b=Nqa5b3FIP33uMSr46WGrCZeIQEcBG4nZil0Iu4aOy8ewIFE8RO/xjWO8fdJ1lYyzPU
         xY3UtaQ+LgsY4SVAUmtnE2yOS80qB8goWmiZM9Vea1vS+PBRZEX2XWo5YqiZBPEXFpo+
         9Pl65TPImhKPnpjWlxJoWDPGbmTQsC+vtkB1x6RgLCdqFmrBzai03EedIqL11rBK4Z8C
         2mbv8TAPyep/FmEgaQL693qCZ8Pdznecognv3CEurS2CNhDJE98TUl+E/4iW3Ge01POA
         hcuQxsgUMGR5/oGwGullLKqWWt+TRqA32FXO4LPtTnVBgN9fj87lEfUJEBSpM7tlYtHI
         Z3pw==
X-Gm-Message-State: AOJu0YyAW31mnTWXvXgbiSl18NmS8f9meaVLzCfSwKgYlGWyp+3inusT
	q/50Mm5Y8CTC3GAWjvXLGx5zjDxGczBZnGMGE1HmG4BLdjsiPOorePpv5si/eVp9PezDf4DHjfu
	crbnLxKlI1hAznG0q6IFHDCDxpOvhYfiNSfd7dvkVIxJ1XIasGSgzAHhiQHHZZ5O+XsNSSoRSoQ
	IaajBaaU+w4EWPJtHeNDe1O+RMVYSis0J7YTDpmaM=
X-Received: by 2002:a17:902:e546:b0:1e0:9da6:1765 with SMTP id n6-20020a170902e54600b001e09da61765mr7474484plf.46.1711346272028;
        Sun, 24 Mar 2024 22:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbSBGmoujt2DqEgZCTFU091ZGyX5Kg/qyLAwmd74LsdjhC87PQ1Ts+fJEtISdMr7oDOf0/oUhVkkcDUH39+GE=
X-Received: by 2002:a17:902:e546:b0:1e0:9da6:1765 with SMTP id
 n6-20020a170902e54600b001e09da61765mr7474477plf.46.1711346271773; Sun, 24 Mar
 2024 22:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com> <5708312a-d8eb-40ee-88a9-e16930b94dda@linux.alibaba.com>
In-Reply-To: <5708312a-d8eb-40ee-88a9-e16930b94dda@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Mar 2024 13:57:40 +0800
Message-ID: <CACGkMEu8or7+fw3+vX_PY3Qsrm7zVSf6TS9SiE20NpOsz-or6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:21=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/3/22 =E4=B8=8B=E5=8D=881:19, Jason Wang =E5=86=99=E9=81=93=
:
> > On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >> Currently, ctrlq processes commands in a synchronous manner,
> >> which increases the delay of dim commands when configuring
> >> multi-queue VMs, which in turn causes the CPU utilization to
> >> increase and interferes with the performance of dim.
> >>
> >> Therefore we asynchronously process ctlq's dim commands.
> >>
> >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > I may miss some previous discussions.
> >
> > But at least the changelog needs to explain why you don't use interrupt=
.
>
> Will add, but reply here first.
>
> When upgrading the driver's ctrlq to use interrupt, problems may occur
> with some existing devices.
> For example, when existing devices are replaced with new drivers, they
> may not work.
> Or, if the guest OS supported by the new device is replaced by an old
> downstream OS product, it will not be usable.
>
> Although, ctrlq has the same capabilities as IOq in the virtio spec,
> this does have historical baggage.

I don't think the upstream Linux drivers need to workaround buggy
devices. Or it is a good excuse to block configure interrupts.

And I remember you told us your device doesn't have such an issue.

Thanks

>
> Thanks,
> Heng
>
> >
> > Thanks
>


