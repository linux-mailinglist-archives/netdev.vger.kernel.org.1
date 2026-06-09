Return-Path: <netdev+bounces-296801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J73+KBlhJ2oavgIAu9opvQ
	(envelope-from <netdev+bounces-296801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:40:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BF565B658
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:40:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CmtSEKde;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296801-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296801-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 579903041787
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3452223ABBE;
	Tue,  9 Jun 2026 00:36:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F1231827;
	Tue,  9 Jun 2026 00:36:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965401; cv=none; b=UokchU7C+BsGo7OQVfUA7RLIH4aK7bL5SkkGfncV/Q2vnVcCh38O1Ihe6G5ct/zGS5zcpOig3d1cqUbb0B6+DA/8EigahD4TWJ9Fc3UxjyZQw4/lFlQv3N3uqmK7PnBmfpqFpriAUPyhf99tOPeiIswji6Rkbo7z11aql4tFaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965401; c=relaxed/simple;
	bh=kPUAUDRbebuuxhK+vTmu+BbAG/G9Y1jk3lUHYiR37TY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH1WwYtCBIa9xXLCwt/2H4ML0mHRhoFmfryFLT8znCuAj0G72RGh4kp9j4ABBdmv8HOUDjlgbjo2LlpcrfnDA/0/8zO065WgJWQc/pCDVVxUmcB9zcd1rMA95V3OucXVNWBDeJpbo6gM6K8NrXWWhn+iMTi79siKXlGQjpNV/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmtSEKde; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D781F00893;
	Tue,  9 Jun 2026 00:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965399;
	bh=+7gNPHTfQZb3hdNUaxuzeumP3gV621exu5pPvLDRQIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CmtSEKdexUWbSGFjcflQoKjhlC7QjC7hX8CWC4EWTgKaHL+ZsKhWhno3jTN+dmtL5
	 U1C7U15LZZEDl0Y66Hzcda3DYSLbtfDwkqqN20tAftLUZEe4gach8yzeOGEpPr0XiT
	 TljfmoExjvP19svZEukvBMjBvgW8ozXbyC2H+qctPG01RqaoRIp0o7W3PRl4BauffA
	 M8WYTK+5c3XJ88dVJRBOxwA9OR40F/CxD3Fn41HmQtnzuGee/MoJD4o6TzzPJfWIJR
	 EVXrnVBO/b1xqRyvRA0YQxRLFMj9BiU2E/PmcFFZPj8daWV3Ii0teRo5sHNGA/TLjh
	 KfnPO+9ASEmPA==
Date: Mon, 8 Jun 2026 17:36:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik
 <jeff@garzik.org>, Roland Dreier <rdreier@cisco.com>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ibm: emac: mal: fix potential system hang in
 mal_remove()
Message-ID: <20260608173638.74da73fe@kernel.org>
In-Reply-To: <CAKxU2N8oh03r2-zJhbOXF0Qqx7RzNSX=zq+i6Ld1c9YXJqDfKQ@mail.gmail.com>
References: <20260603230821.5619-1-rosenp@gmail.com>
	<f49d5ac6-ef78-4530-a420-d94e612581aa@intel.com>
	<CAKxU2N8oh03r2-zJhbOXF0Qqx7RzNSX=zq+i6Ld1c9YXJqDfKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296801-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jeff@garzik.org,m:rdreier@cisco.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6BF565B658

On Thu, 4 Jun 2026 16:03:43 -0700 Rosen Penev wrote:
> > > -     if (!list_empty(&mal->list))
> > > +     if (!list_empty(&mal->list)) {
> > > +             napi_disable(&mal->napi);
> > >               /* This is *very* bad */
> > >               WARN(1, KERN_EMERG
> > >                      "mal%d: commac list is not empty on remove!\n",
> > >                      mal->index);  
> >
> > This one doesn't make sense to me. The list_empty check does a WARN()
> > indicating that this is not supposed to happen.
> >
> > This implies that list_empty should be true, otherwise we'd see a WARN
> > every time mal_remove is called.
> >
> > But in that case, we'd have been calling napi_disable incorrectly in
> > most cases where it was previously unsafe according to your claim.
> >
> > At best, this list_empty check is the wrong way to tell if the napi is
> > disabled, at worst, this whole change is pointless.  
> I asked the AI. It doesn't agree:

FTR I agree with Jake, the patch seems to indicate bigger structural
issues. Then again I don't want to encourage the stream of patches
to this driver so let me just apply this..

