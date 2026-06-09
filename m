Return-Path: <netdev+bounces-297043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z0ChK40KKGpg7wIAu9opvQ
	(envelope-from <netdev+bounces-297043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:43:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C7660211
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:43:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=A72kV2gu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297043-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297043-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B40E300D577
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 12:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E474183CE;
	Tue,  9 Jun 2026 12:43:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662D413D86
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 12:43:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009021; cv=none; b=MDh/cvpAKktkwukgJsX4LyTlFRTUT2unbGvEAnPRECTXK6jIndJgUB2Mp3duf7O5ojjYcisUH7uCw0ir07QkXS4mJTxqlTLCw+s3kEDM2D4XuZivf//ZHZbivtRphy6tw90womDS20z5ymHD9A8eNCOQ1uxQZ8t/RnX/MDj3LKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009021; c=relaxed/simple;
	bh=r87AOgf09jBawFk7Oijp6ve8K4PXrB0C8y80U0hyvYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+r5CCVavi5Zi0xJlACzG+O1iCQy4x7imLeELhpEl57q4vb7BzygrTejJeht7Se69y8r3BOEUmp/qW9WiZP4P1ItmfrPFRj/lY0JNKKfrI5PmPAYfNUXMXNgI6MgNnMzabBFI+xUcy64L+j9DivhMrkW1LqO+j2RoNlhup4hReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A72kV2gu; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so30979685e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781009017; x=1781613817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX0FouJIIFyZjl2k/xAPoma1e0chrivslO1nWJVjm1U=;
        b=A72kV2gueiUXShVnAFagtIoPsLnTEa3A8dCCgQXPKJBWG6IkUN2QHHl1CLX3hqr4vH
         uEhqBTqIknZ6+y1xTEHVudrjG33b73eWBabN6IJ0jrYu+7WGPoorxvSZdS08LlXeBPI9
         pWCLm+VYqQEBKrH742GuK5UnUk/DesrNflzxYhtUaDXDLG+QpNWvymRNSnbMKsNt5ATq
         W3eOm7MY7d9Hmj41DdrJ5dgRQrAZ/+d/s+j4p6YdwN4tIx82SUDOFrYYEyf6bIRNu1l7
         f6/A4rimCgAUiG0ZSiGJdZUK+1UdevfS19CbaxSU/S5nSupBPLr/68joQPCPT4vJT8Bb
         PyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781009017; x=1781613817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kX0FouJIIFyZjl2k/xAPoma1e0chrivslO1nWJVjm1U=;
        b=DW0YiUNEsgbInmqeX+ZweindrVd3H8Fmtm7wL1oXAiTBz5NigaJP7WqLyFYziBD3S3
         zzmZ/VM1H0ThhD1DuYy+CmTVqFVNv+kPmK1gJMNCvla9/65DnagD0M4SIjpxiwR5jZV0
         GILrX+ZGqbrgIH5n44V40ZszbZlSXy2e9vwE/num6548H1hpdmLPciSka+I14CUD9SY0
         gIej/R5PcT3G6wLb413St54jXZ19w87jQXZY3P69swZ+ZdzwCPYbrfQBkOsX1X6JcEc7
         70+0kIoSybN3/Znng3mVPPubEgSZH3q2bvzXL4NoHRksYdQLs99I/FId8XRxRPxMKoQQ
         xWuA==
X-Forwarded-Encrypted: i=1; AFNElJ/8VyVxXkHc+jgM1CJClq2Jb3j5/OgrL/wwkeEQjkHpHVYCLlPqURPzs51nxMK9MiC1F8HknBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+PjBNz2OTN0Nmsk2XzEH6daZFitKds2z1Q+dGqy8fcbMGe6h
	qv5XCma2PxuC6L1aksxrpO0oynC7S2I9poumQXx7QLyafE2xMYBdOc1jlWlDBaU6
X-Gm-Gg: Acq92OExq8o4/N+QkcG8s/UKh+QPjXvHKtzrfG2QM7if9Ox6mjlbwQpRl0DVeiNdM7E
	o4gZd85kO15sLHnTMJAthFnub3aXPUgiaBq8odu7uPrOpa7spLcPNRyzNPUPoM5dnH9a6RNdYQv
	77wvuJpbiykLTVl/P4eO2jERJdTxNpRlg/7+xotWKZ97NgQMquKgo061+tA9dxSdMjw+L4Xki+g
	VNcHJz/7tX3/P1xe5oC3sfIGq7z2r1Zrg1yax/ZLPOCBMSSYPVDYl0zN6PpAABCPBRn9vBhc/5H
	FBND705nDMvZGp2EJppEAw1MuBAFmQBCRYCHQ7oOKxPCVeMAU4rf/8n9fcBXRWiKESAANfC8+ED
	Lngw46pScBF2dzeB28QEAGADmneRHilg7dApO5H71Ix6CvBKjJn72NPWb+kI79SRieuHgL3mFUy
	HvfacUoP3LTgHhSVeQsqRfq9yEFjk79x6PUsMdwvQikv80bOo0qxomxY45eKJHhwqRdHg8fUk=
X-Received: by 2002:a05:600c:3495:b0:490:bf1a:ed04 with SMTP id 5b1f17b1804b1-490c258995fmr317840935e9.1.1781009017249;
        Tue, 09 Jun 2026 05:43:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm60328903f8f.12.2026.06.09.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:43:36 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:43:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Simon Horman <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "aleksander.lobakin@intel.com"
 <aleksander.lobakin@intel.com>, Ping-Ke Shih <pkshih@realtek.com>, Larry
 Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net v2] rtase: Workaround for IP fragmented UDP packet
 hardware bug
Message-ID: <20260609134334.3225b076@pumpkin>
In-Reply-To: <1340406ab190498ab857ad9017529722@realtek.com>
References: <20260604101356.15611-1-justinlai0215@realtek.com>
	<20260608190627.182292-2-horms@kernel.org>
	<1340406ab190498ab857ad9017529722@realtek.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297043-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:justinlai0215@realtek.com,m:horms@kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:richardcochran@gmail.com,m:aleksander.lobakin@intel.com,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,vger.kernel.org,gmail.com,intel.com,realtek.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,realtek.com:email,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE5C7660211

On Tue, 9 Jun 2026 08:20:10 +0000
Justin Lai <justinlai0215@realtek.com> wrote:

> Simon Horman <horms@kernel.org> wrote:
> > 
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this email has
> > considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > rtase: Workaround for IP fragmented UDP packet hardware bug
> > 
> > The hardware parser incorrectly interprets 319/320 in a short IP fragmented
> > UDP packet payload as standard PTP destination ports and treats the fragment
> > as a PTP packet for further parsing. Pad these packets so the transport data
> > reaches RTASE_MIN_PAD_LEN before transmitting to avoid triggering the
> > hardware issue.
> >   
> > > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > index ef13109c49cff..b686b84e15fe2 100644
> > > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c  
> > 
> > [ ... ]
> >   
> > > @@ -1247,6 +1248,52 @@ static u32 rtase_tx_csum(struct sk_buff *skb,  
> > const struct net_device *dev)  
> > >       return csum_cmd;
> > >  }
> > >
> > > +static bool rtase_skb_is_udp(struct sk_buff *skb) {
> > > +     int no = skb_network_offset(skb);
> > > +     struct ipv6hdr *i6h, _i6h;
> > > +     struct iphdr *ih, _ih;
> > > +
> > > +     switch (vlan_get_protocol(skb)) {
> > > +     case htons(ETH_P_IP):
> > > +             ih = skb_header_pointer(skb, no, sizeof(_ih), &_ih);
> > > +             return ih && ih->protocol == IPPROTO_UDP;
> > > +     case htons(ETH_P_IPV6):
> > > +             i6h = skb_header_pointer(skb, no, sizeof(_i6h), &_i6h);
> > > +             return i6h && i6h->nexthdr == IPPROTO_UDP;  
> > 
> > [Severity: High]
> > Does this check fail to traverse IPv6 extension headers?
> > 
> > If an IPv6 packet contains extension headers, such as an IPv6 fragment
> > (IPPROTO_FRAGMENT), the nexthdr field will contain the extension header's
> > protocol number instead of UDP.
> > 
> > Doesn't this bypass the workaround for the exact fragmented packets it is
> > intended to fix?
> >   
> Thanks for the review.
> 
> Unlike IPv4, IPv6 does not require extension header parsing for
> this workaround. The hardware only treats IPv6 packets without
> extension headers as PTP packets for further parsing.
> 
> Therefore, IPv6 packets carrying extension headers, including
> fragments, do not enter this parsing path and are not affected
> by the hardware issue addressed by this workaround.
> 
> Skipping such packets is intentional.

I thought you said that the problem only arose with packets that are
fragmented by IPv[46], in particular short final fragments.
If your hardware checks for extension headers then doesn't that mean
that you never have a problem with IPv6 packets.

-- David

...

