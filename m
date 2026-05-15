Return-Path: <netdev+bounces-288145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJyYIyF5BmqAkAIAu9opvQ
	(envelope-from <netdev+bounces-288145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:38:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51165548755
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCBCA302257A
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F43372683;
	Fri, 15 May 2026 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0GEMmNs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E14370D6A;
	Fri, 15 May 2026 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809114; cv=none; b=Ro5Tl7GOkrdQ6EAKj7PB0SY6/icnrhIXyPDPfZILW3EAzUEoDLK2hmUYX1/ZgpmNNG3l5tO03f2+1SkNWmdD+4jY9d0zWbAptpIR1ZDtrBeWO4ao7ogcwcu4CCvOsqN+Vzl7fOuTQYoe0/cOMlsc6Swt8oqQOSBxgOV2ZVioHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809114; c=relaxed/simple;
	bh=6SrZGAjBUDtzYQSjFlS6ciMmxBTFTh3sUK7/TLer1hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGWOf521S04Rhud1+iWlLNTYrV+OPEd3itVTqcbT7VlsxfNa/kxKkzfkEctD9BbIIi76s8asW7SOoUQVlZtZpdd0YBPvVovJFt8Bei5rReWMPCQ24BNuPf605vi3scj0NvwqoRX22TIFLLTzUL1RegYyCfvrJzL+0B0PzfVO3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0GEMmNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B7CC2BCC6;
	Fri, 15 May 2026 01:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778809114;
	bh=6SrZGAjBUDtzYQSjFlS6ciMmxBTFTh3sUK7/TLer1hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F0GEMmNslm42QdVCzb4dq/8nj2+dK6I2jJJ0jmQprKfnqJTIOZHTI6nVvjxPyxVjU
	 xw7U5KdWoXK1HuVTC0gfcD0HIf53n+QgJgUThvEtGzbsLC4DyBUdSL1aYTjRALAJ00
	 HbgLSj1kTp3mjRh2dm5iuUsf0pLCd0zjH/fD/zZfDS2ZDdWBGNj01TGE/sND1PSimU
	 k+FnQdrd+XwFzcNYyPR34qO4hmNW2rv8YwcHETXOdS+IOknqJvMuQDWw+TvKO9G+Kq
	 XcN/FYtIRpgFQJesSC/AguaC7gY/EGXucuplt7gQ0+MUa7fDZD64wek685df5RevWV
	 dU5G2wfghZwhw==
Date: Thu, 14 May 2026 18:38:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Amery Hung <ameryhung@gmail.com>, Martin KaFai
 Lau <martin.lau@kernel.org>, Dimitri Daskalakis
 <dimitri.daskalakis1@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net] selftests: net: Fix checksums in xdp_native
Message-ID: <20260514183832.5ef205c1@kernel.org>
In-Reply-To: <20260513072355.1083381-1-noren@nvidia.com>
References: <20260513072355.1083381-1-noren@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 51165548755
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288145-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 10:23:55 +0300 Nimrod Oren wrote:
> Data adjustment cases failed with "Data exchange failed" when using IPv4
> because the program did not update the IP and UDP checksums in the IPv4
> branch. The issue was masked when both IPv4 and IPv6 were configured,
> since the test harness prefers IPv6.

Oops, maybe we should run against both IP version after all?

