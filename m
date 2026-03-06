Return-Path: <netdev+bounces-264910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHFUEhA7q2mAbQEAu9opvQ
	(envelope-from <netdev+bounces-264910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 21:37:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D908922790D
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 21:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15A5C302C721
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 20:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CA747ECFA;
	Fri,  6 Mar 2026 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngzr2Eyz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8847DF8B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772829448; cv=none; b=HQ4FVwxS9tXyOuaJABUR0eyKBuqrz5l4p9Cvx8eeRAmnWPKR5haF20WgXVtLW+K2ejGhJxNu32v9MLWGU1432ZAEGkBf/3891T2f8sxastJb5Jro1om1RvtVUvbpJ5ppfGvrSJEFhcI65BolLqbmRTxhIQ+xmiDAq2mi/BzTPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772829448; c=relaxed/simple;
	bh=8IP266OrpRGoB9qgnxdq67NDrPYQDlKhU4OIG9LteCU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tPeQoHYDvGEYHxhhsBa7laMAN7kF8e93/F4ohl84SrEFSdhvXhSWUr0XnVnPk5y0c2bTrgfZWpPr2ZUOXywa98aem32PFURK5LxTKXWS9waIH4zxjQF917VuAwTLmbYTDrC9eyt1i6gYr4EkX9LPOj7/wvn+ltUmvB1+79NStM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngzr2Eyz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7982c3b7dfcso98968447b3.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 12:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772829444; x=1773434244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IP266OrpRGoB9qgnxdq67NDrPYQDlKhU4OIG9LteCU=;
        b=ngzr2EyzB6iFWo6LSx6744C+ykZwA0EoW//RrgcnfGZwxxx6kAoRYTKxILdLaWqIY/
         sij0F98+16T3wYa45OJbUWllZt/8zp5lfRDA0mfVVHDbXYkjHCJQJDaLflB6dzpAJe6I
         m6uUPT3ORaQa/v44KaDJ4lolazve8d6DNdG3cGhlF9vLQ7I2SC4fDRlh8BTjMuZ1KYQw
         8gixCSJwizG+6SbrOTzyX/l1Q2Hz8C63U4fbgn5bMeL4OMOxNXBo0cPhheOdDEJT7E4U
         gyoeFyjAtaP6HWsC3x4e+tOV8rE95R2KEtnMB9mD0RyLglPL+52UOhsItLATNd0L0NSe
         boXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772829444; x=1773434244;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IP266OrpRGoB9qgnxdq67NDrPYQDlKhU4OIG9LteCU=;
        b=WJEZfw7oot8UH2yrwz9EF4cSE7y5bW0RprmNs4m+ZYgfZe/5WkQzWuDo7GgmRS6BeQ
         JutErvSrXc04DXJQZNHnPrJywEm7ysq2PdEFQyKfWRnRLDkFG7uSUV8QYUGj9NCcMqij
         G18fz/8dlYYvTyMT6gssnrlf7S9jU+F0I9EoMjTrjQno6o0YfLuIo+Uze6xn9Akp+UJO
         rUfCHuRVfUXmzQO3H3+KReV2L7+Vzr7tlJwPRZ4N+ZFZr80CiLYl1KOrKUTwOo5v/3DW
         mdUWtdx1feve/toxOb4jPb34RLz4m4RpXO8AWMPfKUChMVR+/gUJnyuANjIFjeiXvr9K
         b2EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlEWii63JPbKsM5f6U0dsZ2nG1kRp5ZE6LMXmT4mocmlE310Ltstk9MFRCtKKkkbD10bE6bfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNUKMnj1hKSKTNFctPb4zrHTljSRWuc4f+QqCZ0gALGL0+mn5
	vy09ArlfkoCEK8oxhSyyzw+ACE/80/B68I8yGIUL2A/nVUU0v67nI8om
X-Gm-Gg: ATEYQzxlrxeX/qodxSFriAa3E/0XieoITUzkFTN2yKRSveH5atwlm2ZqYQaS7C4aZsG
	r9bxE4Dfj8wf22V51JX4CGB1X/78dIzKpdZKHgeCdlNJ9lRjIo6DiRpz4xe/mwn6FyLBuLYRmU6
	Dh45Y+1i5EHtvisRMm4S7R10IfjdIVBvD5UrBrHhPYdm5h4N7J9BGu4pyTyolQUbnqc8YBURWO2
	jGl2kZw7tv3ej1v5bRVjnWYjURYz2/w2AEEk63T89fP0sc63ZSCKfx0VSx8vf12NI3BRLgWx2tV
	ENQO8a5zCI7Ktzc2MxLXJAVcPwqnthoKhmTsOcIMBdHzwUvc61wmrsZLsa5H9J+S/nlPN1QeshY
	PZJzkp3uSnUQuwgRpQenUjPHwdCGSIyF62wnRs7vKB75feuhH8bu6/CHvpmewiGhq2jHM5hnMQS
	86JkxZNEbeOBT46g+T44fvgWjRPhwqP2GQLSfrUhFIPYFEcdFqkay0f3gkgy7rdVegiD+nrgU=
X-Received: by 2002:a05:690c:1d:b0:798:cf7a:4ac8 with SMTP id 00721157ae682-798dd7ac0fdmr32950497b3.58.1772829444288;
        Fri, 06 Mar 2026 12:37:24 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-798dee48667sm11532747b3.28.2026.03.06.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:37:23 -0800 (PST)
Date: Fri, 06 Mar 2026 15:37:22 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 jayakrishnan.udayavarma@broadcom.com, 
 ajit.khaparde@broadcom.com, 
 kiran.kella@broadcom.com, 
 sachin.suman@broadcom.com
Message-ID: <willemdebruijn.kernel.316df6285de54@gmail.com>
In-Reply-To: <CANQF7iA6y7MDR6KfESUnDqFZLOBsgvkUqzAx_3GboF=c9TkDoQ@mail.gmail.com>
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
 <20260302195352.1015990-2-akhilesh.samineni@broadcom.com>
 <willemdebruijn.kernel.270f71617ce0@gmail.com>
 <CANQF7iAYmKUj_WeDgf4dg941Zxm5bBVzz=yvX17PmyKMOYe6ng@mail.gmail.com>
 <willemdebruijn.kernel.128851f8834b9@gmail.com>
 <CANQF7iA6y7MDR6KfESUnDqFZLOBsgvkUqzAx_3GboF=c9TkDoQ@mail.gmail.com>
Subject: Re: [net-next 1/3] psp: Support resetting statistics on a device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D908922790D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264910-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org,broadcom.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[broadcom.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.969];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Akhilesh Samineni wrote:
> On Thu, Mar 5, 2026 at 7:55=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Akhilesh Samineni wrote:
> > > On Tue, Mar 3, 2026 at 2:45=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Akhilesh Samineni wrote:
> > > > > Drivers may need to reset per-device PSP statistics to zero.
> > > >
> > > > The series does not include rationale why this may be needed.
> > > >
> > > > What makes PSP counters special in this regard?
> > > >
> > >
> > > The PSP supports dynamic administrative states, allowing it to be
> > > enabled or disabled during runtime. Currently, statistics are
> > > persistent across these state transitions, which can lead to baseli=
ne
> > > drift and complicate telemetry analysis.
> >
> > How is this dynamic enable/disable configured, and can stats reset be=

> > part of that, rather than a separate API?
> >
> =

> Instead of bundling the statistics reset with the transition to the
> disabled mode, we considered providing a separate reset operation to
> give users the flexibility to clear counters without toggling the PSP
> state.

Flexibility. And responsibility. A user process that waits on a
notification to exercise this API? That would be quite complex and
clunky.

If counter reset is expected on device disable, more robust to have
that part of the reset logic itself.


