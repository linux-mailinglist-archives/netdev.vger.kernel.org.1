Return-Path: <netdev+bounces-256054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEHxOBRIgWkZFQMAu9opvQ
	(envelope-from <netdev+bounces-256054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:57:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D7FD32E6
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0FC3013788
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49661219A8E;
	Tue,  3 Feb 2026 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agj0LUKv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9BE1F75A6
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770080231; cv=pass; b=RIZP+6b11rqsHWHgPnUYIagzZUKAulsHJv0+3sKJPWX3JuXArqgwO2MArp1fDAMZSS0fLZaz2/yDMdGyXCyZ2CSejSJ520Yoj3fTLXOdfpJ5ggDj2tjsAxn8kvwo7bCzE0V2tzzFVr7Cf9kGCaPdsmDGvgN40Gb120lFdttz9Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770080231; c=relaxed/simple;
	bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaThbG/HCZeXTFG/xqE5+bJFLOWsB5aPNWDA3TBSjSgqxbPYnK4XwGZWBx64i9Bm1adRUSYMaPQOAh/VfJOjUE9aTrgSmt4w70alHHy1I+SwlchelGrqWd6fNRAuJfI2L+hWQSWDfcpy4bydsrQiZkk3EbXE4tP60RY2SwlyxVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agj0LUKv; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8947e6ffd30so60736276d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:57:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770080229; cv=none;
        d=google.com; s=arc-20240605;
        b=E9yoZYdp35h6zFHKL/N1JoGIe439/9jiWrGNmanPxVzLM4oiGuLB95zGPsIwM1e18w
         NkaD2/hvmBrObneus9HyZYVcI0PrqwG+02Qbb06WnRw6W4W+QNLBo3rYtvARUjoT/R4l
         /w0tKqqFAa61KMtUC4o3WbNVlNzOLZ39J07McPtXQnfBwQMZz5Ri3Qb1EnHpDEfYFLtI
         CmUCQvd1eNcEPwtgxT1WRENcEZO1xg+5iqoRWH6VDdrGLPe4Su+XtRANIFF0ShJtmGVV
         BG9yd01AUXARxdd+16ynHHuukWfuc0/C88vb1I9AhKM18mmCLfwcuyCMD57Nw8nvlqnp
         /X6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
        fh=y6LWFiVORlP+lzUcKcCftlCsuIQzxBo77dsk3Zu0X1U=;
        b=OQabP9ZSsvKBHq6sXxJaONV7r5hO4I4EwqjWcjcIWR2CW1TwPxvyBmW/mzBBcm8B2r
         aW40Q0fiSfMev15WJqnhX3aLFEzpMU45msVc28Rj8MBzKNqmUgtRUzk8bPdfunepoqLH
         x8TPJI4zD7uFx4xF13fv83FgZjvM/hUEX9aZIdEhhTFRP5pArDpelhCktTuruJu0icsB
         UmSEx0t41j9zTqgPcu0g7kehN7ATzHfYoRT9uwKQcnJQwPyCOoCTlJfrudtjZP2szuip
         qUqOrEefLtfFr7oGFQn+cZEuM3N3iMs9wHV6rdbFurZ7tQqwycNHFmHU13/xKSRTh4fH
         67Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770080229; x=1770685029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
        b=agj0LUKvCNI+z9z47/5kTXHAVgRBy4EBnVUo95soHvJsQMsvTgnU4DKES7IJqm3/sw
         7+U4fD1Npb3IgadzPdCy9mM99lWFUp2Z9WiNOLH3Bb5154PEM9VXvwYMKXVxSsZeWSwB
         zUHrTfFRC/Z97GFPkg5VOfb9msE+VA8Tj5g7baY7JbTO14FkSEiNFZrkdT9mDDB5kE2N
         AM6eQsrKif65TcKPq7/YbLfhjzp3IoqE780unlCpSj2kbxrfXSjBUvXDZwvEIt9FSDOF
         R1SrBVR+yp1iE/YCw3Xalw3EhAFWdXlwLvs45OG71tNHdy8c/BUR9b6oFpZxVCj9RhZj
         pn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770080229; x=1770685029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MIQJnudSfRFE6zm2uKPEiFYOziOVeqVdvnpLT6wcEJ8=;
        b=NDIcHjPNvOAwUS/WS1SzyAsXC7Tz8mQgLF9Feo6ARGXZNwGl5ryTwUbMIA1YTos14s
         tlIxlxOGN+zlschYTMSaMYFL+cM29QOFnxO+a+XpIqdGSiGkootaP/h4rayG71FCAPYU
         MaRBOmLBfQ94l8HmKU4nE4oan0Q0UuWIj82hQShXi5eukTYnCwCkrCgFx6ZmGQqoZ0Mg
         1MmS6GGuO5DuLswrSSpgUA9EFrwv9gSDJy8qpjzL1/oAEigdm3YUYXr5s/rVF/CCLNGA
         Fse8Y277umC9VtJiJifSjxZPoUH4yYpk+eOkAMwJRy8EcgTSM51R0h7J7ZmfltdENSEH
         T5tQ==
X-Gm-Message-State: AOJu0YwdtjrCk4wnZ1Coo/BKHwuVCXTGLzPlrDcADNUHdr16NkRpErMe
	fldOrZMZ5TCfsyKuJxzeE/vCIPaCfOaXkJkzqr3yGVONsMNk9i0NsSBdHi3E/W195eR6BfUQnWY
	Mamti1v/OIQs7+R93UDKCpkzgbT3H2SA=
X-Gm-Gg: AZuq6aI09+ApL5LtD6MZfW1bQC08QzqWUjbfDmVYUQ7ke+rJgWgJeb3ozvigv87UlgA
	zWP9D79MRjMx+m4t202tGnejZesmGZE9wth2TnrpbpgwUj8oYdVteUux8k2Ml+EEhP97Kkdp5oN
	kchGEzV85CZA471SbWRn1/mWguB4odIuOcy0DdEQQAZrJELJkws0EpNNqwuyH9ReqD7LGHmgwbX
	GWbjdcWtOoG/RKTt/NFIhtuwPHjMDcMW5XvOnJdcRWIWEb8jONZTmgmKGWqBdvp9fbxqZvydziB
	gC7YrVpPdiPo1fFBpXZLdMOccF9OIMti4wDgpcwWPjvqC3cUpUlY8757
X-Received: by 2002:a05:6214:2aaa:b0:894:7c5e:3368 with SMTP id
 6a1803df08f44-894e9fb767fmr188217846d6.4.1770080228677; Mon, 02 Feb 2026
 16:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131004327.18112-1-enelsonmoore@gmail.com>
 <66924451-2b19-4a3b-ba99-16437dc79011@lunn.ch> <CADkSEUjEYY=Wwyumv3Ft_T=xWLJY2hiy4uw_YMus=4o=61H+BQ@mail.gmail.com>
 <4b7b8238-3997-45d1-a8ee-b659afc0374c@lunn.ch>
In-Reply-To: <4b7b8238-3997-45d1-a8ee-b659afc0374c@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 2 Feb 2026 16:56:57 -0800
X-Gm-Features: AZwV_QibcfxGBlb6FY5bnd6CK6KIio3ZsP_VQLrtoKrlRtMkrnbOMvIqQ4x18WE
Message-ID: <CADkSEUjxL11fjj4tsxnF6FFtWDP0+Sru45H1sVyOYxPX_S5-3A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit functions
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wireless@vger.kernel.org, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ping-Ke Shih <pkshih@realtek.com>, =?UTF-8?Q?Thomas_M=C3=BChlbacher?= <tmuehlbacher@posteo.net>, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256054-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 88D7FD32E6
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 1:56=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> You need to be careful with commit messages. Reviewers read them, and
> think about the implications of what they say. As a result, you wasted
> some of my time looking for a driver which did not have an
> module_exit, and wondering if there was a legitimate reason for not
> having it, and had you just broken it....
Sorry about that. Should I send another version with a better commit
message or is this patch okay the way it is?

Ethan

