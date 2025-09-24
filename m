Return-Path: <netdev+bounces-225750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4094B97F15
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B887A818C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9451DEFE9;
	Wed, 24 Sep 2025 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0JCvPIa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FC1DE4DC
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675107; cv=none; b=Fux/U91GKRnX54zbIDoN4UamBiZadJ9/TGDp4Qsi3PQ9RBUYBCQ32JedvWkQMJSVg+iOu5/Ui+SGiLdBtwuso2g+SGUBJmFYQa2hZ0RpcN4mvs7+Zo65YivZBNmRzqK4z/NzltWVVshJOFy5fkpxU8dRkSWLGu1lty+U90Va8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675107; c=relaxed/simple;
	bh=B+gaEmpZQToa9D3BoDg5LW16aK2GKwumpEPqc28GJP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0pvT3OGEZ+Je2q6GejvG7KHZoGBOXQ5b7ZguICeqEVBKDEK3NZpZsBwYcpBBoyoHfaRKqHSxFASm92RRS80xaDf/kjd2i65V9TLQ8Fw4A8V7hMj7NeX1nPQ6Mz1Z0eObX9bkNRM0bwXHfY6BpHX61jb2JPEGCcC1t4mKdvjCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0JCvPIa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758675104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+CF+f8ZPtjHdoOi5iGDqJ4Pzq5sIU1lG9ApqP2SS3I=;
	b=O0JCvPIavLoq726+R0omDED72OFfP+C30QiLA0bp4wGhrJ4LnM1TkWPQFowq+S/lyuLZ9k
	cO7ymcTogshIXklgqFlmq2rFqM315i0Qja3qgFsONuXXWcA77vR6VJdwZixOT7eYDbwHBx
	Sf9lsSHrR9ZusTVD7jEe+CwFAnOyyTQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-uzk12-ceMLOCLnRYDEQ-3Q-1; Tue, 23 Sep 2025 20:51:42 -0400
X-MC-Unique: uzk12-ceMLOCLnRYDEQ-3Q-1
X-Mimecast-MFC-AGG-ID: uzk12-ceMLOCLnRYDEQ-3Q_1758675102
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso7407387a91.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 17:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675101; x=1759279901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+CF+f8ZPtjHdoOi5iGDqJ4Pzq5sIU1lG9ApqP2SS3I=;
        b=aPgFyWfnf45WFZCgqx/ZcnUafxITRt1VWVXg2gu6YMlzKXwPnZuR1CFxXpidU6zkyk
         aBzIlT3+SfWhURzXkYZfwtjkdVvocK2IauuNc65IAZuwDJR9TrQ4mg8LLWt2Tn+WkQ06
         EWCEVuL9hCxcmStVtlipf2khpde01H1oFPLaECTMJmoUFJN0RE6uLjASXdeqoMxBEqOr
         tEAwS0yfB3mcim2+A5TT/k87j07f3IjTHr31e/61irWYEJQP4d/1uqSm3YEYBHM3eYO0
         Jqcfe26x76YXAtkRhAgUhfXiz2/AtKQSUK3AARUyXqXpTPen9W+X3elT6ihuK/7Sgipj
         yEog==
X-Gm-Message-State: AOJu0YxpCyD+rv/TKFS1hVig+yN/He+RcjDvT7AUUwfH0mTaxdqjnsqr
	bJq0cAxjfK4oaC5qLPS1mclZTk7hKdTN1m+2+okQGJZiA+Ndt+e4z9vaBkQYpNtPVl2IOPlF2Xr
	E5mBSl1TFQ0662Lgs67FvqSnbbZ/7a+w9Wvh0bh4QClsOSI2agZbaNrfzw1v5esNrKygb0++sqU
	m78XZxfL1/I4zkiCn3DbgaiUL07hpRTR99p9wQ+5C6
X-Gm-Gg: ASbGncsqiQMvxfNvTUYb3WBLs4zlA/fz3DH6ipVaV6xZSWGZbH+0Gzm/0fetoaenVzQ
	/vDaNIiTlakd0pTFiOCo0KZHMCN5PPVHcPyhD3O6OUHHIaP78loKCCxdXl9HXxb8eKbFbd6FRLn
	hF6Q8W3MDkvLNr8ahQBw==
X-Received: by 2002:a17:90b:3811:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-332a970664cmr4735582a91.36.1758675101153;
        Tue, 23 Sep 2025 17:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6wlZU45QFpZaoYYGJj/yXqXhdztwIB8H8KjfQJG+1bAi7ZxkXTql04g41IaDsPBl3CCKvK35kQdqhNnbKqmU=
X-Received: by 2002:a17:90b:3811:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-332a970664cmr4735562a91.36.1758675100707; Tue, 23 Sep 2025
 17:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923202258.2738717-1-kshankar@marvell.com> <20250923202258.2738717-2-kshankar@marvell.com>
In-Reply-To: <20250923202258.2738717-2-kshankar@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 08:51:29 +0800
X-Gm-Features: AS18NWDo9GoRDKQ-kypc5YbeoTNltuvTxzdNxXyoo3qGwjJnvJLpDCXfXyisvgk
Message-ID: <CACGkMEvUMq7xgOndvWUYU=BZL=ZZD1q_LRy=5YFL7k80cYBRRg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/3] net: implement virtio helper to handle
 outer nw offset
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	jerinj@marvell.com, ndabilpuram@marvell.com, sburla@marvell.com, 
	schalla@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:23=E2=80=AFAM Kommula Shiva Shankar
<kshankar@marvell.com> wrote:
>
> virtio specification introduced support for outer network
> header offset broadcast.
>
> This patch implements the needed defines and virtio header
> parsing capabilities.
>
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> ---
>  include/linux/virtio_net.h      | 40 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net.h |  8 +++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 20e0584db1dd..e6153e9106d3 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -374,6 +374,46 @@ static inline int virtio_net_handle_csum_offload(str=
uct sk_buff *skb,
>         return 0;
>  }
>
> +static inline int
> +virtio_net_out_net_header_to_skb(struct sk_buff *skb,
> +                                struct virtio_net_hdr_v1_hash_tunnel_out=
_net_hdr *vhdr,
> +                                bool out_net_hdr_negotiated,
> +                                bool little_endian)
> +{
> +       unsigned int out_net_hdr_off;
> +
> +       if (!out_net_hdr_negotiated)
> +               return 0;
> +
> +       if (vhdr->outer_nh_offset) {
> +               out_net_hdr_off =3D __virtio16_to_cpu(little_endian, vhdr=
->outer_nh_offset);
> +               skb_set_network_header(skb, out_net_hdr_off);
> +       }
> +
> +       return 0;
> +}
> +
> +static inline int
> +virtio_net_out_net_header_from_skb(const struct sk_buff *skb,
> +                                  struct virtio_net_hdr_v1_hash_tunnel_o=
ut_net_hdr *vhdr,
> +                                  bool out_net_hdr_negotiated,
> +                                  bool little_endian)
> +{
> +       unsigned int out_net_hdr_off;
> +
> +       if (!out_net_hdr_negotiated) {
> +               vhdr->outer_nh_offset =3D 0;
> +               return 0;
> +       }
> +
> +       out_net_hdr_off =3D skb_network_offset(skb);
> +       if (out_net_hdr_off && skb->protocol =3D=3D htons(ETH_P_IP))
> +               vhdr->outer_nh_offset =3D __cpu_to_virtio16(little_endian=
,
> +                                                         out_net_hdr_off=
);

I'd expect this to work for IPV6 as well.

Thanks


