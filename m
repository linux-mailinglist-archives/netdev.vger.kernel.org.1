Return-Path: <netdev+bounces-252410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGaiEjBacmkpiwAAu9opvQ
	(envelope-from <netdev+bounces-252410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:11:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEDB6AE3B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE533044A4A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39636920E;
	Thu, 22 Jan 2026 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPhescQY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557D259CAF
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095741; cv=none; b=FgFhg01h+9UPkfa5cEAZlTcbcyqcIcJaCOuMB0f98GfVQx6BVr3ppJ0WiqT1JcnXkkD0/tuSgiF3kFE2gR0OEPg6vvWJK7tdjSU5dxP8HJKufE4PfbQBeNTVoXjHh/GS4Us3os9j8lBrNmkUJIOH9+wQzCUl68prbfVo+T0lyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095741; c=relaxed/simple;
	bh=dEiBGlsD4gpRdVxjCcq+07sVoFNHxQjESs/rev7O2Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBzn0R4qJAgy/MT4l7kjxJPqdfH0qpBqoPc6kmFALQsmHkDDD7IWW2oyAym1WEqLCaagVwonCKaHAHZCp+G5YDPWTf7r4V431EMy2oZoHVPPk2iav8LODhLE7o/SLwf3DuGdU0Tlw6HTOLg9k5VdmeUX++tF2sWQlo2yvIHBzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPhescQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4097C116C6;
	Thu, 22 Jan 2026 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769095740;
	bh=dEiBGlsD4gpRdVxjCcq+07sVoFNHxQjESs/rev7O2Qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qPhescQYwKn+qdqA2JkiaMcalARkgHELVxCtAQaJLeYMqiLXHSZvhKzNOue3r9O/B
	 UoBP0sTtVMQqO9lMfNN1RtGZ79gbVHQ9KRSKLd1MSMWmrlfkp5iYN0OwO/M3rTH8uU
	 bsK+w6L5hrP+w1RImxRR7M0mOSOvYdVc+ux5qh9vEylkSFG3nVtca0qIBuyKDXAlgW
	 95is3v0cERyUH0Jd6tQ2OxxY6NiHBeX1v0IbPAcNiEa1gcgvaoAVM5pecHGXP73dpD
	 dQ2NTp7CsE7ORDja9bHz43G5qfZJyhg/STrj9cVDw48g/xne8Mcug02DYHU9agaNGC
	 hJAJBUI6XSPTQ==
Date: Thu, 22 Jan 2026 07:28:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, syzkaller@googlegroups.com, andy@greyhouse.net,
 eric.dumazet@gmail.com, pabeni@redhat.com, j.vosburgh@gmail.com,
 davem@davemloft.net
Subject: Re: [net] bonding: annotate data-races around slave->last_rx
Message-ID: <20260122072858.2b652eb7@kernel.org>
In-Reply-To: <CANn89iLK1saW=7jxhtew_skR-rPPonFi71brvTApeKM5VVadiA@mail.gmail.com>
References: <20260120152856.1694824-1-edumazet@google.com>
	<20260122022237.2529455-1-kuba@kernel.org>
	<CANn89iLK1saW=7jxhtew_skR-rPPonFi71brvTApeKM5VVadiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252410-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,greyhouse.net,gmail.com,redhat.com,davemloft.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CEDB6AE3B
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 05:42:55 +0100 Eric Dumazet wrote:
> > This seems like the same concurrent access pattern that the ARP IPv4 path
> > needed fixing for.  
> 
> I saw this spot, but determined this was used at setup time, not in
> packet processing.
> 
> I was maybe wrong.

I guess if nothing else we should do it for consistency?

