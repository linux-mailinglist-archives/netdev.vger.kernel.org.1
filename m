Return-Path: <netdev+bounces-162038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 442ECA256B0
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC1A3A7A79
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA4200BA3;
	Mon,  3 Feb 2025 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhW2XFLb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EC200118
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738577573; cv=none; b=Rg3/BoMj0dlZyMed6jTul7Jq8vOy28Ka69ESzHvZSavASsJBNpXZzJ9FWOuk5z9FoGliS8RLMKDz+NcoqxsXkDKQ2gh9fWk7G6iDYTxuoj6kPGc5whuFmVAPOJW6ISYxlu9JpK+hW/SfYCDWgD1h6/gJy/glOAxUhtl9sOfefQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738577573; c=relaxed/simple;
	bh=ioKI1EIF98WVVO1J/m8mFBm2cnBvXmgzKU16tKfd6dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixfKTOakAa7W1gOMQUSmY/0vC4QKbXibBOU+FMT2xgy95pNCtOdh1hh2YRCsLfLWXnuwDihlli9+yTZQuXTLpt+/u2fWqwAjNGxXxvDqxdyziMtXwgwL08EPE9uSjQzyFtzj0aFE8DS2eVTLdJxNou6ojkl6aKQgnmnAdusLKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XhW2XFLb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso6811245a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 02:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738577570; x=1739182370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBJ0SoZygR0uCHqtVtRx1PW+FsIeGKu48cm9v0QtKJk=;
        b=XhW2XFLb/CE9/YVrPsZ8jHpfnaa6YtiXwaznqevNRd4iCw1rmD6RK9WLOCyAPs03S9
         guxiDdMdrmYTezxoWVSyizuRTvBziC48Vyhf2/dw9+YVxVzci0tDRCCIoyzZwWiaZ6oG
         MoWP1XrJuvNoNOetMn+HknYTeAOlZA9m3mkpDxgriHAJFFAv1g9RgOg3yoSqnpXYbrUG
         FsngKlExBtFUHqZ9Fe/AaVI9XguxWuyynVJ6U4685W1Dh4SwPRfYqcJFD4NhZ49Zdv6/
         iMEg85Fg5j6lnZfCmgyEGUpKbPe2T30A23zmJmoGKnb4I+CbEFuZdaNYbXp8HjJvkL6g
         lcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738577570; x=1739182370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBJ0SoZygR0uCHqtVtRx1PW+FsIeGKu48cm9v0QtKJk=;
        b=PCKenuryVpR2v0cGdDgiW8CLeWuWfUHKScOWRWz2rIRy5xQWsCRuP5j9ORw07thNvI
         xXu+vY96f9WACBZ0nvr+zHfZ3t/WIfKd1hYkJ6Dxh4s1YcpfEIWAiRBI24riqRYMaNby
         dsjy32690ad/NCLwUx1Y3ULz4nrIGkCeAXqs8IpqQzYwpyqNKT2bRnN9bWcwT6glVWZO
         gldKc4NC6S6Fcjf/+yDkt/xHc2dMVOvcLz4LKZzJtAsV05xcgN0/oUCGCWoABVT/Vm+1
         /daOG/mz26u8+n+s9sCfA6sB7ZLv2XsrS2ioVnQi+r/YvZ2Kqhd7CE4XMAy15aRKu8DL
         zsYw==
X-Forwarded-Encrypted: i=1; AJvYcCViAduQDP0RLs7L3PajeCygV7VqH/POxMlss1ZaZrA5gk5Vbl341OhKEpo51+tQ/x4pOtET2bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPVYrTydoCAPTbeOGvAYl3PBB4N/pQcMvwS3BxjuWbCKljafl
	ZNp86PSEgeJKXksRP4cn6+ErCsvUmAH4g/c++UnHYUc2LHv8AIuY5b7c3a3rb8Ew6afpPODh1gL
	M55oFNh/y05YrSiARllZuP0n/kBQlvyp2MKON
X-Gm-Gg: ASbGncvrapeZmKKjTcJKxd4kdawhTRcl03RonbnjNmIInDWf/mn98jSvunwWcYi2HLx
	xaiGw37IdACUJp9awxQUQOdn9I+ghxtAc7viPkgdS7btMnOJW785Sop4gAZT+uNROmMkZzS7a9Q
	==
X-Google-Smtp-Source: AGHT+IGR5FDPBJAImGbztFhSP4FOGUN2aGNMrGsM9KO+juOcktIKIvvdtQ0TVnX+kK+2HmrHrCukN20zxCHHnAdxpd4=
X-Received: by 2002:a05:6402:2111:b0:5dc:7eba:7832 with SMTP id
 4fb4d7f45d1cf-5dc7eba7910mr17511982a12.17.1738577570032; Mon, 03 Feb 2025
 02:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com> <20250201181801.4427248a@kernel.org>
In-Reply-To: <20250201181801.4427248a@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Feb 2025 11:12:39 +0100
X-Gm-Features: AWEUYZmg_xYfoYplEHiVf3EmcRNZeklqsZ01WHR9dbvSkzP-eudxIm2q_tDwe60
Message-ID: <CANn89iLt6E-cSE3QWpg5GPjtNSm4A81EzAFh8YuG8Wkq+UqmeA@mail.gmail.com>
Subject: Re: [PATCH net 00/16] net: first round to use dev_net_rcu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 3:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 31 Jan 2025 17:13:18 +0000 Eric Dumazet wrote:
> >   ipv4: use RCU protection in inet_select_addr()
>
> patchwork thinks it's an incomplete series due to lack of this patch
> on the list. I'm afraid a repost will be needed :(

Interesting, I wonder what happened...

I will send a v2, here what it looks like:

commit 52a1dc65d01230876fbacc7f8fe63ee7a758603f (HEAD)
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Jan 31 16:47:50 2025 +0000

    ipv4: use RCU protection in inet_select_addr()

    inet_select_addr() must use RCU protection to make
    sure the net structure it reads does not disappear.

    Fixes: c4544c724322 ("[NETNS]: Process inet_select_addr inside a
namespace.")
    Signed-off-by: Eric Dumazet <edumazet@google.com>

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c8b3cf5fba4c02941b919687a6a657cf68f5f99a..55b8151759bc9f76ebdbfae2754=
4d6ee666a4809
100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1371,10 +1371,11 @@ __be32 inet_select_addr(const struct
net_device *dev, __be32 dst, int scope)
        __be32 addr =3D 0;
        unsigned char localnet_scope =3D RT_SCOPE_HOST;
        struct in_device *in_dev;
-       struct net *net =3D dev_net(dev);
+       struct net *net;
        int master_idx;

        rcu_read_lock();
+       net =3D dev_net_rcu(dev);
        in_dev =3D __in_dev_get_rcu(dev);
        if (!in_dev)
                goto no_in_dev;

