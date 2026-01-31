Return-Path: <netdev+bounces-255547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJGMCBCUfml6awIAu9opvQ
	(envelope-from <netdev+bounces-255547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:45:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1260C4647
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6E13300DD48
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB94F366047;
	Sat, 31 Jan 2026 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7f9NRuC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7231D367;
	Sat, 31 Jan 2026 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769903117; cv=none; b=ELWoYoA18xtIu//zkAuykTuXZfYY2AcvZTN7rLmouOcPvjdz6WVzbDUOVDsw4eZ1NSso36TlUuz/tjODNdyujL5ls4u8czor1UjiA2dwICINRZSeou5ODMxU8Ze/cf4VHyvbT1v8it2KoDC6GZ2P7CEfD/W2v40t+SjQ96txxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769903117; c=relaxed/simple;
	bh=BPDW8aVKg3FkNVU2P9Na9+6xiPACjmBo5yxVmpnge0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSOR6T9QYko+aS3JUxZz6FSQMak7EBDUPF1R9xynKoozfZZt4r/7lbvM2fU/q6stU6rsR7FIg8Lw1Tq7BiSAnqq+mSRr+5hpe0tVnSW5tRUiOf+W24h+NA1xYOrTKeGXnN1zqX4+fqGX6FvGKfo+1mpet1Gn9DF1f+ft+ScYvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7f9NRuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DEDC4CEF1;
	Sat, 31 Jan 2026 23:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769903117;
	bh=BPDW8aVKg3FkNVU2P9Na9+6xiPACjmBo5yxVmpnge0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c7f9NRuCMX3CHu74FvDTLBgO1OMsm81aPaqUXX9bY+C0TFF7TUZGVrIlFxBIydVPA
	 cPckaBVrNmsXIjB8+bL+PmyQiA1xpVFnoLG+px+0RTMwBAuNu4EBbA9U3bVVsvCAg8
	 /VznavKcMbF2TRhJzsGdCoPdfd/kQ1Im/ikPIrjxp2Ly60wBkTmofpP/nM5DPOAdpf
	 QfF8silwF9MdhxOZAv4Kr+I/xuT+mcQdlC9y2+LqZqs7jIQO+kbGsSPVX4MAe0bob7
	 MKMggK420hcuJugHm4zV3QVuLL26qsorIBNjNmKOpysoiknr1PUAkF8t34dOZUB6Sc
	 KIlvOCW1j+mJA==
Date: Sat, 31 Jan 2026 15:45:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 04/16] net, ethtool: Disallow leased real
 rxqs to be resized
Message-ID: <20260131154515.51872b38@kernel.org>
In-Reply-To: <20260129222830.439687-5-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-5-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-255547-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1260C4647
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 23:28:18 +0100 Daniel Borkmann wrote:
> Similar to AF_XDP, do not allow queues in a physical netdev to be
> resized by ethtool -L when they are leased.

I'd be tempted to factor the addition of netdev_queue_busy() out and
get it merged quickly so that we can make this series smaller and more
focused.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

