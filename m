Return-Path: <netdev+bounces-296729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dMUmICoyJ2rEtAIAu9opvQ
	(envelope-from <netdev+bounces-296729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:20:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E590F65AA4C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:20:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jvosburgh.net header.s=fm2 header.b=rmmQPXIn;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=buJi0WIo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296729-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296729-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=jvosburgh.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1C9430021DA
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB1D39D3D0;
	Mon,  8 Jun 2026 21:20:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE8E39E9D5
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:20:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953639; cv=none; b=DqQqdeALMJ8ZCv/GO9TfCXDirN/zoZYcWLkaUlWEcJ3qAvyFWu9mRHv3as62Ia1uB6lKysEvbL9didAOeOEoWYy3MjajoJU3No+jfVChYHcUNQ+pmWc2LV2j8d39tmUCeXzul+PDYD0UhpAWV8wUTFKzd2B2eIZFDEAVYLu1CgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953639; c=relaxed/simple;
	bh=Ku/8y6XN3MJLysNCrORp9X9NXKDQwCp4KeIb9vYHi9o=;
	h=From:cc:Subject:In-reply-to:References:MIME-Version:Content-Type:
	 Date:Message-ID; b=hLbNLmJaKANzk4ZUMjAPwTAQ3c7/cdX0nd6J0k+Wpe03YgJkyK5DouoKLe3oq4JaRoNC/d4hhHvAhoWM5434y2PYkr8wIsIIIXRAVsrLIrupiRtztg2d7Y10Wuzjbl9iKJSv/U1gImqeej7Ew1bPQz3X8GCggXRzua16ZZiNRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=rmmQPXIn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=buJi0WIo; arc=none smtp.client-ip=103.168.172.147
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6995CEC0166;
	Mon,  8 Jun 2026 17:20:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 08 Jun 2026 17:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to;
	 s=fm2; t=1780953637; x=1781040037; bh=+Jb8KQT3szTmTG764Lhs053Tt
	F8dMDsgbz5SRbZ6b1M=; b=rmmQPXIntMbkeeOnmHEWSf8GeVhDiUkElJy9vU0us
	P4CXUN4zWZh565msxbTZVSGAzKWvwP+p1HjhaGHaoLUiK2OjtmrsRjvaz/ZJ/IZU
	3kwwNtKdl9D2YkfqclQ3sT7U9r9NmFe885N54agMLGHHQRKLHhsjeebzabyIHeST
	CYGLdRfC72v+Z6i3SJMohr+mur7/ROV7jV5y4BTFvCP770l3C+Vug0txFOfjudx2
	Rm2SzDHome3s2SS2Ah1SkKSouA2LBNdMpu3MRk3ndRGKWAbfw2Pdm2b0rinU923E
	TdAoNPxpsuo3LS22bhJqaZmFCLxmGCWqlnIhkv3Jw1mJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780953637; x=1781040037; bh=+Jb8KQT3szTmTG764Lhs053TtF8dMDsgbz5
	SRbZ6b1M=; b=buJi0WIoarLmgDU5v34We6Pp9/WrZ+svrBf5F7jWSXJAI0Y5e5N
	x20dqoC3QSC+KIe2Tg3OSJraF8r4MTXuXR4bdztBLhDjQHqHFvwG7kfEQ+vJlIe0
	WzJxc1OAWCVbk7cPHH8ZUEUPNuL5NdcsMMiXCXr+ZPl2nwqqdl+SvxRGn0HO3tlw
	HRvD3xyHGdgYtLRSYX+P/JSVvHzxoo7JqqPDOhvHrLymQkGT93P87h0UExMfBB5R
	sr7mOwjPj3neNYNg307iExDJqs8H3mtHhoCkVS4uYcM7RLWNchSaT7uFH1Y8jEtU
	/gpdAxJGBZHn7xgUAc7rRDy3JIuja/qNneQ==
X-ME-Sender: <xms:JTInaqRCVy-KRuOWyLwGCm8-GTM2ZWuBxh3x6esSMf2DcVryl_50EA>
    <xme:JTInarkiaPLnp3lU0H6rhT5GfFC83upnvhBg2UNBC9wyb9SA-2_klo_48gkY60hgv
    0wY5mfw_GVhQpKuMkYwpq_jjwbBgY-NLA5ndQH7qpYWrO2Nq2tgft8>
X-ME-Received: <xmr:JTInajM4Zv64XPM_9-WbMOZtgRHNEqLKpAj7yQbR6neQsWwphnluU7TKq8ytUqbmG0sc1Q>
X-ME-Proxy-Cause: dmFkZTF6DR+da/AWE1bja6R5Fqp+f22vWYw2HrTOERtfQxA4XuPa7SoTeJRLFYoWX/49UQ
    3u8gCNbJhy2tokgWVJCU3nKDmSbyAWlqF0PBRjkJ0Uh4cNaXWaOonwjWRndxSlY0DXcUn+
    rNjnKEjsWwtW6pVGliVTRdmdvgDXxmayw1p3R6b2WIMWlztYnldLD3z4BxfKyy61SQ+iTV
    M+QrMKBPwa05ngElArSOGVF2oXL4vaOVrL6EZTnoB0iNERMiyoMz6DEyZ65aCoLy7F8A+p
    XtsY/gZAknMHcURJqqoa7GKFTdPlp2bxxrsw0LL0G/d43kZ2OQ7s/IuyeB554lBogRi2ky
    ie/ixgbub8MkZVy8BhJ8P9b56NLgk+AQB5X9VBpTlbPbCw0NUrv/xwKYUCvzUaJfH7BYd8
    39d30c1IlVu4fz06697dyXkaxY/eRmKWpgb1CUZun+GC+eG3RmeIrS3YSH6Z7wFc/RvvyB
    FJWaID50ovA1v2ZHmukZ/qlnKRlv9U6rHF1CqXnM9UHDoMjlLUVKe9RsK/WS2ouhxp600p
    vDtO9mzc51XcxqMx6jZvCg3bLhb32htLPNXjc6o5MDVLr4OpSg3sWbnFOcaMiCSh/tDGWK
    lH8wx+9NYisEJyU+umi8cRjcW632aCgRsioT2vtIIkqUmpr5qqNhKbJw0tMA
X-ME-Proxy: <xmx:JTInavj8tWP-b7gnVjaoZ3y4vlr9q9ssbJ_oKcNB1rR9cDDYcv_zgA>
    <xmx:JTInahgc7oCcVUIAjftRLjTwVF5hpK4O_tkbnEm5P9UZDYvQfXxlLw>
    <xmx:JTInauJXvrMGdB9AmapfdaQcB_L1IPcaNWKyMm95ADO24qOfLYhENQ>
    <xmx:JTInagmF8VSp1p9RMHair9wgMiMJRiFVLEiy5Act-893lEBK4B-qYQ>
    <xmx:JTInaqzTvuFILDmweK0e02OhpQoDM3RhN-C7iKKaj-DjI8fYYcmLSutL>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 17:20:37 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 32DED9FC5D; Mon,  8 Jun 2026 14:20:36 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 2ECC19FB80;
	Mon,  8 Jun 2026 14:20:36 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
cc: Louis Scalbert <louis.scalbert@6wind.com>, netdev@vger.kernel.org,
    andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
    pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net,
    shemminger@vyatta.com, maheshb@google.com, jonas.gorski@gmail.com,
    horms@kernel.org
Subject: Re: [PATCH net v8 1/6] tools: missed broadcast_neigh if_link uapi
 header
In-reply-to: <1040684.1780953413@famine>
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
 <20260603150331.1919611-2-louis.scalbert@6wind.com>
 <1040684.1780953413@famine>
Comments: In-reply-to Jay Vosburgh <jv@jvosburgh.net>
   message dated "Mon, 08 Jun 2026 14:16:53 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1040858.1780953636.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 14:20:36 -0700
Message-ID: <1040859.1780953636@famine>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	MISSING_TO(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296729-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:louis.scalbert@6wind.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,jvosburgh.net:dkim,jvosburgh.net:email,jvosburgh.net:from_mime,vger.kernel.org:from_smtp,6wind.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bamaicloud.com:email,famine:mid];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[6wind.com,vger.kernel.org,lunn.ch,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E590F65AA4C

Jay Vosburgh <jv@jvosburgh.net> wrote:

>Louis Scalbert <louis.scalbert@6wind.com> wrote:
>
>>Add missing IFLA_BOND_BROADCAST_NEIGH in if_link uapi header.
>>
>>Fixes: 3d98ee52659c ("net: bonding: add broadcast_neighbor netlink optio=
n")
>>Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>
>	I'm a bit confused, I see IFLA_BOND_BROADCAST_NEIGH already in
>the net tree, added by:

	Never mind, I'm a doofus and missed the "tools/" part.

	-J

>commit 3d98ee52659c3f1d3913ae5b97f7743c5247752c
>Author: Tonghao Zhang <tonghao@bamaicloud.com>
>Date:   Fri Jun 27 21:49:29 2025 +0800
>
>    net: bonding: add broadcast_neighbor netlink option
>
>	-J
>
>
>>---
>> tools/include/uapi/linux/if_link.h | 1 +
>> 1 file changed, 1 insertion(+)
>>
>>diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/lin=
ux/if_link.h
>>index 7e46ca4cd31b..97a2d4411534 100644
>>--- a/tools/include/uapi/linux/if_link.h
>>+++ b/tools/include/uapi/linux/if_link.h
>>@@ -1526,6 +1526,7 @@ enum {
>> 	IFLA_BOND_MISSED_MAX,
>> 	IFLA_BOND_NS_IP6_TARGET,
>> 	IFLA_BOND_COUPLED_CONTROL,
>>+	IFLA_BOND_BROADCAST_NEIGH,
>> 	__IFLA_BOND_MAX,
>> };
>> =

>>-- =

>>2.39.2
>>
>

