Return-Path: <netdev+bounces-171258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DA9A4C35E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A9C3A7B88
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CDA7DA93;
	Mon,  3 Mar 2025 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlCcpGBE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6B8CA5A
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012262; cv=none; b=Vs2RlIDxFxEQ8CL+X4xNJ7nRtvQECkNIlaNYIp5eD6fLnTIz01PaEDis/GZeF2gfgNxQgbaeFO4uB7BVrobu1reQZ68LGMOXquXYONYfIDj5pK3QuZuaS5MVCzLg/r6CgW8R0kRj0gO1fcIakENjgQq4+ytuRNZVEbpbgwE7hZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012262; c=relaxed/simple;
	bh=ZJKhQGEooGq39rnfsvpaIWYHgRiDneuKaSTO0NdW6gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkXTRrsB8mjZFS5pbiyiGLxfrb6hTa/azmNNWkiiqLuJLLDefwbaubIB/AUH/EA89E5JTjgLlO7SsyWJUi8y98NChPmvKpoeJ38EcYx17lQGpRIJ3KfjjQKcO5mzvK0L4UYGraNczaAyw1DbMHJqTZnqaNG2d0bzTTY/nIdlGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlCcpGBE; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-855a8c1ffe9so121623639f.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 06:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741012260; x=1741617060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJKhQGEooGq39rnfsvpaIWYHgRiDneuKaSTO0NdW6gc=;
        b=HlCcpGBE9B1GhRvqcKAjnfpVuFopbOYKTZ/XpYY/tq8V/sNPITY/4LE438ROt3jvuL
         lSlMzXJsIwGeL/jrG935vrvzZWYCfczoPKWkhsKUIAROT/C3uV2trwYY3sDeU4XC3Rgd
         JbxbrhJFGD0bgj3+JoEPCYzJegAF6ZmvPewbDB/8nCIIxG9PI/LrdEtW81hnlsXZnJaN
         QzMTvD23WsFx44vdGmPfJ/muTxQgt7MUwCxSjFtunrZPN0G5pgO+nRkkQ6cthOHZWx7p
         meOfr7haK8IYw4FIa3flS65ALrCMpF1DySEDfFIuZ/33gVEFwJP/69BEOJ3eUQ95akZ5
         AXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012260; x=1741617060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJKhQGEooGq39rnfsvpaIWYHgRiDneuKaSTO0NdW6gc=;
        b=PD9VOw3ggIb/zmzF3i739X5KqLI0Ej5j6WP2dC+5SVz77r6Kch7F8UUUxuhzFgIgYI
         UFa4AW02h6RpHLTC2HzdS6evup8hckvRPiV8MB0TyyFlEuhPlw5RGGODGX7J1gxtfhut
         nz5opUBKUkUx3vznt785LH3674WESFFVEp+SJwaDS65ryl+DanFhldVg9WTv5yVHz++X
         aEdtm5T9QW7BUyx+5j4RnY9BuilNKxxxQBvqi8TnvToMGWT124s6RY9JKCILNKKJp1Ij
         DNhC8XA6t4YeH874ECHcSJGIKcduJEd6Y1xDmw3ME+NgO5YF9zIa+L/JRSiTqKbSOEES
         VFaA==
X-Forwarded-Encrypted: i=1; AJvYcCXGe/fLXosgt9cCrN8loQjyZbJSzeAcAXTCdvP4HGg0pdrxQYDVqgcE+k7J3Gq4xGWcwaVZcCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0BB9yZ6wp+CfXQCRg2HZqj/HKFXTfFiud87qdTHv8uxn6kKu
	VY5cwtxUp3Fzl6vMWjlx7RCzAuXuk0CYWGPST4P6tz0NUCU7C0yUzeqWuqDnZUlAAaPZDy+KJ4g
	1bBiZsA0R1waKLWd+V1HXLx7r29Y=
X-Gm-Gg: ASbGncuuM9nozI/Pgo6vUb9LA+oKC473fnoiJRgZhZb3PwJp6Vys8zsfHFbjkt03nxf
	4n5bEcCt0LM3RJzLhd3ALlaP6tAGeRciMdX3yfPGnW0BopALyHNe84U4GUf3KFiWwOohfBwOwJQ
	TOChWFRJV4t07V5CwUtgYlVHzeIg==
X-Google-Smtp-Source: AGHT+IERy1dQr9CMHom5m2Ogbs+wm3IAjYpPApITUasj4RLHfGxFX5SJDUnkihQarDvtgCuP+lfMfhgvMfUujl3Uf1o=
X-Received: by 2002:a05:6e02:1705:b0:3d3:fdb8:17a7 with SMTP id
 e9e14a558f8ab-3d3fdb81a82mr45809105ab.6.1741012258995; Mon, 03 Mar 2025
 06:30:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228164904.47511-1-kerneljasonxing@gmail.com>
 <67c5111ae5754_170775294fe@willemb.c.googlers.com.notmuch>
 <CAL+tcoDg1mQ+7DtYNgYomum9o=gzwtrjedYf7VmHud54VfSynQ@mail.gmail.com> <67c5b3775ea69_1b832729461@willemb.c.googlers.com.notmuch>
In-Reply-To: <67c5b3775ea69_1b832729461@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Mar 2025 22:30:22 +0800
X-Gm-Features: AQ5f1JoAV-tIOEzDcZsYNYq7oWBaN6nsqRhYVXKuAqdT2yCbE6u5JOCrElC8VXs
Message-ID: <CAL+tcoCTddpJxx6uCo9b-7Qy=CpVW1YU=pO4S0pKniHsS9fSzg@mail.gmail.com>
Subject: Re: [PATCH net-next] net-timestamp: support TCP GSO case for a few
 missing flags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ncardwell@google.com, kuniyu@amazon.com, 
	dsahern@kernel.org, willemb@google.com, horms@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 9:49=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Mon, Mar 3, 2025 at 10:17=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > When I read through the TSO codes, I found out that we probably
> > > > miss initializing the tx_flags of last seg when TSO is turned
> > > > off,
> > >
> > > When falling back onto TCP GSO. Good catch.
> > >
> > > This is a fix, so should target net?
> >
> > After seeing your comment below, I'm not sure if the next version
> > targets the net branch because SKBTX_BPF flag is not in the net branch.
>
> HWTSTAMP is sufficient reason

Got it.

>
> > If target net-net tree, I would add the following:
> > Fixes: 6b98ec7e882af ("bpf: Add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback")
> > Fixes: 4ed2d765dfacc ("net-timestamp: TCP timestamping")
>
> Please only add one Fixes tag. In this case 4ed2d765dfacc

Okay, I will do it as you said.

Sorry to ask one more thing: should I mention SKBTX_BPF in the commit
message like "...SKBTX_BPF for now is only net-next material, but it
can be fixed by this patch as well"? I'm not sure if it's allowed to
say like that since we target the net branch.

Thanks,
Jason

