Return-Path: <netdev+bounces-300256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zdMEGQAfM2r49gUAu9opvQ
	(envelope-from <netdev+bounces-300256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:26:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9EC69CA8F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:26:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fr.zoreil.com header.s=v20220413 header.b=FF3otWbI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300256-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300256-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=zoreil.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B5F30427E8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B365391E7A;
	Wed, 17 Jun 2026 22:26:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C62EEE74
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 22:26:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735165; cv=none; b=VVCe8CAmEkD72B4+XWViOIQfONROizjB9uxJKtxD3UTw0YTM00BDOpnkPKUFQoDxjH+ZsBwsF7sVXLq1+bQqmN0JiSgKTKlabPDKJjFpYNOosB6WegklEdonE6Ckz6x3+fdfrUV8qYG04V++pllLWCIpALgkE/eKMZ3BBVOXS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735165; c=relaxed/simple;
	bh=ek5YPfIi3miySu+OGgINN4xoG2HI4oM67+yeKK4gpt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkwodl3s4skDdqYgeBnmCbqov6D4wc/BP1ESL76sfbc9BkIua5lnroW9FyyHfPKoPGQr9oOUz2jLhJM9QqeMp8JRym6aBPpVztfkozhVTntzwBq/4qwCTlquQwmly3mv3COHcDGyjet89EnFjlRJkfF1tHJ2SSB/UcvHQhckBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=FF3otWbI; arc=none smtp.client-ip=92.243.8.30
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 65HMPNrF3712048;
	Thu, 18 Jun 2026 00:25:23 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 65HMPNrF3712048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1781735123;
	bh=Oe/iXlh5kEu7zfbfDHyD/ASRNxkD+zGQJQ4wJjxLfmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FF3otWbI1wigC2a1xxSwJwujep3hC4tJGWmT/mKZCyagyHuCj5OlT2L26Ni+7lflx
	 fs+anZT3NqdYSfGub6EXXT5zGm358K0gugWDbaf2DT0KwYBkKOAWc2nnB2IdAXYszX
	 FC6RMplpEaX+k/lupbUkeVLNVnarmgknRXS9HNfE=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 65HMPNRp3712047;
	Thu, 18 Jun 2026 00:25:23 +0200
Date: Thu, 18 Jun 2026 00:25:22 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Atharva Potdar <atharvapotdar07@gmail.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: migrate Rx path to page_pool
Message-ID: <20260617222522.GA3712043@electric-eye.fr.zoreil.com>
References: <20260614054137.32181-1-atharvapotdar07@gmail.com>
 <20260614220934.GA3575431@electric-eye.fr.zoreil.com>
 <CAF9AHva0TSFz5tedMEgJTkhThzDGqmW7MJshAtf3ULbLY4wd=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF9AHva0TSFz5tedMEgJTkhThzDGqmW7MJshAtf3ULbLY4wd=w@mail.gmail.com>
X-Organisation: Land of Sunshine Inc.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zoreil.com,reject];
	R_DKIM_ALLOW(-0.20)[fr.zoreil.com:s=v20220413];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300256-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:atharvapotdar07@gmail.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[romieu@fr.zoreil.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fr.zoreil.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romieu@fr.zoreil.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fr.zoreil.com:dkim,fr.zoreil.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B9EC69CA8F

Atharva Potdar <atharvapotdar07@gmail.com> :
[...]
> Francois:
> > You may consider fdd7b4c3302c93f6833e338903ea77245eb510b4 and some related
> > changes around that time.
> 
> I am sorry but I don't fully understand the context of this commit or
> the behaviour it addresses. Could you please help me regarding what I
> need to watch out for this change?

It should be clearer with c0cd884af045338476b8e69a61fceb3f34ff22f1 (and
may be 6f0333b8fde44b8c04a53b2461504f0e8f1cebe6 as well).

Old chipsets did not correctly implement receive buffer size limit.

I have no idea how mildly recent ones (< 15 years) behave.

Reinstatement of the bug on old chipset imho deserves some warning.

-- 
Ueimor

