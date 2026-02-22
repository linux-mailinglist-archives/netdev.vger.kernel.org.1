Return-Path: <netdev+bounces-259887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hL7NMoQwm2k0vAMAu9opvQ
	(envelope-from <netdev+bounces-259887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 17:36:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B5516FA60
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 17:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEEB6300D31E
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 16:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301C13563DD;
	Sun, 22 Feb 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="kNOGYwJM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2ED1DF75A
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771778177; cv=none; b=MGwezdhjWoki13ZRhmXoAzKih82DNPMKCO4dHHRisLeXt+p3oMmkcLE8Zhizo+YimrJOTtXelOHeNwKEp1xi0OQJ9RisZqCMN8mzukn36OPKNceJVA2P8wq0kMhjjWrtJb79CLTPAQ9pk3DBxKQb8cPdROISl7z+z7i4s+5PlAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771778177; c=relaxed/simple;
	bh=j/hNrN8yCx2c4pErAxcUpIOPgDMVep0Bk1BF9TT9jNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsfolJ+HsiX65YUFDo1zYVvt5TnqLMio6y8wvjwk5nYKrJUxxev7Ik4LAV6J8g9js2MpUVmC4gjNDPN9wIGCbxArO9U/FvOa8sMwm1H4JxDu7blFjbW6Y49zI+JRNTlXzdS/JOJs/eOP9ZRyQRl6llNT7EJm5ke2jw1M4T+6Zj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=kNOGYwJM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso30273425e9.3
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 08:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1771778174; x=1772382974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xS9l5mc+XFl+nwoapUNzADH+s1Zoh0SwLY8LpTEI3o=;
        b=kNOGYwJMAtMS26+X9ILfgpi0iEKPjK3lQX2VgC1oQGaKhUw2i7J9m7P1JVzdwBJFPh
         qC6hr/sOQOcgpWkEwErni8nJbtjE7eG/uO9JvSSa1Af3a1Zo1gRjehvQa9AEuhio5b9u
         oo57NTvyc+gpVKYuzPjoYbEnnSaBRm35R6LkEc3kQImTkZxZBFWWX7/jJ5jeIzJwtlE3
         fva2PL96LXuZ7ae3anAAS89GujtdwBu4HFEkemWsw/0v6UQmq0Pj1CJuN1nuCdxCU9Bq
         Tbm8tenil6jAOOHvFWYdB7N474E2GJNIPW5iBhZFH80RYv46UgRYRS6psCzk+zM4I6OY
         4K4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771778174; x=1772382974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xS9l5mc+XFl+nwoapUNzADH+s1Zoh0SwLY8LpTEI3o=;
        b=ZgfukpKUFPUqlp8p6N63LeKyKVnOHQX/r8Jbf7laAgud0B0X6PcPZLY7s18Qj3RtG1
         560R/pg6h17CDWxZ6uo6TR5h8mYDDiB3N/TVQxADHlwub3uCdulvgUgGAglIAV/CAdW2
         +fn4lRJs2qd5ZgN5C4ymZR76JWGo9GayttWh+6TjqQwvy/RMAnLi7zYjoZUjUTzVWqX2
         kl71gmpniiFwM24QO6DVqSNqgG08EFjHosu2GWoCGEJ4fDLn16JA3LYT5FrLy8w0n0Cd
         DWKvbIZpWb63NhRyAN4wCdpmJhebEed1d6LALSzTEWNd0wICm5c5n099MkcrNBqGNKcK
         v+9g==
X-Gm-Message-State: AOJu0YzkACKVyVpmom1YfZWWQO3ee0OJnW1sR0JV3AYEgOgD8xiq2nWn
	ZXcyYJfgR5odKMSmERVXKaD6wKgxe+LiEKv4YzqA3PscN2GeRwKmmuW5q/qkOfvoBLo=
X-Gm-Gg: AZuq6aJasSh3EKSGglbD+303t+nrWdaqy0AU27GYOaoScYNR/uGnjRLeux9rKJTptqY
	uqX3ldKCaBTiiWe638nuFOdt6INamfTlRqPxFgq9apCTYpuTUMTyiXw+Ek744zQthe8Km7wpazR
	CwOWt75qmH/gYLMYohxdJzauTDWgdlxsqV91YpN6lPusDdj1TgLIzvopk461jRO0zMjdmS6yutr
	gjo7+vwLWw9hKlzZq9KIA2M+80PUGYWQrtH6yt/uR4l0WeQGOlJfr/BmEZBLx18/t1dkhC8j1bH
	SKopk0Dil2z4lPG3CPdUQkI31S80W9Ak1hr94vylEORo75MyR9i/Q4CSASdvTXxYizv5X5w4/pr
	Hjnl0f8v3yLNki8c9CfiyUyQm/bvwHHdteVqBgArUeFusHu0wQfPOjdYwzSc+34Op90K+AlY0EN
	uOierFfeRNMadA7sSRg89NVPC4qGPEj22iZo2iQ2HWd1DjaOwXD8VMUQZiuQ==
X-Received: by 2002:a05:600c:1e85:b0:482:eec4:772 with SMTP id 5b1f17b1804b1-483a963de9amr85845895e9.32.1771778173648;
        Sun, 22 Feb 2026 08:36:13 -0800 (PST)
Received: from localhost (176.111.181.192.kyiv.nat.volia.net. [176.111.181.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00e8bsm10865692f8f.15.2026.02.22.08.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 08:36:13 -0800 (PST)
Date: Sun, 22 Feb 2026 18:36:11 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net 2/2] selftests: net: Add bridge VLAN range grouping
 tests
Message-ID: <aZsvj1Zo7msYRRCJ@penguin>
References: <20260222085338.3143823-1-danieller@nvidia.com>
 <20260222085338.3143823-3-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222085338.3143823-3-danieller@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259887-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,bridge_vlan_dump.sh:url]
X-Rspamd-Queue-Id: F0B5516FA60
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 10:53:38AM +0200, Danielle Ratson wrote:
> Add a new test file bridge_vlan_dump.sh with four test cases that verify
> VLANs with different per-VLAN options are not incorrectly grouped into
> ranges in the dump output.
> 
> The tests verify the kernel's br_vlan_opts_eq_range() function correctly
> prevents VLAN range grouping when neigh_suppress, mcast_max_groups,
> mcast_n_groups, or mcast_enabled options differ.
> 
> Each test verifies that VLANs with different option values appear as
> individual entries rather than ranges, and that VLANs with matching
> values are properly grouped together.
> 
> Example output:
> 
> $ ./bridge_vlan_dump.sh
> TEST: VLAN range grouping with neigh_suppress                       [ OK ]
> TEST: VLAN range grouping with mcast_max_groups                     [ OK ]
> TEST: VLAN range grouping with mcast_n_groups                       [ OK ]
> TEST: VLAN range grouping with mcast_enabled                        [ OK ]
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../testing/selftests/net/bridge_vlan_dump.sh | 203 ++++++++++++++++++
>  2 files changed, 204 insertions(+)
>  create mode 100755 tools/testing/selftests/net/bridge_vlan_dump.sh
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org> 

