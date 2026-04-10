Return-Path: <netdev+bounces-277431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP2JERED2WnolAgAu9opvQ
	(envelope-from <netdev+bounces-277431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:02:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ECE3D86D4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2BEB301963C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7C63CB2F9;
	Fri, 10 Apr 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="cXab2JmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vvUjt/HO"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39C3C342A
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829770; cv=none; b=KKg+YsFlNROIpQ/W8PsMMXUcw5EBuaAXNEjgOud79WjQUKwISYXHgN3HYmjEFehXQOnINLF8IadGsRXFgXFsMmQQQQ+cttenM9Lc4xA+CvayS5GkAjStUzp8+D+VNg+k8g40FXJhIlkXtLx47gBGLLaYhF5rJibgALaH++0D6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829770; c=relaxed/simple;
	bh=99gQyMa3LDK6miH/RN2QAfHt1ie0xJrrE3WOMbDNc4Q=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=C/peFKb3hBSx9u3PW1raZT99cCNvKSMjv8nIYfNbJNWkb559NRbyZtOW/1AavgkB3Y2aw108KGX/h7Mg5uINx7Fgt/K2b1Sfm3hND04cG4ECbXBDHgSA5f9XGdtgykm8iRUfyCUNrofzLgOxKhYG6JmkINlK1s03lnhXqYYHCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=cXab2JmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vvUjt/HO; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 204A214000E7;
	Fri, 10 Apr 2026 10:02:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 10 Apr 2026 10:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775829767; x=
	1775916167; bh=41hTlY1bb6hiT6dHkJ8HJeeKF8w1/NktbnCMzFZwWbQ=; b=c
	Xab2JmVaT/EfT2ZFyByHWu/ct4mbHp4mutpaM+kOEicZQ59fXT01yOh/MuFbmEID
	LdfXyPZRMUNFCU4+H4ixwm6QVOAFQAIl4zi5KMWrtGFKzC1xT+LE+2UMAjzDYM/v
	Yp1Y4Y5u2sTQRntOE+wHvaN3h/GWmpi/KMUNUAsBjtp0LirBx5HPNamteDvFYjor
	MxpiLOr3EevdQ44ywe/LFcMQCONtRMQzABIj3NvFhgFByap2wXvto2L3R41LtRru
	nATUHJ7u2MqJEXNnxLncS7FK3J+louZREcLFVl3zZmLz651sOyUis1mzSy+//rQH
	E81sNaifkkYjZZKhmED9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775829767; x=1775916167; bh=4
	1hTlY1bb6hiT6dHkJ8HJeeKF8w1/NktbnCMzFZwWbQ=; b=vvUjt/HOdgVNt2aIy
	0DIBXRnMnLqT0a57G93uyxapGcke9GnLD/+7umdpZbCMcSystCoiAd5+n0eBjfmK
	9Je7wSYtqo6GYBnInKTT67B2kKdiMK28mbRYtNN5ljkUZtgaxNDL9AopNHGrL6lG
	NIt870LMAoWzb8ru0VKziEErXcKBTj6To6I0EfsNtCcSy7+g87PgwNpBXDoBvsn1
	oaGKesSfg8VkmQGhnKwWKB1X259Q7IB12zySLcvxsiPzcDyy6gWv19NnHWJDTJJ2
	FfIHQAE3LTFkIap9QRs56O1xBiotV2dnX0PUzxPkQ5XzQKVgUx4UlZ4Ylju9jr5n
	WwUwg==
X-ME-Sender: <xms:BgPZaVXwQOvS4noXKcOsTRzbEhEV-fwHVVrVzf12-KsKg0JWTnFwTQ>
    <xme:BgPZadzCYInx3L094G2LCRmEqcsSE8yy-brXVAJqo1GQWrpMFObygy59BMv49Iznd
    NbXOoFsfxnup-Agtcf2gx7SBqBZM7eCYuM0GC71O8nt4Np9Qa4_XZs>
X-ME-Received: <xmr:BgPZac9hj2HptkHoSRtmfK-d1SHmZKbJRBQWTrgM-tPTdQqJdjsqkwjl48hnlPMKczwUjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtfffksehttdertdertddvnecuhfhrohhmpeflrgihucggohhs
    sghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epjedvgffhteevvddufedvjeegleetveekveegtdfhudekveeijeeuheekgeffjedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvh
    hoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhouhhishdrshgtrghlsggvrhhtseeifihinhgurdgtohhmpd
    hrtghpthhtohepjhhonhgrshdrghhorhhskhhisehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmrghhvghshh
    gssehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhguhiesghhrvgihhhhouhhsvgdr
    nhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehfsghlsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:BgPZaS8lOWuwxvXgQYEkGjPDgz6GTm4bS6zGe7zPim3zIHMx6F316Q>
    <xmx:BgPZabVSX_-XXitmxMj8hIlVsDRdQufLIavwEl4o_Xh5SSAC0j3HUg>
    <xmx:BgPZafenpYvGho-kMK-ROWMHinxDxhixEvqRE8Hgv2RQIFxcwoFGKg>
    <xmx:BgPZaUaJ7yNAsnuUHil3TbD5C431qROHMbMqQRWBXui9BC79Ovth_A>
    <xmx:BwPZaZ_Yb259EApXWH-G3reJWV5ed3UcWL8esesmsiINwmHVDXJkZrVn>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 10:02:46 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 08C6D9FD33; Fri, 10 Apr 2026 07:02:45 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 053519FC41;
	Fri, 10 Apr 2026 07:02:45 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jakub Kicinski <kuba@kernel.org>
cc: Louis Scalbert <louis.scalbert@6wind.com>,
    Jonas Gorski <jonas.gorski@gmail.com>, netdev@vger.kernel.org,
    andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
    fbl@redhat.com, andy@greyhouse.net, shemminger@vyatta.com,
    maheshb@google.com
Subject: Re: [PATCH net v3 0/5] bonding: 3ad: fix carrier state with no valid
 slaves
In-reply-to: <20260409193813.249061e4@kernel.org>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
 <20260408201341.68f31247@kernel.org>
 <6631e1e7-8728-46a4-9999-ea9910a1abfb@gmail.com>
 <CAJ5u_OdU_okwjuEdm5zUBibW0PJsTng5ooZtXRX=wjhHpANdoQ@mail.gmail.com>
 <20260409193813.249061e4@kernel.org>
Comments: In-reply-to Jakub Kicinski <kuba@kernel.org>
   message dated "Thu, 09 Apr 2026 19:38:13 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <568328.1775829764.1@famine>
Date: Fri, 10 Apr 2026 07:02:44 -0700
Message-ID: <568329.1775829764@famine>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[6wind.com,gmail.com,vger.kernel.org,lunn.ch,google.com,redhat.com,greyhouse.net,vyatta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277431-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 06ECE3D86D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski <kuba@kernel.org> wrote:

>On Thu, 9 Apr 2026 13:49:06 +0200 Louis Scalbert wrote:
>> > Signalling link up too early can cause issues for some protocols that
>> > may change behavior in the absence of PDUs from a link partner.  
>> 
>> I agree with your point. I have observed issues with
>> keepalived VRRP when it is configured on top of a bonding interface.
>> 
>> When the bond reports carrier as up while no slave is actually able to
>> receive traffic (due to the partner not being ready, as indicated by the
>> absence of LACP negotiation), the VRRP process interprets the interface
>> as operational. At the same time, the absence of received VRRP
>> advertisements is interpreted as if it were the only router on the
>> segment. As a result, it transitions to the MASTER state.
>> 
>> In reality, another VRRP router may already be MASTER and actively
>> sending advertisements, but those packets are not received due to the
>> bonding state. This leads to a split-brain condition with multiple
>> masters on the network.
>> 
>> Such a situation breaks the assumptions of
>> VRRP, where a single MASTER is expected to handle traffic,
>> and can result in traffic inconsistency or loss when upper-layer
>> processes rely on this behavior.
>
>It's been like this for what, 15 years?
>We have to draw the line between fix and improvement somewhere.
>In Linux we generally draw the line at regressions+crashes/security
>bugs. If a use case never worked correctly it's not getting fixed.
>It's getting enabled.
>
>That said, if Jay wants it as a fix I'm not going to argue.

	My apologies for not responding sooner, I was under the weather
for a few days and am just now catching up.

	My general position is that, first, the current bonding behavior
is compliant to the standard, which gives latitude in how individual
ports (those not partnered with a LACP peer) are managed.  The stated
Cisco, et al, behavior of denying use of such ports is also compliant.
One thing we cannot do is run such ports together as a logical link
aggregation, for both standards compliance reasons and well as the
practical issues of creating topology loops or duplicate frames.

	Second, the minutiae of the standard is not the real issue at
hand, which is that bonding's behavior of enabling an un-partnered port
and setting the bond to carrier up based on carrier state does cause
communications issues with peers that behave differently and deny use of
un-partnered ports.

	As such, in principle I'm not opposed to an option that would
essentially tell bonding to only use LACP-partnered ports for the active
aggregator.  I'll have some time over the weekend to review the patch
set in detail and respond to the specifics.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

