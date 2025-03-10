Return-Path: <netdev+bounces-173398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 299D4A58A60
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 03:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CD8188901C
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 02:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505081581F0;
	Mon, 10 Mar 2025 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtoJGccV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF110E5
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573179; cv=none; b=jWlIBSFqRXgQa/94M3NZikfIh2dDlDX72WJjk5sWxNhTL7s+f9nAXxw7BvQNFKCiOm8zUVphRFO5yMLv26mZqBXil0ITNMSGEyWtzXiYoJHm70TowAHVYNdxO0BLGsW0Q93AHFCmF0Q9tpxjO41aFGiefOsPjZWMfy9sR+SEqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573179; c=relaxed/simple;
	bh=AtJz09iFJfguCxcJpJrTrHp/B802QUOltbOGPdkAKoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfF3hqB11p195O9xDVWl6zg8A/asUhOwQV0IfP01uPIRgarK1q68UH0CkuRanWFd0LI7Pg3bHFuRY4z9W/UPglsUirkuqkhcO0GSv0TYIJonqPdWLSyZNJdqfpOTvIZ6AAyyquKEVsv7vBWp2jLl34gzvYfv7ppaG7ys1Q9J9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtoJGccV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741573176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txux+cFqmLt2vXZPROSLCC6ehPEuq9MQWbslAZa6/aU=;
	b=EtoJGccVtkwZXncr0ePMaN1dy2y/XKt9+iq7bMIuEzpuPTvhXkEoNgymYEWGvzIru4fdGz
	JLD/yosWMYRhguQC/jle1Wxruls6atgI8JYpCZSpf68fZNgR9K3Jb9DP8/dWn4OeHAWW5H
	f9W3jFv8m/P9GvaXMEFHdZAitKPrVEY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-3ydxuuvkMPmWNv88quUaiQ-1; Sun, 09 Mar 2025 22:19:35 -0400
X-MC-Unique: 3ydxuuvkMPmWNv88quUaiQ-1
X-Mimecast-MFC-AGG-ID: 3ydxuuvkMPmWNv88quUaiQ_1741573174
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so4753305a91.2
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 19:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741573174; x=1742177974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txux+cFqmLt2vXZPROSLCC6ehPEuq9MQWbslAZa6/aU=;
        b=HHIes0bhZIA3cFwnR23rJ+aMcmJXJMXtvJ7AOVhX2gKu4Zb3H1AaxgzsJHQVlbcugs
         rTpmWiN7uVSUDjo/jhDY4DDoX+THFtWGHJlL58F43t5zGzQQ41zQ5zJlAHPlBGTid2RX
         e1aHAPxAtNJ2Dnjyhhv/vTguqLEgnlDHWhj0fPL2X6bmJR120lA/uviZwM85TF0e69vH
         Un+sf64TXhZhI9tuPEheop4bWi6lDPvD0eLCE0G3btPI58OBFojFm23uCz6/At6k9cDB
         xRlpJKAeSrsq0OwCvtcowHiO1R4F08THxcBNlwWP+Jg0eIMCKVU23tfBwX/pKuD1ZNPq
         oWRw==
X-Gm-Message-State: AOJu0Ywg8dKKifdr5bsTvWjqlyIzUak1Ux+Br6fR5qdxi7eolRy0HoQZ
	rhzRM+D+YKWudynep9ldbFmCiOfNo3rhm9xSTK4HJ+b1O3VOnH8s3RzL2CcgxxxQfTxpRLPuN9e
	ykA5ctxOBSGJeDIO+uSwDVVxhAKInYD89owD9rl7X95yvk2PXfPviQMl13v4615a1c4W72EY3tn
	1a2moMnQm8KmzMfyyQLu9MSowh7A/v
X-Gm-Gg: ASbGncsNJ27k42MaVraVx/fPH3pGWMxW1j9MxPdVFggqAnQpsIlcSBy1gH2WHRg76Qs
	gpF3jJhIGrNeFrBg6FaCx8fTwcJLd/3iJWHNoI1/MPWDcFXPc/KAV4c6IuNSply6j0KysnIcTwA
	==
X-Received: by 2002:a17:90b:4ad2:b0:2fa:137f:5c5c with SMTP id 98e67ed59e1d1-2ff7ce59712mr17785021a91.1.1741573174026;
        Sun, 09 Mar 2025 19:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfi1kUcnjN/MGKScrpXZXxg0LHhjJwKWatCBlfrt9ASrGU0RhKt2zcjhKxKIGQsohJlSyTaOwlLcFFR/095Oc=
X-Received: by 2002:a17:90b:4ad2:b0:2fa:137f:5c5c with SMTP id
 98e67ed59e1d1-2ff7ce59712mr17784996a91.1.1741573173619; Sun, 09 Mar 2025
 19:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307011215.266806-1-jdamato@fastly.com> <20250307011215.266806-4-jdamato@fastly.com>
In-Reply-To: <20250307011215.266806-4-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Mar 2025 10:19:22 +0800
X-Gm-Features: AQ5f1Jqyyv20MK_Tuve32OgEwQce7uxyuKX5GI5kUQGIUUAGsE7tTG42f1QJ5Ec
Message-ID: <CACGkMEuwTaH9fTXC00633RsiKd9BMZSAaPG17i-+MPagGwn0dQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] virtio-net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	mst@redhat.com, leiyang@redhat.com, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 9:12=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps. Note that the netif_queue_set_napi
> currently requires RTNL, so care must be taken to ensure RTNL is held on
> paths where this API might be reached.
>
> The paths in the driver where this API can be reached appear to be:
>
>   - ndo_open, ndo_close, which hold RTNL so no driver change is needed.
>   - rx_pause, rx_resume, tx_pause, tx_resume are reached either via
>     an ethtool ioctl or via XSK - neither path requires a driver change.
>   - power management paths (which call open and close), which have been
>     updated to hold/release RTNL.
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
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


