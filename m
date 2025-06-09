Return-Path: <netdev+bounces-195714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D2AD20AC
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA131889FEB
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA5125A2B1;
	Mon,  9 Jun 2025 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="SMBZqitT"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6BA210FB
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749478438; cv=none; b=Mgv9Ost3QUabJjKvzTJztenndbZ2NyXpKegvzVQvlQhz3tVMsXpxW/EHOcghHdL/v+bsTPUMRJLE/SL8clKZV3cGgJkyyqovywQpZnk+j9D9afGsxwcTRBBWYDrP+Zz3U2z53iy5w+zRiw6m4knT2THdRhrwDdqqLhiGQ8tuTjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749478438; c=relaxed/simple;
	bh=tNF048z8cwYTHZXg/yh4+/yzCnNe7ihhQM1oQ63rclc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=puEq52Ikqy5qXnlJ4rB81fWU+P9OlpHQ3XrQdiOV2MfChVWnSsrDgCBV1gvwZHjCYn2GsBGB2Gj54ivezK/X6H7bpOh9W2t3d839Twmd9JpHdpFBisJUx+FuYHvjRGW32KUizrr+lloeCxzT92zR4AzxwEIEiiL2UKrWltmKGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=SMBZqitT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749478434;
	bh=tNF048z8cwYTHZXg/yh4+/yzCnNe7ihhQM1oQ63rclc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SMBZqitTACCIY6NUYRQBNioHPJdmPMt8CZ3hMiJ3SSotkknEpGYTTk2zrRapzqBD4
	 KftEqc89/Utf5UNeI+db/3EatvA1q7cnQBJiGv82OIebDgTseXS5q8s1L14AvXzYwp
	 3rFvDS9OYqHy6cTH5zy151QOeyxofyNkK7HXyJMTY9v8nJe/6t2gOvPKh+QQOc8yhq
	 s5rluC630eUUDPIXV1Q6VRpIvdhosbXGeSxUbjXg73PJqbPdFFotZzjrrQw2qDgwdX
	 pS20IS/eiL74NbQXyFQrSLs2smpIrd5oSmQZeLzdHzOAdhfLgs/803uYsXxSDpC2nG
	 Dm1z19uaGkElg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 29662640A1;
	Mon,  9 Jun 2025 22:13:53 +0800 (AWST)
Message-ID: <c4c4f4b58dccb6544f03e4da1827ec8f4f9c4a54.camel@codeconstruct.com.au>
Subject: Re: [PATCH 6.6.y] Revert "mctp: no longer rely on
 net->dev_index_head[]"
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Eric Dumazet <edumazet@google.com>
Cc: Sasha Levin <sashal@kernel.org>, Matt Johnston
 <matt@codeconstruct.com.au>,  "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, Patrick Williams <patrick@stwcx.xyz>, Peter Yin
 <peteryin.openbmc@gmail.com>
Date: Mon, 09 Jun 2025 22:13:52 +0800
In-Reply-To: <CANn89iJd5FZiOyaHEDrESsZ8h+N7ngfkCNnTRNULxV+xM+qMQg@mail.gmail.com>
References: 
	<20250609-dev-mctp-nl-addrinfo-v1-1-7e5609a862f3@codeconstruct.com.au>
	 <CANn89iJd5FZiOyaHEDrESsZ8h+N7ngfkCNnTRNULxV+xM+qMQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Eric,

> I would rather make sure f22b4b55edb5 ("net: make
> for_each_netdev_dump() a little more bug-proof")
> is backported to kernels using for_each_netdev_dump()

Either way works for me, but I assume that changing the semantics of
for_each_netdev_dump() would be fairly risky for a stable series,
especially given the amount of testing 6.6.y has had.

Jakub, as the author of that fix: any preferences?

Cheers,


Jeremy

