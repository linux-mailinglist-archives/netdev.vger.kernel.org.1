Return-Path: <netdev+bounces-246480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1909CECFDE
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 12:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59AD3300663D
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8E28FA91;
	Thu,  1 Jan 2026 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJkiDGaq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880113C0C
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767268626; cv=none; b=KsIw74BlRDG9baASKxR6ITG3alHDAkkJDW5jrmzoPKQGZzm4gvpV38trWT71Mxp5hvD74mq4a+SCm51p8Gra5fMtgv9l9yryW65aH9AFIP+5OkJyT/AZlUvDB/MM+pyHIgouFoXfWsH+az/iPeVVvr4rr3OZxA4/32FbpnsjYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767268626; c=relaxed/simple;
	bh=G2rhddGZVpfc7fSGFukzZzPWbmqRXvvAHelXhXgjCiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYXa6L2BIhuxO/MnKQsUYl/Dgp2unXozwBvBDf4MW0MJ0/OmUb2XvYXeHOqUm40CJ/IJYhNFi0GaGno516gK1BEjOdJmbLSqPcqNLF2F6zGTNUvAxFvOWANmymoyDMevrfp9D0QKq3uAbyv1GrLyCvS3x6JgmqquWgC0iLkD5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJkiDGaq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b7b737eddso14362821a12.1
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767268623; x=1767873423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tOCh1AYIsSHgQf1TBlgltjmRG6ChQgBGDoVHtYBbniM=;
        b=RJkiDGaqZqEQ4aldtxBpxjN7In9yhlUjPnR+s6fQYLg7IJqIjqgcsLqdMastkeZ73k
         Jm9MalZo9qffCf22SHY/ZKijCgJ+GF2ghBqA29TeWClpUEFo4OxrG42k1uiGturQ1Jza
         o5QtakV+AGRTmLPl57j0HQXU6zEhGGAt0uHOpjh8RtULMLGU4MCWW7RqPWW4pdIts7Rm
         8mpqhw4wqTRKUIVRtc4P6oojzPhuLTi8VKq3nlgBgJ59mqTjXRtJgnhxm5Vj6G0wwXvi
         FCRu+DkTi7eyHyzFvbVsT3cyWTmOJg0bhUjfkH0VzahI0u929hkqtZSSusIQ7F30wzG/
         pE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767268623; x=1767873423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOCh1AYIsSHgQf1TBlgltjmRG6ChQgBGDoVHtYBbniM=;
        b=Xozhe9pPVp0I0R8T9LJXIKEdI0ah/n2z/CQidXG/II2Fc6LQB4dM0OZfAksBOMc/hS
         erOJakNsbO3oG+RzeyKGfmMahiKDow3/aVhpu9l8AMRRtlLNAO3vN5czRW1yEEqczIcR
         vafz+qE71kA6Xwgw2KaXhRK+4uUFwUnyi9z63M9e1KSEpUzQBMVSqQiJR+ijboh5t0zb
         jF/QXYJQuxK88RxUmUg8dZPiRMoTrM2QkjiOrkGaxl89Q8m25NvTl16WEkgInLjYkqeC
         rIjBcFTkHoObJJII40eQKwBwfSU8EBQpjHuuQPU3d2b/2R6oXjH0hJ9bEOaKwc2yAzit
         aQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCXZY169O8IEGrThA+16X6U+a0oAtyhv8Jvf9Sr/ha09wFjkp/lt/xPKo2pGQ3ZygOHaIb/rawY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNh90tfWuD1j5cSek0VF+rzhEsDgIE2l4NG54DQ5D3hsicKUQ
	ChcksJq4LJnY76YsHPT+y3mTT9k+Es6iQfaDNF0+TxqjoWyQhJga8Frv
X-Gm-Gg: AY/fxX4TQJZ4rsbRVPLv6wiYH57EDVnlregyxwobaK1xNs5DoR2M9E32R+qbQR2olnI
	d+wh6E5asXOn8caa0Jj/YFZUJLBtQy7d9FAiED25JM+sN1OcRHLY7M1wf0rbwZSSMCj8oJqR+2j
	G7vIPiokPxcURliwotfFYVkHtlVO9hyqmzOSPTRM9iiNUl3MWvLagf3A6bMJ0Gs8rcLz8/bUfFt
	fQ92OxmtzYZHjKxYF0joSQM+nDsr18YQPo08e1FchOk9KMW0K+siqjfD04U2aUeWJKTWfDpds1b
	OdEKQx74PyM2SJMYss9FddAbw7uevgE4e2v9aQGllB/lzpjSDEbFJP/8gkm7jz5stJ2p+7HTjPW
	aSBgWCrARBjJYpqR59C0GRB8c5hsqfI70gFM+M8Y2mMmsiUb16/egJRAhXrXesGbm+PC1It6dbD
	a2ynhXHKbtVqHCtcCy8kQ1kOIeKJF0UOmDkIog
X-Google-Smtp-Source: AGHT+IHQ+roj6G+fwaY9C50POuuTNn9OM4QtTiSv3F0ezk9cK0kujONP1nzZ4oyO4PBGT3ASgLWw1w==
X-Received: by 2002:a05:6402:1d4b:b0:64b:7dd2:6b9d with SMTP id 4fb4d7f45d1cf-64b8eb738abmr35662187a12.8.1767268622634;
        Thu, 01 Jan 2026 03:57:02 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105b31esm39838789a12.13.2026.01.01.03.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 03:57:02 -0800 (PST)
Date: Thu, 1 Jan 2026 12:56:50 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>,
	Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
Message-ID: <20260101.c5abb78cd634@gnoack.org>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251231213314.2979118-1-utilityemal77@gmail.com>

Thank you for sending this, Justin!

Paul: Could you please have a look at this new LSM hook? -- it extends
the LSM interface and it is an approach that I have suggested in [1].

On Wed, Dec 31, 2025 at 04:33:13PM -0500, Justin Suess wrote:
> Hi,
> 
> This patch introduces a new LSM hook unix_path_connect.
> 
> The idea for this patch and the hook came from Günther Noack, who
> is cc'd. Much credit to him for the idea and discussion.
> 
> This patch is based on the lsm next branch.
> 
> Motivation
> ---
> 
> For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> identifying object from a policy perspective is the path passed to
> connect(2). However, this operation currently restricts LSMs that rely
> on VFS-based mediation, because the pathname resolved during connect()
> is not preserved in a form visible to existing hooks before connection
> establishment. As a result, LSMs such as Landlock cannot currently
> restrict connections to named UNIX domain sockets by their VFS path.
> 
> This gap has been discussed previously (e.g. in the context of Landlock's
> path-based access controls). [1] [2]

+1

The use case here is that Landlock should be able to restrict
connect() to named Unix sockets and control this based on the natural
identifier for named Unix sockets -- the path of the socket file.

This feature is a useful and necessary addition to Landlock.  The
discussion that Tingmao Wang linked to on her patch also shows that
users are caught by surprise when they find that connecting to UNIX
sockets is not restrictable [2].  Her patch set [3] lists some ways in
which this can be a problem.


I understand that adding LSM hooks might be controversial, but I think
that the alternatives to the new LSM hook are both worse:

* The patch set from Tingmao Wang at [3] is not restricting Unix
  sockets based on path, but on Landlock policy scope (domain).  This
  is useful, but only complementary to a path-based restriction.  If
  be build both features at some point, they'd potentially have
  surprising interactions that make the UAPI more confusing.  (I've
  written more about this at [4])

* We can not use the existing security_socket_connect() hook for this,
  because the resolved struct path has already been discarded by the
  time when security_socket_connect() is called, and looking up the
  struct path again would create a TOCTOU race condition.
    
  The hook is called from the function unix_find_bsd() in the AF_UNIX
  implementation, which looks up the struct path and keeps it
  transiently in order to find the associated listening-side struct
  sock.


Please let us know what you think!

Thanks!
–Günther


[1] https://github.com/landlock-lsm/linux/issues/36#issuecomment-3669080619
[2] https://spectrum-os.org/lists/archives/spectrum-devel/00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com/
[3] https://lore.kernel.org/all/cover.1767115163.git.m@maowtm.org/
[4] https://lore.kernel.org/all/20251230.bcae69888454@gnoack.org/


