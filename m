Return-Path: <netdev+bounces-249165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F70D15507
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD4F302105E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0F2F25F9;
	Mon, 12 Jan 2026 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJEpuSUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633032A3E1
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250949; cv=none; b=MFsiRJXU57yJQ0rCiX8rdHrZYM/5FrgjBk/pgqG24gayf73iAxz3tlrz56QQt45u4LfDXyyqO9wTUNT0PxkRAGQNSlqqJZNduMQqzEKVUay2j4133rSxFb4pkLaS8w/NHEbwUpUAdE8x9EelsB1oGA/ig5bbkU5mAglvno1ymsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250949; c=relaxed/simple;
	bh=DXbVa3jS0bJFES33jOZRjblJg0xNQ4KyxInln27F+dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK+lDZBqUXtQWW7PfY9fB6OrMU1LADc7uO3Xu/gmt5cQElYQKZz8Vedci6gUPmrJni+1hkDrE3B4U2kYCzSE1PR1nlToITx2f1OvIuV506G/uvRw42Xmet2SFZy8iBbYUR1e8o/Vf+O/IQKze655IpqXpdsh0zN345ul3Iupl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJEpuSUU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso59499095e9.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768250945; x=1768855745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2RjJNZj9WiaDuu2/f+BActJj79sF/vP6f1iAg7+n+0=;
        b=nJEpuSUUZ/ZiUYVVDFs/teihrwDrgHHq4z26v4/Bl2gxYqg+aBw0Z0rrfj3e1CHu2t
         rR+Jq5ymGn15/u9fFzCt1jDed83lxsATGyRpCG1fhCkFeux4w3Hay6hyluU9nMYN7sgc
         AtBV4PLI2Ep3zzuzx986RfrgCBvjJ1VUQCK83J1Od+JVEC3VgV1wUSiX/SmFt3vgjaHA
         HErFidYvsXFF4TnOIFTtCgq4AbCY69MtBbLoAL4izB97vqbWfFH6jYWhJAYhP71GcrMB
         k1Jpp2oxybVpwGYMAlnTSBRFtmppghgM7tJmyMx+DWrQDYmpYOlDwkF/oZbnEbzfdKA9
         nQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768250945; x=1768855745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2RjJNZj9WiaDuu2/f+BActJj79sF/vP6f1iAg7+n+0=;
        b=AZjnmGrZp4ce5pDS6bMuePiH05l7wopCMoQLFlJYLsACty5w3YrHN5WyF9NiXjVHMy
         9/AumygEYJ1k+VeSh0W+2hrpZFavzmndFb1KE+L2gFQcAPsrz1AGNrHnhZQl0lRH3hXH
         jo09FfJTU622yyUbYXmnrWbPOXky9kKg/K1MI+7V7sIljucmkc43jmclkb9RFDGtkw6O
         cK3ftiGcYBrph+qcMqvwQbxARMSkzvIbh9LWhQ3hMiISiZOy7UBMQmXEoFiDvj4uw/p7
         4x75qWyeJLW9u1kIShy99mMczN4xI03U5xys0a7YdDPX1E+zpJGODYhe4ZuHYEGcVr8N
         FDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuuNkiYq8ISTbOD9WXVA50vPApT6WCwUvgShorM3HQFPu6+ZABuXLP+/9GRbUyes+XfuufKfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLYHERHdf6s576gng7p0DsgyURXx5I47D/CEIAM6G96D4n0lV8
	4PeY1PzHphxqruWoFIVq8jWDgPc2dsMVkA0tbsxXUg0kZD4BO1Aes8Cq
X-Gm-Gg: AY/fxX6ch589XSNsPs4gKd7Ue2bNkTCa4PPTnIecArSfgP4fkE33iqeoQCy19Nzk892
	a6gWJPuaoC90l66eq9Sq5xqPcz5bTNFEjdx73WGv+fj3cIiwMs5tAC3vvg9ijr1BtkAfAQaY5Xi
	S+xxunuycsiD/r4pQkT+/DUWf9OGnzAC5MyyGFrMVBG5fwYsZwXqnHDHm2pOX+XDdlggKBIh32y
	F2ifcFmnFoCDG1gpLEK0bV9yuNok41n6U0u7omcs9eqcH5+NZeIFvRsiR1doFgwdltTZCLE6sZt
	Vg9EsI47Q8tCgjdNvbKztA9dCK1PMISWqr2nGUvdsywhAXrOFjzoUz4PNLDefVPBUcath+TcK3o
	zrW4cBa+qnTVb+InNKowZWuo5/oJs185aDXATNx8HM78RHpvWN81l9jTbtUBGf1Y1Blk235EGfd
	ZNcjXCbA==
X-Google-Smtp-Source: AGHT+IEUHyZiTNqqW+IdaQUrwbNAvr56XMJ93G/j42dlvw8ceohsgT5xlYL83tB9qWVnH/xCWwdzwQ==
X-Received: by 2002:a05:600c:8b43:b0:479:1ac2:f9b8 with SMTP id 5b1f17b1804b1-47d84b33b7bmr228110095e9.21.1768250945215;
        Mon, 12 Jan 2026 12:49:05 -0800 (PST)
Received: from archlinux ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653c61sm377709655e9.10.2026.01.12.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 12:49:04 -0800 (PST)
Date: Mon, 12 Jan 2026 20:49:02 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 7/7] selftests: netconsole: validate target
 resume
Message-ID: <aWVarVD7DQ4uG8YZ@archlinux>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
 <20260112-netcons-retrigger-v10-7-d82ebfc2503e@gmail.com>
 <20260112061642.7092437c@kernel.org>
 <uzrkzwqpy2mf5je44xz2xtody5ajfw54v7kqb2prfib3kz7gvj@wtsjtgde5thb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uzrkzwqpy2mf5je44xz2xtody5ajfw54v7kqb2prfib3kz7gvj@wtsjtgde5thb>

On Mon, Jan 12, 2026 at 07:16:54AM -0800, Breno Leitao wrote:
> > On Mon, Jan 12, 2026 at 06:16:42AM -0800, Jakub Kicinski wrote:
> > The new test seems to be failing in netdev CI:
> > 
> > TAP version 13
> > 1..1
> > # timeout set to 180
> > # selftests: drivers/net: netcons_resume.sh
> > # Running with bind mode: ifname
> > not ok 1 selftests: drivers/net: netcons_resume.sh # exit=1
> 
> I was discussing this with Andre on private.

I have not been able to reproduce the failure locally yet. I've checkout out the
CI branch from linux-netdev/testing and followed the instructions in [1] to try
running it as close as possible to the CI setup and no luck yet.

I'll continue digging but appreciate any suggestions.

> Also, do you know why we got:
> 
> 	/srv/vmksft/testing/wt-18/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory
> 
> after the test failed?

I think this might be caused by a change[2] in run_kselftest.sh/runner.sh which
seems to cause runner.sh to fail when a test failed and runner.sh was not called
from run_kselftest.sh.

[1] https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
[2] https://lore.kernel.org/all/20251111-b4-ksft-error-on-fail-v3-1-0951a51135f6@google.com/
-- 
Andre Carvalho

