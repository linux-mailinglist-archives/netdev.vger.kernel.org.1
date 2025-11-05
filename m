Return-Path: <netdev+bounces-235645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B3C33764
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 01:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B98A84F1032
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 00:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1652423536B;
	Wed,  5 Nov 2025 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqNZSDw5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B522D7B1
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301993; cv=none; b=Nq25xSugJT8H4bPCO7PZ8OFt/7AJEcVmOD64mIzR7mR4jcVkSmH+NxFO8gyVj24a+u/+I6tV0VEmGCLGZb8PbA/kmqt03ceETm7EJA+i0f44I7enlCuNDTevVWpu2coEedwdYkGnDkID1HhBPB1RntjAe2Ii8FrsOd0oTzjZkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301993; c=relaxed/simple;
	bh=tPNyrSglXgzbTSxAtrtNr66B4b82eAkptaHPW68Y0SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhKCJmGLhrPKwKkijc6x+a3b9A6UqMu5gWci2BbdmjMRjhqkPRM0Sm4HgX7X+I2UPfLdZLtw1OlYZA2wtEQxhaqkg7ltaGlpKQjH2LUtyDOupsGQSteOSslMmNZurtcmk5ILiP2HRPANvCd1fQbVPRyB1ajwsm0/7bK3Vsk+dfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqNZSDw5; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-43326c748d5so1901465ab.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 16:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301990; x=1762906790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPNyrSglXgzbTSxAtrtNr66B4b82eAkptaHPW68Y0SY=;
        b=gqNZSDw5FkB1z/vsgXvvAlmbYiI4DAoGsT1ZhX+eVrPJYEIyi0jvIvtBLywc352qj0
         ZLlrO25aQ+QzYdegFTlh3akPMhyM8/Fz1lULTj87R2PHqgKtnu6HcytvVAN343QyimQj
         HEmKG0W5JEeFp1FMBKy9xCyNwyphsCeE9d0oAejVx1nQLw3h/6qFj3NcemYNPgGVuu4f
         kQZKFp1QjvRQvsca7rPJxFpoT+zV5Y+C5DbBeRVdgR189krev2t2YDoLqLE+CuGfLZQd
         Vyi3w1LdzLqGVz/zcb74b7qjw57YmSoIqAf4ilT0Tbxm3MLR3IijQ2OS9+zzJRd58kgf
         4tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301990; x=1762906790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPNyrSglXgzbTSxAtrtNr66B4b82eAkptaHPW68Y0SY=;
        b=jI8yEPopJntT7AFJjF9ik44sc4X4gKAArTOt/N+XanXL0Or5uQG9D3Jl37JL5JAxeO
         Rs4uLdwirAUDAX/OwZ7o+XXfaUYigOf9U9FU07nURqiE5GhtbAa/Y2WpDRocxwvYU7TI
         Fl9WrNQs7g61SZGgLDpduBR9wb5/zoc00X88DTPXukIU54i138tIZgHgKct3xuARbXWm
         Vz+9wNRdzHHKDLjWgLeKMYEkgeBMakDPT/yBp3ZR6vNDYzJHMrxa+3ICaTR4qA1qb+U/
         wMPBqHJxs4MwSZzNdjUnQOZUfQGiuEKDECpJDc3Jgjj8jDNguwhSrpHNSNYKUhhxB3r0
         Ae2A==
X-Forwarded-Encrypted: i=1; AJvYcCUcMKiNsC4RrBqWW3hBY6KWliILwnTAT101aZVAvpLy4uoTWJRI64YonRJWjE5DB1XBCAfv208=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGa85HSMuVIvwYCM5466K+87RibjI9ZeyrWyKZCOxhPyWPJzd
	3VtyNU6seEmpRKOXHFYR3sR5fxNFC1VBnlmmyoqdafxr49aU1NK5itlcUeR6Eda+uO0p8M+12ba
	A/I4sH2Ix4ujivO7CxrbVzeG1MEpuVX4=
X-Gm-Gg: ASbGncspaSOgfyoDxOhKPDbhcJMtC9IufRSvh1BWL9WoWT6E9T6+/pompQ6qaY2U9mY
	6COqIfUlav+l2qTH7mHEj7deLgs8q0KAVxhgpKWiu0zcqGHYYzZK0QeqA/5wx4j7f26V9DWzvL4
	YLwXvc/TdUD9/3QCXvxmG+i3x44+DFQc2PY3AYlwYsG/sKhQIYnXP+NGcVpMOi2ZOpMZNjx7NYz
	KiSHX1z9GuNrVUkA+dplAzqQpTeU2PCWKw0aeeDp/CA0dtck9fF9WgjLZgP4+U=
X-Google-Smtp-Source: AGHT+IHlKDGDIG6BMqjPpmMiXRElX7CmlqHBVKFE5hB2vstBzsdvMVaGUbKSbC7UrpLHQfFggPSndMWaqnea6GXPLXI=
X-Received: by 2002:a05:6e02:1fc6:b0:433:37e9:c1ff with SMTP id
 e9e14a558f8ab-433401a21c1mr24512685ab.9.1762301990514; Tue, 04 Nov 2025
 16:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030144438.7582-1-minhquangbui99@gmail.com>
 <1762149401.6256416-7-xuanzhuo@linux.alibaba.com> <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
In-Reply-To: <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Nov 2025 08:19:14 +0800
X-Gm-Features: AWmQ_bliMV8nE85ERHZI-EI4lokvoDwiY8yl4dOnlkgckxmIlBlgt3FBCpHKufM
Message-ID: <CAL+tcoAnhhDn=2qDCKXf3Xnz8VTDG0HOXW8x=GSdtHUe+qipvQ@mail.gmail.com>
Subject: Re: [PATCH net v7] virtio-net: fix received length check in big packets
To: Lei Yang <leiyang@redhat.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lei,

On Wed, Nov 5, 2025 at 12:56=E2=80=AFAM Lei Yang <leiyang@redhat.com> wrote=
:
>
> Tested this patch with virtio-net regression tests, everything works fine=
.

I saw you mentioned various tests on virtio_net multiple times. Could
you share your tools with me, I wonder? AFAIK, the stability of such
benchmarks is not usually static, so I'm interested.

Thanks,
Jason

