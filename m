Return-Path: <netdev+bounces-198882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1E0ADE240
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974C5189922B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BD6134AC;
	Wed, 18 Jun 2025 04:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdGU3qi6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721E23A9
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750220150; cv=none; b=pdIo1NBYnb8fWJmV7vVAiSndH69fdSoBtKuou/dLen3yjpJwz2AqBb6Yq0bF49XTr0S5i+QmdLZJ82+rACGMg2YeFNNd1OtPnATl/4sQbrUV/VTsNCPNWBnPCHIt4VuzfP3+Kn/VMzIN2Np048ksWIZBCBH/7NGvxd0lyPj5fM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750220150; c=relaxed/simple;
	bh=e0aPtrwMtedSQ/NHKI90kBVZD/CRPqsDAIDpwcBwZ1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaYwx4Y71Vn85pUsn3Cx7UzfbawtYaOpbBPHBW8YXP11cGVmUQJedTmrNWRrACgf92yeeoB1XsVOefcnmDEbM+lH6lKTD/SotLe5lI3eVCQwJKWZoMEbF4AnMfjr8YaLtneV1BjTiOdhZc8385baf1ssFtPmwAVM3dJBeuOeBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdGU3qi6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750220147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cg+tK70m8amQMItH3UMzJrC6ma517gh27EcuN7pP4kI=;
	b=BdGU3qi6YnOwHBRuqIoWezMmmh/pBQgN6LRAj/DOQaQb0scKle09p940XrKGzyj1q+twBN
	WAdFOsr19hyjjR60VMB2IaY00RvPlAqzPOid9vhBiva1sXUokbmbBxjtEjTWQpTmC09fKr
	v16c1RNHWAsJyF6R77OHWD4z30JGycU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-ZAkc2D24MTm4moUVQeTG1w-1; Wed, 18 Jun 2025 00:15:45 -0400
X-MC-Unique: ZAkc2D24MTm4moUVQeTG1w-1
X-Mimecast-MFC-AGG-ID: ZAkc2D24MTm4moUVQeTG1w_1750220144
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748764d84feso8914214b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750220143; x=1750824943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg+tK70m8amQMItH3UMzJrC6ma517gh27EcuN7pP4kI=;
        b=wGi4Ivll+Jrj3W0eKpWnB8lBbB64d6XlTrJnFT1SOYRfOvqbmMPibcWkI2lXlaP+Tk
         XsgFuUNK6HATtBDQW/1yjZ81tUT+sxxew03eqdK5vn3moY4q72p6QzriZ/fUgSnsPN9R
         bl7T02H0AE4/lBqfxLpBDehyJFCFc0GK9QPrbNDQksnc6w2TJCDnqPYPqGnU89EuIXZs
         7/Y7OStAGzIeDWYwbX+yi0LqjiF2MbsyaQI9BA87RK//Uii5VHVtrpa/y3jKnBe3YBtK
         1KlVLBYtjugTL7LknVeQGYLlYzUdV4vgCnx0SMbehzpbwcKPEPDhHpcm5Td7gBDxSjp9
         Btgg==
X-Gm-Message-State: AOJu0YylXXrDjYNjkM65BFFrLJKoIBFklG+C5Hgckv7KlhwpmCkJnVHB
	6EYsEq/E+sN9RPq9FS++CblOg1UKOc2pbFOL+ZXf+VXtqaPWYwMe1j38Y2UPmbqBg4GgWbLESaX
	3KlxMzdnYiP/N/2ZzdhnoRpXi0Hf3qnMqHvxlxvdsFsc4kprOaKMspY1bDKr1z9S/OfJdBI5UIf
	gDGeinJFmmu+Yeb0dVVU2f+NCnkxCsD+hDMJI2GDOL417STmPB
X-Gm-Gg: ASbGncsygCboNfSC7zJV6+khb2ApJiz6QBu61PcrpDEYmAy2bLuvLTPOxbPeuy8Fop1
	JxN8HbCGbc4TZOtTTdh1NQ9bP9GuRxfdVWNZOmMEuPf1Wjhg0ipf4F7zY9EG3imUuCdHvEmmNKA
	NBOA==
X-Received: by 2002:a05:6a00:ac9:b0:748:2d1d:f7b7 with SMTP id d2e1a72fcca58-7489cffa98cmr22580069b3a.21.1750220142998;
        Tue, 17 Jun 2025 21:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWgNozdmDEhl8wm+3JpheU84q4D4Yzp4Scmfbprf+ZM1XpXKM5/ZVpQ52siKpBsevqHjK9MUbH8rqQKubQsng=
X-Received: by 2002:a05:6a00:ac9:b0:748:2d1d:f7b7 with SMTP id
 d2e1a72fcca58-7489cffa98cmr22580044b3a.21.1750220142695; Tue, 17 Jun 2025
 21:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750176076.git.pabeni@redhat.com> <cd6225a065ce8f2e2fe052c2e02ecf78e7ee9d4f.1750176076.git.pabeni@redhat.com>
In-Reply-To: <cd6225a065ce8f2e2fe052c2e02ecf78e7ee9d4f.1750176076.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Jun 2025 12:15:31 +0800
X-Gm-Features: AX0GCFsWboY0vViiCOrKYvOQYYcQ0GO_-AyO2bvvm-PZsIUjQ6DMABX2u_UIO24
Message-ID: <CACGkMEvZO-vZJ+Wpp_BRFvFhGf5SeCAZXHkzqJQ0KCQHxm+Y+Q@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 6/8] virtio_net: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 12:13=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> If the related virtio feature is set, enable transmission and reception
> of gso over UDP tunnel packets.
>
> Most of the work is done by the previously introduced helper, just need
> to determine the UDP tunnel features inside the virtio_net_hdr and
> update accordingly the virtio net hdr size.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>   - tnl header fields at constant offset, update the parsing accordingly
>   - keep separate status for tnl offload tx and tnl offload rx
>   - drop redundant comment
>
> v2 -> v3:
>   - drop the VIRTIO_HAS_EXTENDED_FEATURES conditionals
>
> v1 -> v2:
>   - test for UDP_TUNNEL_GSO* only on builds with extended features suppor=
t
>   - comment indentation cleanup
>   - rebased on top of virtio helpers changes
>   - dump more information in case of bad offloads
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


