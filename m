Return-Path: <netdev+bounces-290379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A7QLej2DmopDwYAu9opvQ
	(envelope-from <netdev+bounces-290379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:13:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF18E5A49A4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 245133037005
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508333C945B;
	Thu, 21 May 2026 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NaD4QzyR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CDB3CBE6B;
	Thu, 21 May 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365185; cv=none; b=cOUPUBuO159+94Xn7dQgCdJFt7fFeKUcTDKz7ViB7EPF607r612UJg02HYIhoaWy2jd8gQAccdqD8MDUkscgkIfp/PjUQwF8rXuO/trcqF/dv+r+qU/Z7O+L7xMTkWTR2XJMxAZtYM/q91jRwzbtpURpGVJ9AJUeMGOqtthaUf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365185; c=relaxed/simple;
	bh=KBYoZ5ggGAybomRzZ0NJYWF3opNZtjW8sTmXfRL/CPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHELPalttCle5T5ddu31iyMJtW03ArW+QJtvfbbU6SrSP24b+WYlz7xpyg1L2YAfmxgVp4hlrLD79oKRW4kxkDA0Jk2OOQGQDCCNxa1WbTCe5QVoGIO69qITXybnS6XSBCx6NKJQAMcVLJA6LR8OqJtDQuo/zuLSrKGU68uFKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NaD4QzyR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3n/EkWeAIotHHlfu426N0ebCwVhyypELWEd97JI4YsI=; b=NaD4QzyRNaCVHYKAa0Lc81XEYJ
	qGeb7Z49j+AjbGe6lKb09RkQEcOAIvHo68Lv3iFrRR19+/RKiFJ1RWdcoEq0T0+2IT0sQcwd4W69j
	Qs90e4cH1FLCX9jOl0FoDRxPl83+/crmiul0N9qAeQfWHp5se4Gjpgvyd/HVRXm+5F30=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wQ2AG-0040oC-3W; Thu, 21 May 2026 14:06:12 +0200
Date: Thu, 21 May 2026 14:06:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ibm: emac: Clear MAL descriptors without
 memset
Message-ID: <19663d71-94e3-4b6f-ba41-7920ea5935e3@lunn.ch>
References: <20260517033621.1839397-1-rosenp@gmail.com>
 <b9a1ce9c-1f5c-485c-8d65-bb00c7850842@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a1ce9c-1f5c-485c-8d65-bb00c7850842@redhat.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-290379-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: AF18E5A49A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 11:45:25AM +0200, Paolo Abeni wrote:
> On 5/17/26 5:36 AM, Rosen Penev wrote:
> > Clear MAL descriptor rings with explicit field stores instead of
> > memset().  The descriptor rings are carved from MAL coherent DMA memory,
> > which may be mapped uncached on 32-bit powerpc.  The optimized memset()
> > path can use dcbz there and trigger an alignment warning.
> 
> Sashiko noted that the compiler could still optimize the above to a
> memset(). Perhaps a barrier() is needed here?

Maybe my understanding is wrong, but the compiler should have the
knowledge about if the addresses are aligned or not, and so if it can
call the optimised memset, or needs to keep with individual byte
accesses?

Has this patch been in user for a while, a port from downstream
OpenWRT or something?

	Andrew

