Return-Path: <netdev+bounces-282018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDb8MzX68GlpbgEAu9opvQ
	(envelope-from <netdev+bounces-282018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8F548A918
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43A5830167F0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7CC302CD5;
	Tue, 28 Apr 2026 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMExvV9e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1E1A6806
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396810; cv=none; b=IV9cXrP1Crc/JzvUyXUx1WTlzfWWVd8AeHnGGOtDarKQCzzM168Ri8ySlJ1iEw/aNWgQ1ExDFp3kMTZrsjgVrYNfOil9StYE3N8BWw68UUU9ztN7HRKIVrOV4w4QwL95Ls7Z267eKPeboyt8MLN1QtQxl8Q2PY3akbtHHikELi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396810; c=relaxed/simple;
	bh=Phd04HZU3Y05e6ClnsJJdAzLpHXNbEddER5w54uzO2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMcGGTJfd1L/9VXpFQD2EPTMut1K93an9dfBeJfLhSBZyRfR+fdf2mrcj3gMvA0K8JbvPWUmkd3dikbRj1qwrdqIt5S150C2WSZsL3kux80Xcg/g4+R4/2vA2AiDdYtgMn31gfgxgjOymJrMbWYW1UCEGC9kUklZkEtT7aL/yxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMExvV9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC57C2BCAF;
	Tue, 28 Apr 2026 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777396810;
	bh=Phd04HZU3Y05e6ClnsJJdAzLpHXNbEddER5w54uzO2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YMExvV9e56IEJHPJz4fqXE+b6iFpjG9AOGBCrIo2MCQ0cYeHu39l3T+bHO9dgDC1+
	 8JctGz9zj3/3Ie1GXbSZ0ZqizkiuYef10H6PJYUey7SdccN5Y3jFlb5+XMJ7drC0AL
	 A05YfvWS9r6IUEaUDinNkSs0Udzy4KDD7nbdlpgGb/Dz61bPCHVUUIwQK8zmW3pC3r
	 mFNRAodYKgHLznIP3C/Z+c0b//e4l10ltQE3sd0ufAdkrtkj1vrGN/SjNqvp9/aZSP
	 9xh6f7ActO/jnFTNCU2ooCRtyBrLstw0o5esBfy8VUntV2trwvZTto2mbsI+4lVGN2
	 bJcpO9JkAplFA==
Date: Tue, 28 Apr 2026 10:20:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 4/4] net/sched: speedup tc_dump_qdisc() when
 tcm_ifindex is provided
Message-ID: <20260428102008.6f3aa32c@kernel.org>
In-Reply-To: <CANn89iJ4MjaQP047jWFBquLd+ed-QfEOx3fUMUTdw328NOHc9Q@mail.gmail.com>
References: <20260427132555.1791636-1-edumazet@google.com>
	<20260427132555.1791636-5-edumazet@google.com>
	<20260427161830.78193ed9@kernel.org>
	<CANn89iJ4MjaQP047jWFBquLd+ed-QfEOx3fUMUTdw328NOHc9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BE8F548A918
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282018-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 08:40:52 -0700 Eric Dumazet wrote:
> > On Mon, 27 Apr 2026 13:25:55 +0000 Eric Dumazet wrote:  
> > >  static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
> > >  {
> > >       const struct nlmsghdr *nlh = cb->nlh;
> > > +     const struct tcmsg *tcm = nlmsg_data(nlh);  
> >
> > nit: breaks reverse xmas tree
> >
> > I added this tcm assignment after parsing:
> >
> >         err = nlmsg_parse_deprecated(nlh, sizeof(struct tcmsg), tca, TCA_MAX,
> >                                      rtm_tca_policy, cb->extack);
> >         if (err < 0)
> >                 return err;
> > +       tcm = nlmsg_data(nlh);
> >
> > because nlmsg_parse validates the struct is in range of skb->len  
> 
> Note tc_get_qdisc() and tc_ctl_tclass() use tcm = nlmsg_data(n) before
> validation.
> 
> Do they need to be changed?

To be clear - I just mean that as a coding nit pick.
I seem to recall that some AI was flagging this as a bug, it's not
really a bug. But if we're touching the code I think it's easier to
everyone to follow if the nlmsg_data() is after the validation.

