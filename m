Return-Path: <netdev+bounces-135502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6943899E281
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB17EB24FFB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4669D1E0DA0;
	Tue, 15 Oct 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQQxoYim"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1F1D9A45
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983490; cv=none; b=rfxk3fEeECsuK9GyIGgZsBiphOyvzmA+JQDkZOhNlCHIEHBUdnu4nLT5XlUry8/FHBDpWKpz9N2eo8F8IVCMDYwr+iocIPpn4cI54AWmNCKo5+TBapWlDCEHcYqgQZAP86ZIcALQCzXnKzhNRL8S30kEJEF3uwit57vVjlHZgUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983490; c=relaxed/simple;
	bh=XzYS+xvpmYmV7ZgaEsKewlO6C6jLF61SxyXMfC4k4Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XN6Q1ZwwXMKSae1qBBV2W4kOLEsexHUvixLw4jdhLyYH41IzcpdfgM+wZc8n/KIEjl3aq5dvfAxNKDhVOw/bobG3mVKo/On713pIzmaU8XqUzTG/b4yPIy3BesGTkzId0kUbXCrvblWS6W8MLEJaqzI9qRGLilUine1pH64Xw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQQxoYim; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728983487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9rgOpstNDPy2OOaYxLcq89h/23iUsGDorSWwwH2VzYw=;
	b=hQQxoYimXDqCQjwliUF3sDufY+PW0LkMzR1SM9199lHm6jXk8IvqaFqXOPKsdOqCUF0pKF
	CFJjm0xcwqpM5mm1lp08rxMfP0SKntWAmCTf3m8duqG0iROZlXB2+Y4Jr4lNVl1t/fqAzZ
	SD9qDyi6ZnDXhS4LgwTM+UXF3TDaUMo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-VyqCB-9WOK60H10czBOTyw-1; Tue, 15 Oct 2024 05:11:26 -0400
X-MC-Unique: VyqCB-9WOK60H10czBOTyw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431207426e3so16527535e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 02:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983485; x=1729588285;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rgOpstNDPy2OOaYxLcq89h/23iUsGDorSWwwH2VzYw=;
        b=AO90jJoeNXh3tZoCTU/NObTmiYM1k92ATCTF/8XXCVr6glv6VJ7ws8d4CFp21Bb5v2
         Tv3Gjy4Y6UEUD35NdYgAniq0gBas1oGT/moWk5kRgl4b8WFEr1nopDXHy9oIF3bQ+yDl
         kqERZWbA83Rl2IGmgnlO0E+Wl5QXC2D62mMPTtcwLryQwuGOB32MjQqih9nrP1BT2nC+
         PBXy6GXHNyz1CcY+d/CJtdXShnSU5F1KRgIpVvwLsZzsiQ9jRQIWUCwoi6cMC61enigW
         7l3E7UYZorydrAQLM3lf05AfaS7gxJvI19tudPV1csV5tuuW0piv1Q4+xE59dI+IytwO
         L4Hw==
X-Gm-Message-State: AOJu0YwmRbKs5XC9KU1gm1Nk3zsqpebzrdBtTwWm8cQRC8Q2dPb6DJWO
	9/NuHSwmTk4Tx0Yvp94seNyD5jdoGiEFPbEj6PLaY+KrCDpXS6xyt/9bLsQUhZQOtsKH2f7SeOC
	nYkZr7L2bDlbj1cXbvmp9vRDJbabALmxnDQRP3IIdfx3BC/TnufsgCrZIDtRMeg==
X-Received: by 2002:a05:600c:5117:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-4311d891d52mr109482445e9.8.1728983484822;
        Tue, 15 Oct 2024 02:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSZeePQeMhpuTUf/2OKUtkHo50VHgNTxaq0YS0LSaWD5L1ZkG+qz1bxnvhJ5D/Z5etY+Th/Q==
X-Received: by 2002:a05:600c:5117:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-4311d891d52mr109482285e9.8.1728983484457;
        Tue, 15 Oct 2024 02:11:24 -0700 (PDT)
Received: from debian (2a01cb058d23d60030b5722051bf3d85.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:30b5:7220:51bf:3d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f20fd63sm11797565e9.0.2024.10.15.02.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:11:24 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:11:22 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/6] xfrm: Convert __xfrm4_dst_lookup() and its
 callers to dscp_t.
Message-ID: <cover.1728982714.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series continues to prepare users of ->flowi4_tos to a
future conversion of this field (__u8 to dscp_t). This time, we convert
__xfrm4_dst_lookup() and its call chain.

The objective is to eventually make all users of ->flowi4_tos use a
dscp_t value. Making ->flowi4_tos a dscp_t field will help avoiding
regressions where ECN bits are erroneously interpreted as DSCP bits.

Guillaume Nault (6):
  xfrm: Convert xfrm_get_tos() to dscp_t.
  xfrm: Convert xfrm_bundle_create() to dscp_t.
  xfrm: Convert xfrm_dst_lookup() to dscp_t.
  xfrm: Convert __xfrm_dst_lookup() to dscp_t.
  xfrm: Convert the ->dst_lookup() callback to dscp_t.
  xfrm: Convert __xfrm4_dst_lookup() to dscp_t.

 include/net/xfrm.h      |  7 ++++---
 net/ipv4/xfrm4_policy.c | 14 ++++++++------
 net/ipv6/xfrm6_policy.c |  5 +++--
 net/xfrm/xfrm_policy.c  | 20 ++++++++++----------
 4 files changed, 25 insertions(+), 21 deletions(-)

Note: I'm sending this series to net-next as these are generic
networking changes, although they only touch xfrm files. But I'm happy
to rebase over ipsec-next if that's prefered. Just let me know.

-- 
2.39.2


