Return-Path: <netdev+bounces-174223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC9A5DDED
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BF43A8BAB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1898245013;
	Wed, 12 Mar 2025 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xeh4aymP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937C2405FD
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785969; cv=none; b=YxOyFF8eM9OyMPdPTG0o8QuY1nu5EVKDdirvN862Xzlycw/Aytk97NSGV0eHlHFkkSbesuklB+9mu6NbTW9iQZktw+b2Q3WQ4Gd0KxBWuTpK47XOIN+Z0R3RQZ9E8IVWZEjSvb/cytvQ6HtplWFAn/Vuo+R3ym0DYmUiwGF2Qnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785969; c=relaxed/simple;
	bh=wyQf149d956R8llw4X1LrAZYhPsEJG37tSDhhRLRm0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eU1kuLhaTQqQctCW3OryRBkf7FEbaaMDdx8MI5d0jEf4aCqjq0Ylq4H3fsiKvJHRmvpO3ol1bvBha4laTK580y92aYoPaCBBDujCuFGWSjodZFeo30dRZhZso626jTWw32uucNtkw8L8OCbOnMv+kyoWul9qK+L736U158NVlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xeh4aymP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741785967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQ83bVVAGBssvQD/Y/6hPy7fP259qfiYhm1/Pc6fLCE=;
	b=Xeh4aymPWnAp9ktdszV1mOYoPnpeu7ondHTdsqpmr57pyeUu+TOm/M65YQYC2GCKQzeeCR
	7HyQR1rSVjj9c8OEKB7zxrvAaqqVo0lYSMTJZ6TS+ZHCyW1rhoXxfDXKyNbaMaCJh1/CoY
	4BcS+hii1WHCeFV56XrYZhe1dQWbLP8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-G78kvMleMFyejyttJI9rcQ-1; Wed, 12 Mar 2025 09:26:05 -0400
X-MC-Unique: G78kvMleMFyejyttJI9rcQ-1
X-Mimecast-MFC-AGG-ID: G78kvMleMFyejyttJI9rcQ_1741785965
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac286ad635bso427678766b.3
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 06:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785964; x=1742390764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQ83bVVAGBssvQD/Y/6hPy7fP259qfiYhm1/Pc6fLCE=;
        b=Dc2y5XTQgYGMgGnRhi37blH1WW03w3Z9mZkcTTa5NtzddgFZ3Ki4MX/7JYbGR2ihoP
         qa11ZwX73+Qg5CPZaoEIaFAW4wiDqFCM/a1Vo0QzSUO22zkkJz0c+UqfkKZgEOb2OiM1
         2to7qX5Zo5nkgsHkmIbH22W4xPYD+tvLGXHqVOEwr3ghkpjQx/y1fDt4TN3m+6snhsfD
         p6W92i7z1OByPW21dXN2vuRCU+GulzE9E4VbCIZns1ahdxuwX77NQ0SCvu41VMbGLCiE
         h5rXgoLOPQ+B+dkbfYxN1O9jV94v7ZZHzGNJLUJfEtd0qi+Avv+1DRld2Kv3X/8wdl7+
         3h2Q==
X-Gm-Message-State: AOJu0Yz/Qmk1UXzsSQbCt7c8Qh0yV8aEBqQuxqSh1pXtlVrCP8oGkmQW
	Lsr6xqRE+btjKa+r7RVq4QTR1Omz9vSKMfR6Uw2WgTiL7srOgly1ZHpIUfrv8fMeiuRGw8SFMen
	tzh9AVoGbLShkxXUoKqIW8AwN8H81ylofgjGuWusDhjXsje+gs2W22ZgXwRzMIRmu3O3TTW4pYw
	Hs4bZ8K9RYoHRIQ/2TUIPEKZ2w8WL5
X-Gm-Gg: ASbGncsXKQk2ioKrvAois5Vpiy7mXF7Nt8yJNBsVmLckP/mFM9KQRQfWCwrvO1Sgyu/
	uc3zchB6q0XI5/pMP8GJ9E+BColfc4CdiGtJ5X7gv5yZjzCyY0etBWOJgUhRmcl+pHOK+4y4Z1g
	==
X-Received: by 2002:a17:907:720d:b0:ac1:db49:99b7 with SMTP id a640c23a62f3a-ac252ff84c2mr3037878766b.51.1741785964590;
        Wed, 12 Mar 2025 06:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwMmV0C2CCYv/294WVZ7TsbifUATtW/CTrWwwnLd8Mc6iFkeZiz9m9ZXV5FYCn/k4KDS2uoseHSkNcPerxpew=
X-Received: by 2002:a17:907:720d:b0:ac1:db49:99b7 with SMTP id
 a640c23a62f3a-ac252ff84c2mr3037875266b.51.1741785964271; Wed, 12 Mar 2025
 06:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311084507.3978048-1-sdf@fomichev.me>
In-Reply-To: <20250311084507.3978048-1-sdf@fomichev.me>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 12 Mar 2025 21:25:27 +0800
X-Gm-Features: AQ5f1JrgD8nNC6ElFILl5ZgueQ-mIyl58jJoTMkHTMUQbrKsbRA_yYhLcWmk3xs
Message-ID: <CAPpAL=yXhh+MUjJh2KvPhjESUGTQBnDRZ6tKpeMi3FZAtoCNvw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: bring back dev_addr_sem
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, jdamato@fastly.com, kory.maincent@bootlin.com, 
	atenart@kernel.org, kuniyu@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this patch with virtio-net regression tests, everything works fin=
e.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Mar 11, 2025 at 4:45=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Kohei reports an issue with dev_addr_sem conversion to netdev instance
> lock in [0]. Based on the discussion, switching to netdev instance
> lock to protect the address might not work for the devices that
> are not using netdev ops lock.
> Bring dev_addr_sem instance lock back but fix the ordering.
>
> 0: https://lore.kernel.org/netdev/20250308203835.60633-2-enjuk@amazon.com
>
> Stanislav Fomichev (2):
>   Revert "net: replace dev_addr_sem with netdev instance lock"
>   net: reorder dev_addr_sem lock
>
>  drivers/net/tap.c         |  2 +-
>  drivers/net/tun.c         |  2 +-
>  include/linux/netdevice.h |  4 +++-
>  net/core/dev.c            | 41 +++++++++++++--------------------------
>  net/core/dev.h            |  3 ++-
>  net/core/dev_api.c        | 19 ++++++++++++++++--
>  net/core/dev_ioctl.c      |  2 +-
>  net/core/net-sysfs.c      |  7 +++++--
>  net/core/rtnetlink.c      | 17 +++++++++++-----
>  9 files changed, 56 insertions(+), 41 deletions(-)
>
> --
> 2.48.1
>
>


