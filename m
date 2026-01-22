Return-Path: <netdev+bounces-252166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMxqG5ubcWmdKAAAu9opvQ
	(envelope-from <netdev+bounces-252166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:38:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 572976161B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD8714E8514
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA5407595;
	Thu, 22 Jan 2026 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqsSh9wo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84740B6DB
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052746; cv=none; b=QF2A4Nuqhz6cgSL42nLAxNixvSqWivsS+flUaSKzaRCTt77jK2ZFCiqfK2KIQ+9vx3psIe1EmXZvEdqwlMEMrmWX95KdfcBj6CrQD2L8NQ1iGI0PV1s9vHZ1BnvM2s9YAieb/YXy9RhVRqE1sOuzhKjZFsZLV/3xAUneFQv152o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052746; c=relaxed/simple;
	bh=u7y2KMW8O2BVH5WTXNsp2eBYQ58Awz6TWOuNBVskIKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGwtivPcirHZESIIzFfJSrSa+KIYEzSxWrIbXky538mr77CEyzEYGoCH9Fh1c4uv3nd1qaCGhR4dsDLB53S1kPkiJ8pZzV2TZ72gllDjRH5UYcP3sAsCCn3F9yKfXV6z7vYGjtMWMD8ShvxrMCoJBuM1Z4fYGYnucMfCEszRPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqsSh9wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E68C116C6;
	Thu, 22 Jan 2026 03:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769052746;
	bh=u7y2KMW8O2BVH5WTXNsp2eBYQ58Awz6TWOuNBVskIKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KqsSh9wos/1xrjz+kqhtq5bBMDWImdzwtjpQHyjoQZcBRbBYLS1QQ1J4ef/Y9v6WG
	 I++wUKCHxWMwYae1zdD0dgCawIyjHDTam62o85TjwNAXthx/JENdj/LieDe8UfYBVa
	 W1ZpPNC6cUtkOBmy9IcrjVqVOhRQle7D1VqqTyb9dedrZaZF2YmdPyMDVLqPurAQbd
	 i3jv7wiZKic783aAh81I7KWdQ9CeJfqI+2zNsO6NyX8ia0JtOpTrfupsBN6w+RdXaC
	 XxSO1rtD7tZgdnqQhXvwO4HpP6vAmkkSO8GHy7l8ryhBFVpKIy5MJ9+HMtegZG/I4h
	 sxzq3xeDavFSA==
Date: Wed, 21 Jan 2026 19:32:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v2 2/2] net: bcmasp: streamline early exit and
 fix leak
Message-ID: <20260121193224.3bbd497e@kernel.org>
In-Reply-To: <20260120194154.2047656-3-justin.chen@broadcom.com>
References: <20260120194154.2047656-1-justin.chen@broadcom.com>
	<20260120194154.2047656-3-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252166-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 572976161B
X-Rspamd-Action: no action

On Tue, 20 Jan 2026 11:41:54 -0800 Justin Chen wrote:
> Fix an early exit cleanup leak by unregistering of_phy_fixed_link()

Fix should be extracted from other changes and submitted to net..
-- 
pw-bot: cr

