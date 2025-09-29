Return-Path: <netdev+bounces-227206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A4BAA2BD
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 19:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029123A9BD6
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 17:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5F230C10B;
	Mon, 29 Sep 2025 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdwLl96+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3D2FD7DD
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166936; cv=none; b=c23azi2TOpVF0cWr4omUSATXvq7F5slmD2SC7OrevdjtmFhWslnoGudb+aYc/UnQtsz1sq62OHrqUF61PX+Cp2wnUU3+gHpPzlChZLt0P/3qL7GesiD+uw4rPLOM9oI+b24dcoaC7CYHUk2WDoCyBR03eze4He6hkRoQR/UsdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166936; c=relaxed/simple;
	bh=TU1+KKcikkkLjZS/wSy3MRVptcZvum7r3LS6KuJtDTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcnwHyJs4CXpHjCI1LsIp76X7F+BG7LgEA/9RMoDRyY0PJJilmnqiN8mnFhhLtOnXjp2wAYUCZGVCsHWxxMdUZNpi+wZqiXXBeB/kZ7je0XsJ+yeTFOtFA0Xyodx8PvJ16T/jaaXJuW0ydqpizHuSlXjW3yykTyro9Al0ywUoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdwLl96+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57abcb8a41eso602e87.1
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759166932; x=1759771732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhKpPku9iPtRnpJMr9y5imP2rZWCpDDnfk1JiYa7Yr0=;
        b=qdwLl96+TF/Z5rbKvLRYUrChe64682ulE7cHcjKn4i2xSSqMCGgXKlXSVyrHbpWTaw
         soLotDpOwq/5z7ZccSbMhm5i+2+W3dE+AogCjspuWN+cLeLDdf8VfEkHGXsMbYa3aEri
         hTi7tpU84WFcB2PkWh9D4TKZjOsBrM84IXA49JdhyF16GVFun40/CRwJ1wGd2P5Hkdrw
         gteA4taIyzNCueVGiH4NUDOmtE7sqlkEs2AQQ2x1Tqefj/QHEzP7PhcyKloaGv8XJFyj
         r+6HV/4IIwuiByHcpMeUJoYJXmKKlFEXHAqCFgp8tNvTyDy5NL/uxZMZPJwunFD4V5ur
         Rzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759166932; x=1759771732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhKpPku9iPtRnpJMr9y5imP2rZWCpDDnfk1JiYa7Yr0=;
        b=AcqTaUT8rdIh7xM/IfNrMXJ2czYdo227SAXZyRZJOTPnbczZ3MQ55XdPqvGRPErdyA
         1+qUszDjy3HM3DHTxk8+HPevDZ6RwDhpFYQeHUC4Qj/FjingioXITJp8uLz1mkr7fdPr
         F+6S5akgplZry55ZOOZMobu2dtT/mj+a+3N5IV5v/CznDvvNCZUC0taRS0N7pd/ivJj/
         m1NzJvXLp2E5zYUWBW4AltpN1a7fGAnnfJMm+rhNP8frdW16tcWrclPeKFHw49G63EuN
         O/obUTjLqqRVN2Qm63H/5Hrlj/1OtNP6hWhQ43fLiwiA3fu95D65nfhnpHqN+c/rLaJH
         BGbg==
X-Forwarded-Encrypted: i=1; AJvYcCWXB1TrtCU+58P5T18fJBrAe1a4XEweMtiitOYVANhXsYD2mytagUd4XKcFn0C4UdP+PgNXvlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9XtzqdWYUGXuw998bz7uQbPFv761csmSQWH0ZNRJErijg5Hw
	miPfiCnrU19MGp+6b042um7V0QOgNL+XsggDNcqBGAAxqhJ+uxNxMLmh/dKHeoBsaSM7xIQ0ewu
	oPcG0t0KVGISc7kYLz38pguOvRN9q3YGNeH4IF9vh
X-Gm-Gg: ASbGnctwUARuFoqe0v/P0/lf1JYN9AVfV2GQQYlSn0dDhuhJgEpNwCl1GwvV2RZu/iD
	iECptcQheoQoZuAR5cXnB6AgiySN1XykW2JN6gpcfrQmLUtffsDoxxYp8+0VjRAa7MtNdDLsL1l
	yP7gzed/85ITU5nl4LTxVrbBV9H4mCSUvJvTotKrmMwo0fqHHTa+h1XMcWsEtQo5DBvfQmWgsd1
	RXEyivAx91qubQfoqMHCI3bIoyYQN6SYJ67w2KgEJSjnd9nuddAlOg=
X-Google-Smtp-Source: AGHT+IF99d/3kb3Gk5B+kwnd34oyoZWkh3LmdLYeV5VseYbT35wyGBmZXsSZRWmJJqcSu7tB1vRN/cw05D0b8aZfkW4=
X-Received: by 2002:ac2:533c:0:b0:579:fbe5:4467 with SMTP id
 2adb3069b0e04-58a70558192mr34157e87.4.1759166931717; Mon, 29 Sep 2025
 10:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926035423.51210-1-byungchul@sk.com> <aNau1UuLdO296pJf@horms.kernel.org>
 <20250929014619.GA20562@system.software.com>
In-Reply-To: <20250929014619.GA20562@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 29 Sep 2025 10:28:39 -0700
X-Gm-Features: AS18NWAe7i2Wt2VA7cP32l13mdSbxortudnDpG4vSLEkGRbB2jnfYA_HeBXsCYE
Message-ID: <CAHS8izOK=Y1TWyA6XV05d9i3D8xnhGcX2R-sZBYJXiVsE-RM9w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
To: Byungchul Park <byungchul@sk.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org, toke@redhat.com, 
	asml.silence@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 6:46=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Fri, Sep 26, 2025 at 04:18:45PM +0100, Simon Horman wrote:
> > On Fri, Sep 26, 2025 at 12:54:23PM +0900, Byungchul Park wrote:
> > > Changes from RFC v2:
> > >       1. Add a Reviewed-by tag (Thanks to Mina)
> > >       2. Rebase on main branch as of Sep 22
> > >
> > > Changes from RFC:
> > >       1. Optimize the implementation of netmem_to_nmdesc to use less
> > >          instructions (feedbacked by Pavel)
> > >
> > > --->8---
> > > >From 01d23fc4b20c369a2ecf29dc92319d55a4e63aa2 Mon Sep 17 00:00:00 20=
01
> > > From: Byungchul Park <byungchul@sk.com>
> > > Date: Tue, 29 Jul 2025 19:34:12 +0900
> > > Subject: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() wit=
h netmem_to_nmdesc()
> > >
> > > Now that we have struct netmem_desc, it'd better access the pp fields
> > > via struct netmem_desc rather than struct net_iov.
> > >
> > > Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> > > netmem_desc regardless of the type underneath e.i. netmem_desc, net_i=
ov.
> > >
> > > While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> > > used instead.
> > >
> > > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> >
> > Hi Byungchul,
> >
> > Some process issues from my side.
> >
> > 1. The revision information, up to including the '--->8---' line above
> >    should be below the scissors ('---') below.
> >
> >    This is so that it is available to reviewers, appears in mailing
> >    list archives, and so on. But is not included in git history.
>
> Ah yes.  Thank you.  Lemme check.
>
> > 2. Starting the patch description with a 'From: ' line is fine.
> >    But 'Date:" and 'Subject:' lines don't belong there.
> >
> >    Perhaps 1 and 2 are some sort of tooling error?
> >
> > 3. Unfortunately while this patch is targeted at net-next,
> >    it doesn't apply cleanly there.
>
> I don't understand why.  Now I just rebased on the latest 'main' and it
> works well.  What should I check else?
>
> > When you repost, be sure to observe the 24h rule.
>
> Thanks!
>

Additionally net-next is closed:

https://lore.kernel.org/netdev/20250928212617.7e0cbfe4@kernel.org/

Changes targetting net-next need to be sent after the re-open. RFC is
always welcome.



--=20
Thanks,
Mina

