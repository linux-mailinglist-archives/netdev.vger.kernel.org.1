Return-Path: <netdev+bounces-295768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EntnI7OkImqUbQEAu9opvQ
	(envelope-from <netdev+bounces-295768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:28:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5E64751A
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:28:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KT04uiqE;
	dkim=pass header.d=redhat.com header.s=google header.b=ZBTL1nNs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295768-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295768-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7CCA3031019
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0666C3F5BDF;
	Fri,  5 Jun 2026 10:13:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E323F4DE4
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 10:13:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654413; cv=none; b=L/xho7TiI03liNvJ5zVYb06uBIyHa5Q5dUG62hwgtD/HC/lvYwFTlu96oc0mq314mwsorZwyAAGf9czhN/c2VKtr8nLcJJtWZzAbX590kMiDfh0I27A8Vb5m+o9JsVB3ue92x6ilKfJae5IU61UKgHvslhCFVyz0SQhEWN+kiuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654413; c=relaxed/simple;
	bh=rmrP0CKPuij0Mb95o8DBviq5T1C9biiS/sWkMpBJrqU=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=gC67kDbG4qGj3hohGzpcbHkUICfi8N5AoRs8USsxGgtDsAQpPz0LGPeTao7izdDNxwgq4Pxr0dMQC3oLGRi3fpze0Y+kogKBThqvL9FYHaPdsvqDb4jviiZ2ABWlo1mV900b6ZeqUq8zOU9+pPZNscW8qNBVynYnRi7cwcEW1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KT04uiqE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBTL1nNs; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780654411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLB31a1gGAMdNDuc+HogbludLHSY28HNq/UbUahWglY=;
	b=KT04uiqE+fHTSLKArowfX5FO/8bMueELzy4NNrECU3DWkR+PQCZ5ifu0EGcZyruZCMwXNE
	6cMfm4p1ZLxgLZNFy+GpsjfCJdD24zpo3/hUK7VoSmnzJaAi/R5OuAHfupR8s3O34t72WD
	4AWC3e630QHYc57ezv+G9QRh9/dEsdw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-LbE7SCXwPh2Lou6wDN3JUQ-1; Fri, 05 Jun 2026 06:13:29 -0400
X-MC-Unique: LbE7SCXwPh2Lou6wDN3JUQ-1
X-Mimecast-MFC-AGG-ID: LbE7SCXwPh2Lou6wDN3JUQ_1780654409
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460163035e3so1059201f8f.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780654408; x=1781259208; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLB31a1gGAMdNDuc+HogbludLHSY28HNq/UbUahWglY=;
        b=ZBTL1nNs3Emx4ZAyKqagoIT/7UYLIIiBKGsBbic/BqRCmKtpZqzNqxCdNeHvETEckY
         M3jrgWWg/IF3L/fS5xTuCQ31gV+JTXTe3GM97ZPJjQIR/qc9RciW467erRvysUjM6k5m
         y2hiAM0Zn6kvywCaxRNDd8AnoeuCU+oCjcvSMsnaowgkMCHR+MObw4c02r3s+ump28+6
         xLRt62tI53Onp5LybmEL6vZySyv8O19rXrnk6an1qnH4NH85mENAIvRMShEgnhuYIt6o
         gAGWKwblHa/Esq1bgJigrtxVozV4NKINE/wXRs0/4+jQkgQIiTjYWdfr9MCeUeoRQwD/
         Mupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780654408; x=1781259208;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLB31a1gGAMdNDuc+HogbludLHSY28HNq/UbUahWglY=;
        b=Qeo0rhnUHjQY5WmkOvIJNhGOwXhEF4ckAw7hBlGOFFtg0GRzUJV8DKrsQRPrjJ22h4
         h06q9Wfb+T8M2qxOVMSGY38e05S2E/0ypSkDpOcOeooIg5zW8NhOgnSNeXv+V56qEctv
         7+5ONr5IsTlX2n4l6Fcbw9BuBrlxQ/KI8k37avoiUpdbo4H2uvYI4gLl3emhKV9NST9W
         J2GXAcPTl8lrFMHn79vM/BdcTpADz7V3koCUOjCJyejo9qtzdRkXa5Z6sb/MKykGezQQ
         ygMVSjf6Fy9MLWMHG1Hqn8hKM9vtKKqXUCYwnzES2KbPHssEGSLF+yZkW1aG/A3pqfp+
         Kq3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/sz4THi25XXaSafBSgo9flZuSRTVWNY7Up4BFM0FBm95TCgNCBlvh5Gn91OinZWCey0/xHotU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Jz80clO4JfTYiHNTLr35BDbdRoTf/KmjuythUFzlQJT04B12
	XRwrEy8C3Bk8zfX0p1xUsCfUTSgKcdyeCk9Q+dfxv3tM0Z+kXRyw0w4IVTuTnCGlA4iaTyOh8MP
	U/wRLPCkk5NlrIf1ahlMGUikQRgyXwCCAOP7ObiXy8ZFD0wavwfwCgNwJeThQgRF33ltF
X-Gm-Gg: Acq92OHeEifiCStiddgFZgq0TRS0pTRJxJR7/mbVBz+kdK6o88mzb3hTylDrP6RKqRx
	aMvz1YQlQW5cHWoTgmpGJ8qpacY2NHg5cJ7+OuNPkI7TtVHIZOAphJO4C8cjoEmmExuEcQNWIlV
	+Vp3bIV8/Qx8wIc5Hbx7vO+4A6NRioigoXJp5nl/RhzsTPSTZb90cWzdb/jwPb6kOBt+gF0xbLY
	DU3vEeKuurJRRKmRChiDwkoWEOAul0DZFLFRQeSzOGLk29jg+V2JGcoTkJlg2Ux4F02uz7NOo7K
	RwI5xTLJpWLEAb+clUOTJ5Z3afgva29qoe9najCJfyUCkpEnzoKn9hHaHiQV2cO9/hgkYijHL5b
	loJ92hghAJotREWO0mLGC9W15jWpT4MzREHEHzb//iig=
X-Received: by 2002:a05:600c:c0d0:b0:490:c2a3:abae with SMTP id 5b1f17b1804b1-490c2a3abf2mr29040405e9.34.1780654408396;
        Fri, 05 Jun 2026 03:13:28 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d0:b0:490:c2a3:abae with SMTP id 5b1f17b1804b1-490c2a3abf2mr29039905e9.34.1780654407854;
        Fri, 05 Jun 2026 03:13:27 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm26336854f8f.35.2026.06.05.03.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 03:13:27 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Fernando Fernandez Mancera
 <fmancera@suse.de>, netdev@vger.kernel.org, yuhuang@redhat.com,
 justin.iurman@gmail.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, Chris Adams <linux@cmadams.net>, Beniamino Galvani
 <bgalvani@redhat.com>, Thorsten Leemhuis <regressions@leemhuis.info>,
 Andrew Lunn <andrew@lunn.ch>, ihuguet@redhat.com,
 regressions@lists.linux.dev, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Matthieu Baerts <matttbe@kernel.org>
Subject: Re: IPv6 address insertion order (was Re: [PATCH net v2] Revert
 "ipv6: preserve insertion order for same-scope addresses")
Message-ID: <20260605121325.3d426dc4@elisabeth>
In-Reply-To: <20260604183909.GA877115@shredder>
References: <20260529112357.5079-1-fmancera@suse.de>
	<20260529134045.56330243@elisabeth>
	<ah57wxGjL7JBORR1@zatzit>
	<20260602132118.GA508395@shredder>
	<ah-SvHdPRrYXX6lx@zatzit>
	<20260603074717.GA569921@shredder>
	<20260603174538.5454bb93@elisabeth>
	<aiDUMHKi2Sn1_dYD@zatzit>
	<20260604183909.GA877115@shredder>
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
Date: Fri, 05 Jun 2026 12:13:26 +0200 (CEST)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295768-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:david@gibson.dropbear.id.au,m:fmancera@suse.de,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:linux@cmadams.net,m:bgalvani@redhat.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,m:ihuguet@redhat.com,m:regressions@lists.linux.dev,m:nicolas.dichtel@6wind.com,m:matttbe@kernel.org,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gibson.dropbear.id.au,suse.de,vger.kernel.org,redhat.com,gmail.com,kernel.org,google.com,davemloft.net,cmadams.net,leemhuis.info,lunn.ch,lists.linux.dev,6wind.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9C5E64751A

On Thu, 4 Jun 2026 21:39:09 +0300
Ido Schimmel <idosch@nvidia.com> wrote:

> On Thu, Jun 04, 2026 at 11:26:08AM +1000, David Gibson wrote:
> > So, I second Stefano's arguments for the most part, as well as
> > re-iterating that being broken by this change would require the
> > intersection of two unlikely conditions (misusing NLM_F_APPEND *and*
> > expecting the "wrong" order).
> > 
> > That said, Ido, if you're still not convinced I can do this as an
> > attribute.  It's more hassle, but I can make it work.  
> 
> I appreciate the survey that Stefano and you conducted, but there is
> still a non-zero chance of causing regressions by suddenly giving
> NLM_F_APPEND a meaning in RTM_NEWADDR. We already tried the
> "change-and-see-what-happens" methodology once with this feature and it
> backfired, so it's going to be quite painful if we miss again.
> 
> As I see it, we have three options:

Thanks for the helpful summary by the way.

> 1. Use NLM_F_APPEND. Relatively easy change in both the kernel and user
> space, but at the risk of reintroducing regressions.
> 
> 2. Add a new attribute (e.g., IFA_INSERT_MODE with DEFAULT/APPEND
> options). Less risky than #1, at the cost of a bit more code in both the
> kernel and user space.
> 
> 3. Do nothing. As I understand it, any production software (as opposed
> to a test script) that cares about the in-scope order will have to
> maintain a fallback anyway (e.g., iterating over IPv6 addresses in
> reverse).

It's not always enough, or needed, or practical, though:

a. 'ip address restore' could be "fixed" to load the addresses in a
   reversed order for IPv6, but what should 'ip address showdump' do at
   that point?

   Also reverse the order? Or not, because that's the order addresses
   were dumped in? I'm fairly sure 'ip address save' shouldn't reverse
   it. It would be more convenient for the other operations, but
   definitely wrong, because the kernel is picking addresses in the
   opposite order.

   All these are doable, some look questionable, but any of the possible
   workarounds looks hard to document, or even remember.

b. as to pasta(1) and passt(1): the regression introduced by the revert
   of the kernel change isn't a big one: after all, we had the right
   behaviour for just a few months.

   Similarly, if the kernel gives us a way to get it right, we would
   just stick to it for the future and be done with it. Adding a
   workaround for older kernels isn't a priority because there was no
   regression.

   Side note: the workaround would be rather impractical for us because
   we don't use dynamic memory allocation, but we certainly can't blame
   the kernel or anybody else for that.

c. regardless of how addresses are dumped to userspace, there would be
   no way to get the kernel to do what one reasonably expects it to do
   (also from established IPv4 practice): *use* addresses in order of
   insertion

By the way of c., you're explicitly excluding test scripts as they are
certainly less important, but does it really make sense to force people
to to maintain the kind of workaround Matthieu mentioned? Reporting it
here for convenience:

  https://github.com/multipath-tcp/packetdrill/commit/1b7cd4482ce8

> Therefore, the changes in #1 and #2 are not strictly
> necessary, yet they are uAPI that the kernel will have to maintain
> forever.
> 
> Given the above, my preference would be #3 -> #2 -> #1. The first two
> options expose the same capability to user space, so #1 doesn't buy us
> anything over #2, except a bit less code, but we risk introducing a
> regression.
> 
> Between #2 and #3, production software can't drop the fallback even if
> we implement #2, yet #2 requires us to maintain uAPI forever. I think we
> should accept that the divergence between IPv4 and IPv6 is not ideal,
> but at least it's predictable and dependable (Fernando is working on a
> ksft and documentation).
> 
> That being said, you can send an RFC for #1 and see what others think
> since at this point it's unclear who is still following the thread.

I think there's general consensus against #1 ("abusing" NLM_F_APPEND),
but still, I think #2 is very much needed and fundamentally harmless.

-- 
Stefano


