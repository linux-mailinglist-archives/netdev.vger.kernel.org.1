Return-Path: <netdev+bounces-277229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKEfLxFw2Gk5dQgAu9opvQ
	(envelope-from <netdev+bounces-277229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:35:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C9C3D1DAC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4F7E300B8ED
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E122317158;
	Fri, 10 Apr 2026 03:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RezecpH5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7327456
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792140; cv=none; b=lWYiB4Da/0D28nrIxSqP7QL5Vv6rEEMU+6GlmDsefQG/UIBf5YuWcEbT3Y/6t1T7SA3q9SQ53dPPY1OGCtx+tkZC72ni03p/D8Z/ExzdBq0rEK9Ox6kf/+UBF+n53I/2yS2Joz6wxKCvNiI5JN7rS8MnzHGzs5lTspD8XuPcCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792140; c=relaxed/simple;
	bh=7bklhLbfR1ys8v8hxfDXtHey8Rp/a8UoInTCx1wqcss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7mxJmYP9nzEcpcXrlLFIFDvsBE9wykH6JUKaqwuDDFKL3tx2owuZ+9qkTG9SaYJM0IpgznPax5Q5tPz89La0nxReIsZ6oVV3Gbi8IgkwTrv9h0IDMLsGopRmDh7kMkyDjY8RUrM/8QPT8idPgowogWkgE78hBZojhwXoC+rfgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RezecpH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A14C19421;
	Fri, 10 Apr 2026 03:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792139;
	bh=7bklhLbfR1ys8v8hxfDXtHey8Rp/a8UoInTCx1wqcss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RezecpH5XGi6zJlQAcDlO/E+mA+cVXKG+mfp4mZiDMciX5ragKG48onb2lUJFpC7E
	 KGSRkd5LAKOSD4RYXygMWLdnLmAqszsTX4am9u0XjwdhDmlzClAyrL+VVNTWy7wzbh
	 VsS262mEGEoEC09+dmOqb088xofYlVpOgomWGLAgEJFSMfva2/AR4DQUNEAZAQ8o0o
	 LH+broIy0AV4uYEPLkHjKtRBIWboIAqbhkVPCOKA6loQA/cG+Q4Bb5yLtu+eQ1IlcL
	 uAKwZnM/PaTIRISkqinYNhPOxfl7VKkfPx7zbjdzf4Gm92IKp75/bBkAgSsGvKqota
	 ZeBqf8vbco5wQ==
Date: Thu, 9 Apr 2026 20:35:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Xuegang Lu <xuegang.lu@airoha.com>, Simon Horman
 <horms@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] net: airoha: Add dma_rmb() and READ_ONCE() in
 airoha_qdma_rx_process()
Message-ID: <20260409203538.35337631@kernel.org>
In-Reply-To: <20260407-airoha_qdma_rx_process-fix-reordering-v3-1-91c36e9da31f@kernel.org>
References: <20260407-airoha_qdma_rx_process-fix-reordering-v3-1-91c36e9da31f@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277229-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7C9C3D1DAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 07 Apr 2026 08:48:04 +0200 Lorenzo Bianconi wrote:
> Add missing dma_rmb() in airoha_qdma_rx_process routine to make sure the
> DMA read operations are completed when the NIC reports the processing on
> the current descriptor is done. Moreover, add missing READ_ONCE() in
> airoha_qdma_rx_process() for DMA descriptor control fields in order to
> avoid any compiler reordering.

Sashiko seems to have more orthogonal complaints FWIW

