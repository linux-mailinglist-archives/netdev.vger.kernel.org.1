Return-Path: <netdev+bounces-234746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80165C26BE4
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903ED3AAB57
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB1E30CDA2;
	Fri, 31 Oct 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kaf4vG02"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D78303C93
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938868; cv=none; b=ZZyCoEYXKtCbHw9Vop5XBXNHZL76unLNW5Kj1DxtILR7dBSxWt9p5nB57UNddLvRPynTsZh67h3uAgzxB93NQFYubi0cKyDLWLIwV1BJ/uitoSKutxrIOf1dQeh5/F1eA2bYqUbRCOqj4AkVUWg6k3GOatSad/gy7JqiQIN5mq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938868; c=relaxed/simple;
	bh=W5ERWeScacJrf/6VbJA5tzli6xAOwXLej82R5oNfZn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zyd8yKn09PGU/ZmRK2Fl8kuKPPARxNuYqc4IpXU/NuxosWzXUNXgZg56bZ/+KTuJUUIGzCkShz+XF6l30WRgqokwas75p7EWVtPfTsCQrZMaNcBje9BSM1jMLerh/lpCA+q4mxRGxwnFFcNFrHWC+DcfBurYL9/08KQHm3G9y3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kaf4vG02; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2698384978dso22379905ad.0
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761938866; x=1762543666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D//lpsjWyumK3n6VlbuWmPrat3C7InfHOVa4TBnUZU4=;
        b=Kaf4vG02AspVkEQufslGTPLsSeyG6UdwdnCitxJyr41M+eiYrExuNwTvB3W/qXOgxj
         PRdmpjfXsc/2AVmDjk3OFLXCKtZaZiGL1rEaT6msODg8PWt+3Kl3A8/SL6yaJF+5N3+L
         Fb//cQLJp+kr5GsSNqOO++EBbqMb+U2L0/RwOOV4nzgy/83OtgZmLGAuHBC35F63WoFg
         SJPVyTUUwsQSkrNSc8tVzbp7ZaN20KGupj04JWa0HNN6pnw8hOBlMHV4cPXp2FwPrHfo
         R4J1kzBhElE7ZD4mK/GFko+hjzCPfVMsHTtjjVDt5YpAt4yAPVeWylgmxSwsd/tGmx95
         UcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938866; x=1762543666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D//lpsjWyumK3n6VlbuWmPrat3C7InfHOVa4TBnUZU4=;
        b=MgHJvpUoQDBhoN0ZUqRuKJwq9TC8vtRhX7xxbF42h2vHrutRradV1O9APatrP9a7CK
         6J4BNT6esO2QWM6NLESWV3wMWgxe5O8syDvp5eGoX6Xo9RnJDGOD6C2TR24KqLeDEHux
         EEwRPsn3x/OIhIBGRK6ekJaF1JB/8R19tnMsre/kEBGUhbn4IFCWLi4q8oJwnFp8vUDn
         5CN7PStTSXNu4Uznu6+n77Gz3rvY4JkYDnN/F2QeDjIZaHn+LFB7caBrySdSBf0/a7Kj
         r/2WrzfRt/K+HK6hAD92UwOvCSKP/tcEjPABoOn+kwdLXy/d9qy52KGvaUVyYGLFHtqq
         TWdA==
X-Forwarded-Encrypted: i=1; AJvYcCXq/BfouJ+h3i3Rzk5w5z/gOtaukuHSZF9MQUyNl0eVgXG/Uwsl++yrUdE/4xfXmmrtrrlvOG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97j+qYJJrDRPkd5AMgYSAIRwZ7mh78dwMK7sv+tMmGvPq2tid
	JGM1pBp8JgC8fd/Or4TuvifuFA8i6cydGWshxp/o5OwW4Rjv1GIXYxprYgw1A3jSYlDa6JmFgsN
	VZgsPlIyUZEN26f8JWavFPy/ioiIu0a+lXrrJ+CPz
X-Gm-Gg: ASbGncuJHiEaavI0epLVcN9ydv537EoSSuenGvkDXzVLoymH5dPXnVZuPQtVtjdvP79
	le4VUyzeb0/v6ZXZbhE36VMmFdmEYy4KuyYsBWOb/ZRqRgs3SK0mpi3faaBUykZ0Ry9NR8zfkKo
	eOe6gPjqNxsquJCDMpppgYJ8E9aB1aZsHLx8h2OeBU29xELO3G4H/H+pvee31nbR1Uems+vMm+g
	ok+eE6Wh092bo45Dwl/asrnqk7BZSp1arM8cev0m42SJAnXboS2iHhz0snS78SEXUaeGsbkgJAQ
	c/246JrEMw3UyDEnuHlcRmVSfYz2B7o2uv2FVb8=
X-Google-Smtp-Source: AGHT+IFZUbXp28y0C0+8P0RtCvqI8+9sTeRUh7l5pcsHt3+fz1d92FONyqve969QB3J7LLHn7Chttx+BCV31QLbv+Q0=
X-Received: by 2002:a17:903:228a:b0:295:557e:7467 with SMTP id
 d9443c01a7336-295557e7b0emr2653585ad.17.1761938866351; Fri, 31 Oct 2025
 12:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com> <20251028161506.3294376-3-stefan.wiehler@nokia.com>
In-Reply-To: <20251028161506.3294376-3-stefan.wiehler@nokia.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 31 Oct 2025 12:27:34 -0700
X-Gm-Features: AWmQ_bn2YZsASxudsjnaQ_5Bjyi-hSzM7nTrE0vhRKJJp2EZCZFWgvZ56FkYWlo
Message-ID: <CAAVpQUBaJMNCOZtzEcUUT80XmZsj+w8CZDe1C08FudjXJFPT6A@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] sctp: Prevent TOCTOU out-of-bounds write
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:15=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> For the following path not holding the sock lock,
>
>   sctp_diag_dump() -> sctp_for_each_endpoint() -> sctp_ep_dump()
>
> make sure not to exceed bounds in case the address list has grown
> between buffer allocation (time-of-check) and write (time-of-use).
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

