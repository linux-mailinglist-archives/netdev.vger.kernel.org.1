Return-Path: <netdev+bounces-285339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBjpMnOZ/Gk6RwAAu9opvQ
	(envelope-from <netdev+bounces-285339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:53:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 408D04E9AA1
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D6BC307B646
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C73B8BD4;
	Thu,  7 May 2026 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTk91Nnn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAD3ECBD1
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161708; cv=none; b=GFb0tCbxNk56p7XUAe+KfU4DbBe20jJlMpcKmNRE3kHPFHKdl1e1Gj56lYB2bx81zBj4WstfiYlZxq0KQz8zN3QryedL9DOjfo5KLjZ0slqitudwDmbcwnQkvehY5SwG7oCNP5KL5UAj8HxS4/RuJW5zGm8kg+u8mSXRP3Vzsy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161708; c=relaxed/simple;
	bh=6FCpXzCgtsfJ36cDnFBKkSwFAtcNCjtbMR1qFUr9W8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc21T0Pqb+S/laR5Y6bneFNJjYVB55dQTMyuac2XSpvfdvTHqn9VGSoawaSQm9tPC5IdodZ7/QTeR5Z0GyKQxRyvuqzsnNWs+wGPVMoDEAuOU9AKND6Ape1hs6lmhTjOx4M8wjz+iFXZ6FTRZsJwUfqgtOGOz8O1gasJmuN4mfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTk91Nnn; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ee7ffd738dso223428285a.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161706; x=1778766506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXL04VQFG198TFjRMjSGYT+UyBqd1kYAypcPiKoL5QI=;
        b=nTk91NnnxrcM3VfyWZAywNQiRRa9jaHv+Uv3VxSzwaw9j1yxqnsQ1VyKVXYDpXG3bL
         NLx9uFd6mOnQyGZaRs9EXYMVrRdW+2vCPu0pEWvDEztw4vhCqdBsOuIthobOXdc175j5
         yabv8at0emneg2SVUqBNTvhsNOuIXbOjVQQzFD/QWMtYAXN83WnebeJHuM5JlWt3IQdj
         gvr6gvZ9gx6IApaOZXJxW7R//YsMgvlFab08G7cAeeoaz8qaiV5kXchetjm2yfpGUwZQ
         5+GZLEFnFvMjFlrWoL9VWNkKz3TmBUuKGXU1AZFuZPh4Cl/Mlw4zFDtkc16DpIKCCfWQ
         4S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161706; x=1778766506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXL04VQFG198TFjRMjSGYT+UyBqd1kYAypcPiKoL5QI=;
        b=s9WPMm6moJfUaaERaZz4F7nfVIKuDUMb5ERYX1uumDXbpYF6u3oQbUTFhtDU3/aiqB
         zAn6GFN+zTu3T2IfiIbBXCf6YNZrLQA1kA6K1pfMJVZNetG88/lRdzo1mnBAiBnuYPsC
         YQfIiSQE4kTyVI7iIFX5Zz/72T1Uy6DnTK63D00uH+ssKHZQeRE7u4dJsrFU4AHAkLKL
         2rOwojE1r9S51apkfAcULx/oT29O+eCMoFu2mWSPpHYsQOXNuiZHlB2usRB17NE6Pou3
         OZbdCXl83S/Ov9ZhrxRCYTsBX6bPu0rUxYXedxL0DxG3/V8T40q2yh/DEBws5cjeb1hP
         r/Nw==
X-Forwarded-Encrypted: i=1; AFNElJ8Dghtouf2iR8KBUOoG3rdR8GPWXgK4LN8L+oAldRSAmjjn0Tiy25H8Gltils+Hdz/aM7/bHfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7LMW4v1cThzlvjWf7hgNqsjQOg/Ld5MIMgOrfKemzRqyBezWy
	7Wbosjf+DHHbF15h+/DbbzJbqOIxgxKAfNrpkDNm/7ZlgBdyBeaESui0
X-Gm-Gg: AeBDieuvfGR/+uuGtZQQUNtKyj91HTQVjn9WrHx0N3l1qJKENrstWrPtRuWS2tCY+pA
	u/EtUndZ4gFnpvMqzW6sCJpqNBn4rVl72DO3kIJuFg7lDaz0EnhA7rlISyyYgStq3GhufpouR9n
	FukgF90io3wvamN9bGYLG4oJDIt0K0PH6Qd8A/TMlCOpaGoNc6Egut98JB0B2IMqTCAGZJrHNtC
	kn2VdmX8/cNibEKFFscW1x+VdahntE6Ctr1dqKV5U/0CbtknoSJzhzs+Kx9s6Fx9xHIX5mxlVcp
	nsLzFF6nxsx2kn03xte/+nMLZOxgbEtk6V6V75YwO9esVWO3SLhKfUkl7viDJrnBBcfTtTn88XM
	HOVyBm3Rbcx9thOaWIBtp5LItY/cn81MrwJ2kMXVjhbeU89tLaTEdcOFhjoejCN5uMTjLsAr7yr
	F1Sa5oT73AH8zW+aQsFwfcXrpGOL2IS4dSjFFLS2nhI35AN/IE8xxFMc0HCFgDF/wYzlk=
X-Received: by 2002:a05:620a:2905:b0:8cd:b024:114d with SMTP id af79cd13be357-9065324a116mr357701785a.40.1778161706134;
        Thu, 07 May 2026 06:48:26 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a8161csm1890105985a.13.2026.05.07.06.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:48:25 -0700 (PDT)
Date: Thu, 7 May 2026 09:48:23 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Simon Horman <horms@kernel.org>, Lee Trager <lee@trager.us>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: eth: fbnic: Fix addr validation in
 pcs write
Message-ID: <afyYJ9-qW_QG6f7_@PF5YBGDS.localdomain>
References: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
 <20260504135815.44226-2-mike.marciniszyn@gmail.com>
 <20260506185819.1c68a71b@kernel.org>
 <1cd8256c-286a-4a73-b0a0-89233cb3c2d0@redhat.com>
 <afyRrWW8XVeO55Ob@PF5YBGDS.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afyRrWW8XVeO55Ob@PF5YBGDS.localdomain>
X-Rspamd-Queue-Id: 408D04E9AA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285339-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,fb.com,meta.com,lunn.ch,davemloft.net,google.com,gmail.com,armlinux.org.uk,intel.com,trager.us,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PF5YBGDS.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 09:20:45AM -0400, Mike Marciniszyn wrote:
> On Thu, May 07, 2026 at 09:20:53AM +0200, Paolo Abeni wrote:
> > On 5/7/26 3:58 AM, Jakub Kicinski wrote:
> > > On Mon,  4 May 2026 09:58:12 -0400 mike.marciniszyn@gmail.com wrote:
> > >> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> > >>
> > >> The DW IP has two distinct PCS address ranges cooresponding
> > >> to the C45 PCS registers.
> > >>
> > >> The shim translates the PCS addr/regno into specific CSR writes
> > >> into one of those two zero-relative.
> > >>
> > >> This patch fixes a one off in the test that could allow an invalid
> > >> CSR write if an addr == 2 was called.
> > >>
> > >> This patch contains a fix for addr validation in fbnic_mdio_write_pcs()
> > >> to only return actual CSR reads for addr 0 and 1.
> > >>
> > >> There are as of yet, no real impact for the bug as no PCS writes are
> > >> not yet present.
> > >
> > > Hi Paolo! Was there a reason / do you recall why this was not applied?
> > > (I dropped it from patchwork now. If the omission was accidental it has
> > > to be reposted)
> >
> > Darn, limited capacity here plus re-submission glitch: v3 had a slightly
> > different cover title (due to typo) WRT v2 so PW did not mark v2 as
> > superseded. I process patches via PW in sequence, when I reached v2 I
> > considered the sashiko comment not blocking and I apply it. I was unable
> > to reach v3 until now.
> >
> > TL;DR: @Mike: please re-submit 1/4 and double check there are not other
> > differences between v2 and v3 - otherwise more patches needed. Also
> > please ensure you keep the series title consistent among revision, or at
> > least manually remove old revisions from PW upon resubmission.
> >
> > Thanks,
> >
> > Paolo
> >
>
> I double checked v2 -> v3 for the other patches are ok.
>
> I'm just now resending 1/4 of the series.  I reworded the commit message
> to fix the AI review comment.
>
> Mike

The patch isn't showing up on either lore or patchwork.

I may need to bump the rev?

Mike

