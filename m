Return-Path: <netdev+bounces-260716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOgSG81XnmkjUwQAu9opvQ
	(envelope-from <netdev+bounces-260716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:00:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3641905F6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA20330FE1DC
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFE725A642;
	Wed, 25 Feb 2026 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGUX00rF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A153256C6C
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984770; cv=none; b=bJxP+/XkaDKwPizpaCLBJMWFqkKWxInAfW1CmC9O0shofi92RnIY05NRCxjw4WKC+ajdMzfxsBrsr17hOSdIcKkT1obNyixFri8/74u3VzWDT+5FQcX80n9UPyjP5E5AruUBzMe+kTbcAB8gxZloAh+x8ObO2NKBxB+70NrXYjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984770; c=relaxed/simple;
	bh=mpBZ/jHH1XAOVWngsdWnzLBHwuFwXRBwp3U6v071b+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhLSwijkcAgpe+dYSH1rCpaOa/KpL69GzKqo5rhG0Wh+OpCdV6LQz2lo5Voi5eNt4EFmXhy5XEw3mpnj8HoQDVP45hHfXz/mSBSBY+YgK5kH+GtnB+lpx1EUx8Zzo7QXFmbIFTM8ZjOSBWfabx6tANnMwpawRkQbgiTPMEKBx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGUX00rF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF61C116D0;
	Wed, 25 Feb 2026 01:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984770;
	bh=mpBZ/jHH1XAOVWngsdWnzLBHwuFwXRBwp3U6v071b+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tGUX00rFcwj+CQ1x0ipZeDTZqDHuTtHPKHrROrDiAmmQQuCE5KSevD1BSr4/OgkB4
	 CWdbxfzRU8+jwNdpJ8Z5++Z5p+iwsfOvnioogFbeiz2g3ynJyZk5zyFIAIKQp0mhuD
	 8Hg9AgSShE0SsJ/gNLmytWavN1okaU94Z3Qww/YopfJRTW89ClrVJH/mcz79EIKgSZ
	 RJBOnaBf4s0anuX+pCrYlfC0oy/TuX7f0gWHeA/q3/9DcBWJhtXYoWdWiJmFeHRKg/
	 srGAouL4CcQijZFlpmOFE3mDDdmqnZ2qwDFFHE14tvRqux4+P0GwL5pzpIPn7cB5Ig
	 44dRwytf8PgBw==
Date: Tue, 24 Feb 2026 17:59:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 netdev@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net] net: fs_enet: add missing kfree in _remove
Message-ID: <20260224175928.3d16350b@kernel.org>
In-Reply-To: <CAKxU2N8pedieviayis9CoRtm7z0S2C_f-pC1N0uoU0--4cXFSA@mail.gmail.com>
References: <20260224015517.354145-1-rosenp@gmail.com>
	<027d191f-f04e-4ead-a9b8-a6626e0828c1@kernel.org>
	<CAKxU2N8pedieviayis9CoRtm7z0S2C_f-pC1N0uoU0--4cXFSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-260716-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC3641905F6
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 14:24:53 -0800 Rosen Penev wrote:
> > Le 24/02/2026 =C3=A0 02:55, Rosen Penev a =C3=A9crit : =20
> > > The kfree is present in _probe on failure but not in remove. =20
> >
> > Which kfree ? Which structure ? =20
> probe has
>=20
> out_free_bd:
>         fep->ops->free_bd(ndev);
> out_cleanup_data:
>         fep->ops->cleanup_data(ndev);
> out_phylink:
>         phylink_destroy(fep->phylink);
> out_free_dev:
>         free_netdev(ndev);
> out_free_fpi:
>         kfree(fpi);

This says fpi, not fep. Which is what Christophe was telling you.

Please add a Fixes tag when you send v2

