Return-Path: <netdev+bounces-290548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PPyKSM9D2rQIAYAu9opvQ
	(envelope-from <netdev+bounces-290548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:13:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B495A9F75
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B534933CE73C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453103346B4;
	Thu, 21 May 2026 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMN4jEMq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303AC33123D
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378403; cv=none; b=dGSMIboTAWCbM4syccjQhxA5YXnlEyemslXgbiM6omDq4IscskQ4jquszl1TJTP/Q2DsnG8aH2+73+Lx7YBL3pwRcalf/EWN6ABJEBXWLFxDzWvnnIEyzsqnNnOna6SCCmnKiemoZBOHsCCnvkehMk2qk8+0NUs2YiPellKqsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378403; c=relaxed/simple;
	bh=wvXDD1ma/iYRTVZ5bpg4r7exu5q5j5s1o/cAIPHrbPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnatHwCioditY+vg4robky4kDT2wCCXcb+2WJboVdGmLCyUCSDxv6Db7+0yUmW5Z1mxOzKfmnH8MLJJHy2ZC/2ZFKDvmFhrF9pok2Oe+7vMmHf3iQyvSF+nT6YCzblzZnK/uurhGrRoKQ1YG7uSk+KbVdjVe1JAiebB14vpwzAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMN4jEMq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6082C1F000E9;
	Thu, 21 May 2026 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779378401;
	bh=wvXDD1ma/iYRTVZ5bpg4r7exu5q5j5s1o/cAIPHrbPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KMN4jEMqD0Gm1QA2vaaHePklRHefQZysxZ/4jJJ0k52zBNrGbn/gFghRBgqodfTWQ
	 7RwwYrDhnjn/jwEVC7lE9u5nKvCDaNw60aC8ON2CALLg19u/gxZFRoToizNsQ2v33l
	 8QM+j1axKXQ6JSvPWrTBISq91ePuT1hXPyAgXuQncr8srgx+nz6+zGbH5QEtenOFax
	 HyUPg+HTqlIYMlJFyorddKWdPdiAMhulNtBFKBW/RFyUMHSmsIkFH8+C+02xXJwKQu
	 kZtozPCkzHcVIeTpikuLQgclXMJp7l3cPbqSInklW+SXwUgt6TsOUI4xNu8S4uP9kK
	 447AM/edVb0eA==
Date: Thu, 21 May 2026 08:46:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260521084640.683c1ee6@kernel.org>
In-Reply-To: <CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
	<CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
	<CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
	<CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
	<CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
	<20260521073526.793d30c3@kernel.org>
	<CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	TAGGED_FROM(0.00)[bounces-290548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 38B495A9F75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 11:16:35 -0400 Jamal Hadi Salim wrote:
> On Thu, May 21, 2026 at 10:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > > To be precise, something like attached (untested, uncompiled) =20
> >
> > Can we not pull the headers? Do you know of anyone modifying payloads
> > with pedit?
>=20
> not sure - but it is not unreasonable if someone used it for such a case.

Ack, we'd still support modifying any offset in the packet.
But not optimize for modifying frags until we know user exists.

> > The concept of "shared frags" is silly IMHO, if I'm checking right only
> > rxrpc and xfrm think that it's a thing. I'm hoping to delete that and
> > reclaim the flag id in net-next... =20
>=20
> All these issues stem from the shared frags point, but the patchlet i
> showed is unrelated to SKBFL_SHARED_FRAG, it is more related to
> cloned+frags.

Right, right. Just pointing it out cause Rajat's patch adds another
skb_has_shared_frag(). Which we'll then have to delete in net-next :\

> If you remove it in net-next - does that necessitate removing all
> "fixes" that tried to address that issue? It seems like that would be
> sensible, but it makes me wonder why the shared frags concept exists
> in the first place.

IDK. We have in the tree plenty of "good ideas that went nowhere"..
As I said elsewhere IMO having the maintain this flag correctly
100% of the time will only create more CVEs, and there's no practical
reason to optimize for frags not being shared.

