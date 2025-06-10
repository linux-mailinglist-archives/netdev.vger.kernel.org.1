Return-Path: <netdev+bounces-195975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B37AD2F89
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCBE3A3B78
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE271280001;
	Tue, 10 Jun 2025 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mrVP/4ix"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1322172F
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543015; cv=none; b=IXy6RQi/fgq3zcEqYq8jS6GRpXoxnVjnWGLpWAAr5Y355U9L2WW5600Wt3EKz2ZPbOQ+hrRtcsQJFZ2u5gX6iFetv7NG112XLHouWFlOKhsmQsTeSv3lM4JopO9ioR0P/G8IMylridWSQlnGyJQaq2Vs4Avlf56iLr9WYq+nI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543015; c=relaxed/simple;
	bh=uASWbJWfA+bnrlMxN3DTI/iHhc2vlZbgrWbXY+nWJQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmYLDsx9r0gZbKMs6OEg89Cm9gN38C398v+rCFZKssiFpiHW4LODe4FEPj9OgnsppHpYz6SOW1xoW8vsjCzvXHRlHMdIxTXLc4efETgi4mX4u+492CEjgTR3twUHwrIJ/1IsIW/mXP0Xi/op3WLPGWLdSj404NmWCo+6yquHhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mrVP/4ix; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749543004;
	bh=uASWbJWfA+bnrlMxN3DTI/iHhc2vlZbgrWbXY+nWJQc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mrVP/4ixgKIk6QHFmCqbSlvFJstlBQPp1YQH0HVmS9XiNSGp5yz1Nib4xnIhhPjCp
	 fBZRYn/hDlmVSv+Pg/PY/b9iqjSYz5YdyK5SZIus0X69Cwre2bwCYyD8pMZXulY5Js
	 t/yomb1f0KqujflnxmZhvchGOBUjxWyOq5hM0iaOH+yqMwWZlIjuvSW2cXAekxhJMq
	 pO8LPvK2EZe40OsNPxVmBUz4MmBzT7U/BpKDRw63P3+PCCBk80rUtRndFGtRNkWJeO
	 GmgHbTOR6cL0kSw5jJQ4ti6ZWPzPKrK9VAtcF0wsOfYPbAGycu09IEPN3jaZoDDkGX
	 n5B+ggyrvbv1Q==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 402CB640BB;
	Tue, 10 Jun 2025 16:10:03 +0800 (AWST)
Message-ID: <155ebc877a4a20e69c20ff43e2457e2cca5586a6.camel@codeconstruct.com.au>
Subject: Re: [PATCH 6.6.y] Revert "mctp: no longer rely on
 net->dev_index_head[]"
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Sasha Levin <sashal@kernel.org>, 
 Matt Johnston <matt@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Patrick Williams <patrick@stwcx.xyz>,  Peter Yin
 <peteryin.openbmc@gmail.com>
Date: Tue, 10 Jun 2025 16:10:03 +0800
In-Reply-To: <20250609083749.741c27f5@kernel.org>
References: 
	<20250609-dev-mctp-nl-addrinfo-v1-1-7e5609a862f3@codeconstruct.com.au>
	 <CANn89iJd5FZiOyaHEDrESsZ8h+N7ngfkCNnTRNULxV+xM+qMQg@mail.gmail.com>
	 <c4c4f4b58dccb6544f03e4da1827ec8f4f9c4a54.camel@codeconstruct.com.au>
	 <20250609083749.741c27f5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

> > Either way works for me, but I assume that changing the semantics of
> > for_each_netdev_dump() would be fairly risky for a stable series,
> > especially given the amount of testing 6.6.y has had.
> >=20
> > Jakub, as the author of that fix: any preferences?
>=20
> We should backport it, I can't think of why someone would depend=20
> on the old behavior.

OK, sounds good. Thanks for the input, I'll get a patch sent to stable@
shortly.

Cheers,


Jeremy

