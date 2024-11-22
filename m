Return-Path: <netdev+bounces-146768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B329D5A0B
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 08:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB161F234BD
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8DA1632F5;
	Fri, 22 Nov 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYars8gA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E422075;
	Fri, 22 Nov 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260862; cv=none; b=TAJmUb5EQCxz92yVZx15192YpiHLF/Sq5Idc8FwWvekgQVY7E3KuPLO1Dwbn4/14+1kK/njVpZSMJtiu1DSMU3tMtdB7EyCBg47ycVkX6smwWe4h9PVotEVEXZVMF4D8CN67x7uRIDGuw6eU17pnLp+Zm1ZyzRxWLfae8za69U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260862; c=relaxed/simple;
	bh=aKHi2s7g0Yh57xPmgKbyOF+bAC1mWROyHR/WAGtBZsQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MIUwQdfkHKetmJualcz4eiGXXSsHhloJu70pRkzMMIVBbZR/AJw83I3YUnpAhHRsbxejTJFmRPNel6m4k9Fr5jX7sJ21M2wF3uZk9A40tntaN2JToHmWT54mxwMYMKdwir+53dN3pV7DrUPZ5G6l+VbgReFvq49jA7pZP0S86Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYars8gA; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5cfe48b3427so256680a12.1;
        Thu, 21 Nov 2024 23:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732260859; x=1732865659; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WP7Qyyn9P8aoIGhU2FYV6anw46pGQsyVROPp57hHtvU=;
        b=TYars8gAAhB09Pj7MpQQScSyesXwhqVL4B9bTWn9OxCDC9VLLFfTBR7As1hjGhq4wT
         LBIVDgQbuONeP4pAp6BKco34zk+/Nig3it4wDzqpCLeFHh+5OYYEVFZHwUDpsGs1jMeF
         4pjiqEStV50Bj05JqwkkfoM48r6J2kowU4djR5G4EXJ8cpI2W0Jj+8DQ/ZvPR3X6kFZc
         0uHLwRpn9BtbSU0iT2+8PAW4OdgdjmslBU0mVjsK04r0LNUAQtJAjsvze9xC45gxlyWg
         w6H9AA2GRX3TiFzPyJaEQ4U7V4B9c5l7VRwdSnAFniYqtsaiW7x5gGj0oK+GCh2pKg+J
         flHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732260859; x=1732865659;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WP7Qyyn9P8aoIGhU2FYV6anw46pGQsyVROPp57hHtvU=;
        b=FYPeFTt9PbhYmQRWJDybhx8JpRYABSHAmwZm4Okj2jzdlnN+CjaTt2yW9lo7A7Hb0A
         HvjrJfdw9LPxi6d5S+XxhrXZToGeTRK/eKL/R9fD8CYVaWmVBiRUjsjF9a7Hn377eTmR
         r/4WLOEJbVhM4eOe60jQLp36QSx6cwTvJiq0B9VxoytDhcJZkIbUKd5BBiBoQrox/U17
         kiQ6OWSwA1wwitorDrhyDSz9K6ElyCc9bvEA2akydvq5AB6ACj08UtJkps/6Nn7goalc
         e/gDk+xDOrCJRhAmAxzamzoHa0dui7+urCGOAUvHnDLHk6YwQFIavItxxRh5RaPRyDD4
         6MuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP9ab1HBtRNhqwzHoHL6zceYU486MyNuqfNno/hsNjvKKxyTRSpitY2BADjRJNJZWoFUfLBe6IIS2+H3g=@vger.kernel.org, AJvYcCX0fe5efGVlkAYIt033ambYytSGgoJKcdBNsuVPz3KvfFrg4zv7Uu910g9hHtzAZYz1BL9c/X+a@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWfUFUzgdWQTxTiFPfjsF9AbvUP7Bz6tBaKqZ1EdeDbrxahqU
	aICa+TgWl2xL9Wlx5c2Zj7R6Xq5bQIo/BzhDEjQhoTiOzmr4+nf/yR/t5Mzihpwi+hwWwqA5Wim
	pSfNH1fg5Mg5PK7i5wE7WsUcIF2qR6GJaithIng==
X-Gm-Gg: ASbGncsuSFKyvh9X+WK2O0VxFRmX4Vv+Ida+qYfE8vs5yaTJBkj+ezrADRPimpmFgtA
	0IH//86w5LjuuClgc45WvTfnMY0Lmg0tz
X-Google-Smtp-Source: AGHT+IGCtSvS2ymC3RmhAtG5dG3THBE+Z+tmCCHfo43Bgd+3ZuSnl0VmmL4EiEP5whUNpJGSziobzESuHMl33j7bQXA=
X-Received: by 2002:a05:6402:350e:b0:5cf:d24c:e7cc with SMTP id
 4fb4d7f45d1cf-5d0207cab69mr485385a12.8.1732260858540; Thu, 21 Nov 2024
 23:34:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: clingfei <clf700383@gmail.com>
Date: Fri, 22 Nov 2024 15:34:06 +0800
Message-ID: <CADPKJ-7==Bo=Wu6cHQ_y2qQVsPoJGeP3x0GztMXYcDaKCfmrkQ@mail.gmail.com>
Subject: Data race in net/mptcp/pm_netlink.c
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

linux-next weekly scan reports that there might be data race in
net/mptcp/pm_netlink.c, when mptcp_pm_nl_flush_addrs_doit
bitmap_zeroing pernet->id_bit_map at line 1748, there might be a
concurrent read at line 1864.
Should we add a lock to protect pernet->id_bit_map?

The report is listed below.
** CID 1601938:  Concurrent data access violations  (MISSING_LOCK)
/net/mptcp/pm_netlink.c: 1864 in mptcp_pm_nl_dump_addr()


________________________________________________________________________________________________________
*** CID 1601938:  Concurrent data access violations  (MISSING_LOCK)
/net/mptcp/pm_netlink.c: 1864 in mptcp_pm_nl_dump_addr()
1858     int i;
1859
1860     pernet = pm_nl_get_pernet(net);
1861
1862     rcu_read_lock();
1863     for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
>>>     CID 1601938:  Concurrent data access violations  (MISSING_LOCK)
>>>     Accessing "pernet->id_bitmap" without holding lock "pm_nl_pernet.lock". Elsewhere, "pm_nl_pernet.id_bitmap" is written to with "pm_nl_pernet.lock" held 1 out of 1 times.
1864     if (test_bit(i, pernet->id_bitmap)) {
1865     entry = __lookup_addr_by_id(pernet, i);
1866     if (!entry)
1867     break;
1868
1869     if (entry->addr.id <= id)

