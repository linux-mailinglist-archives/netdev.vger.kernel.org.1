Return-Path: <netdev+bounces-277057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM6oDivO12mrTAgAu9opvQ
	(envelope-from <netdev+bounces-277057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:04:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D518C3CD56A
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 18:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 979BE30E37A4
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620ED3DDDD1;
	Thu,  9 Apr 2026 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMlFmv4h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587833E1229;
	Thu,  9 Apr 2026 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749859; cv=none; b=SFwMSjhMiZzNHPYtIo6oYtcf3MU/NtIFT2JhmZYWlBSSrAhJyKC3OqnzTRaNCQr8Vz3hrSUwB1BMk7rkXPlun7i+B8K3Tb9N8HzCUXezqRCkpTTIjuGG3RCxaOw+lwFhG3Cb4oi5MKv34MxjyUOWJGvgA5jnMPuh+CMcOtT0hZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749859; c=relaxed/simple;
	bh=P8/TwooUzepzV7tRpsVrGGoS6hHfaOLwSIzl/V7Hhgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pR7HW8JDrqVbh5Wd4oQS6CxnKqGskfQrTBvomHgcfyCaPJo58X56lrMmBDmqVZh9v64yTVr178JHwomaDG8DAPFn2aB0RSUUemhbO3HsUTAxnyVWvt9le43ctrOaINkxQWnlMWuMpeMQsSWDSmnljAT0sm4S3EvA4G5D/mOEXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMlFmv4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAFEC4CEF7;
	Thu,  9 Apr 2026 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749858;
	bh=P8/TwooUzepzV7tRpsVrGGoS6hHfaOLwSIzl/V7Hhgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nMlFmv4hsj2LmhRBFVGPGfSA/euT81QmPB/WNtWGp1Hyem5Q+Lefg1cz68UkVqNav
	 6SnQu/ueUp0oHlAuezbbTOKAL49KC0HIvhyDVraXHt+1nr23HXRPZ2+ygnRk0zos67
	 u51rgNC7yJyKOHYbW94DY58rVkm8dFSzWUxH9uENVpf1ux5yMaE2ssM78/by9AJmbr
	 djTYZTxWR8n8itADJNGI8OweVkBgFTfw16dxGCte2Y5HaSsSVit5FMejsZcb/zD1Q8
	 tvBj2Gft3RxBW1O4hA8sELhMiQj1aEVT1dQORyon3AvCbKR0qyM+CAQZ7OV5h55t+P
	 MAce+qw5Ix0NA==
Date: Thu, 9 Apr 2026 08:50:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Michael Chan
 <michael.chan@broadcom.com>
Cc: "David S . Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Petr Machata <petrm@nvidia.com>, David Wei
 <dw@davidwei.uk>, Chris J Arges <carges@cloudflare.com>, Carolina Jubran
 <cjubran@nvidia.com>, Dimitri Daskalakis <daskald@meta.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: Add ntuple (NFC) flow
 steering test
Message-ID: <20260409085055.0834111c@kernel.org>
In-Reply-To: <20260407164954.2977820-2-dimitri.daskalakis1@gmail.com>
References: <20260407164954.2977820-1-dimitri.daskalakis1@gmail.com>
	<20260407164954.2977820-2-dimitri.daskalakis1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277057-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,broadcom.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
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
X-Rspamd-Queue-Id: D518C3CD56A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  7 Apr 2026 09:49:53 -0700 Dimitri Daskalakis wrote:
> Add a test for ethtool NFC (ntuple) flow steering rules. The test
> creates an ntuple rule matching on various flow fields and verifies
> that traffic is steered to the correct queue.

Hi Michael, how accurate is the stats refresh timer in bnxt?
This test is seeing ~10% of flakiness on bnxt, fewer packets
got counted than we sent. Could be something else but I suspect
the stats just didn't get refreshed. We give it 25% margin right 
now.

Dimitiri, this skips for some drivers because they don't auto-enable
ntuple filters. Looks like other selftests have the same check and also
skip in netdev CI. So probably a separate / follow up task but I think
we need to add code to enable the filters if they were disabled.

