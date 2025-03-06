Return-Path: <netdev+bounces-172640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B7A55994
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEE43AF56E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEC9276052;
	Thu,  6 Mar 2025 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0kgmuw1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA71FCFFE
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299657; cv=none; b=CCKPGJCyywRs5H/leP6vLlP02DIq2YpK0idmtPjY2QH3HTuuenu6ISQz6CiJyDke+cgmdMWVh1fcZ692bi2gTS3j9C0UtNRU0C9+rpW+T5EIKI2Xf0hXbw/sCSOsoR6VhHTVNSQfb0/dhZZKJ1RfcEJm7/3F2uX/RD5REeUgOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299657; c=relaxed/simple;
	bh=jijdJY1WNEMtaADEADccQQLCKIQ1VEpcBe0JlrxiChM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfBdeoOndIe+FPGkHF5/5EI3f9qqZYwAtP8Qn9Nel9ycnb1nPCtvqGB2EPp7z4WMl9Af0sKoQsbg+34sW+MiQc43WOb+U4qxeMyWeqcv0eF5UUkLotRctD38ajnYopjloFuAsOWzkwTyoTGAULE/tx+E/icMLnaZGZlSUIQqwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0kgmuw1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5496078888eso1448544e87.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741299653; x=1741904453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxnxNhRkl2oL5lhMxI8nazAurkutLlKeiLI6Pg9V1N0=;
        b=j0kgmuw1crX55YfX8ceofq/+A3IoPu+Ne87z/kzb6D1GPHx3wDptI+e3waS/0oq69v
         Rzw9JDTUwYp1LPDKb2vII2+PkbVGKgy1k89xpnGggsjR/GkM6JzBV8+udg8K74uYKr6V
         ihmBlVgBvpJn56iYO3/K0Q5odU5fUT2/dl71n5VZaYw7r5YJKVelhmyEIhhkyiAI68rQ
         yr4Di8jDjmjp8EVoIqLHQ/fsXVGZ83oUr/NkWGQRoB4kQyXFOmZF9Rs2NbO1wuC2DrJC
         jGJUv9Udzm1V+22GZMHi3iXg5ub0J3avot6lb735u65UuQPcbbKnyMcyA/543HyZcAu9
         +RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741299653; x=1741904453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxnxNhRkl2oL5lhMxI8nazAurkutLlKeiLI6Pg9V1N0=;
        b=ANm5KH/kBQG8NhgsxsvwCriCene8egTTtUlpvtWZ6vjluyHxIFQWJxL/dRk9Et974P
         AcQL6cht57+ahSLRwp6kdKRHsz9Ze0qBx2HKxwrnIsq+mRcYoIqvg9JYWs+MzW+vX4n5
         IzmzCJVqwCgWfHKelr7bYdIAmgTrbgBC9MO/LCLfiWqAMAwEJhwmSOaVeavNy3ceIVo7
         jmJ+Bp+HS70bNOaEz1Fl7W9BUAxBJINEx5H8L1WrrlrzGFnquoxtM5P6uQF4nc6HfGMB
         K71W/HbszaYPSRZodUK4Z4VXnjhtqJnO2DYiaEO/a3YKsYl3LvLlKvhN7q7zFrKnm8Js
         TroA==
X-Forwarded-Encrypted: i=1; AJvYcCU4ttHgxPJXe7s5ZT5yaji/UEBcKcCquEuabMsDeyOFLVAQNc3XIECUlL0NsYxxiGHQwepyNHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlugk/DNrT6x6OHyAyUx2yH8Ws+cSn3lf25aT/u2GDDmrBaP7z
	8MoDkvM3hybHAfLLUv0KjFJcAa81e6N63ztiDIIgSVpLYEN0LWxPhQHVYq5Z7V3Qn5P451OnV/w
	u6NHd6igtKke4cWPEl7JcAajm3dbT8DQwyAXb
X-Gm-Gg: ASbGncs3/ksAoRu+vJmRf98V+D2URAEIZdfMI0MxQDfc56OmKRlzEFMpx+ZqJYXoiXA
	QF77864vxaGKA4yIb3CtDamxt9IA7T0zsjE8iSBMMJ5RP8hRXy49P66eVgFg+S8jFkTzA0Z6zMR
	dboZcnWp8o+Nr23N/r/kXoriBA4jLbZQa/wM5AZE8vb9etK5DMYwVT1w8LdRy3
X-Google-Smtp-Source: AGHT+IFQgIlBAILKlFeBj7k9VDE4fActFzDL06Lw+FnjKfZU+rvuCrTsR7pDVJjk4w6BeOMqBwDPg7MqdYOkyAUoeYQ=
X-Received: by 2002:a05:6512:ba6:b0:545:291:7ee0 with SMTP id
 2adb3069b0e04-549910b5b79mr293613e87.34.1741299652869; Thu, 06 Mar 2025
 14:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306171158.1836674-1-kuba@kernel.org> <20250306171158.1836674-2-kuba@kernel.org>
 <67c9f8ed24f9c_1580029416@willemb.c.googlers.com.notmuch> <20250306125601.522b285a@kernel.org>
In-Reply-To: <20250306125601.522b285a@kernel.org>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 6 Mar 2025 17:20:15 -0500
X-Gm-Features: AQ5f1JrhQnewTLzm97XmL5Ku02o7-1hgYN3SI2rppHUO_6A3ax5AY4i0rPHDXRM
Message-ID: <CA+FuTScAQD9eMc6==2en7wko9WR4YjX9LO_jd1rngVbECQK1Nw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests: net: use the dummy bpf from net/lib
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, petrm@nvidia.com, 
	sdf@fomichev.me, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 3:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 06 Mar 2025 14:35:09 -0500 Willem de Bruijn wrote:
> > How does tools/testing/selftests/net/lib get compiled?
> > The other subdirs of net are separate explicit targets in
> > tools/testing/selftests/Makefile
>
> There is some magic / hack at top level:
>
> # Networking tests want the net/lib target, include it automatically
> ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
> ifeq ($(filter net/lib,$(TARGETS)),)
>         INSTALL_DEP_TARGETS :=3D net/lib
> endif
> endif

Oh right.
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/t=
ree/tools/testing/selftests/Makefile#n129
>
> > And what is the magic that avoids the need for adding bpf objects to
> > .gitignore?
>
> All BPF files are suffixed with .bpf.c and we turn that into .bpf.o
> So they have an .o at the end, I think the global gitignore ignores
> those?

Also makes sense. Thanks!

Reviewed-by: Willem de Bruijn <willemb@google.com>

