Return-Path: <netdev+bounces-202010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3930BAEBEC6
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 19:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34D7566EB7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 17:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46EA2ECE9C;
	Fri, 27 Jun 2025 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+rU8Qcs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4A02E9ED4
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751047060; cv=none; b=AaWcUbBv+G5taDIoTapoxzOX127Ltb5HjfKrtWjYBGlu8FfIqgTjb6vnqKnphASTw80QFd9Za/qjnUukOpdvc6q9jQ2AT8UpqbYGq/08y9THbovd8jSpmDk5c7qsdb2tJHaSJa0jXdInuA0IVN6MA2IUBVl1LWr5Rfudw9xHzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751047060; c=relaxed/simple;
	bh=tioZ4g8MofZ5p5N8E/Gdv0k1kOD2CDmLslsDbhDechg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DugzdfIXSNrUJ515pUz0NlLwfyehzp1J3Hp4ORhG8MyFqNnemP04YanuMf5ImmNt1+4jXmOuXmXBgxb9UkYHXzDy5qL71KxVS/Tc9w62+ljDILVgwozK7dg6rF6pnhYYfnxHSVuX4t0PSL1/VFMWXsf6S/htErON3vmytPOYr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R+rU8Qcs; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af51596da56so269538a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751047058; x=1751651858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FNCGYMJ/bkf2VYREzNXIAseN/84z3ons4Q8vWNjRuc=;
        b=R+rU8Qcszwx7++7UU2m75IQ1f2PHGJ81BbXK4TacUOh/ly8wzmOsMGDydQIrn1bcxN
         yYCR4WOLHI5BlrGILMvwjj09GpJLFbuyhTMMQZ8eY5Nx7/nFCkBeUMqJs32apVBHAXCr
         P/gaWt1AzZIT91ve7XVYRYZptLRyUCpuNGQHebKz24VjmDm1JJYwHtte1H1T8u5T4Px2
         0icUYB5PxhzP7lLMZKmljoToYvXW0YNPaHlXfkI7ac2uXRCREbeREWr757zNLxsTOGOG
         Q91ezgvSxkMfvLsIWyr3WY12OVBZfUu+nV0UgoluizKeVzuZfNMyB50IsUcyB2Y+C/3q
         ufOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751047058; x=1751651858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FNCGYMJ/bkf2VYREzNXIAseN/84z3ons4Q8vWNjRuc=;
        b=dvV9KcCtCeS3APhuJimtZgMOGhwabd2RI585GujsiJv3ad+I4HHgj7LCUfCJEzG4y3
         C397qJQKYLDuCYKXTvoCQXvMzHO3nR8/KpN6GCmBn1HMXy13sfSAsXRVBofLPHp04iDM
         ZEFrSi23KNdlQlRg8OuL3lOI4dkr5VJ1cwORTjciUsxLPXQMZ21XlK1XG04841n2aoEy
         9D4rWjJoUmeXj2XIT8fSF1LAEXCHAcFOfZX/zQYUi7Hpb2qUNK6hgb7zP2Vmv2yNnzuF
         b4i8tiy9PP9sEEtz1NTQRGr5659VOeERDXBXCLBeo7xpA8DjUV6Jy7Y9TrYk+nisO+Un
         0/eg==
X-Forwarded-Encrypted: i=1; AJvYcCUHCMt9foi16ZZ7OfFV0Jl3Kn1ZjVvhmVsSuBl78mnwogMT8bZmF3HPkmlsgcHU+yxHC7NJJ18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWirNvUI9iNR09Qdpf2g5bYILdlvTUDSQV8sY3W8WRnXSg5HH
	yZj87/JAD1+nzxpKYU+zza84WtqG4PUoj1BO1CxPAG6Ux5K60ac+cXThJ29lbn5XFa4k4ok9ZiU
	9fdheuPGurLhQclU/xad5rtqxddeTJ8qCRe6WUIbY
X-Gm-Gg: ASbGncvnBN18lwveVKT5eP9CiEw/fzthYBaIQBDIBSKwmJdIsaPQKD1HGdmudcmU9HQ
	epjEdgMfPYDEkchhnxcIpQf0e3/s4vHLQx+6GhiYQZ4KwJNFnskkCkC/4sP5lgB7gz99GkPx8jQ
	1uqYX39o+Niykc+B5vJe9VCYY13tMUFDZr9DrNzd6cgjtwykInC2YGYspmyrM4dXji50+VrpIRk
	g==
X-Google-Smtp-Source: AGHT+IEA8YL1I84t5oQNtSsFStNs61IdgmAP/ZnP6SEf86OmKiOjXKH/hJSUwtujyUUD9WvmEvvv9opg0KIgRrAE/CA=
X-Received: by 2002:a17:90b:3e87:b0:311:c1ec:7cfb with SMTP id
 98e67ed59e1d1-318c92b793emr5249457a91.21.1751047058289; Fri, 27 Jun 2025
 10:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com> <20250627112526.3615031-7-edumazet@google.com>
In-Reply-To: <20250627112526.3615031-7-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 10:57:26 -0700
X-Gm-Features: Ac12FXyjAGl2YJ6dN1nF1GMs2X09vHSwvZsT-w70bHSZ4xZFICPfVtlPlV3d4Hs
Message-ID: <CAAVpQUC4yr68uXvTSs+nW4dwrmuyMLJ-s4cgansGT1rpaz_26w@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] net: dst: add four helpers to annotate
 data-races around dst->dev
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> dst->dev is read locklessly in many contexts,
> and written in dst_dev_put().
>
> Fixing all the races is going to need many changes.
>
> We probably will have to add full RCU protection.
>
> Add three helpers to ease this painful process.
>
> static inline struct net_device *dst_dev(const struct dst_entry *dst)
> {
>        return READ_ONCE(dst->dev);
> }
>
> static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
> {
>        return dst_dev(skb_dst(skb));
> }
>
> static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
> {
>        return dev_net(skb_dst_dev(skb));
> }
>
> static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
> {
>        return dev_net_rcu(skb_dst_dev(skb));
> }
>
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

