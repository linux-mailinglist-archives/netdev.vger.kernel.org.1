Return-Path: <netdev+bounces-173652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD0A5A561
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00441888581
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7B1DE8A9;
	Mon, 10 Mar 2025 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkMzf03e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251411DE899
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640305; cv=none; b=ZVFAi152FbHCd9emTTx6AFMlnuJFEi43nDuP7YbHOj1x73wkdTcV0i4dRL676Sxu191+AYasvW6a4AdL+ckyKtQ3w3sXW22f/1oLyxWyn9hnzDi0HKR5ahoEBnreXnhz4gYMVgx0nRST9MZS/UnCoLBC+dSxivyBAD27f1GtOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640305; c=relaxed/simple;
	bh=udnmpgjnrnQl/r5rpuVE/OrzhYTIVnFvDMbBeWMLMt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qO1H9DmAk4PfD44F/d8YaDrE6ciOCHtUo2P3xpwTSMqA1dwyTzdbppuEzKcEZjJ2U/gayjY7nvPJRe5AdBw1BDVztN3I/sHA3HmvN+Oe9/knmXw0810vGR7qCnHJ4WY/K6O6AmqA1hQJ6eLfXmBIE6e6nsePVy4twULFLTjm8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkMzf03e; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46fcbb96ba9so62281961cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 13:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741640302; x=1742245102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=totOKg+C1RLLbJLz2a3eJ20AMHYupd9oISI8Z8SOtSQ=;
        b=AkMzf03epSWjqy80O5z7MxSUSAShRvyYv0UYOHknyIWSu0FGOvsO50dZnyJ8JsJlYe
         HsdXWKPuCjp7upfNh8FfV9ZW0+BMbACJ1CMQF4Hl9aaRR+ts7SfTfJO5CLonquQRL/g7
         e9p++4wsrMZB6TOCLFZHQ4MOcZ3VFlzXCCEXsodd/JbgPwbpuoWbCTiJYfKvbqVjrpXw
         1ifpuZOle3+a/PW8NZO+BOL6PxlawEXnjSrxznefBj9RaSOfQeMMPz9sPjo2VEw0baMi
         U7mPCUgFb77gcU8nlSCIntSRLlwwJIf7Y5H2pHErw6XLZW/LLQBBSjbAQmgcxjJ/zVce
         XTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741640302; x=1742245102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=totOKg+C1RLLbJLz2a3eJ20AMHYupd9oISI8Z8SOtSQ=;
        b=jTDUvdrGZTnlUnFFlXHZhb4RUhtte8oh5RgYeTl0mZyFeC5Qz9/oslSkh1nF8SPrb6
         KW6wcAQCx+Kr/WWSrAv+/a9GMfNWbBPQXl66GwEqIdQU41DZlvi7m4Zb0O8img9SxsG6
         W0DEP/wrJ13d6xa4nG45f2kslzldShAKMwOtF7KQWCB+m1e3v/3lQlcF070lTwi+RL+i
         UCJL+szBdiDYN10Jrd6XG7g6xZYW6HjOXztCwRtROW5RDMaFXLgmYiHSDHBj4gOXzGwb
         J5Jb87xdLRI1r1v/h/8gi0OZGnTkEE78e8G8hNxUUQiTJEzsewpnjGSXFaKIgfjKcxVm
         +H3A==
X-Forwarded-Encrypted: i=1; AJvYcCXY/6sRJ/8Mnnwvv/Ji7rU2BzpY8TJKILQv0uDM+bsmI9ehc6qOc9NWi0o1sMcvZS12eMi3y5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5t7pSSWIyeEmnrSK4FcZk2g8bD0SWf+Mm4nIkVe/CdBIxzTAA
	YS8XvJV6yfad/YPmw5prjRVOv/inJvPFRMoPxckg/vq9kOWWXH0tbfo9KbmTGAUSBlI3MKW8CMZ
	cEyw0oudqWsI8Pqa9H6N9h37UbtGAH3pRjV/0
X-Gm-Gg: ASbGnctze/VAfHXo1zDOHxvdsFccwk410uz3bgw+zwHv/XmBHYxRJsnZZiGP11AJzuv
	1AhMLyyoK6HOjdWcfXXOs7Do+tAd9cISztHW2dPJMHOa6AMZLaxvPg4Ja4ZsnouX+XoAYtNIBs9
	k9N6UDSIX6Fqb5dpT+wiFHneYzug==
X-Google-Smtp-Source: AGHT+IH32RBY3KE7CCJKADAXBwm53mo8Ml+vwI8WA7zOwPhLmxmL957w5eo9+eN8sJUuoW1tyGYSiBsYTS0PSCwGitE=
X-Received: by 2002:a05:622a:209:b0:472:a26:744c with SMTP id
 d75a77b69052e-4761097d371mr197610591cf.12.1741640301788; Mon, 10 Mar 2025
 13:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309173151.2863314-4-edumazet@google.com> <202503102308.1uTA6Uxr-lkp@intel.com>
In-Reply-To: <202503102308.1uTA6Uxr-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Mar 2025 21:58:10 +0100
X-Gm-Features: AQ5f1Jr884G35uQURzTyL3LRgOkMXY0Q1xmhME8uTd8nuhV72EtVWUaKfRfW8ss
Message-ID: <CANn89iJqKH8A9+pq_i0HWuhqfq_1gkNCzfdv7=bUQy-cR=msEQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] inet: frags: change inet_frag_kill() to
 defer refcount updates
To: kernel test robot <lkp@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 4:57=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Eric,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/inet-=
frags-add-inet_frag_putn-helper/20250310-013501
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250309173151.2863314-4-edumaze=
t%40google.com
> patch subject: [PATCH net-next 3/4] inet: frags: change inet_frag_kill() =
to defer refcount updates
> config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/202=
50310/202503102308.1uTA6Uxr-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e=
15545cad8297ec7555f26e5ae74a9f0511203e7)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250310/202503102308.1uTA6Uxr-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503102308.1uTA6Uxr-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> net/ieee802154/6lowpan/reassembly.c:312:45: error: too few arguments t=
o function call, expected 4, have 3
>      312 |                 ret =3D lowpan_frag_queue(fq, skb, frag_type);
>          |                       ~~~~~~~~~~~~~~~~~                   ^
>    net/ieee802154/6lowpan/reassembly.c:86:12: note: 'lowpan_frag_queue' d=
eclared here
>       86 | static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
>          |            ^                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       87 |                              struct sk_buff *skb, u8 frag_type=
,
>          |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>       88 |                              int *refs)
>          |                              ~~~~~~~~~
>    1 error generated.

Interesting, I thought I had compiled this file.

I will add the missing &refs argument.

