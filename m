Return-Path: <netdev+bounces-103835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD95909C6E
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 10:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44667B2167F
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 08:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC3181CFA;
	Sun, 16 Jun 2024 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+FXveLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59A944F
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718525365; cv=none; b=fvVXxUekV2JjXEZOxhiOPGqzuEpQ1faAyHINSFtf6yW8+E/xTtOSnambtFT3ZALa367Ks8gkJ/gYvwZJccR6MzFW4mZ8HBS/BmuK/w1RET62W9fsDH3Pz7ApylGRPvN856w0KKpc6aSwaz9HD524eDizWRLdHRK9EzZYZwVNmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718525365; c=relaxed/simple;
	bh=krppeOgfvSlKnBK+h5iMB04CsxMC/7zFzJ0cmgILEjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvelLG69/qopF/s8z6820lC2zdn+1ytDtoICVdSAVz1wpOrD7oLXD0DbULLwYMlIgPoclQTxxQVW4UX2xDbm45kWLme6wOJj0u4XbzjhCQnYKNiGG0UvkP2l26rqUJDgAzRT1FujAzIhV82Jww2Ww4FmRAxlCf1HaYmxV0l6k2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+FXveLz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ee5f3123d8so184925ad.1
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 01:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718525363; x=1719130163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk/7afabeK8/L+epjW9YFjDCMdSwGYo/Fd02a9OudIc=;
        b=P+FXveLz/5zNa15UkGTPOTE0/npHdqtnj7WWOsdhpmCDCcOdifI+8hW6YKJrjE0szA
         XOD5cRbvgdYUHxWAI5YLsZ3r7AAmR4jb4iMmJ41Hla9SaTxYID6mLzUHtxHcoPH+udfj
         eDAyqXdBtfhmH1EzMb6YbXJbu0gBWmCTQMoaPDOA+IkckFplhvSwk/fz+UMqyo5SoN04
         yimob4T/kzoKDdlzDiKfCrYIeE/zVDKxXO9azvdAXYC6k2Kh48iQAdCA0fk/V76PJ51i
         l0f/VD5BBBQorUwuS/antlXTcuugwCpvydBEvEZ/frcWJPwwu5vSP93Lvaxx488JhDVl
         gABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718525363; x=1719130163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vk/7afabeK8/L+epjW9YFjDCMdSwGYo/Fd02a9OudIc=;
        b=q24+t7ONWqNnRtVlTS2h021UDHfNbw8MEXwreOMPOqyh6Pl226zM2bndd/dA1Jaqdw
         DHyqiYIwHTmDso7Do0vNjkEQi0g49vNid/eXIo/XLs702QzTFXkMFatQ+aT1ePMv8c8g
         XE3/Y6V7M3uKoh2V+VSjGct1r/vMnzVDwryjW7i08WTzw9C54OftvpGkzifyYmOWmPew
         wbRFoEsA4L2+3EIylA5/YEmHig7QAsV4C6oLES9nt32zfABcCTrZX3Syd5nEvfcrTpMt
         7Qagl25Xw2uOCMWBc0lDAVNkR38uIdC5WDlD4cqQ8iuZ5l4o5HNSsOV7DH1KvpWEqtAi
         3+HQ==
X-Gm-Message-State: AOJu0YyYkRL9AwJdq3no25JRsudLww4PG1CWEqnwFqYsj/Avqu+w5zPd
	MObSPg+QPtPIssLbYGwyxJzSUD1De1KmRSIwgjCLioQscPVAkUHr2ofyDmKRKBgN0dQ4awWPBV/
	9dsq8us6jWAu+3EoTBPEjKOSCPE8qZnY5uAEC
X-Google-Smtp-Source: AGHT+IFosWTXFoJgATMB20EhdyDeXS5FvVw/v+/7DcO1P87Xmmv59McjgMI6euTTtIHRK+RPlM8njP0neOR2LPpq1Jw=
X-Received: by 2002:a17:902:8a84:b0:1f6:b0b5:3295 with SMTP id
 d9443c01a7336-1f8743ae77emr2931695ad.4.1718525362535; Sun, 16 Jun 2024
 01:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615113224.4141608-1-maze@google.com>
In-Reply-To: <20240615113224.4141608-1-maze@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Sun, 16 Jun 2024 10:09:07 +0200
Message-ID: <CANP3RGeENFk0RFD2m1kBuOJxdAhKEjR=9caokkKah35py5kXbg@mail.gmail.com>
Subject: Re: [PATCH net v2] neighbour: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to RTM_GETNEIGH
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

For the other patch, I've tracked down:
  32affa5578f0 ("fib: rules: no longer hold RTNL in fib_nl_dumprule()")
which causes half the regression.

But... I haven't figured out what causes the final half (or third
depending on how you look at it).

I've also spent quite a while trying to figure out what exactly is
going wrong in the python netlink parsing code.
The code leaves a *lot* to be desired...

Turns out it doesn't honour the nlmsghdr.length field of NLMSG_DONE
messages, so it only reads the header (16 bytes) instead of the kernel
generated 20=16+4 NULL bytes.  I'm not sure why those extra 4 bytes
are there, but they are... (anyone know?)
This results in a leftover 4 bytes, which then fail to parse as
another nlmsghdr (because it also effectively ignores that it's a DONE
and continues parsing).
Which explains the failure:
  TypeError: NLMsgHdr requires a bytes object of length 16, got 4

Fixing the parsing, results in things hanging, because we ignore the DONE.

Fixing that... causes more issues (or I'm still confused about how the
rest works, it's hard to follow, complicated by python's lack of types
and some apparently dead code).

Ultimately I think the right answer is to simply fix the horribly
broken netlink parser, which only ever worked by (more-or-less)
chance.  We have plenty of time (months) to fix it in time for the
next release of Android after 15/V, which will be the first one to
support a kernel newer than 6.6 LTS anyway.

Furthermore, the python netlink parser is only used in the test
framework, while the non-test code itself uses C++& java netlink
parsers (that I have not yet looked at) but is likely to either work
or contain entirely different classes of bugs ;-)

