Return-Path: <netdev+bounces-284740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLvnK9v3+mmlUwMAu9opvQ
	(envelope-from <netdev+bounces-284740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:12:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1908D4D7AFA
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF98B3054FE6
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8325F3E315F;
	Wed,  6 May 2026 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKHoLV5J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1313E2779;
	Wed,  6 May 2026 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055111; cv=none; b=muPhe7S19bKC4eDTzEifrvvwNUh12dTtgrKhg/RFB+duwxRKDcviSc582Ud5pBzI/V3b+ezF8/bynY03tRHOjzcEff4+ZeVTwqL859T44XktUKPdpFuyPVfIBD2ISKwwtjsXcSCUbEc2vruAO8ihNHjP+aLj7AaJ1Tfm8kl5mb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055111; c=relaxed/simple;
	bh=j3fnrLvGTp6RctkwUexfBhv7NHZhB5KQ2/b1bV9jJ4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI5hKDwXFZHvWRIuxWtGO24/VYVKc91tTa/qv6YaWa0/2MbLKKG/IrXsu1yzJVuXY3ZPwpSEbvy3uVr5HOWsTlC/7WhBrptawmoYohHIv8eKDC7cd47aoNlBOjfMSVVz43QO2dwq0vuEBD/XgmK8IeU+ZFGSL5i30TVgSw4gQDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKHoLV5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73699C4AF09;
	Wed,  6 May 2026 08:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778055111;
	bh=j3fnrLvGTp6RctkwUexfBhv7NHZhB5KQ2/b1bV9jJ4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKHoLV5JmOyVnyBEYEGFp0XfSFL/C897jBp1vnjIdMizX+t8lxxPusPUqRNLDMqcT
	 tJAi87Y3fcly6C6vpgxuZlhsrUErQvM7OR1RnE3XijTbbtLJc/ViiQ5fqQ7pgccxi9
	 ladnYkVL3EfhXC2qRLrbihPU6z5FuyiaNMAyBGAtZMcvpfK+q/KJLUBR8GhnFQZytn
	 +mm30/SRACHDibXGjPPZRXjnlSoVI8M+yXeg6TlBTQAns8TEDJnasKY0ZxAkvw1Cbb
	 rc7DGuUrwgyGNWOL0OFS7xv1KQNwnPovKnmelp1olqMMheLYHqIJWxXIXcQhmZCvL3
	 Qy1VfqoyJJKCQ==
Date: Wed, 6 May 2026 09:11:45 +0100
From: Lee Jones <lee@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Heidelberg <david+nfc@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
	Junxi Qian <qjx1298677004@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nfc: llcp: Fix use-after-free in llcp_sock_release()
Message-ID: <20260506081145.GA305027@google.com>
References: <20260429134115.3558604-1-lee@kernel.org>
 <20260501162759.06ef164b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501162759.06ef164b@kernel.org>
X-Rspamd-Queue-Id: 1908D4D7AFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284740-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ixit.cz,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,linux.intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,nfc];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, 01 May 2026, Jakub Kicinski wrote:

> On Wed, 29 Apr 2026 13:40:41 +0000 Lee Jones wrote:
> > llcp_sock_release() unconditionally unlinks the socket from the local
> > sockets list.  However, if the socket is still in connecting state, it
> > is on the connecting list.
> > 
> > Fix this by checking the socket state and unlinking from the correct list.
> > 
> > Fixes: b4011239a08e ("NFC: llcp: Fix non blocking sockets connections")
> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> Adding David H and dropping from netdev's patchwork..

Is anyone looking at these please?

These are pretty important.

-- 
Lee Jones

