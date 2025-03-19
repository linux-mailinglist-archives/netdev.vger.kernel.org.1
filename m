Return-Path: <netdev+bounces-176030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E52A6868C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422BC3BF7D5
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FA9250BF9;
	Wed, 19 Mar 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqgBrrFM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87632505CA
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372290; cv=none; b=XUl8aaDlMBgT3Z9HCFbz4Id3WF/k0PCpJUYggyqc3XPRThiNNWkla2AsiTzCre1UOL4Cwg8HFckgeAOPNTS65uCHbJNIl/khZwCGHnDaZgxoLrxiJ/8QCB8Wpxoe5GfTTK/ou9SPyYKmh8muU5wX62hfuoWMDoinfWJ/TuOa0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372290; c=relaxed/simple;
	bh=zKCGYClygELnOz5kUrSj+2y/YlS9cO2lSdiPcMiRq64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7DQd5eI+gA+CWos4/tGz+ZuTcuBz+1eQB9qvGI2r7tS6sHRRcyJnooP/AwYZqLweh35A0OgcqTtL6dElPEM9Sk8z9gRoLTNw4K7/rwWkbLJzP7x30x9T3ZmVtH0TTDmAU61OJ1pzIBxXGgivFTfn37POU4d3KTKRMVEGFe/ykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqgBrrFM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742372287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4weFtyR8Vv/0WRgvwevHnBmwuMVQABx5dwojXYaS1A=;
	b=UqgBrrFMCR7ZBlynjLSSLIFF3ZfrXMxtDq3PEplMwj7J/yNRPKYMTiAtT6E2VwNJwQgreh
	rXXXpsjbDmZc2YK9RHPgkKYjEkJ0f9tMcJzt78h1b/TxSltQKhcHhf10mrrqwxt7GOeJQ6
	sWs9ViRBpzraZzeo1Y7Wf8m5GVlgS44=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-vf3l3_SZNWehi18H0D8lNg-1; Wed, 19 Mar 2025 04:18:06 -0400
X-MC-Unique: vf3l3_SZNWehi18H0D8lNg-1
X-Mimecast-MFC-AGG-ID: vf3l3_SZNWehi18H0D8lNg_1742372285
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e5cd9f3f7aso6829810a12.2
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 01:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742372285; x=1742977085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4weFtyR8Vv/0WRgvwevHnBmwuMVQABx5dwojXYaS1A=;
        b=GiItxTAvNsfpMfvfOuhg8EhO8dSMq90tzNatNO9y20aC9FNTDvAshs31r9+zIhf0SA
         zPeFrMi573UB7SDaIqTJUNDHDyrtesWbOVxBcmQhCbKjL4ZWNCx4+JRvCmIqNYwhnYZr
         aMqYlQyHSXH8ToPUiJNiPT6K5c28GQUrZqw7O0MTq0AXBcZww3A+q+ueST8T2Kk9pMj5
         sAah9Tto0JEfKcychHfoTcZY0hEDDYQwb7p9DsDn+3XDhiEGk7CwYoV2H87P1ypxJ4H7
         +XBUAx6177A/JGT8rPfqrG96VgHmSDWDdpQzhd96qndTqu9Qn9aLfJ/yFY53lhZ2/I07
         sM/g==
X-Forwarded-Encrypted: i=1; AJvYcCXbH/jDyKSZ3uA2yEPzTVLP3Hd/sbRskwoTCl/BV7sJ+bn1tkB/4kFzXC/dVBd9v9JkoyuMioQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1gbVI1XwzhWUb32h+8OmamRmpbR3QRoe2S2VfAH1PkF//QBP
	qXLL3zihsediIcx1ixKeNTkaXL34SPdUTzZTtabAPQ66sdxs0j5Zpp0+8nVQVZB7x+1gcbWqQ30
	Lm+9SN1uxkSISQEnz8TY6GY59IepkowVJrLDqPePGuiqgbYkTqdmJ+hgbSBJTpml2la5aX/ViL7
	0CcG8nXKWnhtFpJHpD1p+rt9MKRVle
X-Gm-Gg: ASbGnct+kNHMb+1J++Erasss8WldVtXNTHLvWvhJds3+d0M6Tz6AYWndPdc3pEpG0rs
	Rg+rcC6UgHOBSovzO/e4xmp3lh4Nbhq++d2f/6ayx5evpClWlNf9aA/vvFo7hc6Fgc3LVhxQSsA
	==
X-Received: by 2002:a05:6402:84e:b0:5e6:13a0:2321 with SMTP id 4fb4d7f45d1cf-5eb80f98226mr1528286a12.32.1742372285021;
        Wed, 19 Mar 2025 01:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX9nz4PdJIYgHPcBf3jCqH7Zjv1u+6eHEgELtuPU+YClK9V5WOHBjYADD5j90Xk8f2xxcCVZPPvbntyja6ch4=
X-Received: by 2002:a05:6402:84e:b0:5e6:13a0:2321 with SMTP id
 4fb4d7f45d1cf-5eb80f98226mr1528262a12.32.1742372284630; Wed, 19 Mar 2025
 01:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 19 Mar 2025 16:17:27 +0800
X-Gm-Features: AQ5f1JqtDok_bmysxOd31u7DWf9rtwBh16X9cCFBc9Txej8fP9FvAHet7aatDRA
Message-ID: <CAPpAL=w6bNxmsqpK7TGKM_YkQOLPe_w=D8_rCA6NsQCJCbHktw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] virtio_net: Fixes and improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches with virtio_net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=3Dz299Q7b4qEDONpYDzbVqhHxCNVk_vo=
-KdP9A@mail.gmail.com
>
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Akihiko Odaki (4):
>       virtio_net: Split struct virtio_net_rss_config
>       virtio_net: Fix endian with virtio_net_ctrl_rss
>       virtio_net: Use new RSS config structs
>       virtio_net: Allocate rss_hdr with devres
>
>  drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------=
------
>  include/uapi/linux/virtio_net.h |  13 +++++
>  2 files changed, 56 insertions(+), 76 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250318-virtio-6559d69187db
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


