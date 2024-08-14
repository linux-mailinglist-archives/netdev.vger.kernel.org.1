Return-Path: <netdev+bounces-118348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A198795157F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A821F24C77
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7701F1448D4;
	Wed, 14 Aug 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjy/UL5o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66D13BC2F
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620447; cv=none; b=UmZfU2h/hKKX40R/pQqLPE03obv2IMbnhEkjEKFr6OCL3NLlYj8jb/2c3PCQjyTVZX5rvnA9TfWmXxap+N1DF2GLWATMLdBft2HeLeGc9Kk05rPHYVgeXrd1VndypFgzqZZX/AeE35dgJ8NVN/u5N5nlQ3UFyZsP/nGF4VXZ6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620447; c=relaxed/simple;
	bh=Oh7Dth0VuGmV7L4BFIpdV5l2Eqlg/db4/+kfPszPPW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZxAvfZoJbsQbPrPXt5mhRgALzfZrH7axnTJptpqOzviKBAQ3E9SGuHnm45ETh3aJy2WEdT0IMvLnPr7sn2Hvh78n/KNpHrozXgcodB0whe56qDn432JyYi4f8LnDSzQfwg/EW0zW+u0u+4ry0q1U/894HMMrrTNBV4pvkPFzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjy/UL5o; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso7262496a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 00:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723620443; x=1724225243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh7Dth0VuGmV7L4BFIpdV5l2Eqlg/db4/+kfPszPPW4=;
        b=Rjy/UL5oKwRrOufIOaca0vwJ89lzTGBUmAroC+GyfRTW/1HapLpErcBuIeS9Ic7wUM
         XQCGBxD68hfnege6E5zkZCQo8ZMCiiMWQcuggmOjBfB81cm7d0O1ooQNk3IGpoq6ZF74
         xiFLsRCftgRNHP2ALEAT5UwIeDRChcEope6KGCs0fvuhfJzCFUz5IG3rYA7LO0u7fUVW
         xRMo/R2ljkBic7k6/akANuWz+Jq1bnI+z/kzSZzKNg0c8+Wf9Gt28FEc9zrcTe8HBl7z
         7bGM1s2YjEYzR2YlkEeAx10bdlOEjXHUSs3AqYi5YS9oV8LZNtxPNt1RuEJ7o96RgnQ/
         tWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723620443; x=1724225243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oh7Dth0VuGmV7L4BFIpdV5l2Eqlg/db4/+kfPszPPW4=;
        b=YVaz2nXu6VQrQBbJigdpmy7akx1OaYXkKYqhEwf/o7gUIG8MxsNlTA65zbf0Zs6hoc
         mKNpVjyDaJWslC1ngOWLBsLkCCrziRKNjbIKLRuVZqkFGw8Si6G1e+mKHZN4CwpxHH3z
         NlnoLx8hwYVtMWY+lKJZ6GgDgswjjcJF8Vj7cdF9LpfQx9/Z6xgtC1bwvg5Hmv+olUYP
         edW2zibwLXl9yhs8VjUwWkaN3Kq2+moTLqC2z2kyNu/FUHVUMv87kTTK4bx7bl9mDWtn
         tLZPwpmcxD21TIKNJsm7qVlHQBHrQhGWmlA7m0El1Tj8i4eMGeB3G2uv5yPQbcsbj8Zs
         u/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiSGge1cTtW8M/TTq6u6czWo+2/ZKjlaR49sbZaElwjKoVEklJEESd3DxJRTHypCbmE/w5VpWKD7vF3QcvE+7jne4DOMNo
X-Gm-Message-State: AOJu0Yyv3GlEKkToVrqiwT/gcPyXV1j1uO0YNtAq0hkmnzaBkvCpyZyF
	kTsbPPTnKnnsQkzzR7lqD1/lBTmLrl7rCIla7Kdj1WkhMbSUUHdGe/EOMGlqYjSaAYyGBb/VCL+
	d7A6C53Y677e3toyr1EOT/L568TkK5R4C
X-Google-Smtp-Source: AGHT+IF/34Qlj63YIDQwB354wQ3VqF3AoqDvRuFGddIUqwSowBMBgelEE9rO/NbWMImEA/zGqsBEZvQmf0aW2peYTYg=
X-Received: by 2002:a05:6402:42d3:b0:59e:f6e7:5521 with SMTP id
 4fb4d7f45d1cf-5bea1c7b7a0mr1282295a12.19.1723620442377; Wed, 14 Aug 2024
 00:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMArcTXtKGp24EAd6xUva0x=81agVcNkm9rMos+CdEh6V_Ae4g@mail.gmail.com>
 <20240813181708.5ff6f5de@kernel.org>
In-Reply-To: <20240813181708.5ff6f5de@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 14 Aug 2024 16:27:10 +0900
Message-ID: <CAMArcTV4nHDpwKTH0JxcLB2tU23gTDtvFp5wNWjJNdw8+ZFGqw@mail.gmail.com>
Subject: Re: Question about TPA/HDS feature of bnxt_en
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, David Wei <dw@davidwei.uk>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Mina Almasry <almasrymina@google.com>, 
	Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:17=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>

Hi Jakub,

> On Tue, 13 Aug 2024 19:42:51 +0900 Taehee Yoo wrote:
> > Hi,
> > I'm currently testing the device memory TCP feature with the bnxt_en
> > driver because Broadcom NICs support TPA/HDS, which is a mandatory
> > feature for the devmem TCP.
> > But it doesn't work for short-sized packets(under 300?)
> > So, the devmem TCP stops or errors out if it receives non-header-splitt=
ed skb.
> >
> > I hope the bnxt_en driver or firmware has options that force TPA to
> > work for short-sized packets.
> > So, Can I get any condition information on TPA?
>
> I don't have any non-public info but look around the driver for
> rx_copy_thresh, it seems to be sent to FW. I wonder if setting
> it to 1 or 0 would work. Especially this:
>
> static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info =
*vnic)
> ...
> req->hds_threshold =3D cpu_to_le16(bp->rx_copy_thresh);

Thank you so much for looking into this!
As you said, I tested setting hds_threshold to 0, it works well.
I think we can implement `ethtool -G eth0 tcp-data-split on` option with th=
is.

Thank you so much again,
Taehee Yoo

