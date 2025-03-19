Return-Path: <netdev+bounces-175978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D4A682D1
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 02:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0CE178425
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A3424E4A8;
	Wed, 19 Mar 2025 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JT1atJyy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5824DFF8
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348599; cv=none; b=KU+SFsf+EPSWIw4irI5ICPRyMvCyBLIZN8xoYM/eTc4Z6m0FFNMrBDMAOWbCSkiuVUwKhdNsB9/acPsedXwPait+smQrwM5tY6H+OvUE+DbEVmwUC35mbMYnmVYHJfmNKwbD0AEYRqVbVpdEtcsPKUWFt1GkozU4WhdyvuwyV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348599; c=relaxed/simple;
	bh=GV92ClXjvz4/MTW4YP/XSUB8BPHIDGjT8AUblei2M/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGl4SoiGskdOQtxl/yms0VWsOpnrb7RHw99ci5Diute9uBAnkXVQSzfnp+nBqwFMPNrOti4FZJd//rbQRhGV7VSGtHyeQbsFZyGt+WoM5uiak/ZDKG8ClR/1vc7Tp9U2LS0YQnOS5OI6iwOwDUCf5cU59mOhyGKWuTzZBgEGGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JT1atJyy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742348596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GV92ClXjvz4/MTW4YP/XSUB8BPHIDGjT8AUblei2M/Q=;
	b=JT1atJyytt/MCz6/T+MoDyP65z2G31eFIJ/g330bDJr5oLl5jAGPIM3OMBb+E5rtX5sTgQ
	uIrvG/FGA5WV+UsEHdqTw839n6mGuPalHc850/88e0Ou6g1slZ1zxf0KeYQuD9o00uS4xq
	UB6s8yBtX7hEbyaz0G9bmb1uUbxMZsE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-jkTTNH8DM8ep4jcngO6tmA-1; Tue, 18 Mar 2025 21:43:13 -0400
X-MC-Unique: jkTTNH8DM8ep4jcngO6tmA-1
X-Mimecast-MFC-AGG-ID: jkTTNH8DM8ep4jcngO6tmA_1742348592
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso10359821a91.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 18:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348592; x=1742953392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV92ClXjvz4/MTW4YP/XSUB8BPHIDGjT8AUblei2M/Q=;
        b=VLt0k1RhB58T2mwu8MoXoyQx8h3qDm1mMazNjLEIbg/SMnufukH1JwdUMwvgULRsTf
         R+xQsjkdoV8LRx6Keqi5sBULLyZ4MrQpfrkqgdz2QSUstasSiIYGpb+80F+/c4j1UPE0
         o3TEJerK1JaXKiLnxfw546TiNUA/v46FToaJZ88UW9Qusx3ycxazWqeECPD2TWKb1iBD
         Z0bnivgmxxgRyh1N9PVgifpn3UjzTSju5+ssv0pZVJbfKqGpnvPArGLGfFQFIF0Lpfpf
         gizP73kIcs6rxpYGnPjQb6zTq8JewVrA7BeD9WDbH6WnxrNy3JURuY9y+j9z5AcvIAbP
         8MRg==
X-Forwarded-Encrypted: i=1; AJvYcCVFO7YTILN5mUDeUaFzJTC8bqArnX13kh3HF06Qjzuz4BSWjW2uKYOGr+ZULd0tMTSmW0R4Ebw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/wjVNsG/2duGA//RWf7rDeOSC8IhM8CUTEJQohu0E74cJZqD
	vsxnBbgfsQ31LmSflN0Fvy09plf4pYrSki55szvOkFwS7eGRTMgZj3OJRXklGrz4vpwHtRZ5bdE
	ZmA8JjlzlmZt/NzoXXyUHTgO89Ok1sQFaQbNTTnkuoQSf6DZcKR894ff+1FuAuqx1c6qNwxJDvY
	hbZBb3V5OFUNuYsJlS+zupvy9Pz0SZ
X-Gm-Gg: ASbGncttLa06VRs3zkQV19CurdKv5aLg2rcLyKSuWMLq4nuAzwduY6bKWAXUu44IP3D
	g8FfnbcCHWLeWGdvwjsckSZPTyB/WG1k2nis0B6HRnhP5uFd/SIsRJHpuwZ5Np5W2H8b9vbFs
X-Received: by 2002:a17:90b:1811:b0:2ff:5ed8:83d1 with SMTP id 98e67ed59e1d1-301bdf8fe6dmr1172322a91.19.1742348592282;
        Tue, 18 Mar 2025 18:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3xUKmc/HaZKbY2Dl8pCa58A8bYMdk6rBE8YTKkC3nogLq+BbetaOi+Z7lREjD84lMdYnVJXjJq88sniZ07Ns=
X-Received: by 2002:a17:90b:1811:b0:2ff:5ed8:83d1 with SMTP id
 98e67ed59e1d1-301bdf8fe6dmr1172297a91.19.1742348591933; Tue, 18 Mar 2025
 18:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-1-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-1-344caf336ddd@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Mar 2025 09:42:59 +0800
X-Gm-Features: AQ5f1JotJK4za7GHDUjLaHu15ZgN8MdATNrjp2GqHsHDNV3hc5BHA8yY_muRp9w
Message-ID: <CACGkMEv4EXUcZ68SZ7RzKnJ1+etf4jvqLLUG9-dXUDc9jSsOiw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] virtio_net: Split struct virtio_net_rss_config
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> struct virtio_net_rss_config was less useful in actual code because of a
> flexible array placed in the middle. Add new structures that split it
> into two to avoid having a flexible array in the middle.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


