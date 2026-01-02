Return-Path: <netdev+bounces-246613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB514CEF353
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 19:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10D99302356E
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 18:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0618A315D27;
	Fri,  2 Jan 2026 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lv8jfAZn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761E28750B
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379980; cv=none; b=gib6FDYpLe7lYz0F7KJYXY5yw+WpIBXy2uGIPsUqs6gbQN2wCvC6fmIsJVw1y9JkuBsGmJv+qEqqyYjB1c5leSGdUaR8bwQp8GqzCmaNNQX1tDdGw3oe7qCB45MGgG5hdsew00Fd3UWM3r+fsAd3dMTS9ZGjbSsEwJz9jAE682A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379980; c=relaxed/simple;
	bh=CGKOJpn9cfMI2qBIMVNddWue424iey9R6jB3Snw2F44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSm0m6o2ZTeX3lozplCBkUMMiFY9EDHQ5BPud21VJrkI+qdEWN6+mBI6uBSnyN2E8jPcCXyUAh725sXf6NMil2eoKvih9MO7DDzhOZGMLknBccupFlZF8ir1ZaNyGf4XTQ3sZ63xtIAAYqCPY7UiKOv4zX9m8XbTv0OsZiPgEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lv8jfAZn; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5e186858102so4382884137.0
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 10:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767379978; x=1767984778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/gceKhMcY5ch3sp6ymd7zYrbfYD9qDp9/dmKeCE2qQ=;
        b=Lv8jfAZnXly0CaLj30B9TH5NEJkwTj7MTwudbKlBLRfaX16I1wUXmZ96KXgz2mKvGL
         faKuWL6BJFuB/ePgkzKeMagnSL+F+88iVQ8dMUKE4AWgyhCb1nhLR3QmFIULQxihHTxo
         lvdToTIf3iGjvwb3NyTzAFW3aW8mggj5Jfe4f2h36J+qKZB7dOHKOxdWjVfi/dDuOA7Y
         itYiXyh7YG/vjmErhKtuO6zPGGG5qXU1SOQZEpgR90e++3OIZnG+tv+46O7ujYEsi3kT
         /B4cjoQ6Znyk36dLm0nf2vTA6dd/4kEN6PjldkbfB/LP2xYIcSBdsin5DuRhGDvXjMmU
         H6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379978; x=1767984778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/gceKhMcY5ch3sp6ymd7zYrbfYD9qDp9/dmKeCE2qQ=;
        b=hJJhifkmKQrO22Mk6L6UojisHAz/SDp4MKWF3s6VSDY2zbc7tZeBLXG8312FsoMAoI
         Pd1K1L4e9B4XLOAgoU1btFbmn3Yx/T3tMQ7fy7RiZXzBNSGURPQCfS/nqMoMraIfCS61
         OwGqCXrM0l0MKdiajKE2G5Pi0J5ckcqUkLSRWqn68TWrlyZ6bJurG3kHUxlEAzE5qJCm
         WeBIBG138Ug374kIYgx5Ah9CX8TvAGPvkxgdi+dO9n7lSbwFOpLGBsc9DhaWc2jP0Wd9
         k4/waxeEAJryr1DlMYOBekW3s7PQ7De4W43HNMa20uVohdNYtZ9pF2JzkK7toMdgX9wM
         ou/Q==
X-Gm-Message-State: AOJu0YyxaqCHfXtm9U3cRGwdYNyW3OWOUkUhn/phRkixldkgxP/PVIp/
	F8mN5+9HLk7dEf4zCBaViJybKPV4OivHPA3nkuJTtIzjvV++DNBuPuiyHhjgYjMoBRYLQHViUPo
	GJwLP3eQdiN3RYfbeX9ThNsntybrg9pnf37uanwO1DsAid4ZPjZR1XP4=
X-Gm-Gg: AY/fxX4sP/jVPzVSHqMBUFRRhoNB2Ns7rT0udcbaIF1OOhDJrHAXGTyX7F91eRs0EOp
	7Piq6Nw6mXZBSLJ48u4Fa5gqggsV5MpBoz1T5WgLHwZe6k4o3zw4aLYdEaM4/KKinVdMs/3GQU8
	Q6qKJBvVa8JeXAsoyh1NgiQh41HRGFhI+tPtk6GTaogt04zf08CegrjAGvcDx6HP8pdwh20r5rg
	tkapDgH0aFgoYyIpri+xuahzCU++D0nchCn+7XqjhdmfA4LJvHI6lEtvHGChYhSQ4SQ+s+dH1Cr
	Uw8y8A==
X-Google-Smtp-Source: AGHT+IFJOuZuL93FURz0m0Ps1uyR3HURvWPNAphdTppf8rChqllBpGJVtym/pANdlgre4zvnYnoNCCntIk8/xLK62jo=
X-Received: by 2002:a05:6102:3f93:b0:5df:c094:628d with SMTP id
 ada2fe7eead31-5eb1a6259admr12537230137.3.1767379978181; Fri, 02 Jan 2026
 10:52:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230224137.3600355-1-rjethwani@purestorage.com>
 <58a92263-47cb-4920-82eb-2400005b0335@lunn.ch> <CAKaoeS3rRk8FGv+zb_vYuYoMAPe7gAsgxq_TKG4OcT5QkKOwjA@mail.gmail.com>
 <86879bd7-0b26-483d-b261-728d13c40b57@lunn.ch>
In-Reply-To: <86879bd7-0b26-483d-b261-728d13c40b57@lunn.ch>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Fri, 2 Jan 2026 10:52:47 -0800
X-Gm-Features: AQt7F2qg-eS2CbHPURjcssFvLvqJD3fcpF0R9beGAG7piYhEm1pwGvy6eOc7knE
Message-ID: <CAKaoeS3LTGP3XZDiJAgXsAguGA=caxEyiUfjH2B2-Q5bV33_NA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tls: Add TLS 1.3 hardware offload support
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Added note about Broadcom bnxt_en out-of-tree driver used for testing.

v3: https://lore.kernel.org/netdev/20260102184708.24618-1-rjethwani@puresto=
rage.com/

On Thu, Jan 1, 2026 at 1:32=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Dec 31, 2025 at 11:34:04AM -0800, Rishikesh Jethwani wrote:
> > On Wed, Dec 31, 2025 at 1:17=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > Tested on the following hardware:
> > > > - Broadcom BCM957608 (Thor 2)
> > > > - Mellanox ConnectX-6 Dx (Crypto Enabled)
> > > >
> > > > Both TX and RX hardware offload verified working with:
> > > > - TLS 1.3 AES-GCM-128
> > > > - TLS 1.3 AES-GCM-256
> > >
> > > You don't patch any broadcom driver. Does that mean it just works? Th=
e
> > > changes to the core are all that are needed for BCM957608?
> >
> > The upstream Broadcom bnxt_en driver does not yet support kTLS offload.
> > Testing was performed using the out-of-tree driver version
> > bnxt_en-1.10.3-235.1.154.0,
> > which works without modifications.
>
> Please include this in the commit message.
>
>        Andrew

