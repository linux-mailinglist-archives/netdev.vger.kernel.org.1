Return-Path: <netdev+bounces-224153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9FDB8148C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98497582F60
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C128225A3D;
	Wed, 17 Sep 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHzVe2i4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E934BA3C
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132084; cv=none; b=DzWjoyO96eVkSu2U+8WtkgCSJyigrqKvymSTloWegidCibq/HozmKemgpmNxpmPcoVYCjTTFbFjBbnyqAT/Aa+IOo1Z4YOraf89/fq4P+RYUsga/a69bhiR4zQlGq/vjdn2+v8Fb2Z89pBlLQrpcPeJJVitJtkV8lJ38SKjQrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132084; c=relaxed/simple;
	bh=A81FrzAp/hgZj+8unJLhR7+fveAbUrJ5cIJzBg/m1Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmI/ss5WNqIODLYRLsSScTKkfiTbbyLhhxEG4iIeIqIyyVV0A7O9JqyX8BxHtb3KNkhhJoLO1EpPJtd4caNlGIMq1RwoXrxE0RY5HXYkcUiRuca1MHcbk9d0Hf3bdj1/6HO0yPBfy3P2PPnbUVjeKCdUAp9j+a/rstpx2Z/fXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHzVe2i4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2681660d604so960575ad.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758132082; x=1758736882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A81FrzAp/hgZj+8unJLhR7+fveAbUrJ5cIJzBg/m1Xk=;
        b=LHzVe2i4p7jyr7Y0e5ZiiB7BwV6b7uzAggjjCEfQkhNas83J4pMuNHIIBtixHMQTDh
         oBcvSVskmLkG2dIk/VZRsqX12//YEgmpQmuHJ998gG07w0I269QQitNfzEv1p7ZdH6rF
         5a5mEH1Cl3QCGGiwKXH6b62XoG9uQuuhkWxIrOmOxyuXmL1SHoCNkbOPMzOgxw1Qq+b0
         MkN7VKfKSlhjKKHyoBHcFXGhZnCKOE8MTtRdXfAR4+eOpkJisPpt5uMKMeSR2DaJeUyr
         wYuExnrEPKRpWyhQMItb3GZlc1jzejz/JpOKD62xVcmdqfD9zG5txj3RMZAGfNWeHL0/
         HuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132082; x=1758736882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A81FrzAp/hgZj+8unJLhR7+fveAbUrJ5cIJzBg/m1Xk=;
        b=SLiaFmu7ePW2WccaCBKpDHnPn1RdclLSyadHbYcqVKi3zBv1Ew+LvHteq4xt7pIkzN
         YLxWHc8g/RX75BpoU6NHqMsJwZhm8FqqvqkUHhVCT5vVHPkv6G67zs2a8UtpfrEJWDi7
         mXccogu3hCpI961rHtmtL49p+lyHM2c56NtG/kfH7hC2WVK16iy4HatsCYFy8z756aCD
         6bJCRJTDKI7TApap7IyzheZHg+etkH1aW7bkRSccStlhrNWv2wr3sL5I5iJj23acY2yO
         yQwEdp3PFJyagLAF//Fz5wyL+H/NLCPbNgOMSnJJOCjVMu0750x2xUh+bYPp68FuoZaq
         Dw1A==
X-Forwarded-Encrypted: i=1; AJvYcCVcyf3HtesymejzdDKJcXdKmQhmuC8Jl5IBz3IqKZqyxQZ8WtC3iDtjUeKu1WWesEmDc76QD4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRNlsJjJ0hQrQ/ZMf3ehA0+2KdmWrkVZwcO623YQGFSO+lBP5
	/L4AOL5pGjo6BVRKq5Yc+YYC0mtBVklGLC5ECvNziKAGsRcTVXZqURA2UNT7lKUEZIDGeWsMmQ+
	dMCV0Ma4KQTkA49h3/dnJ3QQqGsXNcS63znJX9GUv
X-Gm-Gg: ASbGncs6PEnm44YKC6OofyjjZp7yD/leVaZEYLNoImQzi5vKlYGZtInx/y6p8XdDmQA
	mqpLPd09qxV3tKMxbDEO2jkjtnp8Ab41W4cs4YMdWU13l2maNEl17CTvcrRWQ2NiF0K/C0NnWeK
	XA0BIYruzwhvHtWNSwJ0mG3opSb2MyAhG7I0f8IqWJS6n4huxBx9Av+SYahGfIV4LUMwB9Vpqi7
	JFRzAxJkAZ9YSmkbSvtN232JeMdcH5BFD12W/E7eN+FNKXxCFVHboM=
X-Google-Smtp-Source: AGHT+IE3JiDd80nM8RMfePsXMwOcKsy+KJOHl9dHDEJMOsQa1M4Thlyt3h8LfZH0u+FgSI01W1Z1Dv/f5V2f2TcDCHc=
X-Received: by 2002:a17:902:fc4b:b0:24f:fb79:e25f with SMTP id
 d9443c01a7336-26813bf3dfemr35678495ad.46.1758132081953; Wed, 17 Sep 2025
 11:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-5-edumazet@google.com>
In-Reply-To: <20250916160951.541279-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 11:01:10 -0700
X-Gm-Features: AS18NWBAtwdo2RbLjr1Qh9owHQrJFx9U6Akkeljc0KwP-zAeuJ6VnFpANo5o3WY
Message-ID: <CAAVpQUBFDG9+B6fF4hQAmxRkooT0wiY94ghbhNn6rMvpTmUUSQ@mail.gmail.com>
Subject: Re: [PATCH net-next 04/10] ipv6: reorganise struct ipv6_pinfo
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Move fields used in tx fast path at the beginning of the structure,
> and seldom used ones at the end.
>
> Note that rxopt is also in the first cache line.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

