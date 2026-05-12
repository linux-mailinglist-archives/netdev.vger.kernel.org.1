Return-Path: <netdev+bounces-286906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFBmLVWEAmrVtwEAu9opvQ
	(envelope-from <netdev+bounces-286906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:37:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 128825184E7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF9093007B05
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528BB2749DF;
	Tue, 12 May 2026 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy9SIF3X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EF24E4A8;
	Tue, 12 May 2026 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549840; cv=none; b=HHbeUu/Rj696Z4u1IUV0i3bQzRlFRRcH8xONAS6v1RcjiMPfHhTDIndOBHvTaT2YYyf4FIb1anRl8f++u8wenxvlywWt2QWk6ziNUSqNP53s3DeriMapZkISpjJlqWxaJxody1upi/X26dpT6QEpnzTGyonxeEe/TjfJNufKG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549840; c=relaxed/simple;
	bh=TLQ68pdwL/vWkN44gprH1W/a8BUbi1ManMfs36l9l+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSjrKPiQaVybU7jZGOMPxcn+8kAeiuBCZ9VX1WKDyDzL9ix3IE2iraVFx9HF3/GsYX/K2PMGc0Yc3O/+6WS9kYScFHHCWP1qLe44iVGvDxVSAXnpcGDbdKVFLoNxryLwFsaLAHvKT6PcbC+uwOOiN2yIJPPo2ur6c4fZEzc+uVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy9SIF3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41284C2BCB0;
	Tue, 12 May 2026 01:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778549839;
	bh=TLQ68pdwL/vWkN44gprH1W/a8BUbi1ManMfs36l9l+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iy9SIF3Xbiyg3wXP/ttUEUfhkGrkP/0sW1Tv1pKvL6fPLSMgBBOEnacGgCCpMGEki
	 Ds4pTBoSNZS1gGAynVQ5ULhX1SXKpsIlz3FauCo4fT12sQlRhttieOhruZWsyStWi8
	 vxlq7uoriGM4YxjSxCWaR9DQSIMFJKWjc2BClDzB0IEHj1ex65KEp3AyUQt65OB/FV
	 WaZA3so7EeToahoyhiQwwglKy95h/BhdUlkMMfX29QgTQQFLAofrD7kHLrRMRUuCBE
	 f8NlfTQ7ZBAshNgM0HmBi4LpegBjTQCsEU5nXaL9k0RkGJn8aG6gqErCt1qxgqBGsX
	 SvigZezX7DsRQ==
Date: Mon, 11 May 2026 18:37:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 kernel-team@meta.com
Subject: Re: [PATCH net-next 8/8] netconsole: move find_skb() from netpoll
Message-ID: <20260511183718.04781b86@kernel.org>
In-Reply-To: <20260508-netconsole_split-v1-8-0f660e62841f@debian.org>
References: <20260508-netconsole_split-v1-0-0f660e62841f@debian.org>
	<20260508-netconsole_split-v1-8-0f660e62841f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 128825184E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286906-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 08 May 2026 06:29:22 -0700 Breno Leitao wrote:
> +EXPORT_SYMBOL_GPL(zap_completion_queue);

We should probably rename it to add an appropriate prefix.
netpoll_ or net_ ? And maybe export it as NETDEV_INTERNAL?

