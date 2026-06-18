Return-Path: <netdev+bounces-300336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8nU6BYSdM2oxEQYAu9opvQ
	(envelope-from <netdev+bounces-300336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:25:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E88169E105
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:25:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=AfqL+CnV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300336-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300336-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BF803009CE2
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB593C6A51;
	Thu, 18 Jun 2026 07:25:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E532F60CC
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:25:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767553; cv=none; b=OYHecD3pP8CHU1Qe2m3d9clDUAUKD5XnSbHoH1cdiwePUCoH36Pw07HIMurHFlRCIBFg1cfwB3V4qHuvbrzyPhqEdG96HOjgOLoF0s+hcsSmXo+blhTxwuq2J/fCSpfkM4MhXvl/2XDJ0i2TZgdOuSdBzGaBKsseyWJ+0Jqdf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767553; c=relaxed/simple;
	bh=6HqH1fc6zpY8hjY5Pb3t/7XQxyeoJiTv40MBhN4B+Mw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoajCRE7zBkoCGvsbzJcqr7d1c87qu+sDY5jnitTj/IQhmDN7BoiKoLNC1hwhP1h67daKOjuD9WTKU4656J8SP2H2ewNCJQsRYZ0j3BerQAmdFdgl+dwVGPPcb9SrJQNfb7ffj7H7GoyPzeD2kj7+NLk0pZMFknsPqEmIuBfxeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AfqL+CnV; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A0A4E207BE;
	Thu, 18 Jun 2026 09:25:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tj03Nkc_oNvJ; Thu, 18 Jun 2026 09:25:49 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D089F206E9;
	Thu, 18 Jun 2026 09:25:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D089F206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781767549;
	bh=5B8UWRf+QPypKOuQk+WL0ueRgNpNsDFKOhc/Cy80jkA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=AfqL+CnVuYLcymo3bpEKSWs70kVPDZf8TEfLI65+J6a+Py7YWk7hU/4VZfl7LfAU3
	 heuce5K77IqixMT9Yq754cHgdGX7EdpeyZPQv+hcrJbRxa8g7p+L0UW4tZwbBip61C
	 1iK6Ajvh4AGrRMUWsmslJb4Ew1rr4eQzUogKbqPvA1F1ty65zauecXw6HxJlqDqgGT
	 WaNYYyvoKAj7F7T+UQRdcswuBh0v8TjGdSF6m7CsUsazIJivJsthz2UVmZQ9qnqKfs
	 maGoyOReWntaPNah+FisU0mBSRqxrVhYaLgCQQjKOrpAuwsJ99pOR11Xu7h6hd7SMS
	 4mHUhv09LDmqQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 09:25:49 +0200
Received: (nullmailer pid 3964027 invoked by uid 1000);
	Thu, 18 Jun 2026 07:25:48 -0000
Date: Thu, 18 Jun 2026 09:25:48 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	<syzbot+9383b1ff0df4b29ca5e6@syzkaller.appspotmail.com>, Sabrina Dubroca
	<sd@queasysnail.net>
Subject: Re: [PATCH net] xfrm: validate selector family and prefixlen during
 match
Message-ID: <ajOdfIzXW5KGzzXf@secunet.com>
References: <20260615090237.2689082-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260615090237.2689082-1-edumazet@google.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,secunet.com:dkim,secunet.com:mid,secunet.com:from_mime];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-300336-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+9383b1ff0df4b29ca5e6@syzkaller.appspotmail.com,m:sd@queasysnail.net,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,9383b1ff0df4b29ca5e6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E88169E105

On Mon, Jun 15, 2026 at 09:02:37AM +0000, Eric Dumazet wrote:
> syzbot reported a shift-out-of-bounds in xfrm_selector_match()
> due to AF_UNSPEC selector with large prefixlen (e.g. 128) matched
> against IPv4 flow (when XFRM_STATE_AF_UNSPEC is set).
> 
> Fix this by:
> 
> - Rejecting mismatched families in xfrm_selector_match.
> - Returning false in addr4_match if prefixlen > 32.
> - Returning false in addr_match if prefixlen > 128 (prevents overflow).
> 
> Fixes: 3f0ab59e6537 ("xfrm: validate new SA's prefixlen using SA family when sel.family is unset")
> Reported-by: syzbot+9383b1ff0df4b29ca5e6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a2fbe35.be3f099c.2836ae.0018.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Also applied, thanks a lot!

