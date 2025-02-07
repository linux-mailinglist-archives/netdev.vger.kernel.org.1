Return-Path: <netdev+bounces-163932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E44CA2C114
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598F13ABB90
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA081DE4CD;
	Fri,  7 Feb 2025 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYu2o3eL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD761B4133
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925828; cv=none; b=Vmp7nCUglGYR2aDvJYhm7jZaXp2Bi9zPwcdE1CsjsIxfta8n+03mpu1riIEQuLIQG5bniXphvap1bK2BUEg4YE4v8O42rGADql7BjcyxOsY4xBpRGGsJCh9Xic4waI5lCqK/bsnQCNDRn4AE0u69LLFTlvL/y5ZklxZjfF5M0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925828; c=relaxed/simple;
	bh=XhqhA/Rdf3wowMZThBY4E0Dr1Ikf5GSzmF3crbWDwfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG3lWn/x5l+T7cOCNYZ3xN7pqe6cWxk33Y+Wjz4MCnawpZIkr+RU9ebMxN/w5aBTQi61pApaj+GjreZWiG9qlBnYPtyboIR6/XUUKVEt6w3SgZngCWmceJjJlH8xCyuXe6HDNs6AsEhpo61HnySr0mBaXkViGK3qg1sPpD3jt/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYu2o3eL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab76aa0e6fcso261640366b.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 02:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738925825; x=1739530625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oixZqE4mjnFMF72kYzo+MwAIOVoVqFcrjg9SKs2ioE=;
        b=hYu2o3eLbw8q7BiJgy2nsNo/oHrMeWqHpxLE/s6n3TCX0S6ECYVcxwiurR32Lffn/P
         m4mz2Y3iXJfWbpS2dTeIuoQWqy/Y46K+k9+dp/vn8Tl/OWtGJP70q5iYqn78E7OxKC8k
         VGr9n4U6oVXbMQ1os9gLF2nnJqz0mOCJRv0X6SMnHcwztrTEkRFuoy6LgFISPXFW3LJ9
         thmjYq7XAAZ3VVoo9aNsgH3rI2mbm7bxblq63wtwJhfLLnP+BMO0H2m+RS0VHdS3Uhgo
         /EKHxB5yNVy/96Zx5onIK3WexD1bDFURSvT6h9ghmF1EyWnywyc/2qWScLHyT38vxsME
         cSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738925825; x=1739530625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oixZqE4mjnFMF72kYzo+MwAIOVoVqFcrjg9SKs2ioE=;
        b=wPdqeHsS8H08B4kdJnCl2tRQxxS/KGc2hLoPEbBehvGT2VgxkwpTUOmHi1GIJ7M9zj
         x7FoQJJwovFAabIjRgmtoovpGoAMc0Ylo+1fFvVHBqlubtIZY22xY5vQlPdmFfvAjFR0
         RSd1G+K3imXAc8ouf/ZIPghysTNXiKXHcjHzGQ592sLEcExYXFb/02J2Sc2BZzk+Ium0
         TWStjPdBR3QFxXKLycz967CBmICCZn719RXnh4pPNWGncLQSO5iMktUCBex3Hfq58HRw
         iZ7SXpKjwfYoGxeNDqKFT1e6z4oT3oFUvBxhrWWLHYDQyzz8wlPuVA+zuACSsZ+JO8zx
         JYgg==
X-Forwarded-Encrypted: i=1; AJvYcCUB2BsB4TMF3cTXluHRJTb33EMI3HQJp8Z5rc/go198a85WXUX6BNf1PDe2kcZWdeafG5QyjxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHNYAorCJQpMYMTySuX4j9a+9ud76uObcpR+6LqZT0+FFNvqo/
	g2k7mVJTE7iL0xWjfA/nUFsT6BiwW88/7lgpnFJQcfi1tiMpiD5RQXlPANvHv0hin/Tf2MQ2Jp9
	eWfwHtvIOYg1KCOtft2uL02We4l+Bv9F/seNn
X-Gm-Gg: ASbGncuSS06LGGZ2MMmgU0emAvDQt2B5PJI3hPP4S9VNEMtDXhnfBnuT0fh9dTUQTgb
	TtTL5bwqhgsgCmByKO69NKx322sJdLC6dHO1Pgfp5TMnmsDToWVMRaOxckPHlAXPbDL+xnaQ3
X-Google-Smtp-Source: AGHT+IHsIzlaRbpgEITLHhJuOsk3unfBeSfEeTwsa08pijLhdbuUaZLTzdnfyTNlDZXNMwXNcnR8FQV36oxqS/7UuYM=
X-Received: by 2002:a05:6402:1ecf:b0:5dc:796f:fc86 with SMTP id
 4fb4d7f45d1cf-5de4501880amr7430231a12.16.1738925824799; Fri, 07 Feb 2025
 02:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-scarlet-ermine-of-improvement-1fcac5@leitao>
 <20250207033822.47317-1-kuniyu@amazon.com> <20250207-active-solid-vole-26a2c6@leitao>
In-Reply-To: <20250207-active-solid-vole-26a2c6@leitao>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 11:56:53 +0100
X-Gm-Features: AWEUYZmYp8_1cFrM4wCX1ah20Em91z0JEliqSD4w8oGVXpCV-ULTiV0K7niq6Iw
Message-ID: <CANn89iJ0UdSpuA9gMEDeZ1UU+_VwjvD=bdQPeEA0kWfKMBwC8g@mail.gmail.com>
Subject: Re: for_each_netdev_rcu() protected by RTNL and CONFIG_PROVE_RCU_LIST
To: Breno Leitao <leitao@debian.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, andrew+netdev@lunn.ch, kernel-team@meta.com, 
	kuba@kernel.org, netdev@vger.kernel.org, ushankar@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:46=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Kuniyuki,
>
> On Fri, Feb 07, 2025 at 12:38:22PM +0900, Kuniyuki Iwashima wrote:
> > From: Breno Leitao <leitao@debian.org>
> > Date: Thu, 6 Feb 2025 07:51:55 -0800
>
> > > Are there better approaches to silence these warnings when RTNL is he=
ld?
> > > Any suggestions would be appreciated.
> >
> > We can't use lockdep_rtnl_net_is_held() there yet because most users ar=
e
> > not converted to per-netns RTNL, so it will complain loudly.
>
> Right, so, I understand the best approach is to leverage
> lockdep_rtnl_is_held() only right now. Something as:
>
>         diff --git a/include/linux/netdevice.h b/include/linux/netdevice.=
h
>         index 1dcc76af75203..0deee1313f23a 100644
>         --- a/include/linux/netdevice.h
>         +++ b/include/linux/netdevice.h
>         @@ -3217,7 +3217,8 @@ int call_netdevice_notifiers_info(unsigned =
long val,
>         #define for_each_netdev_reverse(net, d)        \
>                         list_for_each_entry_reverse(d, &(net)->dev_base_h=
ead, dev_list)
>         #define for_each_netdev_rcu(net, d)            \
>         -               list_for_each_entry_rcu(d, &(net)->dev_base_head,=
 dev_list)
>         +               list_for_each_entry_rcu(d, &(net)->dev_base_head,=
 dev_list, \
>         +                                       lockdep_rtnl_is_held())
>         #define for_each_netdev_safe(net, d, n)        \
>                         list_for_each_entry_safe(d, n, &(net)->dev_base_h=
ead, dev_list)
>         #define for_each_netdev_continue(net, d)               \
>
> Which brings another problem:
>
> lockdep_rtnl_is_held() is defined in include/linux/rtnetlink.h, so,
> we'll need to include 'linux/rtnetlink.h' in linux/netdevice.h, which
> doesn't seem correct (!?).
>
> Otherwise drivers using for_each_netdev_rcu() will not be able to find
> lockdep_rtnl_is_held().
>
> I suppose we will need to move some of definitions around, but, I am
> confident in which way.

Note that we have different accessors like rtnl_dereference() and
rcu_dereference_rtnl()
It helps to differentiate expectations, and as self describing code.

I would not change  for_each_netdev_rcu(), and instead add a new
dev_getbyhwaddr_rtnl()
function for contexts holding RTNL.

Alternatively, add one rcu_read_lock()/rcu_read_unlock() pair as some
dev_getbyhwaddr_rcu() callers already do.

