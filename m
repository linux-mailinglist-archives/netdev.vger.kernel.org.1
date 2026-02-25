Return-Path: <netdev+bounces-260888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEArB/jYnmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:11:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75282196494
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD473012C62
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097063939AA;
	Wed, 25 Feb 2026 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IBktAHMd"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B7284682
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017866; cv=none; b=YzTxwju0cfQqZTNMONj3zI0GhKNtKcOZjPAS8RI174pwxwKnB2MSLkDHst/6nEMwJOyt6suH3ijnDVc63oHK0ij6WLav2zWS++22FNef4287+c/1Uh5GePe0mQSuaxWDOB+879VSabEgyVVlrcxklarDYo7peG5dYOmzD9EjADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017866; c=relaxed/simple;
	bh=EbYZckyTUpRdw1Kb/+WXutbwzQab58VCt2lVfCH9L94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YogDen5W8dBsZUl3rtu2wegVcfsd6y5mEcjG19sLGkkNRb55DC55mJobagr3dakBB3+M47j9pTxirw4n5n1UzUBV8+5vuyFco+z+qkFtRsY4FqX7vfHB8EVNIOUwmBnZRoKOPMGWtobyZIMcOAzlHVa/hugFRXTvbaMa6SYiZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IBktAHMd; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202602251110599f1e27af5400020761
        for <netdev@vger.kernel.org>;
        Wed, 25 Feb 2026 12:10:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Asc7os5XgEttj+QqFfI9VdSfR3d7ytYJwpk2iQbc3GQ=;
 b=IBktAHMdRTU6V+8xrzNUCbSLyz2pcjARd1g51+nrvqYOdAqTA5KuLrcC6RTKX814EhQ6pD
 98zkHaHWDzqmtcyXuEszOgWJwZdaq/f4WH95f2I+pem0PFeOFRWBH63YazXLYrijQBBkQL/E
 I8RTxLQUTSl6qUV3LxLCci+1NJ5vjjufACcZtO9/87kbP68/W4v687xlC/PrtWk0VkEmjFkR
 CDX8RaFHnNo8P3jvEbhIej0nKleAyrQrsAykTPwfmIe7Gj/p9YMO581U0gBwwnqB9Ex3jUyw
 fkIzJIEpP9kbDMla0Xu05DrrRjJk6DGWhE9OXG2qmzU0kLCyXssSJT2g==;
Message-ID: <f4232af291e742d0d0a110bbf6934ebdf490e153.camel@siemens.com>
Subject: Re: [PATCH v2] igc: fix page fault in XDP TX timestamps handling
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
Date: Wed, 25 Feb 2026 12:10:58 +0100
In-Reply-To: <20260225-igc-fix-xdp-tx-tstamp-pagefault-v2-1-bf797ec20f3b@siemens.com>
References: 
	<20260225-igc-fix-xdp-tx-tstamp-pagefault-v2-1-bf797ec20f3b@siemens.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260888-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:mid,siemens.com:dkim,siemens.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75282196494
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 10:58 +0100, Zdenek Bouska wrote:
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
> ---
> Changes in v2:
> - Moved 'adapter' variable declaration into the if block (Vinicius)
> - Link to v1: https://lore.kernel.org/r/20260224-igc-fix-xdp-tx-tstamp-pa=
gefault-v1-1-7c729ef61ee5@siemens.com
> ---

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

