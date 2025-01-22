Return-Path: <netdev+bounces-160191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 561A9A18BC7
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 07:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3E07A48C3
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 06:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C01518FDAB;
	Wed, 22 Jan 2025 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYlgTkIL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8554190674
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526409; cv=none; b=kXpDSI3a/FR2+mlmNiiLtICQcPSP/Mwkgur1kptBy5/O+P+RwegP4S00MgCBKT1wF14TmU5ktf7akinom8lkHJ+EJq1slZ7dTMG6pqgPqMcKgxFDVxkABfNa9QG5zYG5dNzY7N/A2A1J5Hpbm4m1IqasU3jBMGKlmHeXXmFIcPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526409; c=relaxed/simple;
	bh=N4VHTOiMr1QEkoUwXNcQJva4+4+xsiihj3nqW8BwZ+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iV1sLB64FPjEUoDekYZ6QILIVLo+H8aGaJR/JtnIHSA/nn5LxU4diEzLHM+bbUx4loOXMCW5XpFJcOY1lr8UWMpusjZatsa0mmdZaTt/ZGt5v4qbiuwVskTCxkpPFrBiyctawEHa4YEHYl+I5/8xpYvzXE+hUzwhXnecc5uoQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYlgTkIL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737526406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02nNA7RsZ956EniYLNy3FanK3JnNwTY1mjUMT95zUi4=;
	b=CYlgTkILmdX1rlfH9y34WQF8QBblpKMSFR5bBe/1GyNkTe+8AKsvDvnUo6rF0jlM4VY+kD
	VhUdCmGNBW9DlQgx0MZLUALIg6JBaI7WftCL5tF7Nnb74S0guQnAUTGolJoPJLQ6KwH8L+
	IRrLpOCeFgwJ2J1cCrGCFSQxkZypKAo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-umaSEipgOnWbNn9Q8B2Glw-1; Wed, 22 Jan 2025 01:13:24 -0500
X-MC-Unique: umaSEipgOnWbNn9Q8B2Glw-1
X-Mimecast-MFC-AGG-ID: umaSEipgOnWbNn9Q8B2Glw
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so12220129a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 22:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737526403; x=1738131203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02nNA7RsZ956EniYLNy3FanK3JnNwTY1mjUMT95zUi4=;
        b=SmIFKTJEkLW0u3dUT/qfNpENSoUa5WCH028b15jXon8dL6jA+3PZK6Qi9QdifsI0j6
         UooJRdNRtpHJ7bD2U9wHdddx6+p5yn74s54JulXLXbC+jbcmSsEQg+wDcg4rJrrnblZF
         n8lsdL7HN38J0qUxu2MecbgfVo+cQPCL1Q4VwA8MnM2aLbWwmJXmeSNeCqHfGoi0TJnl
         wPouH0LZqci74P03KHBYVBPs5KHbxyaIaQZBbNy96Dbe3X4THukqYCQ2DJ18P9cpHb3/
         SazEsVpAs7I4yap4Q2/GwgWFHk2ichsJOSuUdX4f3FKFP9CE62Q5iHffLXgYby3cyJ/Z
         7EYA==
X-Gm-Message-State: AOJu0YyXxpCX3p1KtN/6WolCvaVV24bmSq3azQajQoLB8j01zVIoXMR1
	B8JbD5GiwngZPACSWoHCBsQYtt5qKWSwAvBpzNvQsbBgG4pasraYzTKfECWRV9vzm50NIqwXXaP
	hYSiqxEz9jCfKyqH92ifQnP9wlRnHwI/pe6AlJmP+l6SO/SrrLk7QGrIJrFuiTQ4H1zZON638N5
	XsUv+URB8v/N28xpHNyu6oBO/+8Grc
X-Gm-Gg: ASbGncuUjmvaH84Y3zTuDgcD5oPWNJeAO9B00vTQ93mp8McAxEgLjZuIIT3BorQaTWt
	HHUuG02Nogq0RTKQtI13fXZqkiTJ5hXVdLIukFow3LNynuBgQLh+t
X-Received: by 2002:a05:6a00:2448:b0:725:322a:922c with SMTP id d2e1a72fcca58-72daf9abd78mr33122211b3a.3.1737526403543;
        Tue, 21 Jan 2025 22:13:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWZ5jD+lVwVZrfUOdJgzO9VY01R80mkMlLuikBRjnx/qrJv98YZqo4Yk3EacdxygEGirjJku2kd0ZHp3IcPyc=
X-Received: by 2002:a05:6a00:2448:b0:725:322a:922c with SMTP id
 d2e1a72fcca58-72daf9abd78mr33122166b3a.3.1737526403133; Tue, 21 Jan 2025
 22:13:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121191047.269844-1-jdamato@fastly.com> <20250121191047.269844-4-jdamato@fastly.com>
In-Reply-To: <20250121191047.269844-4-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Jan 2025 14:13:12 +0800
X-Gm-Features: AbW1kvas-yRk2J2XFrXmr6vKOy8sE2Th8wv8T5Kmo1zaNBEsKqnxc_Acux4J614
Message-ID: <CACGkMEvLb3o3xe=GVW2ivngYoGt+0KfrWWTN1dsBT7ja-eeiQQ@mail.gmail.com>
Subject: Re: [RFC net-next v3 3/4] virtio_net: Map NAPIs to queues
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
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps.
>
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
>
> $ sudo ethtool -L ens4 combined 4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


