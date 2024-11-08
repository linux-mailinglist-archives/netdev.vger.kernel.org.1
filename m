Return-Path: <netdev+bounces-143439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6589C2721
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA8D1C208EC
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A31C1F34;
	Fri,  8 Nov 2024 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="CgoC3yPi"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFD233D80
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102182; cv=none; b=T7aPHhuS0LTVjz79izaXsVo0qcQwElKs05xoF/NotBlnMZmZJarIYx46rgohn3d6bxrrGleM0r7lcgPnIscfCGSCogLfaBYJLcnLHv6uI6BOrb/gXnbIViMWuV6zbxzpvbvrwF9J+ZfZEIx1BgLJO8TWuRP9gLUozxoSLw0UBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102182; c=relaxed/simple;
	bh=bOgIvEqIQP7aAWFCAUyT2Vzn/DkbaczDZuukumHrHmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnuSC5mQiOiUcPUjJiBrlcThRLOucvwjCDbBcuhOaXxuYO4gUPEroaLEMGimZq6e27WdfQUmHsfzSw2/nb7PnwEMSo/5XOSVNnpwBrNvYlBK6rG/99nSNki0zMbxBpEC3nkXXbwOIOi5tEmoM3EMC0V0ccW0TWOieNRa64Sb4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=CgoC3yPi; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.14])
	by mail.ispras.ru (Postfix) with ESMTPSA id D163A40B227F;
	Fri,  8 Nov 2024 21:42:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D163A40B227F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731102177;
	bh=gfIh3bXKCybmNGisNtzYVK2moedKhWkf28cL8IRdeS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgoC3yPiQAYfVs+EyYyJgrVWnYsmQe6AUzYqXpLIMCvp8fIsikoptjmo17zyWJjJi
	 V3LfG1XpTwBmDJt2yMLSeID77J1V3l34HU3Ezzmp7+9UvCGNN/JK0sXUZNPmmxmvgM
	 xzZCOkUMYAE2ThbwPlx5zI7RNAWnQI1qcOPvxAWE=
Date: Sat, 9 Nov 2024 00:42:53 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Dmitry Kandybka <d.kandybka@gmail.com>, netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>, mptcp@lists.linux.dev,
	lvc-project@linuxtesting.org, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] mptcp: fix possible integer overflow in
 mptcp_reset_tout_timer
Message-ID: <20241109-46edd978694b7d9a2f89b9f6-pchelkin@ispras.ru>
References: <20241107103657.1560536-1-d.kandybka@gmail.com>
 <5f51673a-e19b-45e8-bb1c-a6d3427213c1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f51673a-e19b-45e8-bb1c-a6d3427213c1@kernel.org>

Hi,

Cc'ing more people.

On Fri, 08. Nov 12:43, Matthieu Baerts wrote:
> Hi Dmitry,
> 
> On 07/11/2024 11:36, Dmitry Kandybka wrote:
> > In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
> > to avoid possible integer overflow. Compile tested only.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
> > ---
> >  net/mptcp/protocol.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index e978e05ec8d1..ff2b8a2bfe18 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2722,8 +2722,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
> >  	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
> >  		return;
> >  
> > -	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
> > -			mptcp_close_timeout(sk);
> > +	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
> > +			tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
> 
> If I'm not mistaken, "jiffies" is an "unsigned long", which makes this
> modification not necessary, no?

inet_csk(sk)->icsk_mtup.probe_timestamp and tcp_jiffies32 are both of u32
type.

'inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32' will be computed
first in u32, only then the result will be converted to unsigned long for
further calculations with 'jiffies'.

Looking at how probe_timestamp is initialized, seems it will always be less
than the current tcp_jiffies32 value.

So 'inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32' will wrap in
u32, and then converted to unsigned long. It's not clear actually whether
this is considered to be an expected behavior... Goes all the way down to
76a13b315709 ("mptcp: invoke MP_FAIL response when needed").

> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.

