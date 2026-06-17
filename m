Return-Path: <netdev+bounces-299998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nlPZJSP7MWpytQUAu9opvQ
	(envelope-from <netdev+bounces-299998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 03:40:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB2695FB6
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 03:40:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yeah.net header.s=s110527 header.b=TxyMJUL7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299998-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299998-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yeah.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 136143088D30
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 01:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3326D2F7EE9;
	Wed, 17 Jun 2026 01:39:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA60264FBD;
	Wed, 17 Jun 2026 01:39:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781660383; cv=none; b=CuOmzFbUW4XmRneC3D20mlCeKfSlUqtniWPXW0JpEls/rpuwZYv1rZrjKON7Ulbk0k6AxQ/nYG7gwsTUZ3umGuoa5WBlVLt/dfKtZuNMdcwOozov8g8FTwOo1zYr526StcBLMQc8xNAX8z7aHdpqDt13DhGA8uRR/DR8Im97pA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781660383; c=relaxed/simple;
	bh=ydT0u7pW33C8hUhpXHRrmmFj4IELVDaYMa0bd0YrBCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idbl+qSEOyqsiG2uwyeCIgt+PZVstYT5yQfhaxWJmSFjMwlXnMCjlvEXCRCBkdd7bYybPK3yyNHaK4sTVrRVYSaSLoZEo9PUXAICTA9ueuCUJAz9Kda88w63FOThuNmJb9cgEPC81gnkaw3tvKZxC/RGORCtFlFFstMJ+2HFlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TxyMJUL7; arc=none smtp.client-ip=220.197.32.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=DU
	I92gSJzh7wQxLAifathUaMVceFfWoD3ivQELBGvaQ=; b=TxyMJUL7G3S6VrJYWf
	7j3koHWKtreg4+fRmQW3b5dm0Srng6YfXnW/K+Ri6+hpSGOmMz0bjBYeBzJBWsa+
	IJ9jntkFhdkYyqW7IcNC6ZOtew8hP57NyIR8QJBWkhzPLEf5loNUUA9Vl4ECgr5e
	Gj31ADO3U/Fwf4JXnN7vbaOm4=
Received: from zhang.. (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPSA id Mc8vCgDnT2mU+jFqlAmLAA--.44369S4;
	Wed, 17 Jun 2026 09:38:31 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: Re: [PATCH] rocker: Fix memory leak in ofdpa_port_fdb()
Date: Wed, 17 Jun 2026 09:37:52 +0800
Message-ID: <20260617013752.5820-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1446e974-0df0-4956-b2af-7a9403da3c8d@intel.com>
References: <1446e974-0df0-4956-b2af-7a9403da3c8d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgDnT2mU+jFqlAmLAA--.44369S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF13Xr4kXr48tr18JF45GFg_yoWfJwb_AF
	WvvFnIyw4UGFn7Aw4akrWjyF4ak3y09rykZFn8Xr9rJa4fAFn3XFn7Jrn2vr15KrsFyr9x
	ZrsIkw4fJ34avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiIhfKi2ox+pdxeAAA3L
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299998-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:jiri@resnulli.us,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhangcoder@yeah.net,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhangcoder@yeah.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,yeah.net];
	DKIM_TRACE(0.00)[yeah.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangcoder@yeah.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[yeah.net];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,yeah.net:dkim,yeah.net:mid,yeah.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEAB2695FB6

On Tue, 16 Jun 2026 16:29:59 -0700, Jacob Keller wrote:
> I looked at the surrounding code and I can't find any other place that
> would have released the found entry, so this does indeed look like a
> memory leak.
> 
> You could potentially verify it using the slab allocator stats and
> setting up a test where you add and remove port fdb in succession and
> see if the allocation of the correct size continue to grow.
> 
> This whole flow is somewhat confusing by combining both the add and
> remove into a single functional flow. I guess it is intended to reduce
> code duplication but it sure makes the processes difficult to follow.
> 
> I suspect the original code mistook freeing the searched entry as
> freeing the found entry.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

I don't have Rocker hardware to test the suggestion.

Thanks for the review!


