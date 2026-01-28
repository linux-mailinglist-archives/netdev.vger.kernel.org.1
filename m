Return-Path: <netdev+bounces-254079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOuAIZh4eWkSxQEAu9opvQ
	(envelope-from <netdev+bounces-254079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:46:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 108AC9C656
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D03D300B07A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CBF219A7A;
	Wed, 28 Jan 2026 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbpmBqaj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E48BE5E;
	Wed, 28 Jan 2026 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568403; cv=none; b=hNvl6JT8a1MWVofJPyyOY6s6jHDHXd59K2e2Mxk4SoGV1XIwfFvkKW7lzCSK0nCffc3dQamzIXDgr27gB/ZTRcOmhul6KzOSwXNVBQYNCV1kI3g+V1hkSKZ5FBUOM1n+Ib+RWbkPEtrO0Mo8j/iEWjLGWuh0BnKnPD4VNEyVzqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568403; c=relaxed/simple;
	bh=6QutqYo8fc+TAuoksRVxjFskRI6tdobRyRccMe2sDRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WI/HBwbgMf8nYxbDGFAxjHlqAlhrLlR13pnuGJP7A8+NnMDrMvfNzfXQzfxw9tTylyOEWpK8NGHna3hgLuJQS81kEqSe9Osc5VTgtbm1SYfOe7R1oGTj9cGBV1UzY4gPKXxbDik2vui+aeQ+HmomyCZjIfk4vKLHnVLGsS6Uuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbpmBqaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C590C116C6;
	Wed, 28 Jan 2026 02:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769568402;
	bh=6QutqYo8fc+TAuoksRVxjFskRI6tdobRyRccMe2sDRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lbpmBqajkXlCsf6mKX2AwUX9NgojX2N3CyR1XGrLsADPzIoKm5V99M2tWgGEYG5Ev
	 hJbBSGJF5goifPez+MWyPg+Z6axNk4B7ILR5VCAuwBh6QDOiSlqZIYwgGxYOZOlbMY
	 Gyn5+7bbHZaxMZSYdRBMyc9oNkPPpq4oyrUMsPVbAolaWsxpX/Au4zOYg9n6KlFSHw
	 eh3VRxQOG3UFRe7ghkgZ9it63iZ6gdHU7+iGdD3ozo1SO+UQbf+1TN3c32WBCsNUsV
	 0HlX5PFSknrrYDw85R89t4Y5woOSI7a3MsMbTpNEhiXQAWG3ctVjpy7nP//65w6veF
	 aAIE44MPhvZ5w==
Date: Tue, 27 Jan 2026 18:46:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Aaron Conole
 <aconole@redhat.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Konstantin
 Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH v2 4/5] selftests: net: run pmtu.sh in netns to avoid
 host firewall interference
Message-ID: <20260127184641.6150e97b@kernel.org>
In-Reply-To: <20260127225134.304362-5-aleksey.oladko@virtuozzo.com>
References: <20260127225134.304362-1-aleksey.oladko@virtuozzo.com>
	<20260127225134.304362-5-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-254079-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pmtu.sh:url]
X-Rspamd-Queue-Id: 108AC9C656
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 22:51:33 +0000 Aleksei Oladko wrote:
> -	pmtu.sh \
> +	pmtu_wrapper.sh \

The real script needs to be listed in TEST_FILES now, right?

More importantly - please rename the script and use the pmtu.sh
as the name of the wrapper. CI system which track the test by
name will lose history if the test is renamed. Not a big deal
but seems trivially avoidable.
-- 
pw-bot: cr

