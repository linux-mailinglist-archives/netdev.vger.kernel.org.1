Return-Path: <netdev+bounces-260659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH3YCkgXnmmcTQQAu9opvQ
	(envelope-from <netdev+bounces-260659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:25:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A931118CB4F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16978302EC94
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CB933D4F8;
	Tue, 24 Feb 2026 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KcW5ewYG"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB133B95D
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968324; cv=none; b=qP/xnMzaxQu2BbIl5Wn3swQcXPmNFlyVoUfJD1hZ7u9WVP1D5bIipxdftPlygn6CBDHcTXBjovCPlpbT3uVDhGP7GWYBA2GIxFg0X25xeT6kxinBXKcoQb3p2QauUsDNZ3SoeEWDU7h+Wk7ziFVidINBakRnctRJKSbp9Fif5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968324; c=relaxed/simple;
	bh=p9N0tg9ro3UyBcP2Fzp3R/vRzcui4PdL161SdN6uY2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXVHzH6gHuBV0yLS2p/nguFgCCmNcclkSdkT8i0W5rUdH9oNkiBRsbSgO5xF7OG1Fmoj9wy6eWM/hBO4PYkljRuqOuPQq3WAlK11XVHPpk5dq+Hfg1XpNpvtesisQXVmvxvEF6MQuCi0xrEoFzPF0Bid+eJDiuOvkAkdyxkfsqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KcW5ewYG; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260224212514ac38db24a7000207d0
        for <netdev@vger.kernel.org>;
        Tue, 24 Feb 2026 22:25:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vbehI5k0rB54bjh1f0a2umagLZ4OYrZF4eNdQQugxLw=;
 b=KcW5ewYGX3l5vf4Wblfb+Vgb1Jpva+THV2gf/O4U5sXYcTiaDI7LLIzlAwZMx9XA8avU3B
 MQLeoJMHcWwQCTYV+Lbgn3qf3lawLd9EMojyc47icVDouNXsJJbkRi9MuydVi1Y2oRAEgY9U
 W96vDkI/s4GJtRjD1v8EERcDzrnoFuR4N2bBcqEagUxqt4QDYPEVaFLMXWkTTmUInyqXA/67
 dSjuG5ywwV4GpDznI04Ak2CUpfcKMKF76RVh6CM5zU0SWApiNooKLivJ5BkfGYoQBNqrOYq9
 GSfAnJqKWOzldv8IzuXYnOj/5a/eqfGWLWyn4qc+ed3rWdHWodlyNeww==;
Message-ID: <f269adc1e366685a15622fb51740eca7168c9339.camel@siemens.com>
Subject: Re: [PATCH] igc: fix page fault in XDP TX timestamps handling
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Zdenek Bouska <zdenek.bouska@siemens.com>, Tony Nguyen	
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Richard Cochran	 <richardcochran@gmail.com>, Song Yoong Siang
 <yoong.siang.song@intel.com>,  Lai Peter Jun Ann <jun.ann.lai@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Tue, 24 Feb 2026 22:25:10 +0100
In-Reply-To: <20260224-igc-fix-xdp-tx-tstamp-pagefault-v1-1-7c729ef61ee5@siemens.com>
References: 
	<20260224-igc-fix-xdp-tx-tstamp-pagefault-v1-1-7c729ef61ee5@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260659-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[siemens.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.bezdeka@siemens.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[siemens.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:mid,siemens.com:dkim,siemens.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A931118CB4F
X-Rspamd-Action: no action

On Tue, 2026-02-24 at 13:38 +0100, Zdenek Bouska wrote:
> If an XDP application that requested TX timestamping is shutting down
> while the link of the interface in use is still up the following kernel
> splat is reported:
>=20
> [  883.803618] [   T1554] BUG: unable to handle page fault for address: f=
fffcfb6200fd008
> ...
> [  883.803650] [   T1554] Call Trace:
> [  883.803652] [   T1554]  <TASK>
> [  883.803654] [   T1554]  igc_ptp_tx_tstamp_event+0xdf/0x160 [igc]
> [  883.803660] [   T1554]  igc_tsync_interrupt+0x2d5/0x300 [igc]
> ...
>=20
> During shutdown of the TX ring the xsk_meta pointers are left behind, so
> that the IRQ handler is trying to touch them.
>=20
> This issue is now being fixed by cleaning up the stale xsk meta data on
> TX shutdown. TX timestamps on other queues remain unaffected.
>=20
> Fixes: 15fd021bc427 ("igc: Add Tx hardware timestamp request for AF_XDP z=
ero-copy packet")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>


