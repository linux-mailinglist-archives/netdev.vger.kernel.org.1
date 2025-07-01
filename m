Return-Path: <netdev+bounces-202733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A0EAEEC61
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 04:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6461A17C920
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 02:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E1A1A3155;
	Tue,  1 Jul 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XitJT7rM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F72E406
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336411; cv=none; b=YN5wozBRC9/NSTxHFh7rGi+xhorbhgDZ9vHfVYRlBQT8bQIuHOCdsVBgvhODKIB/jNOzEl1bXWTF4QLdTc/ML2RuSMfbllUa0Mo1NitN9JuJeDtjaq7rMU+c9oPZ/kaANC3eVv0NvZd2F5M+Hv9jlzQZ+GsVgWrK3vIbc/cqz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336411; c=relaxed/simple;
	bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixLf0RWleMvf4xhRfEyheaF+qj/dFJZ0EzR2Vqx51G6qydV1mCh9uuZCZL4gglRK4jxs+cZb+m8BH7PYMgTvwsFCugZyjuT1VuWStRc279o2de2fYUIgHpXHeRMfDMO5bNfoiiXVMIQiUCso9um6lF0OOkfQ0QkMT1OW7/Ya+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XitJT7rM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751336408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
	b=XitJT7rMcVfVnvFvEtiTtsObSRPFK+a70L5scblewEeMF8TbMA+mhgVzETLB0tobE4VrZA
	mbEOHWZYl9pEa70KxAP314mQdty7ITBqKYq2cbRKGpJHzIlaokjTde4rr7YypwAxWMJRI+
	ffhw6htbZjLLQUaMAjYEafXX3btQSdE=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-GRfNt-n_Ow-j4Jm33wBgIg-1; Mon, 30 Jun 2025 22:20:06 -0400
X-MC-Unique: GRfNt-n_Ow-j4Jm33wBgIg-1
X-Mimecast-MFC-AGG-ID: GRfNt-n_Ow-j4Jm33wBgIg_1751336406
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4e81805effeso406580137.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 19:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336406; x=1751941206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
        b=hA9Euw8m3Qu0P0LRlgL2qFEX7hIMDEcZt194s3RGp6J+AsWTPWS3GJbRgDLgQTqvqz
         VgTKZnJTubw7bUCm1Mg58EOJNM5zC7X2df4grOekQaEfE3gXPM/1XGfmnQWcUVQFrOB6
         p09qST5NkqLM5/X4T1yNbedDuvTUMs47oO1WFLJ1FLc6IUsJEJqiPFHgYrdysp5/7hVQ
         vOksGwbOoJPTFa6wTl9g2Oihnd0NqbjpNZFhjDixqsMugSfiod1HK3qAizTqRgwQxM/M
         QWyFqKLtMfrHTbtS0lau+BKVejU6wa1V/K3UfjYQ1fRhRxUNS3fkyYtyiYmnQ0HZFL03
         sUFw==
X-Gm-Message-State: AOJu0Yz0rcSifb7Iw8Nqn33bA8xCAr/BetxL4UZfNpktoyYIetkGAQfz
	F/eTmtWi82jbesnbWogm7EOCAwNo6b05va0TtnDx4CSJguF4KslwpfQUI9kMuSSLV3y3djIMziy
	LsmchUHt5wjUisWH/do/E5In/WMFpJSFoO0OB5hciZsRP0od/fzh6gfqrFkIuvr2KYTGZnPYd+R
	yVZ1ulJu4ZKZ0P+oSlCu6mqBYDs/fzafb7
X-Gm-Gg: ASbGncvNEokizMoCo3IqMQivfqN8p/Th+0ByHjMVmVY0J2+M+ET73/RVqIqeei0b7bp
	zMoebAwtaicAwxerTLL+3E76OYEBL7yb3aNBa5hJAEkDPqADyMWtu7K0oCrWA7uFowB2ADq7FxV
	6y
X-Received: by 2002:a05:6102:b0f:b0:4e7:db51:ea5d with SMTP id ada2fe7eead31-4ee4f57b220mr9035444137.6.1751336405998;
        Mon, 30 Jun 2025 19:20:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfwt0IUN9XzbcPTMYkve3OC1WK/0fpTeOcXovTvrlwz1DP2O24mIjCZg0vVcRzjUe2M01DvNuq273bCwcQw/Y=
X-Received: by 2002:a05:6102:b0f:b0:4e7:db51:ea5d with SMTP id
 ada2fe7eead31-4ee4f57b220mr9035421137.6.1751336405513; Mon, 30 Jun 2025
 19:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630144212.48471-1-minhquangbui99@gmail.com> <20250630144212.48471-2-minhquangbui99@gmail.com>
In-Reply-To: <20250630144212.48471-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 10:19:53 +0800
X-Gm-Features: Ac12FXwg9udMXpdfqk8skCNczA1b4cFLqKAJ_PlRVtyvo3Mi9xA6wAsp9nIVFQs
Message-ID: <CACGkMEuJk=PF2aGQj4FNhSv=VvOTzruK6PMpEykB9MVHwU4nDw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] virtio-net: ensure the received length does
 not exceed allocated size
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:42=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> In xdp_linearize_page, when reading the following buffers from the ring,
> we forget to check the received length with the true allocate size. This
> can lead to an out-of-bound read. This commit adds that missing check.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


