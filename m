Return-Path: <netdev+bounces-184326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44D1A94B52
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 05:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0888516FA52
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 03:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF81256C90;
	Mon, 21 Apr 2025 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YT8f8E6q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B6256C7B
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204908; cv=none; b=ovqvs5F0frnG3vutum7ZaiXa+xa6yuA9p9TvPObXS3zzSl/qpOlRzifP8xS6XNAUTN548uQ7FMD4Fl0/b6JYXRkxjpc8GFy2lXQWsYeGpd23+FbiDfvbRPSOIZchZswym0WU9/ptd66j3Ef/vx0bjocA6pjXeVwFvpzEnUwBSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204908; c=relaxed/simple;
	bh=8hivAmNLcvTNx0c/bREHx35jQBHl8GSDmzWxh1wjb3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5Jtu5uPKt0lRwrxSZZl9S9NOaAOxGZkseW1dA/J7bGiQhey3d6nlXuwIZlpSWOfEy5vX0FSIqGRUfCHosjQ5gFRkXJXq3SZT84bVPe+kbOqbimJKi7Y8ETy/mcwlyy27o9tGnVh1F6a7+plWXxgUOi7D7boNIjPY4la9LpUnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YT8f8E6q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745204905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hivAmNLcvTNx0c/bREHx35jQBHl8GSDmzWxh1wjb3U=;
	b=YT8f8E6qZwMh3xSTLCPq4AvWpGUyXxTwEULnxpFUQjvHrcC608BJJ7vmuIDlMDXLdXrC39
	D4Ow+AHjCRimbHQDOx+za+dtMV1bRevXd5F+0InKj1tog4ypcJ4lz2GndjBBiLmwfmFNtX
	GVqk0rnU+bBaFfCU0q/1ylHygINiupg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-0Kmtcf0QNnyW_P3wRm98cg-1; Sun, 20 Apr 2025 23:08:23 -0400
X-MC-Unique: 0Kmtcf0QNnyW_P3wRm98cg-1
X-Mimecast-MFC-AGG-ID: 0Kmtcf0QNnyW_P3wRm98cg_1745204903
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-30828f9af10so8072243a91.3
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 20:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745204903; x=1745809703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hivAmNLcvTNx0c/bREHx35jQBHl8GSDmzWxh1wjb3U=;
        b=NQpKETa8pWQWrPnZU6/BVrphctW7SfyHHuzUKF0yZQxddsPvGHf+w02OdgsPOUHSSH
         v45zqiCbPSXpLEkmUE/I3ePb8I+QiGwhX4WbmKyyySrTlqRHLDoI2uUAC11BRM7sSY4S
         nlWFcUmzWcS/lnTxpwf9XKppjY1fsUY2IZSTzUmkgxfwmikRGm3MbufFiBgAtxA5eSJt
         5giu/DVToYbtOzF1BlVC9w/dlGtJQ8D+fE2Nr3MdFA0b1Duq/Hq9JDXxaNlsVZvVJ1FJ
         +mvsre8nuf5SMuO4dEwwSMbbz3KrI7l6/QehNPF0DucggmxiAMYUDLqjNHvdsD9RrXVA
         B/tg==
X-Forwarded-Encrypted: i=1; AJvYcCV4rP4qci2xEbI2qsj6ce+0JvSNJCGPmJv5ZeepQUix1XM+M5vFZHBsrBKXaoZiRWLhCJYCUrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQJsAAePD8hKyVUOX3CtB8cSlLs9wqifJd/vUWS7ZUC2gUSfE
	3b00PtdQUXW30FCm8USyC0jWm0ndBs5gziY5LqlU0ijvvnoOJK1bUkdL4ekQuafqD7TZXQVco9e
	EUruZpK+k9RAKRZPHK6wAHhbx7pey3SvlB/1VfPsSukt8u6Ap4nToszjtAX+SWJ8WiuLVTK5th3
	EshNXMpOlpxZp4BHJGAzYkZiq6EaHL
X-Gm-Gg: ASbGncuoBkkNQqkvrmoxZfXQGt7TXk0v4Dpmvd/zvDiTqBypsPH0zdwyG42hW69lUVH
	1ux3x7s5mnlSdUeAFlL0ocEmsKgISPnKN8PKdSCKQZKp86O+lptuE9bw7SmFC0fijbD6NpQ==
X-Received: by 2002:a17:90b:2ec3:b0:2ff:4f04:4261 with SMTP id 98e67ed59e1d1-3087bbc9485mr12662281a91.34.1745204902900;
        Sun, 20 Apr 2025 20:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsGZidodHER7DPx6AJsb5qX7z5X9GlyzJiQZloe3T04D2Jm+L8lzs+jE/AE1c2bmOaTmkFYJEYHB7563A5Hac=
X-Received: by 2002:a17:90b:2ec3:b0:2ff:4f04:4261 with SMTP id
 98e67ed59e1d1-3087bbc9485mr12662267a91.34.1745204902583; Sun, 20 Apr 2025
 20:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403063028.16045-1-dongli.zhang@oracle.com> <20250403063028.16045-5-dongli.zhang@oracle.com>
In-Reply-To: <20250403063028.16045-5-dongli.zhang@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:08:10 +0800
X-Gm-Features: ATxdqUFK2T-i_sGgdtK1QZ96gsa3IRjAzlkSfDUbg2Xu7DWrfBlUunqWMett7BA
Message-ID: <CACGkMEsU2nnTD7akj8im+UBYMjbyyUSAq7U9+uVS8_USAK81eQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] vhost: modify vhost_log_write() for broader users
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 2:32=E2=80=AFPM Dongli Zhang <dongli.zhang@oracle.co=
m> wrote:
>
> Currently, the only user of vhost_log_write() is vhost-net. The 'len'
> argument prevents logging of pages that are not tainted by the RX path.
>
> Adjustments are needed since more drivers (i.e. vhost-scsi) begin using
> vhost_log_write(). So far vhost-net RX path may only partially use pages
> shared via the last vring descriptor. Unlike vhost-net, vhost-scsi always
> logs all pages shared via vring descriptors. To accommodate this,
> use (len =3D=3D U64_MAX) to indicate whether the driver would log all pag=
es of
> vring descriptors, or only pages that are tainted by the driver.
>
> In addition, removes BUG().
>
> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


