Return-Path: <netdev+bounces-299913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3o/vJe55MWpUkQUAu9opvQ
	(envelope-from <netdev+bounces-299913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:29:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0529E692211
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:29:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=h7pUsB6s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299913-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299913-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB64F31EBA0E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4F646AEFE;
	Tue, 16 Jun 2026 16:16:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED337DEBF
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:16:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626591; cv=none; b=CBDpAe2S1D1/SQsDXRhIUaVIORwuX1cLDTtU2u/ZbSxUokFe0bhoPZY18ABDvI0bT926IpViER6XN5p7qf7FUOrwr2kQo00VGwPpQASTIbhbjs3K1DpLmNWyX34FRVsF8yBdRcsNbpx4Xqp6ngzZXKd40hkcV7Xic51kYfSF0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626591; c=relaxed/simple;
	bh=ucrLXHTtP6pRHhma6/r53bX48kitE1CcLVLhFHsdIuQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDZ4NHadhlZZr0DJR1wPn4ep+sFEP7ZpyXH9M+tIf2H684kE92jQW1bw12eGreQVR+8R9v1WInxpVupzMCd2JVYBRYGTHTHlZ+qG3ss1MIkGM497L7G6X7SRdnhdngdvndRxKdFWTLwHpLGPoNNEPgC5rpTaGcjgShWRtSuo3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7pUsB6s; arc=none smtp.client-ip=74.125.82.181
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so397156eec.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781626590; x=1782231390; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ucrLXHTtP6pRHhma6/r53bX48kitE1CcLVLhFHsdIuQ=;
        b=h7pUsB6sPhK9L782bFlXNrNnyoMgnqstbqY+2zoCllb2Ha6V+5kCFSnEXEKJV1ovUy
         xJnuk8rHIH3zgKwU26Ky4cwhCJpghnzywrT+JkHFunIBl7E5ZThYU9KPRtpYz5jQKD9A
         moBNJFoEWlkbBjrkHahoJ7ysro+y5LbGfpTeEay9Wj6jXmCTqow7GmZMdoAmCprQVVWc
         mBo926imx8AgddShr07eGEGjdZxFXRfRPkk+kfulMwKEy10PnDHruYz7Z838gVgHEo4W
         og1rxJr65ngs2VcZyk+dQ+ygUB/VIW7KgDEr+D3ZWcfJhxb/vxCSqft9OGI4Vh2wEOV8
         awpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626590; x=1782231390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucrLXHTtP6pRHhma6/r53bX48kitE1CcLVLhFHsdIuQ=;
        b=H4GfsSyTRAadMIE3MIcHty0fDo9KBGwyZO7Wzbe2VfHV7j3x/+hXNEanogfhsMzt6L
         XKqd5ijs+YewRh1imCGCI0gl1Ss/zlyD+OTHIQpkd/yKVg7NgPW4C2rFIAUhzZ2qRB+9
         R7QC6X+03Nv04o5qAvrVyh5SI9AIC0ooGzcYmOsWqsMx6Tqx21Zudj1vHgDml9VgVIwr
         9D00uj0/jgBByOZFM9AErxoyUwvgN3pw+TrIQViEUbHKNLUeQLJbJtoGoVC9J7gIKyGc
         fdDHE9TbumR3Q3H2xtvXuq1AXIw7GDejk7k5j7newEO2//2AE8fW9yQnSqiERk1zdbmf
         oFnw==
X-Gm-Message-State: AOJu0YwdZJUWYabaRKL1sNYtRq/cfqpXNS6RT7O3k2gTHesBG4INI95B
	2S4k/aTncCp9mrZJmCN+OhQ7WTk2qihVpEZstmetdBff2xaX0Kw48YSC
X-Gm-Gg: Acq92OHqYbzCSgG7m+ZEVMALEPmIt4Ofyfq0s//AZfOg8xm+GEE/S/cY9cJ9yG9J/cZ
	SkHdtXnoetjT4rIhiLaUVin8m/d0uuTBWgXZwzpXh4vaaGJQtJZ5qn/7apqj6IOcf4+ehcFluZE
	Utym0R2YSQhEXSuXOMMeXzoKuriVP/1PW5bWCan241wXSjpT0GA5epE0BLGdrq6LYlwBqHpSszN
	cLFP4w8hX3+HqMqoOGc3VwGNxWxlBBPXTp8F5TCxpBnTqGGtFIz1G1bgVjWRs6d20zIg9TZCwi/
	7LnUhLZQfZuNzU6F39zXsuDbnodOe5hL89RV7SbLlHFnEfVNY8U612AzwZdirvMXsHL1Gag5J/G
	E7wlZ1hgKVK9iqDOXJsjqoMlPIxEBB94DGZEpm6Ui/zE+blFC7X9QRJ2XPMVpiLSa2LER96hzsk
	cwUhT//+eblYuJcii7+oOBH1BnEhFuoeW0I2G1IwZRtRmowlZaSDVO+SemoYIyfatPM6IF/smNn
	08iRpT0z7X2j1L9kLlPEY4=
X-Received: by 2002:a05:693c:69d2:b0:30a:e531:3141 with SMTP id 5a478bee46e88-30ae5313542mr6036116eec.17.1781626589499;
        Tue, 16 Jun 2026 09:16:29 -0700 (PDT)
Received: from [192.168.0.128] ([98.97.36.235])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm23977823eec.28.2026.06.16.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:16:27 -0700 (PDT)
Message-ID: <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
Subject: Re: Ethtool : PRBS feature
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: "Das, Shubham" <shubham.das@intel.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	 <mkubecek@suse.cz>, "D H, Siddaraju" <siddaraju.dh@intel.com>, 
 "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>
Date: Tue, 16 Jun 2026 09:14:55 -0700
In-Reply-To: <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
References: 
	<SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
	 <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
	 <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:shubham.das@intel.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexanderduyck@gmail.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299913-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexanderduyck@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0529E692211

On Tue, 2026-06-16 at 12:14 +0000, Das, Shubham wrote:
> Hi Andrew,
>=20
> Thanks for the feedback.
>=20
> Yes, for multi-lane ports we can accept the lane number as an argument li=
ke:
>=20
> ethtool --phy-test eth1 lane 0 tx-prbs prbs7
> ethtool --phy-test eth2 lane 0 rx-prbs prbs7
>=20
> We referred to "Lee Trager's" "Open-Source Tooling for PHY Management and=
 Testing" session:
> https://netdevconf.info/0x19/sessions/talk/open-source-tooling-for-phy-ma=
nagement-and-testing.html?.
> We have been trying to reach "Lee Trager" to seek more input, latest upda=
te on the approach and understand if there is a parallel effort in active s=
o we can collaborate.
> If you can, please help me connect with "Lee Trager" and others who expre=
ssed interest in Ethernet PRBS. We are happy to align and start implementat=
ion.
>=20

You aren't going to have much luck if you are trying to reach out via
his Meta address as he has moved onto Nvidia so he is no longer working
on the fbnic driver.

As far as the work done most of it was internal and making use of
debugfs. I don't believe any of the work for fbnic began to approach
the suggested methods for upstreamming the feature as Lee had been
pulled into other efforts.

> About standardizing across other bus like PCIe and USB, I had a quick dis=
cussion with our internal designers, but I didn't observe any such SW-level=
 config knobs interest.=20
> Looks like Ethernet has clear interest and we are joining that Ethernet P=
RBS community too.

I think it largely depends on what your implementation looks like. The
point being made was that many of the SerDes PHYs out there are capable
of use in multiple applications. So instead of being a networking
device you would be looking at a SerDes PHY such as those in
"/drivers/phy/".

Also do you know what layer in the PHY you are injecting this PRBS at?
I would be curious if this is PCS or at the PMD level?

If you are referring to the PCS level then yes, it would make sense to
have it in the networking subsystem as the PCS at this point is more a
netdev specific set of drivers, see "/drivers/net/pcs/".

In the case of the PMD that is where things get a bit more interesting.
There is an IEEE c45 register definition that includes PRBS testing
registers, however in the case of our implementation the PMD doesn't
follow that specification and follows more the "/drivers/phy/" model.

> Ethernet PRBS configuration and diagnostics support is well established a=
nd already widely used in existing Ethernet SERDES deployments.
> We think Ethernet is the most natural starting point within netdev, as it=
 aligns with current driver practice and existing validation workflows.=C2=
=A0

The problem is many of these parts used as an Ethernet Serdes PMD are
really a multiuse part. So for example in the case of the hardware in
FBNIC we use the same part on the Ethernet PHY as we do for the PCIe
Gen5 PHY.

The complication in our case is that both are buried behind our FW due
to the fact that both are shared between slices. However for testing
purposes and such we could look at disabling the odd slices to
essentially unshare the hardware if you need another platform to test
something like this with.

