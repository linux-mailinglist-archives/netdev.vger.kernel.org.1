Return-Path: <netdev+bounces-266393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CiHCn21sGlvmQIAu9opvQ
	(envelope-from <netdev+bounces-266393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:21:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7918259B1E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9F52303CB23
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE8F318EE1;
	Wed, 11 Mar 2026 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXOcsHvJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAA317160;
	Wed, 11 Mar 2026 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188424; cv=none; b=ZZLeLvaJUbb+Yja7EyswqMUqUVFuXkHi5ZejxJSECsAOCsdaILYtTsaPyy6/9wHZ5gzP8e1ceKlhszTcSSZaPIKUi3bqImEJXDs/AxKR6IeSDABweZsIawy0StPwqHTXlrEtf/JgqonMiu2a9WFV2cK4t7hdHRwqLi1u3OimmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188424; c=relaxed/simple;
	bh=hjt8rYCiHadMY716FJXUReoveBi22CA9zPegPMM9eLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVhn8bynR4BPdmYvk3ilZa5RKYKWUhbN6v0lOoWSIFSJc8/pit8xWBIM9WKLiDyyeUBsktZBSLnVO83kAHqLkddOkrClFUyzIvWJMNEObYbxwMcREWzr1oBBDQ88woHHXmv03NKyzGjgua0rs/D+aOaOUYk8kHY3h8b4qbn8WRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXOcsHvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB778C19423;
	Wed, 11 Mar 2026 00:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773188424;
	bh=hjt8rYCiHadMY716FJXUReoveBi22CA9zPegPMM9eLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dXOcsHvJ/SRFixePsDWry6p8htMTzEqDMQBY0gigUCwLpBmX1KrguGpWcFwwUY7TG
	 NVhcFsNjzNUP2LOLnAPawoiZD6Iqh/cJJd7D+dhFjdpQ32T0fOydIMyJSUlCHRvQjO
	 p59mLl3okKKXs36jP+jGGZ5fKsVcA6cbhAD/Kkz/qBnJaPcHsrjtxcZN71+mWSl8zb
	 3U7MEi591jKZeKAldDb0+ZVfCggHn+F9G/1ZAuEn/bqvM/qZHFG57xDzV1LdpiJxYY
	 ho90ukWIlkj+39N9bzMFz2BtdKyfEI8ZTM2pBH0BQ5/SN5UBXXAwX10grdPNtVnRto
	 YuF12W9LYxYRw==
Date: Tue, 10 Mar 2026 17:20:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>, Dmitry Bezrukov
 <dbezrukov@marvell.com>, Igor Russkikh <irusskikh@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, enelsonmoore@gmail.com, kees@kernel.org,
 oneukum@suse.com, n.zhandarovich@fintech.ru, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+48dc1e8dfc92faf1124c@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: usb: aqc111: Do not perform PM inside runtime
 suspend callback
Message-ID: <20260310172022.2543b368@kernel.org>
In-Reply-To: <20260306164351.503e8540@kernel.org>
References: <20260304155734.110734-1-zlatistiv@gmail.com>
	<20260306164351.503e8540@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C7918259B1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266393-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,suse.com,fintech.ru,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,48dc1e8dfc92faf1124c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 16:43:51 -0800 Jakub Kicinski wrote:
> > The PM docs suggest that PM should not be done
> > during runtime suspend, but I cannot find a
> > definitive answer for system suspend, hence the
> > conditional if(PMSG_IS_AUTO(message))  
> 
> Dmitiry, Igor, could you possibly shed some light?
> Can we simply switch to the _nopm() helpers instead?

Hi Nikola, seems like we may not get an answer..
Let's switch to _nopm() and let people complain if this is wrong.

