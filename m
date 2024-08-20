Return-Path: <netdev+bounces-120294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDF4958DDB
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65ED284D84
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5417C197512;
	Tue, 20 Aug 2024 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="JVEINzYK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91139210EE
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177772; cv=none; b=PRymXi7wziq9Z5VL7RGLJBEozVrLjnNRhXBoSWiJCcxf/T99UlOTETi39oxc1U9cXYAbolx6xP1H0CrpSzg4GWCp4L6hx5z4BvpKrLnLzOgwWkbp7MhdYR7bWXQ8Q1UpA8TprudSMV7AaLcCEs/gsBc4pwT1NYo/cQk2sNp1eqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177772; c=relaxed/simple;
	bh=aRO5Uv9ckXe/E/ZfRbx4BpZxM2mh0Ru9T9hOaPsTWF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSixJRBwg/2kvq9QZMSNvBS8aJac4pLi8CJKsXxLNGmE4rn1XYzk2xs+M9nn6Rc9i2oDCGG26lPeCrsJqix7MKtMTLS0e3qbn5fjeFqqeljJEfub9Qh8mulGrZT/M/efBH2mwklD0yCm6+ryG4m0fnSXAm39FLGXul+j5iAXrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=JVEINzYK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5becdf7d36aso4771930a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724177769; x=1724782569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHUE1ZYpsKWfvauy5fViupmbjUCSmp8hubrF5lC5SQo=;
        b=JVEINzYKtCkwPNVNhkViRdwlXrJcv7mrFpMf243Vkf5AjLLq/xM7dUhIOCx+euutoz
         yrL8MAdSTQxB/RafZVycPDKAYdLv3DOv2akdCMg3OKiLlnT/I7vb/F826trGZLwIgFAt
         AWID95YmAC2cQ2EIbHWyZmzbTZ5XCx458LWh/aglJi5v64t/fNa5nnVNROSKXvgXk31e
         x2D7xt9B+ybd27wt3s8LTXlQukjew04oelpWLTnSfkknpj+CxzIqhhCnl7Mblxr4fPed
         p2ywLMRXSX96kWZhYa7MSJzFEV7ReoiG0hWdE2PhnZLc/10f/cFo5/SX0sVCmUsDXMJ5
         Cmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724177769; x=1724782569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHUE1ZYpsKWfvauy5fViupmbjUCSmp8hubrF5lC5SQo=;
        b=f8ZB9r554L7sw6/Rv1jBSdJY5ATqIB+I+ym974NkTa4M4K99pOmm6YM1WtfR5D/g/J
         w7tRFHmWGgPKOtqP46cjOV/TNxFP27VHI63thcbUfXIhmZrVjjtx6dXs8u6yel1o1Slz
         MRKavuGfT/Vzr8QobsNlko9wlBudyFs/X0Oz7LIiaiTgxM1TYKxe3S1YcV4clb0sw28K
         4NDrBg+DfifAeNCDm9Cz8F//Uqt6hRpA5A32kjeKB90rzu5+x3AR8bIRWve9xq4+G8aG
         5mcDWwr01TTom70B+B3QBbN88YzGSW1p6+Bi6PlCQ6fcSbeNtpYfgoVNY+LS97Vx+Hyb
         4Svw==
X-Forwarded-Encrypted: i=1; AJvYcCU4AvXMjxW5bXoEF89Xt5L3meobOKNtTO1z1hmM0v4Yt1rn2i/TYUO5f17opT6ox8NOntzr948=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/lNOnJXVITnYe4xZKItDgYPhDpzZILnP7LH5/6zhoq19kEmf
	BguOIHoXfsf0HCfbYvUeGVADy3ol76a68JnuBRxpbYomLl3fgCgX7Cw7sstXdMhd9oqCSxxPBwP
	x7mMDWCl6q4CguzJu0r4NMT9W6oluqYzGpbhB
X-Google-Smtp-Source: AGHT+IEOncGTsTk9GFJ/pgFTXPNBaD+FboxpZPQpdlP9kxnUg5mhd+BrWekld48vUB0I7/1xh7W8yE/X+xaRSPtIoic=
X-Received: by 2002:a05:6402:11d1:b0:5be:fc2e:b7d9 with SMTP id
 4fb4d7f45d1cf-5befc2ec0b8mr4224854a12.36.1724177768212; Tue, 20 Aug 2024
 11:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815214527.2100137-1-tom@herbertland.com> <20240815214527.2100137-6-tom@herbertland.com>
 <20240816180913.73acfa7d@kernel.org>
In-Reply-To: <20240816180913.73acfa7d@kernel.org>
From: Tom Herbert <tom@herbertland.com>
Date: Tue, 20 Aug 2024 11:15:56 -0700
Message-ID: <CALx6S36RJ9poHZBo+T0ZT1YB0Z6gEV5iiC+-C-SJDrBbd1wWvA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/12] flow_dissector: Parse vxlan in UDP
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org, 
	felipe@sipanda.io, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 6:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 15 Aug 2024 14:45:20 -0700 Tom Herbert wrote:
> > +     if (hdr->vx_flags & VXLAN_F_GPE) {
>
> sparse points out that VXLAN_F_GPE needs to be byte swapped
>
> not 100% sure I'm following the scheme but it appears _F_ flags are in
> CPU byte order, and _HF_ flags are in network

Hmmm, VXLAN does seem to be a bit squirrely :-) AFAICT, a VXLAN-GPE
packet isn't self identifying but requires a VNI lookup which is what
the vxlan driver. We don't have access to that table in flow
dissector, but I think we can safely infer a VXLAN-GPE packet if the
next proto-applied flag bit is set (it's always set for VXLAN-GPE,
never for VXLAN).

Tom



> --
> pw-bot: cr

