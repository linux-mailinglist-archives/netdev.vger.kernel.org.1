Return-Path: <netdev+bounces-294712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rdBiLp0GIGoiuQAAu9opvQ
	(envelope-from <netdev+bounces-294712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:49:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DE9636B8A
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:49:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=HjtGNtHW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294712-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294712-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD2843014166
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 10:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7753F54A7;
	Wed,  3 Jun 2026 10:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A7340404
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 10:48:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483738; cv=none; b=Lq6TMlMbQ6FXpOhbICLX4FfEQasjm0RPDMpQo8xrjZzNYDiVaP4b3Cg3A1IlWU96CgCogTEU91MiTyZ1VUNc6+RKpIRufeOmmFN6VnHv8z3EO9wKobjiR6P6Tst417/Dl/M85IvjF8dNV0EXlFz8a8wccvVNLmIFRG9wH1vYeaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483738; c=relaxed/simple;
	bh=hcNWV9ynrtgnT9aVZ1zqB/jzc4YnEBuLOXJn94aAX30=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXe3R+cmV6bLZpgq+admCFJHyC0bgmNbs7saz9Dq4Op+dhO1ZPCCUEi6Lbl3yk++kXd/MymHpgzLYq/lGzeLDJZau92hGP2idiXFDo7V5n/6WRr+AfpLyxpj6prEsN6ONkt9apzFmAldFCW4r/znr6gvWCvoPjFCNM2pwUrtWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=HjtGNtHW; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CE6D6207B2;
	Wed,  3 Jun 2026 12:48:47 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hIyJjOnGr39M; Wed,  3 Jun 2026 12:48:47 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4603620185;
	Wed,  3 Jun 2026 12:48:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4603620185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780483727;
	bh=eoJaiIsfVK7BigA7oqbmOeQRei0ZAuBR003v3+d9+bM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=HjtGNtHW5t3nluXo7EvYDNuoPW20n7k6zi9k760Z9gibIwaM3YOqpnAVufbS5nRug
	 o3a664IABEWtDU3WCFp0IyHHRPbFO1KHwQrTeFuI2ybUfm7F4kke/zihSJtcVeruMD
	 iZjacYKbe0Z4sv8iFBtcXbcyy+edWdJ51uvMb6rzec5dSiTSZrTrDTEce2ckVXvjJh
	 JmiRGAmqDAA4ZcafX+AcKy/ivusWkHu/hbcnz7bsin8a0P1xaQOqPFCZAR3EjuxLHt
	 oqpBfZn2U/7sMs11O/Xs92WzqAq2RQSE3jxd9JJ/x4CpcCmMMbmsx8Ly0uvk9y8Zcn
	 iLspPd1FqNlgw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 12:48:46 +0200
Received: (nullmailer pid 1850063 invoked by uid 1000);
	Wed, 03 Jun 2026 10:48:45 -0000
Date: Wed, 3 Jun 2026 12:48:45 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Zhenghang Xiao <kipreyyy@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH xfrm] xfrm: iptfs: fix use-after-free on first_skb in
 __input_process_payload
Message-ID: <aiAGjceNXWenyawR@secunet.com>
References: <20260526105328.87078-1-kipreyyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526105328.87078-1-kipreyyy@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294712-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kipreyyy@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56DE9636B8A

On Tue, May 26, 2026 at 06:53:28PM +0800, Zhenghang Xiao wrote:
> __input_process_payload() stores first_skb into xtfs->ra_newskb under
> drop_lock when starting partial reassembly, then unlocks and breaks out
> of the processing loop. The post-loop check reads xtfs->ra_newskb
> without the lock to decide whether first_skb is still owned:
> 
>     if (first_skb && first_iplen && !defer && first_skb != xtfs->ra_newskb)
> 
> Between spin_unlock and this read, a concurrent CPU running
> iptfs_reassem_cont() (or the drop_timer hrtimer) can complete
> reassembly, NULL xtfs->ra_newskb, and free the skb. The check then
> evaluates first_skb != NULL as true, and pskb_trim/ip_summed/consume_skb
> operate on the freed skb — a use-after-free in skbuff_head_cache.
> 
> Replace the unlocked read with a local bool that records whether
> first_skb was handed to the reassembly state in the current call. The
> flag is set after the existing spin_unlock, before the break, using the
> pointer equality that is stable at that point (first_skb == skb iff
> first_skb was stored in ra_newskb).
> 
> Fixes: 3f3339885fb3 ("xfrm: iptfs: add reusing received skb for the tunnel egress packet")
> Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>

Applied to the ipsec tree, thanks a lot!

