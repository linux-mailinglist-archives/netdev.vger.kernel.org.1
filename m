Return-Path: <netdev+bounces-301667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +RjLJbrkO2rWewgAu9opvQ
	(envelope-from <netdev+bounces-301667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:07:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B71F6BEF30
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:07:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="bOD/uamh";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301667-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301667-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27D5E3071D93
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B953BBA09;
	Wed, 24 Jun 2026 14:03:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCC3BADAA
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:03:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309790; cv=pass; b=bmnFTVjR7Q/d/l9yjFd1yp/ySGt4wrO5/jkgBDqR1/k47JWksk1xs1SOv2kyyXridTT7afxEpZYp+Ge1D1bf+7ZZBZiiLhjczmkcFvwKs8GioIvI82Urzv7H1psHjwFth6LBNAKUwm8YCpEW1apX/KN3v/7YhsDI+fPewJiyEIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309790; c=relaxed/simple;
	bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNEskCTdSN6BFzS6D9m7ehguj8CcMRMMWYP+yMwpQl9r+UIbWppMyRnOC/lRJW8DyIMu1GjrhElOyll1eOv0u3xWbOSk27Lu6e8cPQucsJKRt8KXHFryMpZkiMPtioXuoRWVatgb+PP7Q+6XrL69Vz/+ENZbdZAzb8wgMw4m0DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOD/uamh; arc=pass smtp.client-ip=74.125.82.174
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30bb87c90deso164474eec.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 07:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782309788; cv=none;
        d=google.com; s=arc-20240605;
        b=ftWZBU+rWtCkYh32krgyyHd+Ck1ABFGdwmKzfVHjaNVKdES5S9bbPk9xP/uB6ldXMo
         sOe0BIzwSbxph7eXxtgMfmONvn6G5d0gWAtzyVitcTDNhkW+XI9iOemHCx8BEPvDO7tW
         ox9gpp4FRE2rvi08Ulo61f9UkJb3HReu2g1bpgalyan+IiLVeOwxYvll+CUCFI9hjuAl
         wlJbypHQAN+32r46GHoLgrcZhsjpHNDAZyPZwNNwX7tZ6d1FE7kp6blCvwdg+p827/Rd
         3XPoeQano2Jxq1724s70wDfcch3FGmYDSNMydbsLV1rqNEpc0OIulHbWJNSnGsytJ8nC
         zQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        fh=sRYdzMrmlwLkEtIYG6vRc3+Y9nXDGq6XGhAU6h0O5AE=;
        b=LUNc/4tlqjv3Lbr5/89UnppUbbWK7c6BgtreqbyqTwHoZ8Ytcj7UpEQoyNwBtiWDwp
         7YMCvLsfHrPFW/BVb+C2zsQHeh7StSa0O0xJ7Pzmo1KdDy3iPScRY5pgBGPL1Lg5Dce7
         XqzAna+GmQvSdgU2wRhJfGk65I312pqJaEIR061R1ug93U6KTMfYbf5krn+lgpsCB+G2
         nRiOXd3zUIsMzVMKLPUdF9CE//tub9XxnXPwmcuupaDZUf89Oy6e2x+P9Vt7Vz+1eoDX
         qOwvEo4dKeBjK9a8K3+RTTzuc9vITCHab0/bALpVpTGmGdqq254ljxBFMu/eopaU1uRV
         BgKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309788; x=1782914588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        b=bOD/uamhEpcZJyswv53R84IDRMeI6M5+ChYBgjLyvLfT1fQ65r7lzzwQ1gmCC+wuEn
         2vpGRI+m5uC/gsBm7DblfDULWdfIY9ZSe05VXEG08w57lGrNtLwN60ZcYfsqhVWvylng
         bWEK2eVdZJ0Tmb5pCGX3UXUiIh3E+i6++a9NhVOOHmx/n5nJ0rOXw2ASWQ9fgoOTVTCB
         3/28G0P4l5fMK7R9as4EUjduvq28vuDMkk4OmSZZcOF7jdfBx/hM62MM+5WWYAjBBcyO
         /vcLrSxb4845JDcnkXx9wDzYjuWeHm0U98NS/Wqidu+uHZFS1rgP3ozC2XHYFw/vXnIx
         udvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309788; x=1782914588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        b=qRMie0FAi19T98gUkqawpzaNenPS55OwThTYsVTcg124GGWHuwFNRb69YYyQoE8uBw
         dIlIUdAFH+JPOyicJOn+ARhRurSbQJFmpxwbgV0zpIjG5tsWOGhtVNZI817Zwg5hNmCW
         xr1CE+lc9j5zczTpzf3cSXjiy1JuRlDvEDkccKvdexfOfuhmg/aCH5p+PJLyCeQE10Na
         nyNNLZ4cn+TyE+/Qd6tsiXBnJ/g8lyxHBauKP1tGSoFPg+Xf70uLznl54uJZESXU3q49
         4A47xzBRFF3yvZbxMeJGCyMBUujk/vRzKs0cyV63XjIp3ETgDghxIiNfQ7Ln1uvQpG0A
         KybQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIXDmE8MWS/NmspjpPRR/9X/OkiXbbTK8UOME8deYdDkjCGUilRK1QlXTBNcE4SmQsWjY/4OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQdpe3Dap4yavQ86q22zdPmUnRvi7tgm41v81plbDXZxoWAmI
	vj/q67E+S2RXz4W46vrLP6Gk+0yWnNdj5YgRqSPbqSpibkhTWnO87vLbJjklcFfKt5DTvCvbgV5
	4B+MdRPtBJqtfmv+VX3tQlh1RaPADuQw=
X-Gm-Gg: AfdE7cnD8szIt726w/YPFHXqP+LBRJB1/SA4fRbztp9hD+zQKU3iTve3SSW4c8Z54I7
	5uFnCnxpj+BO1kt2WQeodsZZbaLgCMknNTWPkno4e207cIKZ0h3h+csz4notvOE958Yt0A3eHUp
	z0cz5N1t9+yewarJSZjpKcVibt9ii/vEARVgN0GBtq2frNWiYO7eqVM7dxhqGet8E41cz9lGFsn
	GNx/WViDBMcpTHASxSGQ41SQQp0FiuvgX0T7/tBkz1BdB1ypvuKgShWWvMiwBDTpzBl+3AEMBA9
	8/+9eBdqEl3a4TGeAOSeRU7+Bfqd90ABPXUUVvRVkNK4tRXo1vCxZCLz+TffD0R3aFBPU0pTV07
	H4Ucj7yd2lnYi
X-Received: by 2002:a05:7301:658a:b0:30b:c8bb:588f with SMTP id
 5a478bee46e88-30c5240f7damr3538472eec.5.1782309787929; Wed, 24 Jun 2026
 07:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev> <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
In-Reply-To: <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 24 Jun 2026 16:02:53 +0200
X-Gm-Features: AVVi8CdZJD474qdF4GDgFLlfJ_vD8WsFaomaTI3YSRH6pluhcoRUR51gh_iz4VE
Message-ID: <CANiq72m_LakPxHt99+3eBn2rXokr3vZbdJf=Wk-Yi8_ufQ2mvA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Fix missing fops.owner in Rust DRM/misc abstractions
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:petr.pavlu@suse.com,m:alvin.sun@linux.dev,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:leon@kernel.org,m:igor.korotin@linux.dev,m:fujita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:linux-kselftest@vger.k
 ernel.org,m:kunit-dev@googlegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301667-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,davidgow.net,debian.org,kernel.dk,intel.com,android.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,googlegroups.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B71F6BEF30

On Wed, Jun 24, 2026 at 3:23=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> I would only suggest adding the new file rust/kernel/module.rs in
> patch #1 under the MODULE SUPPORT support entry in the MAINTAINERS file,
> similarly to the other module-related Rust code, so that the module
> maintainers are emailed when changes to this file are proposed. I think
> you can change the existing 'F: rust/kernel/module_param.rs' to
> 'F: rust/kernel/module*.rs'.

That would be great, yes -- thanks!

Cheers,
Miguel

