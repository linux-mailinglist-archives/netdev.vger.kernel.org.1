Return-Path: <netdev+bounces-254998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFkmLR8dfGmAKgIAu9opvQ
	(envelope-from <netdev+bounces-254998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:53:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74962B6996
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFFCB3027030
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0842F99AE;
	Fri, 30 Jan 2026 02:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKS9c7U7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2514F112
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741481; cv=none; b=U/yZpw7BodtK7247OJdupZKEZiPQPR+u8/8zzNPjgAol4gaK0H1VesvYxNDFnoViS/yeZR9sRlUBIk6d6viiyVhzEHPv3XpM9D8l2X+roYERjX8kZ6WvaLpF1LHtR2xkKahX2/r0QhuzRYkbyu8jBhMz1HAPcMM9QVa0WMIF1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741481; c=relaxed/simple;
	bh=G7a2+KX8gi+XnUPSclgmLiRQqwuiiDPInWJzWgiFJgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HERlCCOBsWqB+BkUrOVOgiZ2iZdqPPPEmnqurq9LxGtPotbOtkF0JzWLhiTcnyex+HCTA4VOHza4uaYHIPSmD5AFCEFU/+lPlctKuGJeAixQFTEY08KORyiIP1zgBAh0WaLTp8UPWG00Pym7WZzMIQ03vXDtIQQBZavkzxEb9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKS9c7U7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74619C4CEF7;
	Fri, 30 Jan 2026 02:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741480;
	bh=G7a2+KX8gi+XnUPSclgmLiRQqwuiiDPInWJzWgiFJgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PKS9c7U7Q02gL359rOtq6v6MpIHksHKg38IoWkfmkglMePZh83ula373I2m0ZD9hZ
	 pclQrfpQXUhAVnfFbci2vlH0Wi1pZQw7QrePitj+FloXfccZzALIrjsE/NN1r6wy9z
	 rv0q4hHYQTjdJ03dT4L1X/RdFaonU14NxAghHHdT7pZUYSAqZ97PvCS/KLyQH1W+Ld
	 c0Z7KolXgqkzLV5bc6XZxjVoCQPLtP1okxcfxpVIpg7gzEhJiF0d3dkPCBWlA5qxnG
	 BA9+l6gxMuzgLIKfikrREfTvd9nMMymaTWk3EWeSHzWUgyUIA4iauPGS5jbba8E7di
	 tY+tZRKJ8KVvw==
Date: Thu, 29 Jan 2026 18:51:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, asml.silence@gmail.com
Subject: Re: [PATCH net-next] eth: bnxt: make sure we populate the qcfg
 defaults on old FW/HW
Message-ID: <20260129185119.3182f59a@kernel.org>
In-Reply-To: <CACKFLi=bzz+HcTGO+fKXEwpxPMN_9fYndmFDnKfBqcKC1RnQDg@mail.gmail.com>
References: <20260128193258.125274-1-kuba@kernel.org>
	<20260129182332.040411b5@kernel.org>
	<CACKFLi=bzz+HcTGO+fKXEwpxPMN_9fYndmFDnKfBqcKC1RnQDg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254998-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74962B6996
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 18:36:07 -0800 Michael Chan wrote:
> On Thu, Jan 29, 2026 at 6:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 28 Jan 2026 11:32:58 -0800 Jakub Kicinski wrote: =20
> > > The driver now depends on the core to tell it what the rx page size
> > > should be for the agg ring. We must populate the ndo_default_qcfg
> > > callback even if we don't support any queue ops.
> > >
> > > This fixes:
> > >   Oops: divide error: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
> > >   RIP: 0010:bnxt_alloc_rx_page_pool (drivers/net/ethernet/broadcom/bn=
xt/bnxt.c:3852)
> > >
> > > with fw version 225.1.109.0.
> > >
> > > Link: https://lore.kernel.org/20250421222827.283737-20-kuba@kernel.org
> > > Fixes: f96e1b35779e ("eth: bnxt: support qcfg provided rx page size")
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org> =20
> >
> > Can I get an ack here? This prevents machines from booting so
> > it'd be great to fix before too many people waste their time. =20
>=20
> Yes, it looks good to me.  Thanks.
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

Thank you!

