Return-Path: <netdev+bounces-178681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87725A78398
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 22:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028663AECD3
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 20:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4D61F0E3E;
	Tue,  1 Apr 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GN85febK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2691E9B39
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540528; cv=none; b=J+4vwcymfLuITrNsnAf5XDUY2Koo7oBiygFrtl8Q2FpT0Da9GelrH13ZX0e4Ys8AHUY9FVGPE8TdNYRbbbE2avoWtbMRA7oEvOGLsvTIET6jooqE6lSF/2WLDEC0qN+99lo+K7eerO7Ldn6jWvrKh9WdOUN8pLNhCV7PcBJcOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540528; c=relaxed/simple;
	bh=qwztNLshqymLlN2X4UgeFOrucyjgwUfhecdMODasoMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iG28iSmameA077n+LDltm55SXVpz6jT05GGZ08UKMxI/k7/wRRtv8+PgHIhlHH807VYpDESI8szNG3y47uDn3qOKgVyhvyUE6A/O5b7JiPodokkGNz3YxRxBMP5piMBfoZXKQXPvQUm+qUNR7w3a72o56gOpBMq+OXmXTBlnSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GN85febK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so43332055e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743540525; x=1744145325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkO4a88+Txv/GLJVvPTo4zIPNNIrQG92E4ZbquZedeE=;
        b=GN85febK07OyH8QYrolrmfBh8t/atxvtcmmkKO+LCCAc/4nm4IbHG8M8TiejpUdpdm
         H8O7wCRRPBBEx6COlTZiV/HStCSIkyM3VquiMqfnqlCxSrdgtxT49PIOPSJjUM6Kc6n9
         2ptDoMJsg1+LDiaJzQPTh+F8p8XAzhYnDlS5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540525; x=1744145325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkO4a88+Txv/GLJVvPTo4zIPNNIrQG92E4ZbquZedeE=;
        b=ZT4ciItQMfZUpIuBcselvaAbbN4KTJX55zullrmGaMZgpU3xgjWE6W1e4eQ9kebdvJ
         V9+E79QaGN80IGV3NYbNB6zmen0EmW3Np6JC0cTZwqTNlNSk9br5hDXgCoeYgNtrwbT8
         8hCLSA9B7BATgxu/yxubXg3HbdS2luyS9Zp4DFPLRjEqZRfFqabVuLFX1sr8pTAsrqbW
         8y+xNBvCMAbJ36dpg3HDd0jBIOS36bZxdzm2ENqesQFmzmHDSWrXE34C3afQ1I/3Zpmd
         RlZmUU8eduuH/gLJFC/tQbphqqsPtcdGz99gN6m8a2N+cMG1+trzYWvviGwRM5FALqaX
         ZpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfF4iZGeK+jGhNxd91vdsmUf4nSwEK7RhKblr6rG29+3jyJ0TyWKH7fRvlRiDx55/U29pLXik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0irpQ1TTV6wbBIULv73Tmn/xQhZ9StLCm72tSetkawiYeJgMB
	4QaQDzQMkNlpIiE/xbmPwFrtfjnwpcMjGS/a0UlJBH2S+x3i5N4/Zf+TY/pgi5+sBrvjB9y/FbX
	TDSzGZmZkrYhkIV8xudiwkTg8cJGcblWu/Fu6
X-Gm-Gg: ASbGncvzzNbNCKu3ETGKekpj1EfIjiVKXO9pYM4vIs4dSGspJ7xmPk17kayPWGrPBKz
	cMhmnSOssGIqEoqIU4qbJB0RTJZ3tr06lSMPL5bNa1wKx/wk5mrmovezuWoePlsArUpBxYeNZQV
	dDDBaIF0ibSts6j2NoraljuO9T6W4=
X-Google-Smtp-Source: AGHT+IFIMvNtEEcNZfKRl7q+JoxC15xSd+SXbP0Vz47P/z+prk1TU3mVNFVIKV+JeDHOGNaMwYzJiIWIykH4uNPP1I8=
X-Received: by 2002:a05:600c:83cc:b0:43d:160:cd97 with SMTP id
 5b1f17b1804b1-43db62b59d7mr121396845e9.25.1743540525321; Tue, 01 Apr 2025
 13:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
 <20250223133456.GA53094@unreal> <CA+sbYW3VdewdCrU+PtvAksXXyi=zgGm6Yk=BHNNfbp1DDjRKcQ@mail.gmail.com>
 <20250401134133.GD186258@ziepe.ca>
In-Reply-To: <20250401134133.GD186258@ziepe.ca>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Tue, 1 Apr 2025 16:48:34 -0400
X-Gm-Features: AQ5f1JpIsW_7IkXLGjeXIQXGkdUItH5Ex9T6h9foDQscw-Izjnyr_X4gXQVfmwk
Message-ID: <CACDg6nXwG8ibo=PHnz3WpMzkJbWuWrRtTcj3-JJDDdc9RMm+PA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 0/9] RDMA/bnxt_re: Driver Debug Enhancements
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma@vger.kernel.org, kalesh-anakkur.purayil@broadcom.com, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, abeni@redhat.com, horms@kernel.org, 
	michael.chan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:41=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Feb 24, 2025 at 02:30:04PM +0530, Selvin Xavier wrote:
> > > I'm aware that you are not keeping objects itself, but their shadow
> > > copy. So if you want, your FW can store these failed objects and you
> > > will retrieve them through existing netdev side (ethtool -w ...).
>
> > FW doesn't have enough memory to backup this info. It needs to
> > be backed up in the host memory and FW has to write it to host memory
> > when an error happens. This is possible in some newer FW versions.
> > But itt is not just the HW context that we are caching here. We need to=
 backup
> > some host side driver/lib info also to correlate with the HW context.
> > We have been debugging issues like this using our Out of box driver
> > and we find it useful to get the context
> > of failure. Some of the internal tools can decode this information and
> > we want to
> > have the same behavior between inbox and Out of Box driver.
>
> Can you run some kind of daemon in userspace to collect this
> information in real time, maybe using fwctl or something instead of
> having the driver capture it?
>

Looking at a real-time log is exactly what we are doing.  We have
support for infrastructure to do that already so just adding this log
would not be too difficult.

