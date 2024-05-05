Return-Path: <netdev+bounces-93506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69548BC1A2
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 17:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7998C2819FB
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574D135280;
	Sun,  5 May 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvsyYDKL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC025381B1
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714922115; cv=none; b=hwfUgCQQO5fqX/UL/wevMeEZNKBE3Gbyd1y2VAh6jquqBnJYkZqwOQ4y2oKEomn3nG1Fi3cCSIFC520fHjhtmrcfMX0utEyvoNvpxn6G/FryYrTbH+qW0v5Lvu6WdajUZWCINb2AFktd/dXP9RuD0+JoMOax7RmS8zS3/ROBqaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714922115; c=relaxed/simple;
	bh=Lr1cOQzOVYaLmeK5ejjDCqjyeOEtCEtirD6cfuzwuh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8LHSV0XfDl5RoeGx3dXYl71g8w3+7ESIgQKvSYacmvZ6ImgfWdZKAKU8QkrrXvZ7NnhaKM+7Ta9pVkDK5HcNqMljfUSgeTDIAI2QLg3+KW0WBoR/mN0bNkOLoj7zGdznDiw3W9yVgpdaT5xEu+372jOPgGYz5teN42MkBoWElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvsyYDKL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso6131a12.1
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714922112; x=1715526912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f47fjo0RQeq/0SPTYJBohpkHIWTD/vEUBtpg+a96S/k=;
        b=MvsyYDKLuKfIGwMVbbvIOxP+IrpDSiEDpoABlH1BtGLN0pwSzdrWRnco7spt9rkkuW
         9ONb3IGjPrrdhCtV7NRVG2BtbiOg+RC9w6RGrp67JsFhDhLIlxPBO8/xBgvgVr1vADBZ
         cSmMU0F6SBwPmb0m0uCMdE5qHb1tl3PmUlLRuL5/C/IJuLx0pvEXOj5bnvkk4XozRmQp
         8RKmexcPJv1ODMJo9cV/GJ8ZRTuj7vxD6FpQpiXr0kJoiW4000OLpoWX4ECWkH91RusK
         JzCBCiitP0LqPRLoSgsdT5SPqcFF1jDeRqtok1AMXUlvcEdwz27lZeczimhfdCVpXjoT
         TeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714922112; x=1715526912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f47fjo0RQeq/0SPTYJBohpkHIWTD/vEUBtpg+a96S/k=;
        b=E75qK1+QLGVRb81d6o8UkfXA1lmud4590Qy+WRjuOQET2O9oWUdqAr+oTvknubwRG0
         npICIapOO8xqVlMpDNoOT/Ah/eolmBJDKawQ08pvgKC0TFWXxsdMpVGg4gPkH9z4n0rq
         scZIdOTrsF5FBb7i8zX0iDxryc5ZiCcT+nM3b+VPCVN76s8slS21AnSk1lc68N5v/d3+
         jrXkcJHbZ2vqum/u6jsm3orJdJr1jUoRzAnk1Nf972b5ecZF9zg3xJJ1RTyvs/sBquMz
         mqjfKPDJwA30wyggsH2+K8LYWl16XgsEdv9YvKBNKMxbXjHvDNslCa0vXFAxzBYQPpA1
         KVMg==
X-Forwarded-Encrypted: i=1; AJvYcCWS4EVtk/V6CWUDdRFfSQcNvDEfWCCuVzsOjHU+VliruN7I1Zu9zwzRw/VM6UQ+RgDE+sUhxlg5AWjooOXafPNC2gQvdatw
X-Gm-Message-State: AOJu0YyC0niNIs8eA5aoPAS3MpxI7OG7DRWGGQinvp3VE4EUwmazDv/r
	bqRVqsL6Rp5Wg7a9tton7Uduo2tim8VbDdWCVn4b5NvypgrZp3JdKr4RG9amM+M45mSHBtJFzXv
	d1Y5s2LDWl2SBaz+nanPO7Wf1Z5VkaDGtkcpR
X-Google-Smtp-Source: AGHT+IFv5zcmdfipVF/zV85XBKAbtHpY1Kc/dTJbsnGv7YbmQEho+QxB9+Q8kyY7wGZ4zIx31d36hujt38rL+yyLtJw=
X-Received: by 2002:a05:6402:510b:b0:572:9eec:774f with SMTP id
 4fb4d7f45d1cf-572e0679817mr218758a12.0.1714922111719; Sun, 05 May 2024
 08:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com> <20240503192059.3884225-6-edumazet@google.com>
 <20240505144608.GB67882@kernel.org> <CANn89i+ZKZrbmqxKU33XgN_ZyqqkFa7+BqAqFWCYdj3He1Xy8g@mail.gmail.com>
 <20240505150616.GI67882@kernel.org>
In-Reply-To: <20240505150616.GI67882@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 5 May 2024 17:14:58 +0200
Message-ID: <CANn89iJO6mAkw5kDR5g7-NvpCZOGh9Ck1RePmXps60yK+55mSg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] rtnetlink: do not depend on RTNL for many attributes
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 5:06=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sun, May 05, 2024 at 05:00:10PM +0200, Eric Dumazet wrote:
> > On Sun, May 5, 2024 at 4:47=E2=80=AFPM Simon Horman <horms@kernel.org> =
wrote:
> > >
> > > On Fri, May 03, 2024 at 07:20:56PM +0000, Eric Dumazet wrote:
> > > > Following device fields can be read locklessly
> > > > in rtnl_fill_ifinfo() :
> > > >
> > > > type, ifindex, operstate, link_mode, mtu, min_mtu, max_mtu, group,
> > > > promiscuity, allmulti, num_tx_queues, gso_max_segs, gso_max_size,
> > > > gro_max_size, gso_ipv4_max_size, gro_ipv4_max_size, tso_max_size,
> > > > tso_max_segs, num_rx_queues.
> > >
> > > Hi Eric,
> > >
> > > * Regarding mtu, as the comment you added to sruct net_device
> > >   some time ago mentions, mtu is written in many places.
> > >
> > >   I'm wondering if, in particular wrt ndo_change_mtu implementations,
> > >   if some it is appropriate to add WRITE_ONCE() annotations.
> >
> > Sure thing. I called for these changes in commit
> > 501a90c94510 ("inet: protect against too small mtu values.")
> > when I said "Hopefully we will add the missing ones in followup patches=
."
>
> Ok, so basically it would be nice to add them,
> but they don't block progress of this patchset?

A patch set adding WRITE_ONCE() on all dev->mtu would be great,
and seems orthogonal. Note that we already have many points in the
stack where dev->mtu is read locklessly.

