Return-Path: <netdev+bounces-245931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2802CCDAFDC
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 01:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB5D23017861
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 00:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E9C20E334;
	Wed, 24 Dec 2025 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQLpaHYu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g62rC903"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47051F7580
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766537577; cv=none; b=f3d1sW/RsUs/7uyVoU/YyFMEpiPz2apPWe8EVTBTpzMt1ZH5b3DfD6pgH/C37An+f24fKtyPQJd1uvjwYplz7zLqpsocjo2Kpy6wW3Go30Ehru7RJ9EWA0yo9vbXF4+jzC9fQzV5imYWGPkTXsMWlAq5kAQb6w/lvN6ZZXpBnSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766537577; c=relaxed/simple;
	bh=po6RpdovHRdcPdJ7ye60KpUAACBfvE59Xqd+JhqKwnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sj3z+vDjpOdQqVMkEqxdGAIw/q+nIJNMULJoMd40AkOItHC1YrIIvIDZ1ACKqvccrp1g0H7uT0TWSvlvBgyDMu3Q1CYPKaEUT5FcUNZyf1wAtZ7Jg5LBpeGLbKqGRFFSc8jOKZi+2fagp5PbDNnOD1nBNYzkr0r0NV3WsxZOSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQLpaHYu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g62rC903; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766537572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=po6RpdovHRdcPdJ7ye60KpUAACBfvE59Xqd+JhqKwnI=;
	b=ZQLpaHYuxKWix0wOPqIluBvC3eMrwRrY3FhFandm7yAgH8AJ7Fb1+VcP/Drfmpo/s9ri1x
	PFtM4uLXalBisT4AfW6/8cWWbwoHFG3Gjw+KeMRPmxiRyUvNzdNjjOkLsLdIVdyemsRZJL
	fShjPeqpHnWhQczT4A41VBAL1H12MWw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-27TyNGNjOgaNfaJyJQIonQ-1; Tue, 23 Dec 2025 19:52:51 -0500
X-MC-Unique: 27TyNGNjOgaNfaJyJQIonQ-1
X-Mimecast-MFC-AGG-ID: 27TyNGNjOgaNfaJyJQIonQ_1766537570
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ec823527eso5173554a91.2
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 16:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766537570; x=1767142370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po6RpdovHRdcPdJ7ye60KpUAACBfvE59Xqd+JhqKwnI=;
        b=g62rC903dm8IXE2lOS4pwyMFXwnL8tdTrcPQI/x/e85UnBC8Cx+eOH6mfrDOmC5DkK
         lpE8qz+wFEhWYkW2+u3ZpU5X3b6cYrZ5ZzJEP8VZpY5+9DIYS9khyEv9Yd6iUKuE6+3S
         RPL8d7b00zraCCQw96fYTWvNfsO3/7eVLO5UAon6oq23yUfSwaXS6Y0SizuxQIvwCU+X
         ODE7KKiEqwvtmnq/GrNyxUMHiRCmCkj7vrjL9WSMo2D7y4TbM80MyY27LSZnQY+8mgQB
         1IOcFPodITXbOdIzkUFwuxYHS8cB+OKVK1rLukHTlGcHHr9msHDYFkT3RwbicK7hbhNk
         S5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766537570; x=1767142370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=po6RpdovHRdcPdJ7ye60KpUAACBfvE59Xqd+JhqKwnI=;
        b=HkOfZp8v61hju+wf1tGZs+xm5MuYdL7orT7V9h/PNRQZjD1wwvA5saQhsVhgPv/ja6
         WauWep3Bhej4jub5lixDGd4HsVV0f1iSItoChGVtCCxM/7FM0R7PpLnY7ZMcERHfhmEB
         eGeT+Y3VlSeBDjinK1ai/Dm/sJ7OENXkdJuJSN/vHpP0eJPAU5oBbzCxIqzKpFRH0ieN
         bg8ILpkpZgFVPNEdeHUXdRrzo09rE8gWZOh72sw7veT4QkI4SGINIZ3BSZ+Sgmo5NAGO
         CnN+xV9hmlI9Is3BmvC3PWNGg/u0z1w4OpydpjFoQ3vLa2UlvscOx1CNU1/dRpVPnniT
         ZCKg==
X-Gm-Message-State: AOJu0YyIevLxpHCm7Z1rem/vFPk2S8W4e2dxuNK454X06pobU2ooGseq
	+6kdE6r4eD4Dm4cgyvQhv0Uv+S6twAQqvVL36rZiVHiaill2YCE5GW/mbakE2dCocgdH4JMTAVd
	aiKYO3xTkR33MesU0xceWG0CHMxsHzfeQW+sKO4j7m7Eu37XZFl/grwxSSUO835/1GhTLcuqI8y
	/fGNEqvwDbYEQ3oROg+lEtAceFIHy7XOVR
X-Gm-Gg: AY/fxX64/vI9y6ztyMtmA1qvqj20k7pLTg8Zn2YfL6ipWV7/Uxh2BwliUT0quzyIzFS
	Vl8E72Q4a42RVG+9jqyDN5yV6v1WWnSytyHtneFc7rQLBtqzkdiQJp7NV+5QWYJcKBfpuScEiOr
	NUxg4zZUwUfdFgc8KddIjknhOka9r4II6VnSLTFYWv+WRU0YSYdLzG9mYBj9J3af0hYBU=
X-Received: by 2002:a17:90b:56cc:b0:340:a1a8:eb87 with SMTP id 98e67ed59e1d1-34e921f6feemr13113370a91.35.1766537570560;
        Tue, 23 Dec 2025 16:52:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF+noWfN2ySEUI8GZb3Ntf51HoydRghcYL05TuV9bQ1tdT4T7RAnx9LFZiea6uBQnWuwOmdQQ+4Kqavimq6ZU=
X-Received: by 2002:a17:90b:56cc:b0:340:a1a8:eb87 with SMTP id
 98e67ed59e1d1-34e921f6feemr13113351a91.35.1766537570192; Tue, 23 Dec 2025
 16:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com> <20251223152533.24364-2-minhquangbui99@gmail.com>
In-Reply-To: <20251223152533.24364-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Dec 2025 08:52:36 +0800
X-Gm-Features: AQt7F2oh4rVbS-8aQ3gvuoAlLwJB54Xn2U1CBKxMODTcXeAZWD0c1j8udrn6yHE
Message-ID: <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 11:27=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Currently, the refill work is a global delayed work for all the receive
> queues. This commit makes the refill work a per receive queue so that we
> can manage them separately and avoid further mistakes. It also helps the
> successfully refilled queue avoid the napi_disable in the global delayed
> refill work like before.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---

I may miss something but I think this patch is sufficient to fix the proble=
m?

Thanks


