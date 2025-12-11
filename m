Return-Path: <netdev+bounces-244409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 189D3CB69FF
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 18:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D317300D4AC
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904723148D5;
	Thu, 11 Dec 2025 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q79214zR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A33126AD
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472964; cv=none; b=H6Wp/5A9UARX8zInf8LCea14qDuLjXqmyHvfIWvwn7QZ4zJzE84mt7bkXHFefTb87YYlK5JrkY4EWlnSMtie5RgAOmxKq5+iXLLyBZGS6Rrt4tvpFxLKjB4JtmMA38SW+CRsVyzdkPoUyMb4U2kxoqnUILy0gR7CyZeW73dAFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472964; c=relaxed/simple;
	bh=dh/HDIXzktuGWQSITg9LVH40sJ2hdSzo5/AZggWSBpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn0Wk1piE03rMGep/kJeJ59lwLv2HXvDWko0su1+yokrg30oByzv4vVQnol0hsQtRgZI9tAFLdnlP+hhUBUWdYcXeHZXLPAAOq/yGwjy5EjSaNVcQvtyWjUpzCzPI5kuexVzreDPoDaDOjyaoCcvQ/iYOcHLJEvMFUbqohsW3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q79214zR; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4511f736011so215363b6e.0
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765472962; x=1766077762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FW2VUCo7IK1n+Kn8KgoCJTzuM+/Fk/IPBhEby/pihF0=;
        b=Q79214zRLQTrtfy55PB9mcNpTTY5Uczwi11HN0wq2jDJLMAOtaT17KrTtAgo25jRJ3
         o7jPIS30D72tS7kcINTJJ0pQbj/aDjisRzyRiWAko3upbUAHGu0shiXoMOfak4t1Te3y
         TaqKY+2RQi+HiA9l/G0F9Lv7TFPgHl2pQD/msiiLOdVOH7cMlObeVXtUDGHhxmQ51HNR
         Kbavh0jBn6cF7d/spmZ+LqKagNgAbOIvmpsgVlxZ6wjKljxoF6Pt0//Aiz6QrwJYJs66
         sQTyTpScjT3UkN4IseJNCpe6yoeFTBYhncI/eHiUip8R+I6qflc2yyhjgJFnb9/nQGwh
         ibkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765472962; x=1766077762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW2VUCo7IK1n+Kn8KgoCJTzuM+/Fk/IPBhEby/pihF0=;
        b=rlTVw4VdE3F09+YnDsjg9S+JRftPgXqRDSKBmH88n5Zn6xfhoL6QVc7o9RSB2ArqHq
         w+5tlNlx7I+U/Y06u6oWmxjqb/R9w/2f8BoWyY252CWi0wQnkdaHFW+6OfqDFnFs+qNE
         czncdfQYnlxHwr9bf9XjO34r6KQLwfcgEDbQSHVg4m0q+dtPyRGWK9syriAh9du9YEJJ
         uQFlEF7SbH1c/0B3qU2z1aIsImIxxCqeCsCCqZZfkoYghIsa/RVFEHz7jNRoYn424MdN
         N1qKnEYvKEE78/ZCCLN/QNqDiuEfeRLpO7n2NRUrKdFhH7+K3JYP0qI0e/PZXdg65kRU
         M7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVG+tqF24Qc0xL4jw4NWeXUF7lJqzcc5QAu7MyNiVDoi079qftPrcrpRSaZXchZVHRoF3jriOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4wkXGfrLYidJagaYi8mcjTxUGwCeJteiq53q04fHFV0QsHya
	QPwci/jHZ2a5AeW5XnCOHfSbGzya2HvwsvRXBaIVGlch0rVo+mpzVIn5KPbaEXhfIF0vL3Pvi6A
	RRVe49OrhOfhgPhrP42lKQ6uq+n8Q3EA=
X-Gm-Gg: AY/fxX4h5rtEYXVEevZYBtUBWu2w8bBJ1ZmV206FkOlXy7mmv0HN74ojxb9kawfISp9
	Ypcqv9IchmBfbPG2cxk3RCApEKgUbNNxTByFA7DJddMyZxZ3sttqrCwLKxE/y/D3sSsYLRDdDes
	ZReOQUCoYIXbTj1132HEp/PmU9b9ZmmTLN4PzMbLkBJwJKVcpcuPGlFTVtvXgUP8VtAZ2nm10aN
	ANXmnqnz5nsHO8XfZ1HIWwKA0D63bEVAdksv2wtYy5YT1+tG+2r5bkgkaHieY9C9I9kUraQNCz4
	2c6/KL69PUgGuqpSMVKCDh9ncQ==
X-Google-Smtp-Source: AGHT+IFxpPbCdRMZz9XBjuHDTCZ9dsvF1etOQHeAP0z0LVfgm/LsQx3fse+ZuSSLzWCYXnUik92Z0mf6l8CpZRvS100=
X-Received: by 2002:a05:6808:470a:b0:453:5e88:29b9 with SMTP id
 5614622812f47-4559bf4860dmr1211437b6e.28.1765472961939; Thu, 11 Dec 2025
 09:09:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <fc7dede0-30a4-4b37-9d4c-af9e67e762c7@lunn.ch>
In-Reply-To: <fc7dede0-30a4-4b37-9d4c-af9e67e762c7@lunn.ch>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 11 Dec 2025 17:09:10 +0000
X-Gm-Features: AQt7F2qtonLBE9deAK2-llt-SKUXbtrFWqqvYj6_-uA64Lmu8yrBroU6XbFO-mo
Message-ID: <CAD4GDZxYVwzxHBRnpG1RnkaD3wPW+-GUozhBg7hzO-_3X_PPpA@mail.gmail.com>
Subject: Re: Concerns with em.yaml YNL spec
To: Andrew Lunn <andrew@lunn.ch>
Cc: Changwoo Min <changwoo@igalia.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 17:04, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Dec 11, 2025 at 03:54:53PM +0000, Donald Hunter wrote:
> > Hi,
> >
> > I just spotted the new em.yaml YNL spec that got merged in
> > bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
> > because it introduced new yamllint reports:
> >
> > make -C tools/net/ynl/ lint
> > make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
> > yamllint ../../../Documentation/netlink/specs
> > ../../../Documentation/netlink/specs/em.yaml
> >   3:1       warning  missing document start "---"  (document-start)
> >   107:13    error    wrong indentation: expected 10 but found 12  (indentation)
> >
> > I guess the patch series was never cced to netdev or the YNL
> > maintainers so this is my first opportunity to review it.
>
> Maybe submit a patch to this:
>
> YAML NETLINK (YNL)
> M:      Donald Hunter <donald.hunter@gmail.com>
> M:      Jakub Kicinski <kuba@kernel.org>
> F:      Documentation/netlink/
> F:      Documentation/userspace-api/netlink/intro-specs.rst
> F:      Documentation/userspace-api/netlink/specs.rst
> F:      tools/net/ynl/
>
> adding
>
> F:      Documentation/netlink/specs

It is covered by the Documentation/netlink/ entry:

./scripts/get_maintainer.pl Documentation/netlink/specs/em.yaml
Lukasz Luba <lukasz.luba@arm.com> (maintainer:ENERGY MODEL)
"Rafael J. Wysocki" <rafael@kernel.org> (maintainer:ENERGY MODEL)
Donald Hunter <donald.hunter@gmail.com> (maintainer:YAML NETLINK (YNL))
Jakub Kicinski <kuba@kernel.org> (maintainer:YAML NETLINK (YNL))
[...]

>
> I'm also surprised there is no L: line in the entry.

That's something we should address, thanks!

