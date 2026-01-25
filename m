Return-Path: <netdev+bounces-253149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BaEC/f1dWkXKAEAu9opvQ
	(envelope-from <netdev+bounces-253149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 11:52:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6472C80202
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 11:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 594003005EBA
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49753164D4;
	Sun, 25 Jan 2026 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="N4LccVRh"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10F1DDA18;
	Sun, 25 Jan 2026 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769338354; cv=none; b=L5HEbl87yFarJrO6SUjsSxqTyenHp0aOG0jYK9aKZDtfBIFKt9SHvGb+rC3KYpL0rn+Fb31TOVJj1h4fjPYXg8rCl0KYTOPmhOHJXbbrXqP2VmUXeS2YhW761T25TyogdsXedIVbCQVUXIsr8QfPlVNd/IFZMW+MfoQUP/vsqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769338354; c=relaxed/simple;
	bh=N9wuVeisJp6wKmKx9xMnzIbH+aRPiEeSOuBAj23eXaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ixNp5sqFcK1VvfdImS22/GD5iufSaFGzUAf7fuua/Owom64sH3U4+pgWgXKiyTPdkh4FLA00bw5zfhuIWhFrnr+TUoFJXfDkNAt5ZOZlbdhszLlLH2SPv1+Yn60pkK3KWNYXLrDGuyrBIYWu2xA7+MCR8kf9Rks3LidyAhjiknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=N4LccVRh; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=N4LccVRh;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60PApuop1579748
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 25 Jan 2026 10:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769338316; bh=klYFgE3oVkA1RyWF60BFFIBtGuJQqQVnL4RYvB1c+e8=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=N4LccVRh7tut0lOiQRC8GjPbLzjaXLExjvU3jyRi4OWG2y8j8NT7i/m92Irar2Xff
	 WIb7DM82KnAjzokPiqFgNJzR8huJjpD8Zb7CswpKSOluazj6sHLsmQ7k9rR5IwNmaf
	 RubaZHAw4IuAeXqVr5UIxocTF98RlsbF0QuuUtZ0=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60PApujP3883598
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 25 Jan 2026 11:51:56 +0100
Received: (nullmailer pid 1277716 invoked by uid 1000);
	Sun, 25 Jan 2026 10:51:56 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: phy: air_en8811h: factor out
 shareable code
In-Reply-To: <af7daf2e-7a8a-4a83-902a-28c9375daea3@lunn.ch> (Andrew Lunn's
	message of "Sat, 24 Jan 2026 19:38:53 +0100")
Organization: m
References: <20260123075817.1162068-1-bjorn@mork.no>
	<20260123075817.1162068-2-bjorn@mork.no>
	<9743e516-20d1-4f73-a566-1fdd415d60a9@lunn.ch>
	<87a4y3j6hi.fsf@miraculix.mork.no>
	<af7daf2e-7a8a-4a83-902a-28c9375daea3@lunn.ch>
Date: Sun, 25 Jan 2026 11:51:56 +0100
Message-ID: <87ecnehsmr.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,makrotopia.org,nxp.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-253149-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mork.no:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mork.no:dkim]
X-Rspamd-Queue-Id: 6472C80202
X-Rspamd-Action: no action

Andrew Lunn <andrew@lunn.ch> writes:

> Maybe a different strategy. Most of read_status is generic, it appears
> just reading lpa is specific to the device. So have a generic
> read_status() function, and then use phy_id_compare() to call the
> needed device specific function.

Yes, maybe that's better.  My immediate feeling was that this
contradicted your comments on the RFC, but after rereading it I see that
it doesn't.  I was reading too much into that

I'll try and see if I can improve the readability of read_status() with
a generic function.


Bj=C3=B8rn

