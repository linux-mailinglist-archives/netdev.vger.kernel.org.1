Return-Path: <netdev+bounces-298526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6DhdNgPHK2pnEwQAu9opvQ
	(envelope-from <netdev+bounces-298526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:44:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E675677EA0
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:44:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SbFHET31;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298526-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298526-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6452303754F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD6383C93;
	Fri, 12 Jun 2026 08:44:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884F37F8A4;
	Fri, 12 Jun 2026 08:44:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253862; cv=none; b=LDwFRPbV7V6/CSH8SEHCbUSrMqouiqydjiav5edMGxdtr5nwGKIcLd6ljw7es3jR3TXHDb/wh3oy3pSTGw1hWd+ijfVGjYplCPFJcxN31hdyxrmWDqKS4e6R7yg+qq2dOthKOBPiI1n+QR9VehEFgueo/Mcz0h5Ssm3L61alrbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253862; c=relaxed/simple;
	bh=opNULbMsLFO7G0iKg0MW34aWlrvrchHIe3SdZYnnk/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqXf4JCARlZXoUhkRncYjAF3h6ztTAopQnuyISG43uRCIRmANNVgjz5KIHTckur7QUPahF2YApI2cS2gxiFj/JcpuM87BxoiflIb7/IcjvJK47nkCJzQOvGyUTFbE/5iy1Xbr/AuqTeqpXVy96J7dprC5l9A7GZ9Lvi4YZ63VTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbFHET31; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327F71F000E9;
	Fri, 12 Jun 2026 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781253857;
	bh=CnyWSURZdvG7Ai86hnxk/cu/zFJQx0+8PaYVIH2aDoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SbFHET31Qk9YXEEOHwzuAoyb4t4AuSQe1pzSppz5xqB5PDKfIegG69Yp/ThE+WuYS
	 KwU43YpOz3mp8LmDVn0t1zWptN5RCeIeV1ygPQV0TRxA1leN84q5TmSpzw/Nlpf/MD
	 YAPazfmjPUEHF7UbRb3Sfc//wEBHSag6bW2RnxLTmUjd+6L/Fro7a6kvXVsnGf2CY+
	 /dcR2EoGwXr4Hjh/hyOMLX/iiKlta6IE2jeCppIrJptugOTcD4i0X9EO9crUlu+9un
	 UetTX5cqa2Dy8BmSyaf98ne1uAhssSOiB/wojsDN3Fk3b/llu5/DGsQDgPJZiEOA6B
	 Otl/hyxzfQG+g==
Date: Fri, 12 Jun 2026 10:44:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Piergiorgio Beruto <pier.beruto@onsemi.com>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net v5 4/4] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Message-ID: <20260612-tangible-supportive-eagle-0dbff6@quoll>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-4-4533a9e85ce2@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611-level-trigger-v5-4-4533a9e85ce2@onsemi.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298526-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:pier.beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E675677EA0

On Thu, Jun 11, 2026 at 02:55:41PM -0700, Selvamani Rajagopal wrote:
> According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
> specification, interrupt type is active low, level triggered interrupt.
> 
> Specification calls for when interrupt level will be asserted and what
> condition it is de-asserted. By using edge triggered interrupt, there is a
> potential chance to miss it, particularly if it is asserted when interrupt
> is disabled.
> 
> Level triggered interrupt can't be missed as it gets de-asserted only on
> interrupt handler taking actions on interrupting conditions.
> 
> Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY")
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


