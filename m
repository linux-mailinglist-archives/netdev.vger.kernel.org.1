Return-Path: <netdev+bounces-96993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124CA8C894C
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432041C222D1
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88E12D201;
	Fri, 17 May 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ueqelzg1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0954673
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959492; cv=none; b=HQRWZS6MHtdCO2volNuN6M1NY8M2Bxmlv3x3GCIew4YPNS/HnmYnichwd+ZRngwbNZCN9EbsvaKVxC88vY8yASHHTv7YxEXoKjfmHvMNekb2PaRmSEhHiR51OPY1LYIY3LSIQ2KYd9pn7uy4shG5Mc+YkBNcXGXZA4RWmYMLd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959492; c=relaxed/simple;
	bh=cUMkYnXb2sVcgkJHzzstVudL5onkuBflFC5M66AkkAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzZntYegMGJ0RGP2Hl6LKU4I/pQPbgWR2z3a+o9LIlYVt/roFQCSNEW1bmmXjhWHCcOh4l4kwN7gwZ6MWVHxIR8bSNVqgA6Hdj6thwhoDldy8zkrFanaWawvlMdJZXLTQX6q3aOEvoxOZBA5c6l0F/r4gXbG87aW4YLxvk8yozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ueqelzg1; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VgrNl6JJbz13M3;
	Fri, 17 May 2024 17:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715959479;
	bh=8cODBbaV2wOKAiX030YC9XoVHmqVf2+m2ed+C0a8c+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ueqelzg19343f69VenrcasMFnBmalWOXY0aHal5RLHRC3JZaZNw/mA+RojjzK//oI
	 2fqXEesvnQJpgmXflhkK8FMJqhX18qIrlJtCTCiPqyD5u1zFUkjgcgxaF24m5BO1z8
	 r4r09+By6TmkuJgehvJPvua7gSEdlisBPA2vXqm8=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VgrNl30d9zsjt;
	Fri, 17 May 2024 17:24:39 +0200 (CEST)
Date: Fri, 17 May 2024 17:24:41 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH v1 03/10] selftests/landlock: Create 'create' test
Message-ID: <20240517.Wieciequ2iec@digikod.net>
References: <20240408093927.1759381-1-ivanov.mikhail1@huawei-partners.com>
 <20240408093927.1759381-4-ivanov.mikhail1@huawei-partners.com>
 <ZhPsWKSRrqDiulrg@google.com>
 <9a8b71c6-f72c-7ec0-adee-5828dc41cf44@huawei-partners.com>
 <20240508.Kiqueira8The@digikod.net>
 <986f11a9-1426-a87d-c43e-a86380305a21@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <986f11a9-1426-a87d-c43e-a86380305a21@huawei-partners.com>
X-Infomaniak-Routing: alpha

On Thu, May 16, 2024 at 04:54:58PM +0300, Ivanov Mikhail wrote:
> 
> 
> 5/8/2024 1:38 PM, Mickaël Salaün wrote:
> > On Thu, Apr 11, 2024 at 06:58:34PM +0300, Ivanov Mikhail wrote:
> > > 
> > > 4/8/2024 4:08 PM, Günther Noack wrote:


> > > > > +		{
> > > > > +			TH_LOG("Failed to create socket: %s", strerror(errno));
> > > > > +		}
> > > > > +		EXPECT_EQ(0, close(fd));
> > > > > +	}
> > > > > +}
> > > > 
> > > > This is slightly too much logic in a test helper, for my taste,
> > > > and the meaning of the true/false argument in the main test below
> > > > is not very obvious.
> > > > 
> > > > Extending the idea from above, if test_socket() was simpler, would it
> > > > be possible to turn these fixtures into something shorter like this:
> > > > 
> > > >     ASSERT_EQ(EAFNOSUPPORT, test_socket(AF_UNSPEC, SOCK_STREAM, 0));
> > > >     ASSERT_EQ(EACCES, test_socket(AF_UNIX, SOCK_STREAM, 0));
> > > >     ASSERT_EQ(EACCES, test_socket(AF_UNIX, SOCK_DGRAM, 0));
> > > >     ASSERT_EQ(EACCES, test_socket(AF_INET, SOCK_STREAM, 0));
> > > >     // etc.
> > 
> > I'd prefer that too.
> > 
> > > > 
> > > > Would that make the tests easier to write, to list out the table of
> > > > expected values aspect like that, rather than in a fixture?
> > > > 
> > > > 
> > > 
> > > Initially, I conceived this function as an entity that allows to
> > > separate the logic associated with the tested methods or usecases from
> > > the logic of configuring the state of the Landlock ruleset in the
> > > sandbox.
> > > 
> > > But at the moment, `test_socket_create()` is obviously a wrapper over
> > > socket(2). So for now it's worth removing unnecessary logic.
> > > 
> > > But i don't think it's worth removing the fixtures here:
> > > 
> > >    * in my opinion, the design of the fixtures is quite convenient.
> > >      It allows you to separate the definition of the object under test
> > >      from the test case. E.g. test protocol.create checks the ability of
> > >      Landlock to restrict the creation of a socket of a certain type,
> > >      rather than the ability to restrict creation of UNIX, TCP, UDP...
> > >      sockets
> > 
> > I'm not sure to understand, but we need to have positive and negative
> > tests, potentially in separate TEST_F().
> 
> I mean we can use fixtures in order to not add ASSERT_EQ for
> each protocol, as suggested by Günther. It's gonna look like this:
> 
>      ASSERT_EQ(EAFNOSUPPORT, test_socket(&self->unspec_srv0));
>      ASSERT_EQ(EACCES, test_socket(&self->srv0));
> 
> I think it would make the test easier to read, don't you think so?

Yes, this looks good.

