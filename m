Return-Path: <netdev+bounces-294981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OVigA+PBIGpy7gAAu9opvQ
	(envelope-from <netdev+bounces-294981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:08:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F11963BFE3
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:08:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=Q+p3H2Z7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294981-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294981-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49B653018AD0
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691CB1FF1B4;
	Thu,  4 Jun 2026 00:01:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B719184524
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 00:01:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531295; cv=none; b=cNpS0Sj9Snr7Ntz3fKVK5OkmHi04crSSExvRzMw/m6469lhjQn/LvcrWBhG9jkSjBPO9XZbcKS3ChPYhoETVlgFr5VuN0WCalEJyaFlohFTSlDiSCIEFCRKddGvRqGrR80gW7FKg1d2FsqtdAgPh8gL2AboHk6/8LtdPvlWZstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531295; c=relaxed/simple;
	bh=uQcJ3DbEdxsfH/k24j2l4FHVQEAFZdw9HA2H2VMaFx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aj9niFnsBQj5N/6yCySj4qcz9pF3gr8MjsKRiH2OugjrlF4Jw9dotVKTC6nqjPAqHArr7djtWsfhTqcHXcxFZqDzdOEQfQYDG2rM0n8zixtOAuBww9ikDPELRQn4SK7QSElhDPBm6zjaEPdLdkCjOFPpLiG+ILaKFIozfKDOuCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q+p3H2Z7; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-842288702fbso28416b3a.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 17:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780531293; x=1781136093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fmwtcO9oMtO4r20fiMVX6YvjF6Gi+HYM7qIN8rIiuJU=;
        b=Q+p3H2Z7ql3lAznVf4UaH2BG0/fD3s6GNPt8duObqYDXjaceJa7Qy3kJ8WXIYZIwsD
         wa3CNvfZ1Gn2/rVoOIN/7+AbCsEx6pIQ05AqDSzE4klHViu9OWbG1TWDElD1tpgUxrfH
         66dwMMPXazSLi57iXYm+aa/lc1pIArh9Gt4Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531293; x=1781136093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmwtcO9oMtO4r20fiMVX6YvjF6Gi+HYM7qIN8rIiuJU=;
        b=Ih+Hc1+kT4D87Iueik/TzJCtT96azIJTQDjtWai6TOwVW/MnJ8JxW4z0xkuNmvq4+/
         S4t68YWNXHzuEoool/G6SNc9SpWDhqWswMXKlXCPVtXs7pagA7dzRDbGPVuwK2E3bjhN
         HHprGhwsSKJRyMTLXo2Yt2//S+Dh/ovDSc77yPmkriu90/MelXxwMkild5pbsl6gHnof
         ue/FdUiZMxRBiIEJoMelEB1RimY6xQX0IT8qqG9IebaVHtjUEMPCHgUXOgM+PVfSCtPX
         f8EoqMHzfqEyWfF1c7XQ0K6VX9LDcLZQ6DkS3bNBqs9KGvAlf6+YvVjr98FsUfATcKe7
         VdKw==
X-Forwarded-Encrypted: i=1; AFNElJ+rTi7vgsDN2vVQby7/E8DvuYkUS5nDoKOqqi6VaCmIVwpqUmh+zoD54VcytpbEEvgvBaW1fR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkAfa86grMtRHfMJc0jpa4Tcsj1GRCgfixxKFRuegj8upNgZ1
	7THlDleEkOn/R54mOsM3rIZ8ZGRKr3Lq92KIJM7M2+pyjLgg/yn+AFPCNLDO0Kw89uVHKE4WFKb
	Mi7I336aqMQ==
X-Gm-Gg: Acq92OEd3jrVUF8LSQDLSnIMeA3PHFzwcVOkGc+ntHsnUWyNNalKNwPSKES4MLyotHm
	CoyfpCdcoBNhuEgjMY6LSvsifbvaIEgD0hXOtllM19fzviZoKoOaCRIocoJU4XsnpSZ7zPpBC2P
	DucioRzGRLdnAEeDokx4MvilEYqBzwTFb2kV41KfBGN0jqGupqYJgfmF0zaJgPfxbMmdNLaL/mr
	QFqSD/pnul+2kQuChy43eML+LaNVJqneJrg5J28k20/P0dkLbNdvPgxeMy9pMNQIjJ70Rqtt7Wy
	kGQVms/NGWGgGjCXk+uGNMhY/wwXnAtN/BBCcDcoeE1m8JSTW+9YfD8WeDDoBFzHFVfvROViT3p
	A3HvtBNV6AM3gva3fK7uVCt3ZsScUlS+zs2daWRJXIVTWOoI/EmPr1KhzsG9DvfcqT1JJFZ1kL2
	6sRynkNZ6jZ/3Yx9OT7TbA42UImkYfVflT0Da6NNAIhhIbxgH3dQo+6iKSLgNliNzMiVgH50IYW
	JhKt5WuIdU=
X-Received: by 2002:a05:6a00:846:b0:842:7992:bdc5 with SMTP id d2e1a72fcca58-84284f37744mr5430280b3a.41.1780531293343;
        Wed, 03 Jun 2026 17:01:33 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com. [209.85.216.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bd1sm4985571b3a.44.2026.06.03.17.01.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 17:01:31 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso41380a91.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 17:01:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+e6AvY9WDcAKV+v0d1nybtkewclJSz7wolW9hl6RnjfENb2RanHmy3lecTVHGiSUB6FDjOnTs=@vger.kernel.org
X-Received: by 2002:a17:90b:2811:b0:36d:5dbe:2a0d with SMTP id
 98e67ed59e1d1-36e30c23af4mr5607319a91.7.1780531290626; Wed, 03 Jun 2026
 17:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrU94ja56CA5CRtXrm1v_7gBaPUNOHKQzS=JNF9JZ7Fznw@mail.gmail.com>
 <20260603230122.851517-1-safinaskar@gmail.com>
In-Reply-To: <20260603230122.851517-1-safinaskar@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 17:01:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjARJSHGWvZKJysvZOVEVi7bNL5x9K2X7ifhfLA9YK2sQ@mail.gmail.com>
X-Gm-Features: AVHnY4J3E2GAiTMiUKCy1DVjF0CiXaoh4gFXUo3phzZ8FQ9ufT44d-VKtd1uRR8
Message-ID: <CAHk-=wjARJSHGWvZKJysvZOVEVi7bNL5x9K2X7ifhfLA9YK2sQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: luto@amacapital.net, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:luto@amacapital.net,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-294981-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F11963BFE3

On Wed, 3 Jun 2026 at 16:01, Askar Safin <safinaskar@gmail.com> wrote:
>
> So, if we remove tee(2), then we will probably need to remove all
> non-standard implementations of pipe_buf_operations.

I don't think tee matters.

Sure, it will share pages across pipes.

But if we make normal "splice to pipe" always copy from the page
cache, nobody cares.

You can corrupt the resulting pages as much as you want - through
multiple pipes if you use tee() to copy it - and it's all just
corrupting your private copy.

And yes, iSCSI and nvme might do their own splice-like thing, but
again, nobody really cares. When it's all kernel-internal, the attack
surface has gone away.

So that's why splice() (and vmsplice()) is special - not because it's
buggy, but because it's the user-facing attack surface to expose bugs
elsewhere.

             Linus

