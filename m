Return-Path: <netdev+bounces-241728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08518C87C4B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8C014E124D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DF13090E1;
	Wed, 26 Nov 2025 02:06:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD01F3FED
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764122770; cv=none; b=leV68UWw8e04wFmfK3BYXd9gKZonVfaYqVptwazpzB2y9vKgOFNlzKh3we56tGXbrKm3zIXZENiENA+ziVU6wGxKbqihztSv9Lw/kO2rB9TS5ksV/meok5/sCK8CsLtibRBNrdtdZK8IThHGUEw+ATGK8wiUdeYhEaFmPxrei1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764122770; c=relaxed/simple;
	bh=eHsd3TSZ3G/BGYnBQbxM688dMPsb3i+X4LJ+UCcEK6k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZVx9nsQovZM69GKdrriyosIkXze3rlHRTHLRH2MOouEvmNDF7c5CpW7gzpxq+lzaxUzSnnAYzRJAWXkHe2FeUdnieQ5yj6qriSLmKa+Xy0WneSHJBfGkABUpPKz4Exo7T5WSgNR0Sd4w6VRIQw4ZWe+QxrQgq4boTxQa20k6Bps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz8t1764122752ta3fdf028
X-QQ-Originating-IP: FFqWERfumkrW2o5KBHiqxPTpLXzehB+mbLurzoj2ysg=
Received: from smtpclient.apple ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 10:05:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7530743812056573258
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v1 4/5] net: bonding: add the
 READ_ONCE/WRITE_ONCE for outside lock accessing
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <CAL+tcoCi7+8p2TA21cQvmAP2OLpWRzY03NB9Usp5p39KcgoSBQ@mail.gmail.com>
Date: Wed, 26 Nov 2025 10:05:39 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3ECD7BE4-98BF-4C99-B47C-C00FA448B89E@bamaicloud.com>
References: <20251125084451.11632-1-tonghao@bamaicloud.com>
 <20251125084451.11632-5-tonghao@bamaicloud.com>
 <CAL+tcoCi7+8p2TA21cQvmAP2OLpWRzY03NB9Usp5p39KcgoSBQ@mail.gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OQhZ3T0tjf0aJ/bYJ1h8W5fbgOeKmtn2V9psx53v6+wC+5eZnUtUWXw/
	D9Ep7K8SWZDxsDbm1GkRIlcxhBnu/e8xpW11Whozg+aJoLUgLna7HqyCTiKEpsoiNCuEtr+
	j+JqWMWN2ZZKaPfCUTkPgMQqyVhRqlmfFBmcjrPgtsreG+sguky3t+cZJJ4iODEjPw9ZyyH
	EMqFeVrX496fCfWHm2LGPR11ylbojEovw4SuvtxkUVcc5drV6uf0TSisOq00oLNnHKU0rNo
	sGpELqVaTnTwes0hEamVM+HlRAWyLEzkrJVSKEJQb7ZbrDPbJSYEVeRYfmsg8S2txm0lH3S
	m5IMTk/5KUGfDqoUnPrnyo63xAT1EOx1trtM3/TpuGAec49LeCkQAWPYrUkZ/t491+jRfOA
	k57RccpeejWNjo3Aq4JSpnlqwpOqvp2tJNUmk4egpAnXQFuUhEysYPW7pY2KJu1ls7GbVLH
	FkDjHNUHqBMouqNB4NrUW9p0m7WTj8Alme0deGPKH9IeQHBEeVykK7BYbH3TC9CPVbg6fuI
	QBRQGLV8UNfZiyNSi2dNuc5BRJn3afNr8m6boBrcd0vmObMLpcbrEgMwrol1rrXq6xII2+1
	/O4XQ7O/O9FqgWNz7KMCzySh5PaKtnJvKBhJ68wLmN5tznDzHhT5J6fwHSyoE5FIx+levV/
	XnGFrqJNCeoMXTapi+WCTNOsQ1SufyK2pWHralY2yF8+N1Dr5P1RVyi5dhj2V+NrCsenZLe
	lpmoVQKIcOvVpC3ycvdofhPGbhg+FQBVtIdgi0nqoxfrBZUA1JGw39KEf5KJzo+tVQpYDSl
	KQcOvIfcM7jAyY9GChEwgwiYPomXZwR0drQbIZBvC/n7EVtXctmXKHT1wW/858Dnmxk9RFL
	ngwGBYJFIfRy/h5HEWk5IgipObNDfF3BhsdmXNCUysmzjbcNMBn7Cb/OPqP2uFEWAKob9sC
	badCEE0yGdZpFYEMLlK5l2qztmNqA0+CGfomehqfjMUEPUOaaT/GYbuHfyUruJIHno5JYjo
	MMHenaGTYF/7Xbx7pvHrR9G5CbwTE=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0


> On Nov 26, 2025, at 09:25, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>=20
> Also there is a lack of another bracket... It's not hard to spot this
I'm very sorry. Before sending the email, I adjusted the order of the =
patch files, 4/5 and 5/5.

