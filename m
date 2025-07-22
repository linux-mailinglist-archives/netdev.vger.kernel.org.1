Return-Path: <netdev+bounces-208906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFFAB0D890
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5698C6C50A1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105C52D660B;
	Tue, 22 Jul 2025 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msjJ8Yrz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F92475C7
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185096; cv=none; b=qMFg4n27YcScDagNyaSVx3DOZfacj7Ox3LYnGCma9hoO8KCct5YQxCR1tAqPWsq54wjhG4jtYll24erJ7K2hDLGAL5thk6x+cgtkmBole15p3lXYACs5ok164GGl6C5i28edgw1b7qlJtb0rihpWEUvKOSoPQ0zuwEL2dgCxcIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185096; c=relaxed/simple;
	bh=fDs/lkiikr8lrDjSXMBJGZzg2+NaAuigQIEX/Ky00/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOmQuYKtQPhRa/iJhymyvgdz2qwTQPasbXcNcpFQRUx1nF1WCNpYFuGnkF9eMJSkMGS6vYC2gRiSTjZcLyWZu6doS7nX0Uy3HLlhJem/2U1nwoJh+vtWUOYKX1VlBh5/Iqgj51P02YWoNFbajm55QB2TEpbF8AVHlgVBjWgXYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msjJ8Yrz; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso44394095ab.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753185093; x=1753789893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALwbxiasFzPrPDT/PXeVaomnxgv+oiue00P4Ij8jwo0=;
        b=msjJ8YrzNiAv8GLfm7430phdsg1xC+aX0siJOozQT0+N/Jys+1bfTDO/ZSuHjnf6o3
         HaHahv6W5Rd7/uCQUSSmQ6aF9p79xcSiBQBy+wZ1so6muPvg8A8AahB6B2m47piC3cv5
         Ht5WU45/3nWXci6VrJJima1VdAoEtMnrzqe6j5R4ot2CNwV0qaHBfR/hzKo27vfL9gdt
         uCxl/p+3zZoLpm8TSpU58pzS7afX/0xIFvBtGIhWMBui0sCwxy+kDXqCYxDAU6W21JcL
         mD5HfI6c8lLXtoKIqkaF4uvJzuoLqsbIB1tJUPG7vRTHAnT2XodmVHhK5KOEtfee/sBs
         7nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185093; x=1753789893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALwbxiasFzPrPDT/PXeVaomnxgv+oiue00P4Ij8jwo0=;
        b=Gshp+EJMxgW4suznccsxYsI5CUftc49oWzp/93ClzXSJ93SFaHQnlF7a0bLcJje3ef
         NDdPOgoINXBvlUSd4g04AzZH7Sq3P/a7FlsTp/bQ2WyNnRlaHKfT/xa9se0gzl43ARl7
         FzsIyZ1lKOhLvDc8BJbWx/EgQYM2/FM6ZJr1mRgZIaB7QYCw+/Dk4ARWuY4bnSeDPXHD
         z+FbWHsWqU8dOnnrfbRzJ85+A3fCo7BbCaM9EtMLmTNM/gxGl1aAuxsDqZKPZCWZ6KxX
         ow1jCobwdnpH1Fhl8z8zgoLGUyDFPEKC6gbYgS/FVMud7U2MDuY4TlPj8+3DfwN1oqou
         36yw==
X-Forwarded-Encrypted: i=1; AJvYcCXeSDTpyz6ce0lg6YPgSmm9WcqWxC3bxo5DyjVNwk6/E8OwxOCvT3bfRRFQW9r9cepWdbBqnME=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1Zw7U/RWeZ1IPbgCsY865vykho/IuWdQnPk9utbpccZBCfTP
	yru0j8XjX4JHi6qt92CFw9/m/IyrLSViw1zviYBNT6/q2TUlYc+NxeOEsuvJOnuEv/3utM4O3ri
	RkJvtFZ7NbFn8Xvuuo/IEbcoAaND30iZJHCRQ
X-Gm-Gg: ASbGncvZ0e59xaIXCLEMdN5GIVKjMrN8A/FJd6k0+c4gShTFNpe0ffNUKXygdJeuBct
	TvTI5gCbqrJdiUfHx2+62KD255oBQBdH005jfpmQyCYtcPMag/Jj44Yif2glXjz37UCmam1E9JE
	BoG66ONDwB+F2eRW74O/cbMzE1rzEIUr9Op0AAGMU4KPJSetZfDKFOoJGR9DBNcOTD6Gn5J9zW8
	kekBo0NvqKHC1F64g==
X-Google-Smtp-Source: AGHT+IGXR9clp3Zfn1b/yJO8h2n6Rfk8AbS1/Kj2GNIusLGv2n5VulhfCfmGKWZ3xKH4iJ3wftLJSDYdsDNoCHSxTKI=
X-Received: by 2002:a05:6e02:350b:b0:3dd:f743:d182 with SMTP id
 e9e14a558f8ab-3e2822fce43mr339664415ab.5.1753185093608; Tue, 22 Jul 2025
 04:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717152839.973004-1-jeroendb@google.com> <20250717152839.973004-5-jeroendb@google.com>
 <CAL+tcoBu0ZQzLA0MvwAzsYYpz=Z=xR7LiLmFwJUXcHFDvFZVPg@mail.gmail.com> <534146d9-53b1-4b4a-8978-206f6ad4f77e@redhat.com>
In-Reply-To: <534146d9-53b1-4b4a-8978-206f6ad4f77e@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Jul 2025 19:50:57 +0800
X-Gm-Features: Ac12FXxZ_vgWastcEpiWlVbERTJiWIJfn-QYMbgCRW_O9wklUPWTEa8uoXvsIoI
Message-ID: <CAL+tcoDR7O327uDMLgZ_74X_Vkvnx1ACpcs0BMNjTZRD0pY9kw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] gve: implement DQO TX datapath for AF_XDP zero-copy
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jeroen de Borst <jeroendb@google.com>, netdev@vger.kernel.org, hramamurthy@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, willemb@google.com, 
	Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 5:32=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/22/25 1:37 AM, Jason Xing wrote:
> > On Thu, Jul 17, 2025 at 11:29=E2=80=AFPM Jeroen de Borst <jeroendb@goog=
le.com> wrote:
> >> +
> >> +               pkt =3D gve_alloc_pending_packet(tx);
> >
> > I checked gve_alloc_pending_packet() and noticed there is one slight
> > chance to return NULL? If so, it will trigger a NULL dereference
> > issue.
>
> IIRC, a similar thing was already mentioned on an older patch. Still
> IIRC, the trick is that there is a previous, successful call to
> gve_has_avail_slots_tx_dqo() that ensures there are free TX packets
> avail and operations racing in between on other CPUs could only add more
> free pkts.

Oh, thanks for clarifying this. It does make sense :)

Thanks,
Jason

