Return-Path: <netdev+bounces-303398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rlnnKkpLRGqqsAoAu9opvQ
	(envelope-from <netdev+bounces-303398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:03:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 092CE6E890E
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:03:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jvosburgh.net header.s=fm3 header.b="f yKJdU8";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=fB3CzQhw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303398-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303398-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=jvosburgh.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF5F63031130
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A0D31E823;
	Tue, 30 Jun 2026 22:59:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF732FA1B;
	Tue, 30 Jun 2026 22:59:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860345; cv=none; b=Lb7l//Np1+fGln9DjIXfiyO+dFxdAKZcrInCeobKlj2bbihPzDLlfAq2d5ORFd/LF5iSe+yq+Szip0SWqGjtMcJntBL3LuTsa2k+Zt6d4Im6OYfuHO2gce/230lvfl+1QuwX0pNL1cZ3Lk8KO226ZCmefMFiYjjqvRmiQs01+K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860345; c=relaxed/simple;
	bh=HkHf36jpWBSbPhOI9+BlVy0yj3oNXJ2ScHBlT4g2Ykw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=KjjXfAo3eI+r0QvOYiNX4iVH1ImSB9Ru6xYNh8IMYvXX3S3K8nhmzzcry2k5vJ8prGY3w08wvzWy+GAGbDsHcc5FpKbBGAF5h4DEnmAfVf51oPrhKszYrgZCW7q7pUkzugOWzbaOUQrVDwG1iGwKhihvGz2a6YctcOPfKWImdEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=fyKJdU8x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fB3CzQhw; arc=none smtp.client-ip=103.168.172.155
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 788331400155;
	Tue, 30 Jun 2026 18:59:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 30 Jun 2026 18:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782860342; x=
	1782946742; bh=Y6/Zgv2EAl9gLYe6n45/Fj/bRUykpuAHQNGEahXM/Fw=; b=f
	yKJdU8xc7g+NbyNpimhrGu/ESkmOiau/sI+Rj+KYSRs9TzgBMj+Yy5JxxaBH78Ba
	LX8mgB0jziyUJmyPuEpzrSNW0dDLWmnLBaqBPerNnxVcWVEiK+/p2NVvJsVJkdGC
	zuOfKc2zIFBtrVIJJCc2IDm/vCJx5QgkdacnSxAJMP621mApehnwSLGs8oy5laUc
	oh1o6EefllZmdeY2t7hfBNvlz1u9WERifIXV6DJW/7mgKcUYT1nETcDccbYBD0mo
	d7+HBKE5qc3v+BixAUesvRNOk4uqxiGrJ9A29vkqm7elqczJGX+kHdjMyw98OoW2
	aXQWgAGJYqWyIYhyCJcKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782860342; x=1782946742; bh=Y
	6/Zgv2EAl9gLYe6n45/Fj/bRUykpuAHQNGEahXM/Fw=; b=fB3CzQhws62Gz8VOR
	8dlXFhD10XO8EXKBhnq6PKJaZpdn4zW8aHjGUCEYgam8y4BO8IHJCmlhlEV8JCal
	qCe6bKop9kcuuZGc8biKM6+Zj/DdOsnRDMzVVbrKsMMnvYJmxNuc97j5PsbFyqpp
	ssgNFaq3uDmOr4xp+oTQtkaux3Iovti31d8kR4R/FgFUnzGGsf8TVNP6CaNqoCj1
	8w421nAUfqQllVhu6pyt5w+ycqaASH5StOYVkgbvFJB69ON456BhOw2VLFk83muE
	7xdTVLxvnyA/OYuSWMS/ckx3GlgtbYjZVxmOpaEO9YEMt54/PfgSS5Mdp38Vr3SH
	Aj1lQ==
X-ME-Sender: <xms:NkpEaloEmV0GtKfA0GcQ7CE4u5gIk1Bq1rkVkqDU9TtV-ZiDj-dsKg>
    <xme:NkpEalfEJzyZtC2c-D7uEzhJ30ggO8UDFsCSt6_CA3rnN0NUiiU9UtCYgQDEg-aI_
    L9lh4APc-oQQ88uJA2XkiFAPFHihfR2U5hCj5ZeVGrlLjD-32VdE1k>
X-ME-Received: <xmr:NkpEasr4yXZPQROTOSU6ndXO3ZLzmKjqZ21kK4jH8byUPVNI_EKOMo6HJgmLqFzPnuO-Cw>
X-ME-Proxy-Cause: dmFkZTFTCyQAfWYDemlxUx4YqR+3PjSq0FDg5PiuVvmR0XrgpUv20vbl+GYngsLKybtXlJ
    aq2liW8irkXfHFLWni5f17wlz0AgWclfEA79DIIaCt93h4MlRFiymjSXseEleN2+VNcbPm
    eTH0DOPcmwbygkxndcvBp588c4Fy2mIb/H9cdGRMRloBHuMsCtbAaOqc0ARHgx+ttvCSm/
    xU+vpZscgxiVmIkDdw5JH26WswdwPG1cAs4lei5DYUm7etfM6H1Shdxv9N2mGzXHo+Qv7S
    s7oqQ940o7+vuov2GriQWjyh83B19eU09Aj6A4nSmonl/h27AOPjLy1dH9wdnnZwLja0Ka
    57r1JCHEcKDnO8adCQ6rKUMd6f5U8VNHUIrX03v7MyHSmR14bmk8wuQDapK/lUdjgMW4Xc
    5AO9j6RRM24gcd3FfsmvHUsyappRi0U/HrsQTj7R1enySXz3SyYHJzg0OvAJ6HQH4he/Fl
    DCuzdhwVDx9lIoGt05PYYCYTfb8LacdagaQfetdDhfwNh2l1S2VOhju7vgx3zmt4wQkVrZ
    Vog7sVT0X4/92pERyhhXsLe3oZPS1zD9MsplfJoAYrX5UZYR/EBrQN/+mKjuAwMJswSzEf
    MDnSSwUg/K9g3Xbb6PoOObk21EiLHnSVegGe9C2+H3QUim1MwA63LONz667g
X-ME-Proxy: <xmx:NkpEauG3Ut5yUXvka_EoSwzdcBYPlE4CVLRX1mPFVC4khVRwpy4RtA>
    <xmx:NkpEakuEwyMpxu7Pgy0jTuIqPhfxvGBwABMhMUtrVTtnXe3ypti79w>
    <xmx:NkpEaoWca_2L7AjheVqo8nOhEC8GxXI3rSVLQZeukyzGr8FoML7EWg>
    <xmx:NkpEaoG1H9kZXj8AtAVA_k1iiwyEr1vIIrhiIt-zsVwz4g45QxD_Mw>
    <xmx:NkpEahJfcR_cU888H4j_AsKBjcSxGNBNOGZyn0bpqfKWI9Oti6T8iN1W>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 18:59:02 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 20F9F9FC67; Tue, 30 Jun 2026 15:59:01 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 1E4129FC4E;
	Tue, 30 Jun 2026 15:59:01 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    paritosh.potukuchi@amd.com
Subject: Re: [RFC net-next] bonding: Retry updating slave MAC after a failure
In-reply-to: <20260630150937.3508222-1-paritosh.potukuchi@amd.com>
References: <20260630150937.3508222-1-paritosh.potukuchi@amd.com>
Comments: In-reply-to Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
   message dated "Tue, 30 Jun 2026 15:09:37 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2001255.1782860341.1@famine>
Date: Tue, 30 Jun 2026 15:59:01 -0700
Message-ID: <2001256.1782860341@famine>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303398-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paritoshpotukuchi@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paritosh.potukuchi@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,jvosburgh.net:dkim,jvosburgh.net:email,jvosburgh.net:from_mime,messagingengine.com:dkim,vger.kernel.org:from_smtp];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 092CE6E890E

Paritosh Potukuchi <paritoshpotukuchi@gmail.com> wrote:

>I came across this TODO in bond_set_mac_address() :
>
>        /* TODO: consider downing the slave
>         * and retry ?
>         * User should expect communications
>         * breakage anyway until ARP finish
>         * updating, so...
>         */
>
>Currently, if the dev_set_mac_address() fails on a slave, we go
>ahead and unwind the bond and its slaves.
>
>As the TODO suggests, one possible solution is to try setting
>the MAC again, after putting down the interface. This is because some 
>drivers may reject changing the MAC when the device is UP.
>
>The solution I am proposing is as follows:
>
>dev_set_mac_address on the slave
>        - If this fails, temporarily stop the slave - ndo_stop
>                - If stop fails, unwind
>        - call dev_set_mac_address() on the slave
>                - If this fails, unwind
>        - Bring up the slave by calling ndo_open
>                - If this fails, unwind
>If dev_set_mac_address on slave passes, we go to the next slave
>
>
>Before working on a patch, I wanted to get feedback on whether
>this interpretation of the TODO makes sense and whether there
>are concerns with temporarily stopping and restarting a slave
>during bond_set_mac_address().

	I think the proper thing to do is remove this comment block and
make no other changes.

	This comment dates to sometime before git, when it was common
for network device drivers to lack the ability to change the MAC while
the interface is up.  To the best of my knowledge, that isn't a issue
today.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

