Return-Path: <netdev+bounces-276768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBtyF9cF12mdKggAu9opvQ
	(envelope-from <netdev+bounces-276768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:50:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 076FD3C5544
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 03:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75198300C00B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBEC34D916;
	Thu,  9 Apr 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VY8M9GRs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199FE1D5ADE
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699411; cv=none; b=ggUx6JB4x1Ct4majCm1nS45fUeFwq+0DFknbOt8+vU4JDu2p//E4Fcu/SRpxIXl3TZ9B/lyj1N+46DLL4RPujKJWrKlcAwcWSfg5dMdxTLl9avWh3liQ/bKNHPPVtAe0OiQDoBVt6zQKHYouHDWRfi+0/CyHC6APSVQxiyTcxkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699411; c=relaxed/simple;
	bh=GhfndPD4+OKCpF/SdEHNOJ9ZS7SHzh1F9MEHZdeuVuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XQuts5Kzpn3RjFKBAN1hc6FJgHlMoz9Mrk+BNcf+stORJ/8YAbywGrJTikdV4+Ud8jCK2A/1MEw5XWIwGa3YAdR02xvKbwmTSyNTZ85vs9Na5ArRMcfjRLQVIzNFlgIb8LD54nQJ0I31b+gePYQwvNsOxrSK9ZUpdZ5TEWEzuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VY8M9GRs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b242b9359aso3810675ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 18:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775699409; x=1776304209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjzeQXG7bo5x2g7969Mw9H4IWYa/nql9R5zj42Bkizk=;
        b=VY8M9GRs7Io5RZqFoYkZz+8toiH9N9GQswxQTsvSAF6gObNlV/5tyIghwj5rPMqHOO
         4REWq4ojnx0X7HHIrSGqVdeEJMvyKHJlO5ZMvCisReqVWCTBOM0zyr1nBC4or3HB8ElF
         Rs91UhvOIEPt9R3+DVRFbG/rxYTQqEc9qJUpuuICDwyd10C1J/wXSUozgG5/vujfFPHt
         OkMba0Yk7P/opfo8RYv8pEwz+IpdHKLImS0XhU8P/FlTc7ESYwoSZzGALXKb6YEkL/+z
         KwgFnOetIAetzY6n6eHOW2kL36LUGW9jdPhFGPdGinhvHquZ35PPUb3fFnLJk9q7mUsS
         776Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775699409; x=1776304209;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IjzeQXG7bo5x2g7969Mw9H4IWYa/nql9R5zj42Bkizk=;
        b=sgPgqpkhdd28sV+5E8kHeyDWfBgQZbvqUh2K/z4PSWVWk0NpD/MKW0uq3C+xf3ob1f
         dnxHwmNTSb4f7u9+Ezw0hkknp3v/T78RXT9FF9FpMtNyBD/lwaJ8JXytUfZmTkk1RigI
         M1ogIDrZAPOHg8TlBg5ZIQKA6sutEIu6dGiUZzomRW9O/ob3grj7YUyha+5RA/P3IeWR
         seZoc09QF2FrsY4u7KID549Fh1x92rQM+/H0T7vehgCaOu4U71w2f7DT4D5xtADK+OBL
         H545unAdj9+nDdMTeF4lKKS4jK8ouR+mlJLUYeF/vxhdxp7IR6ehWb43PU8j2XpjLNjD
         r/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlzKTHuCe6jiwgaJ+MhjXUKWRZ+HdZrywVTiESxWxROkQylUfsHPXCc4Hekk9/wKx1b6iAJww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQVGCxrg7B8Kc7h/SQHX7GDWOyT4voWsE9zLNSildTBkWQR6/
	fGIBuB5iQzuB+tUFFBY+CMmkuxWenhcr8yZfZ65oMYDbg5ix4HqexW2h6e+86m0Nh3uKqQUptx6
	LjVpBrQ==
X-Received: from pfop2.prod.google.com ([2002:a05:6a00:b42:b0:829:a228:6330])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3946:b0:398:8f38:441a
 with SMTP id adf61e73a8af0-39fc7ba75d7mr2248165637.0.1775699409147; Wed, 08
 Apr 2026 18:50:09 -0700 (PDT)
Date: Thu,  9 Apr 2026 01:48:59 +0000
In-Reply-To: <CANkEMgk16j2xzQ85JGQ4OWqeiwiVO5Gy-UfkN3omKkKizpLxiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CANkEMgk16j2xzQ85JGQ4OWqeiwiVO5Gy-UfkN3omKkKizpLxiQ@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409015007.3741559-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v6 00/10] Decouple receive and transmit
 enablement in team driver
From: Kuniyuki Iwashima <kuniyu@google.com>
To: marcharvey@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-276768-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 076FD3C5544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marc Harvey <marcharvey@google.com>
Date: Wed, 8 Apr 2026 17:10:05 -0700
> On Wed, Apr 8, 2026 at 9:40=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > It pains me to report on non-debug kernels:
>=20
> I'm sorry to have pained you. Despite my best efforts to run with the
> exact same environment and conditions as your CI, my teamd can be
> killed with "teamd -k" but yours hangs (both are version 1.32 on
> Fedora with the same kernel config).

Considering the subsequent "kill" works on the dbg instance (thanks
to 2400s timeout), I guess teamd is somehow stuck at SIGTERM handling
removing team devices in teamd_port_remove_all().  (SIGTERM being masked
sounds unlikely)

https://netdev-ctrl.bots.linux.dev/logs/vmksft/bonding-dbg/results/593802/4=
-teamd-activebackup-sh/stdout
https://netdev-ctrl.bots.linux.dev/logs/vmksft/bonding-dbg/results/593802/4=
-teamd-activebackup-sh/stderr
---8<---
[  759.819815][T21724] test_team1: Port device eth1 removed
[  759.822323][T21724] test_team1: Port device eth0 removed
[  790.615687][T21728] test_team2: Port device eth1 removed
[  790.617445][T21728] test_team2: Port device eth0 removed
---8<---

Adding -N and letting "ip netns del" release the last netns refcnt
and defer device destruction to cleanup_net() may help.


> For v7, I=E2=80=99ll invoke "teamd -k"
> using the timeout utility, or just increase the test timeout.

+1 for the latter, maybe set timeout=3D300.

daemon_pid_file_kill_wait(SIGTERM, 30) * 2 =3D 120s, but just in case.

See these files for howto:

  $ find tools/testing/selftests/net/ -name settings

