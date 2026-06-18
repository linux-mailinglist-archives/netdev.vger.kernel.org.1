Return-Path: <netdev+bounces-300334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qRzPMh+dM2oaEQYAu9opvQ
	(envelope-from <netdev+bounces-300334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:24:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1592A69E0EA
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:24:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=Edzvnx1S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300334-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300334-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7397300917E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FD035DA6A;
	Thu, 18 Jun 2026 07:24:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01831ED7D
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:24:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767453; cv=none; b=IyT+Sht8cYaqb//Jv/VoVBypo1h5KNnXM3vMk5zRk2MQNOaa4Vr1Of2c9j5BZm585fgpl8Yi0teR+3CX1Af0MClg13dRsDK3+ErGKZH3Y4LQOLEXA6McMbvJ78AJNW8tZ2nRYhxAKpFXTGvq5Hs6vjRvB0lr0Gkd9A3ganx4Rxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767453; c=relaxed/simple;
	bh=QMZj6JTpu964iMP3q79vrett+s/8WrJIfvIEbpyAhCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6isN27dz8pW+dSexLcny4rGEbHbAIc8cnbJtYC4zUQZK5NaoabSDFI8pEU4V9cLV2DdEYLEM/Uq6lYZqnxz31MulpF/QEgmTm3Mkw1VBHbQFGrA1rtg6GfyZaDiIgQZYTHd0kOWOFBOnlIORAr9tSnbUWsuIkptxgohmtMjAXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Edzvnx1S; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 699382074F;
	Thu, 18 Jun 2026 09:24:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3FleXRWhi6I; Thu, 18 Jun 2026 09:24:08 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8BE2420704;
	Thu, 18 Jun 2026 09:24:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8BE2420704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781767448;
	bh=AGYosLUTA1dALnl3eAdgVL5Vkoubpbpyn+BFcG6Iaq0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Edzvnx1So5ld8amTmM0mGsaC68C554ndCK71M3cuRq4UlNED6o7tba0PCHw3p05sh
	 ZrGsf6PhPE0viPmVACQc2XBxT2ZwpocLKf+0TfmSHFw1emauKX3UjCGx4+XuNhmvnM
	 YjzXykE+BkQSlYd6gQV0RnsI8WrVrJUQJ2+kQMUraJusvHpLWC8Cw6is+4uEIH3DYz
	 aiUyy6aUwoepDtWPrkPq2L68yyxm8nVAGZHhCrBpskqDO2KBpuyFGECNAx8LAICaos
	 I4pnFbL2JAlT/N/rN13Yf4XCwggdt6YUzynnIevAvwZYckCEJqtWNwuZYLuHEO+OBZ
	 2qh6W5AQdkc2g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 09:24:07 +0200
Received: (nullmailer pid 3962650 invoked by uid 1000);
	Thu, 18 Jun 2026 07:24:07 -0000
Date: Thu, 18 Jun 2026 09:24:07 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	<syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
Subject: Re: [PATCH net] xfrm: annotate data-races around xfrm_policy_count[]
 and xfrm_policy_default[]
Message-ID: <ajOdF6Vx5w_0WBFs@secunet.com>
References: <20260612055634.3560352-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260612055634.3560352-1-edumazet@google.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,secunet.com:dkim,secunet.com:mid,secunet.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,gondor.apana.org.au];
	TAGGED_FROM(0.00)[bounces-300334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com,m:herbert@gondor.apana.org.au,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,d85ba1c732720b9a4097];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1592A69E0EA

On Fri, Jun 12, 2026 at 05:56:34AM +0000, Eric Dumazet wrote:
> KCSAN reported a data race involving net->xfrm.policy_count access.
> 
> Add missing READ_ONCE()/WRITE_ONCE() annotations on
> xfrm_policy_count and xfrm_policy_default.
> 
> Fixes: 2518c7c2b3d7 ("[XFRM]: Hash policies when non-prefixed.")
> Reported-by: syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a2b9e96.99669fcc.12a77b.0006.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Applied to the ipsec tree, thanks a lot Eric!

