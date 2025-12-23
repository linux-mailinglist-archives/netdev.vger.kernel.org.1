Return-Path: <netdev+bounces-245785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CDDCD7E28
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 03:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19994300EA2B
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 02:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5F0285CAD;
	Tue, 23 Dec 2025 02:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ArCKmIYk"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476C2580D7
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457508; cv=none; b=Jhl6Y0UQrBzmZXr/ZE2OZHWKuj1gnD+Ig/q/XIYST9FxMRux2cPF+0nRCAvrI6ycBNnh0TDY3OYRkATWNpr6trZ08kk6SVlhjxTBB32Ef5xDb61ep3/ft9TpvJbaTZ63j7c7evXDaw25GAK6EZ8pCajRiQYZajj40BEJn2FV8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457508; c=relaxed/simple;
	bh=dIKWOo8YL9XeTr1lW67VL/yCD0Tufj7qehZgxf04a+Q=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=oEnOGn1foR0uMkPNXQ2z/aJCdRJlEk3uTEiW4pgEeIEN/b0+TphZaSAdCB4Kw81Ampo+VPHwJbgOTLvR9JE+rf4nV6YcDRpFCI2RKSB5++aWVARNFj8NvzGvnyDikn6j9n8h4X7/anYbcZr0OWcChLCgdjIUd6xCzsVcUo0VCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ArCKmIYk; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766457494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/A7HbKpgTjJW7jQqPeYrZs5kL1SDV4eFk1EHi5q6zlY=;
	b=ArCKmIYkignxuHuuMHgL8eCn2R8rYz1fF9lucl0Nr5BB9hFnsO13kSlOqeqrNukY82ubNR
	dKo5g/dCV5bP/pWxwBa/djwNhB57jGcq3kJfZjD1S/FTM0xRIXXHPyRxhL+oYIGcA9Z9zt
	D+wDwU9NZl71qyt3Jsk95uZonT1ewcM=
Date: Tue, 23 Dec 2025 02:38:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <7f7c32e627e7d0fd1be12865f253a67cd3af29a8@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v2] ipv6: fix a BUG in rt6_get_pcpu_route() under
 PREEMPT_RT
To: "Steven Rostedt" <rostedt@goodmis.org>, "Eric Dumazet"
 <edumazet@google.com>
Cc: netdev@vger.kernel.org,
 syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, "David Ahern" <dsahern@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20251222122628.38e9bc89@gandalf.local.home>
References: <20251219025140.77695-1-jiayuan.chen@linux.dev>
 <CANn89iLeASUZyonYSLX0AG5mbC=gxux0efehkBc_j1bbj6xrvA@mail.gmail.com>
 <20251222121639.3953ea08@gandalf.local.home>
 <20251222122628.38e9bc89@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

December 23, 2025 at 01:26, "Steven Rostedt" <rostedt@goodmis.org mailto:=
rostedt@goodmis.org?to=3D%22Steven%20Rostedt%22%20%3Crostedt%40goodmis.or=
g%3E > wrote:


>=20
>=20On Mon, 22 Dec 2025 12:16:39 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>=20>=20
>=20> On Mon, 22 Dec 2025 09:50:58 +0100
> >  Eric Dumazet <edumazet@google.com> wrote:
> >=20=20
>=20>  > Link: https://syzkaller.appspot.com/bug?extid=3D9b35e9bc0951140d=
13e6
> >  > Fixes: 951f788a80ff ("ipv6: fix a BUG in rt6_get_pcpu_route()")=20
>=20>=20=20
>=20>  I would rather find when PREEMPT_RT was added/enabled, there is no
> >  point blaming such an old commit
> >  which was correct at the time, and forcing pointless backports to ol=
d
> >  linux kernels.=20
>=20>=20=20
>=20>  Ack!
> >=20
>=20Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
>=20
>=20That was the first commit to enable PREEMPT_RT on any architecture (j=
ust
> happened to be x86).
>=20
>=20-- Steve
>

Thanks Steve, it helped a lot=20!

