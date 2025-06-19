Return-Path: <netdev+bounces-199597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1842AE0E71
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7E34A277C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 20:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1413F246BAD;
	Thu, 19 Jun 2025 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rVUKW6py"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C822244686;
	Thu, 19 Jun 2025 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750363622; cv=none; b=hEDVq3g2KNtNpU0BJWS178Kqaonw7VfbPPUgud5etqkqgrFIPX3jUuZOElpPqlVOlo7PBF8j7cLJNIG+JI1Jqdz8HFjeDkzlh2ZVT/trxFwyaONeiLawCEkTH1VDszgPI1B+NLCUuk0JJjFVmce/3cv+OZnF/gClf4DnVtpRlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750363622; c=relaxed/simple;
	bh=x8nkZpBV8B1RfMXzIjaeghHZ0IZmHLuUDZJUgB28/C8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jpXM3fHQOGP1X2GQO8r6lzYTlX2H/D+tAtdWUOkX3sQPYvPe92Bigcp1UwnDkQwJ6qke5ds6E2U9KMTBRjk3EjfpM4qN/2Cpgpwv0krru8IuczTWwCBawMMl06HTE68E9e31ggeYL8u27mwymQOQlA9RcVQQyh6FCAhdrixLi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rVUKW6py; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7B75A41AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1750363619; bh=R9c4vgL7SuYf1vxfbbp+JsNTP8qE+XIiFw2ZuOXL6S8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rVUKW6pywt1KAVhnsKmGFtuxGHE20Sn/qoL2NdO84G2FNt+qf2dslll76hqnx+p3W
	 Bd8yIVeDuuAZh6A0J23a4GRqbZ5ovmDB7rPgiYGco+FQKEck4Brit0VA93ggk2Nkh2
	 fuK6N4b4x9AyLkHMukIzKOOejFe5RvgZx43Wg1RiYO5x+AulGvGXdv68l8v+K69shU
	 VTbrrzDKYi5iMvUni58QUNlolykUJlpgzMNIpVB2ol/UH6gdYhzcSQoaHEcJwpdLK/
	 oY4FQkcPtcn7eSEeDqLQ7cn1VX67jckzQV/DSvPU5WhGIAedv/Xg8O9MhM+OUxUhiS
	 LaJERjmb96X5Q==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7B75A41AD8;
	Thu, 19 Jun 2025 20:06:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jakub Kicinski <kuba@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Akira
 Yokosawa <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Ignacio
 Encinas Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>,
 Marco Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben
 Wauters <rubenru09@aol.com>, Shuah Khan <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
 netdev@vger.kernel.org, peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v4 12/14] MAINTAINERS: add maintainers for
 netlink_yml_parser.py
In-Reply-To: <20250614124649.2c41407c@kernel.org>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
 <ba75692b90bf7aa512772ca775fde4c4688d7e03.1749891128.git.mchehab+huawei@kernel.org>
 <CAD4GDZzA5Dj84vobSdxqXdPjskBjuFm7imFkZoSmgjidbCtSYQ@mail.gmail.com>
 <20250614173235.7374027a@foz.lan> <20250614103700.0be60115@kernel.org>
 <20250614205609.50e7c3ad@foz.lan> <20250614124649.2c41407c@kernel.org>
Date: Thu, 19 Jun 2025 14:06:58 -0600
Message-ID: <877c17h4wt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Sat, 14 Jun 2025 20:56:09 +0200 Mauro Carvalho Chehab wrote:

>> I'm more interested on having a single place where python libraries
>> could be placed.
>
> Me too, especially for selftests. But it's not clear to me that
> scripts/ is the right location. I thought purely user space code
> should live in tools/ and bulk of YNL is for user space.

I've been out wandering the woods and canyons with no connectivity for a
bit, so missed this whole discussion, sorry.

Mauro and I had talked about the proper home for Python libraries when
he reworked kernel-doc; we ended up with them under scripts/, which I
didn't find entirely pleasing.  If you were to ask me today, I'd say
they should be under lib/python, but tomorrow I might say something
else...

In truth, I don't think it matters much, but I *do* think we should have
a single location from which to import kernel-specific Python code.
Spreading it throughout the tree just isn't going to lead to joy.

Thanks,

jon

