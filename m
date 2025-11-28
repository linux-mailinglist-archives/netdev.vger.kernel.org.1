Return-Path: <netdev+bounces-242503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEC9C90FBD
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 07:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8968342BB7
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 06:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8FB2C375A;
	Fri, 28 Nov 2025 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXrAgU/g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jdp962xJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D755264619
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764311956; cv=none; b=K0Kr39msQ5Gu5NfHNYf8ZgAxyfI1SD4tz6axTKw/B1+xTqAkU+v+yVIQI+6mwtf/zmOlExY7nXnebhWE71I5F41Ex1XXrrcjlHk8fBaQLPecLanTQmsK+CvyvWNCzFx6NUDMrvhBEkJQwEdNcMcqtVJRrGUNIBarESpV175Wptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764311956; c=relaxed/simple;
	bh=dGBV6+kLJM1o6JBPqWSncI8381JwVJvpxDPD6tLRodU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPZgxY3/W7g/pR/aGusMVkpeFSoxhR0vbMCOzS0ji/r6GIqwvaYEJFDIctf2EQErv/27w+AVwMFvl5I5A3v9cfGf1a7LyvJn9bAdb3xnOuhFp+NbjzkDP4s0cWIavyfK7lISsPO70n5lNTn3qbY17xl/B0V9iEnmpooXChZi8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXrAgU/g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jdp962xJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764311953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGBV6+kLJM1o6JBPqWSncI8381JwVJvpxDPD6tLRodU=;
	b=HXrAgU/g2/wy26Otu3kAMEoW8I6w78LDsZXSnrcl8PTtiSWLcy1paSWA+j035IFvNu4Gt9
	VdGRjYt/yNs2YGbP1suZu8HJyrizolhqW8izL0E7tFVKtq2L7znTTpQeqDRzgXDDYTft1M
	TJMjMRY1RdDART4VnV38CNaGDIf3Io8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-0sz6VXhAO5Gb2KebhDgPOQ-1; Fri, 28 Nov 2025 01:39:10 -0500
X-MC-Unique: 0sz6VXhAO5Gb2KebhDgPOQ-1
X-Mimecast-MFC-AGG-ID: 0sz6VXhAO5Gb2KebhDgPOQ_1764311950
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-640c4609713so1912940a12.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 22:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764311949; x=1764916749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGBV6+kLJM1o6JBPqWSncI8381JwVJvpxDPD6tLRodU=;
        b=jdp962xJX7Wdfbzkl4qU+SKPI4PrIRtJg5cYLptc4xdeZlKF+1S+dy2NmuglzLrV4E
         2KjJ1odiyjOb4z0eFq+2gHYyihBDLZbYsTNp+eRbV77oPwYhU0UjdgipCbIs5CRuFA5X
         azfQMP5lcuGAdF0/OiCOZa+W2OhD2bXfMAgot1kxngUM+pWYly0AWNyXU40TVZUHWQoY
         AQWhnxD8loAx4xyitlkRWNcnhhI0QD14ml8gzyBfa9bzfn9kzHNcznAjOPwNB4Ye0Zbh
         7Ra2Ysmwi9BWrd7Rq2reHHCkSFhIbyDtvNtIxzB3Lhqt9/uc4hiCS1kKgCxfYZQkWnvo
         sNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764311949; x=1764916749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGBV6+kLJM1o6JBPqWSncI8381JwVJvpxDPD6tLRodU=;
        b=Z+4iEZM5WLc/uLFsf2j8cC0x9JWSDB1hFff0zPSOsedSnVTmjqxyRLZ8tP/TAuyUBH
         Q+dWBETCGOGt9dBs/iGaVITO2YfASF0vFy6pvW4v9dTdD4HavZgaHedz7mb13ZQrQ0J8
         KqNXYx3NbsYHJxpnkKRBHUoKtDx9ckB9QusgGslZWO4PbR5OsRbXuBEjc5EVC6C4qXeo
         NOHFss0ctUoklgpL/Df591eEdWmmvtBEiNu1G1f8qU9Zx0qYsEa3JBrHH2pr+MNa1Nba
         Mli8ERfe1kxoA0LapPth3R3/+PeGbwDNzz5WbDXtzkWhDp69SXdw+6RAInowPswdg3nf
         7vAQ==
X-Gm-Message-State: AOJu0YwiBpaT0h5XjNFhUhsgydsZlfviONsWixqZgaYZrByquRmKejgo
	nIeQ8GMKbLtFtCDr4o34eOJEwlPwMD1+Uwgkw7qLlCJtTC9Wk19ePOvAplAPahf+LsNDhyBKKiW
	j6qC9kl9QEuNMTR5xw3OiUPP3nP1e6GDyJ/5f7oJ7SRF3saLlbxBbunDrP3aQnAIjRRlAVNrRP2
	zI/+snXLk5Ns6RIQAvEmz55ySQlqHE6f2D
X-Gm-Gg: ASbGncsAhxmaJjGdPfidB3iBugNyi5bYKJOy5kxR4OhrFNLRPIxwVknigmp9p+MThvS
	s0WRnnVlme54T8VaJuaJI9PvjG3acCZ4RVB4IWfGPXwL1yZrEJyVROQXUXP6HiFq/aNdHAIlC9T
	kte9weP3XVEN9EA8l+A+mnv0uox8vJ1EYQbEjeMxxqNesVH1iWqngPP7Ds2hRdwcmdP4A=
X-Received: by 2002:a05:6402:24d4:b0:647:550a:2f3a with SMTP id 4fb4d7f45d1cf-647550a2f6dmr1906446a12.5.1764311949632;
        Thu, 27 Nov 2025 22:39:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/dBoSdev4vqHRcj5jp5tId81DFREdXtEMbpvydMpyro0wfzJvvPCDXBSz3/hVtgNkEb/DPqj59N5uV19OVwc=
X-Received: by 2002:a05:6402:24d4:b0:647:550a:2f3a with SMTP id
 4fb4d7f45d1cf-647550a2f6dmr1906437a12.5.1764311949169; Thu, 27 Nov 2025
 22:39:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126083714.115172-1-yuhuang@redhat.com> <20251126065818.581b2c9b@kernel.org>
In-Reply-To: <20251126065818.581b2c9b@kernel.org>
From: Yumei Huang <yuhuang@redhat.com>
Date: Fri, 28 Nov 2025 14:38:58 +0800
X-Gm-Features: AWmQ_bkmMtx6GXawwhZS2f5Iaxgf5iNKQYaqerTIIIgpDG0zqxJCXQUl1M47yqk
Message-ID: <CANsz47=_bwrHa-RChtbZyBTJxrM8MtCtrJm_x-gRUaw2Ndr_yw@mail.gmail.com>
Subject: Re: [PATCH] ipv6: preserve insertion order for same-scope addresses
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, 
	david@gibson.dropbear.id.au, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 10:58=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 26 Nov 2025 16:37:14 +0800 Yumei Huang wrote:
> > IPv6 addresses with the same scope were returned in reverse insertion
> > order, unlike IPv4. For example, when adding a -> b -> c, the list was
> > reported as c -> b -> a, while IPv4 preserved the original order.
> >
> > This patch aligns IPv6 address ordering with IPv4 for consistency.
>
> This breaks the ioam6.sh test:
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/402461/16-ioam6-sh=
/stdout
> https://netdev-3.bots.linux.dev/vmksft-net/results/402461/14-ioam6-sh/std=
out

Thanks for catching this. The error can be fixed by just swaping the
two lines of adding addresses for veth0 in ioam_node_alpha netns. I
will fix it in v2. Thanks!
> --
> pw-bot: cr
>


--=20
Thanks,

Yumei Huang


