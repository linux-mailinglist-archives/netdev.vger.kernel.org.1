Return-Path: <netdev+bounces-304595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2u9kMrHYR2r1gAAAu9opvQ
	(envelope-from <netdev+bounces-304595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 17:43:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16949703F8D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 17:43:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V843hRpe;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304595-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304595-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1592330237C7
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDC7417366;
	Fri,  3 Jul 2026 15:43:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761CA414DEC
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 15:43:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093410; cv=none; b=iQ1Gjlb5epILNXICoOJ6EWGtbBl7w8OLkC7d/ps2Eg1aEDkTX5VMKGYk8kUeP9A9BU6BlEBrC2T9qfPrDYs71pEezTmI6deoGY1aDxo49Q3OT75jtE73wqPWw4uE1TSwkEfz4kb5qFKdIhLedXMM8YY2dFvSNQ9oyCXD8MWrTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093410; c=relaxed/simple;
	bh=/aMtT2CgzoX7UI2jViPbwCEZh995kH6Bd0vInKP2ZLg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EV/HxjqBGXm5CtyDrtCHQYhp433Uo8N+cvkgb6nOuP96/76JceI0zkTvwbO5SbWID2Uoo5sOIN36nRhSqPf8Okm6FA778lNYbHGgrnEArgHzsjhOavod1jXwzq4sPHDk6iwKAIZcHFdmS92WF96OAYBrhgEB8g0qM+XzZMVr1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V843hRpe; arc=none smtp.client-ip=209.85.128.174
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80bb8287d99so7805957b3.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783093407; x=1783698207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aMtT2CgzoX7UI2jViPbwCEZh995kH6Bd0vInKP2ZLg=;
        b=V843hRpedUQzRMHE+ChxlEVQksb8qkgcSrBdJYy2FPXRlFU979ILjJLNUi6JgrLYVB
         a19hjhB4mOGB6wCxc8gwS3D9jM3M2f16D+su8TdL5L3tbQtZEVTeim0R0PuRwFy2/8QN
         yXkhl8ZhsbSL57KuIC0Zyau1wxC37wCMAs71XQcNeB5n2CIpXjlUBvi4JMgfP9Ly6kUm
         CT/q6oLzCtchD4PUG6puYFS3dpGswsj06YJ3bB2Og/nqvPEpbmqKoOfTxKncS5CXsxe9
         P3DTkCZyINJSWPJx/fyJdqXI3OXCDK7OXHd5nnY2FJtNMyHTazVXKg8Pzyo+ca4caa2m
         2TvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093407; x=1783698207;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/aMtT2CgzoX7UI2jViPbwCEZh995kH6Bd0vInKP2ZLg=;
        b=PG5Ecy/KCR1p+CEHJTgqPFN90ZMAGyF/Nu/7jU5I23yLivKeMr+VGTXyBrnE/JWx38
         m96J7DvDKWmwrz2Q9rgJIrcQ3Qm8aFVzIsm5uR5Da8kg7jXVQuwNZzhnVUD9Fpyu2YsE
         qooe/x52tiBAcwIU/W4PHIyowX0YnRuoLCQcK9BOVWAISNfMoMnVFBii69aHhgJVcKen
         HDOyomN0FAxxRXjbucJLidOUGE9/iWTeSgX5Sw37vp9kxxfA/c3TSo58WnoZBlNvpCX9
         hK7dVstZZkGtEQXrtTNYbKLHuWEfr8o4IKiiyTQB67OZ8DJF7Op1vD5dgDTrsm6XG2dC
         EZkg==
X-Forwarded-Encrypted: i=1; AHgh+RrJMly5eGv0c1fc4DuIdZxzmWGE0G2F87DfDumO1T5NzptKAIXeyWLGzbzZBTJDaLL6xIXY9CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJBTaDp7X+XVpNQM0ZTKkMHG3M0xTlkXO/vf0RHCgKzoeIeDWt
	pLRj6UjVSFqNOe1MBirC4Cc037C5Oz2yRAPE5UZC6OxDXa5yUJQyRQdKDPy0AQ==
X-Gm-Gg: AfdE7ckb2HM9nOYBR2uHaWnMQpz4EjdG3d4cCi3N4xBITatEAWsdQffehbZZZi4w0nS
	plp8zhH/FqKM3V501ibcq1r5Vfvmgu5Zxi7WPHx55qqw17YQpJqwKYm3SGH4uDJ3p06I1ObnOVc
	VTmxulHNreVkgfRTYA1QJ6rUkW+hsv57m931ybSstTk+aiHeK5liWhtnh2O2WMbdU47pCkpitpF
	KCep+AzmhNfqzHEr2ViuIIDPZpXMlS4cGQVYGJQrysE0dgYgQvhArswuCkty5Ldj+KHYs0/ToPV
	1lWd7qmWr6sPC3rkGkNYwWCmu/jCmDQ2NgU8ea3MPIhdG8i6D8uXwPVr3zA1JH0/z2cYQsSXgU5
	RCl393/TRHDqSTFxOx/zo1PPatLlGx9/zbDVeo4gdiG/EqDzllToy3b+157goCXF/moLzrUQq6Z
	+9jko3IJj+I9GCmdlXzc+h4uDd1mp1ePExIsGJldZSWz/+ik1rXQCmcJnku3ox8vfH3w==
X-Received: by 2002:a05:690c:6712:b0:80d:7292:6142 with SMTP id 00721157ae682-8171ecd4c7fmr2645837b3.27.1783093407202;
        Fri, 03 Jul 2026 08:43:27 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b049939sm25358117b3.32.2026.07.03.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:43:26 -0700 (PDT)
Date: Fri, 03 Jul 2026 11:43:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com
Message-ID: <willemdebruijn.kernel.1376ffaa117c4@gmail.com>
In-Reply-To: <CAAVpQUC1UKqqUdQaP+ud_uGkhByxooMvCs1H7i7q=OzQFP7trA@mail.gmail.com>
References: <20260701125112.3652880-1-edumazet@google.com>
 <CAAVpQUC1UKqqUdQaP+ud_uGkhByxooMvCs1H7i7q=OzQFP7trA@mail.gmail.com>
Subject: Re: [PATCH net-next] tun: no longer rely on RTNL in tun_fill_info()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-304595-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16949703F8D

Kuniyuki Iwashima wrote:
> On Wed, Jul 1, 2026 at 5:51=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > Update tun_fill_info() to read device configuration fields (flags, ow=
ner,
> > group, numqueues, numdisabled) locklessly using READ_ONCE().
> >
> > Annotate all writes to these fields in the control paths with WRITE_O=
NCE()
> > to prevent data races, as these fields can be modified concurrently v=
ia
> > ioctls (TUNSETPERSIST, TUNSETOWNER, TUNSETGROUP, TUNSETIFF) or queue
> > attaching/detaching.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> =

> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

