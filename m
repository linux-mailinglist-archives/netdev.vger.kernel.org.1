Return-Path: <netdev+bounces-255470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBVaHdE6fmkOWgIAu9opvQ
	(envelope-from <netdev+bounces-255470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:24:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AD8C32E7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5569E30039B1
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0801834E76A;
	Sat, 31 Jan 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgkJGpac"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6DA34DB71
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880269; cv=none; b=SCsUvkEO8xiEvfHWL7kHK5u43NkQsZuX66Socp/6GmMky8vorDtI8ZDaM51LWaL9ic+OwOF8MQQW7b7lMh7cTb2ntqSuaFtjKIxdF5c7wifXPCoT162rlumzZNXMArLi7VNeNL3vAoXxWeKc7dTa85wA/zCpnE6S71gGPRChRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880269; c=relaxed/simple;
	bh=OEqIXbSaoOBliwhOLk1/fzNNjgw8LJKa+/nPC6uSmuI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nsDGQLOaE8z4zSXFUbymuWTeMjM80WV0siytXtAu/Z96AOWaCFAxu0CubBWMbdYmppoFrb7y45lxh5L8EsytbCKJupAzWRIMPQIkj+JpF3CnldD4KL1/mTYtpVbPdi7y9DxVFgEcDmAk3IFPw0k/ILaiKZmuuBrqwmvm31XIaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgkJGpac; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7927261a3acso33231037b3.0
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769880267; x=1770485067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKboPE3fl/KIx2BnHup4VWWuPwDj3/HflfhjNLtqX/k=;
        b=OgkJGpacg/e4iOyx9GUuq7QsRY94AJE1T9nSUJksi40hzXoTw/sfR+o4VUX5EFKx1+
         IyaOhW37MGHnF67UXslgv014+JNinaGXnOcQ1w1VetIBrUGLe/jG8aujibup5HNWJCZI
         +4tVGnixvC6vd5BfqbwJTzh/1Yyxmm98BOxJWqQF96hqoV+bAirkULviubykoS7HCSGR
         gZu/VSnlmX+mW/2UysnwOHqO+cElyBIQmMSiw6vPkmoHtC7kNV0MpctYagEQgQcLHpMX
         yp0qH99z/V6y7UzVn7uZCJM57oCoE5LwwUnrEUbi83HNZlKCi9ya04J7GVV7s7EZowOR
         eDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769880267; x=1770485067;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKboPE3fl/KIx2BnHup4VWWuPwDj3/HflfhjNLtqX/k=;
        b=Wp75BKoXb/6OGpDudqnuN4gSbWHE/0ZYH8OUBwoxO9ngTe7j3yo77EFT6Pb1Mz5HAI
         SVvlDO+8VxsRCb68cAbvkmHgmkZBWI758sfLs1v4E6KUA0QbjL+wWYfH6JT9n53Jzd69
         9shCIBEiBBffs8a2NrBsPsjbTPmGYJ0ddbZRc4kMI09zlgeU74D35/P+wXO7zOxw41F5
         LTc7NxBWDhvavbsF5uOt/A7wBnlLCmNu9lPwD8kj1dr7b0ZmAojXyv0G4NqlF3MlYCCk
         aduTPhnN9iaTF6ByeWaHlKwziFr8WIN48PgPv4Gn2ggHLwSU29SJSybiFToPYPuxM0MY
         Ri8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWucWWGaZJ8Pkd/FTmHndwLsb107nnzwUca3jRxtMpUcDltkJDv4McupNHBK61htRxuaj3ZXCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyadXk63EStDqgRewWB4jxD8+6jEHAxKswWQE3gO8XaALQF+Fl/
	WfXsEvZZtfRyav5PxXHhE8FsQG9vv6NwuA1im5DxV04g7MSZfdCA3RSWnasgkA==
X-Gm-Gg: AZuq6aKxeGkeg6aIXohVTDcV0ff2NbIRJXepbQz2b6i/i5D6xymDwstjBTy5tPu5cnE
	N8Y9g1xQqUnWEeST8XhnU5MlSA5ZtX8+b4QiO9103h+ft/pqAkt/L02MWCEL2tQWzypF1waUkiG
	+QkvjyNSbAWryUay/eW9j09v746HlGY9WRPvf4pUabFAjDvxyz39nePS0htzGPiaZtK+ANfMeSp
	X+qkGcYtD3e1XNOdRrEGeHE35+kc9JeMtHmMTeNv9br3B1Bvo3NIdPi4oMjTcPF2ebOyWIshtlo
	TU01Q/SmL7AeqXROBoGt02jAN7E700P1EPw+BIxp0AgdV2e4Xi04D7ltRPtAG9l6Ze3xeMpctJM
	6ouDdj4vC0h+ECmx7TzIf0st6EVXbTUifauyc6ky+EVWRA182NwsXg8DhhHKp/4nnRp/214og5v
	VjWLp7vpcNlmxhiGWZLPLMqa+9+6u0SaN5LL2TVwC+57vesohqrFTFTWK8P+w=
X-Received: by 2002:a05:690c:f13:b0:794:8f0f:e8b0 with SMTP id 00721157ae682-7949e04f18amr54506147b3.68.1769880267366;
        Sat, 31 Jan 2026 09:24:27 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79482766c5dsm47989367b3.12.2026.01.31.09.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 09:24:26 -0800 (PST)
Date: Sat, 31 Jan 2026 12:24:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Justin Iurman <justin.iurman@gmail.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.b21ec5446983@gmail.com>
In-Reply-To: <CALx6S37LRKzvGF8j93OECgDuVR9P4rz0DNMhM2JwaFziNq2vaQ@mail.gmail.com>
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-7-tom@herbertland.com>
 <willemdebruijn.kernel.19061eebdb902@gmail.com>
 <31232399-4cf4-49ea-b769-84aceca61dc9@gmail.com>
 <willemdebruijn.kernel.8e46b721f5ed@gmail.com>
 <CALx6S37LRKzvGF8j93OECgDuVR9P4rz0DNMhM2JwaFziNq2vaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 6/7] ipv6: Enforce Extension Header ordering
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255470-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[herbertland.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ietf.org:url]
X-Rspamd-Queue-Id: 08AD8C32E7
X-Rspamd-Action: no action

Tom Herbert wrote:
> On Thu, Jan 29, 2026 at 11:05=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Justin Iurman wrote:
> > > On 1/29/26 06:18, Willem de Bruijn wrote:
> > > > Tom Herbert wrote:
> > > >> RFC8200 highly recommends that different Extension Headers be se=
nd in
> > > >> a prescibed order and all Extension Header types occur at most o=
nce
> > > >> in a packet with the exception of Destination Options that may
> > > >> occur twice. This patch enforces the ordering be folowed in rece=
ived
> > > >> packets.
> > > >>
> > > >> The allowed order of Extension Headers is:
> > > >>
> > > >>      IPv6 header
> > > >>      Hop-by-Hop Options header
> > > >>      Destination Options before the Routing Header
> > > >>      Routing header
> > > >>      Fragment header
> > > >>      Authentication header
> > > >>      Encapsulating Security Payload header
> > > >>      Destination Options header
> > > >>      Upper-Layer header
> > > >>
> > > >> Each Extension Header may be present only once in a packet.
> > > >>
> > > >> net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
> > > >> enforcement of xtension Header order. If it is set to zero then
> > > >
> > > > [e]xtension. There are a few more typos in the various commit
> > > > messages.
> > > >
> > > >> Extension Header order and number of occurences is not checked
> > > >> in receive processeing (except for Hop-by-Hop Options that
> > > >> must be the first Extension Header and can only occur once in
> > > >> a packet.
> > > >
> > > > RFC 8200 also states
> > > >
> > > >     "IPv6 nodes must accept and attempt to process extension head=
ers in
> > > >     any order and occurring any number of times in the same packe=
t,
> > > >     except for the Hop-by-Hop Options header, which is restricted=
 to
> > > >     appear immediately after an IPv6 header only. Nonetheless, it=
 is
> > > >     strongly advised that sources of IPv6 packets adhere to the a=
bove
> > > >     recommended order until and unless subsequent specifications =
revise
> > > >     that recommendation."
> > > >
> > > > A case of be strict in what you send, liberal in what you accept.=

> > > >
> > > > This new sysctl has a chance of breaking existing users.
> > >
> > > Willem,
> > >
> > > Note that RFC8200 does not use normative language, which is part of=
 the
> > > problem. It could theoretically break existing users, but I don't t=
hink
> > > it will in reality. For that, you would need users to beginning wit=
h
> > > (joke aside, I like EHs). Anyway, if the order is enforced at sendi=
ng,
> > > why would any receiver accept a different order? In this case, bein=
g
> > > liberal in what we accept might be a security risk (see below).
> > >
> > > > The series as a whole is framed as a security improvement. Does
> > > > enforcing order help with that?
> > >
> > > IMHO, any packet with EHs in a different order than the one specifi=
ed in
> > > RFC8200 looks suspicious. So, yes.
> >
> =

> Hi Willem, thanks for your comments!
> =

> > Looks suspicious. But does not introduce concrete new risks?
> =

> Hard to say specifically. On the other hand, there's no known use
> cases for alternatives for it and given all the other security perils
> a strong default security posture wrt EH order seems prudent.
> =

> >
> > The main risk I understand around IPv6 extension headers is the risk
> > common to all untrusted network input: bugs in parsing code. Bugs can=

> > cause crashes, infinite loops, or worse subtle effects. This is why w=
e
> > introduced the BPF flow dissector, for instance.
> =

> I believe the main risk is Denial of Service attacks and security
> vulnerabilities.
> =

> >
> > I don't immediately see how different order of headers increases
> > parsing risk. Nor, btw, that reducing max number of headers from 8 to=

> > 2 significantly mitigates a real risk.
> =

> It's a similar rationale to putting a limit on the number of options
> in the first place. Going from 700 options allowed in a packet to at
> most 8 allowed was a no brainer. But even 8 is too much considering
> that the stack only supports three Hop-by-Hop options and two
> Destination options. There's a common misnomer that only hardware has
> trouble parsing TLVs, and somehow it's free in SW (I've been battling
> that mindset!). For instance, a well constructed attack could force
> one cache, maybe two cache misses per each option. So going from 8 to
> 2 as the default limit could materially mitigate the damage for a DoS
> attack on options.
> =

> >
> > No objections necessarily. But I don't fully understand the argument.=

> =

> We selected the default value of eight in RFC8504 based on an
> expectation that there might be new options defined and that the
> Internet would be fixed to reliably support extension headers
> including those with options. I do not believe either of those are
> going to happen.
> =

> Hop-by-Hop Options are ostensibly the right way to do network to host
> and host to network signaling.The only HBH options that might get any
> substantial deployment are Router Alert option and IOAM. The Router
> Alert option is being deprecated and IOAM is at best a "nice toi
> have". The best use case of Hop-by-Hop options is congestion
> signaling, unfortunately the die was cast when CSIG authors decided to
> place the information in VLANs at L2 and cajole the information to be
> routable through a switch. IMO, the miss on CSIG pretty much is the
> nail in the coffin for Hop-by-Hop options to ever be widely deployed
> (https://www.ietf.org/archive/id/draft-ravi-ippm-csig-01.txt).
> =

> Destination Options have proven even less useful than Hop-by-Hop
> Options. The only Destination Option supported by the stack is the
> Tunnel Encap Limit option and Home Address Options. The Tunnel Encap
> Option was buried in the v6 tunnel code which is why it wasn't obvious
> it was supported in the first version of the patch set.  I'll assume
> this might be useful, so this patch set cleans up the code for it. I
> don't believe there's any use of Home Address Option.
> =

> A major problem with DestOpts, HBH, Routing Header, and Fragment
> header is that they have no inherent security. Their use presents a
> security risk especially when sent over untrusted networks including
> the Internet. Given that and that the high drop rates of extension
> headers on the Internet, I am proposing that Extension header except
> fo ESP being deprecated on the Internet
> (https://www.ietf.org/archive/id/draft-herbert-deprecate-eh-01.txt).
> =

> IMO, IPv6 Extension Headers are a failed experiment in protocol
> design. The vast majority of hosts do not care about them, and the
> best use case for them is Denial of Service attack. So IMO the greater
> good is to limit them as much as possible. If some private network
> finds a use case for them they can also configure sysctls if they
> don't like the default behavior.

Thanks for the detailed context, Tom. May be good to fold into the
cover letter or commit message if respinning.

One remaining question: these features may be largely unused by
Linux systems, and Linux peers can be expected to follow RFC
directives on ordering.

But may there be other peers in the wild that are not necessarily
malicious, but just less strict. IOW could this break legitimate
users in the long tail of use cases of Linux in the wild?
Probably good to explicitly state if we are not aware of any.

Or abuses of extension headers for private reasons inside non-public
networks.

The risk/reward of lowering from 8 to 2 to me offers at best a small
real increase in security, but it may have real regression risk in odd
installations?

