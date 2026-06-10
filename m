Return-Path: <netdev+bounces-297425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BpT3CrHhKGrxLQMAu9opvQ
	(envelope-from <netdev+bounces-297425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:01:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F93665B13
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:01:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jvosburgh.net header.s=fm2 header.b=h64zDGnf;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="P WA+vF9";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297425-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297425-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=jvosburgh.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A59307AE52
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE31337B87;
	Wed, 10 Jun 2026 04:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DDB7E792
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 04:01:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781064110; cv=none; b=nlZozxdE62w/q+ox7Fgx3aw5Z7rbVwe6Q/yj/BaWv4KsFg4T8My9lyRLNJIo7OHh93WHB64Zzdq1UHm+OSgf6FQ2vn9mctAkCw64FsACWv2jGHJMNna/Dlh178SpfxQU5/PPNzSXhqSgStrIGpnko8KPMbnbdziBdOMw6315NOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781064110; c=relaxed/simple;
	bh=kJItE6LCRQHYsVfmrfj/JgBGeugjj9/2SeijFcHgysA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=TEQKQTh1PopJAIoBnB9XCrIw+tQ9t8/K6lNgvhnwxuJhGU6BrSrs+xIEgqfXnSM9spDy7Tm83SlJ83Np/hDlP9By+lkaOfIaNWI6cywEVdzWDbhLEPxrIEAJACEX2VCe3OA+SBNWEnjC5A+yCchRBc/LgIYtpaE1EISWVAvBsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=h64zDGnf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PWA+vF9b; arc=none smtp.client-ip=103.168.172.159
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4036C140010E;
	Wed, 10 Jun 2026 00:01:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 00:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1781064107; x=1781150507; bh=rtkq9QeQyqsoW7C8ybhLaXi9M4w1EIPd
	lMEVK7HHaug=; b=h64zDGnfaFSzVfXz27Kg8++5KPcv1ucteG9xf1f5oElTmv0a
	U7+y+rY/T9SLPmV3Mi78zK3fQNS3CyclT9In4hGTRsBk6YA3GCuZK0BK1mL6aBet
	PCsUYXs8Y4pHLPnTS8edQLvLJMBN7u709t6xpWR/ZrurIWWrYVCARRF2RzXl+BAe
	H8/6Abyemp91iSO+PKJcDLE1FU/vUgD9QgxDq3b6Do690aM6Hcxqi5BAT5Gj0faX
	CDOxA008vJEUQ03f2GrspK2J2p6OTn5rMdvyc2rpLUqgftJobc1c56vKPcB9v2U/
	Ae8hDPNK2LCx2NLb1iHBesYytZU9xkRc+3n1pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781064107; x=
	1781150507; bh=rtkq9QeQyqsoW7C8ybhLaXi9M4w1EIPdlMEVK7HHaug=; b=P
	WA+vF9bfNcwA9phxl9h8TOVobwxGRayH3cmVSfExm/NnaT5nAz2yQmHeQWyqiA4+
	7bFowR/K70Hq23gmg9j9Ka69qM0ZYExSInD5K7pf8BdJlC62mzqitgSzFtu846Yw
	ivBzo9ktiH9neEwKFv9VxdoX4KrDgCLxHeJrUnutIS0SJ92Cpxx++Jz4WO2mtmZr
	5ipEaSik6eJlmehs+nlXtpI2abn7eqj39fZsYq+QjowUQ5hCa38VpNp8shdz474e
	DzMwk3kMbXiEfHONtb/rrUo8NpvlwBPzKEGZ1tADYhNC8wIw8MULkPx0O81n0BOB
	vfJ2tjjk65boToxNFOhGg==
X-ME-Sender: <xms:quEoauq5i48l4Taab3t6nvNfkViqo52800DUuCAn7V1zLhHsu_Y-OQ>
    <xme:quEoaofPb7S-iJ9qTGnnji1v_s-GSquBwdMJAy_iF7WsHHHeoEDyzWPXd59ZE_ZQl
    vBOcIuyCryU9arUfq_aaD1q3WXsMenbi2MJGLERcGDCOotVEQo2Suw>
X-ME-Received: <xmr:quEoaunf03JmIWiPzTEERFyFWq0eOqcJXCF1osq-5m6ZRp5vCF2KcKGXFMDWlDqMpJSuCw>
X-ME-Proxy-Cause: dmFkZTFtdog3ahJS6oblJc6KfiKoQcQn9TZC3+osVPA6IIFp0zKzXPxPLDat0JBdaXhTuQ
    uTze0MgNaJgM+UX/f7mT85+RJVimKd9OaakZkO5moOIvfQMV1h6vgYZTGXX19GIQI1HyPm
    b9tHb5pIoN4O2wqcwt16csxBrCBcgwl+ckO7ZAtYGOCee8vIbHFDShkwzL2aDKY9XTGSdb
    n4k2LI/jLJ8HrmpOnwzIdM4Sd4hAr//78/Z1iFWpNXZFGrR2SJmdmSWLiY97P1w5Px3xzG
    OhegtvuYFFe5sqZ0rb+zwuPiOl2esjxH1NNzVJ6J5/OvbrMMOCXyHV5zGUR/JwVNxF/UV1
    x4meYa+SbT1RWzQaOUzpH/4AuEa2I87HXa/h1Lw9HKXkXLI6qUqBcxGFwzeVz34dN2sYuE
    ADmhVAZ4YyNzmX72jw7TYlJ4Y8+kHpzkNDkXWjamsRAWR1HkO8WRFYBYyBlKY3i3MMkeq6
    Z1xKdvvQytmeaFX1EbjKwigVaELL06W4paJq3Y2b0u/2mKdFxNwAfvHyht9M2BhlLitf8P
    fP9Eei2+bJTbyaUaptyXkbqUXUg0DVrYjdaMtd8PePvJ697Ekj3VnN0EQC79c3jevfKLjP
    raCTsieN1Mb6eJm3aSFiQrR1nWEoHQ0MryjNpue5Hov+xs3nQGjHICn2ETeA
X-ME-Proxy: <xmx:quEoanbp2-rbrlvZddcvAak9eCdmavD1I-IdEkqoY4EMtuCz9ME0gw>
    <xmx:quEoar4BtWbnOXgfzp3NWbQfVAdF3mpsPrXl5F3QPw8O_-Gba4I28A>
    <xmx:quEoapBDyeQboJfYILe51kidny2h0LVCG4thJuhUo_6xL1UdFdAdCg>
    <xmx:quEoah8yvi7YCSf_uqfCUdl6gnqvf6qMc0_8MYe40RRPrnmla7fFsA>
    <xmx:q-EoarIURfKFImFqgTheYZ8m5fHL9VAqegmhlHM43wxIMpRC2TUsLrH_>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 00:01:46 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 497349FC5D; Tue,  9 Jun 2026 21:01:45 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 487E59FC59;
	Tue,  9 Jun 2026 21:01:45 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Paolo Abeni <pabeni@redhat.com>
cc: Louis Scalbert <louis.scalbert@6wind.com>, netdev@vger.kernel.org,
    andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
    fbl@redhat.com, andy@greyhouse.net, shemminger@vyatta.com,
    maheshb@google.com, jonas.gorski@gmail.com, horms@kernel.org
Subject: Re: [PATCH net v8 4/6] bonding: 3ad: fix carrier when no usable slaves
In-reply-to: <377b117a-b29a-4761-aae0-3236be1f0b49@redhat.com>
References: <20260603150331.1919611-1-louis.scalbert@6wind.com> <20260603150331.1919611-5-louis.scalbert@6wind.com> <1041444.1780954642@famine> <CAJ5u_Of1+eEL4iVe-sWzhOOva6xx3gPCeXeRP4Y3yCqny8=gOg@mail.gmail.com> <377b117a-b29a-4761-aae0-3236be1f0b49@redhat.com>
Comments: In-reply-to Paolo Abeni <pabeni@redhat.com>
   message dated "Tue, 09 Jun 2026 10:54:01 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 21:01:45 -0700
Message-ID: <1120239.1781064105@famine>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297425-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,famine:mid];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:louis.scalbert@6wind.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[6wind.com,vger.kernel.org,lunn.ch,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25F93665B13

Paolo Abeni <pabeni@redhat.com> wrote:

>On 6/9/26 9:56 AM, Louis Scalbert wrote:
>> Le lun. 8 juin 2026 =C3=A0 23:37, Jay Vosburgh <jv@jvosburgh.net> a =C3=
=A9crit :
>>>> @@ -1179,10 +1194,10 @@ static void ad_mux_machine(struct port *port, =
bool *update_slave_arr)
>>>>               switch (port->sm_mux_state) {
>>>>               case AD_MUX_DETACHED:
>>>>                       port->actor_oper_port_state &=3D ~LACP_STATE_SYN=
CHRONIZATION;
>>>> -                      ad_disable_collecting_distributing(port,
>>>> -                                                         update_slave=
_arr);
>>>>                       port->actor_oper_port_state &=3D ~LACP_STATE_COL=
LECTING;
>>>>                       port->actor_oper_port_state &=3D ~LACP_STATE_DIS=
TRIBUTING;
>>>> +                      ad_disable_collecting_distributing(port,
>>>> +                                                         update_slave=
_arr);
>>>
>>>         Is there a functional reason to move this?  I don't see anything
>>> obvious in ad_disable_collecting_distributing() that depends on the
>>> actor_oper_port_state.  Since you want this to be backported via stable,
>>> fewer actual changes reduce the chances of an issue applying the patch
>>> to an older version.
>>=20
>> The path is ad_disable_collecting_distributing() ->
>> bond_3ad_set_carrier() -> __agg_usable_ports(). __agg_usable_ports()
>> reads port->actor_oper_port_state
>>=20
>> It was found by
>> https://sashiko.dev/#/message/20260526084048.1696544-5-louis.scalbert%40=
6wind.com
>
>@Jay: it's not clear to me if you are ok with the series in the current
>shape, could you please clarify?

	This was the last question I had; everything in this version
seems reasonable.

	For the series:

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

	-J


>Thanks,
>
>Paolo
>

---
	-Jay Vosburgh, jv@jvosburgh.net


