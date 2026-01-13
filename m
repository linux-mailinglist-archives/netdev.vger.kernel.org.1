Return-Path: <netdev+bounces-249575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A54C8D1B1DC
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 363003016CEA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312C36A010;
	Tue, 13 Jan 2026 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="YPLNkRO3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FE03570CF
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768334082; cv=none; b=LoLJFS0/Y+9EP/HKLDLAIuafU6Ys0WkKMNH/qcIlPrecP8VNEXUgqJH5vDU9g+ibr4aw49WKfERn0skaL3xXf0rIOj1+OkTFwOtMPB+mGne/lhytfl54rltbNgeeL6/YtByDaP/+PF+5YlyNZqjcs8/79hKVSYu7IZlsaVHTlWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768334082; c=relaxed/simple;
	bh=YdW2q0GpO4EHX0WhRe6b4HjMfoeWHSyAzK/rRaAABi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgwLiesXZLXu0F7ggSbUrK9abZGO95VEtGdLCWkk8qKw43yNP+dFtPa6Bm4oYBtOxMLphmhLvydCK774lAhJ5gcTs8lzbAH39e/aCz7xOxuSRsCCNsvwAdYynHOdy1i9tMOXUuPwRrIiGS3n8GXpWPzFoE6jkundC/OYbF9Q8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=YPLNkRO3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-383247376a4so36329681fa.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1768334079; x=1768938879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIoy/FVe88F+06EGG091rXbZFZp4KaZzIOjxCBl2QNU=;
        b=YPLNkRO3Dehzy2C0oa21msgRqhgDjP6Xx3AkyXtlvQKv+cJSSUD5HQMehG2jTYakQ7
         xrBllLxO86+gKFSXGJjsK/3Cgu6jxO+v/oUPUkVLzUvG+ddry7YHmUfpTZz1mHrp+QlX
         Fd5D8qnX0o0KPa20pufZel3G80pM19nRuQw5kMlYKZZCLhWSeI0+dudBy2g0GEBaecJm
         kCe4PxZz+Ubh7vg+rFp9qHBohhIwuED1ejvX9RQfpOMg4Td/iwF86llyP42F1SyrdUxN
         Pef2moA6IsYrlzceEwjd5f29MA7B+veTRI70HuPCm7McJBH6iRVTqBCJTX/NDx6GJZHV
         qzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768334079; x=1768938879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IIoy/FVe88F+06EGG091rXbZFZp4KaZzIOjxCBl2QNU=;
        b=kAtkoNU6MCsoNBhKTb/zP2kPf1EJAXIQsrX2+zeRZQlb3GOih0CdPqARljTV6u5iXS
         pwZLpuMjjRxE/s2lEYFxQPU6uC3mEAyBae0a5LjeUn9Yiha7jToFrzSz3UFuVRxLfAjq
         OwGmS00ogm4JpUGVEUW5Wx7gW0dmgDvNhjm7DXQXwegzUuBoob+Z4CZR+cFxy+DY/dDk
         hG1soOYx2uRwRJOGu+g/2VSFVB3kUQLedKR4uN83LUJRFeK//Wxii7YoZfVXnn7n+tLs
         VmoZ0b8/bDiGa/pAGo7CNwiBfhVmEmZtcz+Qdw+1lGolCEHGeKmOWVU9QeGFxbVtDZqI
         vzNg==
X-Forwarded-Encrypted: i=1; AJvYcCWF9K3cYDbRVl0THAKeGWTK1EFnbiVDTzeilWCNyuethvLWe0fvEaGxTxa2jloz3v98FlFQ3DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR/8Ks0srm7lJmTT0Swy51pj/6U85BemN2RwJDi5WsHysscM53
	7jJPFfsqliQwMdbq/eZjrM3kNV+YdTQuG/es2s5CYw2dBgAhHhBoC71oTDlYSUnoA6zyBGgJq0A
	Pvi9Jqxctv2y/kgaJmZ77hTr07v2syGvUUbOWkMEcQ9nS6b1NWtx40g==
X-Gm-Gg: AY/fxX4k35mgmVCnWJ8KCV7urz3n2LnrSbhDFReVNc/GsCI82LLj5tpDiAe7cFVsEn2
	8rHPbZCSxjlwx/WtlGfheueVATjkRJYtJYF5YOPGu5Kk2g8AQbvZ5NVF0+PAi0+/tWZXvVCMpg6
	GGRyI7eGAj8f9mEs+FimM3yrm76ZMXcSBbTip55ss04x0rpWMys6I0rzM2StY+K2dAlcXjg6kPz
	iLiPOdnA28J8TkJ403FYcPDZZ3W++OKiJoDyust4p2c9o0iV9HDGK+1cPFxSOQ3uadE+a3Y1asl
	OfoW6+oaQDX/chNnuw2zqoW/tnO+BBh5y6Bpl1mjciO2gZ0ik6bT8ljNg++G
X-Received: by 2002:a2e:bc1d:0:b0:383:1737:5ae1 with SMTP id
 38308e7fff4ca-383606c207cmr760461fa.11.1768334078904; Tue, 13 Jan 2026
 11:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108171456.47519-1-tom@herbertland.com> <20260109115015.727c7e9e@kernel.org>
In-Reply-To: <20260109115015.727c7e9e@kernel.org>
From: Tom Herbert <tom@herbertland.com>
Date: Tue, 13 Jan 2026 11:54:26 -0800
X-Gm-Features: AZwV_QgIKeAH8yz7acGLRvA3u1Gx-zA8ckufMopKOvwiH9oKaZ4eUgRk8r3UUB0
Message-ID: <CALx6S36qzL2etxrTgEn5XurzvKfnPneAG25z5kebsbtVc7c9wQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/4] ipv6: Disable IPv6 Destination Options RX
 processing by default
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 11:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu,  8 Jan 2026 09:14:52 -0800 Tom Herbert wrote:
> > This patchset set changes the interpretation of the Destination Options
> > and Hop-by-Hop Options sysctl limits, net.ipv6.max_dst_opts_number and
> > net.ipv6.max_dst_opts_number to mean that when the sysctl is zero
> > processing of the associated extension header is disabled such that
> > packets received with the extension header are dropped.
>
> Hi Tom!
>
> Unfortunately, this breaks GRE:
> https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-202=
6-01-09--18-00&pw-n=3D0&pass=3D0

Jakub,

There's a hidden Destination Option used by GREv6 in
IPV6_TLV_TNL_ENCAP_LIMIT (not defined with the other TLVs and not
processed in the main TLV loop). So probably can't disable Destination
options by default. I'll respin the patch set to restrict EH as much
as possible to avoid DoS.

Tom

