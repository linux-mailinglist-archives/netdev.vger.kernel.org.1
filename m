Return-Path: <netdev+bounces-269291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ar9Grpyu2kdkQIAu9opvQ
	(envelope-from <netdev+bounces-269291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:51:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C243C2C5B4E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970A3308CBEC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B6630101F;
	Thu, 19 Mar 2026 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="XahrJVVD";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="utA62WXU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E52D6407;
	Thu, 19 Mar 2026 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773892273; cv=none; b=EV+go97FTUWRcCtT4m/9lr6YkAKdOZRLBqqsWnyYUHsGoAZjU6iT1Zpe95XTYDqhJzbEJLnnqPiDz/3hLcCpyho3uixqL+OIj41BZbo5MbiUJeRCxfDTIETtp7ea8MjA8whkyGyd83wKoOFzXYHKkfmX1Oa210rj+oE3sSx4ZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773892273; c=relaxed/simple;
	bh=5ZIa+VrEFGT6s1b0n+11rNRJMPKAoeTf6ErlW04zVms=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k1symkfDP5hVAssYtyx2MhNf1SPXyCBE/q9NhcB277BEO6jjEXOz8LPvBb2v1b/uxzFU2hj8PF5KIOvBc6TVJyfk65UNWRc8aETG4qxogZtavUiiBzNqJa6lg5Wz3auVO3GG5kyIHxU0yQGogUZPP/FHaIJNb8hd0qVj5xr2Aaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=XahrJVVD; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=utA62WXU; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62J3oKkn029244;
	Thu, 19 Mar 2026 04:50:25 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 7F46D1205C5;
	Thu, 19 Mar 2026 04:50:16 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1773892216; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YolXrcb2/k8M+7PX1AoAcwS/BpwizcrDlJUgtvNcKuA=;
	b=XahrJVVDeKrgVSOvrX1atO9T5q2RCy9T3Yn+UkJh2g/gZecKvzFpBJbv9DUKttMPRIAWa+
	RmS1BbYUsDEsNuCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1773892216; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YolXrcb2/k8M+7PX1AoAcwS/BpwizcrDlJUgtvNcKuA=;
	b=utA62WXUeNb7C0mqKix132Fu4TDFLyYLOFqIa02MKoB5HDotjak907RZ3Lb5gnTQNM1WZk
	g6XVbJjCIzbUEJ2wDE+ieE+tTa+LYC/8ZX9a6TjfNVyAly+5el/pRjZnExnM6eTnuJfw/w
	4aK/Hvckb8ZrIH2zleT6ABzJGgIx/BokavCr4AMVgptkshEM61cMcVlypP6S9GuJ3OYz/W
	1Zlg0WlSrvSNr4t1AlcRogihj1ktYAQwbmJo5tgV34QhWKoMvDogVRP9i6pHfnQg9Vbn3X
	Gkl+MWFQY1GKcv9gkgECPxrXkwsLynTREL8Iq193hhHV23DqH1C/Rjsr6ObVDQ==
Date: Thu, 19 Mar 2026 04:50:16 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Justin Iurman <justin.iurman@6wind.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        justin.iurman@gmail.com, nicolas.dichtel@6wind.com,
        stefano.salsano@uniroma2.it, paolo.lungaroni@uniroma2.it,
        ahabdels@cisco.com, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next v3 2/2] selftests: add check for seg6 tunsrc
Message-Id: <20260319045016.df6af895b17517b8e7e9dc5c@uniroma2.it>
In-Reply-To: <CAOY2BqxrY6je_34375P2FEGp=-TatSb3oSktWXcc-xBeMRqYVA@mail.gmail.com>
References: <20260316162955.1253225-1-justin.iurman@6wind.com>
	<20260316162955.1253225-3-justin.iurman@6wind.com>
	<20260317115430.cfd3846b20c1e2314d468b5d@uniroma2.it>
	<CAOY2BqxrY6je_34375P2FEGp=-TatSb3oSktWXcc-xBeMRqYVA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,uniroma2.it,cisco.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269291-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.957];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[encap.red:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,encaps.red:url,srv6_hencap_red_l3vpn_test.sh:url]
X-Rspamd-Queue-Id: C243C2C5B4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 13:29:56 +0100
Justin Iurman <justin.iurman@6wind.com> wrote:

> On Tue, Mar 17, 2026 at 11:54 AM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
> >
> > On Mon, 16 Mar 2026 17:29:55 +0100
> > Justin Iurman <justin.iurman@6wind.com> wrote:
> >
> > > Extend srv6_hencap_red_l3vpn_test.sh to include checks for the new
> > > "tunsrc" feature.
> > >
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: linux-kselftest@vger.kernel.org
> > > Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> > > ---
> > >  .../net/srv6_hencap_red_l3vpn_test.sh         | 65 ++++++++++++++-----
> > >  1 file changed, 50 insertions(+), 15 deletions(-)
> 
> [snip]
> 
> > > -     # Direction hs-1 -> hs-2 (H.Encaps.Red)
> > > +     # Direction hs-1 -> hs-2 (H.Encaps.Red + tunsrc)
> > >       # - rt-2 (SRv6 End.DT46 behavior)
> > >       #
> > >       # Direction hs-2 -> hs-1 (H.Encaps.Red)
> > >       #  - rt-4,rt-3 (SRv6 End behaviors)
> > >       #  - rt-1 (SRv6 End.DT46 behavior)
> > > -     setup_rt_policy_ipv4 2 1 "" 2 encap.red
> > > -     setup_rt_policy_ipv4 1 2 "4 3" 1 encap.red
> > > +     setup_rt_policy_ipv4 2 1 "" 2 encap.red true
> > > +     setup_rt_policy_ipv4 1 2 "4 3" 1 encap.red false
> > >
> > >       # create an IPv6 VPN between hosts hs-3 and hs-4
> > >       # the network path between hs-3 and hs-4 traverses several routers
> > >       # depending on the direction of traffic.
> > >       #
> > > -     # Direction hs-3 -> hs-4 (H.Encaps.Red)
> > > +     # Direction hs-3 -> hs-4 (H.Encaps.Red + tunsrc)
> > >       # - rt-2 (SRv6 End Behavior)
> > >       # - rt-4 (SRv6 End.DT46 behavior)
> > >       #
> > >       # Direction hs-4 -> hs-3 (H.Encaps.Red)
> > >       #  - rt-1 (SRv6 End behavior)
> > >       #  - rt-3 (SRv6 End.DT46 behavior)
> > > -     setup_rt_policy_ipv6 4 3 "2" 4 encap.red
> > > -     setup_rt_policy_ipv6 3 4 "1" 3 encap.red
> > > +     setup_rt_policy_ipv6 4 3 "2" 4 encap.red true
> > > +     setup_rt_policy_ipv6 3 4 "1" 3 encap.red false
> > >
> > >       # testing environment was set up successfully
> > >       SETUP_ERR=0
> >
> >
> > The paths marked "true" here were testing the encap.red baseline before
> > this change. They need to stay exactly as they were originally.
> > Furthermore, if tunsrc is not supported by the kernel running the test,
> > the ip route command with tunsrc will fail during setup() (since
> > set -e is used), and the entire script dies before any test runs.
> 
> I kinda disagree here: you're not supposed to run the updated
> selftests on an old kernel or with an old iproute2 version (versions
> are kept aligned). And I also concur with Jakub about degraded
> environments on your last comment below.
> 
> > The idea here is to avoid duplicating the entire test suite, while still
> > providing dedicated test cases for the new per-route tunsrc. A reasonable
> > approach could be adding the tunsrc checks as new, separate test cases
> > that run after the baseline ones, leaving the existing paths completely
> > untouched.
> >
> > For example, a dedicated test_tunsrc() function could take care of the
> > whole thing for a given path: setting up the tunsrc address, installing
> > the route with tunsrc, verifying the behavior, cleaning up, and finally
> > restoring the original route.
> 
> Well, I actually thought that this approach would be easier, and would
> specifically avoid adding too much code or having duplication. FWIW, I
> don't think providing dedicated test cases for the new per-route
> tunsrc really makes sense, as it's the same behavior as without
> "tunsrc". It doesn't impact the encap baseline by itself, since
> nothing in the selftests depends on the outer source address. I'm open
> to implement what you suggest, though, it's just that I'm not sure
> it's the best way forward.
> 
> What I suggest as next step: I'll ship patch #1 alone, along with the
> iproute2-next companion series, so that we don't miss the merge window
> and have the feature in 7.1. In parallel, we keep discussing design
> choices for the selftest and ship it as soon as we settle. Would you
> agree with that plan?
> 
> Cheers,
> Justin
> 

Hi Justin,

IMHO, the optimal goals should be:
1) have at least a selftest that covers the new feature;
2) re-use *if reasonable* existing selftests;
3) have selftests that run on a reasonable set of kernels and
   environments, without unreasonably increasing their complexity.

I'd prefer to have the selftest shipped together with the feature.
I think we could find a reasonable way to integrate the tunsrc checks
without overcomplicating the existing selftest.
Let me send you an idea offline so we can evaluate it together.

I certainly don't want to hold up the tunsrc feature, it's something
I find very interesting and that I also discussed at netdev 0x19 (2025).

Thanks,
Andrea

