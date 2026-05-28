Return-Path: <netdev+bounces-292619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL2eEuIJGGoaawgAu9opvQ
	(envelope-from <netdev+bounces-292619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:24:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D60995EF88D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DA3A31077C1
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2166725782A;
	Thu, 28 May 2026 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="g0Nu1mcV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gkuKP4RU"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD43A4F4B
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959717; cv=none; b=RsuYizZAtdu+3/ES+nCwRObEwiWxL5fAMiShphtIcHosp+ww924u27yANMqETrNSy165rXea4nrDnkN0uii+R7bRbVd+jXjU8hwwXdVBwSv4FsnV4EcZtZo+0kNIUwS1bDqT4kmhrSyIeqBRMYo8wyZyU4zf6Jlo4yRZ5bc+/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959717; c=relaxed/simple;
	bh=rsKE2ntFZgsoNAYlxykrOehP1Ly+cVLd31XcodFdt3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7++jBuM5UAPQ/Wt4owGnSHHsLUy4WOdReH0Be1ui/bTqixYL4L+HS2OEdcK3oEunCuVYuhziy+H0HlqSdqzW+IV6P7ELJAh3D/wqDy3Xp9b/pKfYTZPmHhVEDvdarftB6Rrt9YVjxg27aQsMgmUKL19ikXyQVE9P9XBIUZhNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=g0Nu1mcV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gkuKP4RU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9399140015F;
	Thu, 28 May 2026 05:15:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 28 May 2026 05:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779959714; x=
	1780046114; bh=8TKMosZtoNCLawfUgM4vlnC/yxtsCh7j5xlUZtgwYJs=; b=g
	0Nu1mcV/Gov7UYaASYQMC6LFRABAM1tMc+wqUfH1XUHGhknYbRcmfONc7RbWJwkk
	W7DwX72mjX5n0PrJCt2od2tqO48wkCrW8WmgyGCAUujXYP+RfRGPwl9o1ngu1bl7
	7Toc7wBpOAnOfQnz182+lvkCwMt0c+pNtBtl2mm2aB0k2lsU6aND/kg9mu3TBRtL
	gdF3e3MOVNL/Y4msFsTTphq8vIU80WOHAdCAQspjAF7mNqCbxngDYyEnqVhGoWIp
	jqIRT35vW4hjsic37OWvb4Co7A54deYTf34qJo8TLMQNJ0efmB2cyhsQ2RPSzLkZ
	k597AcGB5e2dT7Yfu7Acg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779959714; x=1780046114; bh=8TKMosZtoNCLawfUgM4vlnC/yxtsCh7j5xl
	UZtgwYJs=; b=gkuKP4RUOICFJywd8zdocS1tmkuoVPrZpfJSfwvrzmpVvXtHKVi
	BlvimM5QQkT6apyTkDI7LcvmXE3CdayOgdBt1izAP0OapN+8cXjQEz0hsfrkNwM5
	KV96X1X68H8kYkmsHEeRnZZSf6PKtEw5QHTxHoWfIQYHSNbD2RSXPKmjqFatHg9T
	61nczh9DL1G1KPCG7Cf46SAxrcxOZEANJ9Xax1XMNc6J1cL7sQzF7dJkVlA9E0AB
	wpN/UCNTrJbpg2Rj+4OfEfsR4pwCJU/VT1nm2u2LbaDDNvljowkYa8MMm3i0PsKW
	XrGUlhY8MO91nfyGcBSrmckaKCidvr3PYZA==
X-ME-Sender: <xms:ogcYanaLyAx3tjZjLuZHcxna4ySLeobTRWBpRFGJrBOt6YdZsaJJNg>
    <xme:ogcYarUaBJHHvteZhLijl70fkW3giwgScLkr862AOWXR51mI3pSA_g3ctvNCKlCrA
    tDSB62P-Q3WSRMDGje8tia1wPn93b88TNH2TlxCbpC4sn4d7gIYfD9u>
X-ME-Received: <xmr:ogcYauMsGoXdSyhWYLopGjGzHNNz6EiagY4OjmncO3wh6tkJDtQUJ9a8dFXDCwCxh_hlXcn9BRHlnQbcqKt38M0>
X-ME-Proxy-Cause: dmFkZTFQiGLwr+by7AW6vFTILuHsMzDswvh+KiHXyxjz8ZUfe2AJ+Zj3cSAaoCZ5lcmfpc
    zC/3t6rdo8rNpbCVcuxtjkmBoJEtByJNl6MvveZagwWsZqwznrRmJgHjUY8agCSOBX20Yc
    3KRjnCM0LYoqI9FUCx/540FxaoM0UkNDCgDEnqpS5D4mIhp5QZTY6/Lf72fh1pQJV8r76H
    1kJ4b963exyCXkRR/uF63QJjcIrgCLoDmSIF68ri6Uu1TpQcHpsLLimOANsOeOKtOqSgbu
    FEVS2CmJh0hVzGJmxiyZIN7DLXbFULjZCS00hw9FQAqPKWEha1VDy4sRMDVXiMDZ0HCoUp
    LlnA1sVbWrJWdYwc14XYiCA8tIexGHMkXOL4VI13CwGf2nZ/5m4amRZ1H8k4sJZyqIEYcY
    B7tweAWhfyhQH2uRjwk/oF7kyjbQQ4c4tQyeWU0onsQhlfj51hBGOo6zW9vANOEMfqEixQ
    JDcXGvi3dn/me5l9c1FGcme7g/4+b3P0vd9lmvO3czE8fqOIqeL/71HyE4LMuMVpEq1FEt
    88+YsgbeplsmePvkYnkGG9Bnmo2E0k3Zw2Pvx1IVfpTYkRH26r7X/ysFtqOQ/a56DFpFwU
    OBZIIon8lkmiCcHYh4EE3ZfWtzStdyY8HvFvtcJsm3vob0QtPX4ZmPnkB6Fg
X-ME-Proxy: <xmx:ogcYatbEXn33Cz7_D-KrJcmcTDmCZmPQHWUvy6EzfBArf4snQWP3KA>
    <xmx:ogcYal8PgViMRXEPYvrZug9rdsGlFDkCCR742_CvdAbGY0zzYpu8vA>
    <xmx:ogcYamTMIqjVNOTVutaQkM5maOU1HrZgR66Lhb2CVAPKxBHoLdpg6Q>
    <xmx:ogcYancXSXL7h74uvdSGAdPQnX8m3AvDC1Fwq3IjfgIY_Xq5GfO-AA>
    <xmx:ogcYar_8fxZ_66awg65TMcqbG02cc6FPC6dGdayZI_ctejrJOG4L52Is>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 05:15:13 -0400 (EDT)
Date: Thu, 28 May 2026 11:15:12 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH net-next v11 5/6] tls: Suppress spurious saved_data_ready
 on all receive paths
Message-ID: <ahgHoCb5H6SO4bLg@krikkit>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
 <20260526-tls-read-sock-v11-5-244fe1dc4abd@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526-tls-read-sock-v11-5-244fe1dc4abd@oracle.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com];
	TAGGED_FROM(0.00)[bounces-292619-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D60995EF88D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-26, 10:21:35 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Each record release via tls_strp_msg_done() triggered
> tls_strp_check_rcv(), which called tls_rx_msg_ready() and
> fired saved_data_ready(). During a multi-record receive, the
> first N-1 wakeups are pure overhead: the caller is already
> running and will pick up subsequent records on the next loop
> iteration. The recvmsg and splice_read paths share this waste.
> 
> Suppress per-record notifications and emit a single one on
> reader exit. tls_rx_rec_done() releases the current record
> and parses the next without announcing; tls_strp_check_rcv()
> gains a bool announce parameter so callers can request the
> quiet form. tls_rx_reader_release() fires the deferred
> announce on exit through tls_rx_msg_maybe_announce(), an
> idempotent helper that calls saved_data_ready() only when a
> record is parsed and has not yet been announced.
> 
> To keep the final notification idempotent against records that
> the BH or the worker has already announced, tls_strparser gains
> a msg_announced bit. tls_rx_msg_maybe_announce() sets the bit
> when firing saved_data_ready(); the bit is cleared whenever
> the parsed record is wiped, by tls_strp_msg_consume() on
> consumption or by tls_strp_msg_load() when the lower socket
> loses bytes from under the parse. A second call for the same
> parsed record -- as when recvmsg() satisfies the request from
> ctx->rx_list without touching the strparser -- becomes a
> no-op.
> 
> With no remaining callers, tls_strp_msg_done() is removed.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/net/tls.h  |  5 +++++
>  net/tls/tls.h      |  5 ++---
>  net/tls/tls_main.c |  2 +-
>  net/tls/tls_strp.c | 23 ++++++++++++-----------
>  net/tls/tls_sw.c   | 27 ++++++++++++++++++++++++---
>  5 files changed, 44 insertions(+), 18 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

