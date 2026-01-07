Return-Path: <netdev+bounces-247861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCBCFF8BE
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 19:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7947C30049CC
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63395318BB5;
	Wed,  7 Jan 2026 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jkm9Ivs0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F512D5935
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811166; cv=none; b=kXApFcc+Q0c4jawfUG9G5xxkR3wbPxjJFRLKJ4AbwYgX5aTR+jPVYt84v3Md/wGmYMu68j0VPHlvz1cUOk7ckDCRYIU8Kw2Q6m0tJN3C3CjkDNVVR1NNczE1Bokml4Sq4suLMJLJSaFvamJHA9G+w9rzEh6Jwtvb8WCRsGbt1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811166; c=relaxed/simple;
	bh=17/GRs/sweZ2UxepJ2FORHbjljzCVhb7QOgp+On2PmI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TQgz/i5+4qikOoxMkbm3GdlEYqLy00ZmUegpq6im+H/zMGrphvQbKKgT8oUDklda9av3f9pY1KWGKoFL/0JzfI9fJEjNztGLc1cbj5/TvLL8uPudRz7H5hljMVn8Ky/wbDG1qtUTF34Q3nEuT+ZnWrnbkeB1/gKiqmOjGzGF3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jkm9Ivs0; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5e5697a2cfcso845669137.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 10:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767811163; x=1768415963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jog/s8phY/kMD4U7ZIMOitnbIny6TU5fVxKkDlvhkaY=;
        b=Jkm9Ivs0wTcOf2wEcWUBtnDBOEyX0NqrfmcaHEEmz5OLjcWYkgVuXAf43LdDdkjIvT
         LxSCW9sQpjqssdP/kU48IWYr4A8g48IXQPoCLHeIk5/rdHadFc0/NEQFxhP4fqzH3UdC
         giM1gFyi+pzeOL+0emf2UPsz08NqOKr0w9y9hR/gzDaviCRZ5bOvuq/hUjK/LphL/PKm
         SUSroA9IszPgdDlvlWWrIXDOf+NKhHd22C9wRCvysVwDVwsLD0jVoqXQxqYXVTHdpkkn
         ZlHDAYfC4RsWByvOkIjfcxUU1SAqiEzIQqzzZvC7n+fm1ZSxrahVJLGGN/Uy2r23R2Yo
         Jibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767811163; x=1768415963;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jog/s8phY/kMD4U7ZIMOitnbIny6TU5fVxKkDlvhkaY=;
        b=P7amwC2WD1Fc04kaGihzUjSQHEHHkVanLYPCaMSnoe/sb1iitW6egIgi9Oznlq112o
         BKVOi1IziWgMEScrmnPmsu1EqDtX4bqaUEhrAY94Vi2KoqG9XMQ4JR1c86USO4eaAbiJ
         pOehqwzltntvjn9ZI/3jedTIqghApu5vBiI2681ALVPL4cLA695XlgELhl6qNHSyTIxY
         frGTwJlHNthxPECCAopaI1b3fcOnb+SXvGrnRcr9DpxPLx15dTx+MtxRIsRREsfSo7dq
         yg1nbgIY268v6Yv+M0yAXzNxKsHlKP6ipU9sZg2NI1rD1Ls9eFyNO7MCz+03enn8LJAE
         TXSw==
X-Gm-Message-State: AOJu0Yz54yIj4ZNpNhYDahSAEfLqHXFxreFOWKasOacZcd9JAFih+YTM
	oW0UqGnOHaUk/TJPCouJF8+yvTOJHAg/ece8aNHIY7kPV3wWtl2pkMaKWX3rjd4tv96UyTqC4O3
	cCRAvb2UbPvqhIZXB9iZ+Qtp0vngwb/mc+pgf
X-Gm-Gg: AY/fxX54tEFtiy6DTz25yS0ftn78qDNtI6tj/zhNnYNuXWIxRoOD6ug+j08y6iri80S
	7R4VgeK3KXrVjk2Raqm5pU7pgqdmhE330xO6Z5tGb89QVuyE+y8RtYkwmxNsFZzlHqUnaj6TixB
	7yYyeadFJsxHMWDrXKNjiC6G4tfPbYBUNLCG2D0IjY54j+NXxkpmGkTgPr4lLVNdAoOFyVvmQpb
	50AKYvIDGaysr9JDU+0x0h1VgDniIBjcyKMaXq1v5bfQ8xuPFs7WKpmjoA2hdvIMMExOe5hl576
	rgOpA6ytGsEMPAj/zt0aCFGtKdY=
X-Google-Smtp-Source: AGHT+IH2lPj9RqhIPAdu0Sp8rZB+iqhYH31Wx2KEG7nk3hSOfKnCH1ouXFewSOWJ/ynRl326Uu6oS/OVNP4ack66jow=
X-Received: by 2002:a05:6102:292b:b0:5dd:f9c2:5505 with SMTP id
 ada2fe7eead31-5ecb692e177mr1382062137.20.1767811163387; Wed, 07 Jan 2026
 10:39:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 8 Jan 2026 00:39:12 +0600
X-Gm-Features: AQt7F2o1MGfH4aId1E2Gkf_rlxZr4z1aSoCT613kikoYDRdw5y7gruHHWqac-Ow
Message-ID: <CAFfO_h5k7n7pJrSimuUaexwbMh9s+f0_n6jJ0TX4=+ywQyUaeg@mail.gmail.com>
Subject: Question about timeout bug in recvmmsg
To: netdev@vger.kernel.org
Cc: "edumazet@google.com" <edumazet@google.com>, kuniyu@google.com, pabeni@redhat.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"

Hi,
Hope everyone is doing well. I came upon this timeout bug in the
recvmmsg system call from this URL:
https://bugzilla.kernel.org/show_bug.cgi?id=75371 . I am not familiar
with the linux kernel code. I thought it would be a good idea to try
to fix it and as a side effect I can get to know the code a bit
better. As far as I can see, the system call eventually goes through
the do_recvmmsg function in the net/socket.c file. There is a while
loop that checks for timeout after the call to ___sys_recvmmsg(...).
So this probably is still a bug where if the socket was not configured
with any SO_RCVTIMEO (i.e., sk_rcvtimeo in struct sock), the call can
block indefinitely. Is this considered something that should ideally
be fixed?

If this is something that should be fixed, I can try to take a look
into it. I have tried to follow the codepath a bit and from what I
understand, if we keep following the main function calls i.e.,
do_recvmmsg, ___sys_recvmmsg ... we eventually reach
tcp_recvmsg_locked function in net/ipv4/tcp.c (there are of course
other ipv6, udp code paths as well). In this function, the timeo
variable represents the timeout I think and it gets the timeout value
from the sock_rcvtimeo function. I think this is where we need to use
the smaller one between sk_rcvtimeo and the remaining timeout
(converted to 'long' from struct timespec) from the recvmmsg call (we
need to consider the case of timeout values 0 here of course). It
probably would have been easier if we could add a new member in struct
sock after sk_rcvtimeo, that way the change would only have to be in
sock_rcvtimeo function implementation. But this new timeout  value
from the recvmmsg call probably doesn't make sense to be part of
struct sock. So we need to pass this remaining timeout from
do_recvmmsg all the way to tcp_recvmsg_locked (and similar other
places) and do the check for smaller between the passed parameter and
return value from sock_rcvtimeo function. As we need to pass a new
timeout parameter anyway, it probably then makes sense to move the
sock_rcvtimeo call all the way up the call chain to do_recvmmsg and
compare and send the finalized timeout value to the function calls
upto tcp_recvmsg_locked, right?

I would really appreciate any suggestion about this issue so that I
can try to fix it. Thank you!

Regards,
Dorjoy

