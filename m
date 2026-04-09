Return-Path: <netdev+bounces-276754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O1LEurt1mlYJwgAu9opvQ
	(envelope-from <netdev+bounces-276754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:08:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65B3C4E44
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B544301B73B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 00:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ADF9443;
	Thu,  9 Apr 2026 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb2vY7Og"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DA740DFAE;
	Thu,  9 Apr 2026 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775693287; cv=none; b=qTh6JYsKvWH0VpeAC9wntCMifdIzG0z8byiLoQj2HX8ozStsqrLTF74YG3VUUWSh85XGWNvi4fFNDxA+gwsI4hbaZXkVmHD8CcEV8iesovLsfZ9yaZ0iEKNT0a1zkLoqY9Z6XLt4c18imGz5BX5pr/xKo9UUcw6DYzDZJgjkNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775693287; c=relaxed/simple;
	bh=2qtx3fjeOwwKBhwYPNsdmNR6dIyaw6+iCdUQ5M1wnSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WStaPddeM/2mYGYH7t+NYI0InFYAEro498v8N7z8mT9xWG+HzXQ4qyqDTI+GcPC8ctVQunWfhQJX/AQ6bAeeF1XID4YSRGnEQuZoD7e7CeicULs0zNSwsjcIseI6XZ0ffkC6AVq602eCIpLMGVXqtk5GFIxuUL+1XHj/8xVMb8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb2vY7Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C872C19421;
	Thu,  9 Apr 2026 00:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775693287;
	bh=2qtx3fjeOwwKBhwYPNsdmNR6dIyaw6+iCdUQ5M1wnSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yb2vY7OgZpto/u5jaGdGOS2lk9ReFhLK+lt1O1/AotrCYv0C2m9USfRf8ZY4ts1Hb
	 Cu2Xzb5b7VXPZZHosC+2Qhn7F+3T2Ct0bN0u8txj9m4eF0vIC1oL5I9h6X8a10eIWI
	 zKv+pl0N4aQcHDRJ7/r3w5IZeajD5keUtxTjhzfoeOG2k1tNLWIA1BRUrAxm/OHxIj
	 ECyx2wzQTnDbS1k3nX518SWKR3meQR+n6JUn1f9g/zPC3+5a+nnLO73Ti3Z0+qQivG
	 KTszHWMwcgk1hqio5I/x2zZfZ/zwzgNreFUmsNSjwZTCmOe6h6NLs91W4LhIlzV7aN
	 opYWBjrc2yvhQ==
Date: Wed, 8 Apr 2026 17:08:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it,
 paolo.lungaroni@uniroma2.it, nicolas.dichtel@6wind.com,
 justin.iurman@gmail.com, linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] seg6: separate dst_cache for input and
 output paths in seg6 lwtunnel
Message-ID: <20260408170805.03e6562b@kernel.org>
In-Reply-To: <20260409012708.78040268c05e3285742157ae@uniroma2.it>
References: <20260404004405.4057-2-andrea.mayer@uniroma2.it>
	<20260408032039.314762-1-kuba@kernel.org>
	<20260409012708.78040268c05e3285742157ae@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276754-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,uclouvain.be,uniroma2.it,6wind.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC65B3C4E44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 01:27:08 +0200 Andrea Mayer wrote:
> It does seem orthogonal to the dst_cache split and worth investigating.
> I'll take a look.

I fingered the review send command, to be clear the series we're
commenting on has been applied already.

