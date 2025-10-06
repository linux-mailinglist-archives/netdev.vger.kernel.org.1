Return-Path: <netdev+bounces-228034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0734BBF3B5
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 22:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7603734B137
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048DD1DDA14;
	Mon,  6 Oct 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="HjBGwMPv"
X-Original-To: netdev@vger.kernel.org
Received: from out8.tophost.ch (out8.tophost.ch [46.232.182.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68F1D6DDD;
	Mon,  6 Oct 2025 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759783583; cv=none; b=H2Nq+ysig67fCgevuOqb3PFqojGY7v7X0NsFlayRJ3R93WlDDqL/8bXb20P4xu7CsNp5Guc1Z02Qx948pqh5bdCVQUUIwd/cLAlWHj2BeyvEsdlmz2mvGO39cmSRP9Ac1G8A9QP1N9YmJwjAlJYvk/4lbsdaqgYgqM0bVXdjBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759783583; c=relaxed/simple;
	bh=bQ2/QXeOHuR4GdYWKjJISIBBy8VABAMrNvPe2K3zZwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NL+upcQd6OUPrAViZclyt/sVnotUNQusXQRbEc4/eZl75IrIL3n9ETPjIMGQ+coIq2tXqgWRRACyshr22Cq/JectRshg7Cao6iBvq76KrBAmmVjH2bkarTNLJXwReKy+42IIPpWWuxvwykmJfm2UACVOs+oIxYoXc1o3oO0EDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=HjBGwMPv; arc=none smtp.client-ip=46.232.182.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter2.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v5s5j-007RhQ-Pz; Mon, 06 Oct 2025 22:45:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=L3YTjzbsOYjUbsbU/Wy3ta9LHNYn+m0h3PqY4SwxINU=; b=HjBGwMPvj6P/BcnFLl/tx2TtCP
	qiZJVV6u2o2odvH01Fy29kUzG6HlcwznDBaEq27P5Va+cjYDK+4k3h2MC8phg/xYWplo1Y6jNHUuC
	RtS/5V4UbOkhVgiErB+Uwav7mXn7NLXHP9ElUeqIu2qSFq1/fd3EOZkrtGr7NB+E6QmNLi3GUlOFO
	Bp+r1YFgFZc0pA7lLwpAPNAIqhisMAae6QlUqsufr+AQDHVQJ6XszK2k6prTjPMAookHmCpc6kvJf
	QvGKV5jtZwBmiHSdc59SKyS5gImeafIUeHSrTV9W4ptbCRb1mKkMzOlbBN6OUTdXoL+1nvVYKTMUQ
	izCXpjfA==;
Received: from [213.55.237.208] (port=11652 helo=pavilion)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v5s5i-0000000D8Ee-1jUB;
	Mon, 06 Oct 2025 22:45:54 +0200
Date: Mon, 6 Oct 2025 22:45:47 +0200
From: Thomas Wismer <thomas@wismer.xyz>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Wismer <thomas.wismer@scs.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: pse-pd: tps23881: Fix current measurement
 scaling
Message-ID: <20251006224301.4dcf3878@pavilion>
In-Reply-To: <20251006144911.702fed49@kmaincent-XPS-13-7390>
References: <20251004180351.118779-2-thomas@wismer.xyz>
 <20251004180351.118779-4-thomas@wismer.xyz>
 <20251006144911.702fed49@kmaincent-XPS-13-7390>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Get-Message-Sender-Via: srv125.tophost.ch: authenticated_id: thomas@wismer.xyz
X-Authenticated-Sender: srv125.tophost.ch: thomas@wismer.xyz
X-Spampanel-Domain: smtpout.tophost.ch
X-Spampanel-Username: 194.150.248.5
Authentication-Results: tophost.ch; auth=pass smtp.auth=194.150.248.5@smtpout.tophost.ch
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00821288287289)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXM471z1iVsQgpD2K0Yb0CXtnosJVX7rrLt
 siJdZCHJ+iu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zMpj
 vEVOTsR2BCGQHEe9o6DxcwM0aDExi5MlveCS7R16CtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYsG4jVZi5Tfop5qjCZejidXzthz0vNkOX8Em4cj6D/wdR983ISMXlZYfkTQnVvsLb89W7vD
 6C469DIPe8wH3iOJTcWsqU26dvDcYIYzaKVPzizNp/gleLRyr2ddmlcu+i1jPgDrl7KDWN+JeAU8
 1aNgksp0UtIrN0U07614AkdB++MTbkn6z1fsm8NoMVdUr8MDPUrsZkS8fIjQg/OlnCq9era6RvWE
 xGjaMpBDSCziBywD4A8JEs8nAB07i3qQt2GCxqdhJ42egOXnLvBjaBHojvcdCFSGnAoJdmBrbnML
 ysTZI7fFfQwiuwD2LcLdqjNFmtMtCFuKzK3WYzvpld0/yccMnl06aHo07R+V2VbvDXc+galx1KGI
 Pp5jnkiI48S3blKfwQpggXpr4ijI5V97nizzgiBlcUwLhZK/ZHw1RdpNQJ37uqLsFt7+YGhJkDU9
 4+PQCJgyeQ5hmX4W3XfjuZq3ey7jWD75mz2FgepuKE1QHL+v8HSjw4E9FZ48n35YGxLcRm31r7HJ
 L906rtNSlbyOZqJAl0NcWR3h5RCCpdhlI2FswyUM1YB4pb6NihzVEQJD0k3NJ3BxI7jJWMBode2U
 Svel4Ph4LtRWGzmVykX/svZHtlcv4/x61HBbxR8gr/U0flMcy2Vi/IcBgY4ane5tOXPRIqHUx6+W
 zGK5Hg6zly/hm7kTCa25PmFuNjYUvwsQEI5UkfpCg7AUhDMCozAGWaBw5toun3z41wwqu6OADWMC
 9+/HEHYskr6LOFgfNJTYgMI1RqtgWZEsuX9H7fs8i/Lg4VMmqeqQOhF8kMn3arb1xVlaLjgbxjTB
 gAHkgTtbIGX4Gktj7c2CONolFYbP7eetTUcNPZF8UuWWRQPHxHs4uWfEMXRAPK2SKfAoiYNGqK33
 DNrpuCWt66XitN3uNQC5yiFHVtp2XHTC/tXl1Kc2a+wlKs+ogYIxcMllcGL2FYQA/TYqr07UQr9N
 8YzZ1OXdAJhrEGn8vjZdfatsJHAzgC46MYYXOcKJkR5mWDA3wLMqtkpqhq8QHjwHB17Mh03hOC2D
 8X08bmfUo2hx63fUqSBCUpmH010fZI9bHEjTkiJxSPqFbdrqtFE8gK0UxPGon/0gulkiYXfVWWO3
 KRWMcR+Z5yTvtzkwsDU=
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

Am Mon, 6 Oct 2025 14:50:29 +0200
schrieb Kory Maincent <kory.maincent@bootlin.com>:

> On Sat,  4 Oct 2025 20:03:49 +0200
> Thomas Wismer <thomas@wismer.xyz> wrote:
> 
> > From: Thomas Wismer <thomas.wismer@scs.ch>
> > 
> > The TPS23881 improves on the TPS23880 with current sense resistors
> > reduced from 255 mOhm to 200 mOhm. This has a direct impact on the
> > scaling of the current measurement. However, the latest TPS23881
> > data sheet from May 2023 still shows the scaling of the TPS23880
> > model.  
> 
> Didn't know that. Where did you get that new current step value if
> it's not from the datasheet?

The correct current measurement scaling can either be found in the
TPS23881B datasheet revised in May 2025 or computed from the legacy sense
resistor value (255 mOhm / 200 mOhm * 70.19 uA = 89.50 uA). I was able to
verify the corrected scaling using power measurement instruments.

> Also as the value reported was wrong maybe we need a fix tag here and
> send it to net instead of net-next.

Right. I'll resubmit this patch to net.

> > Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
> > ---
> >  drivers/net/pse-pd/tps23881.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/pse-pd/tps23881.c
> > b/drivers/net/pse-pd/tps23881.c index 63f8f43062bc..b724b222ab44
> > 100644 --- a/drivers/net/pse-pd/tps23881.c
> > +++ b/drivers/net/pse-pd/tps23881.c
> > @@ -62,7 +62,7 @@
> >  #define TPS23881_REG_SRAM_DATA	0x61
> >  
> >  #define TPS23881_UV_STEP	3662
> > -#define TPS23881_NA_STEP	70190
> > +#define TPS23881_NA_STEP	89500
> >  #define TPS23881_MW_STEP	500
> >  #define TPS23881_MIN_PI_PW_LIMIT_MW	2000
> >    
> 
> 
> 


