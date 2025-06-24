Return-Path: <netdev+bounces-200792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2DEAE6EA0
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4C03A8F7D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828582E6D15;
	Tue, 24 Jun 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="frN3BPTD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8D2356CF
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789892; cv=none; b=HpRQyrUXf7Tzkcw3FYNeO1Kvi1zRERwHrfK6MjDXMByiJTBAgeeAlegV4ehhORDMhYgE1ZIERZTQ2lLffuFM36ZxD1AoZltYD8QB12bCBUupWPtejEgCMb+AABohEJSbxwcbw7r3EOWkHHUDQwowg+5K4V5Si0lYqTInCBppE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789892; c=relaxed/simple;
	bh=oxggGxlEAxQEG8dw/1WSvlADiepky9mdW9MNmieccOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3SGIGaV93FTztMig4Arbeqk9UU9NM0zZNKnHcLsA1jbRNsd4gzF0+J7m31MLCPbBnAAYg2T9ZORzxQaxdzGNZz1iwtSVCo1Y+io8QSo1E/SY2RDSLFGeFwgZ9hddURIGUYrDZmoE0hmWlCVBDAU9FoZyk2Ultm4NK7NS2Cs2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=frN3BPTD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a522224582so446608f8f.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750789889; x=1751394689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wcG9j8VdN/npPwgyr0htyxSJI9SVIjp3ma+CA4lJZY=;
        b=frN3BPTDIdQzrJIYBwis8zfSQMoyLD4EMPu/S6n7IBWNYVWI7rppG0w6NnjxKAagin
         pG+IFvzB3MiwhZgXdjQ2W3e+oMYDMfoUCs67iH47CDwS2sZcNLmNiV1qX5vD3sUeXdpr
         IJJVqmxR9tb22c8BoJj7UudPDSjJtzMKTUJZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750789889; x=1751394689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wcG9j8VdN/npPwgyr0htyxSJI9SVIjp3ma+CA4lJZY=;
        b=q19NR7rTbAEBXXY4AJ/+FRqhH+p34YGI2I7JUCmJ/a5AjzGsn/vMb2XczZkmPRdJwK
         Pen83eh+dFsv5/BKNr+Cm0E9+zykde1yGTSWneygC/MPrOlqMG4aWG+jQY6/jHdSCic8
         xgTWES/8iUJhnjOgvWQaxPpAUM+laCb9FAEMFPZ+ux9Hs/b9cOSZW/sXULvaCU/M0GDq
         M1QF4c/bgPhCBT8pWhe5ZKK9niAKOE0An5lyrR7gKwE8GhA+UxwHWNGU9Avfmo2wEiaT
         T/bpjzmfMyLd9fGH+WKgqzb8cL1yOGF2Wpsgty5SK9FkuBy1OGFOGVlwOy0twsGtYxsz
         GBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrCmjvNi2i3lPUtnk3hvWj25MGGq6EIV2UFJauw2ig9QT06Wopx2tuk05alSHR6UKVCDo2BVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjwMAJ50+nwK7jZC6suZSYCHiUR1sV4pwHHEjFpJYhefl89GPo
	vM6Uu7PEBr3JGKX4rfo3dBHRvDy/yNSRNKtgeduflhwlgkPjU0e2ZjYpN72mUPVCJQrHC2t4Ccg
	r61XFNeZ3SHnjOxnCtDziF0olVNPRu49mm5w2wuh9
X-Gm-Gg: ASbGncvUrsB6qmtZCC5prIphmtL81FQNZi52XUW1hG5pFudKiE41OnyYufMMaWG/nn6
	A9x74GSk4TUGiue3Hk+CUi0ShQ2dbha5ihaKi+i41Rx7mObYVjdXQYvCuko9L0qrr5ZTwqDoNyc
	2Njtn+YjRpC25lZOyXZvcnDdn16u3ToGh3U/TQAhJObtDu
X-Google-Smtp-Source: AGHT+IHlsJf8+bi5OMmeyYd45t8XxJc7w9Vdsy57udvF0huW0fRWNhgY20XQo1TYvMIZI/PAdLdm921J3sfinlX3PFU=
X-Received: by 2002:a05:6000:2f83:b0:3a5:2d42:aa25 with SMTP id
 ffacd0b85a97d-3a6ec4d3cd3mr776826f8f.50.1750789889090; Tue, 24 Jun 2025
 11:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFl7jpCNzscumuN2@debian.debian> <633986ae-75c4-44fa-96f8-2dde00e17530@kernel.org>
 <CACKFLik8Ve4=eUV=TJMkwkScLN0H80TtiqPUwtuDqNEji+StSQ@mail.gmail.com>
In-Reply-To: <CACKFLik8Ve4=eUV=TJMkwkScLN0H80TtiqPUwtuDqNEji+StSQ@mail.gmail.com>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Tue, 24 Jun 2025 14:31:18 -0400
X-Gm-Features: Ac12FXzy1JNsBli5zeDTmdvBa1itDipHFkLbZK-3c1TY40dRr2V_CjtW_YzgdDY
Message-ID: <CACDg6nWEAKWU3s1x+NRU28BcXHK0=yFkAAU4MMkSTgEA9g592w@mail.gmail.com>
Subject: Re: [PATCH net] bnxt: properly flush XDP redirect lists
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 2:00=E2=80=AFPM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Mon, Jun 23, 2025 at 10:59=E2=80=AFPM Jesper Dangaard Brouer <hawk@ker=
nel.org> wrote:
> >
> > On 23/06/2025 18.06, Yan Zhai wrote:
> > > We encountered following crash when testing a XDP_REDIRECT feature
> > > in production:
> > >
> > [...]
> > >
> > (To Andy + Michael:)
> > The initial bug was introduced in [1] commit a7559bc8c17c ("bnxt:
> > support transmit and free of aggregation buffers") in bnxt_rx_xdp()
> > where case XDP_TX zeros the *event, that also carries the XDP-redirect
> > indication.
> > I'm wondering if the driver should not reset the *event value?
> > (all other drive code paths doesn't)
>
> Resetting *event was only correct before XDP_REDIRECT support was added.
>
> >
> >
> > > We can stably reproduce this crash by returning XDP_TX
> > > and XDP_REDIRECT randomly for incoming packets in a naive XDP program=
.
> > > Properly propagate the XDP_REDIRECT events back fixes the crash.
>
> Thanks for the patch.  The fix is similar to edc0140cc3b7 ("bnxt_en:
> Flush XDP for bnxt_poll_nitroa0()'s NAPI")
>
> Somehow the fix was only applied to one chip's poll function and not
> the other chips' poll functions.

Odd that we missed this back then.  Thanks for the fix for all other device=
s.

> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

