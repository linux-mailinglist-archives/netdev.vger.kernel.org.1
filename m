Return-Path: <netdev+bounces-99281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C88D445F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD68B24EA4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BEA142E69;
	Thu, 30 May 2024 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFzqnQCj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B8C142E60
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717041194; cv=none; b=Dt8Fi9h6nHVgWTVeD5CBDKBbjdYFbc7GjB3WsxyGxOcHxWc3PoCpiP7zUgjaao3ohx+zairOUEEN1+VKxh28xP6vOqPSlqpKWMve2f03uv7zBpBCJktQbkv4VZieUIoz1XVm+zTLzyWBHGRTT0d+GytFMKDdIHikg1VNRcT6Yk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717041194; c=relaxed/simple;
	bh=qxukRFjgTgtSKS2ohXLJolyK4AYZBRJm1/DcVcnsKh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdY+3VjMCk0lyWYyU6r4NQ73nHwH3ZQSiUfAJU5QI7p9H0SkZWt3seqMaLOw6Or9MPpdGjfzVxtgr7Fkaq9IAA83LhBdBvVQ1KdRq40pflEkBGEmqf7+bbF93tNAqSZal8bzIypXD0bPRTU+VFH2bGUaG2zpexKtiTQk+ebSPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFzqnQCj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717041191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jlpc9L3Y02CHMDDZW/B1f1o1c+Ed5Qsk0U33kO+zkjI=;
	b=MFzqnQCje3SNMBsLkkQe3Tcqm3vMAoI0iSDrE/lFYN3Ce8updeXebf+Zh9go8tWWK4dw/g
	suSsqr8SlnGEWB2q/7HN+I6SggJcCiUeQfaN1uKAWSf37bBio2uKfzfIWoSrrk+q3+67XF
	DK020Fko8uYD1koQABcWhzq0bDaYzuo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-xnfi_W8XPx-2ZCBrHWPKkg-1; Wed, 29 May 2024 23:53:10 -0400
X-MC-Unique: xnfi_W8XPx-2ZCBrHWPKkg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2bf5936d1cbso376284a91.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717041189; x=1717645989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jlpc9L3Y02CHMDDZW/B1f1o1c+Ed5Qsk0U33kO+zkjI=;
        b=uvgEpTMEUPTLqndjO2Cd4+QKLAqccMiUqiyMMJMvJA//FhweG5kgHUzQyzPZE4s2HN
         5gTfTCdCNxBiIX8//wf7iMYubkCo8yjqPmh5fe9cxQ8/k91mznJyCQ2sDeFMrGCn6mkl
         s8GBPkIyWwaUEVRm7Ze/dRO9GlNE5F7wK7/j33FDdRwA4FZD6hHT0bnHJI2+fMsAKMtP
         ny3spCv/98rjrx9XJy8lb131uma6KUy1UyUVFn6pasD6Z2wLwYlz0y0uBs0fL8RQBsNT
         PsC/G17ONSq7Y5qS2sc2oDnx4KnAlYVgYSgG9ft5NHAva1f5eHjebJLCJgNjPS/eQJtO
         s2IQ==
X-Gm-Message-State: AOJu0YxZfv3t7bwFv0k61lqUc/yDIvq5VZYrxWWoi/0eWc7cn/7USPdI
	+1XE+3cVtJVUYA44ffiyRhOHxsaYv21mDNUlBbUNjHQneV6RxJeajBlGFeoY+cw4w2AfLDKlxiU
	pTGrg/r6HIY9LPBEiuw5crIwB5Dl7IChCFEdxe9AGZNW0PLHe0mCkX1s2Z+4jUkwNffl0UolgPW
	TO1PBUw5F24OYK2cvTmt3HAF86zuDF
X-Received: by 2002:a17:90a:de08:b0:2b6:214a:71ac with SMTP id 98e67ed59e1d1-2c1acb303aemr1035707a91.3.1717041189141;
        Wed, 29 May 2024 20:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeULtR/FufvAbU74QWlFg+74ajOXPYZR/8xr0yW3xI15uth/YAMmN2biyO6W1EJHRFDVlowveTP7HmqpIZiKk=
X-Received: by 2002:a17:90a:de08:b0:2b6:214a:71ac with SMTP id
 98e67ed59e1d1-2c1acb303aemr1035682a91.3.1717041188693; Wed, 29 May 2024
 20:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530034143.19579-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240530034143.19579-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 11:52:57 +0800
Message-ID: <CACGkMEtL43VKTjU0D9bCftCCnv7_DwiSMaALPZnPo3E8btBmVQ@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio_net: fix missing lock protection on
 control_buf access
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Jurgens <danielj@nvidia.com>, Hariprasad Kelam <hkelam@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:41=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
> Refactored the handling of control_buf to be within the cvq_lock
> critical section, mitigating race conditions between reading device
> responses and new command submissions.
>
> Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
> v1->v2:
>   - Use the ok instead of ret.
>
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4a802c0ea2cb..1ea8e6a24286 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct virtn=
et_info *vi, u8 class, u8 cmd
>  {
>         struct scatterlist *sgs[5], hdr, stat;
>         u32 out_num =3D 0, tmp, in_num =3D 0;
> +       bool ok;
>         int ret;
>
>         /* Caller should know better */
> @@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct virtn=
et_info *vi, u8 class, u8 cmd
>         }
>
>  unlock:
> +       ok =3D vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>         mutex_unlock(&vi->cvq_lock);
> -       return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> +       return ok;
>  }
>
>  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 c=
md,
> --
> 2.32.0.3.g01195cf9f

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


