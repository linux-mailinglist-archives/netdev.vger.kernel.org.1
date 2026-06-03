Return-Path: <netdev+bounces-294822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TIx1CjlXIGoM1gAAu9opvQ
	(envelope-from <netdev+bounces-294822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:32:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ABD639C28
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:32:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ov7GxPJV;
	dkim=pass header.d=redhat.com header.s=google header.b="bLirVto/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294822-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294822-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C31E63129C6E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBA63D75B4;
	Wed,  3 Jun 2026 15:45:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C73CF04F
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:45:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501551; cv=none; b=nHIhtk74ECdZ5A+Jyom+5bDjHrMHrXKXNr6yDyFCFpIv5kQpWWU8Ke9XpdyCX+xFeySaETkryuXy0OcOau7mYMYJVoxGidm6P+4RsZwwEfhn65Pa/DStZWaKRXaGFCo8RAJEXWt3elcTmfgMWlUeq7xt68Mi73btRJAc0nAFhWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501551; c=relaxed/simple;
	bh=lzW7exR1kNCxPyuPkHgqBWbInC7o9p5ohCfDidT6udo=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=bMAbkVS4ikhkh7vpDW+qdYL8Dg4T3T45nvehLrGoQIt25L6svhOljxH9Ye+jkpfErGTUsKWWp1MJrsLcbZC6DxGokjJ8vSE0eiTUY7SBIwfJZz+9kJSfa4fMDY7+N2vT6fnu3tIJC0YRIheSulgi8PVDErOVbql/NO5qyObjqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ov7GxPJV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLirVto/; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780501546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5PBr/5K2c7sLCGfLZpy7whhqK6W/Z0MTaU2ybEk/CQ=;
	b=Ov7GxPJV/V4/BOsKXvYcFe5kZXdzmYovXB8mUg4OzzET8Zcu3HnbXAgeQXVW/OYlmw/YNt
	Tn3bCkWVrE5AJKd2v/WLJZk/afyYCiYnlnUi0O4Vk4u4Xze1xCTJc9ROaoBi95cIHBls0a
	1s1IO+av+od1ga4139LsJYr6Ni0TrVc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Th7lIVjqPEycf2yVbvJe7Q-1; Wed, 03 Jun 2026 11:45:43 -0400
X-MC-Unique: Th7lIVjqPEycf2yVbvJe7Q-1
X-Mimecast-MFC-AGG-ID: Th7lIVjqPEycf2yVbvJe7Q_1780501542
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef4931de5so516955f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780501542; x=1781106342; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5PBr/5K2c7sLCGfLZpy7whhqK6W/Z0MTaU2ybEk/CQ=;
        b=bLirVto/Sx2yl4fUklx1UlJgSEu1RFTk/seZrxj0JJGyhOIi0QliV/1fvwXBPDQ/5Q
         VKYPKU7+poUAD5mjZ+IlStiXKjCTSn/NfowXwA/uWZZuxV4SWl4lKsTkompTJ56HloZl
         CSZFSm3OQU4s9SaLMgh1MY0f3rzVI9y3QY3PCAa2X3icV0L/DzIo1bmSN2/aj2yAtUGo
         ShdtmhHJDiRST8+rPZX0SwyWXhYWz/mpoxRy6ZD06p5kZdfVbAM+hBgdpldwAmp9MxWV
         zwWT0j1R82VNhVqFjnpTZWQoSHFWRYhlW2o4EK7jGAx5tzsSkTZikm5BmsO4gFUmq+LH
         ystQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501542; x=1781106342;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5PBr/5K2c7sLCGfLZpy7whhqK6W/Z0MTaU2ybEk/CQ=;
        b=CI0AsxVBHmdaRdETF+cEfBy47LTJV60WUG3NgSX85QtF2Gp8S/B4qvQ1Aulh5OLDvz
         ikwJFiTdOKaBuuX5knbVCBojjs0qbnavXIBcU/JDqThxrBKT93ezLUcrdWgZux+BDCtx
         7LAVA8td+uVHjesihBz71jigFcJlVR+v5+K4++PZKOpUGgJkgr4M0NlHwn7j0DgW5u54
         DRhHsjBPWQozY9UPh9VxI/Mo7KA3DOmeQwTphuoR/sSvz4Zd0pT4d126Eb/5+Honsp7O
         gtr1IRsQzcRBPZUYaJpmqHikSGDIO65kG5meKvKDksjueHPXeNAfNbkw/joO1+4eJpYw
         dDIA==
X-Forwarded-Encrypted: i=1; AFNElJ+C6iUJuL1+NM6/wstIC3uliQZP4I5vOqGDNVh2sgbU1MOGWtqn6tY29huULrzL679gIHWtdCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+C3T8rOpA86KH8n2JgSI0hccbaS5QC0aEdMl+/E+DEWz+g8s
	WlRpy92mheCw4CpE/hX/WN9EtBxSM/LmESwhUGPCsJU3pL6mhS/oKP/Gh9L4eR9oGuVwAP+9AC+
	6w6Wh+QWuaunXR5tX1GGEPnelnXxai6PLAPyUQlWplRvVlZZ8l2AYudrf5w==
X-Gm-Gg: Acq92OG5iULDJ2wGnSUx4Moa7OhMdaFAFpFy8qfll2ndrrwt1SQps6cDgxahM6UwLtS
	yaYC9Dqhmc6e5iQlZg4CV7ONujDtrlfQ/2HAr0k8Ul0i1nSHh7t3chlZSQ1ma745R0jhRjXeEQF
	r2SeMxqKODo+oYGhXm+ECXoAmSNtBMfV8xwGnoOa1bXRLJMs79tcTAUU8NSo6qv6NvoWDqh82a5
	W5cGP4+9QgRTNziwjkNQxvtXcRTXGmVPvauBqEpyJHp9TWqRMyZzh1HKH4In5Ei3W7JLqFWSAsO
	sKAZ8GkYQSW3DyASinaVi+7GtjlCHe7EFDA3FofS6/uCIvjuun2U7egEvkMLvAIW55Da2uSwdJz
	yNbnXF+OoaG/O2Zjm9cspA1i3LdIKLCbIVdQJpcpU1MQYRXJn4EOd1qOSI7wg
X-Received: by 2002:a05:600c:8184:b0:490:ad1e:1846 with SMTP id 5b1f17b1804b1-490b613f158mr48109575e9.9.1780501541706;
        Wed, 03 Jun 2026 08:45:41 -0700 (PDT)
X-Received: by 2002:a05:600c:8184:b0:490:ad1e:1846 with SMTP id 5b1f17b1804b1-490b613f158mr48108945e9.9.1780501541151;
        Wed, 03 Jun 2026 08:45:41 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c183asm974145e9.6.2026.06.03.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:45:40 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Fernando Fernandez Mancera
 <fmancera@suse.de>, netdev@vger.kernel.org, yuhuang@redhat.com,
 justin.iurman@gmail.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, Chris Adams <linux@cmadams.net>, Beniamino Galvani
 <bgalvani@redhat.com>, Thorsten Leemhuis <regressions@leemhuis.info>,
 Andrew Lunn <andrew@lunn.ch>, ihuguet@redhat.com,
 regressions@lists.linux.dev
Subject: Re: IPv6 address insertion order (was Re: [PATCH net v2] Revert
 "ipv6: preserve insertion order for same-scope addresses")
Message-ID: <20260603174538.5454bb93@elisabeth>
In-Reply-To: <20260603074717.GA569921@shredder>
References: <20260529112357.5079-1-fmancera@suse.de>
	<20260529134045.56330243@elisabeth>
	<ah57wxGjL7JBORR1@zatzit>
	<20260602132118.GA508395@shredder>
	<ah-SvHdPRrYXX6lx@zatzit>
	<20260603074717.GA569921@shredder>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 03 Jun 2026 17:45:39 +0200 (CEST)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294822-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:david@gibson.dropbear.id.au,m:fmancera@suse.de,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:linux@cmadams.net,m:bgalvani@redhat.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,m:ihuguet@redhat.com,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gibson.dropbear.id.au,suse.de,vger.kernel.org,redhat.com,gmail.com,kernel.org,google.com,davemloft.net,cmadams.net,leemhuis.info,lunn.ch,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,elisabeth:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26ABD639C28

On Wed, 3 Jun 2026 10:47:17 +0300
Ido Schimmel <idosch@nvidia.com> wrote:

> On Wed, Jun 03, 2026 at 12:34:36PM +1000, David Gibson wrote:
> > On Tue, Jun 02, 2026 at 04:21:18PM +0300, Ido Schimmel wrote:  
> > > On Tue, Jun 02, 2026 at 04:44:19PM +1000, David Gibson wrote:  
> > > > I get the impression there's a rough consensus that the best we can do
> > > > now is revert this change (already done), and make a new patch which
> > > > changes the insertion order to the "correct" one conditional on a new
> > > > flag.
> > > > 
> > > > Stefano has enough other fires to fight, so I'm taking a look at
> > > > implementing that.  Some initial thoughts, that I'm soliciting
> > > > feedback on:
> > > > 
> > > > 1) I'm assuming the idea here is to add the new flag to nlmsg_flags in
> > > >    nlmsghdr
> > > > 
> > > > ifa_flags in ifaddrmsg would be the other candidate, but it looks like
> > > > it's encoding properties of the address itself, not about the action
> > > > of inserting it.  Plus all its bits are allocated, anyway.
> > > > 
> > > > 2) Could we re-use NLM_F_APPEND?
> > > > 
> > > > The short description of this existing flag in linux/uapi/netlink.h is
> > > > "Add to end of list" which sounds like the right thing.  Looking
> > > > closer, however, it seems like what is' used for so far is things
> > > > where the entity added with the NEW<whatever> operation is itself a
> > > > list, and NLM_F_APPEND causes it to be added to rather than replaced.
> > > > It's not used for addresses at present, AFAICT the list of addresses
> > > > is a semantic level above the address entity itself.
> > > > 
> > > > So maybe re-using it for the thing I tentatively called
> > > > NLM_F_INSERT_LAST would be confusing?
> > > > 
> > > > On the other hand, it's not used for addresses at the moment, so
> > > > AFAICT there's nothing actually preventing us reusing it for this
> > > > purpose. That would save a bit - we only have 2 general and 4 NEW
> > > > specific bits left, by the looks of it.  
> > > 
> > > This is not really viable. Even if the kernel is not using NLM_F_APPEND
> > > for RTM_NEWADDR, but not rejecting its presence either, then we can
> > > create a change in behavior for a user space that is currently setting
> > > it (intentionally or not).
> > >
> > > Example:
> > > 
> > > https://lore.kernel.org/netdev/27c249d80c346a258cfbf32f1d131ad4fe64e77c.camel@debian.org/  
> > 
> > Hmm.  So, in this example case we have a known, widely deployed
> > userspace that was broken by the change.  Similarly with the
> > original now-reverted "fix" for the ordering, we have a known, widely
> > deployed userspace that was broken.  
> 
> It was also reported over three years after the kernel change went in.
> Point is that we have no way of knowing how user space is using these
> flags. Suddenly giving them meaning when we simply ignored them before
> is risky.

I think that's a very different type of issue because, there, *another*
existing flag (NLM_F_EXCL) was suddenly given a meaning, as it happened
to have the same value as NLM_F_BULK, and that's what broke libvirt.
Not support for NLM_F_BULK itself.

Here, NLM_F_APPEND doesn't share its value with any other flag, and it
really is documented as "Add to end of list", but we don't do that.
That's a bug.

I think it's actually more likely that some bits of userspace are
currently broken and causing subtle issues because the author expected
NLM_F_APPEND to actually do what it promises, but maybe they only
tested that with IPv4.

Allow me to draw a parallel that looks more fitting to me: in commit 
1e47b4837f3b ("ipv6: Dump route exceptions if requested") I happened to
fix a two-year old issue that made 'ip -6 route list cache' show no
output and 'ip -6 route flush cache' have no effect.

You could take this to the extreme and say that it was risky to fix
that because some userspace application could meanwhile have started
relying on the fact that 'ip -6 route list cache' returned no output.
I guess we agree it was a good idea to fix that, though.

Of course there are several degrees of UAPI expectations in between,
but *not* allowing to use NLM_F_APPEND to append objects because
userspace might rely on NLM_F_APPEND to *not* append objects sounds
a bit like this extreme to me, or at least closer to it than the
NLM_F_BULK kind of breakage.

> > That's a different case from a hypothetical userspace that incorrectly
> > used NLM_F_APPEND on RTM_NEWADDR.  Moreover, to be broken it would
> > need to incorrectly use NLM_F_APPEND on RTM_NEWADDR *and also* rely on
> > the counterintuitive and inconsistent insertion order for IPv6
> > addresses.  Absent a concrete example of something meeting both those
> > conditions, I'm inclined to breaking that hypothetical case when the
> > payoff is an easier route to get known cases working with the
> > preferred insertion semantics.
> > 
> > Fwiw, I did look at the most likely candidates: iproute2,
> > network-manager and libvirt, and I see no signs that they're misusing
> > NLM_F_APPEND in this way.  
> 
> See above. I don't like this approach. IMO, it's not worth making it
> slightly a bit easier for some user space programs to adopt when the
> risk is breaking other programs and repeating this ordeal.

Another fact we shouldn't ignore is that, compared to the NLM_F_BULK
incident, we're actively surveying userspace before touching this.

-- 
Stefano


