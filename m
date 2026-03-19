Return-Path: <netdev+bounces-269381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMPtBPDCu2n1ngIAu9opvQ
	(envelope-from <netdev+bounces-269381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:33:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D742C8BBE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBFB23011A7E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8E37419E;
	Thu, 19 Mar 2026 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="W/vFM7XR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3etQwQ1m"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977836BCD9
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912683; cv=none; b=ogw7iJ1EVU2UOY1tjo38VtSs3mYXAp013ASDlu1N8FqvmDEPaXUpnKpH7xVGS9/MilENRpQaiHh8Ffq8VhGLa97GI7/n1FIyAv67Gx59xB+6zBnuq9a7k8IQUQW2444i9uLv8P9149iQkNHCsJaHA/LD/OetxMvySkhx2cgI38I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912683; c=relaxed/simple;
	bh=g0UxsdjxOubFnTre0WWAoZemhlwBPWubs5+CfWaZws0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s25OztUkiu+vVzWnO+mXatJMTfQsv48TjGOlrR/Z9s8AzLXSgT4gHEbUwxvv/IDwRjCtLF300Gvb6ZJBtHiaWv51Csmi9NcvN01ofmhDlPSd/JUaMpJM67Ue1pHkQVbTnOcx5aBGP8pTWzy1oZC5RfYm4ElLTyRqF78ipaD8XR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=W/vFM7XR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3etQwQ1m; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABDD17A01F7;
	Thu, 19 Mar 2026 05:31:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 19 Mar 2026 05:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773912678; x=
	1773999078; bh=sklSja91ZrsragPCLIBWZEBM9NRmmC3AzswbyXGvzac=; b=W
	/vFM7XRhsq354zRAlkxI/rqyd1t6ebaG9nuDR52rmdjx+sA6P2J3IRfvIACp3SHX
	OJWc4xuRM9eVCJxqBjxKteGGm5rd5u5YfqJPuxREAgPY1oGPaB+BX8Z4FYpeh13S
	LX3h6Kd2qEIhP1jkh8oYmwvN57vnI8uVpM70fOZrEg0gl/QdlsgQ7pyb0zxqFNkj
	XMgvOMdGy+GwnB4jK53KTO9W8Jc5kb4dYgZCu6CkOjCGL/ZdN3UlXW36xkza+UtT
	5rd5N0+E2Jriiq/VMbxfSpqCUnCBcgcSLJi6O9atvdkTssMtjg9V5fP4wHPfgTOS
	7VMatt6+t95qS83NAq8HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773912678; x=1773999078; bh=sklSja91ZrsragPCLIBWZEBM9NRmmC3Azsw
	byXGvzac=; b=3etQwQ1mQS8ewFqrILRA4TflYGzNbPIdNCul6BpBJWkgY7jcvg0
	nQ8howvJ6X67Zz5CEgghDrG0+tnW1XObQFxEQSICzM8V30o2OuRtGDtMV4XvMU9I
	bXM/V+g/dbUAKQXf/wQHGbya7eKkXzDryCDjHctEVyfmPoskzQj1s+Q+D6CH0Zc0
	qLXqoGuIJz5XllRuPBvxcGHWIcs1WMobBOh12L2I4GrevU32WaSv+C2o65wjVwTK
	1XoMFyVO9tVlx6Y+Go0z5iAKLa16hWaQjHgR1QA6QlDsFC9BOKd2w5kGAwuR/7uu
	vEPNavruX6uy4iXYdy00fMQSkHKGdcYnOXA==
X-ME-Sender: <xms:ZsK7aVXYT9fARZHb049iHS8657wkL7LgaEtOfx9CDwXgE7Zm8qBX4w>
    <xme:ZsK7ack65vBR2OiLzAecXYVBcL_Qr-XUTzYWWfUI6FaQLr93ZqsxGZlHo5F2hk5_3
    yIboAthcXG1HGmMnD-XNIPn9dTmm3nGwyFNQvhkqLNltuhSPaotAGfo>
X-ME-Received: <xmr:ZsK7aWarDVhN1BuJAPjz038xEHOZEVtaONg9Ba6BRqvbCZNJqhUZzRdo8GHS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilh
    drtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjohhhrghnnhgvshdrsggvrhhgsehinhhtvghlrdgtohhmpdhrtghpth
    htoheplhhoihgtrdhpohhulhgrihhnsehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:ZsK7aXOs9xSGSs1jGDOXHCa3VhzLKxyQ3M3CbJ3wk9GyqRWHXyDYTw>
    <xmx:ZsK7abb0qNOXm--ZAQUIa9gUsgjVCU0wpoc0e5PJ0mFkslQ5U7TQLg>
    <xmx:ZsK7aV0DKqV0mou274OyBbLhEM7L8-RISyAtdTWPhTk2g6Bz-IByZw>
    <xmx:ZsK7aRcQkFnTpknbDjfqG0Uurt9xUDLU8ye54sx-mCZjpwLYvEWgNw>
    <xmx:ZsK7aQ5a76KgpkV-FhGfvGXs9v7TT1JyFQyC-bJj3W3qKYVIcOwas3zM>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 05:31:17 -0400 (EDT)
Date: Thu, 19 Mar 2026 10:31:16 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
	Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH net 1/2] rtnetlink: count IFLA_PARENT_DEV_{NAME,BUS_NAME}
 in if_nlmsg_size
Message-ID: <abvCZH5vS1bG6kkM@krikkit>
References: <cover.1773829376.git.sd@queasysnail.net>
 <c8acbb1f4f3651f50fc4f5ddee234f1ea6769588.1773829376.git.sd@queasysnail.net>
 <F93F0AB8-E659-412B-AE27-83488A711490@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F93F0AB8-E659-412B-AE27-83488A711490@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269381-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 60D742C8BBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-19, 08:59:47 +0200, Sergey Ryazanov wrote:
> On March 18, 2026 12:45:52 PM, Sabrina Dubroca <sd@queasysnail.net> wrote:
> >Commit 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
> >added those attributes to rtnl_fill_ifinfo, but forgot to extend
> >if_nlmsg_size.
> 
> Nice catch! Please find an implementation question below.
> 
> >Fixes: 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
> >Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> >---
> > net/core/rtnetlink.c | 16 ++++++++++++++++
> > 1 file changed, 16 insertions(+)
> >
> >diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> >index dad4b1054955..a116362f5f32 100644
> >--- a/net/core/rtnetlink.c
> >+++ b/net/core/rtnetlink.c
> >@@ -1267,6 +1267,21 @@ static size_t rtnl_dpll_pin_size(const struct net_device *dev)
> > 	return size;
> > }
> > 
> >+static size_t rtnl_dev_parent_size(const struct net_device *dev)
> >+{
> >+	size_t size = 0;
> >+
> >+	/* IFLA_PARENT_DEV_NAME */
> >+	if (dev->dev.parent)
> >+		size += strlen(dev_name(dev->dev.parent)) + 1;
> 
> Shall we use nla_total_size() to account alignment?

Oops, thanks for catching my brainfart (it's not alignment but the
attribute header). I'll send a v2 later today.

-- 
Sabrina

