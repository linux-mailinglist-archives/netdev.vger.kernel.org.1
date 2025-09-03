Return-Path: <netdev+bounces-219481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006ABB418A8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631DE2051B6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EB82EBBB9;
	Wed,  3 Sep 2025 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viEOOW+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81412D77E8
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888523; cv=none; b=COfJTdJOqgt0Mf1JIJ9Upw2KDynCU1fZ6uiyQWnjvwfopvu4bNmAdvs0/cTraAOgYZ6MeuNK8oJwDasV/B8WDR+nng8jguVtm9ULrfDi+53A0XhHjhdOgWhqxE+hARzSzccxNd2SYrVNO+ZzxmeUeP3DyPrti65Y0uq7Gwna4yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888523; c=relaxed/simple;
	bh=R2N9spdLU9NDJo/nKcHKtiGIcW8ZX4PMkuXiFvh55Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRRwYWyWJvgtju8Q0EPnbuv5da7RgukYSOcj11e5ezFYKVPaHt+TG3vBGLVzKU8HUw1Q4pcuELS9+qQD+s1wIIRC6sfRKuHYVp6203IhedvXe8Favo0Tmy3/dgsZtbFbWowEkjXDwmdigu7vbULxhPR+W0Gdqejn2PIBeJ2S2uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=viEOOW+s; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b30d24f686so6938321cf.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756888520; x=1757493320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd3MZy7ytHCCFLjEgD8JYRORuypNow1ky2mT/O++Gu4=;
        b=viEOOW+sAAd4VQCVGmHS4lfURm3HpRBYtI2fr+db8RS4HkL1/jSxCErVNVnPZAd4Po
         ACroq8JH8fVyt5ky6fbJ+S81terYhBF2/VEvZJuNe654VTgVnbMBXn2yloVOf7y8qgmQ
         DLYYrxirrujiM3iEHIWGH8K1GqikiN/TmVycut0gkaWv78Pvmu1IgWDNcQZqcU91dj5L
         ePgWyljmsXpxrGTXVaWRkkmYvZ7ZAIbjfuewQPQZpiNwY2HJIeeIN85GAeSM/5NPm2hN
         GaLN9VqfsfayZNxzvhbS1tcmOmgeMMV6iqY+Qd+Ut7n3dSRTePnhlR8H5eP49RVF8noO
         bYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888520; x=1757493320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wd3MZy7ytHCCFLjEgD8JYRORuypNow1ky2mT/O++Gu4=;
        b=lDNytOb6Cd/bmfQ1xKb8p1ZOqvJF7kWYBqVHjBNiBKGcPrph5f9eUPpkZG0Rb7d7dt
         s23oqmyt5cGyp0yPupDfJocUGKhqxk2Y6xitkYKY7PeQUVb+Zk2uM2wctiFDb4uJBE0E
         9S+gcXKz8HAd6yHxys6X6q76ydZd7oKds3o/dXxCgQHglIRZPDzZzToQ6FMHYxBdUA+b
         rkH78fOsL2V/eraGiW4R1bbfTmbWhwYh5/flFlHUSnfhpWbv8myAbhBsXzq5WLD3L5N/
         1+xUlK/Qks5rB4MO8c7VinFDaSl6fuYjUGPw13RzWISQGESc1nluNJVKZDsBrdtm5vpA
         qrag==
X-Forwarded-Encrypted: i=1; AJvYcCXclYoA+zJOKyA8XNkdv2FfRuHidwb01jQ4An7/io2M8lNH7hVFT/zhAzcHvzUVPS6Z4ES1W/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdlXDIpke09n5Pbb7wZ0TFT77i9qcnLmByv3xu/B9/Evge7inf
	9UAwTdk5AsrcSmbE46TsDwGRA5/K8xfa5TAKg4zRYAGhSAw3q4o1hpxCuzHExlh4l/dPpjJTWKH
	QYCPtBS0afwBGYv+w2eP8nsrAq/2/2gjVJz+uZLlG
X-Gm-Gg: ASbGncv2l2C7DE2fhLzPZvYx71QWP5maT/TMRI/cMXRMqwJpmTA69UPcfUE9+JR87WK
	zrCFtVjXb64F2BkBwP0lSfjEMSXJQZXG4Sdpeuo6tpplJoqYvWD7wpTguDeaEm2u4DmYaSJVIVx
	5Tp6Nezp4uzpB/vmePFWYPPGZjOO55W5IM8mplxv14nUAXebFZefvQNG7Pt/CX89EQyM+jm8CnH
	1pRg2EDC2uPt+Nsfrqu95wL
X-Google-Smtp-Source: AGHT+IGbvDOSDCQ/4PJr/B7CKPjOPOnfqMSCE15+0FaFcZBeenWNWBxrhjYrJLZpNi+8mOlrBc/kdOWTOcAPufBS1zI=
X-Received: by 2002:a05:622a:4116:b0:4b2:ec43:3de4 with SMTP id
 d75a77b69052e-4b31dcb27f5mr196466861cf.75.1756888520296; Wed, 03 Sep 2025
 01:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903024406.2418362-1-xuanqiang.luo@linux.dev>
 <CANn89i+XH95h4UANWpR-39LSRkvM3LL=_pRL0+6fp6dwTZxn_g@mail.gmail.com> <CAL+tcoAPdLYPu+HE=pA=T9T7J+b19Mg2BRgP3PM2d8_z6iXgYQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAPdLYPu+HE=pA=T9T7J+b19Mg2BRgP3PM2d8_z6iXgYQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Sep 2025 01:35:08 -0700
X-Gm-Features: Ac12FXx2qrJTucXvUQQDb7aw_L-yjCfH8KD01n_ZyyD-39DwUTy2Hz4kmXQNEw8
Message-ID: <CANn89i+AMitXNYNo6h7GPBHsk2sVSbmH-8BQLRFDeihEd9-oQQ@mail.gmail.com>
Subject: Re: [PATCH net] inet: Avoid established lookup missing active sk
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Xuanqiang Luo <xuanqiang.luo@linux.dev>, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, kernelxing@tencent.com, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:53=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Sep 3, 2025 at 2:40=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Tue, Sep 2, 2025 at 7:46=E2=80=AFPM Xuanqiang Luo <xuanqiang.luo@lin=
ux.dev> wrote:
> > >
> > > From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > >
> > > Since the lookup of sk in ehash is lockless, when one CPU is performi=
ng a
> > > lookup while another CPU is executing delete and insert operations
> > > (deleting reqsk and inserting sk), the lookup CPU may miss either of
> > > them, if sk cannot be found, an RST may be sent.
> > >
> > > The call trace map is drawn as follows:
> > >    CPU 0                           CPU 1
> > >    -----                           -----
> > >                                 spin_lock()
> > >                                 sk_nulls_del_node_init_rcu(osk)
> > > __inet_lookup_established()
> > >                                 __sk_nulls_add_node_rcu(sk, list)
> > >                                 spin_unlock()
> > >
> > > We can try using spin_lock()/spin_unlock() to wait for ehash updates
> > > (ensuring all deletions and insertions are completed) after a failed
> > > lookup in ehash, then lookup sk again after the update. Since the sk
> > > expected to be found is unlikely to encounter the aforementioned scen=
ario
> > > multiple times consecutively, we only need one update.
> >
> > No need for a lock really...
> > - add the new node (with a temporary 'wrong' nulls value),
> > - delete the old node
> > - replace the nulls value by the expected one.
>
> Yes. The plan is simple enough to fix this particular issue and I
> verified in production long ago. Sadly the following patch got
> reverted...
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D3f4ca5fafc08881d7a57daa20449d171f2887043

Please read again what I wrote, and compare it to your old patch.

- add the new node (with a temporary 'wrong' nulls value),
- delete the old node
- replace the nulls value by the expected one.

Can you see a difference ?

