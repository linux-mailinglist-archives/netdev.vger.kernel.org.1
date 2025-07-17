Return-Path: <netdev+bounces-207676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DA2B082AF
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 04:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B48177DEB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E8B1DF75B;
	Thu, 17 Jul 2025 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrxjT/iU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF31C8606
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717763; cv=none; b=stN/kT/i7nJSic2nxhy57ozPMfbIf9765cheoaUIES+lCcq3VHIC8yetyOMjYbnvbDsrpSiNxjyXLkQfibMptPzGv7CnQdePjXshQk3GnU9VLDqYxiy/ZALrJXs6jyXiQLy8qvpGghH1zayA5CxzMo3wbZ0UU7cJ8HiONbwhehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717763; c=relaxed/simple;
	bh=0GZHNVlrO+mmKMgTeSzkW0wKBWAd9//7yTO7Ox115SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPnTtDA6vKmIoyPC2rPTgCYwG+b7CvtaUqv1fvAODeY5jUTX7ueeX91yhhg2DAc8e+qYFqy6gwuuhR3XuCuMntMWdwuUn9LgUqmuLa+YDojNf7FGdH1YBtGVoqofS5XWUgfW+ffEcuWjow3wIdtYXdUqcQBuKrxxjddAOJWh7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrxjT/iU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752717760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M14DsGiQtqzXQpY818urP9W5ujH4yY77Exoy3IyUIdA=;
	b=OrxjT/iUp1hlxjR9D5gMgUvWKzelrxtXctQn5OeLeUn32uR6r/rnpRt2ZpqCZic9NtALig
	/IgGdpjL+NXztVTYnBvLjpYWEO5yFlwuiZ6pSGeYGwG8G3yJwLt7SVws9QMM12sbPykQcA
	W2zXOZamSvpgLE8de1vB2Ow8E0apdYg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-BqMK7qhSN863ib9bhqs8-g-1; Wed, 16 Jul 2025 22:02:35 -0400
X-MC-Unique: BqMK7qhSN863ib9bhqs8-g-1
X-Mimecast-MFC-AGG-ID: BqMK7qhSN863ib9bhqs8-g_1752717754
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-315af08594fso420818a91.2
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 19:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752717754; x=1753322554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M14DsGiQtqzXQpY818urP9W5ujH4yY77Exoy3IyUIdA=;
        b=hyLh57ptNiSi0mpYyobjmqZGry86HNRJoSglJ98v6T0vMeeJqdIJuBwMAAQh6CkFxl
         EvXHMQl+jbdfh95AZm1xSXkj+AE3+6BBw0+m0Ysks0qjaeK57g6nPtbW9jPDISXpPodp
         1fXj0WKo0zCDh4kAfAiqgKTp4/C6vTd1BgjBQdH6qRHx+ARHnKeHlOYj5nS2ywdlLIrG
         5xHXBc8nvDPUyhSNq0pRt1ZsMBPZi9F/n/DxOCd4i3dCw4bWWvP84403tQ5xQgIw+rCq
         01b6R5qFtfWbi1g1EIls38Xkkpbg0h7oIg6itZAGpYsvF65JsGYIeWw/BfyeQC606ZgN
         XYXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKpISYWh0K9kAOfrO6ogX5xk/3MItFfvGpHgsTBALk9fDenc3yPeqZ3BWLLGA8g0qu5jWAFV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUMxzvpTyf6pqNUWs3fnoOPHKf17T61m0iFEdWQG9uvV0fKtz
	wjFGgx7UoCm5YuyHhDAxpLcdvNPXIvKsVGfkTVivvcc5a0p18PO74iHE3BlpZBFWh4cPc7VwZre
	HBTaTUxT7aiBJeREJpuOtyQAYje/dS2iez8ryPBBsP+PRTVQo7QhxJKYW4dUk/hls8Icftu/8CQ
	tQ+wKfnsmI6TOCxYZbqM33EscDPOIad5Ws
X-Gm-Gg: ASbGnctdOXSJ69cYZoBO+QmNQWgl3OQYIUvZfuSci677NvWpuGMatUZYx3MYc14zS4r
	fr0tAfHuKmUCGN2LatVmS9AiQwFvZgxIxekD86mDd+mUaOvkUcUDplJ7qEf5Kg3DUgSWxYG6WAP
	EyIa3AoPB7XGcAVMgblCYu
X-Received: by 2002:a17:90b:1fc3:b0:30c:540b:9ba with SMTP id 98e67ed59e1d1-31c9f44bc2dmr7521582a91.10.1752717754217;
        Wed, 16 Jul 2025 19:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5iPUiqqpQyBmPLZCPtjid1ls/tJqR3WHYd9f5uSW/9kS6qJ/9PczlVKVSg/orVJ4W9fRrd/6H4sTsVPc7n5k=
X-Received: by 2002:a17:90b:1fc3:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-31c9f44bc2dmr7521534a91.10.1752717753774; Wed, 16 Jul 2025
 19:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716115717.1472430-1-zuozhijie@bytedance.com>
In-Reply-To: <20250716115717.1472430-1-zuozhijie@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Jul 2025 10:02:22 +0800
X-Gm-Features: Ac12FXxK3fHuuCF0pftokODGN7tkaUVBIGycjF0F-57Uypg4whIM51FXe-X2b_o
Message-ID: <CACGkMEsSD_r0akWpsP+Xa4_CvCAEVbF2cQ9GrE6VYhZ7m2C9hA@mail.gmail.com>
Subject: Re: [PATCH net v3] virtio-net: fix recursived rtnl_lock() during probe()
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:57=E2=80=AFPM Zigit Zo <zuozhijie@bytedance.com> =
wrote:
>
> The deadlock appears in a stack trace like:
>
>   virtnet_probe()
>     rtnl_lock()
>     virtio_config_changed_work()
>       netdev_notify_peers()
>         rtnl_lock()
>
> It happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while the
> virtio-net driver is still probing.
>
> The config_work in probe() will get scheduled until virtnet_open() enable=
s
> the config change notification via virtio_config_driver_enable().
>
> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state =
on up/down")
> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


