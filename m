Return-Path: <netdev+bounces-167602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED2A3AFF9
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 04:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4673AE8DF
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD1191F6A;
	Wed, 19 Feb 2025 03:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpeqnPpY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85A54648
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 03:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739935078; cv=none; b=oWyPCgwRT/ABVRvY4nDHH0ZNYKIdwn2q+II06pf7jg2MuC0E/4P3EDuUc0ReeLQCN3SwOA35nUAzws/FMe1pHNruLnFbdd0xZval1APPWPqz/jDXkvwWYGIOqHdlgjx8fbU6lfKirj6mO0b5//lD6PbVS+SD4ceWAyzD4UMPglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739935078; c=relaxed/simple;
	bh=AXiI9tXfD/bRXn+8Y0AETb2ngSu6A5KTjMGOKhztDro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlTcI9Vltgo/sSWtHbLkcGpx69oNWUyPerjf7s7SabOilN3vOrNze1/RV6uCYFoYdIHvj8D6kciGqEgxHT7gWRy1wx50L9WrG9Lpm8ZMRoR7l0i3lcIqAL/EKikJor7ucdscO0hcLutuhl3VPaGLAQGyuqv6e/rMwHOVyHByslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpeqnPpY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739935075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKadPNxi6muCmVb//eXomLPYTLJo7paJFVc00B3IJME=;
	b=CpeqnPpYLoD+uhqqkS71OGJTk0coyhY5s3pn7UjSM7ytQ757zSwHKxd8dg81qiDeXqj1tG
	dOxyteo4EE5tt3c2EN8Uuhk+8DJnqUjRGt1Y0KjqwL+xUz56FF3i5Ay0c6NYaT1lea3cw8
	8To/SiIgk0XAXn7Qri7j6oASwCT33N8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-h3Q6vvB2NcW7-lyrSsBuWQ-1; Tue, 18 Feb 2025 22:17:53 -0500
X-MC-Unique: h3Q6vvB2NcW7-lyrSsBuWQ-1
X-Mimecast-MFC-AGG-ID: h3Q6vvB2NcW7-lyrSsBuWQ_1739935073
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc0bc05b36so19913039a91.3
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739935073; x=1740539873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKadPNxi6muCmVb//eXomLPYTLJo7paJFVc00B3IJME=;
        b=oDDo1fuwYsplEgBX/Tfc1XSVnUYQO7hr/XyxeMGtqfI2w3/7DBHK0N7sNXVv6eOWTN
         37zDqCFqoc+aJm+OEzDbwblJ0pPPFFMxlbWV2/nAgCAsaKhPs/nJHtZ53LAHGkRXbLcO
         VApzwGvzALcoiiuUfIz21BWAYhBpGMW5/3njCUmH6Gj0qhkGQUVXC/pzKUBjHEu9JREN
         lRoWgJQFoQbdHCs6wWEGfqJvb+ukuhc1DlyBsMpEa7klxR/5/PZ1Z5xr7CjyNK58te2f
         2TdeSkEy4xU5vyseALVqjkKHCJB5wSw8CWD8U14FEuT0jdmLZEhRSHu/pNY+GCNaNKdl
         22GA==
X-Gm-Message-State: AOJu0Yxpbcf7UxqIY2+rwwJRuE//Yw918JJduUe3bTrn0qR4qkh8JQqW
	26gfOI8YsZ5Mk3pP3z0id25a5WYAQPvmxrzcexjbCYHTMqhtQwt41Iw9jnyoBlU53hLXGUqudTx
	et+GYvbsVyl75HRHrzOLh75bXvng0wnSJRvj53rJZo5HJzCr4le5nhUsKLYYBWdEzj3FPXNnZWn
	jC5PkUKFdOGSjPIDyjFPrE5lAe1lbu
X-Gm-Gg: ASbGncvaEBdWMIda2FILWd/EOXdpkmcmW9cw3Vhjlf5hjS9ChhSLZEpnpy2Q5iAlcsz
	i7uOh2Spfrdv8caEWF7Bqtqt1WG077cOh7V4HCAYm+r9BHr0Ku9u62Mih0MDKERE=
X-Received: by 2002:a17:90a:f495:b0:2fc:a3b7:1096 with SMTP id 98e67ed59e1d1-2fca3b71328mr6689798a91.27.1739935072847;
        Tue, 18 Feb 2025 19:17:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6PN3buhsj4JUJy+Dzc+p8dgfIJT6zMzIfOOj/oagvGFTtsM5768bTiKiPfmJPIJEOxIzO0imrO6+0oAlHP4A=
X-Received: by 2002:a17:90a:f495:b0:2fc:a3b7:1096 with SMTP id
 98e67ed59e1d1-2fca3b71328mr6689759a91.27.1739935072464; Tue, 18 Feb 2025
 19:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de> <20250217172308.3291739-2-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250217172308.3291739-2-marcus.wichelmann@hetzner-cloud.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Feb 2025 11:17:40 +0800
X-Gm-Features: AWEUYZmQkycRwSOsaFbHJhebPYbtJJ3xrSXwIHRYXHCed3Hqat2E_8Ie-BS422U
Message-ID: <CACGkMEu0amsUNZS_EoJc40B=av90OJkpivDw3vCWwYJYAB68kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] net: tun: enable XDP metadata support
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 1:23=E2=80=AFAM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> Enable the support for the bpf_xdp_adjust_meta helper function for XDP
> buffers initialized by the tun driver. This allows to reserve a metadata
> area that is useful to pass any information from one XDP program to
> another one, for example when using tail-calls.
>
> Whether this helper function can be used in an XDP program depends on
> how the xdp_buff was initialized. Most net drivers initialize the
> xdp_buff in a way, that allows bpf_xdp_adjust_meta to be used. In case
> of the tun driver, this is currently not the case.
>
> There are two code paths in the tun driver that lead to a
> bpf_prog_run_xdp and where metadata support should be enabled:
>
> 1. tun_build_skb, which is called by tun_get_user and is used when
>    writing packets from userspace into the device. In this case, the
>    xdp_buff created in tun_build_skb has no support for
>    bpf_xdp_adjust_meta and calls of that helper function result in
>    ENOTSUPP.
>
>    For this code path, it's sufficient to set the meta_valid argument of
>    the xdp_prepare_buff call. The reserved headroom is large enough
>    already.
>
> 2. tun_xdp_one, which is called by tun_sendmsg which again is called by
>    other drivers (e.g. vhost_net). When the TUN_MSG_PTR mode is used,
>    another driver may pass a batch of xdp_buffs to the tun driver. In
>    this case, that other driver is the one initializing the xdp_buff.
>
>    See commit 043d222f93ab ("tuntap: accept an array of XDP buffs
>    through sendmsg()") for details.
>
>    For now, the vhost_net driver is the only one using TUN_MSG_PTR and
>    it already initializes the xdp_buffs with metadata support and
>    sufficient headroom. But the tun driver disables it again, so the
>    xdp_set_data_meta_invalid call has to be removed.
>
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


