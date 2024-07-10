Return-Path: <netdev+bounces-110494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34FA92C966
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 05:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BBF1C22EFC
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 03:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026533C6AC;
	Wed, 10 Jul 2024 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxnM8kKW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E593C092
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720583096; cv=none; b=HbxV4BwmVKydxRIXm2DNi6RwY1KDz6abRBopdOAzyqa4vJ55u0R5h09g2w5XUoV1h+fmwytj5P0ctrL9ZxzP2MrgtVPuMi/xWpp7C+6dttqahOVevcRoPb0Hp7pWVVsL3g9t1nJlWuvXBjHcrhrvYAQg2jZv6RIQnZb/SK/dURo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720583096; c=relaxed/simple;
	bh=i62hVybCBvOjhHF8NST7W42rhOG39vIkacaC6aT/xoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCGT3rPOqakxSS3LhZBD+BI8+vG6fPEMjceHNyU21XWAJYvsaryjaSNQecwSWlVDH9J85OpSKtgx7C9qoyDd5W6Og7dcr84zQLWa1cB98pvU4ATo5twQgA4DQcISjh4Pj196nCse+O63ZBmhYK6Wxt1oHS4+DVssGTkyCDwqMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxnM8kKW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720583094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i62hVybCBvOjhHF8NST7W42rhOG39vIkacaC6aT/xoA=;
	b=XxnM8kKW829EOmjLUb7AOFsqbgPaL2UwleOIkxKppnHVdq3GLeWeEfutP5brOzk+ZMH4Mn
	h/fVPy31XwTJ2hT+KSsuaZgnqWB0e/nGCwsmYQmptLlBtwf0YVNU20B8Xuwum383Gsjcw0
	QRjUfi5aFbD3cB4moJ0scSFhtwTqH1U=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581--JKTCZ24PaqwRZwRD8oBEA-1; Tue, 09 Jul 2024 23:44:50 -0400
X-MC-Unique: -JKTCZ24PaqwRZwRD8oBEA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70af603db29so3787624b3a.3
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 20:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720583089; x=1721187889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i62hVybCBvOjhHF8NST7W42rhOG39vIkacaC6aT/xoA=;
        b=PlzwcIWkif3LzlzZyDdvwXrIW2XGE3soGu7LtkKH9kk6B29ZgnLTiDBAafnr4dUYwb
         4MmmiRWM36SO56b6AnhwJzz4cS/Nva1nmC0Mip3EZ2HbmKScDlW3Vw3Ee0PGTpSfbLmP
         49cf/VLuRyMniXwN7wUkB/S1qtVwZWF3M2RtRoJHKUDDA4GmWS8fZMz/XbEt77n8maCd
         hXsOx4jtiAeOt/9uTNTHeExbXJq1gGnml9UcOlax4jbMzEWOmNjae7+3aZMJElZXEtmS
         U4z2DlD/L/HoQt4nw4zGxlMaF4Lh26rLFahInjrVdxiGzEJgnaI3A8kZJNtBmAky97hD
         cu9g==
X-Gm-Message-State: AOJu0YzNz9APYUsiNnh9h5QIVGzgFmvIZz1sSkNHwRKeFDOJl7TmLRxe
	A6Dw8mTq96gq5E8l74vu6CVxcRB+QKd+seGgQNK0Zi+Kpau2Izq6499Q5mjsD+D59S3CNt6lLEz
	bISSGHqJ4d4e9A+CEyo26c00wQEKrwTwF11sIZjDljASr0fBku2wIMaQ+pas51CamXqkQBN4s1T
	JGM4GMtUWqkB+8Xeaq17t6FZNI1Mf6
X-Received: by 2002:a05:6a00:1304:b0:70b:141d:4a9a with SMTP id d2e1a72fcca58-70b4363223cmr5525296b3a.34.1720583089391;
        Tue, 09 Jul 2024 20:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6DK5RquFuxm9UxpTrrMYhpGVKkxyGGgB00e7KDYNJvf+PSSaHyWY1Zlws4I2c/WC4UdEyl5u0hefWLqdOSq4=
X-Received: by 2002:a05:6a00:1304:b0:70b:141d:4a9a with SMTP id
 d2e1a72fcca58-70b4363223cmr5525274b3a.34.1720583088933; Tue, 09 Jul 2024
 20:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com> <20240708112537.96291-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240708112537.96291-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:44:37 +0800
Message-ID: <CACGkMEtfd7ndOZt4M3j7yNUVYtnu-c9n02He59Cq+1_ML9bEDw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 08/10] virtio_net: xsk: rx: support fill with
 xsk buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 7:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Implement the logic of filling rq with XSK buffers.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


