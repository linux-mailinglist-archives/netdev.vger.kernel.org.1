Return-Path: <netdev+bounces-296386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qYnPCBBsJmoaWQIAu9opvQ
	(envelope-from <netdev+bounces-296386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:15:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62817653705
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:15:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=tqOY3TSX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296386-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296386-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D147B30055AD
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD930C629;
	Mon,  8 Jun 2026 07:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8028B4E2;
	Mon,  8 Jun 2026 07:15:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902923; cv=none; b=MvwUq4UaVVhfjifHOIBAsAP8zUNS5raL2qNwTLwwA4jWcQl6DGZBfxXIeTQ1AQ2YC8GL1SJoKbQE2eU7t5ToHwBtpw7kGsyvtzAfhR2Jq5NHz6dkjc2dbOjuJkcrwe0KEOIEQR+P+bSHSMXYImAiir1hqTzzDfOKVx8cjM6KHm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902923; c=relaxed/simple;
	bh=sgCSxu8SUDZnKgcwGPjsvCzlrsGDReY6qfSGvSmYa14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnLJ0CnYrUIknnAx0iT1lZXP/xinimvwJbXw9Ha2egVCe0xh7oQBNHhO8d7FkEze4ZLuKyBCN6Fb+vqQpbFm8SSSstXa6Y1RxzcRAzheh5o9WEXMXK8vSZLqZfauLGsKNexFy8DGrZ2YTsnJTkpEdUrsJXj7oRfpv7UsV/2xO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tqOY3TSX; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2UXqzTLU9+fgWDwv5bt+CPv4MNbwS6rROorNZuf/poA=; b=tqOY3TSXVvOT7a5faZTDG8bbFC
	JsRyxWLhUoiiLNg9AN/lcskFrw+TPaMAHsh9r5ZTwbfFBKRANUsRIhhhwofWQKZsYXBj78k+ZI8HV
	nEP9kb2oIXM02WO4Qjg3MM0xif6MlYlYPgOtYyQEqwev0uf5uagxf7OckUbmoCTk58wo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWUCK-006Zm3-Ua; Mon, 08 Jun 2026 09:15:00 +0200
Date: Mon, 8 Jun 2026 09:15:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: "Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"conor@kernel.org" <conor@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Message-ID: <103296ba-9577-4851-ad43-dcd261130afd@lunn.ch>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
 <CY8PR02MB9249E607ACBF3A05AB83ABF683102@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260604-swimwear-garnet-3eb092e6fda7@spud>
 <4df9882b-3426-4c36-8048-0c76d0f11c74@lunn.ch>
 <7c68173a-ebff-42cc-8519-95e8365805b5@microchip.com>
 <DM4PR02MB926317F64B5A3827009B66A9831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR02MB926317F64B5A3827009B66A9831C2@DM4PR02MB9263.namprd02.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296386-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:Parthiban.Veerasooran@microchip.com,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62817653705

> I agree. When we change to level triggered interrupt, current mechanism won't work as
> we are not disabling the interrupt when we handle them.

I'm kind of surprised about that. If you only provide a thread context
handler, but not a interrupt context handler, i would of expected the
IRQ core to leave the interrupt disabled until the threaded handler
exited. But maybe it is historic behaviour.

	Andrew

