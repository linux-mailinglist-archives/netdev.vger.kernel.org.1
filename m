Return-Path: <netdev+bounces-244059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DBDCAEE22
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 05:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2407830341F3
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 04:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DD2BD11;
	Tue,  9 Dec 2025 04:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDc5TkT6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4Uyxwp9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A33B8D7E
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 04:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765254647; cv=none; b=g5ylzAnCc1PXbahYPxZIo6UZIlOlo6x/euJcWU5NpQUm/yaPJ2EZ4BjfHfntvkQKjVXdpSXkvCJ2NJdmBLl69T+Sv2G1+25MLEMyFpQbjJybNmHCPJZ1C4eoeds6Tvxl4NFh3mMcmBDcYPI5MT8qPFEamWI5YuuWyCD/Gx7Ixts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765254647; c=relaxed/simple;
	bh=FqRrkq9RkhhKrp58S/BccmT+zycBzvr/ayVbPtBPhHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQRlJHFsnfMNRGmU4WmjOhlOFXrsDBImuQqlqJ3XmvnXCmCN9am4pbWBNaXe2halIoK7ZHFcrSDlSVC78U7F6qHaeaedv8dhZHOZmwfHX+aZV/PGBefXI4mQtJl8be36ybHcKYKW7lQnI73dJRnsx7UhQJ36MfQXq+s5tvH7h3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDc5TkT6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4Uyxwp9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765254644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjZkNBzK8xQG6o4l+/b1jesEnkz3gHkSmOVvKHR9eIw=;
	b=VDc5TkT6K2BqFOtPk7OzOoSKaM3wFP79ZRR9ZGZHWfMOZwwKImrSqouCbCNFB2BSZ4SwYr
	NseD1ldZId9NeKiDKpsuYc9oA6oAUJAP30veHv4kRU3TUfJJkWuWeBkxREfyidPImVwreJ
	8A5D+2nZfJ3lKaoKdTGl+1GkkbcVlD8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-gDcq71SGMuq46v7dqjCd2w-1; Mon, 08 Dec 2025 23:30:32 -0500
X-MC-Unique: gDcq71SGMuq46v7dqjCd2w-1
X-Mimecast-MFC-AGG-ID: gDcq71SGMuq46v7dqjCd2w_1765254631
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34176460924so5219264a91.3
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 20:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765254631; x=1765859431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjZkNBzK8xQG6o4l+/b1jesEnkz3gHkSmOVvKHR9eIw=;
        b=E4Uyxwp9tGS1iUCji8Mu7parAvXXFR3GTTd3NEVKrML8dbkzgGikatju3VJw04hFYg
         JytuHgLrrc4/8ztE41NZ3caw67VEEqYuQMmxrOro/OJeOIpz7QGPbe9YrOVOE0u8qjiN
         SIJWjcZ96aRkUmlqyp7JPdjrpY6LvB/mDH9w39PPUGCQHInrRYx4llof58LB2ord7BPl
         ejxRGv+kt6Mp517Ht8Hu5Xw7IZrsdIg25+8cCCYTssnsf5YVlBRrP0/DSYGjJdzp/HY3
         Lag51gUWynquaIAjA9sK13TS6cUI6IK0Vr2Nxxmb94cDNRqnSQH3EKp5/kkokRaxeQOI
         6oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765254631; x=1765859431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjZkNBzK8xQG6o4l+/b1jesEnkz3gHkSmOVvKHR9eIw=;
        b=P1KsR7uf7agLVYscJXXQ+4eKqcDyLWEk6qKOIlKuLGNkgt3ghNYWR1PNBS4I30+O/A
         /geeg6tboX/rfazTAR3AzXTDFw2Xvt4+Eq5mSZH5WbG6CfWaRRiQeO1Vf+385oz8LvP3
         FStLmfL1b47IARXCMpam1UOZDlu4OKsoeFu0w5bEw4U29xgHOqjwxg4d+ERzXxEHKAnw
         ULgz9rbonrbmvgFkO+mAA1LhVmrg4ccpJjnSPgLx0YTVaZ1hgYWBVW0e7WQpWrEdbcje
         ISEMlJpApGaiAO5HyEuz5tzMRpJEothZq248BrVLWyoDgdEOU1z6yWv5SUSVqZ2XMUE2
         FbjA==
X-Gm-Message-State: AOJu0Yz2cCGr/0QClu0a1PZASUVNOR5G2aQF41zFBGtn19mG94YPrNZ9
	QSdGF93/IPULhi+N9kfXI41NtnJV98MBaxtLHTql5kc7K5AbUuaRUorU+eyvtzjpgWCUL++Lel7
	5G5dohRtU8FyKIgEaSHD4d5CchGR1aDwo9VZw91yb2N7djXkEtPH6bl/ChzNTkHkDRVkd2ix1IP
	0w8izN45Cxw+x6fMPalglw8rC0dflpXn6Z
X-Gm-Gg: ASbGncuuaiNFm5knbxB/LO78dJJUkX51MntR4Fz2Ln2finIi1NUefy+CkH9xAEsA5PN
	rTXcwb1CFopATD3xY5KY1wEykZ54/44FQoxGQIDNa/1cVuZjci8iFocYscmVIY473wqgZVeNg7R
	xg+Cjh2OW++XHkQvgzV368YbLcGhP2aVKFyFEAUdgS8KeJTt0Jcuu2VFrgwIqZfUJlBw==
X-Received: by 2002:a17:90b:2689:b0:341:212b:fdd1 with SMTP id 98e67ed59e1d1-349a256e409mr8500171a91.16.1765254630805;
        Mon, 08 Dec 2025 20:30:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExGqnqO+DyztHKRZgQziFfQnzweFIyxEgvKR3AsKvJmK7dcSqQvfdQGlSNvqQr39deZXVUow2OFVn3WFQTU/s=
X-Received: by 2002:a17:90b:2689:b0:341:212b:fdd1 with SMTP id
 98e67ed59e1d1-349a256e409mr8500154a91.16.1765254630384; Mon, 08 Dec 2025
 20:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
In-Reply-To: <20251208153419.18196-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Dec 2025 12:30:19 +0800
X-Gm-Features: AQt7F2pdiWKYZftUX6M208UPAFNmS9Br13quSDg8KS6iZmKHEOuykxku7dVVBJ4
Message-ID: <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 11:35=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> when pausing rx"), to avoid the deadlock, when pausing the RX in
> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> work too early before enabling all the receive queue napis.
>
> The deadlock can be reproduced by running
> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> device and inserting a cond_resched() inside the for loop in
> virtnet_rx_resume_all() to increase the success rate. Because the worker
> processing the delayed refilled work runs on the same CPU as
> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> In real scenario, the contention on netdev_lock can cause the
> reschedule.
>
> This fixes the deadlock by ensuring all receive queue's napis are
> enabled before we enable the delayed refill work in
> virtnet_rx_resume_all() and virtnet_open().
>
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx"=
)
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results=
/400961/3-xdp-py/stderr
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e04adb57f52..f2b1ea65767d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi,=
 struct receive_queue *rq,
>         return err !=3D -ENOMEM;
>  }
>
> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> +{
> +       bool schedule_refill =3D false;
> +       int i;
> +
> +       enable_delayed_refill(vi);

This seems to be still racy?

For example, in virtnet_open() we had:

static int virtnet_open(struct net_device *dev)
{
        struct virtnet_info *vi =3D netdev_priv(dev);
        int i, err;

        for (i =3D 0; i < vi->max_queue_pairs; i++) {
                err =3D virtnet_enable_queue_pair(vi, i);
                if (err < 0)
                        goto err_enable_qp;
        }

        virtnet_rx_refill_all(vi);

So NAPI and refill work is enabled in this case, so the refill work
could be scheduled and run at the same time?

Thanks


