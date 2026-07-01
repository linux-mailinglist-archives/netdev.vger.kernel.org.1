Return-Path: <netdev+bounces-303802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qh2zMwpoRWrY/QoAu9opvQ
	(envelope-from <netdev+bounces-303802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:18:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2441F6F0CA9
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:18:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ml0ih55n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303802-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303802-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E17643043D36
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13139525E;
	Wed,  1 Jul 2026 19:17:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF26396B73
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 19:17:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933430; cv=pass; b=Y/d55WeeGo7mXdZZ1fksDD+cq8w6bOrb7oJHS/JgwOd9PuBX3cCyONzj7q08t0JiJ4k0+IZwRR46eastAo86k1sfg/20RjEKzJYmLOwsfP+sChYs4gpECsGYUYSp4CDYphWp9jzzZ0RLnnZ4SKuv1rEmw2vxrgzr52ZxEyLEtvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933430; c=relaxed/simple;
	bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0l88xdFPocaIlnGRFQUFyPfACkgaLb2ZYzayMqaTHFE6Ff8V8kIOu/f4AyzyRjDZQP59Rnx2HlgvNbmQMnQC70JsKIGN8NAqBhZDSH6H+nZHav5rXOPtLEPGCJ+gy12y9HT4/eh5F85a24CxTbHbLcJrNzRfPNInLUPS22kHNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml0ih55n; arc=pass smtp.client-ip=209.85.160.41
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44aeefa1c00so752563fac.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 12:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782933428; cv=none;
        d=google.com; s=arc-20260327;
        b=iJewAai8rDEgaLjd2y+iisp1yGbphNHfY+MHYWmfBaHvxGD7g+DAvcmxCp6OcaYa6p
         6PQsn3A8tWsSTjqwbW1c9dbz1ajHXxQq0OrwG8vH6zIDKj5BroTwFIrFd9n2YboLyfQr
         dln7ZkLtgcOeHx68+Xku8jYW4bFtkwdonLCVfFNchEnUHvrWdErK1TrDDTKkbf3BoRYT
         tbvkgXBD7mPMcx7jeQab5V/SLqxXBRMv1mod8qBEA1NgwZkioZqh2g2wJxTpf0WxZWGC
         ppKqGbefzl7my+08PsYzbdAcz+whsmFaleVgIVgHxOwpCwCHO3A848oCueGzPYe7mt4Z
         92sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
        fh=uYtpqRYLCe48KqyNoiKUDB3+R6CW0CD+3osqdOwekgc=;
        b=PsaP0LnBd+ITcWHe6QlOr1ysnpELvVaLb2yaUAiWYJVR81BPjJwbPlbMVa9NkgAMVM
         40fZdaAvK1xhMYiIqlaNJP6mN0JYvnIN9ptSiwJGQboZ2TziJAK9dBrZihMDH37f7KbH
         5omYeWmEXA3J2aIt7VIDzocqjFslwMWb2F1Nu+AJ3SHu4/NnKe3y1xY2Klt8UC/p6MCx
         DbtIs7rosnnpAha45/D8/CTWwVKWMJd4xSJss61LMdztHFZijJx8vx4OShXfHYYl4vIj
         Vf6Xsi9dX89gulUEuUk8FX/IOADVu1w3KDPBbRGi1Db7rBmUmpuvoxGLFWyEflP1WyeJ
         n9/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782933428; x=1783538228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
        b=ml0ih55nsFzrKA+0lWHweYf0yqKIE40M0dLzZRhgy0Kagi1TSlkeTyLxkLZiymLcPM
         riMpj/bwV8kBuLKI0CQGgJjlIqmu1KmFxFS1AuqH00kQfaVuUTMUUJNhvTtj/QtfBqQn
         e7L/KLLhD+kOhoZkDFhmUXkYuHK+zMJQurdgZUBO42jwOb5AnA4a0Gau2bLvu7dB64rS
         2CHP8ycB5ebKneaFg4zfN0KiYx5pvZXjDqw8pdzja1zAw4v6UPiuFcbcygN7jsRdR2JE
         0P01vu7eVa5OtiHuVFLeVKP/OfK9H1BGUmoZuyXQTPUvpbpT5j5Ve1lUvYGH1XtyiC0t
         svTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933428; x=1783538228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+NletA3FmRDG/GD5IvXS5VhekYurTM15nt1C3iy2LU=;
        b=Y6jIpAnROANfcn0HbEpK65n6YF3I8Sntii6yMp/z9QcnC4kQwi+E3IoJ/2ORh5a/xY
         Jf035GPzFJ/r5cfyVp1Gt6TdpEiek0EXKF90qK9NztHeyaOG9COL3YKzVz+8hR7CYTXZ
         Z0n6Mn/pgsfgZBFr5akmj+v8WzpS4PHQM9LHedJyIu2JYXNJSHhsa44PiZOEi9OmdNH8
         A1yY9zXroFiWY1JrZcXCT0/Mvoc0BP7h/XtxzOMNlQTEIR72XIagpxc9LkadwWpC9Gas
         GOL8vZtmV/iNwNRQ1vajEL1wTj76nbNuB4Zmbwoe8U953WpWzfDJgWjteZEgLsR75qFx
         lWCw==
X-Forwarded-Encrypted: i=1; AHgh+RoR74guChga9yJsIucEbGKjqj+qXFMATohuqSt6Z0eZapb3pKMV30iCDkM5xn3chMJ1b+SgO5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8lJQ/n8j0jdl5MSofoK8zZ2mPX+/5M95DGN73ehkCkQR/63H
	Z4HfuaDa2XSX1b9y62CM1EcUrMeh/7gkk0btqyVkrWwpOa6VNEVC9pU4kTF3WbXOksF8XPg29yr
	AyYt+Euv4UYQjcm2cFkU2g/ANicg0qhQ=
X-Gm-Gg: AfdE7cnDt4Xjp4BRYjkAwgrXqAt4Cw6B6Xc1zfuAQ6+nhFlSvK8UCJOcUiU6XUBS4FU
	YTEKhgjivmpglC0coOT0fHZq/BTtFM3CYV+CrHg4jgO6Ir/Nrui8hgbxQ0kYjSfD0yFPR1bVcRi
	CJuMxG6AZblG4F/2C06gqliOfmL0eI33hySKZQxhAWzLnqVRr592M+w2p1lFoLXEMLHGnimHtI4
	IvGpiyHGpJi1xcWfxxn1IaQtVwhyK6+Bx1kY2Aroe2iEYpE3hv98A9u/ZAaIBBM+3uZlJ8=
X-Received: by 2002:a05:6871:c8c7:b0:439:ecb3:52bb with SMTP id
 586e51a60fabf-44ae2b77260mr4418100fac.2.1782933428320; Wed, 01 Jul 2026
 12:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89ea76b3-e956-4232-8180-ee3929adf905@kernel.org>
 <20260625101132.3859505-1-safinaskar@gmail.com> <63f7860c-4f5c-4682-8914-27978b9fbfe1@kernel.org>
 <20260629-bauland-knabbern-abgeladen-c0acbfa62cc2@brauner> <CAPnZJGAJROqfCWSeeBu31HsE6nmgxVqHTNeC554S5y1Y-VN19w@mail.gmail.com>
In-Reply-To: <CAPnZJGAJROqfCWSeeBu31HsE6nmgxVqHTNeC554S5y1Y-VN19w@mail.gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 1 Jul 2026 12:16:55 -0700
X-Gm-Features: AVVi8Cfr-c-MwbiVa4Na7Gy64V9E0QAPHBSr0wHsSXCEVpPyigPKnVtNTDOprcQ
Message-ID: <CANaxB-wewdUnxApVU3yn7hqbztNJFQfN6Y8r_XZk-TZRXpOQ=w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vmsplice: fix some problems in my previous
 vmsplice patchset
To: Askar Safin <safinaskar@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org, 
	axboe@kernel.dk, collin.funk1@gmail.com, david.laight.linux@gmail.com, 
	dhowells@redhat.com, fuse-devel@lists.linux.dev, hch@infradead.org, 
	jack@suse.cz, joannelkoong@gmail.com, kernel@infinite-source.de, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@amacapital.net, 
	metze@samba.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, torvalds@linux-foundation.org, 
	val@packett.cool, viro@zeniv.linux.org.uk, w@1wt.eu, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:brauner@kernel.org,m:david@kernel.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:kernel@infinite-source.de,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:luto@amacapital.net,m:metze@samba.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:w@1wt.eu,m:willy@infradead.org,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[avagin@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303802-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,kernel.dk,gmail.com,redhat.com,lists.linux.dev,infradead.org,suse.cz,infinite-source.de,vger.kernel.org,kvack.org,amacapital.net,samba.org,szeredi.hu,suse.de,packett.cool,zeniv.linux.org.uk,1wt.eu];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2441F6F0CA9

On Tue, Jun 30, 2026 at 9:01=E2=80=AFPM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> On Mon, Jun 29, 2026 at 11:56=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > The amount of regression reports that we got in short succession doesn'=
t
> > make it likely that we can merge a plain degradation.
>
> Let me repeat: this v2 patchset fixes all regressions found so far,
> except for major CRIU performance regression

Askar,

As previously mentioned, this isn't just a major performance issue for
CRIU; it completely breaks the current pre-dump implementation.

The other proposed fixes look like workarounds that target specific
projects. Since few projects run tests on linux-next kernels, we should
expect more projects to be affected by these changes.

Thanks,
Andrei

