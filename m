Return-Path: <netdev+bounces-268349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDpIDfqauGkzggEAu9opvQ
	(envelope-from <netdev+bounces-268349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:06:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC72A2289
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7DA130095DE
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2E182B7;
	Tue, 17 Mar 2026 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycwc6beg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA34C81
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705971; cv=none; b=VwuX/Tqo1GF7AuhMoM197QgRC6xI1dQ1uBQKF6hb2kNBEF91WNKaok+rbWq+nhzD5JagbGDpXl2RIfr4G9YFgGaLSEysZpsFlF9CD+wA33MjDZs1fi+ED/jfDQ7E64+qPtBA0K0uWniXGuNZEVESpHzmQygY5jKBytpcJ9Dhut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705971; c=relaxed/simple;
	bh=MKPLLfZ/i0guSO0VBabzX9UY15KD6EcsdAvkxTBr+1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1SC1/kCuvw6AVyiSodYB4TTDCZm6fACn5kChyClMZ+tKJIc9YkKjrRQa+qGOwiJSy6SAd+kD7DLE4SiKq050fXB6OMipGhvEVbo015sKk6l6p37BDsz9PC8Pw8cY6R67AhQJiY3Qi+jyyMbS/ms6Cwv0GVblTLLtOHsZcPVUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ycwc6beg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4451BC19421;
	Tue, 17 Mar 2026 00:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773705970;
	bh=MKPLLfZ/i0guSO0VBabzX9UY15KD6EcsdAvkxTBr+1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ycwc6beg1E/5m5Lby8IXYo2n6/i3LNdw0eSaKTun7U9tM8c0x0m+48Jq2H+hJ59UM
	 xTTmO3JEikurTPu0lbVPgi1+H0l9c3mjD7V34Ykx/AzGktzgoIYQH1HT7iu1OxVyoX
	 xkgt/gk0W99Px+TwOTyAXOGT0QELxC1bzHjkQkC1EfePW+dCtsRSPD0lHQW9gLI8XY
	 /770ySXKK3HDOzjGAiVTx3O3X0C8VuOM+K8E25qAuPWoCujl8ZP94LPpi6kv8MQspc
	 xOSBc4HidiI7C/ZjGnYIqdR6FFb+qyHLeCwIlmiLxhlL7R9aP7x75wotc14sGcZeaT
	 0WWyvYiYx0P+w==
Date: Mon, 16 Mar 2026 17:06:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net] udp_tunnel: fix NULL deref caused by
 udp_sock_create6 when CONFIG_IPV6=n
Message-ID: <20260316170609.6636d621@kernel.org>
In-Reply-To: <20260316005337.1147633-1-xmei5@asu.edu>
References: <20260316005337.1147633-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-268349-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26DC72A2289
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 17:53:37 -0700 Xiang Mei wrote:
> When CONFIG_IPV6 is disabled, the udp_sock_create6() function returns 0
> (success) without actually creating a socket. Callers such as
> fou_create() then proceed to dereference the uninitialized socket
> pointer, resulting in a NULL pointer dereference.
> 
> Return -EPFNOSUPPORT instead, so callers correctly take their error
> paths. There is only one caller of the vulnerable function and only
> privileged users can trigger it.
> 
> The captured NULL deref crash:
> [    0.489638] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [    0.489962] #PF: supervisor read access in kernel mode
> [    0.490193] #PF: error_code(0x0000) - not-present page
> [    0.490435] PGD 102a11067 P4D 102a11067 PUD 102a12067 PMD 0
> [    0.490706] Oops: Oops: 0000 [#1] SMP NOPTI
> [    0.490905] CPU: 0 UID: 0 PID: 140 Comm: exploit Not tainted 7.0.0-rc3+ #2 PREEMPTLAZY
> [    0.491266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [    0.491786] RIP: 0010:fou_nl_add_doit (net/ipv4/fou_core.c:590 net/ipv4/fou_core.c:764)
> [    0.492009] Code: c5 48 85 c0 0f 84 04 02 00 00 48 8b 34 24 0f b7 44 24 1c 4c 8d 44 24 30 b9 07 00 00 00 0f b7 54 24 0c 4c 89 c7 48 89 6c 24 28 <4c> 8b 6e 18 66 89 45 0a 0f b6 44 24 10 66 89 55 0e 48 89 75 00 88
> All code
> ========

Please trim the crash dump to what is relevant.
-- 
pw-bot: cr

