Return-Path: <netdev+bounces-286871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLaEGq9rAmqosgEAu9opvQ
	(envelope-from <netdev+bounces-286871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:52:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1197F517852
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E867F308B587
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478C3D1CCA;
	Mon, 11 May 2026 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSnaXdFN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA823D1711;
	Mon, 11 May 2026 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543323; cv=none; b=hUx8BvZ1WrOEWaWTfBIyvrv/TFICKd8Nl85jeL9gVTeUKo2Bvw7ZxGFEQOuegj6XDCaJ1FOuvnNAAgRbcb5zTGVitHC4pVxO8GAx0OF4PITNp6ye005Vv8g9FDsQLb0WQnRPoWQ2g0k2QDrOdLYQ4bojeZL2bF2lZFG3X1Qw0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543323; c=relaxed/simple;
	bh=gWx89j4UXXm2t396CgMExGu+KZuVAbEhqjkwgR181UM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYHRoAHuzpuT/zket93AB+mo3fdw/Zs8Fx9+hDStkCmUX35ebRKEZMu7/+zSiC2x0VvBYseW8sFZVzlaHWgZNTZkd72aV64zJhxij7euGwsGNc4ZhUvApWLIHIdt7Y08z34bBNXr8OW7JRWK+VtsSaW/d3ehnIjtXa2E5PW/7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSnaXdFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE1EC4AF0C;
	Mon, 11 May 2026 23:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778543323;
	bh=gWx89j4UXXm2t396CgMExGu+KZuVAbEhqjkwgR181UM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RSnaXdFNA1SR81L0q6fxX31cP0FujjsLUK0Bf6vzT8TuhwEMv0gUmJhoYie9qHFAu
	 M2U+ZqTDHw8r1X+oL59DwpDXbexrHMulXEhDC5HRI5fiB+qEt0QfVlgu6b1In6+BTD
	 8/OM2HK13ilwr8qgFB66Y7BC/w2QfQAtVieUeaaen01tg5IvIHmX1HTKjMhz+y7O1N
	 3tckIVfEfM1upFu2juJpXsct3XzVEbNpBePwqAq62RH8RJ8AG3rC5CrQ5GuwrsWAFH
	 oT2bCW4qMpgJVh9QHtZsGTF9hpG4uEJTlKvOoe11USRB5WR8RtE1T/3bEcT5rWwFXz
	 VbnUHyMds/P3Q==
Date: Mon, 11 May 2026 16:48:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, Eugenio =?UTF-8?B?UMOp?=
 =?UTF-8?B?cmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260511164841.7f7ff557@kernel.org>
In-Reply-To: <CAGxU2F6TPfRxZ7SX20vXiqDM4_sY3yUQBUSfEM=Nr+TKXwT9mA@mail.gmail.com>
References: <20260508092330.69690-1-sgarzare@redhat.com>
	<20260508055125-mutt-send-email-mst@kernel.org>
	<af2y2Fyp7H-om-ur@sgarzare-redhat>
	<20260508063104-mutt-send-email-mst@kernel.org>
	<af28MAV0LF4qHVmB@sgarzare-redhat>
	<CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
	<20260511084551-mutt-send-email-mst@kernel.org>
	<CAGxU2F6TPfRxZ7SX20vXiqDM4_sY3yUQBUSfEM=Nr+TKXwT9mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1197F517852
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286871-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 15:17:56 +0200 Stefano Garzarella wrote:
> > > Okay, I thought it over over the weekend, and I agree that this patch
> > > still doesn't solve the problem and would still result in packet loss.
> > > So, until we resolve the issue permanently, and since 059b7dbd20a6 is
> > > coming to stable, I'd like to rework this patch so that we only start
> > > dropping packets when the overhead plus the queued bytes exceeds
> > > `buf_alloc * 2`.
> > > Removing the other changes to reduce the buf_alloc advertised, but
> > > terminating the connection so that both peers are aware that something
> > > went wrong.
> > >
> > > Any objections?
> > >
> > > Stefano  
> >
> > Let's try to first fix it upstream properly please. Discuss backporting
> > later.  
> 
> Commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> queue") is already in Linus tree and will land soon on stable. Which
> issue do you see on having a patch on top of that to close the
> connection instead of losing data and breaking our test suite?
> 
> IMO we need that change in any case, because the previous code also
> discarded packets without any notification, whereas breaking the
> connection would be better in that case.

Sorry if I'm speaking out of turn or misunderstanding but, like Michael
says, let's focus on fixing this the way we want it to be fixed?
IIUC you are trying to minimize the size of the fix, please don't worry
about the LoC in the diff at this stage.

