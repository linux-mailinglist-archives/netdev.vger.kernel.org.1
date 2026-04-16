Return-Path: <netdev+bounces-278939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB1YGRZ64GlahgAAu9opvQ
	(envelope-from <netdev+bounces-278939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:56:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CD040A823
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9187E31B4A33
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502703793C6;
	Thu, 16 Apr 2026 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="KoxUPzIH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300533793CD
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318714; cv=none; b=JdKoY/aZrUuH6J91+a1a6id9Qb3UPn4UTtxpdeHSvtahy3aL9KxelnXiIXM5HYvcvRL6ChzwAVifRvu6SKKPzpZGUfsjGNKdhTNcKo60iF+HwA/ipSk6kTkQwh3b8fTQlGZwDBIo18ns4CtUWbfG0wdozAT/8Rwe0U+TpvkBasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318714; c=relaxed/simple;
	bh=xC5OuL/bVVgPXD7TUtKYjCWk4/nqbFucL75V4cDJdTM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W59AgKR7x4Em01ptThYYnH9sQb2vWSjGdapNhfzaViLO4T8u/VSyO33xyi18YArEhYDaxVms3yka82JlHV4A2uTaCp9NyWIraJw4J5STW/oLyhC9IqG96nZ5G0bzyLD6UyZH0sUs9sU7znx1kzv3QECMuvWL3xd3eHw+Yxgdxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=KoxUPzIH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 02F352082B;
	Thu, 16 Apr 2026 07:51:49 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wTAExfV50ATW; Thu, 16 Apr 2026 07:51:47 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 51F82207FC;
	Thu, 16 Apr 2026 07:51:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 51F82207FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1776318707;
	bh=nV4yyLECC5svVloibHiXGOLDvJVycNAoQGvq/jtoSCY=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=KoxUPzIHQyt8CsAzgpdVJRhWvcWGRQtcRRAkJ4bERYjMGOc51we2GHRxLlBTgkoZC
	 hegygndiF6vIEBllVSP4eo+ZWt7bPRkAAsLMMJD8u8GZtjKnNrC/bs/f1oBygztUWs
	 wey2owsewf/O8Q/JojfGxIgfl+m+ydGyYpQjxL+4086aawmkPmdVzhq6y4spNT3XdE
	 2+0oo98+Z4fgxcGb7nTT5JelqpMLstcp50CTM1acO6Jl5JENqMsLPqwPAMPur+YEh2
	 b5y1cUgkeV+abWIC3FtdN2DemZidMSNteWJkltxKnCKAB/jIw/PgJ+ApOmKlxxD6Km
	 plQIzl/fqXryw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 07:51:46 +0200
Date: Thu, 16 Apr 2026 07:51:40 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Yan Yan <evitayan@google.com>
CC: <antony.antony@secunet.com>, Aakash Kumar Shankarappa
	<saakashkumar@marvell.com>, Nathan Harold <nharold@google.com>, Tobias
 Brunner <tobias@strongswan.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, "paul@nohats.ca" <paul@nohats.ca>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "akamluddin@marvell.com" <akamluddin@marvell.com>,
	"greg@kroah.com" <greg@kroah.com>
Subject: Re: [EXTERNAL] Re: [REGRESSION] Discussion on "xfrm: Duplicate SPI
 Handling"
Message-ID: <aeB47HqELuB6uV3v@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <CADHa2dBN+_9H-_L19Rg3vfvzC1N5FzG+rzW9Pff8pyM3KL9Ocw@mail.gmail.com>
 <fcc761de-f677-4fc9-969b-47c2b56f54be@strongswan.org>
 <CADHa2dBzJBF6po_qDcn97C15U05EZOzuY-opGW1uc3WAYTPx_g@mail.gmail.com>
 <7b4667b9-c4f2-4c56-a0ea-6e9bdc8b5241@strongswan.org>
 <CADhJOfbv8A+2X7xwtoEpLUV1D1vesMjj=nSYc--iOHF6R+VKLw@mail.gmail.com>
 <CADHa2dBA=MpBz3_j2kbLr-wb2nsmnYBhyhWb6pjWekEzurBr9w@mail.gmail.com>
 <acqqpAHmKnduKxRp@moon.secunet.de>
 <BL1PPF236BDCF3E1BDA74118AE2A6ECFAFFDA52A@BL1PPF236BDCF3E.namprd18.prod.outlook.com>
 <acumPxrIVJYlQUsg@moon.secunet.de>
 <CADHa2dA+Yq_K2A=Pk131yYYOX3Btncbp4Q+9UoTu_7egLPJhQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHa2dA+Yq_K2A=Pk131yYYOX3Btncbp4Q+9UoTu_7egLPJhQg@mail.gmail.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278939-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	RCVD_COUNT_SEVEN(0.00)[7];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[antony.antony@secunet.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[proofpoint.com,aka.ms];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aka.ms:url,proofpoint.com:url,secunet.com:email,secunet.com:dkim,secunet.com:replyto,davemloft.net:email,strongswan.org:email,kroah.com:email,apana.org.au:email]
X-Rspamd-Queue-Id: 09CD040A823
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, Apr 08, 2026 at 15:49:00 -0700, Yan Yan wrote:
>    Hi Antony,
>    The patch looks good to me, and I verified that it fixes the
>    regression.

I rebased the patch to ipsec and sent as RFC ipsec. I am sending it as
Fix, instead of ipsec-next.

I could not test it easily both.  
Aakash and Yan would you like to test it and may be send tag, that may motivate Steffen to accept it instead of waiting for me to test it.

regards,
-antony

> 
>    On Tue, Mar 31, 2026 at 3:47 AM Antony Antony
>    <[1]antony.antony@secunet.com> wrote:
> 
>      Hi,
>      I have tweaked the patch a bit more, uniqueness is only when
>      x->dir == XFRM_SA_DIR_IN. See the attached patch.
>      I have added tags Fixes:
>      and
>      Reported-by: Yan Yan <[2]evitayan@google.com>
>      Yan, are you ok with this?
>      So fart I don't have any tests for this, so more tags welcome:)
>      regards,
>      -antony
>      PS: recent libreswan is setting direction. Thta should not be
>      problem.
>      On Mon, Mar 30, 2026 at 20:34:07 +0000, Aakash Kumar Shankarappa
>      wrote:
>      >    Hi Antony,
>      >
>      >    Thanks for the patch. Yes the x->dir based gating approach
>      looks good
>      >    to me and it works for Marvell.
>      >
>      >    Also this seems like the right direction. It preserves backward
>      >    compatibility for existing users, while still allowing strict
>      RFC 4301
>      >    complaint SPI uniqueness as an opt-in feature. Anybody who
>      wants the
>      >    stricter behaviour can upgrade to Strongswan 6.0.0+ and
>      leverage
>      >    XFRM_SA_DIR_IN.
>      >
>      >    Thanks, Aakash
>      >
>      >    From: Antony Antony <[3]antony.antony@secunet.com>
>      >    Date: Monday, 30 March 2026 at 10:24 PM
>      >    To: Yan Yan <[4]evitayan@google.com>
>      >    Cc: Nathan Harold <[5]nharold@google.com>, Tobias Brunner
>      >    <[6]tobias@strongswan.org>, [7]antony.antony@secunet.com
>      >    <[8]antony.antony@secunet.com>, Steffen Klassert
>      >    <[9]steffen.klassert@secunet.com>, [10]paul@nohats.ca
>      <[11]paul@nohats.ca>,
>      >    [12]netdev@vger.kernel.org <[13]netdev@vger.kernel.org>,
>      Herbert Xu
>      >    <[14]herbert@gondor.apana.org.au>, David S . Miller
>      <[15]davem@davemloft.net>,
>      >    Eric Dumazet <[16]edumazet@google.com>, Jakub Kicinski
>      <[17]kuba@kernel.org>,
>      >    [18]pabeni@redhat.com <[19]pabeni@redhat.com>,
>      [20]horms@kernel.org
>      >    <[21]horms@kernel.org>, Aakash Kumar Shankarappa
>      >    <[22]saakashkumar@marvell.com>, [23]akamluddin@marvell.com
>      >    <[24]akamluddin@marvell.com>, [25]greg@kroah.com
>      <[26]greg@kroah.com>
>      >    Subject: [EXTERNAL] Re: [REGRESSION] Discussion on "xfrm:
>      Duplicate SPI
>      >    Handling"
>      >    Prioritize security for external emails:
>      >    Confirm sender and content safety before clicking links or
>      opening
>      >    attachments
>      >    [1]Report Suspicious
>      >
>      >
>      >    Hi, I looked into this. I feel a simple solution is use x->dir
>      as
>      >    Nathan proposed. When dir is not set we get pre commit
>      94f39804d891
>      >    ("xfrm: Duplicate SPI Handling") behaviour. When XFRM_SA_DIR is
>      set
>      >    alloc_spi() returns per direction unique spi. Another benfit
>      is, this
>      >    would also keep PF_KEY use case as it was before that comit.
>      Here is
>      >    simple RFC patch attached. How does this look? strongswan
>      6.0.0, from
>      >    Dec 2024, sets x->dir. Aakash would this work for for marvell?
>      regads,
>      >    -antony On Fri, Mar 27, 2026 at 17:05:13 -0700, Yan Yan wrote:
>      > Hi
>      >    all, > I wanted to send a friendly ping to see if we are
>      aligning on
>      >    making > the strict global SPI uniqueness requirement optional,
>      perhaps
>      >    via a > toggle or by leveraging the XFRM_SA_DIR attribute as
>      previously
>      >    > discussed. > Are there any other questions or concerns
>      regarding this
>      >    approach, or > anything else we should clarify to ensure
>      backward
>      >    compatibility while > meeting the needs of modern standards? >
>      Best, >
>      >    Yan > > On Tue, Feb 24, 2026 at 3:53 PM Nathan Harold
>      >    <[1][27]nharold@google.com> > wrote: > > > That should still be
>      allowed
>      >    when using the intended APIs (i.e. > ALLOCSPI > > for the
>      inbound and
>      >    NEWSA for the outbound SA). ALLOCSPI might > enforce > > a
>      unique SPI
>      >    without considering the address, as that's intended > for > >
>      local,
>      >    inbound SAs, where the kernel has full control (looking at >
>      the > >
>      >    the patch, it's certainly not ideal, as it goes through all >
>      installed
>      >    > > SAs to find a duplicate and it prevents an inbound SPI that
>      >
>      >    matches an > > existing outbound SPI - I guess that could be
>      resolved
>      >    by using > separate > > tables for in- and outbound SAs). But
>      that must
>      >    not prevent > installing > > outbound SAs with the same SPI to
>      another
>      >    peer using NEWSA, which > still > > uses a hash that includes
>      the
>      >    destination address (that must > always be > > the case because
>      peers
>      >    are free to allocate whatever SPI they > want). > Agreed that
>      there are
>      >    some unfortunate limitations with the current > patch. Keying
>      off the
>      >    inclusion of XFRM_SA_DIR would resolve the > issue > you noted
>      >    (conflating inbound and outbound SPIs) and function as an >
>      opt-in for
>      >    this enforcement. Whatever the mechanism though, the new >
>      behavior
>      >    should be opt-in rather than opt-out in order to maintain >
>      backwards
>      >    compatibility. > > In my opinion, you are using the API
>      incorrectly...
>      >    I also > > don't think there are any benefits in that
>      "consistent
>      >    larval > lifecycle" > > (if you found any, please let us know).
>      > The
>      >    Android architecture is multi-tenant and allows userspace apps
>      > to >
>      >    establish SAs. At the time we designed it, this felt like the >
>      >    cleanest > way to facilitate leak-free resource management
>      because the
>      >    chain of > associations between kernel resources could be
>      symmetrical
>      >    (and > managing them was already quite complicated). Mea culpa
>      >    (Nathan). > But, > correctly or not, it has/had worked for many
>      years.
>      >    > > By the way, are you using the min/max option for inbound
>      SAs as >
>      >    well, > > with an SPI generated in userland? That would seem
>      like a >
>      >    violation of > > the intention of the API as well (i.e. letting
>      the
>      >    kernel control > the > > local SPIs). > We provide following
>      two
>      >    Android APIs for app developers: >
>      >
>      [2][2][28]https://urldefense.proofpoint.com/v2/url?u=https-3A__devel
>      oper.an
>      >
>      droid.com_reference_android_net_IpSecManager-23&d=DwIDaQ&c=nKjWec2b6
>      R0m
>      >
>      OyPaz7xtfQ&r=r6Wzn5LnVsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNMKKyp
>      JWI
>      >
>      SL5BbGkfA2yD1_H51rd5M6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=9txNFXC-wFiRF
>      V_Q
>      >    JlIQLW2AWSbERIOWcGHJfuQP2ZA&e= >
>      >    allocateSecurityParameterIndex(java.net.InetAddress) >
>      >
>      [3][3][29]https://urldefense.proofpoint.com/v2/url?u=https-3A__devel
>      oper.an
>      >
>      droid.com_reference_android_net_IpSecManager-23&d=DwIDaQ&c=nKjWec2b6
>      R0m
>      >
>      OyPaz7xtfQ&r=r6Wzn5LnVsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNMKKyp
>      JWI
>      >
>      SL5BbGkfA2yD1_H51rd5M6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=9txNFXC-wFiRF
>      V_Q
>      >    JlIQLW2AWSbERIOWcGHJfuQP2ZA&e= >
>      >    allocateSecurityParameterIndex(java.net.InetAddress,%20int) >
>      Indeed,
>      >    allocateSecurityParameterIndex is direction-agnostic; both >
>      overloads
>      >    are implemented internally by including the min and max >
>      values in
>      >    ALLOCSPI. For the variant where app developers provide a >
>      specific SPI
>      >    (which is also useful in testing), Android simply sets > both
>      the min
>      >    and max parameters to that exact value. Our > understanding >
>      of
>      >    #xfrm_alloc_spi is that min/max are required for ALLOCSPI, and
>      >
>      >    otherwise ENOENT will be returned. > Note that we also use the
>      DADDR as
>      >    a mandatory part of the tuple > because of the issue mentioned
>      above:
>      >    SPIs are only unique in > conjunction with a DADDR, regardless
>      of
>      >    direction, and accordingly, > that’s how Android is expecting
>      the
>      >    uniqueness requirement be > enforced. In this way, 5 duplicate
>      SPIs can
>      >    be used on 5 unique IP > addresses on the same machine;
>      therefore, a
>      >    strict "SPI only" > interpretation for ALLOCSPI (or SPI
>      handling in
>      >    general) is curious. > We feel that ALLOCSPI should really
>      enforce the
>      >    same uniqueness > requirements as the SAD. > Best, > Nathan and
>      Yan >
>      >    -Nathan > On Wed, Feb 18, 2026 at 12:42 AM Tobias Brunner >
>      >    <[4][30]tobias@strongswan.org> wrote: > > > > Hi Yan, > > > > >
>      For every
>      >    inbound SA, we allocate SPIs before negotiation. For > > >
>      outbound
>      >    SAs, we allocate SPIs once requested by the peer. We > only > >
>      >
>      >    require the (SPI, destination address) combo to be unique.
>      Thus, > we >
>      >    > > may have an inbound and outbound SA sharing an SPI with >
>      different
>      >    > > > destinations, or multiple outbound SAs to different peers
>      >
>      >    sharing an > > > SPI. > > > > That should still be allowed when
>      using
>      >    the intended APIs (i.e. > ALLOCSPI > > for the inbound and
>      NEWSA for
>      >    the outbound SA). ALLOCSPI might > enforce > > a unique SPI
>      without
>      >    considering the address, as that's intended > for > > local,
>      inbound
>      >    SAs, where the kernel has full control (looking at > the > >
>      the patch,
>      >    it's certainly not ideal, as it goes through all > installed >
>      > SAs to
>      >    find a duplicate and it prevents an inbound SPI that > matches
>      an > >
>      >    existing outbound SPI - I guess that could be resolved by using
>      >
>      >    separate > > tables for in- and outbound SAs). But that must
>      not
>      >    prevent > installing > > outbound SAs with the same SPI to
>      another peer
>      >    using NEWSA, which > still > > uses a hash that includes the
>      >    destination address (that must > always be > > the case because
>      peers
>      >    are free to allocate whatever SPI they > want). > > > > >> If
>      so, why
>      >    would you use ALLOCSPI and not just install the > outbound SA?
>      Is it to
>      >    avoid differences for in- and outbound SAs > (ALLOCSPI+UPDSA
>      vs.
>      >    NEWSA)?" > > > > > > Exactly—it is primarily for code symmetry.
>      By
>      >    using ALLOCSPI + > UPDSA > > > for both directions, we maintain
>      a
>      >    consistent larval lifecycle > and > > > make it easier to
>      maintain. > >
>      >    > > In my opinion, you are using the API incorrectly. ALLOCSPI
>      is >
>      >    intended > > to allocate a free local SPI for an inbound SA.
>      That is,
>      >    reserve > it > > before and while the details of the SA are
>      negotiated
>      >    with the > peer > > using IKE. This step isn't necessary for
>      outbound
>      >    SAs and forcing > such > > an allocation, after all the details
>      are
>      >    known, to the responder's > SPI > > (which I assume you do via
>      min/max
>      >    option) doesn't feel right. I > also > > don't think there are
>      any
>      >    benefits in that "consistent larval > lifecycle" > > (if you
>      found any,
>      >    please let us know). And the difference > between > > UPDSA and
>      NEWSA
>      >    is the nlmsg_type (there are some attributes that > are > >
>      different
>      >    for in- and outbound SAs, especially if you set the > direction
>      > > in
>      >    newer kernels, but that's the case regardless of the message >
>      type). >
>      >    > > > By the way, are you using the min/max option for inbound
>      SAs as >
>      >    well, > > with an SPI generated in userland? That would seem
>      like a >
>      >    violation of > > the intention of the API as well (i.e. letting
>      the
>      >    kernel control > the > > local SPIs). > > > > As the XFRM API
>      basically
>      >    mirrors PF_KEYv2 here, you can find more > about > > the two
>      ways to
>      >    install SAs in RFC 2367 (SADB_GETSPI/UPDATE vs. > SADB_ADD). >
>      > > >
>      >    Regards, > > Tobias > > > > -- > > -- > Best, > Yan > >
>      References > >
>      >    1. mailto:[31]nharold@google.com > 2.
>      >
>      [4][32]https://urldefense.proofpoint.com/v2/url?u=https-3A__develope
>      r.andro
>      >
>      id.com_reference_android_net_IpSecManager-23allocateSecurityParamete
>      rIn
>      >
>      dex-28java.net.InetAddress-29&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=r6
>      Wzn
>      >
>      5LnVsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNMKKypJWISL5BbGkfA2yD1_H
>      51r
>      >
>      d5M6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=UtpwkuoswT-6aK0he6dSS-0dvZfIcRj
>      bfj
>      >    _Eu4A-c6E&e= > 3.
>      >
>      [5][33]https://urldefense.proofpoint.com/v2/url?u=https-3A__develope
>      r.andro
>      >
>      id.com_reference_android_net_IpSecManager-23allocateSecurityParamete
>      rIn
>      >
>      dex-28java.net.InetAddress&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=r6Wzn
>      5Ln
>      >
>      Vsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNMKKypJWISL5BbGkfA2yD1_H51r
>      d5M
>      >
>      6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=fVmYoLIpyuMX3AtAkU7ejR1dno_8QtnhCK
>      LMD
>      >    4BmURc&e=, int) > 4. mailto:[34]tobias@strongswan.org
>      >
>      > References
>      >
>      >    Visible links:
>      >    1.
>      [35]https://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!tG3Tv5d
>      8inv1_6DXc1X1B4ctthRq2qCkR8nIF_n_SOJiXQ-SqG_LUk--J5LZEwV9jGdXABQriDr
>      uLYnPEg$
>      >    2.
>      [36]https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.a
>      ndroid.com_reference_android_net_IpSecManager-23&d=DwIDaQ&c=nKjWec2b
>      6R0mOyPaz7xtfQ&r=r6Wzn5LnVsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNM
>      KKypJWISL5BbGkfA2yD1_H51rd5M6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=9txNFX
>      C-wFiRFV_QJlIQLW2AWSbERIOWcGHJfuQP2ZA&e=
>      >    3.
>      [37]https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.a
>      ndroid.com_reference_android_net_IpSecManager-23&d=DwIDaQ&c=nKjWec2b
>      6R0mOyPaz7xtfQ&r=r6Wzn5LnVsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNM
>      KKypJWISL5BbGkfA2yD1_H51rd5M6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=9txNFX
>      C-wFiRFV_QJlIQLW2AWSbERIOWcGHJfuQP2ZA&e=
>      >    4.
>      [38]https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.a
>      ndroid.com_reference_android_net_IpSecManager-23allocateSecurityPara
>      meterIndex-28java.net.InetAddress-29&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xt
>      fQ&r=r6Wzn5LnVsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNMKKypJWISL5Bb
>      GkfA2yD1_H51rd5M6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=UtpwkuoswT-6aK0he6
>      dSS-0dvZfIcRjbfj_Eu4A-c6E&e=
>      >    5.
>      [39]https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.a
>      ndroid.com_reference_android_net_IpSecManager-23allocateSecurityPara
>      meterIndex-28java.net.InetAddress&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&
>      r=r6Wzn5LnVsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNMKKypJWISL5BbGkf
>      A2yD1_H51rd5M6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=fVmYoLIpyuMX3AtAkU7ej
>      R1dno_8QtnhCKLMD4BmURc&e=
>      >
>      >    Hidden links:
>      >    7. [40]https://aka.ms/GetOutlookForMac
> 
>    --
> 
>    --
>    Best,
>    Yan
> 
> References
> 
>    1. mailto:antony.antony@secunet.com
>    2. mailto:evitayan@google.com
>    3. mailto:antony.antony@secunet.com
>    4. mailto:evitayan@google.com
>    5. mailto:nharold@google.com
>    6. mailto:tobias@strongswan.org
>    7. mailto:antony.antony@secunet.com
>    8. mailto:antony.antony@secunet.com
>    9. mailto:steffen.klassert@secunet.com
>   10. mailto:paul@nohats.ca
>   11. mailto:paul@nohats.ca
>   12. mailto:netdev@vger.kernel.org
>   13. mailto:netdev@vger.kernel.org
>   14. mailto:herbert@gondor.apana.org.au
>   15. mailto:davem@davemloft.net
>   16. mailto:edumazet@google.com
>   17. mailto:kuba@kernel.org
>   18. mailto:pabeni@redhat.com
>   19. mailto:pabeni@redhat.com
>   20. mailto:horms@kernel.org
>   21. mailto:horms@kernel.org
>   22. mailto:saakashkumar@marvell.com
>   23. mailto:akamluddin@marvell.com
>   24. mailto:akamluddin@marvell.com
>   25. mailto:greg@kroah.com
>   26. mailto:greg@kroah.com
>   27. mailto:nharold@google.com
>   28. https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.an
>   29. https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.an
>   30. mailto:tobias@strongswan.org
>   31. mailto:nharold@google.com
>   32. https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.andro
>   33. https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.andro
>   34. mailto:tobias@strongswan.org
>   35. https://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!tG3Tv5d8inv1_6DXc1X1B4ctthRq2qCkR8nIF_n_SOJiXQ-SqG_LUk--J5LZEwV9jGdXABQriDruLYnPEg$
>   36. https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.android.com_reference_android_net_IpSecManager-23&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=r6Wzn5LnVsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNMKKypJWISL5BbGkfA2yD1_H51rd5M6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=9txNFXC-wFiRFV_QJlIQLW2AWSbERIOWcGHJfuQP2ZA&e=
>   37. https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.android.com_reference_android_net_IpSecManager-23&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=r6Wzn5LnVsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNMKKypJWISL5BbGkfA2yD1_H51rd5M6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=9txNFXC-wFiRFV_QJlIQLW2AWSbERIOWcGHJfuQP2ZA&e=
>   38. https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.android.com_reference_android_net_IpSecManager-23allocateSecurityParameterIndex-28java.net.InetAddress-29&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=r6Wzn5LnVsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNMKKypJWISL5BbGkfA2yD1_H51rd5M6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=UtpwkuoswT-6aK0he6dSS-0dvZfIcRjbfj_Eu4A-c6E&e=
>   39. https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.android.com_reference_android_net_IpSecManager-23allocateSecurityParameterIndex-28java.net.InetAddress&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=r6Wzn5LnVsk7Tgc5x4l_c04I_Hr_8TYqFn-YFi_gjqI&m=JsnNMKKypJWISL5BbGkfA2yD1_H51rd5M6YO4NG3WpRdteRwP5OdfTJFNEK0Xiec&s=fVmYoLIpyuMX3AtAkU7ejR1dno_8QtnhCKLMD4BmURc&e=
>   40. https://aka.ms/GetOutlookForMac

