Return-Path: <netdev+bounces-198731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76525ADD622
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F4E19E0A98
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC80028504D;
	Tue, 17 Jun 2025 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="g80EKZwn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6EF28504E
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176666; cv=none; b=LBEt2oDnNtgpgiDTNHo6SCAHBsaAD8qaH9Py2F3m/4mYXTg04zvYKAUtwbDhNuwBTsuCDp9Dwu3pfwkYiMP6Mkv8gekMy6590wX8xOCkDSx1F8Q00lE96gDe4A691WYsl5NJzcCSF6DPZi4z12cxbWb7wWR6joQmO4wSr/X5g+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176666; c=relaxed/simple;
	bh=gg778PBdWtNUKArL2pmuJhETfoc59XLHWvCYQZ1X2uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/XGgtGbiZ8VVziMTeFmsWfCGZvcHJ5tWkIzF5f/KESzQumT1E8D3khjckZ8vl3hXqeu1Y33x7lzbygw4BgGMBwyk7TrLT05+dDz3B4gFK2uqtHcJi4s2Nh+y2YeWdyMYFUU4TCRMSmKhCoRDFXncWrJX9Y84eBvswfycgDuSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=g80EKZwn; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af51596da56so5307282a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1750176664; x=1750781464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg778PBdWtNUKArL2pmuJhETfoc59XLHWvCYQZ1X2uM=;
        b=g80EKZwndmY3EOfB73wdDc+fSfw9IH/zyAWWXaPW7sEwWkC3qnhzh/B9Viz2OCI7lL
         3H2O2Z4ZfjbF0GJ79WiGVfxeDGGgofPz/687NCnL7X1RJR9mMmnwVvUbJLD18ktkwGv2
         MmxtD3r6Lah4ovX0o02152p8FjIyBIeBHTxNFNcOzIfkz2pja3yMVwLAjb6kbCmgbo3T
         j8sbXIxIaKgt9MhUXQfiM8r68waQR1JTSq+pAKi78u4OtPmEPqhLe1a6c772Wsx2S387
         gXdusrNHzRJx9Ntkz1CTJTCbJ4BjKH4jgJxVaTcbFI51PnZqLsP74pcxK7yoWmby6o29
         aiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750176664; x=1750781464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gg778PBdWtNUKArL2pmuJhETfoc59XLHWvCYQZ1X2uM=;
        b=s/VNpY9en5l9+ABTfMmuEPcL+0F3BXS3gM3U9U83gRxGXFCEBRmbNJYvsXbOfU7myG
         lM37xJBB/rNlHS4B1aDHiPbxzh78/1oJVLHjmlLsskm2nJYqldTWNnWkPqxmGwCTAwEE
         Myv9oPtoUx5eSdn5FDvUv3fNkiI8fU9qZrtOred1WIGI4ncEnIrpiTX3B8Xbr7O5m+vO
         LjOiNdg/PTUI+WMy2eZwzpIvPB+x69QDjxWhcybFhyYJyhFn9aNZDjkcuU2swWOw5Ie3
         yZrcnFeDFKEz5kIKjCr1I6qsvLp5A9jFiDkSk7vwNpLqrD8CJFuur2Gp2TIKkcmWWSmm
         tq/g==
X-Forwarded-Encrypted: i=1; AJvYcCU9XdPjyoQwN4fIdwtmj/tHhnDjA9JB4kEqpmABBwX/lpQN1VsbYYjFXRK1UNTuCkd1/7S0by4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBfxF+33dp30FpVtvhtqwwpBL4uRbjlg36r/BRVF/Nwe3M7Sa
	5CsjipZwnYdKerqh9zCX4LWrXstPEuLbB7RKk8VrK0P9X3z9XrCkqW3qPGLepaiD1kkGlQ1QdXl
	qMix7ftW/JRT4kbH8bRBbTP8XRGJK1opEEZSXr/42Cg==
X-Gm-Gg: ASbGncsgvzlOL9iLYuormlGg+yCA8iYtO+uXpMvTssx56+4Yvwwtc5bZyIjFky4fJNR
	7P1liBPtizE2pZ4iyUI/uRmuWGPp/QaixyY04cAtqWpmjj+KWRO9zGcnX3O4jDQfM5whsGE3D2s
	z2QQbMHRjfr73k9TLZmUkRulNZflOmOngWsh/PCv4Gs74=
X-Google-Smtp-Source: AGHT+IEwLRT4NgD0VkFpAfGEE4lBsj4qKk2Y/0QoGKEN2Z2KPoxjGSMj5GM3SiWq+d0xn84a0Y6XzCf0o77ifyAdREw=
X-Received: by 2002:a17:90a:e7c6:b0:312:b4a:6342 with SMTP id
 98e67ed59e1d1-313f1dd5483mr25642897a91.33.1750176663647; Tue, 17 Jun 2025
 09:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617144017.82931-1-maxim@isovalent.com> <CANn89i+ZhT9HWnzjCJepunumS4zLrwGBgGPq6mKiiaa21CKP=g@mail.gmail.com>
In-Reply-To: <CANn89i+ZhT9HWnzjCJepunumS4zLrwGBgGPq6mKiiaa21CKP=g@mail.gmail.com>
From: Maxim Mikityanskiy <maxim@isovalent.com>
Date: Tue, 17 Jun 2025 18:10:47 +0200
X-Gm-Features: AX0GCFutryz01K2X-kbmx1f4AIJ3aGMsSvrfR02wcgNDi2G0Dcw0zKtz7alNYzk
Message-ID: <CAD0BsJWqe-_O6JD=KD7=ktmtFnkA-mo6pnYm2ODtym=JvZyTTw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 00/17] BIG TCP for UDP tunnels
To: Eric Dumazet <edumazet@google.com>
Cc: Maxim Mikityanskiy <maxtram95@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Jun 2025 at 16:52, Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Jun 17, 2025 at 7:42=E2=80=AFAM Maxim Mikityanskiy <maxtram95@gma=
il.com> wrote:
> >
> > This series consists of two parts that will be submitted separately:
>
> > The only reason why we keep inserting HBH seems to be for the tools tha=
t
> > parse the packets, but the above drawbacks seem to outweigh this, and
> > the tools can be patched (like they need to, in order to be able to
> > parse BIG TCP IPv4 now). I have a patch for tcpdump.
>
> This came multiple times.
>
> I want to see the patches coming in the tools, before patches landing in =
linux.
>
> Having the promise that it can be done is not enough, sorry !

I do have a patch. I opened a pull request and pushed it there:

https://github.com/the-tcpdump-group/tcpdump/pull/1329

