Return-Path: <netdev+bounces-287759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADhmJagWBWoUSQIAu9opvQ
	(envelope-from <netdev+bounces-287759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:26:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 225F953C56E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA8BD3030D39
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 00:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79F828641F;
	Thu, 14 May 2026 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLs7QubT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476E282F2F;
	Thu, 14 May 2026 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718373; cv=none; b=RHJCVyKEKzogIR7Gpgo3Rx0ZNp0nYQ98Nu98ktY7MqCydlYakyXRRcQBu/J72vmyI4RDKwoQcvDF8J8yjUuq29iWMJH0c1z+g3O7ims6FUFK8tsKGVrlkamHzgQtp8uUhMzkRvTA/5rim26R3G0B9CKE5QmikP2MDj2l2yTODCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718373; c=relaxed/simple;
	bh=dfLlsE5ugU7pDsQEXdX528yXK2CP7H4o3e4kFKOeTBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIMin+vmVjQPxuBuSJv5WAJE9bC2o6TYPKI48Mvyd6hzWvxrS+SbpB/8N7RVKeCPIOuaIp8MfwlWVQm6CKTSFiDIHuUxGTqRUVFsbcgooQX89ArlO1eQoRIPx+LEcav7SJ86Gvl85QJsSk/bI+ckv1ZBaK3RSixCuijeWPSihWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLs7QubT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9F0C19425;
	Thu, 14 May 2026 00:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778718373;
	bh=dfLlsE5ugU7pDsQEXdX528yXK2CP7H4o3e4kFKOeTBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CLs7QubT8WDKNuTPf6s93dA1N+HnSy5BadtX/Z9bxPBeUTemrAC68lDUKvZwJDpW9
	 HRika1wqw/3KSRquPqD93VIClewTs/H4Siy56T4j2IiGdQDMm680n+NAumKhBQiMW6
	 hi2aZ8kEEZzL6+eLYpxV2r0oPfk/dviWQMw7EdlFrK7Z0z4MHtrclPuq0gPJXI1TZe
	 mWX2NSf4j3cwrx15F/y2AkmvxhkxvXH5cGzhGDChqgNvydtBBppyaV0izU86N8ym+c
	 GwtMZcE8nipS+2Wq2XlDfaNTfopljqP8jbqDQg3/u+bATUsyrpvxcJdS/BVtKk/LWo
	 l6z2XpFzprO+w==
Date: Wed, 13 May 2026 17:26:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net] net: Clear skb metadata before LWT xmit
Message-ID: <20260513172612.6dcc5887@kernel.org>
In-Reply-To: <87jyt78y93.fsf@cloudflare.com>
References: <20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com>
	<20260430173153.5cd1d348@kernel.org>
	<87jyt78y93.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 225F953C56E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287759-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 13 May 2026 11:17:12 +0200 Jakub Sitnicki wrote:
> I actually wanted to double-check with you and Daniel - is consuming
> metadata from TC egress supposed to be supported?

Not AFAIK, let's see if Daniel has a use case in mind.

