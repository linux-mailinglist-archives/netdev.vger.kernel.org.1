Return-Path: <netdev+bounces-292893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OQ3IK/QGGqunggAu9opvQ
	(envelope-from <netdev+bounces-292893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:33:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0B75FB712
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2B683019BA6
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A8A2D9797;
	Thu, 28 May 2026 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn7H1iMc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6BF1DBB3A;
	Thu, 28 May 2026 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010943; cv=none; b=efqxnyaTYs4HlXaX1SikqmvlDKM3MtMFAjX3jaGcLoxbVktr+4S0LFs1gg/mcyiNet6Yonw7KfKRIfuhxU79pQWTauqCJu7CA7vgAEj5vOlm/J0KeZn3Auoo02IZO9nmY93ItVYF7s1D1tkenxksX6mPAuf3zIKm/HkYzh5Gk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010943; c=relaxed/simple;
	bh=JiC2ZXR5o5RuRvWtBMIhBz8Bt7AysbRI+tZGiWA+qEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liptk5FQWAQE+r5ZuzvYng2Ln/freH76SSyMbQilEwSNRTv10KSEqW2Lf5SB8O0DczN9Bvom+F0Ld8yDgT9eTBw0QDXZeb+rd4GYpVTIJ+DK36YGTGXo5TfPHD4wOGzbU31HtVUaiRtMRYTtSQAhZobdVhI4kQS94H4KbjhHzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn7H1iMc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C891F000E9;
	Thu, 28 May 2026 23:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010942;
	bh=TSbbAi6AxwOZw7EN9L734+yNxSco5cVfngQEMKLubdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dn7H1iMcOsAK3rg/m1++i0NJ2OQbnjlXCfN0qBBgfFapxteFR/xKZYhbyme+bAsSp
	 2AzFYYeEo4/nchah0qH3YzyY6sJkV6ok6XOzcqiuc1MCp+mp2begLQ+6H/FKX77Qlc
	 C1CkZWI+D7jFWwjJQ+BwdAN4ie78346lNCjWsV//srxxyKhQV75dkDh0TCd8Lw9ATW
	 zK1jKI5Lkbkn5rKtbhIVYMKnT5ISIvFkyfq+Vvyhm4IioNXINB5efpuNxXVqgGTLTO
	 FTzuTNiRUlHpaGOXb+z7H+HvHV6OXSvbuLf80qMWsvV0Jg1MDA3i+6pE+eAICPiW2Z
	 Mc+a2wP6zm1Pw==
Date: Thu, 28 May 2026 16:29:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
 eparis@redhat.com, edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout
 expiry
Message-ID: <20260528162901.2d68e2e0@kernel.org>
In-Reply-To: <2143396.Jadu78ljVU@x2>
References: <20260513172443.1128496-1-rrobaina@redhat.com>
	<CAABTaaC98dqM8U-7xkdW=b=50UKu0SQyBO629LDdphQ9DC=P=g@mail.gmail.com>
	<20260527152936.001d5d28@kernel.org>
	<2143396.Jadu78ljVU@x2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292893-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EC0B75FB712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 18:40:44 -0400 Steve Grubb wrote:
> > > (3) A new NETLINK_F_RECV_NO_ENOBUFS socket flag doesn't exist in stable
> > > kernels where this bug is actively impacting users  
> > 
> > Which commit are you referring to? Isn't that flag itself ancient?  
> 
> You're right, it is. I see how this flag would fix the pathological behavior 
> that was reported. But as I have looked at this suggestion, there seems to be 
> one wrinkle. User space should not need to know that the audit code in the 
> kernel has this retry mechanism. 

It's not about the retry mechanism, at least in my mind - I read 
your reply as "user space should not know that there was congestion".
Why? It's not very useful, I get that, but user space can just clear
the congestion signal and keep going.

> It seems like the audit subsystem should set the flag on auditd's
> socket at registration time in auditd_set(). The kernel is the right
> place for this because it's the kernel that manages the retry/ hold
> queues and sets the sk_sndtimeo that triggers the overrun path -
> auditd has no knowledge of these internals.

We have to carry this code somewhere, either in user space or in 
the kernel. I'd prefer not to carry it in the kernel.

