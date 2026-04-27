Return-Path: <netdev+bounces-281531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kECRFiPr72lEHwEAu9opvQ
	(envelope-from <netdev+bounces-281531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:02:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA9B47BAD2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13E9F30075E7
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD543AE1BB;
	Mon, 27 Apr 2026 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp2LGnCQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0203845BD
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330967; cv=none; b=UHtMatlK0Z/IFzwkr39E+hXBoq61TID3bBX8rfknqZteTr0lsaarF/+jT1/Fxu+ag0x3O8UALDHXwbfWyJ8oUh8tbB11rHnmUT9pkHzJpLVilAJ27a15DOCkDvUkHm3dwnUbRVYxIObntBu7R3B5021uOZFpxogfnVGDI/Qpljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330967; c=relaxed/simple;
	bh=Txchng0uY3okUD5Nq3Y0b9qGMUL4NLtNd6uafhQ9MSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnQW115nUxYRQSYJHQr9Yb/hBIuJTuKe2IQxi0LiAblMPJjM/yLKnvCsgtZlMC3x4wlpO+jZ6UkrG2HrK7A7XixU3wp2nmKfXGqlHFmkJzhL4n97hEvdUwgcFUe9srPW7VNFApcv404R6TRo+fQa8J0ek6irINP1dGoUofTv/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp2LGnCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E73C19425;
	Mon, 27 Apr 2026 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777330966;
	bh=Txchng0uY3okUD5Nq3Y0b9qGMUL4NLtNd6uafhQ9MSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lp2LGnCQDJh41XQhwo3B0sDT0yMiNB9FVM6ri9Fe7VMG/iU9mWlQm0svsKIH40yAu
	 y+0xw9XaoU28455y0xnjW+22PZES3A07FP7DCRrhTWMbfJmUPvou+U2wIxnVL2MH1A
	 lxYtGUxbFWl1bAKLE7Muxrs7hnlTatJdeDyaxDycWGasvMxCfZDaqSMG2cDGplSwzY
	 +ctld+xi/m/N9QYQ3DaaKbxO2aAnM2T5Qqo2Ur8pqLNw+1hwDDQlE9hN1X5481HfSk
	 VesJsMbjRm1UWIy6WLmi8/vrfRLb5qrhQbWnNVjKwHnPE7p+dUyRSuRiV6QFqtFtPp
	 BOCOY/LDufFjw==
Date: Mon, 27 Apr 2026 16:02:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 0/4] net/sched: tc_dump_qdisc() optimizations
Message-ID: <20260427160245.11dea0a5@kernel.org>
In-Reply-To: <20260427132555.1791636-1-edumazet@google.com>
References: <20260427132555.1791636-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CFA9B47BAD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281531-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 13:25:51 +0000 Eric Dumazet wrote:
> Before converting tc_dump_qdisc() to RCU, we make the following changes:
> 
> - Use for_each_netdev_dump() instead of for_each_netdev()
> 
> - Only dump qdiscs of a single device at user space request.

Hah, what are the chances, I've been sitting on something like patch 4
since Apr 15th..

