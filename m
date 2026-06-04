Return-Path: <netdev+bounces-295050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5YrLG8UQIWpE+wAAu9opvQ
	(envelope-from <netdev+bounces-295050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 07:44:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDF963D0FA
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 07:44:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295050-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295050-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=padl.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 527FC301AD26
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 05:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867633BFE4F;
	Thu,  4 Jun 2026 05:39:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9393C09EA;
	Thu,  4 Jun 2026 05:39:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551597; cv=none; b=D/U7XP6Ofqgpi8nkGxOUCue+x0mFqCvBC84IRKDpgcO9482yUttoWkEpT1Yx+StHKPRK9hjSfVOJJUga9v8zJqInuvPbP4rCRMQKK1miqsjXc8+Lbx+NDgDB/jZJXLL/U4fNW1PRngmaCL14lTgzpl6ZasiZdxbY/4NJBgX3roA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551597; c=relaxed/simple;
	bh=/71IDNAYlaYhMk27O2rluNJgQT68JB+md99aDpuFqFw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YvBx2pRKDhaZUcQkpD7M6vfUPlEgH5ypeGB48MtAKcrf+HkRM144rT3b1o06SZ9c0qEdqX15RtubXnPAUOyyAhsJdBIcSw8xHDff84AgtuUlRfY/vO3daylk7Lt5RqP48tij3963D4s5Ox6OGrpzieEBZthu+4PPxZjQ0YfHwn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 7471B60058;
	Thu,  4 Jun 2026 01:39:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 7471B60058
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
Date: Thu, 4 Jun 2026 15:39:25 +1000
Cc: Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 Max Hunter <max@huntershome.org>,
 Kieran Tyrrell <kieran@sienda.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[padl.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:cedric.jehasse@gmail.com,m:razor@blackwall.org,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295050-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,nvidia.com,lunn.ch,gmail.com,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:from_mime,padl.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEDF963D0FA

On 3 Jun 2026, at 5:35=E2=80=AFpm, Nikolay Aleksandrov =
<razor@blackwall.org> wrote:
> So looking at how this is implemented, why not put most of it in TC?
> It is testing for skb class, for tc qdisc, I don't see a reason for it
> to be in the bridge at all. You can filter the mcast groups and =
simulate
> the "reserved" flag, it has to be set manually anyway. Adding new
> tests in the bridge software fast-path just for this is a waste.

This makes sense. Maybe it=E2=80=99s better to use flower+TCAM to =
implement this, and have our SRP daemon manage flower entries in =
addition to MDB entries. The mv88e6xxx driver=E2=80=99s TCAM support is =
recent (hi Cedric!) and does not yet appear to support the 6352 or =
matching on PCP/DA, but one presumes this is possible to add.

Alternatively, responding to your comments, the bridge could mark frames =
with a =E2=80=9Cstream reserved=E2=80=9D DA with a new tc_skb_ext bit, =
which would be surfaced to flower similarly to l2_miss. The rest of the =
policy would live in the flower rule. MDB_FLAGS_STREAM_RESERVED would =
remain but IFLA_BRPORT_FILTER_STREAM_RESERVED could go (we would =
dynamically enable the equivalent in mv88e6xxx by refcounting =
MDB_FLAGS_STREAM_RESERVED entries).

Luke=

