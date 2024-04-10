Return-Path: <netdev+bounces-86683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5E89FE9A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE061C21583
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8617BB2F;
	Wed, 10 Apr 2024 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhCmNOGU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C017BB11
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770452; cv=none; b=qAe2E5STSgnlwO0sy+r2zrFMRLUNjql38QUgqp7kaqr+DowYc/DRBYNr25DElS6hvgWbHph6XVpe0ogIJf6rNUOFuwFFjmXF4NMStcoDFVwpXrct9Q7R+EpiQ71lWyVjcB0J9fjuz2dxOg6fQ/Q54kcIW/d2cErouzBl3a3gH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770452; c=relaxed/simple;
	bh=JdPYH8zXzJjCy+9t2t002gX792kNQ6LJClxLBlf8XAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioDfjyFnKCSN6Jf9HhE/v9+3u9bVtktEbmMFGRxpSG1HMQW7stBCQgKTTfSTGtErtA3lK6OBkb/42j0laAAamZ0miVmv4EXK087u93/lecWVR+MBvy9mWziVkoPP4I8ZN1hct2CRhwU/slth1IPHSsAKWMwX5jnKnG+cq7YAemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RhCmNOGU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so856a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712770448; x=1713375248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24S3Bg+rcESNRT2cXFvXR7bglB21qtrQn/+dYIrwVcs=;
        b=RhCmNOGUUFBHOcQnr725lGqAM5NsB802AZ3u02MWvEbmKqtx8YJ1+7ruUPFFeTnQUO
         wjQufY3CKLQe4NLy74is/4f/K94FbkrRwy+6gsdZnV+dPlmRVbp2mmn4bbDrURTskTBl
         pxklmXytXCE4yCxFOm5xNIcTW9NDq1u27f5SCAmhlFGoUOo6gvhVRejgf07LbJs8wZcL
         7ErRZGl0D8Bd3qpnQIa18nZ4N8DqXoWwkCffycmzF9twdbwLM6DRpJgxGuo0t2IbBSSu
         f1veo85v9QhEmXpflP8HwFEwueaLIXegM5Pja5vhT4zPgtOX9xfNV9LrNn9qxGLV72Gv
         92ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712770448; x=1713375248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24S3Bg+rcESNRT2cXFvXR7bglB21qtrQn/+dYIrwVcs=;
        b=AM6T9Y403liKRW+DeR2n2uWBbk0nB/Yu/Km+QHdAusofmw0XSLCc8y/kHKEyxKCTac
         RmBcv3zsv65DLyEjn9VtgrxxnQ2UmcYVqIV16MJ0od96XCK0QgEPsgDosf6nd3PyldW0
         HmlzLqwPrEHMZu37TTukcXLnBe1PyLKZMgQDPvi/qQ1hUegx9tpnVD4+dtua+6w2gZN2
         htm6oRuZNFb2QduakECZlBSyiF4os99EgnJs+Wa85KqSZ5kofdtTEWGpodxo4jTwybLo
         5Rjs3j4d9yw2ciogibFnehFvNPWVmrVFlq78vnC7TLlnwP5MmZE25uB2dgyMf2LimhMy
         D0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUwgYvGL5kqIHTOso8CFtRt0WTcaHO/2hXkMmp1Xif0L17mu4jfvMfPTi1ECLqLulNsU4FnHmMmDds1I1MnY4C8TYCNUxr
X-Gm-Message-State: AOJu0YzKusniTbdXlAo2QDiw7bSqfrmfxcwvBMk9bqrRUW5sH23BD4BE
	v1mH38LRuWPgYS3e3IrrlcQFADLV+X9R5kgqeWXxVcdfWOG6vogAJ1WipFCSXqi4HLnxUEujPoT
	aHLIe+PJZ9iNHWBA5I+aO3NNnGvAC7usai0Kh
X-Google-Smtp-Source: AGHT+IHwKZj9oiU3oRdw6YKYrDV891dVli+TzPT9xQvC/me3PFqdqWwwMbeMDWlvcwENE3/ToQALhQMOxXDDEn4giRA=
X-Received: by 2002:aa7:d753:0:b0:56f:ce8d:8f9 with SMTP id
 a19-20020aa7d753000000b0056fce8d08f9mr167166eds.3.1712770448176; Wed, 10 Apr
 2024 10:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404082207.HCEdQhUO-lkp@intel.com> <20240408230632.5ml3amaztr5soyfs@skbuf>
 <CANn89iJ8EcqiF8YCPhDxcp5t79J1RLzTh6GHHgAxbTXbC+etRA@mail.gmail.com> <db4d4a48-b581-4060-b611-996543336cd2@gmail.com>
In-Reply-To: <db4d4a48-b581-4060-b611-996543336cd2@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Apr 2024 19:33:54 +0200
Message-ID: <CANn89iJMirOe=TqMZ=J8mFLNQLDV=wzL4jOf9==Zkv7L2U5jcQ@mail.gmail.com>
Subject: Re: [net-next:main 26/50] net/ipv4/tcp.c:4673:2: error: call to
 '__compiletime_assert_1030' declared with 'error' attribute: BUILD_BUG_ON
 failed: offsetof(struct tcp_sock, __cacheline_group_end__tcp_sock_write_txrx)
 - offsetofend(struct tcp_sock, __cacheline_group_begin__tcp_sock_...
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 7:28=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
>
>
> On 4/8/2024 10:08 PM, Eric Dumazet wrote:
> > On Tue, Apr 9, 2024 at 1:06=E2=80=AFAM Vladimir Oltean <olteanv@gmail.c=
om> wrote:
> >>
> >> Hi Eric,
> >>
> >> On Mon, Apr 08, 2024 at 10:49:35PM +0800, kernel test robot wrote:
> >>>>> net/ipv4/tcp.c:4673:2: error: call to '__compiletime_assert_1030' d=
eclared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct tcp_so=
ck, __cacheline_group_end__tcp_sock_write_txrx) - offsetofend(struct tcp_so=
ck, __cacheline_group_begin__tcp_sock_write_txrx) > 92
> >>>> 4673                CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp=
_sock_write_txrx, 92);
> >>
> >> I can confirm the same compile time assertion with an armv7 gcc 7.3.1 =
compiler.
> >> If I revert commit 86dad9aebd0d ("Revert "tcp: more struct tcp_sock ad=
justments")
> >> it goes away.
> >>
> >> Before the change (actually with it reverted), I can see that the
> >> tcp_sock_write_txrx cacheline group begins at offset 1821 with a 3 byt=
e
> >> hole, and ends at offset 1897 (it has 76 bytes).
> >
> >
> > ...
> >
> >> It gained 20 bytes in the change. Most notably, it gained a 4 byte hol=
e
> >> between pred_flags and tcp_clock_cache.
> >>
> >> I haven't followed the development of these optimizations, and I tried=
 a
> >> few trivial things, some of which didn't work, and some of which did.
> >> Of those that worked, the most notable one was letting the 2 u64 field=
s,
> >> tcp_clock_cache and tcp_mstamp, be the first members of the group, and
> >> moving the __be32 pred_flags right below them.
> >>
> >> Obviously my level of confidence in the fix is quite low, so it would =
be
> >> great if you could cast an expert eye onto this.
> >
> > I am on it, do not worry, thanks !
>
> Also just got hit by this on an ARMv7 build configuration as well.
>
> Jakub, I do not see a 32-bit build in the various checks being run for a
> patch, could you add one, if nothing else a i386 build and a
> multi_v7_defconfig build would get us a good build coverage.

i386 build was just fine for me.

