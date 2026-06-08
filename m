Return-Path: <netdev+bounces-296727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sdcSMKoxJ2q4tAIAu9opvQ
	(envelope-from <netdev+bounces-296727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:18:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0F365AA34
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:18:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jvosburgh.net header.s=fm2 header.b=Hq08RX3j;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=hK2F9v2K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296727-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296727-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=jvosburgh.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA55303748A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0483A34E745;
	Mon,  8 Jun 2026 21:16:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3443FFD
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:16:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953417; cv=none; b=LbjbVePnO4nqGR3GkxiuF9mdmlixE9dE7L4UbkYf8UH02IHagG46sDwPP8g8/AtKLeKAc8P4iJefO4wbYzjRaUUJf43KzmyZHxbsi2soUmhmBcTmTeXChafgfBU+gxWuflVyB0mh2mZ1/EwC4U5mZiC6CRNT+ulSZaurMPrkmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953417; c=relaxed/simple;
	bh=pxmhjD1dEtt229AAbFtmBL+QITWw+d2TB+8/W3Z8hCw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=j1soxleMMBKAKzfAuuVu1EipDKT5TbotQQpDyNfM13MzW4nH64aqp3qvThsiO27/PoWZrSqiw5El//AV5sSOCCcohFPhbtOeUW2JU9CULLDzoyHWmRgnjUBod/owS0K0HD0qLpnMWm30f+eSsnZY9aAUnXr2kBQ9vi51enxxCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Hq08RX3j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hK2F9v2K; arc=none smtp.client-ip=103.168.172.157
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59BB514000FA;
	Mon,  8 Jun 2026 17:16:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 17:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1780953415; x=1781039815; bh=AtN7GypxgN27SF5pSs8JD
	drsXoFSSFQ4xw5p0IHo5cg=; b=Hq08RX3jxuI+uVJc1h0gSbwvwvjdQMFAl1UB7
	j3TeUfrFhSI1K+kdX53xQ485/YMUN5gJuBwfTAD52mU06gp9GGVgumhEdzHAOMuz
	QuGcJRd0OLOrarD/WsU9UlHS3KV+W4YpB/YbekZF2bsbK4pi7jaLs0s9sIykDhxi
	Vso3KWf8AvURetpQcMmTSbKLQN4+7+69Ph/PvYBWCNqCsBRIZd+rS5zS13jlplTT
	YoiFu/rYRVAakZf445V4SRJcp8MLK4jCjtrN7I8Vb06QiZs1ull39cBuYTGXZnGA
	4bLFBgCGN1KniNTp5ct8fYUXeWm2QRhRQb2IUL3lp+pjJe/8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780953415; x=1781039815; bh=AtN7GypxgN27SF5pSs8JDdrsXoFSSFQ4xw5
	p0IHo5cg=; b=hK2F9v2KqQiQ1JNeY236Ky/qR4uWUKmLNuV1IEMUI/smi7sDHgv
	Sy4Zn8zd6eYnSSc0wbw9GjAsUQ01sottU7f3f93qvI4cLh1/cHpgLDSRX++cia+h
	DltvHmk7YOh1JVPeEjHpMEfnaLqWmP2BHxZ/NLMvvsNJZ0X5BNwex+WVyEezdaBm
	Bjsxmqz8EEydDj/KEKOTwZTJqcAZIIE62r8N6DFc7yzA74KyfdkSfW87PoAjD7VC
	zCIGYjTdO5z1AQqt6zLrhDjN9NplQEMCTpyzA2RDKIB0XuH9mxBCdbPCa+/IJnmQ
	nYYJvO6CbcBMxRozi3KukvITTyu/WaqgIUg==
X-ME-Sender: <xms:RjEnamlWgoCHI5qDyWLtjSfk0PMsAe_LeHzeZJ4hUVSCs6ttsUk7hw>
    <xme:RjEnapqLHkW57mmoytkSGiXrpDr63nXPVUu93VxBQDAysSBu4WnvO40MVyuPwkfmN
    ZYMY1ahsELa7XnsKlXImlx9YqI1xaMIwmHvjsVG1K0aUNLXzfaYyi0>
X-ME-Received: <xmr:RjEnagAGt-WXPweMeGsOVBGUCUKUTk5TSVRwBpHO-YbJlyf89cmEAOTKJoz2_FhAsyBxuQ>
X-ME-Proxy-Cause: dmFkZTFQgmUFxaXp/NKwsU4iuB7aQub3kuL5A6vcxSw2N4QgInMYfY1OwXQdMP/I1cTrKc
    Z5RISK4qJp/pzSLbLr3y+RMub677ZzVG59LE444HwXpdaRADffhxsB1wA/Z1sxGA1uZYlQ
    EnactV0AxGJsD4qghJERNomIoBgdUatabT+FOxwpUCSBmxTFEIhTn6iocSkSxgY0LI9R1l
    4PR/mGEckBe2OanLk212fMSEzF7P93GxsS/kr+t4n0YwmNcIcxApVeHa/Opsb5NdabjyJ+
    wBlnTQoZgIbDLNtKzoc/n/nGyXzh/8n+DaT/iJ8BAXllApsQaLyF67EuaYBp2sFGDGcEMM
    z48cdUIIyN3XiPORjZld05qcfAw22b1HY9PJRiCWwjRi+aUNnxV9PiP75b7pxHcu06IYQx
    qUUUSLOyPWS2W22L7cVqDRMI5ftOmc0gah2B5p8e46scSoQDFCbu/ZrQKqRlUzwuSoeP/j
    yBiYmVDvanSDoZGdXJ8P0hl7ENIUePHg5LaBl0R1iTtL/NwBLjiSR2bsq04A941iupL755
    MtsdPwur2z9YrbQ/77ipPcsgIj+NI59KA3im09B6GVcFkmFtNoKrdDYqmWcEe9Htr5CZvM
    Knge2kG670MCCFz9ao4hiRtLCE2ssdYYeUH0KeV6XDhPOuQEdaiREJ5GWKtQ
X-ME-Proxy: <xmx:RjEnakHL__isU-dTNQgMrCYVaw3BvgmRvSIth-E4bZmVrBK6Cl9sdw>
    <xmx:RjEnai2H_NnvG1WwmWpGEHyE3YlF4PXctF6X21TuB-m3zGZxt-nsMw>
    <xmx:RjEnatPNcoBh1VYE-80gBUZJQrN1OPO1hNbRpI4JlQjR47u41-XClg>
    <xmx:RjEnaqZC6lcGEhNFXO5qOv6amCoG5ikBjhnUTy2bN3c5ItCNviecyg>
    <xmx:RzEnapErfO-L22nmjlKWesomZZApLn2UN_u6FqKFMwwfo_taPwdcmu1K>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 17:16:54 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 8265C9FC5D; Mon,  8 Jun 2026 14:16:53 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 80EC69FB80;
	Mon,  8 Jun 2026 14:16:53 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com,
    jonas.gorski@gmail.com, horms@kernel.org
Subject: Re: [PATCH net v8 1/6] tools: missed broadcast_neigh if_link uapi
 header
In-reply-to: <20260603150331.1919611-2-louis.scalbert@6wind.com>
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
 <20260603150331.1919611-2-louis.scalbert@6wind.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Wed, 03 Jun 2026 17:03:26 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1040683.1780953413.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 14:16:53 -0700
Message-ID: <1040684.1780953413@famine>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296727-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,vger.kernel.org:from_smtp,6wind.com:email,jvosburgh.net:dkim,jvosburgh.net:from_mime];
	FORGED_RECIPIENTS(0.00)[m:louis.scalbert@6wind.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
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
X-Rspamd-Queue-Id: BF0F365AA34

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>Add missing IFLA_BOND_BROADCAST_NEIGH in if_link uapi header.
>
>Fixes: 3d98ee52659c ("net: bonding: add broadcast_neighbor netlink option=
")
>Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>

	I'm a bit confused, I see IFLA_BOND_BROADCAST_NEIGH already in
the net tree, added by:

commit 3d98ee52659c3f1d3913ae5b97f7743c5247752c
Author: Tonghao Zhang <tonghao@bamaicloud.com>
Date:   Fri Jun 27 21:49:29 2025 +0800

    net: bonding: add broadcast_neighbor netlink option

	-J


>---
> tools/include/uapi/linux/if_link.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linu=
x/if_link.h
>index 7e46ca4cd31b..97a2d4411534 100644
>--- a/tools/include/uapi/linux/if_link.h
>+++ b/tools/include/uapi/linux/if_link.h
>@@ -1526,6 +1526,7 @@ enum {
> 	IFLA_BOND_MISSED_MAX,
> 	IFLA_BOND_NS_IP6_TARGET,
> 	IFLA_BOND_COUPLED_CONTROL,
>+	IFLA_BOND_BROADCAST_NEIGH,
> 	__IFLA_BOND_MAX,
> };
> =

>-- =

>2.39.2
>

