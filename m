Return-Path: <netdev+bounces-306364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DCmXMwUBUGrrrgIAu9opvQ
	(envelope-from <netdev+bounces-306364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:13:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FAF735472
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:13:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aWzQcwzM;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306364-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306364-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF13300D94F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3A13C1F47;
	Thu,  9 Jul 2026 20:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732072744F
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:13:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628034; cv=pass; b=BWdKXpMSasYnElVOR1GXER/QonTsqYWO0O6iSKsFaOQ3TMrKsARDvKEt7igUo0aoAfSeTiXWAp6e6q7jdoHzQD2aPjb2Qp+w3oN+SBOqjvtaUFPdR2z5Rxim/XxLThVzg1d3lSYSd0ZMB05/1zIB2V/Ev3pOUUCP4+UNa3hxBOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628034; c=relaxed/simple;
	bh=6iTx+2OhEZxEm/nEmZXKPtfkGBAYSdZ6m6tQMnwow5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVyKEPJvblwNTt+qtZTkp77hyPoAUC16kLe0rgFAmZff/nDOahPFzce2rMeMm3dn4jibfxh3gco2WQ0tRlcqy/RDykJ6TUKbPy/Dv2N5weD1/UFgcZqwnMHl7N5n++T0fCl02yoQnrEeX9YQi8RJCeYlGmXa4izOSGN3RyFky/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWzQcwzM; arc=pass smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so178506f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783628032; cv=none;
        d=google.com; s=arc-20260327;
        b=hGmFMlyMr1GpsOueMi74e29o/q+HUKEkKSlzK+E1nUUMJ2s6twIHT3CQOJxjlyoTGY
         j1JEfINgrKQhS7EC01bCyJsmx6bd0OHCU+iqMWe5hBhn+Vn0EW0pC9N30XXIJYw6Liy6
         gkpdao9fKaPeca26FWWjqyv8YDnLbHooPa5bpMfRQc2POhL1hId9q/HXtBD3OpqlOpq8
         IRfJO5gK/o0uiC/HIb+BjzvNN2rgg5Wto31FhJ3EZLhSAKO21P3bpeAYelhc6b5rv7mz
         1ppc/FhEMeDNIbWdBMnxnTSyN/cVRIvpLd98EKaLPTvl5gM4Q4IawP6QnFUic+SQsuFG
         RcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6iTx+2OhEZxEm/nEmZXKPtfkGBAYSdZ6m6tQMnwow5A=;
        fh=a/bVTH9IGX4cvPGAp42AKU7NnwwYCBhafZGNFajWTnk=;
        b=TouPW7bba6URiXDFjQcVWaYHXUK8MKD1tjF0qaAA0gwcst7VkTF6J1LL+5cnG0Vlw1
         nIMs5jThzx998D/sRdTd3MUWtOC85kQfZaGleMRjG/iUj0skhiFpTrLXdmyVoNEFl4ZE
         bQSQZ4LcxGPDE67yPHHNMixzP8d7HWx7aYideg/b1Qpyd4LiTb8UkakymZX2u1ZKOerm
         jLFDoU8lsLm+wyvWMVCD1SrzOiXHxToogq0ITGZ9DaFW9aWDJuRsYOoU9JRMLNGE7BDJ
         NmMixmWlQU2Dn8lVHNUucnFRX+dgIIoPZXPnMr5gAWeMqrkT+og91Ac6TiEmxxL/mzJS
         0k0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783628032; x=1784232832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iTx+2OhEZxEm/nEmZXKPtfkGBAYSdZ6m6tQMnwow5A=;
        b=aWzQcwzMD1fpfzbOWKzPd7bZQFk+njC4cPi7rzzHLIIU2FRf9aNT4HBYdMhJomRr2b
         rkYEgxscvcuU11BeA3NNBrHAu6Da5UMVOjjz6W+KZ0IcOKrHImwJuYNaSSoBNayJE6oW
         vQDdqq/MAjJ+3osw0TzkxU3TZhP1g/CdHq6MxunGHvsoTwiCvochvHLZ2qY+hH1zABgg
         dgQqf+Rc2gU7352j/+snRO203Q4VAeQRbICcQae1P/tJxToZWyGHCchH8s4Vqf7qJJ/a
         ewxxRiuU1/IT3PTMchRZF/Vxj7GsRql3+PoaPvFtsZvFXRWICLTTENoSO2QHZxAvVFE/
         Nm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783628032; x=1784232832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iTx+2OhEZxEm/nEmZXKPtfkGBAYSdZ6m6tQMnwow5A=;
        b=JtqbRyltN1hXK2eJDOGxDaXNvwIJMQjbdUf76n4JJF8zmdMjLdZU3fvrAe3u1/Wkgu
         4IjLwSuWB27rkI8BYbjokgZOJsS1qyhZA+WR8tH7BZG/VnjflAo/rIVX+qk2Pw905E74
         dzh7uFVW8rGzEVd+mtiwaBa/1VXFJBSyTrlgvGMxhgqOa+I8ygVjmSeZxc8vXxit3zoQ
         P5fcTShP/C3WJ5qI1EghQTpGEoQxFYFACwUDAex+L0lesHK7/JoqiAat3LtqL7YFdps9
         WlYtv26MfekQfHYaNDc5u91pOog+Tifj/LAMrtfboPsZjZSUuQDLaz84uWUQFW5Vzrwf
         DHPw==
X-Forwarded-Encrypted: i=1; AHgh+RpWQr/mPkoZ1iKpRz7GbYhDeCCNb0l+BpktjSg8MaJIUW8Ou4sfv5KXMI3cVZP4mHfZDKY5hIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGGvDc6dB5A/QKaU+ubM6KykUQNPKLTFPtjHLNRsoCyhis+TLG
	iAMtt4ccsPLr6YO76mjwAu1dRSfm1sHyCz2phLiwOC01L2C/wYVlAlzAXFEYzW+M+RnZGjruoux
	VbxXOM1WMBjVtqB0sKTsfaUuvJ8che14=
X-Gm-Gg: AfdE7cnadzNwN5pmLnvCKtXggyYiKnzmGINaApBMVWr0eLKqoWk35QGTkZxeKM6H6+i
	BtYuijDtN9NW2DJ53Ns331kgmRwJFs+JGMLz7kCiwSo6ez4Hu5OVfrj2amU3khdugrRlDl5MBMq
	PmapPz59wzbq/O7tVn7gilmnIteE6Wb1bKL7XSvkrMdseiMsfdEffBEzLoH1vF+OzrE9Fu6ZyBL
	b0eTgNKrE+B2zJ8joZ1tObBPH2MYpJ9LZLgvebfcUlvR7Gaq/gQ6VcOc//cZv5AeHELz6px5gHF
	p0aKYRRnqbuFp9yDNrWUBLEZGaiazkuDX0MK779/VA7FVP/a3tmRPV/b
X-Received: by 2002:a05:6000:4705:b0:47d:e3b3:ff6d with SMTP id
 ffacd0b85a97d-47df07b4a15mr9587472f8f.57.1783628031569; Thu, 09 Jul 2026
 13:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch> <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
 <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch> <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch> <705f6fcb-e0e2-4898-bf83-78c38f32f505@trager.us>
 <BL3PR11MB6385468A86BACA1D8EFEF2BE88F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <SN7PR11MB8109F7A3F491E20701BDC0DFFFF02@SN7PR11MB8109.namprd11.prod.outlook.com>
 <46f714b7-ec6e-4b26-9ff8-b7f27f11fe33@trager.us> <4ccc869f-a724-41fc-9bfc-da5332f54790@lunn.ch>
In-Reply-To: <4ccc869f-a724-41fc-9bfc-da5332f54790@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 9 Jul 2026 13:13:14 -0700
X-Gm-Features: AUfX_mzF0OOGDtV91XS9vL13PXgBX6mAO15lzAx7X_n5iyPUFUxuE5_6Ne-WUIw
Message-ID: <CAKgT0Ue-wMYab25gPzE8iarW2abYONv=5ZBokrLS6-DfD4WFpA@mail.gmail.com>
Subject: Re: Ethtool : PRBS feature
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Trager <lee@trager.us>, "Das, Shubham" <shubham.das@intel.com>, 
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz" <mkubecek@suse.cz>, 
	"D H, Siddaraju" <siddaraju.dh@intel.com>, 
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>, 
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>, 
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:lee@trager.us,m:shubham.das@intel.com,m:vijay.srinivasan@intel.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[alexanderduyck@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306364-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexanderduyck@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21FAF735472

On Thu, Jul 9, 2026 at 7:37=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jul 08, 2026 at 05:58:52PM -0700, Lee Trager wrote:
> > On 7/7/26 2:06 AM, Das, Shubham wrote:
> >
> > > Thanks Andrew, Lee for the feedback.
> > >
> > > Lee,
> > > I don't see prbs11.0, prbs11.1, prbs11.2, prbs11.3, prbs13.0, prbs13.=
1, prbs13.2, prbs13.3, prbs16 and prbs32 in IEEE 802.3 2022 standard.
> > > Is this specific to fnic based on base PRBS pattern or it is mentione=
d in some other standard ?
> > Those were from the fbnic spec, I'm not sure where they originate from.=
 I
> > suppose we can drop those for now but its good to keep in mind more tes=
ts
> > may be added in the future.
>
> Can you find out what they actually do. It might be something as silly
> as, the .1 indicate it only runs on lane 1? So these are in fact
> standard prbs11 and being able to specify the lane via another
> attribute is sufficient?

Looks like they are different derivations of the polynomial for the
given pattern. For example PRBS11 is 1 + x^9 + x^11, but PRBS11_0 is 1
+ x^5 + x^6 + X^10 + x^11. That is one thing to think about. When we
say PRBS7 the assumption is we are all talking about 1 + x^6 + x^7 for
the polynomial. We may want to have that clearly recorded somewhere so
there isn't any confusion on which polynomials we are using for this
testing as there is always a risk that somebody is playing with
bleeding edge hardware and ends up defining a PRBS polynomial
differently than what is expected. I almost wonder if we couldn't
define the sequence as a bitmap instead of an enum with each bit
representing which fields are in the sequence.

The 13_X values seem to be used to generate QPRBS13. I would assume
the 11_X values are something similar. Odds are they aren't in the
standard. The comphy we use supports both PCIe and SATA use cases as
well as Ethernet so it has support for additional testing that may not
be referred to in the standard. In the case of QPRBS13 it looks like
it was rejected as a testing sequence for 400G so it may not be
something that we have to concern ourselves with, at least when it
comes to testing Ethernet PHYs.

