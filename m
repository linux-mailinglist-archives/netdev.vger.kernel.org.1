Return-Path: <netdev+bounces-307551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MLZKEBt6Vmq+6gAAu9opvQ
	(envelope-from <netdev+bounces-307551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:04:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEEB757B3E
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:04:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A4f7LP12;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307551-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307551-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73485300D54A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F0732ED54;
	Tue, 14 Jul 2026 18:04:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82C337BAB
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 18:04:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052244; cv=none; b=rNMTsXZIPptZ/DXR6gwb+9wfVLGSIvsN78o63upXO1O3dw/7P/aE5SoG+eTIiPhGGlMP/GJwlqIfUr2wvuDPJsyQ38nq35AHpiyf7JKWI5kFXQdwfVbQHmraKTgZQsGkhUL0pvMcTBcPOFvnNYDxFILVjk+lkkbhrVX35Chkt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052244; c=relaxed/simple;
	bh=HO8Q8vDJJ6X3nKLzA8Ugjl0nVKU6c/2LRMY5qr2jOPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFGjBA2Hy03nM07D6yMEGLbIM6m0SaySyMELJ8rI2wr+IXr8kSiSVG6nBZ8k/PRql4NsdCQUseqG+tBp24CPisWrwsGndPdXEW/yMvTpv+hRoUKRVvt9LZap6+jYZ6x9ZokD4Z6lfuiDIlAXPLwLPKVUQhgAMcRbA9x9q7UW7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4f7LP12; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEC21F000E9;
	Tue, 14 Jul 2026 18:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784052243;
	bh=aOuzucrNKHJIcV2zJQgz693DKy+bvRbE02cKNhl4zt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A4f7LP12myIhTqFeScXgUNtm0Q3huz748IfPLofSOIs7KJ3vAPyBsth45eAPemnuE
	 sZWXKJ1KwkeCbP+j5aBxjJXFvnnPIuk/qHP4EXxTh66tvaMqJBc0vVoaGEz13dHFk7
	 dWWZ5sECp6ZVxQt/I90pvOocDkQLCebu+hunxBtQPd5EWUr3QxDwnK9WhFQCTJmDaE
	 tZyYv8FVMP/2FRZriylBIz4NM6Wazn3LzzFQ7gTlClFJ8EpfldykqcOaGPYyUQkoBH
	 kEOWlsrhLl6SatZ6Q5yH8M+UfCjNtH+7YRxfAZ/D2dJ8+gkUcazMW/NXl1yUOXDpRn
	 idPRdyiCtNm0A==
Date: Tue, 14 Jul 2026 19:03:59 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 1/3] geneve: pass geneve_config pointer to
 helper functions
Message-ID: <20260714180359.GN1364329@horms.kernel.org>
References: <20260707145331.3717941-1-edumazet@google.com>
 <20260707145331.3717941-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707145331.3717941-2-edumazet@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307551-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EEEB757B3E

On Tue, Jul 07, 2026 at 02:53:28PM +0000, Eric Dumazet wrote:
> In preparation for converting geneve->cfg to an RCU-protected pointer,
> update helper functions to explicitly accept a const struct geneve_config
> pointer instead of dereferencing geneve->cfg directly.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/geneve.c | 140 +++++++++++++++++++++++--------------------
>  1 file changed, 76 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c

...

> @@ -1306,14 +1313,14 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
>  }
>  
>  static u8 geneve_get_dsfield(struct sk_buff *skb, struct net_device *dev,
> +			     const struct geneve_config *cfg,
>  			     const struct ip_tunnel_info *info,
>  			     bool *use_cache)
>  {
> -	struct geneve_dev *geneve = netdev_priv(dev);
>  	u8 dsfield;
>  
>  	dsfield = info->key.tos;
> -	if (dsfield == 1 && !geneve->cfg.collect_md) {
> +	if (cfg && dsfield == 1 && !cfg->collect_md) {

Hi Eric,

Sashiko.dev seems to think that the cfg guard is purely defensive.
Which does seem to be the case.
Perhaps it is an artifact from the development of v2?

>  		dsfield = ip_tunnel_get_dsfield(ip_hdr(skb), skb);
>  		*use_cache = false;
>  	}

...

