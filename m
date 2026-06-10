Return-Path: <netdev+bounces-297499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id osgzEf8RKWqsPwMAu9opvQ
	(envelope-from <netdev+bounces-297499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:27:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA50666A1E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:27:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KW3i8lM+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297499-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297499-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C0863033FBE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809438E11A;
	Wed, 10 Jun 2026 07:22:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159443264F2;
	Wed, 10 Jun 2026 07:22:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076126; cv=none; b=o8o2erjpHzdjTLeYA3uNTKl8g0t5X0m998twYWZUSkwYeGvRvGENel9ylXgN8Dv38lkhiRilq1mm0SYuUAaFPdw7grXLrMxDIfn5LSV3h36RWqzPmDG9/R0bncYGv1Yn4u1OscbilnV4AXKrchNTn3Rw/rS6fAYbiVBzZERcuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076126; c=relaxed/simple;
	bh=hGaLcMiyb+9mMuok6B98CuQbY92HfVgRIFjfJWrDwvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvBF1IBCg8+F9HzWwZ0SGTtUbTRNCzlK4z6XEkVtHb6KS/2gKIp6/VK1M33+onv1FeKsPflTn4z8sOGyfgzIItmKAXSiaEb5zwhzlbx84Ms2V48wZpgXeXNOKzf4USi6fiLHiV6o6HeDkwZtoC+tkpKBiqNOGozMWrsBq+nPDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW3i8lM+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5092C1F00893;
	Wed, 10 Jun 2026 07:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781076124;
	bh=sBDr//3jQGp33lXnSXKOK85B+gq0Woy1cD+eSVoAx1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KW3i8lM+WAsDvdfATVx6Sk0Nx3ECr1qsD41T/Wj1UG/xo1TmtaMp28j0hZ1OR1D1b
	 ZQCfTfExXD9B4AWWhWo3+DexJ3geSwC9J02I65/YOPrhVLPN3DmBGuRkvlkuWAIktF
	 BDugPCBC+8zy2O3TYU9D9MuVwg4dBwkDOp0ORCMZesF7j+u7AfBWqxQRB7WfsJuJWa
	 Pwft2T2wq4VHc685QJtDgUnCOuSKjGZs+BUa7xIy/flqk03D7cImJdmkvoviHxHjuj
	 Uq2P1Cgw4DRFJ3gnKgFujEy/MbTntP1SQWe8f5iCu+YqAHH69haXxeITbboRRQ3TSs
	 u4yG7gJjwJLYQ==
Date: Wed, 10 Jun 2026 09:22:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, devicetree@vger.kernel.org, 
	Piergiorgio Beruto <pier.beruto@onsemi.com>
Subject: Re: [PATCH net v4 4/4] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Message-ID: <20260610-glittering-rose-squirrel-b0ccf6@quoll>
References: <20260609-level-trigger-v4-0-6f389abdd192@onsemi.com>
 <20260609-level-trigger-v4-4-6f389abdd192@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609-level-trigger-v4-4-6f389abdd192@onsemi.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:pier.beruto@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297499-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,quoll:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EA50666A1E

On Tue, Jun 09, 2026 at 12:50:27PM -0700, Selvamani Rajagopal wrote:
> According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
> specification, interrupt type is active low, level triggered interrupt.
> 
> Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY")

This to be a fix, you would need to describe the issue, e.g. impact. I
already asked last time and commit msg did not improve.

> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 

Messed patch - missing separator.

> changes in v4:
>   no change
> changes in v3
>   interrupts entry changed to level triggered from edge triggered

Best regards,
Krzysztof


