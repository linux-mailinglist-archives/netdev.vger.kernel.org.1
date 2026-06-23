Return-Path: <netdev+bounces-301312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XMT1OdNOOmoA5wcAu9opvQ
	(envelope-from <netdev+bounces-301312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:16:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC26B5AF8
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:16:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ucloud.cn header.s=default header.b="Hb2s/4X/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301312-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301312-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ucloud.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 248BA3029792
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 09:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D933403E1;
	Tue, 23 Jun 2026 09:14:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49244.qiye.163.com (mail-m49244.qiye.163.com [45.254.49.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF330CD89;
	Tue, 23 Jun 2026 09:14:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206098; cv=none; b=NEP0FJT0RoYXuGx2RFx/Pcr9hZizLTIJzsqg12VxbMx4IEACCo+sI+ykcbMOYz1c/yfC18YF8j/aWI0mfK6SU4yShfD1yloYVbAvGVeybCEHno6Ut3qJXnPIHVO6TZXxNvebNAzgvxBHxyT+UT2GiXDesuVTqt6gcYDGSrfIOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206098; c=relaxed/simple;
	bh=ExgVCt1CCPYVVSXX87mcq1UZuQEJGtt5QQwC44gLNZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILlcE/Oi4gkngWgvGJuiKVhkcCS6PazPGCSbl5/V31VZGbNQfSkGTPA5mynBqAcUj04PGr+6WCaIwH2s2PErpCQz47JGw1ShnVysDn0FBt0qOmg4uocWrKLBDPP/S5A0anrD+Z5iQHqge2kfwqn8DFZmiuTvCWxPePJj+icJb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=Hb2s/4X/; arc=none smtp.client-ip=45.254.49.244
Received: from localhost (unknown [106.75.220.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1bc217c60;
	Tue, 23 Jun 2026 10:24:43 +0800 (GMT+08:00)
Date: Tue, 23 Jun 2026 10:24:42 +0800
From: "yuan.gao" <yuan.gao@ucloud.cn>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yue Haibing <yuehaibing@huawei.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kyle Zeng <kylebot@openai.com>, Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dst: block BH in ipip6_tunnel_xmit
Message-ID: <20260623022442.uyq5vtciwidezl45@yuangap>
References: <20260622033118.244651-1-yuan.gao@ucloud.cn>
 <CANn89i+hKw-G3jewJoEPgGu-BOWUNuUn0RMdGh5L3B1ubD+OMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+hKw-G3jewJoEPgGu-BOWUNuUn0RMdGh5L3B1ubD+OMw@mail.gmail.com>
X-HM-Tid: 0a9ef24b52aa0229kunmde27a96423c337
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUxCVhlDGkNMSB9MSBlNHVYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUlLVUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Hb2s/4X/YHffyORINucWEpcBB40pIywgWk/xqqlCU6oc3bnAWJdpBxieqKp7Sf/V/0vRydWGy7CeCQs5jHr7HzOibYyG2ZvDNlugewBdk975dKKYBQ0aq6hn33RpI/jNuF6pIJZI9Es3nOjEmMNRavPnSp+6JRDYhqLzNrD4TzY=; c=relaxed/relaxed; s=default; d=ucloud.cn; v=1;
	bh=aXCiHqlT8yz5PIFvChdkyURa/aetmPB2ZOsvzGXT3LY=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ucloud.cn,quarantine];
	R_DKIM_ALLOW(-0.20)[ucloud.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:yuehaibing@huawei.com,m:kuniyu@google.com,m:thorsten.blum@linux.dev,m:kylebot@openai.com,m:kees@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yuan.gao@ucloud.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ucloud.cn:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuan.gao@ucloud.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301312-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,yuangap:mid,vger.kernel.org:from_smtp,ucloud.cn:dkim,ucloud.cn:email,ucloud.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51BC26B5AF8

On Mon, Jun 22, 2026 at 01:13:30AM -0700, Eric Dumazet wrote:
> On Sun, Jun 21, 2026 at 8:31 PM yuan.gao <yuan.gao@ucloud.cn> wrote:
> >
> > Similar to commit 1378817486d6 ("tipc: block BH before using dst_cache"),
> > the dst cache helper functions must be invoked with local BH disabled.
> >
> > This ensures proper synchronization and fixes a potential race condition
> > on SMP systems.
> >
> > Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
> > ---
> 
> All ndo_start_xmit() methods already run with BH blocked, can you give
> us a stack trace when this would not be enforced?
> 
> You forgot a Fixes: tag.

Many thanks for pointing that out — I completely missed that detail.

Cheers,
Yuan Gao

