Return-Path: <netdev+bounces-299456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tY/gABv7L2qLLAUAu9opvQ
	(envelope-from <netdev+bounces-299456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:16:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B66869C6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:16:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sz7vrXoM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299456-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299456-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D078304B699
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BAB3F39E8;
	Mon, 15 Jun 2026 13:12:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514693F1ADE
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:12:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529125; cv=pass; b=AhtXPCCDG2/2s0d/7Fu68WTou4gd0VxRq7ak+45fvF/6XhZk1KywlJdyJX4OpSIDyn7JQ/WMdNiPDOQUu1Qcu/Ym41QbwK8cQjCubzkaUZKBRo6/5X+9m5Ss8xJS3yCQWivdQEQIFGVlzPmd13O2Rxe+a11Up2d7wiPkduKgWqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529125; c=relaxed/simple;
	bh=kKNBiJvc+rzdgShKrG5gbJxYUuppXn+sgk4q2LkXCxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tr63AfuOtkGZ+c4vejZk2PPgCDkYxSYFKcPJGtrSNK1xnnhiwJBmX7wFDlH8I/+fEOdFbAdp7LLUXbs0maKwm6WNG2snXuiErfH2p6nL5rzQaxIHivS47NogJaPAOG/c78ZxSJNMNzhz84faCnFnzottXTifRMavBIwrWRGnYXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sz7vrXoM; arc=pass smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so2072693f8f.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 06:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781529122; cv=none;
        d=google.com; s=arc-20240605;
        b=GlTQi+BBMEl4mLdviz4rL+3Gl3jywUeMVi1UxzA/JpeUa7xOjrE09D1Xf8VRc/Fg9+
         kcm1ksU1SVcgxSllfTXVBmWyTqf+P34zXvFECccK3gpisZGgigiJ/MSUpNhbP5FXpm/2
         kMnUCZqje1QrfhXbIMERNyEcde+tk6S5EgxL1owWlCNdrlBMllwX3NjgPsBZM3IvhLz/
         MxsHcgPXg7bbw+skaCnl9a3NJy7WhE2cnWtnoP45DmtQzccn/2th2XZBXt2ZECMKlhZR
         KdRUUWiSul7LPtDXXRQTkc16zru9JqC/eLe7dWoFw0V0af+SUzco4NyfBL6U5wdxq+lS
         xYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kKNBiJvc+rzdgShKrG5gbJxYUuppXn+sgk4q2LkXCxM=;
        fh=LtpppKIXJT+/B+myaaaJl9QGPvXbF57eRXyZ4Xyzf/4=;
        b=PgRZjvLQWpIB8K/7K8BvPFLkw/WeDY6RWI8IIBAN+Sh9WFC+Awgb37QXNJobcRvi2o
         /pSayahqmdAVniaanaeqZeBEFK9VRonJQRl8k33l3ew1qe65xKtrlT2wKFWpAQ6+ut1V
         /ay2iLQ75MD2muacUlXJP5eDWJT6JWfoR92EtG3lg5bZvxZYwiChManttu2V0yotcRDD
         IwcGc0+h9psPkJv4h2XW6LYig/PekO9k5J8I0yd2CJyq7S2JeaJcYonQpEki8Mvz47Ue
         zW561F3E73/GBcPWFsEzWO9FLLMTDvgv74TZvazz9Rf2AGLkygvKD2p9Icn0DPOgk0R7
         2cCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781529122; x=1782133922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKNBiJvc+rzdgShKrG5gbJxYUuppXn+sgk4q2LkXCxM=;
        b=sz7vrXoMLJUVlNRSXSM5ZMY1x+lAyOw0C4S0ArHAjkZeisG1XAu4oge6AOUE3MW7an
         nrDGMam1wYXfT7xWJbPnKhYlpg1DqWSsnoAsnTBKI3xlGTnxEtlK1nrEvnXRnbAQG8NJ
         glW16EyHYJMxJcF3QBUSUiQ32cUZBGbjjl2upQYS2f/p/rVhkvLgEZ3couZ2eNcDT2Ma
         fAKdOh4tvQ+zuQEDVbmtVDEetR2UldwO3KsEwR44uh+3WLPHkYh/B30ZsdeWOd7raFew
         3PgGp97uWXPpuG6s6Xf7HjkVLAMldhduYLDgjreZgV+vEZpiJpHTXH+64KE+kYnp5Jf7
         jqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781529122; x=1782133922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kKNBiJvc+rzdgShKrG5gbJxYUuppXn+sgk4q2LkXCxM=;
        b=lv8S8gehnzenOJbyG0yHk4CVlYdOqIokaYz4XuNNKoitgMF8FT/qL6CIFlfcPlaNUo
         D/jngdbt8wePlqQ3NmGe2Gq/IOV3QuD4QxFk4HAyTEC0vj6pBCHsa2WCtKOUanjR2GFq
         PIVFTIaJ/33pt5ohkSNwPFyyKZQlxehni7iLTZarAljxPgEOLg9LNnkSoB8ycUWOBSH5
         oEv8RpEsVwr2frMeXEwR3aJ441rk7D1CY2OUuXBdtA33LMa3RPI50eeLwSpyeqHo0d0+
         g8AptWbFtJA7NAEpJdMynrkq3f8vZXqO7OUZZe6bE3LsG5dH4eg0mpVaQcZmy3uGo8Pg
         BStg==
X-Forwarded-Encrypted: i=1; AFNElJ/QafGm5vsB9LfY1Br4WLdCRrAV2MTtX7RXcJCN2rTju34I8ma40HWgWUcM05TDD8LOdqLCTS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNsjGNo1xoYBixXe4zh71nEThe8cKYRI3VoRGxoYpMkOUf1XJ
	dHI268xTlURsdQIzfHW+uBfx98N3WGiBCXjf64j/3MuVcmt4/W3TiLqPsq8vKZgohchltPfrhyo
	Zi8nD1BGIn+GHpLfFq3FtXC3AIwhkGP8=
X-Gm-Gg: Acq92OGdZyns8glzC9JvtLNBW0r2s5CvMglagnRkVsyCHk2tV7cGHHvEX2z1iy3dttj
	nIos2nWly/EpurfybWTXJho0m/yPXT+46aXnq58rMJm+Ac1s6AuJd98knCGZemItL7Rz/G9QR1m
	ElNRvgen8UNXbkiJrCo8JoHwdrAJgZwHa5sQ3a/0TA2Q9KjakJ7Ui6GLFYYBqxh1s+sx20P9ue+
	FY7UDiH7GV6JRRaT2rXGuOIAo2nfYfgV70+xMCBI2ip19lcgxmAapBK6QGK6qWgBp29yoNUPIjg
	xvm2cA99ePCRtMpEDOieMyhR9bQTcafM6mku8r92sQXN1M/3bkM4jQz/7DmztB694Aw=
X-Received: by 2002:a05:6000:1842:b0:45e:eec6:500c with SMTP id
 ffacd0b85a97d-46074b8a1a8mr14546144f8f.39.1781529122279; Mon, 15 Jun 2026
 06:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
In-Reply-To: <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 15 Jun 2026 09:11:49 -0400
X-Gm-Features: AVVi8CeKgoUdgzfGyE3gGhvo39veJuptxa85IFXCJ5UZu0W-8unFPPqkk0CT60c
Message-ID: <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Val Packett <val@packett.cool>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, fuse-devel <fuse-devel@lists.linux.dev>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299456-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:safinaskar@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:jack@suse.cz,m:rostedt@goodmis.org,m:fuse-devel@lists.linux.dev,m:bernd@bsbernd.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[joannelkoong@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,linux-foundation.org,kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,suse.de,szeredi.hu,lists.linux.dev,suse.cz,goodmis.org,bsbernd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,packett.cool:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 525B66869C6

On Mon, Jun 15, 2026 at 2:25=E2=80=AFAM Val Packett <val@packett.cool> wrot=
e:
>
> Hi,
>
> On 6/1/26 2:33 PM, Al Viro wrote:
> > On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
> >
> >> TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
> >> a big simplification.
> > FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> > Communications between the kernel and fuse server at least used to
> > seriously want that, so that would be one place to look for unhappy
> > userland...
>
> speaking of fuse_dev_splice=E2=80=A6=E2=80=A6_write actually, this series=
 has broken
> xdg-document-portal!
>
> https://github.com/flatpak/xdg-desktop-portal/issues/2026
>
> Specifically what happens is that the EINVAL is returned due to oh.len
> !=3D nbytes:
>
> fuse_dev_do_write: oh.len 16400 !=3D nbytes 15526
>
> (where 16400 =3D=3D 16384 (read len) + 16, 15526 =3D=3D 15510 (file len) =
+ 16)
>
> After reverting the series, there is no error because oh.len
> becomes 15526 too.

I think this is because of how libfuse handles eof / short reads. When
it detects a short read, it fixes up the header length after the
header was already vmspliced to the pipe because it assumes vmsplice
mapped the header's page into the pipe by reference. It assumes that
modifying the header length in place gets then reflected in what the
pipe later splices out.

The logic for this happens in fuse_send_data_iov() [1]:
a) sets out->len =3D headerlen (16) + len (16384) =3D 16400 in the
stack-allocated fuse_out_header
b) vmsplices the header to the pipe
c) splices the backing file to the pipe. if this hits EOF, it'll get
back 15510 instead of 16384
d) detects the short read [2], fixes up the stack out->len =3D 16 + 15510 =
=3D 15526
e) splices the pipe to /dev/fuse

After this patch, step b) is a straight copy which means step d)'s
fixup doesn't modify what's in the pipe. This could be fixed up in
libfuse to not depend on modify-after-vmsplice, but I don't think this
helps for applications using already-released libfuse versions. I
think this patch needs to be reverted.

Thanks,
Joanne

[1] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#L846
[2] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#L956

>
>
> Thanks,
> ~val
>

