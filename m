Return-Path: <netdev+bounces-160192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F21AA18BC9
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 07:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63893161603
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 06:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5BD18E361;
	Wed, 22 Jan 2025 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9znhGN/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB119007D
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526434; cv=none; b=onno3ddU6FB/ykgJpxxPr3qForxPzhNmRZ0z0AOzCAfWarrQJNTkXrOFz6KIbVEGoYt5VV6JM+fmz3InyA9p/oA+ltzKvwzgUEbz3P4GO/6mvmCVH5yp0UKGjPzJTpvf2CzvgSMU0sZOHOxRP5NQ3C3Lzr/gGdG1pLtk/x13p4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526434; c=relaxed/simple;
	bh=vjKbTn7w8K5WVElatg0aMdnqDfH3VnAXAE40M7XOEgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUo54Bls1NQSoQzFq2MdMg8k9UFxK6WVFH3W38/UiiUAuE2DzbfqJ31W4yCuxLWvoAo7RvM2UWFO595hnv9AW/kIBB4Zmo7ow56K1rzjUHtDp34oIH91GDK8pxiQ6YzakIEKyIDbX1343BGz++ojjy1Z0A4v17IqKwrQ+qNd95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9znhGN/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737526432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWN0QwZFJgBt79Q9qJ1KqnqceHCKjCN8oGypdv/f+IA=;
	b=U9znhGN/iVX2dgOMirRDUAyrJjJgNOCU0qOitp8dP5lQTHUc1cMQPOPDVAbgFKjeJG0zx3
	NzjqDTZpts8nBVZ/9ALUz2IfBt63o/9VplXkqrHvp8x0PdVNDm0JvoAPFHz0SY0yGMkEGz
	qjPoD7bQ4fW/E5cSO99Rvc+GFzSOeVU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-4N8ZQ_7pNiOwAa1aWAOHjA-1; Wed, 22 Jan 2025 01:13:44 -0500
X-MC-Unique: 4N8ZQ_7pNiOwAa1aWAOHjA-1
X-Mimecast-MFC-AGG-ID: 4N8ZQ_7pNiOwAa1aWAOHjA
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so17982874a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 22:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737526423; x=1738131223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWN0QwZFJgBt79Q9qJ1KqnqceHCKjCN8oGypdv/f+IA=;
        b=gsidqt5e9PBhqfrVKPMUvBA5dn2tE+v3g2sGNgy0FKWLHRT9tl+pEH4oBpj7Sdpf7o
         WH7wFuqYICuJlmlmCzjfmtZnZTurjbTC+b7R2F8bD4C8BOYOtix9KC01vmQhSF3pk4L+
         4up3qQcYldcPWf92fFdkIpMxJmv910LEfWYW2v2g3iB2t3DUDWy8qVmG8uLl30MkXmXo
         1VC+8lutpQLTr2Imi6pSlQd4D7oQNzrsVH3WGyWiAe5XT769FGB7voYHtaOvUU877UB1
         ObivO+K2QppGOoOUcC1E2U0IAoKsTEeH966d8JbEL2l+btviURNx/P3+Z9AhnUr0Hsy4
         OiOw==
X-Gm-Message-State: AOJu0YwuOHHnHG/x2GNpmCzMJu5b13D7jMTUPHMEzDM7ilajXKMcW96e
	jNCo48oBkM+oXQ9gSMF3Zi7Ud4uzNPaoGeuEuXW1YGCmn0lOM0sni4rw3b1fompPN0clndkUDVQ
	sF/2oIS69p/ng3gTWH1X8dZ5laUkSjKPnVoHEn9+S7409/dfbd1nmd0H+eM0eNJZ5n7g9Jg2PQI
	oIRx3V8Cjfcvzjfg+49TDb44I24J9v
X-Gm-Gg: ASbGncvBov5+mJGRg35B2VscTtI6Cb72hCoWB5qAT61kwRpVD3cyYQgIV9takfFNiCi
	J/ztsjoHssJOaD4HFDeVkDPoLHc/im+4YqLsilByu5WS6s76Y6Xzn
X-Received: by 2002:a05:6a00:2d96:b0:725:e057:c3dd with SMTP id d2e1a72fcca58-72dafbcdbe4mr26636807b3a.22.1737526423396;
        Tue, 21 Jan 2025 22:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYqZqsM0A60Mj6m99y3nE57/Un0/rci/Atd2ypW5XJwwcIh4GxWsyggmg8FPR7FLg3iPdMlBYcQxtV/egKO2Y=
X-Received: by 2002:a05:6a00:2d96:b0:725:e057:c3dd with SMTP id
 d2e1a72fcca58-72dafbcdbe4mr26636769b3a.22.1737526422974; Tue, 21 Jan 2025
 22:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121191047.269844-1-jdamato@fastly.com> <20250121191047.269844-5-jdamato@fastly.com>
In-Reply-To: <20250121191047.269844-5-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Jan 2025 14:13:31 +0800
X-Gm-Features: AbW1kvZKHfFCjPQ-bI46vnDnPUQynkrVL4hZbC_qPnyp29-XmFKBRkXp58xT_8o
Message-ID: <CACGkMEsymdUyZZom3KOpyAJA2mP1BNNq0+EN66-42ZAKhx555g@mail.gmail.com>
Subject: Re: [RFC net-next v3 4/4] virtio_net: Use persistent NAPI config
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com, leiyang@redhat.com, 
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 3:11=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use persistent NAPI config so that NAPI IDs are not renumbered as queue
> counts change.
>
> $ sudo ethtool -l ens4  | tail -5 | egrep -i '(current|combined)'
> Current hardware settings:
> Combined:       4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>     --spec Documentation/netlink/specs/netdev.yaml \
>     --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Now adjust the queue count, note that the NAPI IDs are not renumbered:
>
> $ sudo ethtool -L ens4 combined 1
> $ ./tools/net/ynl/pyynl/cli.py \
>     --spec Documentation/netlink/specs/netdev.yaml \
>     --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'}]
>
> $ sudo ethtool -L ens4 combined 8
> $ ./tools/net/ynl/pyynl/cli.py \
>     --spec Documentation/netlink/specs/netdev.yaml \
>     --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
>  {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
>  {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
>  {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
>  [...]
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


