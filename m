Return-Path: <netdev+bounces-198802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E6BADDDDD
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E0C17D924
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CCF2F0056;
	Tue, 17 Jun 2025 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRPcXb6/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548BD2F002C;
	Tue, 17 Jun 2025 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195423; cv=none; b=VordSDddkk0f49PTZDCgRXnMniQonVL8yQ6FKGzbxFFHgqJe+Bk5tCK22xXpwKweo2CvkXFYFFdmxksYFb4QUf+G+6FIID8JXiWr1RDRD1eLUpVc1cnIoYua/UK2cUX5JmPDapfIjazttpyU3Qos6LxZOLYBk5Yk536x4PuaytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195423; c=relaxed/simple;
	bh=xCaeqnGFURa4WE7ZGAQiMIxRYtRhwOv7fu5xpngpuHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+ARYKY7pYTWcgxC50UOV7WPwHGmQB+la8oVCkTwDOf94cBZdLzWJgo26qFx9EfKFnzOQKAh8lbhGzAjxeaL0/QWjHv3EjZPnwi9Fd/kR0jD14huUHDkJvjhvd1b6mnP1XdsL6QQBlRrAen+h4Wm84AniLtmzSSFO3hBSvVmaUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRPcXb6/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2353a2bc210so55404455ad.2;
        Tue, 17 Jun 2025 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750195416; x=1750800216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aS75VzdIUay76QJsK2VftduMxFyEPBUJ8MrlD9vVBg=;
        b=LRPcXb6/dATDFd5GZtbhOxAWiGpnLHScMZsWBMjo6JxGGEzW3Ij9akopnK1hYBzGiT
         JrPdHW8NUWyIniNFlh56tdIxGQTTqjtCGDbEh4pC+RFQZIMHMHck93L8dyu+6voHONA0
         sE0yyVdXUs/xQdHnHgAbLOuNdzz0fsR8O8FVEcLvvohWpqhW6ISl0nDrUuovvLkAAXmQ
         7FF6YF7gLDWgjg74Hhn2f9Xgg5jFxt4Tz6WvsjLwm9Z6Pxwq7xeZPjg6eUS5G5FBJzwC
         o272MZK1F2j3aK5Obg3LNBEo6dScMlICvPmeQ+xMDm5zdnddW5PwJt3hwe0fD5U8PqIB
         mYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195416; x=1750800216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aS75VzdIUay76QJsK2VftduMxFyEPBUJ8MrlD9vVBg=;
        b=Be2lyDOc6EHp/4xvhWm+KmGy2p31+8N/277/WSn6pPBxajVG2WBUwHklxIVkCj2iEi
         Z8M+cFC1mUPUIWDz26KM6Zhp5wiE9F7SPuJcsUJnjffwZw2nKBo3t9kHI8tIgyvyfimm
         6vNxPoo0fZP/fWd13MhtABn5YcoPwJgfnCEGMLRc/qkvlrqhYK8YvEDe05WPtPO63q2s
         hCXSkX+qT70iznwfA89OPvmDXynFjrS3YPB2zkBa7qhX1mGSzLU+MrGULClag6NU8iIn
         s7JQa/X5zGUYN5hKXAKijxryj8bIHuxHQXLobfnD/+7Bzvdvno0/kWWIz3oUUCi/Mazk
         s3wA==
X-Forwarded-Encrypted: i=1; AJvYcCUcySXnrcCE2/F/cV1hVk0MMv30G5/awx9RThSedrVVJKh7fujuzjHzmgjewEZuUWb4MKrcXll9@vger.kernel.org, AJvYcCUffizbbQlIR+5XVAeZnFkMbbGKFFSyFg0hhKx6nMhgARzw+LCmoDbq1s5yHSPotaI9Ac1BraptaYJ1cniCiVf2H6UsDBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3JZykYeGfOpN9imosmgIbuvjYuGRCHVwetYLPsv4r3+2wRYP4
	O8QMpVThmsZCh9j/cLv7Nu1/NwhQEtAXBmUYAFT/TSYpW8DfVTtVVfE=
X-Gm-Gg: ASbGncs5gVwiveF7X/5BdA9LwKvwR0KqHpIfsXL78LnqLfWyKRahZMGJEUTW+JPJY5w
	09EMNLAbhBYTjWUrQFnpQbTkfgcZYtTHSfo+UVe0z6XrQ1YF1t7zLuzJdhCmzY3Oa6Ax7LCbFX0
	JuR2Xm94J9ZX9+hzyXRgLMcsOCad23MLUgAi06lc5zqhXyrg1Op3elZXT8iTq1GCqs7wYBJinWU
	OpHNr9YthCo9TDbGsXgiC0SFZYwYmWUqm3S1dVDWkC9F2hdo13ZnwhwQapN0YWT2cWjd96p7aBJ
	2XKwne605vGKNeqU39Tf1ZVOwAbUgOly7RdLWu4=
X-Google-Smtp-Source: AGHT+IFHZ0ZWlFVwyZopd1xDHLBtbjq+QG30lwWa8nF+92idCEzGbE1SXnaJi7UyFS4DRU/i0m1k5Q==
X-Received: by 2002:a17:902:f68d:b0:234:8f5d:e3a4 with SMTP id d9443c01a7336-2366b32e4camr222408265ad.2.1750195416453;
        Tue, 17 Jun 2025 14:23:36 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23699a75d65sm12534805ad.91.2025.06.17.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:23:35 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: paul@paul-moore.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	huw@codeweavers.com,
	john.cs.hey@gmail.com,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@google.com,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller@googlegroups.com
Subject: Re: [PATCH v1 net] calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().
Date: Tue, 17 Jun 2025 14:22:36 -0700
Message-ID: <20250617212334.1910048-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAHC9VhTPymjNwkz9FHFHQbbRMgjMQT80zj1aT+3CFDVY=Eo5wg@mail.gmail.com>
References: <CAHC9VhTPymjNwkz9FHFHQbbRMgjMQT80zj1aT+3CFDVY=Eo5wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Jun 2025 17:04:18 -0400
> On Mon, Jun 16, 2025 at 1:26 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrote:
> >
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > syzkaller reported a null-ptr-deref in sock_omalloc() while allocating
> > a CALIPSO option.  [0]
> >
> > The NULL is of struct sock, which was fetched by sk_to_full_sk() in
> > calipso_req_setattr().
> >
> > Since commit a1a5344ddbe8 ("tcp: avoid two atomic ops for syncookies"),
> > reqsk->rsk_listener could be NULL when SYN Cookie is returned to its
> > client, as hinted by the leading SYN Cookie log.
> >
> > Here are 3 options to fix the bug:
> >
> >   1) Return 0 in calipso_req_setattr()
> >   2) Return an error in calipso_req_setattr()
> >   3) Alaways set rsk_listener
> >
> > 1) is no go as it bypasses LSM, but 2) effectively disables SYN Cookie
> > for CALIPSO.  3) is also no go as there have been many efforts to reduce
> > atomic ops and make TCP robust against DDoS.  See also commit 3b24d854cb35
> > ("tcp/dccp: do not touch listener sk_refcnt under synflood").
> >
> > As of the blamed commit, SYN Cookie already did not need refcounting,
> > and no one has stumbled on the bug for 9 years, so no CALIPSO user will
> > care about SYN Cookie.
> >
> > Let's return an error in calipso_req_setattr() and calipso_req_delattr()
> > in the SYN Cookie case.
> 
> I think that's reasonable, but I think it would be nice to have a
> quick comment right before the '!sk' checks to help people who may hit
> the CALIPSO/SYN-cookie issue in the future.  Maybe "/*
> tcp_syncookies=2 can result in sk == NULL */" ?

tcp_syncookies=1 enables SYN cookie and =2 forces it for every request.
I just used =2 to reproduce the issue without SYN flooding, so it would
be /* sk is NULL for SYN+ACK w/ SYN Cookie */

But I think no one will hit it (at least so for 9 years) and wonder why
because SYN could be dropped randomly under such a event.

