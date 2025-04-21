Return-Path: <netdev+bounces-184418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3ECA95556
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197D8188DD29
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567C11E3DEF;
	Mon, 21 Apr 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pu4DAup0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDFE1EA80
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745256941; cv=none; b=Kj1Z7+CbbYICYt6c6LUQHfP/uHHNLofJHpM+TNBwM5QmG55RiOrl98F+85Mxr15CFwsMcPVUbgK9/sRZO9c3tuZWjTzzSFRuKL4IUb5jhEQEAeM/ijP5Wc4WbmoXC8+Ycys3f6ZG0zWlrMByKgfnQe3G9E1aAT2ztCvtkpaxAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745256941; c=relaxed/simple;
	bh=hmSzqGsTEs3QiqBlEW1804SOhwdh5NLn8cDDY0kAwxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SREVD0xOgXjCZuMajgPsjppgmaZAw0SKJ5vKwT1Fk+0JVDRw/SS987Uaaqs5pc1oCi9C6UUwtYj4n5gajL2ODxWg6oB+LKxmQ6g4tXK/kBETWfVNJRqwhUnm8/SWzrAOpcIgS+d+WHU2dxBFl1NZZa1tpGI3DnwrE2dTCAeesAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pu4DAup0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso7358219a12.0
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 10:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745256938; x=1745861738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SogFHnzJwTbv5IaXaFxg3/UsLRTKjoHS9E0vex9M12o=;
        b=Pu4DAup0H++qqExK4cnZ9G2jgZysb4PtNKaVMRphW9Blhs3B0AW6MUoe9BcVGGLxA9
         /MKXAM59/USjnjXhUrK6ivVlxzdh6GO1z1OVr1JOSxHR5egqZ580zoH2Twsfq1vTSOzd
         /PflJ4Kv4PsWgvlz8Fomp41V7Et6q8pmTLyO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745256938; x=1745861738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SogFHnzJwTbv5IaXaFxg3/UsLRTKjoHS9E0vex9M12o=;
        b=Ro428Gw7dnzJ4f0lK05nMVdYgxECuzDrZJV4AdKfqLXd4/lPdkN6wfELySYpF74sEZ
         o5uJVRrggmLGGoTHyz9W3SYEuTeNzgaEp8K8GPRLE/lqEme4IotLzGqUawqLsgqqqASJ
         8yJnd0x6skW6fOoNlIxbJrCSfLSC0Y+4YJsO6wXX7MKpYFqGvwCf1Pfq+XW3Yjj2rJ2O
         iKiT23JkXU5jHhAabjS6jXSQkbwD0mdG8SSrxDfVD7pttGXLcjaPmKsq/r91hqAw5AJ1
         6LN863jqNZCibedaoxtvebfBumZ9brXZcX6kUgqUVTnySyyyKFV49T3AMfR42kbXa3YB
         EESg==
X-Forwarded-Encrypted: i=1; AJvYcCUV5nYgAySLB222DIL80Um4/3z6ezE2FO96kSzBdjo0RB4EQVakPjfqBWLJG7PyO4qFmRPz94g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU0tlmPYd9QkCwvoHjCshZK6g0zzFLdEy/obbdFnZo+5bCwArM
	GF2pcy5OF/Iu+UH0pNrIKKGUi5EcP6VI4M9/ElG/7n+Z0wo9U4bt3FcCeicloFQpCUCG5DeUdaz
	WakU5utsu+Jh2049wqKf3DlfuZPkDlhtMYPOy
X-Gm-Gg: ASbGncvn4HQ071RshMoNONrmbvXH13weMRexkWtj6hPt5am4MwPKGw/EKhkTn4gUJ5i
	Q/b9bJddZS+Hu9eLWRe5Gwq7xqONFOy7Sl4qgEzHRn5vZjeIvs92DDiWHwuccd8R5/xoFV13CQg
	yrx3dPAT8iBVwjxYBY8Gue+/U=
X-Google-Smtp-Source: AGHT+IFrFSgOTX+BGQAsbmCNEpP/ZUu11MtWy5IWQ6G4ie4KVvpucAhUsv24G04U9zpHfapVBtCYTcHz4ZDBO8S7StQ=
X-Received: by 2002:a05:6402:3546:b0:5f4:d572:68a with SMTP id
 4fb4d7f45d1cf-5f6285781d6mr9266346a12.12.1745256937725; Mon, 21 Apr 2025
 10:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417160141.4091537-1-vadfed@meta.com> <CALs4sv1sKLABmzHNj3DuMRYjJBm2_t2WZttr56DfHozpA7kqrQ@mail.gmail.com>
In-Reply-To: <CALs4sv1sKLABmzHNj3DuMRYjJBm2_t2WZttr56DfHozpA7kqrQ@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 21 Apr 2025 10:35:26 -0700
X-Gm-Features: ATxdqUGqiPZMYP-O2UjUfchhxanJnZDa-udWSfUGAg81Zyrah0P_PjSn7xMZxoo
Message-ID: <CACKFLimoVkYG24yJPK6cTRhGGoF6eR8g=Pu__Qf1j00usEXb6w@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: improve TX timestamping FIFO configuration
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Richard Cochran <richardcochran@gmail.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:39=E2=80=AFAM Pavan Chebbi <pavan.chebbi@broadcom=
.com> wrote:
>
> On Thu, Apr 17, 2025 at 9:31=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com>=
 wrote:
> >
> > +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp)
> > +{
> > +       struct bnxt_ptp_tx_req *txts_req;
> > +       u16 cons =3D ptp->txts_cons;
> > +
> > +       /* make sure ptp aux worker finished with
> > +        * possible BNXT_STATE_OPEN set
> > +        */
> > +       ptp_cancel_worker_sync(ptp->ptp_clock);
> > +
> > +       ptp->tx_avail =3D BNXT_MAX_TX_TS;
> > +       while (cons !=3D ptp->txts_prod) {
> > +               txts_req =3D &ptp->txts_req[cons];
> > +               if (!IS_ERR_OR_NULL(txts_req->tx_skb))
> > +                       dev_kfree_skb_any(txts_req->tx_skb);
>
> For completeness, should we not set txts_req->tx_skb =3D NULL here, just
> like we did in bnxt_ptp_clear which is now gone.

I agree it is better to set it to NULL so we don't keep a dangling
pointer in the array.  But I think it is not strictly necessary
because only the entries between cons and prod are valid.  This loop
will advance cons to prod.

>
> > +               cons =3D NEXT_TXTS(cons);
> > +       }

