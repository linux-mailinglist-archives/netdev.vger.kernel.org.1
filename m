Return-Path: <netdev+bounces-178482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D498A77247
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 03:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBB83A96A3
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 01:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929D92CCDB;
	Tue,  1 Apr 2025 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTwKfK2/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1B1078F
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743470128; cv=none; b=dw1v2zVVPCgPOiTcv3GtGj760krNuX8Wo2iUyukfQVhSIioM0hQvVudiKjQvzvjziU72AbFybcfoWxBR3gAtC5kjN+OZgap3kThEO8o6wMSeFidW0S1RLb+nDghlmfBloTsgxdP/0XcrQ4sNPNmHGcG2+NsuSZXC6LP3vsv4ZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743470128; c=relaxed/simple;
	bh=uSKK15Bmle+CHDxqKOqkP+lDtUPEqARU0bViNSV6Ntk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=isVkion3NgHS9eIvrR3uoyu0TgM1qXTiCgVHBiY8vuVDIQfY1Wki67kyQf+0zXJ03Ga0BzNutExF5JWJUsHcKhSrpy9+9PxD2a6L0Yw0kgu9HZFLuw11i0wcEEeoQRaO7cxyNP0X7NR1jH//Zzx5Y0thzanxe7ZsOiVKVcz/0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTwKfK2/; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4766cb762b6so46410091cf.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 18:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743470126; x=1744074926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXAoilsLfrA53qHSwwb6+fb6SaPNoUOlQKK+o+3d4NE=;
        b=RTwKfK2/Ka1tfqzb7iipguWWjcmjxCogHpyX+7tm6n8ERWDAZ9LXGsjPMTfJZQrC2p
         8TQ3qCGW671Rm8e2GXjwTDbW0jPvDu8wjn8I2QzoDKXnXvMHYRTocu2UY9xovq2dOu0a
         McAEO4DPxEsWef22ARck8RVfOMgYVdxp46WShzLRspwhDOjronkQ56YvCIjq/5s5Lgge
         Fb5x3ft2lu8VA7ank8zzAhG5JiucmiN0fppgrYn24uK3k3+aMzTGumNRiKmbEeO7q8Ia
         5JJLqUML/GYfa0bpbz9jxw/eQtolj6UHXAUzRLQznJjnqRTP5U6eE6hyEMFoUgsXVFua
         oVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743470126; x=1744074926;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VXAoilsLfrA53qHSwwb6+fb6SaPNoUOlQKK+o+3d4NE=;
        b=StI8VVgjst/PPfrWUKu9qPhRNF7cZiuZZnW1Us0jAFKmN5NSxF2ZBqC7QcmIHR7bwt
         cw5JgdYYQ8URy+a8xtwSyCtzfMRBCUOho1QgUXcIjTB88iDmE9ToZmZfpcNCppm19v90
         wm3Gkawtx6C1Qcq6kIwyBrrfR6GSfL6pxC90w/COFEWW7W8zL//whThNObEz2mIcEFK3
         mnIk6KOJUYtxSp0v6q/I4CKjEONFfmTN1+RsHaaFoO2KDyxhPbkdc5Vbl6QCcUW2nZsv
         h9RKNN6VwCwUlCaai5EkFBsz462UmYGmps1lyG748b8chkdWzgNuQCke/KcAH4Ws7VBB
         AUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2DnFszwCGcUr/+w1RZFX2C/Z5eD0n+9tv92pqdtVHHPLY19PomE+Qu88ukmOsq7oZ/YhOt0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94ehV9kQOKDk3ewNx3+X7v64WUx9ALCgAWufoF1LrG/LbzMut
	LarEKfqixm5Y+O2jdmv42E+P7jV7O9EUF7LDeGbiHEHw0Strv8GH
X-Gm-Gg: ASbGncs3cOFCnBQOk12BtH7YAVHHA1QibGi3lvu/x3/We/InKayxonC2mv1otGRTzfs
	MyJFXArqD1UTgnJBX8hFDtfDWvRL7aW9pGCaxXfBylEvILb+aK+YprToAFJKUKjhXlYSZ3kDJGM
	vXVoLdc8iGnRkw5EhZCJOdhJI2zBMdkW15S+Jt+FnH1RUidZ/YENP4uwx/XP+bLGNKpuM+JlNT7
	Gm2aW9fFrHjEwpsXylkJpiEN8s/DPHG0JTatx3u1+OuYownNmNgZ/oRSzseBEfYV7qIHDfrL+pz
	DkwvJtfpihxR63xQeXI6QRyF6GPy3ipat+JFY4U3WuBRlf623uDyTwnsMTNMwq/0mmisNy4a5U4
	Efqa+iVJMmJ9dQlszzKswxg==
X-Google-Smtp-Source: AGHT+IGnJcZQD6hpooq/ugxfcaYJ3Ge+iWQ02+18qk00Wwz0VMflSS2FtfvZoOkN+q5VFQ++rbVd8w==
X-Received: by 2002:a05:622a:518d:b0:471:f9bc:fe53 with SMTP id d75a77b69052e-4778462aad3mr218996171cf.26.1743470125802;
        Mon, 31 Mar 2025 18:15:25 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47782a49f2csm57601861cf.32.2025.03.31.18.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 18:15:24 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:15:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuni1840@gmail.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com
Message-ID: <67eb3e2c92fb9_395352294e1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250331162941.01e14713@kernel.org>
References: <20250331185515.5053-1-kuniyu@amazon.com>
 <20250331203303.17835-1-kuniyu@amazon.com>
 <20250331162941.01e14713@kernel.org>
Subject: Re: [PATCH v4 net 0/3] udp: Fix two integer overflows when
 sk->sk_rcvbuf is close to INT_MAX.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Mon, 31 Mar 2025 13:31:47 -0700 Kuniyuki Iwashima wrote:
> > > > Please do test locally if you can.  
> > > 
> > > Sure, will try the same tests with CI.  
> > 
> > Is there a way to tell NIPA to run a test in a dedicated VM ?
> > 
> > I see some tests succeed when executed solely but fail when
> > executed with
> > 
> >   make -C tools/testing/selftests/ TARGETS=net run_tests
> > 
> > When combined with other tests, assuming that the global UDP usage
> > will soon drop to 0 is not always easy... so it's defeating the
> > purpose but I'd drop the test in v5 not to make CI unhappy.
> 
> Can we account for some level of system noise? Or try to dump all 
> the sockets and count the "accounted for" in-use memory?
> 
> We can do various things in NIPA, but I'm not sure if it's okay 
> for tests inside net/ should require a completely idle system.
> If we want a completely idle system maybe user-mode Linux + kunit
> is a better direction?
> 
> Willem, WDYT?

The number of tests depending on global variables like
proto_memory_allocated is thankfully low.

kselftest/runner.sh runs RUN_IN_NETNS tests in parallel. That sounds
the case here. Perhaps we can add a test option to force running
without concurrent other tests?

Otherwise, the specific test drops usage from MAX to 0. And verifies
to reach MAX before exiting its loop.

Other concurrent tests are unlikely to spike very high. It might just
be sufficient to relax that ASSERT to something a bit higher than 0,
but a far cry from INT_MAX, to mean "clearly no longer stressed".

