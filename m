Return-Path: <netdev+bounces-71337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2415853033
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E03B2374C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E30F38DD5;
	Tue, 13 Feb 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSXUDrIX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4602BB16
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826043; cv=none; b=H4ocDTxZd+ZIbo1r32F9iuTlegJB8ceB6IY0zIa60PbD3bNzsQb/pNNjDSqDvTM3gGvyxSDzuUNUPnj1tVjhES4xgMzq2+SQ+57HQ+MCoOxe7IKKBFYc8duIUOY72askAqCnOtlkHvIbwzSAkNjRapHDB7akvMF2izu/bpIJL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826043; c=relaxed/simple;
	bh=ZsJZZnBdStxwssb52H7yy6LOMWpdHb//G2aL5Xtbeus=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9E2LhSEIXVLX/Fj8GAWlYNsOOPTKPlcMpRsgVOoy7MnDN7PAWAtezCKDpmYfWvu04r6IhA1jTdO7OSceeT+y+Mc3XO+3wqSayuotjsSNs9pAKsiQTRznFsAi5HcYLaGAQM8Lr8qXkSZlbVtRzlfbSpqMN6E7Ab/u9utOhK9uhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSXUDrIX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707826039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lw0Xj5USibqEAA2E4SJ+myVUvmFeNxouUaqKRZTOkbQ=;
	b=ZSXUDrIX0vnrEv5sK+W44tta5Wq6UiOpoOlzsQiNTOStuKjBgdLGakgGoxq/tgcZanzwg+
	VGVvMj0v2+5Zx/b8oS13+TT9hMsXQwBQBKFgUTRZKrhpCHqs1zlHj3g3tFEcXwCAaFokYs
	xkUKT1JR25p8KgT6VIQsluJDDgYzhUY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-zWhhMmycPteinUYuPJJvIA-1; Tue, 13 Feb 2024 07:07:18 -0500
X-MC-Unique: zWhhMmycPteinUYuPJJvIA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68cc11618a3so10298996d6.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 04:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707826037; x=1708430837;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lw0Xj5USibqEAA2E4SJ+myVUvmFeNxouUaqKRZTOkbQ=;
        b=LJX31OsCYZnsE+FzANIudy0Sxd0MIxpAFGCDU/ki+0Jq5/jW6HdElxZeWjJlgHkNuU
         cfPcnXiyLPKVMPMDfNShFWNPZ/79L3G/dbanzI5M/MOPaV2lNZumpy4pF303CtE2BxbG
         Xgy8MYFVZMIuXFT/YnMW4j/N+KINo4DR6Pz1QMh4duOIpVTLS2eIdBZHVRT0PlmOCfeV
         Q5M9msADyY2I+4ZmY6jrxokSmza5sA3wq4ssUHrfGzoNpcHIhlcXegSchFX9zK7trF00
         7naHGioZc1l/k7bbrp3R/w5GyyjyW3t8ePgXVggGuOpzCQa84+NMmSmENNarjVniwY0u
         /AAg==
X-Forwarded-Encrypted: i=1; AJvYcCXtiJ0fAqBrWixpbqFIwjPQQEThw68TOCJkgWqQQmwk1S+UKbWgfY3/JK5MfYfpArL33seQUn1iJLqFE/OrzusX9EsZqejS
X-Gm-Message-State: AOJu0Yy8StF5+WOsmZPLMJzHDsiJzP4OXsoT55H0+yVjQKnhIeAu3Ofw
	Ob80uXshmQ6bDN7Iedv5ndB0ua1KbxBHTdro1wprBJqlWG72+QO2ZnsQgIICTgQ8MTd1ArYyB10
	8fridV/ZojhENO283FOl4PQ3ShPsJsnidRmzr8Wm6vXwIOB9f7lpLGQ==
X-Received: by 2002:a05:6214:5097:b0:68c:c134:6697 with SMTP id kk23-20020a056214509700b0068cc1346697mr11474088qvb.4.1707826037476;
        Tue, 13 Feb 2024 04:07:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH33JQ/EKpm1I8NKO0mDZ+KlYJaF+XsS3odJJvmyy77nmAJvnSMhkNNPjr6jo8HkqGXYUwftA==
X-Received: by 2002:a05:6214:5097:b0:68c:c134:6697 with SMTP id kk23-20020a056214509700b0068cc1346697mr11474078qvb.4.1707826037196;
        Tue, 13 Feb 2024 04:07:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/icTPQBiTk2lZnA1T0rgLT9TmP1zZUQXiFjKpyBP7f3B0tw2WEJDZSPi4VLvl7WjeAh6jp8QILWnLeKctmLZpG/eHTAjl4+vddj0cdb40y2c8RPCXE8Wj4Si+/znZOHII4zRekT8/LaDpWy8fU2LZPpEd6LyFD8H+BKP96rCNTQZwZ2h+xSOtK63lNtt2jR6eMPAlaquZNZ76eRvkMUY=
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id pa6-20020a056214480600b0068ef8c3a138sm54259qvb.9.2024.02.13.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:07:16 -0800 (PST)
Message-ID: <125361c7ec88478e04595a53aacc406ef656f136.camel@redhat.com>
Subject: Re: [PATCH v4 net] ps3/gelic: Fix SKB allocation
From: Paolo Abeni <pabeni@redhat.com>
To: Geoff Levand <geoff@infradead.org>, sambat goson <sombat3960@gmail.com>,
  Christophe Leroy <christophe.leroy@csgroup.eu>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Date: Tue, 13 Feb 2024 13:07:14 +0100
In-Reply-To: <4a6ab7b8-0dcc-43b8-a647-9be2a767b06d@infradead.org>
References: <4a6ab7b8-0dcc-43b8-a647-9be2a767b06d@infradead.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-10 at 17:15 +0900, Geoff Levand wrote:
> Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures") of
> 6.8-rc1 did not allocate a network SKB for the gelic_descr, resulting in =
a
> kernel panic when the SKB variable (struct gelic_descr.skb) was accessed.
>=20
> This fix changes the way the napi buffer and corresponding SKB are
> allocated and managed.

I think this is not what Jakub asked on v3.

Isn't something alike the following enough to fix the NULL ptr deref?

Thanks,

Paolo
---
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/eth=
ernet/toshiba/ps3_gelic_net.c
index d5b75af163d3..51ee6075653f 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -395,7 +395,6 @@ static int gelic_descr_prepare_rx(struct gelic_card *ca=
rd,
        descr->hw_regs.data_error =3D 0;
        descr->hw_regs.payload.dev_addr =3D 0;
        descr->hw_regs.payload.size =3D 0;
-       descr->skb =3D NULL;
=20
        offset =3D ((unsigned long)descr->skb->data) &
                (GELIC_NET_RXBUF_ALIGN - 1);


