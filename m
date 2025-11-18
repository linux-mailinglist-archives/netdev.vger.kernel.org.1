Return-Path: <netdev+bounces-239365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E55FC67393
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31F784EEF34
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98F228727D;
	Tue, 18 Nov 2025 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYAzpzeI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C626F289
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439073; cv=none; b=MYsVh6z6q+YD5cWnDhps5WbIFN8bcX9MzXxF2cG86FBD9sTcLvPDyig7POkpAA1wzeytowx/niBDauSAhaE03XcqV1GcsUiUidR/vEKM/9qHPFwSbPg4D87FNhF9vyPNWTuwqECMtYFMdve5CFIOgjACAJrHpD3e0+NwXtE3p1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439073; c=relaxed/simple;
	bh=tjr9KH+lV8CoCrbY17LnLiECgJOfMmNqkT7+0mCumt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKYCYBTLqy/uVbqYwOz1RLirYK118BUsvrIVuoo4byBZ9psTSH0HjLRmx8AuFddL+yUPbG/7BzqA0lCrrmC/NJJHF/kPCJQ60sxbUMeJcYPLOiBIoFB/Dp1yEFYVMKddP0xwF5bQr6kupO3lPeAKBucfzhaNnU7Prfugee7bFto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYAzpzeI; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso2984164a12.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 20:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763439071; x=1764043871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6aW2bgs0VZ9MjhNhRHMxTtnMpl6CGOiKmZw1mi570M=;
        b=RYAzpzeInZAjv+THTKE4HdRGS/H+uQ1G9NNW4bJUO5Vo6c7zfyWYIWMKmRY3eWmFp9
         qXAK3Ux/qxu2bth6MbKtCTf7hHwN8yvwAjARfzGgLE0u42IHaU45R0kIODlyMujTGQfB
         T4PzDsIIoXWM8QsnEQVpisYOnGAqRLl7vqZYXKqqmkht4ehcU2wSZZKqtBG4RYrSJ+45
         /v7pyA8WaYycaYuFb/w/w7Qmnj8NzVBQkYkNyj7MJ6APiHEh37zA4K8tKtndkhc1n1ll
         +kbNQqUcU/278K7iEbULJfb+QSCX7SBK7Ylsm9FcqHY0BNgoIpgfSIYV2yGPML4KG6p+
         njdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763439071; x=1764043871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6aW2bgs0VZ9MjhNhRHMxTtnMpl6CGOiKmZw1mi570M=;
        b=RS2eCBjv6Dxmj4c8ZPnIPiKaMgo6Jab2MEBLUyV4rGjv/ySrSWJjpBKo45jHtD8BpF
         DuxX9ybPp6S735Kb02psnn2UQb9S47O0gl+BmrrbezTh2ca6YrIQbiYd1DYCYl9uh5DB
         7nYU/xRhlC2vg5XUCq0oeR+fqmIxr9s+v/OtciOL7VDnLAn0MclFsXKY0HSqjJha2Nkl
         QqDGjpT2KaHEoqBeoUZ5v5dSwIOSf+l/iiTluSIqN7Fn2ydL/+4PXYu0COrJ+QddE1vW
         ARWGH3HhCydaI3lVm/SzlfmTyKYt3nn32dhZpfiUPeK50e5bvxIYrucfQs0bLo3Ehn8/
         CLrA==
X-Forwarded-Encrypted: i=1; AJvYcCWx638zxa9uU7zvGjw9ojlNIfe/LqEWIkzcaFFLT7GNieayCfqZoB8Npp6TRDJHPCf7OaguGIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGg1FP+KBpOLoA40CwI1Lzaw3HPVsblzPrRXftjvigSYKTHwpK
	FbsnLW3T0pChN7r25mIJDBSc+aQcAh+VUptuJSfbxQ1pTBcqUZWY/b6qV0SUFZZU2KGMSrs80Jt
	VgdC2qwan/U/ozY4XCtioxiP72uE97CfcUJuovXO8
X-Gm-Gg: ASbGncvWM0B6guuOoPHugS7N5D27rL6CAYDV2wC33xqz1csd0UIdZSMCa9ZffwmbdEh
	6h9ARrBhijJxixZLj7k6MwNY53oU/m/BXhF7809l1qfel8LsRE/fh4yWxgT6PTwhBXCOPK+6f+7
	viYBBbh25cf1dwi1b7ueMpQJypkoDvEiNGcxgIuSngO5pVs6jzBCJETdjkUolGL7a2QEUcDZ+Gf
	fV5hGvE4FCyQPbLQOhVbXufdYbHHMPpaSQ3olufXMGUuORRURYbosbtZlyYgSLKcOYMlLVn6hFl
	IAdtNzcRVGuBB+2A5usR57SeLaQ=
X-Google-Smtp-Source: AGHT+IFC7ApQOa5umCADINIo56Fk+Xt/J7jMhqfgrm7R1ivI4CvNbMGdmQi9206JuGBBNYxBZiFzARTFSXw4Hp1iykU=
X-Received: by 2002:a05:7022:6b8c:b0:119:e56b:989d with SMTP id
 a92af1059eb24-11b40f837ffmr6431312c88.4.1763439070841; Mon, 17 Nov 2025
 20:11:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117174740.3684604-1-kuniyu@google.com> <20251117174740.3684604-3-kuniyu@google.com>
 <7B657CC7-B5CA-46D2-8A4B-8AB5FB83C6DA@gmail.com>
In-Reply-To: <7B657CC7-B5CA-46D2-8A4B-8AB5FB83C6DA@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 17 Nov 2025 20:10:59 -0800
X-Gm-Features: AWmQ_bnpR1Bwpls7u_tbkLSN8WNogfDspeovD8H7PBQXNvcH-JSHM8WwuoROMQs
Message-ID: <CAAVpQUBAKi+78aV2q4H2z8AVku4DGmsV-43UkksGV8kWEaauxg@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] selftest: af_unix: Add test for SO_PEEK_OFF.
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Aaron Conole <aconole@bytheb.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 3:10=E2=80=AFPM Miao Wang <shankerwangmiao@gmail.co=
m> wrote:
>
>
> > 2025=E5=B9=B411=E6=9C=8818=E6=97=A5 01:47=EF=BC=8CKuniyuki Iwashima <ku=
niyu@google.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > The test covers various cases to verify SO_PEEK_OFF behaviour
> > for all AF_UNIX socket types.
> >
> > two_chunks_blocking and two_chunks_overlap_blocking reproduce
> > the issue mentioned in the previous patch.
> >
> > Without the patch, the two tests fail:
> >
> >  #  RUN           so_peek_off.stream.two_chunks_blocking ...
> >  # so_peek_off.c:121:two_chunks_blocking:Expected 'bbbb' =3D=3D 'aaaabb=
bb'.
> >  # two_chunks_blocking: Test terminated by assertion
> >  #          FAIL  so_peek_off.stream.two_chunks_blocking
> >  not ok 3 so_peek_off.stream.two_chunks_blocking
> >
> >  #  RUN           so_peek_off.stream.two_chunks_overlap_blocking ...
> >  # so_peek_off.c:159:two_chunks_overlap_blocking:Expected 'bbbb' =3D=3D=
 'aaaabbbb'.
> >  # two_chunks_overlap_blocking: Test terminated by assertion
> >  #          FAIL  so_peek_off.stream.two_chunks_overlap_blocking
> >  not ok 5 so_peek_off.stream.two_chunks_overlap_blocking
> >
> > With the patch, all tests pass:
> >
> >  # PASSED: 15 / 15 tests passed.
> >  # Totals: pass:15 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > tools/testing/selftests/net/.gitignore        |   1 +
> > tools/testing/selftests/net/af_unix/Makefile  |   1 +
> > .../selftests/net/af_unix/so_peek_off.c       | 162 ++++++++++++++++++
> > 3 files changed, 164 insertions(+)
> > create mode 100644 tools/testing/selftests/net/af_unix/so_peek_off.c
> >
>
> Hi,
>
> Many thanks for your patch. I wonder if at the end of each
> test, a normal recv() without MGS_PEEK can be called to check
> if it can receive all the content in the receiving buffer and
> check if SO_PEEK_OFF becomes back to zero.

I'd keep this for now as it covers the fix in the previous patch.
We could add more tests in net-next if we want.

Thanks!

