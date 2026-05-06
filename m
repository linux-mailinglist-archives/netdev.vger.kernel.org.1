Return-Path: <netdev+bounces-284766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIurFtgM+2mbVQMAu9opvQ
	(envelope-from <netdev+bounces-284766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:41:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C27A64D8C80
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A585630598F0
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F23EBF18;
	Wed,  6 May 2026 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDLfj1NS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67E3EAC90
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060459; cv=none; b=QIYkxE9t6TlrIqckPr0Nl2u97NA/p02dtX/3yGz0RQYs0kU4mVHAoH6KVBwLRWZolWoedEoWrb0vbc4QQfJdHVEd/N0YEnqUqBeU5J8Iy5tpHg5wvGJtUan/kv03M2y6cqX90Qa1T/2qZFounXXGxJpPj03uVkk3IZwZkJPNTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060459; c=relaxed/simple;
	bh=/ukJ5vDdOSsgLet+xcKmTpHYrOQRlHD4PS747OsECPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxMITVdIajRdXPchBe6DdP83XpNTFTVACcF9mvPrPD1f3lc7YJIikwH+EMRJ/g+OUF+qagoVS1fCH5m3T00jh6njAmfvqmxwZ1kMeJuSRcQzAmiOac6QLckC0ddi+Pe+fxW9JEx8kgMBKXrRQ2PHP1um3a3+CxXpOaETcIxRVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDLfj1NS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488d2079582so64475265e9.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778060456; x=1778665256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sQT2FfXZ9a1rTbGvEQSWacP8U0CUvSTZQ/TjI8giX0=;
        b=CDLfj1NST9JYZRVTIIvS83t/mHd7lUZYEcHGc51dN19d7HrrIT51+cbNOuLWRsMaJA
         IDl/EHIiAghbCprguQJtpTj5hDys+kFNY5ABo9VVjVKeEIZAy1BV9Mnp5gGXmvoc3S1P
         11dflymXj8QotqzOHqvksCUPiTKr2Lli5lC56D21pkY0IL2/3RORyZ0sExYXt9y+rA0j
         X+wlFKja6Oe5GwmJ8AVeITpe7u7nOzcIBVCFl5mEfsa6PvaE7jwWdMr8dhzLmoZQedrM
         Hvtf8+sHO4glpI9UQsA953yd7IrzOgWK8AuNB1bXMjdXAJcRgWoyG5l1LoYAmWnXIZK8
         oa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060456; x=1778665256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sQT2FfXZ9a1rTbGvEQSWacP8U0CUvSTZQ/TjI8giX0=;
        b=l3nf/nY2BjH3ZuPvd02CNQN7ksoRtrtixFsHY9M/lLvpu00ATCLD3LCD+a0YuZSxKn
         jUiRU/gc2iGmfVdLx6FQ9lejUJMMBxCczKcqG0Elf9mtwInFZKrhL8RIfjxefuYi9rGR
         GU1R2AdLdFXCI0EIHKCDhHV6OBOyVJHq5YIuTGC0GbPZQgiC0TucWLirEo8gbJnG+39s
         Nz9bSNjwCSTtkRyfeIhatlpoaJQx4IbKKtVUvLKRkpLLtMS8PIfB81Ps2PxDheySk58X
         +f1pEUOOPZKc7AmMUNN9Bxfhcsjad+Kkrf1n90cv4ShOO8f2Dc78f2eDRUtv2DDbBeBJ
         k/Hg==
X-Forwarded-Encrypted: i=1; AFNElJ9/Wy8sA/1cedV2Sr/j9OYRrs7e5wEISrE+MnXz6U1MyYdxkLNZ2FrjOFPBvOVhzV2OVGjtQMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2gn1Uy9GnDe1pjNtSQNO4Xwu01aFqcd3ucq9zeMh+oeF+hRA
	VnrHN+1aV3bBL6em55DEXD/Ve3TTvaJvCDqS7736WPA9ps6IxPTo1LOi
X-Gm-Gg: AeBDiesm6eAUw8fNrgoP05EeK8cWWcoXS24ahErCfzcZmkOcrZMukCxsSNUxEpS4H9T
	X5X8CUuiEcISM2aLPaIMqci7SeLn1VERkikqyf7yzVwVMFcztQKD5joxcV5S3PeCqZ53KNhtH18
	Wm+qu8IgQBD3FNDDdhjK54oknq/EIs0gxPwk7bbRySguI6Z05O9IUNk3Tipq75rR9OH+TmsklwK
	ljSjq481qzQ4w8PXsnk/oBzi0JCWevymGvZ6x+DrYWExZZMbKW+3ELJpW0hkVw4fcS8XgqKOAB+
	o7EOmK4XuS0avltHcKgEaypgwrHdFYpbVt6F3R9Mkk+96YMYH44Qlxdjna7Msm3/qTt0loGLPix
	0FTxg+ZpfLt9x+fNLx5fO7uy3/0HhxZGu25Zw7Hy2/FtcsROOsFDSjgRUMn7GkBDzYq8qp76dcY
	xXEVrGfND+JL3ZrDxosjS79IBS9ZpZuAt2JW0MeSAGmoetn6U/tRG9RcmnJboID9wY7LTURFpKF
	OpMXI/zkD9WEA==
X-Received: by 2002:a05:600c:a305:b0:48a:5970:2005 with SMTP id 5b1f17b1804b1-48e51e08362mr30882515e9.2.1778060455466;
        Wed, 06 May 2026 02:40:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530b2947sm12667845e9.4.2026.05.06.02.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:40:55 -0700 (PDT)
Date: Wed, 6 May 2026 10:40:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: KhaiWenTan <khai.wen.tan@linux.intel.com>, anthony.l.nguyen@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com,
 khai.wen.tan@intel.com
Subject: Re: [PATCH iwl-next v4 0/3] igc: add support for forcing link speed
 without autonegotiation
Message-ID: <20260506104053.7a4f5bf5@pumpkin>
In-Reply-To: <63b186e0-046d-496e-8ae4-d68cd5eb5817@linux.intel.com>
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
	<20260430154105.505739ac@pumpkin>
	<63b186e0-046d-496e-8ae4-d68cd5eb5817@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C27A64D8C80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284766-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]

On Wed, 6 May 2026 14:21:59 +0800
"Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com> wrote:

> On 30/4/2026 10:41 pm, David Laight wrote:
> > On Tue, 28 Apr 2026 14:00:06 +0800
> > KhaiWenTan <khai.wen.tan@linux.intel.com> wrote:
> >   
> >> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> >>
> >> This series adds support for forcing 10/100 Mb/s link speed via ethtool
> >> when autonegotiation is disabled on the igc driver.  
> > 
> > I'll ask 'why' ?
> > 
> > In particular forcing half/full duplex has always been a very good way
> > of 'breaking' a network connection.
> > 
> > It really is much better to restrict the advertised link modes and let
> > the autodetect/autonegotiation logic in the phy/mac do its job.
> > 
> > About the only think I can think of is to force 10M HDX when connected
> > to a remote system that supports 10M/100M HDX.
> > In that case you need to send out single link test pulses, not the
> > burst used to identify 100M HDX, or the pattern encoded on the burst
> > used by autonegotiation.
> > But you need to got back to the mid 1990s to find such systems.
> > Anything that supports FDX will do autonegotiation.
> > 
> > 	David
> >   
> 
> There's a use case requested:
> 
> Profinet Certification tool reports that forcing a link speed without
> auto-negotiation is not working.
> Forcing the link speed is a critical feature for the industrial automation
> "fast-start" use case. When there is a connection lost, the system must
> come back up as fast as possible. In PROFINET, that means to force the
> speed and rejoin the controller loops. Without supporting forcing the speed
> to 100M in Foxville, the certification tool would not be able to certify
> the availability of this feature.
> 
> I'm hoping this context is enough to justify the need?

Is auto-negotiation of the 'low' speed actually that slow?
IIRC detecting 10G and above requires a lot of signal processing.
But 10/100 and hdx/fdx just uses the ANAR register value sent in the
link test pulses.
(IIRC 1G uses the ANAR pattern, but requires extra signal processing as well.
The higher speeds didn't exist when I was writing ethernet drivers.)

I've been on the 'wrong end' of hdx/fdx mismatches - you really don't
want to let people get there, it is terribly confusing.

There actually ought to be a way of setting the auto-negotiation
registers to 100M (HDX and/or FDX) and then transmitting as (say) 100M HDX
even before negotiation completes.
Then correcting hdx/fdx based on the received ANAR register.
Or, at least, sending out an ANAR that only contains what you are using.

The problem I always had was that the actual operating mode of the phy
wasn't in one of the standard registers.
So if you connected to a system that didn't do auto-negotiation the
phy would be using (say) 10M HDX, but the received ANAR register would
still contain a value from an earlier connection.
If the driver read that register from the phy it used the wrong duplex mode.
(The speed for 10/100 doesn't matter, the phy clocks the interface to the
mac at the right speed and the mac doesn't care.)

	David






