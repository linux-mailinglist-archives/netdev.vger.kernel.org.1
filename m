Return-Path: <netdev+bounces-196313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD0AD4359
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 21:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080AA3A50C4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0DD263F41;
	Tue, 10 Jun 2025 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6Jy65t7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5BC264FA0
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749585304; cv=none; b=o9/OSJB1zgOVbrWxbk6vBK53og/p9T7ovt/h/jZ+2rSLjO/dTvEdgfxMsGYG+7W2fkkqoes2U8uDUar6DDVFSXVmah6HGMy0YliTvu7yrh8mclflv2u/CeTa/aZisXWjYG5XvenqBHmGTERQtKUBrBUXCygAu7yOObh3qtaWpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749585304; c=relaxed/simple;
	bh=4ZQFPiO/Z8eR3ErmxM4le+vHhVO4UgB3z5yNUs1JM1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBV4b45ICwV9aWKBY3QSsUDfHPEDBPL3zyjDt9iMgi0bU/OTBmB8YvXRG/SalvKnpX4Ab3SlWcZStqUNeW+M0DP6EI21iZTSf25+ghE/q7QkoMG+wp4mrRFvPwoQmROXWf5IcunZPWIYETaZprVQOzc9gUiRSY4tpH8Sbc/jaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6Jy65t7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so168746b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 12:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749585302; x=1750190102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUmo7g0UFJJWN2OnoMqbnKsEq8c7qhVTj7PyMfmJWyw=;
        b=F6Jy65t7PQGjIK6LJIAi30m82c5SE9Pcvzrf/fh+AbwyfemOzoemNy10g0V+LuW31r
         Rd/x07qmK80W+Tv0gdjRav2FMNKT/g7DuhQWUO3USdnLxGJgRfSFdp4Bh0VahY3sL+2L
         4UKDn3rxk9p573U4koHbABuxp1rIkli1I8t6x0T3gd2cv5N4xUv3y+3l9qXGr0FTBKbe
         0X9CBAdJDFEZMdgIJdtUGoXQhSJG2NHAxep3B6uEUPLaEktEciYnZZH29hnyP7ZUVU8b
         jFyncZ4rsXT4bl+La4nMdhKzX/Y6EMhuXLLfn7fdn4oP1qMnnQ3xa+xrnTA42rH39egI
         u77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749585302; x=1750190102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUmo7g0UFJJWN2OnoMqbnKsEq8c7qhVTj7PyMfmJWyw=;
        b=I9fMADR+UiTz7mjazEwKkBySKtw+aJ0taphmxnHQa/v139zSMUBUkHyFO/Cyr6JvuN
         n92mA/229KoLqrlL1pfhwJSCDciUxSl2uIzXpkbFAwCKgZEsnGZYZDg376+K39W0I3s9
         E0TQ6VcqS6E8UEGlU6z30sG/6AlerW00KdvNOw7zbtQ/LFIACCkTU039rjM1WjY/f8e0
         L12VFr576GtnVStF3f/LNzk6GDFae0T8WLAJsK7yHO4zTNfcNdoIYUA8Ae3r+/xdRpjP
         sifhVich+0z30WFTCxF6ovH58CJ9nBjz7gPSonk/9rITA9G5XmQL30kD0gzSezQ4ouyN
         9LSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3YCRi/5LRasyg7wC+j9osmvnAMKBJznioUP1aHHHH4B6TtZYu86DMNO9sL45e2QOvVJnxgmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQZl28OignD3dgJ4jUypCRW9PRLjPwXRVQcPjgjM5i/M/IZpu
	aVd+jOCDO0jCkuhM2lX4BqPntlk3PC4+He34bv+O0fSlSrliiUn6t18=
X-Gm-Gg: ASbGncul7bSv56wR7YOuEfuWg0nkNtRKq+U9h7m7yp7MKw0C8mFuWQLlxwwS3Od6VRS
	nWAsqjgHEi9Igtqu6n7f/jLc8X7XSbEDKw4HuZOf65d7+SOKkPZSrU5aQy/d+taeElUzZBEO8fO
	B88Syqh5UONSpq+HWhSznCxK4Qz+Z1naEdgDTh+CnNVEkbcTOvKtrk05yhWxHgg6QQdqnx+VTW3
	DPTF6bI8y+75iF45jPIjgxZ6rCS/Xi3eAvFbJGVGgU59euSgGodEsl+fMjnEh70w7IqGZ5xKB42
	kDra5Pqeb2Pmwhrfqe9I87eXzm7YKW3PxumxpujXDV0Pj/zWYA==
X-Google-Smtp-Source: AGHT+IHfDb4ifVadoX4ZMOapqzmDBAmPZIgfIZ4spkZzm/s6Ixad+cR07DWCQxcMoKMdsmNaYpCX/A==
X-Received: by 2002:a05:6a00:b52:b0:746:25d1:b712 with SMTP id d2e1a72fcca58-7486d350f0bmr717315b3a.7.1749585301783;
        Tue, 10 Jun 2025 12:55:01 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b084e5esm8076755b3a.103.2025.06.10.12.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:55:01 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: kuni1840@gmail.com
Cc: bluca@debian.org,
	brauner@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemb@google.com
Subject: Re: [PATCH v5 net-next 5/9] net: Restrict SO_PASS{CRED,PIDFD,SEC} to AF_{UNIX,NETLINK,BLUETOOTH}.
Date: Tue, 10 Jun 2025 12:54:34 -0700
Message-ID: <20250610195459.1885739-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609155613.563713-1-kuni1840@gmail.com>
References: <20250609155613.563713-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuni1840@gmail.com>
Date: Mon,  9 Jun 2025 08:55:36 -0700
> From: Luca Boccassi <bluca@debian.org>
> Date: Mon, 09 Jun 2025 12:14:51 +0100
> > On Mon, 2025-05-19 at 13:57 -0700, Kuniyuki Iwashima wrote:
> > > SCM_CREDENTIALS and SCM_SECURITY can be recv()ed by calling
> > > scm_recv() or scm_recv_unix(), and SCM_PIDFD is only used by
> > > scm_recv_unix().
> > > 
> > > scm_recv() is called from AF_NETLINK and AF_BLUETOOTH.
> > > 
> > > scm_recv_unix() is literally called from AF_UNIX.
> > > 
> > > Let's restrict SO_PASSCRED and SO_PASSSEC to such sockets and
> > > SO_PASSPIDFD to AF_UNIX only.
> > > 
> > > Later, SOCK_PASS{CRED,PIDFD,SEC} will be moved to struct sock
> > > and united with another field.
> > > 
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > > ---
> > > v3:
> > >   * Return -EOPNOTSUPP in getsockopt() too
> > >   * Add CONFIG_SECURITY_NETWORK check for SO_PASSSEC
> > > 
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index d7d6d3a8efe5..fd5f9d3873c1 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -1221,12 +1221,21 @@ int sk_setsockopt(struct sock *sk, int level,
> > > int optname,
> > >  		}
> > >  		return -EPERM;
> > >  	case SO_PASSSEC:
> > > +		if (!IS_ENABLED(CONFIG_SECURITY_NETWORK) ||
> > > sk_may_scm_recv(sk))
> > > +			return -EOPNOTSUPP;
> > 
> > Hi,
> > 
> > Was this one meant to be !sk_may_scm_recv(sk) like in getsockopt below
> > by any chance?
> 
> Oops, but the next patch happened to fix it.
> 
> Will try to reproduce it.
> 
> > 
> > We have a report that this is breaking AF_UNIX sockets with 6.16~rc1:
> > 
> > [    1.763019] systemd[1]: systemd-journald-dev-log.socket: SO_PASSSEC
> > failed: Operation not supported
> > [    1.763102] systemd[1]: systemd-journald.socket: SO_PASSSEC failed:
> > Operation not supported
> > [    1.763121] systemd[1]: systemd-journald.socket: SO_PASSSEC failed:
> > Operation not supported

This was just a warning and nothing broken as mentioned in the
thread below.

> > 
> > https://github.com/systemd/systemd/issues/37783

