Return-Path: <netdev+bounces-253953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HKHD0PzeGmGuAEAu9opvQ
	(envelope-from <netdev+bounces-253953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:17:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF1C985E1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F31330517ED
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77B28C874;
	Tue, 27 Jan 2026 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQw1gluR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4001AC44D
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534157; cv=none; b=gdk5XaONlJaEqPLA2NMcZOqiMnKoEMuvyDmfHkr4eGWQRjI7Mgpwp8WtXUrN09ZbSGJ8A87MCIjiUeOc41pr2YHOZKDPZw39Yq99P8KOzrPH9Hh/k0mv/FycwfWhhDFqjLfkw4GqUnj37irSMwe/fKrshN6kjJ49j/2rWoY4xEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534157; c=relaxed/simple;
	bh=XrARRcInRBz966ra6bqqa7zNSjmFxAULR2fkEa7Q5GE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3wtTIFkh3tpOYVGoB2y7AEDgCkODrVAZ04wYalGjK6Z/70wb43n9364yT7H1W7fNB32g9McByivsJgxJCxSJTB9g1S+Gfj4fRXbuV9pVfHQ6ui/otQKoty0Klko6ics3e5g6tHqYb8WyMTfHkTP74uF0gU8LKhCblsAkBM1Cko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQw1gluR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA00C116C6;
	Tue, 27 Jan 2026 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769534157;
	bh=XrARRcInRBz966ra6bqqa7zNSjmFxAULR2fkEa7Q5GE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lQw1gluRZqMBUQeFXCKweHeZ6SvfkPPR8bHFwpInpvIcFnmsTOxebebGsLgkwhegm
	 0MB8yGEpHaSmZRkbyz9SZiceSWmj8aWAhrtW+rPdJ9Ysq6KrT/7Ot/eE+y8y0teymJ
	 6jTusJf3ofSjh05qD+URhjVEbpLxsl62YQVBkUqVkVh78l5I0Xdgg5DzsgugvHaU6h
	 KyEp2doIWxQzB+x/wDh/UDsm4QfJt9bL4vQLwkTxGgNSzisbHYzAB+Og8AObvBj5il
	 n0bsoYPow41ow4jKgpw/5gWUWoRdqKsKHVaUGmT0l85euVST0uEfm4yvggVEnFbqd/
	 31lUALfvSyAcA==
Date: Tue, 27 Jan 2026 09:15:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [Patch net v8 0/9] netem: Fix skb duplication logic and prevent
 infinite loops
Message-ID: <20260127091556.052604cd@kernel.org>
In-Reply-To: <CAM0EoMn=bx-AMR0RbFmSj8MjWTxLtB_xo5419AW18paZ9r1wDQ@mail.gmail.com>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
	<CAM0EoMn=bx-AMR0RbFmSj8MjWTxLtB_xo5419AW18paZ9r1wDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253953-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[mojatatu.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADF1C985E1
X-Rspamd-Action: no action

On Sun, 18 Jan 2026 10:07:37 -0500 Jamal Hadi Salim wrote:
> On Sun, Jan 18, 2026 at 1:16=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:
> > This patchset fixes the infinite loops due to duplication in netem, the
> > real root cause of this problem is enqueuing to the root qdisc, which is
> > now changed to enqueuing to the same qdisc. This is more reasonable,
> > more intuitive from users' perspective, less error-prone and more elega=
nt
> > from kernel developers' perspective.
> >
> > Please see more details in patch 4/9 which contains two pages of detail=
ed
> > explanation including why it is safe and better.
> >
> > This reverts the offending commits from William which clearly broke
> > mq+netem use cases, as reported by two users.
> >
> > All the TC test cases pass with this patchset.
> > =20
>=20
> These patches should not be considered for any review because they are
> not following the rules that are set for the community. The rules,
> which are well documented, state that you must cc all stakeholders.
> When someone does this _on purpose_ such as Cong, some accountability
> needs to be imposed. I would say totally ignoring these patches is one
> option. Otherwise anyone can just throw a tantrum and decide those
> rules dont apply to them. Either that or we modify the rules to state
> it is ok to do this..

We (the netdev maintainers) had a chat off list and concluded that it'd
be great if we (the two of you and one maintainer) met over VC. Either
technical solution is fine, but we want to make sure there's no ongoing
animosity. No agenda for the meeting, just want to make sure you can
have a friendly chat. We can talk about the weather, AI code reviews or
everyone's favorite animals. At the end of the meeting we can either
decide or flip a coin.

