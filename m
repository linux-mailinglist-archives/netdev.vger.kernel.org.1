Return-Path: <netdev+bounces-283304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F77GC439WkeJgIAu9opvQ
	(envelope-from <netdev+bounces-283304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:28:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C14B04BE
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E056C3021D35
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 23:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5D737E31E;
	Fri,  1 May 2026 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHQaqI1a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEC32F12AD;
	Fri,  1 May 2026 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678081; cv=none; b=Y4YICpFGqRNNBLI5k4KQbfZ1v01vicXDqSGC+ZEGRSaQTULduEatnYERopoVYQYCoWrGTKH2iCDS05CldVOS/ll7zRukTKemlsHNKuW6awOPhgCbrTF0B2zZgShENWJTv9IZ9wjQPljfJsok6oWo2QDMvSdDFBV2V6+AaH2IhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678081; c=relaxed/simple;
	bh=Lu2YesTtENkzb7PS69NViHQTAO604Jo2CPUPu31t4rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g296Y+n4ibznOCl8epl8Ckel4z8A8CectTZI3hqn+WrfNqnjgqhLmYpDYZT4wJZbj1RjXjBFSY0zkGjfsO7CFD8KPVC6fJsGSThfBL9IcIvVqaAS0zPVD3C/hiZfpPATMa155WaB/A85TR6+UlEng0c2DJAAXjlIAPC6QRUe+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHQaqI1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837F7C2BCB4;
	Fri,  1 May 2026 23:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678081;
	bh=Lu2YesTtENkzb7PS69NViHQTAO604Jo2CPUPu31t4rQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHQaqI1abVncCLShjh0gpmQCu61zLuuCICYOPDvvwK6sGHB+9FvFt5TSIxv8O+5aE
	 mt9It4uf7EPD9jAg8pF6I5NjRtkeCL4dDh+B+0PoAZmlCMNQO/FRuirdtJ6y+z8jNC
	 kwRo81DT5HAcBTw2PZ9pafUeZ4KnbSkVc7HKweRXG5WwlkR1enbwX04naE7SgDsDwj
	 p0YNtOqWPwlTnizu2HfXR+s/vhX1sQwG5Cd79yEKeQktcZeZ8KMYxT19y1Ci1vcNv1
	 NjJYBiEK6ZjLbhE1nfMgQsj+lzkJWMbn6tz/SlaZY+A1D0k7bRyrWV2p2VT2J9IhPz
	 Utg3fFBE9y2yQ==
Date: Fri, 1 May 2026 16:27:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Jones <lee@kernel.org>, David Heidelberg <david+nfc@ixit.cz>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook
 <kees@kernel.org>, Junxi Qian <qjx1298677004@gmail.com>, Ingo Molnar
 <mingo@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nfc: llcp: Fix use-after-free in
 llcp_sock_release()
Message-ID: <20260501162759.06ef164b@kernel.org>
In-Reply-To: <20260429134115.3558604-1-lee@kernel.org>
References: <20260429134115.3558604-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 198C14B04BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283304-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,gmail.com,linux.intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 13:40:41 +0000 Lee Jones wrote:
> llcp_sock_release() unconditionally unlinks the socket from the local
> sockets list.  However, if the socket is still in connecting state, it
> is on the connecting list.
> 
> Fix this by checking the socket state and unlinking from the correct list.
> 
> Fixes: b4011239a08e ("NFC: llcp: Fix non blocking sockets connections")
> Signed-off-by: Lee Jones <lee@kernel.org>

Adding David H and dropping from netdev's patchwork..

