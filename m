Return-Path: <netdev+bounces-176789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9DFA6C257
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 19:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620351899162
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2D122F15E;
	Fri, 21 Mar 2025 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAxy/fYc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825581E5B83
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581631; cv=none; b=HFV49hGD1FnKekZ4wifYqmCuaHNghcZMnMTeDjOjgFAwP79bO51LPeXyhuWk/KKafyi+Ja9iXGc9IJIL82PpmJX44p3RviiO5DTg9FZIc4+PJee5E6G366HOrCWCDLDVn2sPtThivA2Fmgxi0Q+iPDle+wvHnlAc969qyTuqiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581631; c=relaxed/simple;
	bh=bTQZl+jKYwsLzl4vfj4ptDXiTWI3OAMPApOYg8CTBCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCriqDJ+7BsoUOx1bzbydwtS3TeRmm8FU0tqphqhFC0uj4DUIm1Mk0Z3KqCy0Uu/UqvRK/SrSnq5zQE8UmnkTRKJyzYNxxJ3uBfkZ1VzJLdyWlnFzeQ8Im1pC2NOfLfi6bsunz9O9kPBX5zFYSu/NInezvf5Py/PKImbhmqmvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAxy/fYc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742581628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBvAZI44TSwYckHNoPIjidtJUdEM1gfFKOJZR81EuoM=;
	b=eAxy/fYcv1uI6yp2ZVhJYjHcw71zxa5Q/uxmLU3aOfHj7t4F5BW0AiVmd7LmRHDdPpPXjr
	UmIefqwb8Np0Ep6oYgpSnijf840d8n+mh/+HkxNTnx/mO6PP4JbttBDFddDwOcPXNDom15
	frEPDPt90JSfFmb3RhcX89CynrMUQ6w=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-7eDfEMYuNXavtAA0UnaSlg-1; Fri, 21 Mar 2025 14:27:07 -0400
X-MC-Unique: 7eDfEMYuNXavtAA0UnaSlg-1
X-Mimecast-MFC-AGG-ID: 7eDfEMYuNXavtAA0UnaSlg_1742581626
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2262051205aso24381385ad.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581626; x=1743186426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBvAZI44TSwYckHNoPIjidtJUdEM1gfFKOJZR81EuoM=;
        b=M6Tp9vN0nPjWYfDFfYzANdkRMfX+rjFdk6n+roRm1MqCzH+yzKpzLkvO9o13aLIPrG
         2lxPkDjLRo4qS/Kf6bOJ4jKvsEcKW/43f18z0jUBJ2utC41GQ584MhPL2qWTbrJy6dYm
         T4b1liboln9N/3ptBT0d6EeP24MR1atQH8dsoNrFlv3PO1CnDuO/i7rPZlh69Twbfprq
         lXoUQSKEdx/r4giqffus6gTKQZsg/Ak08DOOwxl/pMPXnvX7/Gdm9hgh5MmvsnZxeTaG
         nRK9xsCpPagY69BlIWMPBcSWpKnYMdSHGS+OuNvBYZlBNrPT9x/O9fYIzsrXzlkjTd29
         8pcA==
X-Forwarded-Encrypted: i=1; AJvYcCXLyb1QjTWayjwwd+IKWeYLcH7/X7ROKgatf+TjpQz9recuAOhUdWdKSlrAPotXDbzFazvMnNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3WadgP3UtsRbbsC4zeJeoxmIondJx2GdZHVZ2r2pLIAumnpV
	fNVb6uKqjtiJVIOti0mcf1G3vQl6vKCgRti3DUogAcEgwAXBzA65vWjZKrZRRq4LgJdzCPBrOK8
	MHUJS84lY599AN42Q058YEpRxJXUwOFbV4zMbx4AZ0jKZVbdjMgDefA==
X-Gm-Gg: ASbGncuxDLU4G1hzjlvdpweO8nD99IJXpP+S5NOFV0lnQaTY6KbnVi9RyBjSAbIWtQC
	9zzBzB8bECnwzh1/Z6alpGsHj6r1LeAAuwvP67f2yuNAZ+5epxSC5Vw8i2jE9klHXaKDTlvNWvz
	LFJ2oPOgF5sPPb6YtScSVFHpDAnXeDpRSzuDCo3+KOD75RM5Vf9/Tye1Zh83rd1UtQ7J1DB9nWH
	v53DayZdzZUqRyHDjh59osMKMAo+y44Dk/9AImi0zxTxP9SV3FQ2SRRL2sgiyReHmtkD7sk46pc
	zUuOjxs9
X-Received: by 2002:a17:902:d4c5:b0:224:e2a:9ff5 with SMTP id d9443c01a7336-22780c68927mr63231025ad.9.1742581626017;
        Fri, 21 Mar 2025 11:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHESOlmKUv4omuiIQXNajC9s1OooXjFczUMnufBWcD/XHD7P+eP9u2TgzZG1Ni8l4wIF+1XA==
X-Received: by 2002:a17:902:d4c5:b0:224:e2a:9ff5 with SMTP id d9443c01a7336-22780c68927mr63230655ad.9.1742581625648;
        Fri, 21 Mar 2025 11:27:05 -0700 (PDT)
Received: from redhat.com ([195.133.138.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3b242sm20686155ad.41.2025.03.21.11.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:27:04 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:26:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Joe Damato <jdamato@fastly.com>, Philo Lu <lulie@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devel@daynix.com,
	Lei Yang <leiyang@redhat.com>
Subject: Re: [PATCH net-next v2 0/4] virtio_net: Fixes and improvements
Message-ID: <20250321142648-mutt-send-email-mst@kernel.org>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>

On Fri, Mar 21, 2025 at 03:48:31PM +0900, Akihiko Odaki wrote:
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com
> 
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v2:
> - Replaced kmalloc() with kzalloc() to initialize the reserved fields.
> - Link to v1: https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336ddd@daynix.com
> 
> ---
> Akihiko Odaki (4):
>       virtio_net: Split struct virtio_net_rss_config
>       virtio_net: Fix endian with virtio_net_ctrl_rss
>       virtio_net: Use new RSS config structs
>       virtio_net: Allocate rss_hdr with devres
> 
>  drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
>  include/uapi/linux/virtio_net.h |  13 +++++
>  2 files changed, 56 insertions(+), 76 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250318-virtio-6559d69187db
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


