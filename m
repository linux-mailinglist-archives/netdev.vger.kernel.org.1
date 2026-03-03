Return-Path: <netdev+bounces-262981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO7dFWg8pmmpMwAAu9opvQ
	(envelope-from <netdev+bounces-262981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:42:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C711E7C42
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4214D303674A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00161F1534;
	Tue,  3 Mar 2026 01:41:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3FA373BE4
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502117; cv=none; b=rUy+P4ubemJWvKUaup5Lu3bdpo9smBra1M8VKj+KpIpRI7rMvIeVFxOl3ndilef9GHJtgLWevGaW4xfJDVQhqp9E7eof+mXko9SSY08/7wynAlmCXjla78q2Bkd9+Q1XwtZiSVlyosWR+t+OB0a8wqemKTTrJfyrA7lwCMrd9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502117; c=relaxed/simple;
	bh=TPaqrDNCQk9XGqNEyBhzUJhNXYzsVJB5kKUPv1Nf+Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdmW9J6Fhucq5M4P29xG3W6Mx9ZYBrCtbEYz9M/j0DIsnJoAh9MM3FoapdbwDaFJuWg55EptaHX2S7/qPiJAHMB0L3jGi4aAR5rJ9SRy23Ir2fPBkYUgH5yUFdHeGuP1a+a9jsDb6uAVe3U7NRS8ACtlcpzD8N4Guz9n/Mt6Tlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 630E960492; Tue, 03 Mar 2026 02:41:53 +0100 (CET)
Date: Tue, 3 Mar 2026 02:41:53 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Willy Tarreau <w@1wt.eu>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Zhouyan Deng <dengzhouyan_nwpu@163.com>
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
Message-ID: <aaY8V14pSIbAE8pu@strlen.de>
References: <20260302205527.1982836-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302205527.1982836-1-edumazet@google.com>
X-Rspamd-Queue-Id: D7C711E7C42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262981-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,1wt.eu,vger.kernel.org,gmail.com,163.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.662];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid,strlen.de:email]
X-Rspamd-Action: no action

Eric Dumazet <edumazet@google.com> wrote:
> This reverts 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp offsets")
> 
> tcp_tw_recycle went away in 2017.

Indeed.  Thanks Eric.  The original situation that prompted per-host
offsets might not be applicable anymore.

I think its worth a try.

Acked-by: Florian Westphal <fw@strlen.de>

