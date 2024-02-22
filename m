Return-Path: <netdev+bounces-73971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7FF85F834
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA12B284911
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B099612D1;
	Thu, 22 Feb 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvfoRf4I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949060DFB
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605002; cv=none; b=mrlp1Rt+zdQKVyKySkdTRIG93K0Sy/TilGXYXkSrTKCTfUoAnmoFHHtvAnBRNX625XN1koPGLFiCYEzHgku3LyY9bLTSsBlm7tX7Rj8gvmr2myMOLF2Qopgd/yIik4KwAdvmalbMlDjLkJINBaVp/wj/nXjNGyHrQswEfQjNUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605002; c=relaxed/simple;
	bh=MY3erdYgXTbzBAwb7heoWycTSO1wYsJoBYjjKY7COMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vi6h9sWW/k2gZpsWMPeIFNS8pfVZuvgwwySqR3ujYX4d4/ePpW0dZUp4B7eIS0W2Qc8QRwx5CufqrtvIk+QidDLdhnVQtOS8/wI4A1sXAwMl0TFnm/tQAqNXc2mO2ygUOkkgLNFIxs2agReLz6FYmIeQEY642nFQ0pZzA7cBTvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvfoRf4I; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso1212a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 04:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708604998; x=1709209798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRq/c7rub7qjIP+0W8DlbwFM1pjZasKTe59aAPitH5g=;
        b=JvfoRf4IHfzKELcZY34OoEkgugrN7EboDL2f7GOMJVA3pxV7MraZHWIwbdCHg2YveW
         mRXzw0pZ104hooMlOpsvcYKq7KBC1E07DWdZcgRxbY+Fz9FLiNDmboSb6J6X+yQbZ8bT
         EJ02WXCsdjuoXqGB7xGaaijCzox/lVAgMVD2G61FzgNmhwlHBB4ntF7+hLMWd512Pyjp
         DEBvDFttuiVwl2uV84MI1EBydzFCGFS5KLc5WyvYMIqi5jHyXa6YAS0+xJbrE4jX8szi
         iPAqErmhKBcGNn5PxqKNtjJhWuTSjAlUTGFEWNgW6QjVvGx5x8KTl7fn/e0oftiav1OF
         9pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708604998; x=1709209798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRq/c7rub7qjIP+0W8DlbwFM1pjZasKTe59aAPitH5g=;
        b=kTBndkcT9PsZAEDDR4GLPfIi8QFbeGuAu4naigGgGRz5YIFvY/R8pqIwVPkCSTQrgp
         v4fl+kD2FUyJFoJHL80Xu/w48qfOtBlVVhv/JETepz0fdEgHL1FbBY23+f/xazyBZ1bq
         g1pdYK44ZVU07EeFeuEELh/IdhHOcZzbwGXsTyZRqoLbgwGiCaL6f1pFR6ffmEFMKtJb
         YvE0tuk1GYIEP0Qj/JlG/3BojogXFBeBn8YD8x14E6vmXZHhk40+9AtHtoEck9LKsdBO
         M3Nh0PpxzqMf1dBb56Xrb4EQEdLPbklh7lGkjfrGKaCkGB363EBglQVezF/cdpfExxtA
         r3iw==
X-Forwarded-Encrypted: i=1; AJvYcCXB8PSty0lw/rX1AoedzcMae3NCIua+lptHVDkx+Gw16kgSknfYFdoJ876yPN1ArsYMcFqs/1ENiIaS6/UfW7QJ/WnJkSyV
X-Gm-Message-State: AOJu0YyCVg3OAn8O/L9hEV/bzWtZyzF8cY/EetY0URpQBKJ4Tz3ldgxH
	9Qtaw+CFyzJ/jLw/eDq2ty2WofUom707F1T365dcXOJHr8FQaGbxezDPdZz3E3hdgklNv7MBqMB
	5q63woHhecQQ3luekIkpxEKSIWf7Sn0RpW4Z6
X-Google-Smtp-Source: AGHT+IF213ztTVhAKfwz4pMDRqUJiQsEJfcI6Uvt0b9BnI77WjOC6PhK+7K0z95PBhzYHdDtaJgVNgx42VsWsRc5NMY=
X-Received: by 2002:a50:c309:0:b0:565:4b98:758c with SMTP id
 a9-20020a50c309000000b005654b98758cmr47861edb.4.1708604998302; Thu, 22 Feb
 2024 04:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000043b1310611e388aa@google.com> <20240221131546.GE15988@breakpoint.cc>
 <CANn89iK_D+v2J7Ftg1W6-zn7KSZajwWVzfetSdrBPM6f_Zg80A@mail.gmail.com> <20240222122324.GB28098@breakpoint.cc>
In-Reply-To: <20240222122324.GB28098@breakpoint.cc>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Feb 2024 13:29:44 +0100
Message-ID: <CANn89iJ6UxRPRJeat==LXQS7B7rYpUN3BvBJv3w1_v5y53cfSg@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in mpls_gso_segment
To: Florian Westphal <fw@strlen.de>
Cc: syzbot <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com>, 
	davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 1:23=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > I guess we should try this, or perhaps understand why
> > skb->encapsulation might not be set,
> > or why skb_inner_network_header(skb) is not set at this point.
>
> syz repro injects data via packet socket, skb passed down stack
> has ->protocol set to NSH (0x894f), gso type is SKB_GSO_UDP | SKB_GSO_DOD=
GY.
>
> This gets passed down to skb_mac_gso_segment(), which sees NSH as ptype
> callback.
>
> nsh_gso_segment() retrieves next type:
>
>         proto =3D tun_p_to_eth_p(nsh_hdr(skb)->np);
>
> ... which is mpls (TUN_P_MPLS_UC), it then updates
> skb->protocol.  This calls back into skb_mac_gso_segment() which
> sees MPLS as ptype callback, we then end up in mpls_gso_segment()
> without any inner headers set (skb->encapsulation is not set,
> inner header offsets are 0) and mpls_gso_segment() attempts to pull
> negative header size off the skb.
>
> I don't see anything that could be done earlier in the stack about this.
>
> As far as I understand NSH assumes its only called from openvswitch
> and MPLS GSO code only via Openvswitch or mpls_iptunnel, but its
> reachable by other means.
>
> But skb_mac_gso_segment() doesn't have any info on the originator
> to know if it can call into nsh or mpls 'as intended'.
>
> So I'd guess best solution is to explicitly check for negative
> header size, plus a comment that explains how this could happen.

SGTM, please send the patch with all this analysis captured in the changelo=
g.

I was thinking about adding a debug check in skb_inner_network_header(skb)
if inner_network_header is zero (that would mean it is not 'set' yet),
but this would trigger even after your patch.

