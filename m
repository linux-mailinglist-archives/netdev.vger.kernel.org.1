Return-Path: <netdev+bounces-46947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCE37E74EA
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 00:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BDA1C20B8A
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 23:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4506C36AE5;
	Thu,  9 Nov 2023 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQc4LdRa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260FB38DC5
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 23:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA4FC433C7;
	Thu,  9 Nov 2023 23:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699571043;
	bh=q25fxnyRwCKyB6X8dMtvC2LfwbcbhvRVubBjYIAkRKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fQc4LdRaV2jqYQH4yFSwfyC8rn9ZhyExtgelVpdXl1F11rzQCI1vYfTxWC//Qw4DI
	 Om4dg2gugBNTsWUnhaQa7jsr5Z1IsFyRWcbGd5H7+qWqAAupPQBhetiIhccB5l/fcD
	 Ssjd003w2kcVfl+1USSNSuc9xpCMTq5APPgqlEqIZORqz/5CJFCZS/j6FE+k5uLR5z
	 282CPD/P4veeOnw+Xhj9NjLQY7NgVVM+s/Sdgc1D0excfGr1TzWrd2Fqz0RRPqgTOo
	 uSs6HbUT74Y9Q37Yi6fXK5d+JyaIHqyB4YO5TOvt4Lzwwq2lBGSdLGTqctcdc99O7S
	 2bySd79WnWVNA==
Date: Thu, 9 Nov 2023 15:04:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <VishvambarPanth.S@microchip.com>
Cc: <f.fainelli@gmail.com>, <Bryan.Whitehead@microchip.com>,
 <andrew@lunn.ch>, <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <UNGLinuxDriver@microchip.com>, <edumazet@google.com>
Subject: Re: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Message-ID: <20231109150402.12fda9cf@kernel.org>
In-Reply-To: <0d0627cbd32afb813b75b485ea8e979ac027482d.camel@microchip.com>
References: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
	<20231004122016.76b403f0@kernel.org>
	<b1f64c44-0d1c-480e-a272-fb017e7d8673@gmail.com>
	<20231004130957.2d633d03@kernel.org>
	<ee81b2128f5178df95a1678d2cf94ad4edf2c9e9.camel@microchip.com>
	<0d0627cbd32afb813b75b485ea8e979ac027482d.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Nov 2023 10:53:26 +0000 VishvambarPanth.S@microchip.com wrote:
> Thanks for your feedback. I apologize for the delayed response.
>=20
> The data presented in the patch description was aimed to convince a
> reviewer with the visible impact of the performance boosts in both x64
> and ARM platforms. However, the main motivation behind the patch was
> not merely a "good-to-have" improvement but a solution to the
> throughput issues reported by multiple customers in several platforms.
> We received lots of customer requests through our ticket site system
> urging us to address the performance issues on multiple kernel versions
> including LTS. While it's acknowledged that stable branch rules
> typically do not consider performance fixes that are not documented in
> public Bugzilla, this performance enhancement is essential to many of
> our customers and their end users and we believe should therefore be
> considered for stable branch on the basis of it=E2=80=99s visible user im=
pact.
> Few issues reported by our customers are mentioned below, even though
> these issues have existed for a long time, the data presented below is
> collected from the customer within last 3 months.
> =20
> Customer-A using lan743x with Hisilicon- Kirin 990 processor in 5.10
> kernel, reported a mere ~300Mbps in Rx UDP. The fix significantly
> improved the performance to ~900Mbps Rx  in their platform.
> =20
> Customer-B using lan743x with v5.10 has an issue with Tx UDP being only
> 157Mbps in their platform. Including the fix in the patch boosts the
> performance to ~600Mbps in Tx UDP.
> =20
> Customer-C using lan743x with ADAS Ref Design in v5.10 reported UDP
> Tx/Rx to be 126/723 Mbps and the fix improved the performance to
> 828/956 Mbps.
> =20
> Customer-D using lan743x with Qcom 6490 with v5.4 wanted improvements
> for their platform from UDP Rx 200Mbps. The fix along with few other
> changes helped us to bring Rx perf to 800Mbps in customer=E2=80=99s platf=
orm
>=20
> This is a kind request for considering the acceptance of this patch
> into the net branch, as it has a significant positive impact on users
> and does not have any adverse effects.

Thanks a lot for the details. Unfortunately after further consideration
I can't accept this patch as a fix with clear conscience. The code has
been this way for a long time, performance improvements should end up
in new kernels and people who want to benefit from faster kernels should
not be sticking to old LTS releases.

So please repost for net-next next week, when it's open again.

