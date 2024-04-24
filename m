Return-Path: <netdev+bounces-90765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1568B0039
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 05:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F5328CA7A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 03:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA4143C60;
	Wed, 24 Apr 2024 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPztDN1k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AAD143C5A
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 03:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930745; cv=none; b=noV7/5e9Q+hCSTI7S2tnBSgblX0xcrVe6hdUdOM4wcMMIvZ7PEiNAYB7cSTeXZ7qAbnOvZxVCFtmaGnoyulHz/NC/Ar1/M0xYln0IcefeQQDIC/RN6p1K4zEN0rkyfdxeN7EW2zZ3cPcjud4zDrckLiqQa+7cre0yk3swN0WYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930745; c=relaxed/simple;
	bh=PmFXyGv9ORkds1kmwcp/v+wglJVZcoPaTmT0j8rNGkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiJLg4FHoGWONoOm9jmXLSS2o+/IaOZ4jm9SjRsNpilSj4RZEhCnlXdJtC3cLFmVWwXAJLe4QrOanc4ZOJ/X3QBlqwF8Bemvm6xGqLFc6uanhl6WczsiaflOXC5jAPSrxO/OyUFqzw51cX87CdFI5skAfKD0PaJnsAUZ5BL6pHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPztDN1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713930742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmFXyGv9ORkds1kmwcp/v+wglJVZcoPaTmT0j8rNGkw=;
	b=NPztDN1k7XLwlQrB2N+fvkBUfT+83QD11y9ifRBncie978rb3BV5p3+tf/RD9z1P7EPomg
	6L3BalqdO0WPDEarFiTDSDPwFK1LD/XJN5KsiqSElowjo1WjxqxVWoK/5YJ4Ov2RlMFD6t
	o4yVi3V1keU1IOCYNXUrQzQ9ZGE8whg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-xY0jFhc8MYm8qKFogxPjiw-1; Tue, 23 Apr 2024 23:52:19 -0400
X-MC-Unique: xY0jFhc8MYm8qKFogxPjiw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2adb84b10c1so405797a91.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 20:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713930738; x=1714535538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmFXyGv9ORkds1kmwcp/v+wglJVZcoPaTmT0j8rNGkw=;
        b=o2Sjk3yZM7amf9A+KbTFRyvQMhCAced3RAgok/4qAsRPxk5u7mZye0OajuL9Euqk0Y
         7kyHOxkv/TmJUflB4aWfjFu3diS1Qwa/8EelhpfzcQkbaXhC2jSGCFyY76KCsOIXgEMt
         lkgxbYYukCBPCmRgsvULE4qlmVkmCHx9ihEp1PQY9WjOooI2YiL77mBABzaTfH6npkzj
         WT2H8MLpNFB/Itzcp1cshmjdRN8YztYgnT6hIGLApAKe7lFS0xMd8D1/5I0gaJp11SoT
         KZZ8ZEJeB34Vs6CIcoP5EECl3wxCjYaR2nwukEyE7W/n3aQ9+YHB84iUGV4ggbqQ/IJd
         04OQ==
X-Gm-Message-State: AOJu0Yzy++YEfvjS8aMOTPD0BO+pATLne7EAHXzmtUqxfH9zT/JlHRlm
	jBNmwRpsfDL93KS/paeVTXEslomsrwrsFA55MZMo0JCy8eIPaFETXvJrA6iYRRjaoNjQQDctBVM
	V29HjvLmyY6+a8h/lB49qRXcoz8nCFJO+YAVo1ZYVzJj8yIpgv/mZn2vZtItdBP069GILkbzCus
	0uVbhGvJQ+DkPGcnMJT4W71mJ+PLXx
X-Received: by 2002:a17:90a:5513:b0:2a5:be1a:6831 with SMTP id b19-20020a17090a551300b002a5be1a6831mr6312916pji.19.1713930738073;
        Tue, 23 Apr 2024 20:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFLrt3g5mDa/U40wi6cTIapOPrwgf/9zjhcS2nWoXd7w7CUZDb45+Ebxt0xxbOVlMJuued25HbftoqyRRiNhs=
X-Received: by 2002:a17:90a:5513:b0:2a5:be1a:6831 with SMTP id
 b19-20020a17090a551300b002a5be1a6831mr6312888pji.19.1713930737759; Tue, 23
 Apr 2024 20:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com> <20240423113141.1752-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240423113141.1752-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 11:52:06 +0800
Message-ID: <CACGkMEv5di6XvjbgSq2Qz1f_SBK-sTiCyTRer8CvoMkuAWkaaw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/8] virtio_net: device stats helpers support
 driver stats
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> In the last commit, we introduced some helpers for device stats.
> And the drivers stats are realized by the open code.
> This commit make the helpers to support driver stats.
> Then we can have the unify helper for device and driver stats.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


