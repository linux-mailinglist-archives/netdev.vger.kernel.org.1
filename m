Return-Path: <netdev+bounces-151387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907859EE8A8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D81160728
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00046213E92;
	Thu, 12 Dec 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHas12+E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394428837;
	Thu, 12 Dec 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013378; cv=none; b=MiYbC0mXftlCfqDsLgO1sn+FGk69eop1u9rXAf+sCiczBKmBPBaEpJ9P85H2XhM0RTqHJQiExfv8xUOgUYm/G3eEEyUCaBG+11j0fIvvkrszlafArSRL1UwIY16souyeRLS7n2SyKSI/rMP2HXZE0ppMinxYREvk7PZX1NFs820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013378; c=relaxed/simple;
	bh=zKgvEFGqQx2FJ8CDJqBabJFwcSfnDuCHB0lcISfBNS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2wDXmUqQEYZLhRl7HLopLlhgnQR95u+hKPANW5hDmZnaKqJXtWGUB2j4FRyB1C6jpZMz4V6ldPBlge6rQOQsaDFUl0SxTVvGzf9PLK8GdzrKbs22t1EJGnPiKDXNlXcvNI52ki0GSZSn0ff/6RHyxnJC9K4Y9Y1u6+mwA1s6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHas12+E; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54026562221so680654e87.1;
        Thu, 12 Dec 2024 06:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734013375; x=1734618175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS+z2xhMRRsiEpeHQXzr4Hn0U9YM/X5VilCwkW5p+lM=;
        b=HHas12+EjGZbEtldHTjwLTza08S5N0trbRS0b4x96poSlZ87IiCikODZ+amVpfAVwa
         p9FtV/ZREMysD2YuOriDUTIznhs/Codx+SjEviyNwOS/QnjaPKaVn0bpRWX0IcQ8Ucwh
         XzWhAA1X8PSrfl7PyPnOc5xFp9qOxdCDB/WHU1n2qhf4d/h+wL795yeGi4UCDMcKByIX
         WlLZFptHC1twrUw3sVRZVD81eAhWXaGZcLNSxyO3DX97+ae5e6Jmd7Z+nWPiXqC5MyxF
         sdZlt6yvXk8UnQhDhsvGyrrXehmDKk/t4AUKOfntNByQXo6y7RWWBOvWQ+msv3OtNF1t
         I8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734013375; x=1734618175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS+z2xhMRRsiEpeHQXzr4Hn0U9YM/X5VilCwkW5p+lM=;
        b=uLOFQ3ygLDGdvbws5Myc+xj9yUa9X4lgbsq24Dj5NwFElMioCPDUuibm2i27FgHz5f
         njdOgKdt51z24VEyUIOx5Y5XMGJQAlRVCc0jqMoIhjUcTZEb7iwNs4CPoJbPa87uGABm
         ovSC8E0qKSbMbZxnfWp53hxOK+zqIJbvhLq+fpZqZWR9epKfLbTg28njsHgngRCPbSaE
         koVMD2AP+mRBtNVorKepHiGqofog9n9x/Hvy4+zkV9UXA0PxW0WY8y4A1H4bDB71V5+b
         TU+ll+3P/C6BFzSDFWuRnk+3Pyao2q4cgp/OPeHIdDEDkm4JtHHIiJiXpKLH2ZTRo14Y
         yPKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOgSfgn7Db6VVWW/k3gMjTjsCVyv/DwwyAKNm1otiH+L9VRG66Vg3x+8axPiT+x+FbXjm5WWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymffJUxUwi0slSYpPVqinGB2pNIxrLmBJOJBOp9C/Z+vB6eq+M
	6FeQeTKlfRKm9cvyrckIEL0yoRAJluWlVf1HqewY08IWMslkrrhP8dlixaYVIhT2Ml+Jn/S+QtQ
	JeQU77muqRD0DRrUH9bWtDDgmpuS+eg==
X-Gm-Gg: ASbGnct6GztTzr1MbMpXl1nTeducf9j86LiNUFydZF5+WFWlMa3db3VZ3PCxzClfGNh
	1Rvti2w6RzBeEatfQm0O/L8QSqJMF2u5FKvPA7Ew=
X-Google-Smtp-Source: AGHT+IGu8D26QzOkttbsr8xB8ZQzqIMI7ExAmhNiETJBOcsMMgvxSAHL0fcYwa5zbMrMcHX01CPujfMOHSCdkXFvskY=
X-Received: by 2002:a05:6512:33cd:b0:53e:39c2:f036 with SMTP id
 2adb3069b0e04-5403412ed5bmr235070e87.43.1734013374898; Thu, 12 Dec 2024
 06:22:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211172115.1816733-1-luiz.dentz@gmail.com>
 <ba32a8c5-3d90-437e-a4bc-a67304230f79@redhat.com> <b6ebd1f0-d914-4044-913b-621071a1b123@redhat.com>
In-Reply-To: <b6ebd1f0-d914-4044-913b-621071a1b123@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Dec 2024 09:22:40 -0500
Message-ID: <CABBYNZKadKNzMWdP5bsDxTtGXjYhe47nPeLyH49hHHpnTo2Etg@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-12-11
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Thu, Dec 12, 2024 at 7:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 12/12/24 12:55, Paolo Abeni wrote:
> > On 12/11/24 18:21, Luiz Augusto von Dentz wrote:
> >> The following changes since commit 3dd002f20098b9569f8fd7f8703f364571e=
2e975:
> >>
> >>   net: renesas: rswitch: handle stop vs interrupt race (2024-12-10 19:=
08:00 -0800)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.gi=
t tags/for-net-2024-12-11
> >>
> >> for you to fetch changes up to 69e8a8410d7bcd3636091b5915a939b9972f99f=
1:
> >>
> >>   Bluetooth: btmtk: avoid UAF in btmtk_process_coredump (2024-12-11 12=
:01:13 -0500)
> >
> > On top of this I see a new build warning:
> >
> > net/bluetooth/hci_core.c:60:1: warning: symbol 'hci_cb_list_lock' was
> > not declared. Should it be static?
> >
> > Would you mind fixing that and re-sending? We are still on time for
> > tomorrow 'net' PR.
>
> Whoops, I lost track of current time, the net PR will be later today
> (sorry for the confusion!), but there is stills some time for the update.

Will resend it asap.

> /P
>


--=20
Luiz Augusto von Dentz

