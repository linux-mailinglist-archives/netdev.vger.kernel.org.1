Return-Path: <netdev+bounces-235365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F52C2F4EA
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 05:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B822B4E24B4
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 04:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA8B2641C6;
	Tue,  4 Nov 2025 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elpvN5aJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qqKZZwG5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12763CF
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 04:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762230911; cv=none; b=icEpz18PLsO61M7drUwCryqsPRCNSIl2eqLnb1b7LEWyKe9YWsAsDsi//1oso6loxqXSuqS9TcJwqpQicmxNv0zkF6D+71MLWoWkMe8ueiQUVtcWTfpC97uGdJcTwY26RdDyfCcfutapDlhj8/mNEijXiu9hEPULlR9imJ5guHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762230911; c=relaxed/simple;
	bh=pZ91m8+a/VCgZ6qu8Bmh/r7IDOJwtRB6INYfrPNEiRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9BqEZGEZPvkAT7oQS6TQ1h/7y/WhwXDefWT+LyG+nAUNFAnUvRs4BrJU8vndIWgXVg/hC9fKD9uI0naFMocdM/P2+sYgb7k1bXstNqTbuG+yEVOn7/G0zsK/AbSoGiJijRmTLoKZGb4uYo1239Ico6ColbIY5ecn7IIRpWbQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elpvN5aJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qqKZZwG5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762230908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZmhQ+nL2DY+AZpXAeBqjbcazVO2nfP8+I3WpEAuJO0=;
	b=elpvN5aJi4Vkk4XT0K+OC0dYWSG5RrsCVz9gQ1xy8xcqOJcWxwyJoGSvbGcVBPDuBhR38m
	u0X6N2rrmD+KIki7VXRQUdci7Cd5PMBboo4jrYlEcv5GZabrJz0mT95Oj4G6ZLuUVhBGkf
	7QovPU2ogXDz1Nvi0iV5lwea151T7Uc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-Aip6JQzUNBGDV5moxRShsA-1; Mon, 03 Nov 2025 23:35:06 -0500
X-MC-Unique: Aip6JQzUNBGDV5moxRShsA-1
X-Mimecast-MFC-AGG-ID: Aip6JQzUNBGDV5moxRShsA_1762230906
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5dbcd41a372so1142255137.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 20:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762230906; x=1762835706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZmhQ+nL2DY+AZpXAeBqjbcazVO2nfP8+I3WpEAuJO0=;
        b=qqKZZwG58D6KOxHfY18VvV7zZBLYcucH0FN8vfxOL7y1fwUvyHwzKnpxFPevrvJCbG
         yeLh3tV1mBiUzsQ1rcKRMaYpCdgaSHCYp8G+hO+wwH7RhRDhZVQ/nLwAuR8oNnsKjw1X
         XkSw03Z9rO3YlFHsBOl3iSGJvf9I+HWIhFYnGWHP2UY0bbU9OzXDe701jjHn3sEJ+MJL
         4Gctt1JIy4BzgiTKjtnqvL+sJm7rXXRKoy2bIKuw4ZxYgT2UrTGAnRTYRRsixFkCgpUR
         1WzSwxJc+8UhNQB1tlfab8/c7bjFQuDHEOHHnIcd4IADjBFy3WIqzphFKWx7a1tI8QkB
         am0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762230906; x=1762835706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZmhQ+nL2DY+AZpXAeBqjbcazVO2nfP8+I3WpEAuJO0=;
        b=lyPgRgPm58u9nnq4bFl4H328PvSGxcT/SsCG1nxW69jFsFRYp9n9UMeA9CCI0vQAEP
         1wM0lqo8Nmbbab8tYXWFkAMhvDAfXAeRoDoSrAkJVzCVIFbb9ZmVt79aK+oMg5tF4F99
         oVqyGs0UAluc2r1J04QI653XyAnoQBWGcGg6aRE3ecZN4bJCpK1x98C6EotjGtkmDCMo
         HnT82Rg5AVj97plBGYREFyWzlyVeuSTIBepHzb+BPengkWYQfDu22HMEEN7atapkfzJ+
         uD6euxUQiVVwfafC023iafvOYFYM4jq+Be7GW5760Qi9CSnOrgO0iBHhf/OWBVHB865t
         Iwhw==
X-Gm-Message-State: AOJu0YxG6tEkeC9egrSs31Gj4+hBR5LRPJgRMqGkua1037qrxsGB0/4H
	hqVILZFsK1ux2qMSR5R1VumzcgQrViwGVBgR4W6HEYYHMlrLFdjF5loqw74paVX63RwRvis3l2X
	DHMEdv64d4kPUhWDlZexUUMqHJ5zkeuCRDNgCzvXZSX0IldwUcIQmuEf5RuNFynQtNpHYjkw4Pf
	q5tAuL51mo0hVcuhSR8N4sAu2XvYZ++eY0
X-Gm-Gg: ASbGnct4UaU30CiBIczrHMM+6CK/ZgCiDo0iXXuNq+lyksUkMKs3Mju+jTOhai0IagR
	KBwh33uRWEhQ0oAJ3KD+DOG5X4GzsBhdJ9rd+gL605eoQtNqd5kXdDBWsLV9E8Mh+6BsuV9EDmD
	XN9xFowa/Au2S+clS517C/nY8d+u+9PC8qfeawBCsSHzte2vPEYz4X+o6W
X-Received: by 2002:a05:6102:1622:b0:5db:cc69:73a1 with SMTP id ada2fe7eead31-5dbcc69748cmr2217628137.42.1762230906326;
        Mon, 03 Nov 2025 20:35:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQRGGOR1eTK1zpBsstEHaXBd9jeWCUzZj8w151fHMOwtmeAK1RRNN0i+yG1hERYPNxEGz4nA8xUzhsJdQ1HFc=
X-Received: by 2002:a05:6102:1622:b0:5db:cc69:73a1 with SMTP id
 ada2fe7eead31-5dbcc69748cmr2217612137.42.1762230905823; Mon, 03 Nov 2025
 20:35:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103225514.2185-1-danielj@nvidia.com> <20251103225514.2185-8-danielj@nvidia.com>
In-Reply-To: <20251103225514.2185-8-danielj@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Nov 2025 12:34:53 +0800
X-Gm-Features: AWmQ_bnmjGn9_5EGzpg2LqGHbd5YLW9AweuWJKWVAd0C5Mfyewv5Qlbi-E9D4lo
Message-ID: <CACGkMEumoo3J1LTKBJqLCWLAZ=DX1NeX8D_87HjJ_9hNkV0bZw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, alex.williamson@redhat.com, 
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 6:56=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com> =
wrote:
>
> Filtering a flow requires a classifier to match the packets, and a rule
> to filter on the matches.
>
> A classifier consists of one or more selectors. There is one selector
> per header type. A selector must only use fields set in the selector
> capability. If partial matching is supported, the classifier mask for a
> particular field can be a subset of the mask for that field in the
> capability.
>
> The rule consists of a priority, an action and a key. The key is a byte
> array containing headers corresponding to the selectors in the
> classifier.
>
> This patch implements ethtool rules for ethernet headers.
>
> Example:
> $ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
> Added rule with ID 1
>
> The rule in the example directs received packets with the specified
> destination MAC address to rq 30.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4:
>     - Fixed double free bug in error flows
>     - Build bug on for classifier struct ordering.
>     - (u8 *) to (void *) casting.
>     - Documentation in UAPI
>     - Answered questions about overflow with no changes.
> v6:
>     - Fix sparse warning "array of flexible structures" Jakub K/Simon H
> v7:
>     - Move for (int i -> for (i hunk from next patch. Paolo Abeni
> ---
>  drivers/net/virtio_net.c           | 462 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h |  50 ++++
>  2 files changed, 512 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 998f2b3080b5..032932e5d616 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -284,6 +284,11 @@ static const struct virtnet_stat_desc virtnet_stats_=
tx_speed_desc_qstat[] =3D {
>         VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_rat=
elimits),
>  };
>
> +struct virtnet_ethtool_ff {
> +       struct xarray rules;
> +       int    num_rules;
> +};
> +
>  #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
>  #define VIRTNET_FF_MAX_GROUPS 1
>
> @@ -293,8 +298,16 @@ struct virtnet_ff {
>         struct virtio_net_ff_cap_data *ff_caps;
>         struct virtio_net_ff_cap_mask_data *ff_mask;
>         struct virtio_net_ff_actions *ff_actions;
> +       struct xarray classifiers;
> +       int num_classifiers;

This is unused.

Thanks


