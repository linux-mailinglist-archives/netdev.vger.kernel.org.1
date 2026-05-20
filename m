Return-Path: <netdev+bounces-290131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOpgFUJJDmoM9gUAu9opvQ
	(envelope-from <netdev+bounces-290131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:52:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B4159CF71
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B43D9314619F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581CB3C0600;
	Wed, 20 May 2026 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNbtxols"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084293BF665
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320043; cv=none; b=h6wXj09yx8g0djYSvkJ38OxeGTuDOJisb8h50SJgZ0mAQyxHGTLqkNcJqgv+8xWtgOqq1EaVzBPQoPZIIAg8YchV7h3oq4EsxJ918bkqlq8kL4pVT+Sq0CuRjEt/4StN5EqruH+uxu9MXT2YnCqmubxTGTFYGqwZWv0KolDtsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320043; c=relaxed/simple;
	bh=3ihbkgf/GRMLNZARgg66/Us3ArMauzPsIerUR9v6piM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyg5sMK3aYMPUA+sXxLXYTsjD1n7jqQnaL/Hrrm9tv6Sf/rqCApel//K4wqOMYfHKQ/hciKaTEWyVMl02KD5xsG2z1wDEVOxCRjbu+EFpoLKHZDO6sMffJgHUNp1r4z4o/9v1p0rE0Z033ODNoGb53ZAaGe8ImxhkQFjD+B+PpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNbtxols; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0C71F000E9;
	Wed, 20 May 2026 23:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320041;
	bh=0shzrTknhkac4cyolV3ejF0Sew8mao+ZQFoxNbH24D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aNbtxolsc+AF7FtqMjYXqrnygFGco5gcihV91/JI99EdyzvrRnetvO+OvN5BUc0+u
	 YxY566v76KzBgdfkP5whnff0VJmaGYAGT12T+/WQRt5NLFdOHlDKifiTdGabf3xcLO
	 E6YtNv0NxgsPaatDK97i+NIGiY5Ekdj6jubBo4ZZrduKQaWXO2XuWfKnHjS1SD8xDT
	 VX/odqjYfZY1ln7wL/DE2BQ+VZgmBgzF3W9vXX5qWy8SPVem68H5sFMZDudIuBdnkN
	 7QADLdy/Q2tGU8rZqdaUHaHzaAzripI7sfymLorO02N6DbC1VE12UqDrb2wFnnUNeH
	 TgIBkk34/GEXg==
Date: Wed, 20 May 2026 16:34:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, hmohsin@meta.com
Subject: Re: [PATCH net 0/2] net: shaper: fix VALID confusion even more
Message-ID: <20260520163400.72c24ef7@kernel.org>
In-Reply-To: <20260520195428.GA1506108@horms.kernel.org>
References: <20260515221325.1685455-1-kuba@kernel.org>
	<20260520195428.GA1506108@horms.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290131-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B7B4159CF71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 20:54:28 +0100 Simon Horman wrote:
> On Fri, May 15, 2026 at 03:13:23PM -0700, Jakub Kicinski wrote:
> > Sashiko reported another pre-exising issue in the previous
> > batch of fixes:
> > https://sashiko.dev/#/patchset/20260510192904.3987113-7-kuba@kernel.org
> > 
> > Turns out I over-esitmated the guarantees of the XArray flags.
> > Stop using them completely.
> 
> Sashiko suggests updating the wording of the VALID flag
> comment in net_shaper_pre_insert as part of the second patch.
> But, TBH, I don't feel strongly about that.

It's very picky about these comments.
IMHO the word "mark" is not reserved to exclusively mean xa_mark
in case no xa_mark is used by the code any more.

> For the series:
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks!


