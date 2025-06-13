Return-Path: <netdev+bounces-197262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAE0AD7FAF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A525F7AEF7B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2DB1C5D62;
	Fri, 13 Jun 2025 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMFcvSjZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7415EEBA
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749775351; cv=none; b=D4w/Cciey1lDYYbSfY/qSBqV6bKPvmPUB1oTUOOw0wWoCPAJsQ6ihOMxpOv6p+q29Jsgs2wGK9RnyjW/qkUiUWJ1iwT70MQcSzdMJD9fPSKAm9lBcUX3TLNiizP2Ny26b9dNdQXYoCZtMO1prqbnQOSWIqktzDUZBbXMCPM4Lkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749775351; c=relaxed/simple;
	bh=maylzhN3R1kW/ohhBSyd7HqzpVdN7/AKHxThCz98Pi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmDXiVKPvegeCykhc40HfSYjOsa4gd0fch1Htf5PbtN5K8ENsTjKsTUI0NSfD9HXvin4/wJ+os5CmhpAZLHwLNxSs+gnsbACrbGm8y3Pws8VgsdawHdcIfRm3tjUjqwVKB09za0iKbzfH7tlASZiqlnBztqxSvB/FdTHZ2kiFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMFcvSjZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749775348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maylzhN3R1kW/ohhBSyd7HqzpVdN7/AKHxThCz98Pi8=;
	b=RMFcvSjZMZyoBnBCXTyNfeAZ/2Ztg3WaXkS2KnM/M7GRet83s3Yx1rksg/IPPpjbB8Av6y
	hZ9fGQGS8R8BkqsxhBIAaAxXWK4Tm7IkDvArLWW3fApISI2NQDK29AmLItGTmWXZMmNXjW
	Z5kC12o8deNi/h/5Jr8vDHw2OgeVVrE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-tUMjRWTRPTeYQsFUuE0YFg-1; Thu, 12 Jun 2025 20:42:27 -0400
X-MC-Unique: tUMjRWTRPTeYQsFUuE0YFg-1
X-Mimecast-MFC-AGG-ID: tUMjRWTRPTeYQsFUuE0YFg_1749775346
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2350804a43eso23528795ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 17:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749775346; x=1750380146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maylzhN3R1kW/ohhBSyd7HqzpVdN7/AKHxThCz98Pi8=;
        b=hx23B7cMh/hj9PwCHV5/eFNgL/OLoh0ELNTFvlko2iaEg6l4MF3R8Ot8qNegVKWgVt
         ZEbHS2hu/nyz4ZWVCaHRhmMAZEayosjP8ubmGBSCUlubk8plTOn3G7KmNbReL0Rjnjlb
         3vuVP8Hksy8uiE5ZY843E6ZZfPVGaKfpkeep/UrcvytjBb+2Z3ndwKKC52wCgHvgKPnA
         0MwWcvLc87GDh5Qt/vjoH7TubaKUFpCf+zT1E2NyNOcLViJyCwlY6/DkA2O3OUY7TLfT
         RICfQYQZ06fYUlaitRh1wkMcqSZ7hDdMVCeSln4noL2u2dCxasdkqcO9GljHdKQKNNVQ
         bIgA==
X-Forwarded-Encrypted: i=1; AJvYcCX2jEQ99kmx5yFPBubnCTF7uz+HZJ0WlI1cesC9d0C1RhehbknLux5Lki/CWOLHux+JUfRxHns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYBQUGH7kOC3uxpmDet7K/s7BUAA0bDG3yRbtftBbFHgCnAos
	4D02gRO6KImRiGg/g0DVgfW1SysyLs5PWbfpoku2SC3lYXqZUg1QABCT/ABGjZ3DCkkg0wQ2j1o
	UpEsJpaV69bnD3f2eMvS1gIArM75x1l3TtbgtIeFWNnXKcObipTBxjLhgs+/paR2U6MU8UJaOWy
	mFWAW1bbtzeTyOsSm/KBfJjZF8nE4yELxr
X-Gm-Gg: ASbGncslzDow24thiFrR7oqklA0g2zbjJzhlG1Tu2+HyWxYeokMvlA01qpSPFKG5uoT
	XA6G7snG2Tr0azb/DIq4nvnbMrOUSlwskpo/VsW5HVTnxr+Jwio1T7uZUBSHprMpVs/KhBu8IyJ
	ri
X-Received: by 2002:a17:902:ecc1:b0:234:8ec1:4aea with SMTP id d9443c01a7336-2365de3ffebmr15643985ad.52.1749775346552;
        Thu, 12 Jun 2025 17:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyAdb9tOchMbc5VNkQkyQSUnXYNZ2kaRcZWI02WcZBsf9KTCg9tOz9NPCpeq9Fvd5gqgpmYLmy0vfEXIRGarw=
X-Received: by 2002:a17:902:ecc1:b0:234:8ec1:4aea with SMTP id
 d9443c01a7336-2365de3ffebmr15643675ad.52.1749775346178; Thu, 12 Jun 2025
 17:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611145949.2674086-1-kuba@kernel.org> <20250611145949.2674086-9-kuba@kernel.org>
In-Reply-To: <20250611145949.2674086-9-kuba@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Jun 2025 08:42:15 +0800
X-Gm-Features: AX0GCFtduX1ZN2Z9MpNLZYiPSNj2kJDaR7Qwn7qrUaaQEilxwRPmYc-DFKEweUg
Message-ID: <CACGkMEsDmQc-zcSpKSC=ezfTfVQNayZDHC2VTxRvrz7qZ_+kgw@mail.gmail.com>
Subject: Re: [PATCH net-next 8/9] net: drv: virtio: migrate to new RXFH callbacks
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	ecree.xilinx@gmail.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Add support for the new rxfh_fields callbacks, instead of de-muxing
> the rxnfc calls. This driver does not support flow filtering so
> the set_rxnfc callback is completely removed.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: xuanzhuo@linux.alibaba.com
> CC: eperezma@redhat.com
> CC: virtualization@lists.linux.dev
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


