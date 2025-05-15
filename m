Return-Path: <netdev+bounces-190841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3EAB90E6
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FDA1BC6260
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D71729B77F;
	Thu, 15 May 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b6ESvTV7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B309297A48
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747341550; cv=none; b=FkRCwSLvlaLg7RW51YA7fCsGsq/kciKAMzcIgRjS1PzoHsdgYxAYWRJoav/dLS8iHXOsnScQ//H6hn4jbzrv0y0A4tPtT8l/2IWorY0OnFbzhij25cPlQIKDqIoYBA/9hJ877kPUsOLA1A1DPut5CI7HAPtFkY1LulDFWtTRWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747341550; c=relaxed/simple;
	bh=5LvY5tzl6OpWTrPnPisYnQ8qd/DVKQU7fKCXD1M2VvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBM38s64+cZe0MAWeL0Usmw1BokSAuA7x508J5PlILPNxx88NHLu6u0IwYpuD0EgrxsC5T1YE4AkR87tRndoNWlSlKP0Bw9Nm89BJGAe8WDK8RJcOC1RiJhIF9ZYPwV1IV+N4JHNrxmw/pFvrcihhoilBeomR/zj1AApQqRvHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b6ESvTV7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30effbfaf61so16386611fa.0
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747341546; x=1747946346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGd89Ij3ihsDUANJWKDVjCfRrcPwOEzhW7E9noIOuHY=;
        b=b6ESvTV7b+mx9WOGCBbnI+Gmhu2CiawJBWgBsr01xFolu9J1NEjBhJwOGuaIKoz/gu
         Xk3qPqpqoAWcFYg8l3u8/WKOjmq/DMFS+6mjw4aQzlOLLvpxart+4gyGyMCwJWRt9V9j
         dPJX5Mc+sanynPvgnfGxCyIFQha1qpFrJ7ciU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747341546; x=1747946346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGd89Ij3ihsDUANJWKDVjCfRrcPwOEzhW7E9noIOuHY=;
        b=Omh//o41yVvKCOACEitqa2b3SfTFmQTefAn8SOgZheU3N6zg7MJLZGQiT3fuqE1Gqh
         OgLwr4W4LFB3KQKMmgH+IWn+83xHPUOKcMOlkkP8pM4sjiJ10jvgP+Ll5WNInKRRbUSl
         7kgKSfpj/mIOY6lcBp5BR8C10D6vpmklv+JE+w4a1PXboMqPCW1flcMMB4SQqjN1nhw2
         4zlRFynwZHxVniGuGRIelksRU15/EPJojSYJJzJJ1N19gzLyX16S+pOOdIyzD/VvixI6
         6+WqbyoZwHz7a1L6jmKYTreRdNskvNR5Txsn5epE2AuZreJ3xDaEZSc8tyFy+G3mpcz+
         JNlw==
X-Forwarded-Encrypted: i=1; AJvYcCXGgUQz1/N+tVH4xUjbLYlUKO2OIixD4z81hGTGay+7pvMWNob0vkofIWfiR7a0seqEoA8pmEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/s9yUBO0IWqW1v7E+Q9HmkFSMjOVtv6zVV21BrO53Ov8w5Z5w
	C65WZeHmRdkkWIbPtbz4QccH9MWc78Me//uw3PntvzMWRroSbBbtDbiOCGRaxmUbRlWCVeXncs2
	ChATD7g+lMeyhHzhJPF07dQz/gKYMXJz4S/oOVu+n
X-Gm-Gg: ASbGncsCWlQyja7zStx81YmQI+t4pc2FYnAnKqADyeL51W4rYpBNhPKE0yp1YyykZV6
	XI/9nM+j7D1ZJu51E9Ri30x1fhaMlpNSpwYhWKLP2pdAWUqo4w6f74rp0jams2tMR8w40huGe2X
	jyl/oGBOgVjUyW91wZhRHBhcKbJQin/EhjVQ==
X-Google-Smtp-Source: AGHT+IFEpyU1SVPtYkgJNaWkDU3vfROG0brtMk2c/tj0jWAjvmdg/YHiXLPyCBT0NU9510I+dsh+53qxgZ3Rtnmi/rE=
X-Received: by 2002:a2e:b8c5:0:b0:30b:fc3a:5c49 with SMTP id
 38308e7fff4ca-327f8484b1amr20578561fa.9.1747341546527; Thu, 15 May 2025
 13:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513210504.1866-1-ronak.doshi@broadcom.com> <20250515070250.7c277988@kernel.org>
In-Reply-To: <20250515070250.7c277988@kernel.org>
From: Ronak Doshi <ronak.doshi@broadcom.com>
Date: Thu, 15 May 2025 13:38:49 -0700
X-Gm-Features: AX0GCFu6WRwaZwKs1VmGpZoHM3Ug86kZLV0H4pZQIn-f-tFF39RhsCaq2N2sM6g
Message-ID: <CAP1Q3XQcPnjOYRb+G7hSDE6=GH=Yzat_oLM3PMREp-DWgfmT6w@mail.gmail.com>
Subject: Re: [PATCH net] vmxnet3: correctly report gso type for UDP tunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Guolin Yang <guolin.yang@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 7:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 13 May 2025 21:05:02 +0000 Ronak Doshi wrote:
> > +                             skb->encapsulation =3D 1;
> >                       }
> >                       WARN_ON_ONCE(!(gdesc->rcd.tcp || gdesc->rcd.udp) =
&&
> >                                    !(le32_to_cpu(gdesc->dword[0]) &
> > @@ -1465,6 +1466,7 @@ vmxnet3_rx_csum(struct vmxnet3_adapter *adapter,
> >                       if ((le32_to_cpu(gdesc->dword[0]) &
> >                                    (1UL << VMXNET3_RCD_HDR_INNER_SHIFT)=
)) {
> >                               skb->csum_level =3D 1;
> > +                             skb->encapsulation =3D 1;
>
> IIRC ->encapsulation means that ->inner.. fields are valid, no?
> And I don't see you setting any of these.
>
> Paolo, please keep me honest, IIUC you have very recent and very
> relevant experience with virtio.

I did not hit any issues during Vxlan and Geneve tunnel testing. I did not =
find
the code which validates inner fields being set. Maybe I missed something. =
If
you and Paolo think inner fields are indeed required, then I will remove th=
ese
lines.

Thanks,
Ronak

