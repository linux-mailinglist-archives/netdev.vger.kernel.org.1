Return-Path: <netdev+bounces-261651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFJzK5PwoGmhoAQAu9opvQ
	(envelope-from <netdev+bounces-261651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:17:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D81B175E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01CC73008621
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691E722423A;
	Fri, 27 Feb 2026 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="G1DsVA4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDChppER"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2701AAE28;
	Fri, 27 Feb 2026 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772155020; cv=none; b=goww+ooFLQ6JM7gMM799nyECHSqGQyoxGKB4Sl4OdFOQuOC49cshc3O5BGTkaA+0VMgZ4XCZeyvb78om695ynjJarbV/B4EzlSBYmSM5P+fS75au/MooprZhFNURE+zT0HcSNcX5Z54nbL0YlJQXWJuv4CoHDGy8z2mdNiNQJcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772155020; c=relaxed/simple;
	bh=MOrSwXY88w7HsmkbJG76/DT3xMJe01+L4j5heQQ/GLQ=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=WiUTzztwaejC45/iiIUjEzSfEnbTB6EpalX/xYbHGkwwt81dHPN6OtCxW4+iXfaBxKTthaiIN27/LGSWuWBM5RrWEALyBWI8MHjRgWZFJaquQVc7mjzD5pkDFJDhiEQ7jWuig8ukIx1rb9Q4u0yo+VhqiZADTVAU08YH7iroh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=G1DsVA4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDChppER; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B634A7A0070;
	Thu, 26 Feb 2026 20:16:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Feb 2026 20:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772155016; x=1772241416; bh=HluBTWjtB4nmJ7Kmo16jb0iyeLaGJM0+
	1nOjnZpZpEQ=; b=G1DsVA4ptRSRG01CUrPCRR64z+JzQsrqXoGOwMpQNnax5UJ5
	oACot6DT32ZmQXkAve3srpwGnefZU9zK0+dkTkIFn8i0Y63xwOPhvqFiR+0s8SfH
	PbsWoW6DirUDdi846nHwC2VWIZoHm+o25cypHIN3+eYcgnZvQczYyhp5Ilfsa7ff
	qTKApGLmIXBIA0ROCQHdyp3sohupRURleQhylTupQY35t6Jl5a3iz7LR6XHfze3P
	VvuzeQS36WrMVac/JLu3WI4hV8GVQRAB4dJRCQeTMU2JBvaDFr4sxASdZ4JJ/q23
	n5neIf5J5rsj5aI4NaXFGZR2lnxR1H/uao4qQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772155016; x=
	1772241416; bh=HluBTWjtB4nmJ7Kmo16jb0iyeLaGJM0+1nOjnZpZpEQ=; b=X
	DChppER+/DubT2TjYZrmnJWbeLZiXcZpYeqxXzXt/zmFQbQniIYIsejMCkG6cobH
	mxhxCVazyE6xYBEgNV29+C62OBP8xUzBrZS4flVq5Vhh0l/Hz+Wfqvu5IWvErcVo
	eHp6PiceevPaLTIUCGj1gc6MHXH6GWwLsp3CH3N7Ka1/B2hWGPaeQ4uwAuIscSuL
	iKLYHSZRpY8GuTfM54FJ4BMmC55q7ld3q5swhztLVtS18ud4mjh5Xxl32UnsLLNV
	KibWRMeUpIW3GHkETQkT1F56JnwkNeeYl3LVJ4uFTcqDfgN/tNjuGKAidm0kNUCx
	RZglt3A2KQ08H/V57J+jQ==
X-ME-Sender: <xms:iPCgaaOJdrRvCn0J2yAgQgVZGjsqX_2hQPzTjrm-I4nV-emT9uXJqg>
    <xme:iPCgaTYa_lvVqgRa4pQ36WXVuq05Kr3ObtXgDgNDPULNCzYidHGuC3fRmGr_QaU6q
    2_7WvWSip9LED6AzQzufJ4fedB1CKCsPQD5tF4xXGSVvjATNt9vih0E>
X-ME-Received: <xmr:iPCgaYwr8MY2aDVSomwXQNdChXAtgriFE4s6eFT_pns2bCFkPJxUSE2wgiuQIGhGx0bAuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertdejnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepgeefgffhgffhhfejgfevkefhueekvefftefhgfdtuddtfeffueehleegleeiuefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhiuhhh
    rghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehmrghhvghshhgssehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhu
    nhhnrdgthhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:iPCgaSN0YoWMGdcOBaVhSwgSLWM_OajI7PxA_MtaMU0rQPpbx4oRGg>
    <xmx:iPCgaXeE9A54mzoltxAj8YP9956rIjCiKl2IQgE9kx6QJv9zo7JN0w>
    <xmx:iPCgaXRbvfUxdw_JzywZi_QSQMAq5mZh4hMTyk1xMdKvJSK7ueNrKw>
    <xmx:iPCgaVd0ZLZ9QeCQ3YOBb0G4B4uKa4p7WI56_e5PX7euDVemZLNRbg>
    <xmx:iPCgafDGSm0Tl2OeSyKES_EtTNkU0philyLI0eKVch6Q6PJYkeMLsfP5>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 20:16:55 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 0E2919FCB1; Thu, 26 Feb 2026 17:16:55 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 0AC1D9FC39;
	Thu, 26 Feb 2026 17:16:55 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Mahesh Bandewar <maheshb@google.com>, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net 1/3] bonding: set AD_RX_PORT_DISABLED when disabling a port
In-reply-to: <20260226125331.28147-2-liuhangbin@gmail.com>
References: <20260226125331.28147-1-liuhangbin@gmail.com> <20260226125331.28147-2-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Thu, 26 Feb 2026 12:53:28 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Feb 2026 17:16:55 -0800
Message-ID: <942584.1772155015@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261651-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jvosburgh.net:email,jvosburgh.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DC3D81B175E
X-Rspamd-Action: no action

Hangbin Liu <liuhangbin@gmail.com> wrote:

>When disabling a port=E2=80=99s collecting and distributing states, updati=
ng only
>rx_disabled is not sufficient. We also need to set AD_RX_PORT_DISABLED
>so that the rx_machine transitions into the AD_RX_EXPIRED state.
>
>One example is in ad_agg_selection_logic(): when a new aggregator is
>selected and old active aggregator is disabled, if AD_RX_PORT_DISABLED is
>not set, the disabled port may remain stuck in AD_RX_CURRENT due to
>continuing to receive partner LACP messages.

	I'm not sure I'm seeing the problem here, is there an actual
misbehavior being fixed here?  The port is receiving LACPDUs, and from
the receive state machine point of view (Figure 6-18) there's no issue.
The "port_enabled" variable (6.4.7) also informs the state machine
behavior, but that's not the same as what's changed by bonding's
__disable_port function.

	Where I'm going with this is that, when multiple aggregator
support was originally implemented, the theory was to keep aggregators
other than the active agg in a state such that they could be put into
service immediately, without having to do LACPDU exchanges in order to
transition into the appropriate state.  A hot standby, basically,
analogous to an active-backup mode backup interface with link state up.

	I haven't tested this in some time, though, so my question is
whether this change affects the failover time when an active aggregator
is de-selected in favor of another aggregator.  By "failover time," I
mean how long transmission and/or reception are interrupted when
changing from one aggregator to another.  I presume that if aggregator
failover ater this change requires LACPDU exchanges, etc, it will take
longer to fail over.

	-J


>The __disable_port() called by ad_disable_collecting_distributing()
>does not have this issue, since its caller also clears the
>collecting/distributing bits.
>
>The __disable_port() called by bond_3ad_bind_slave() should also be fine,
>as the RX state machine is re-initialized to AD_RX_INITIALIZE.
>
>Let's fix this only in ad_agg_selection_logic() to reduce the chances of
>unintended side effects.
>
>Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> drivers/net/bonding/bond_3ad.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad=
.c
>index af7f74cfdc08..c47f6a69fd2a 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -1932,6 +1932,7 @@ static void ad_agg_selection_logic(struct aggregator=
 *agg,
> 		if (active) {
> 			for (port =3D active->lag_ports; port;
> 			     port =3D port->next_port_in_aggregator) {
>+				port->sm_rx_state =3D AD_RX_PORT_DISABLED;
> 				__disable_port(port);
> 			}
> 		}
>--=20
>2.50.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net


