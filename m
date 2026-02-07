Return-Path: <netdev+bounces-257778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Op/mIVKrh2lDbgQAu9opvQ
	(envelope-from <netdev+bounces-257778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:14:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4FE10724C
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BAD3010528
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 21:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA18A354ACB;
	Sat,  7 Feb 2026 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oy2taCo3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Quml3ClH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2C83542C9
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770498894; cv=none; b=tBqrUiR8bmF7Ojfkgy153vxD4h4WeO5uSP2Z+zwOBH9nDdtJa4sAYEyGvJo3lBvE2P6SH8s59vCLCcu3Zj91tkn3VMZGN03O9arnfpNCcfJC4qfKFsM3WeHNfabo8N8ftnLDn2X0FksI8pM/kBGwpymdQ/7N8CcN2RT4nYYCi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770498894; c=relaxed/simple;
	bh=yYsqxIDf0jWdw7ugKoIzML4fUYtXXfYz9CZyOBwqbG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tizh5sTKREXdhmhNMUBB7zlNpMvwPdAjOyNuvM5kvIQb86Tw+ic3gY5s4/gnIz0VqSXXJBNJuz2+50Z/Nvdi2f1x73Tdl7j/7mQDLn+NJDgilEoCAr6I5FDFAfInqnivRSxHhjs8heg1a9dWjtH9JNVTQSJ1WC49uZzKnW8MOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oy2taCo3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Quml3ClH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770498893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ay7waeK8INh+cINPaekYEvXT+aMvUwQTRSpP1Fkfng=;
	b=Oy2taCo3F4kTl2qjJF6WUrD/j8sx8NU0L3KlCOy8vfq9nvx8ys6E5aItOWAOAQpFEUvvWF
	/3XVVSKY6WPFzysCNCgsOvOdr+2s1NljwcSDqDHBa3TmT1H8JrWtN6y9byBcUisNCBDpjb
	iig1HdxQePbm/bOmGNqZxizbavJcX7s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-HKsgcS0LNCCUpe9-03ZrtA-1; Sat, 07 Feb 2026 16:14:50 -0500
X-MC-Unique: HKsgcS0LNCCUpe9-03ZrtA-1
X-Mimecast-MFC-AGG-ID: HKsgcS0LNCCUpe9-03ZrtA_1770498889
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso36097295e9.2
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 13:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770498889; x=1771103689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ay7waeK8INh+cINPaekYEvXT+aMvUwQTRSpP1Fkfng=;
        b=Quml3ClHJGuF2JeOz48bYuRwSnYeOR0lVbOGonVCirxWevOtNSYVexzKT6LNPUzbKL
         Z4lGWJ9LL4wcQ2GG2KMoxRaDHDMG2OkIuE4AlaWTutBTZuXgDCaXiEv1nFaXWVdY2KkO
         DY8Ud07IFytbnSlmx+TODbfqUqmLDR00VlVZpfJZRem0eYjslBSzpVRqiSG3286JqNua
         GGEidmG9O5NXCbHJt6BktbEraylwPcwGAkrKtb1ZA/2iJSkThamlBzh9yojepCrnAKcs
         Me0MNNJ5fnOA7rr3osfYOgI5muVbQjg/4PTHHCxotQdtWIN53Isj696ILDnJEPQwlDGI
         laOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770498889; x=1771103689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ay7waeK8INh+cINPaekYEvXT+aMvUwQTRSpP1Fkfng=;
        b=lmpyeMQWK5j2Dn08oLP8vpJHbybWjajFMpqHiisJ6Z3bCxiudycU/5n86mk5tJYnEG
         gERFStSs35tcrOnw2czFd/J3G1WIXQh+SxfWXeZPQwbN+JEN03MTCGdyC+ZO5A486B+8
         3YHrbZnS0rNq2Gt6ZiNUII+DvSPsSUUmk6qa65cNtPr2ayqnY2UQA0YMR703HIxX0g09
         BK2fHKO7E5211uPXafo1dKhhI0uiMNPa88ipOb1bmun6e2zw95A2rv3yF5V6qaxWPQvA
         3GBF4ON2MSp8pJy4X4d1ujuXbrE1QJ1hTqcrdcabET/7Azf6ShZxTnWnxQ6yLZ7BM3uY
         srmA==
X-Forwarded-Encrypted: i=1; AJvYcCXL8907rzu36YgQeHAd2e9y3m1dr+5vKgmoPgNKY3vgBqoMyR0QIGLfTqTn5Kg8ltDD26aWgAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfdqCetZvqm+ZoJQWFKSHAaPJArFLfop5ry7KoMfdOcOszScBG
	7MQWCrUySztWoC2q93Pu5ejjBGGNrswEaRGm0MCrO8vs2ps4Y/OtfSFFIPUBV2KnoevNF57QT43
	kGvLcFSWuxYafTb+SNgeuz0RnrNq7spqm8dQHes1CRobrqvDP382rA2bBBA==
X-Gm-Gg: AZuq6aLKY1EVQmXtUnigHtLFqwQy1UvJSk+b7ly61DdXDYPl3XYCAf5lfjGBMwXL4Fd
	utBfY4R1I26vlUp8LgsiQlZrxC1WJJR5dtQsFiJIuZJOraK90PhpCmyKEA9vqfSIbwkvoizBcWV
	Q04mte0MsyGeZPW4FJg2DzCxrSmR/WDn7uaxVC6my2hyhGFgAbEyfd4/4L52PmkBQRHPeCluY0m
	ylkjlreSLuBkEI/EvOm5ZsPF1NHrwFVT7VPpViO0FkMCDpBn7ThlcchwEQDDFBuN5ABHBLcmUmB
	ZDr1UmdsYUfN84el7SubwXpFFWTBX46RmyWYEq3x+fWMh+mGX4DcFYEb/556M4xsT56nSwqZng3
	cBbpxN0BrqYMfWioDF9tzy0Bx9+V7kfiLxw==
X-Received: by 2002:a05:600c:5253:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-4832021b53dmr107227025e9.21.1770498888667;
        Sat, 07 Feb 2026 13:14:48 -0800 (PST)
X-Received: by 2002:a05:600c:5253:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-4832021b53dmr107226685e9.21.1770498888085;
        Sat, 07 Feb 2026 13:14:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832040e91fsm51832075e9.6.2026.02.07.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 13:14:47 -0800 (PST)
Date: Sat, 7 Feb 2026 16:14:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20260207160509-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205184328.3b706154@kernel.org>
 <20260207045848-mutt-send-email-mst@kernel.org>
 <c96d6b1c-5bad-4e06-905c-10f722c9b9d1@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c96d6b1c-5bad-4e06-905c-10f722c9b9d1@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257778-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF4FE10724C
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 07:14:25AM -0600, Dan Jurgens wrote:
> On 2/7/26 4:01 AM, Michael S. Tsirkin wrote:
> > On Thu, Feb 05, 2026 at 06:43:28PM -0800, Jakub Kicinski wrote:
> >> On Thu, 5 Feb 2026 16:46:55 -0600 Daniel Jurgens wrote:
> >>> This series implements ethtool flow rules support for virtio_net using the
> >>> virtio flow filter (FF) specification. The implementation allows users to
> >>> configure packet filtering rules through ethtool commands, directing
> >>> packets to specific receive queues, or dropping them based on various
> >>> header fields.
> >>
> >> This is a 4th version of this you posted in as many days and it doesn't
> >> even build. Please slow down. Please wait with v21 until after the merge
> >> window. We have enough patches to sift thru still for v7.0.
> > 
> > v20 and no end in sight.
> > Just looking at the amount of pain all this parsing is inflicting
> > makes me worry. And wait until we need to begin worrying about
> > maintaining UAPI stability.
> > 
> > It would be much nicer if drivers were out of the business of parsing
> > fiddly structures.  Isn't there a way for more code in net core
> > to deal with all this?
> 
> MST, you reviewed the spec that defined these data structures. If you
> didn't want the driver to have parse data structures then suggesting
> using the same format as the ethtool flow specs would have been a great
> idea at that point. Or short of that padded and fixed size data
> structures would also made things much cleaner.

Oh virtio is actually reasonably nice IMHO, and of course
virtio net has to parse them. But a bunch of issues
I reported are around parsing uapi/linux/ethtool.h structures.
There is a ton of code like this:


+static void parse_ip4(struct iphdr *mask, struct iphdr *key,
+                     const struct ethtool_rx_flow_spec *fs)
+{
+       const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
+       const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
+
+       if (l3_mask->ip4src) {
+               memcpy(&mask->saddr, &l3_mask->ip4src, sizeof(mask->saddr));
+               memcpy(&key->saddr, &l3_val->ip4src, sizeof(key->saddr));
+       }
+
+       if (l3_mask->ip4dst) {
+               memcpy(&mask->daddr, &l3_mask->ip4dst, sizeof(mask->daddr));
+               memcpy(&key->daddr, &l3_val->ip4dst, sizeof(key->daddr));
+       }
+
+       if (l3_mask->tos) {
+               mask->tos = l3_mask->tos;
+               key->tos = l3_val->tos;
+       }
+}
+

and I just ask, given there's apparently nothing at all here
that is driver specific, whether it is generally useful
enough to live in net core?


> I thought this series was close to done, so I was trying to address the
> very non-deterministic AI review comments. It's been generating new
> comments on things that had been there for many revisions, and running
> it locally with the same model never reproduces the comments from the
> online review.

Uncritically posting, or trying to address "ai review" comments is not
at all a good idea.


A bigger problem is that we are still not done finding bugs in this.
My thought therefore was to see if we can move more code to
net core where more *humans* will read it and help find and fix bug.

-- 
MST


