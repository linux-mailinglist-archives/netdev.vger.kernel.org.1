Return-Path: <netdev+bounces-239658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ADFC6B247
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0952A4E24FF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566203563DC;
	Tue, 18 Nov 2025 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7jnD6cT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E40322DAF
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489514; cv=none; b=YYNzmzfvP1pOYPWqCoWxrhclzBpMSyzo3KsIosBqk9PFHLcd08m38kyTB9/cVdPhZOiW7logjrB0XREmvANAdWhmbYKDcXS7sg6Cf8shBdFiBfwP0UfmGZEmPnVDCD8QK6XqBNQkdETnjhPtSRtpVpXht6FB7h8jke96fhoruLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489514; c=relaxed/simple;
	bh=Db461TIQaJOzcd2Ab9kKZXL037QmCFFsDbIm1umLS5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRE86Gxy+fpagKuMPmgjWUdXfF2sEO+KY7nw2+Cm8PtNJpY4+Lbddr8JlsuOo3xPIeMMWaS81HfUGucftPD+iD3T4rxO+6P+kBvEtYkQ+j74NaKTQvRQB85Gij6m0ZuHTQ3Qxs7pZHaIbzl+C/nuqPdO/mvRXQvZreowLCXTe2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7jnD6cT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b2dc17965so4736313f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763489511; x=1764094311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIeooBALJa+R8frS+RJBJVJ1nxCCz8GYTXb8+XSFj9M=;
        b=c7jnD6cTPdWPfANRV8E7CKk6GH34+ZrhjH0pQW+xh2L24GyHroulhgOfSKMfIeSz7R
         4c1f8IjtpFmXfZZSaOrDBVEtszC2hsY3I4CPJd1yBq1AeHbdTuZIgeSQzZFAY9+hBznO
         zTHvPr47QHb6J1zE3L84n+iRpxIxM2gpZVVEYfHcC/x5kJ1fsjcGoW9sHiX0lBZO4F+s
         r+6ksKpY0kZ8X7wGamuNr26Hsc2B12AtOlFXzW6cnsE472ceE3kbmhMtcFWedTOthlbP
         7c9nzzWC+6W+gpB6ZWRYGs/y2nu6GqbdZY+8iSCeDr+EryqkGX+fbf4hTOftdi+yv1GO
         jjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489511; x=1764094311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uIeooBALJa+R8frS+RJBJVJ1nxCCz8GYTXb8+XSFj9M=;
        b=LlT0xCLuvQU6k7lNNPb1k7RwTUTt7PYlEsA7Ommy3rFMvry3lUNw0ecUc15+1z84kt
         HYvrii/sAJE92phZI8mSw7u0nA8FWIkwS5sWzkhRx6Led7ly5ikMmFmx3LpnX6zDS+fi
         DpZebsm0cJ1Bnc+xxW/STf3jySGIMytiR36enC1gOhkKEgN0EOPjAWTMGqA3TOvdiEYe
         pkjqyR0/D04YpfHY4km4UkxVSprp6/G6sZCZ0MdhMYUGQ232Ti+DPvUT2Rnb3n5ZsbxX
         PVcpuPWmXoX0wOMiSxPWBIpw5GYs0553e4YoIUVKwiFcTTyvtVMOrQxlrCxgvJvNQ/60
         1dzA==
X-Gm-Message-State: AOJu0YxgEjY8E4BZWCs5kdfnt68CXeJe5TU5rsVZqu2V0Ce4e9aUe0JG
	cjcJrpDSMpqLaU+nSytTtRy7UJtquX3NmjyiqOKo7J4YakY8hMywXdIMjQs/0332PtRRz81+bT9
	oc+XmF953lPPxNuqhqx0bW6Dmabj/Qjo=
X-Gm-Gg: ASbGncsvZPmFzEFJU+93xbOYQKr4VxEy1Tte21tW1fENX5Vdx6WCkGfLLH8JCDYucZ5
	A1fPDJ3y2xlDodS+yGagBuZRLq/Rru0K5BAkK0c0dxAT/GjhrNZyUC/lppv+D0S37Jh9nbvWSHC
	vPSjwLViQWYiltMVJcnUT2UvGFQfz3n3DAUqwRQIAVjsQZBZZsQxFqXaP+26ihL/nplKYo+i6J3
	gszee5j72FHiYikJJWWscjH9ROaCm2jLsbdWIagf/3IyZzUM6XgPSdyK300qdyT+uqf5qAXb7Iw
	R90vGmw5PbUg50BhbDq/rGBmniSBqyBVbVWj/xY=
X-Google-Smtp-Source: AGHT+IGsDHRDLM0nPyeJMAXpSa5IvQJX2TDOcESl+hn/6O/V8urZzUJRUZrE+aKZMqgLEdTcqW+t1xYf+fcCPOA0nIM=
X-Received: by 2002:a05:6000:1ace:b0:429:d33e:def1 with SMTP id
 ffacd0b85a97d-42b59378443mr17396435f8f.29.1763489510570; Tue, 18 Nov 2025
 10:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
 <176305162259.3573217.16863263438601087321.stgit@ahduyck-xeon-server.home.arpa>
 <2e11014d-2782-4533-91a4-ff952077f042@redhat.com>
In-Reply-To: <2e11014d-2782-4533-91a4-ff952077f042@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 18 Nov 2025 10:11:14 -0800
X-Gm-Features: AWmQ_bm63s-bmSCPXnVjdzUZseu76MjZ4OlUg97sB-fcjlved9FYWVyQi-QCezU
Message-ID: <CAKgT0Ued4fG9_CEdjJRUnBgUaCxr39eJ16y1g+Pdmq+znQOVNA@mail.gmail.com>
Subject: Re: [net-next PATCH v4 07/10] fbnic: Add logic to track PMD state via
 MAC/PCS signals
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 3:07=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/13/25 5:33 PM, Alexander Duyck wrote:
> > +/**
> > + * fbnic_phylink_pmd_training_complete_notify - PMD training complete =
notifier
> > + * @netdev: Netdev struct phylink device attached to
> > + *
> > + * When the link first comes up the PMD will have a period of 2 to 3 s=
econds
> > + * where the link will flutter due to link training. To avoid spamming=
 the
> > + * kernel log with messages about this we add a delay of 4 seconds fro=
m the
> > + * time of the last PCS report of link so that we can guarantee we are=
 unlikely
> > + * to see any further link loss events due to link training.
> > + **/
> > +void fbnic_phylink_pmd_training_complete_notify(struct net_device *net=
dev)
> > +{
> > +     struct fbnic_net *fbn =3D netdev_priv(netdev);
> > +     struct fbnic_dev *fbd =3D fbn->fbd;
> > +
> > +     if (fbd->pmd_state !=3D FBNIC_PMD_TRAINING)
> > +             return;
> > +
> > +     if (!time_before(fbd->end_of_pmd_training, jiffies))
> > +             return;
> > +
> > +     fbd->pmd_state =3D FBNIC_PMD_SEND_DATA;
> > +
> > +     phylink_pcs_change(&fbn->phylink_pcs, false);
>
> AFAICS the above runs with no lock and can race with
> pcs_get_state()/fbnic_pmd_update_state(). Is there some logic safeguard
> logic I'm missing? Why 'pmd_state' does not need ONCE annotation?

We shouldn't need to worry about the pcs_get_state as the
phylink_pcs_change call will trigger a follow-on so if the link is up
it will be brought down in the next call. So the worst case scenario
is that it would appear as a link flap.

I will take a look at the pmd_state setup. I don't know if we need to
use the ONCE annotations, but I think we may be relying a bit on the
sanity of x86 ordering and may need to make a few tweaks.

