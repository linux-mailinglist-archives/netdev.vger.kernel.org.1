Return-Path: <netdev+bounces-266841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIdUC7IcsmknIwAAu9opvQ
	(envelope-from <netdev+bounces-266841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:53:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B368326C09E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A39A30420AE
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F8375F60;
	Thu, 12 Mar 2026 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww8yK/Uc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA991846A;
	Thu, 12 Mar 2026 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280431; cv=none; b=b5qMryCB79u31oplz9xEF1BTXnowUMCrr+qM6yGFDQdVMuiLyRKMejCpCGflNKhtIwBw2Z1s2pXcEFshl0ZdwAzxssxkH+jK1pNTO7t79rMoUMoB5e/3wt8+C09Lj9J+kbRK3FxEI0F7ct5+6cE6/H5x5l3i/pL9AKQ3Gp6gIo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280431; c=relaxed/simple;
	bh=rIJBeYtGh/oJMHX0mFZs6nFwvzQHqwAcHf5JPZv05DA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVkyJ0yME98NrkBErrXtiu7Fi5KpYuyZQnOwPhdF38dvfEZ/HYtLo5bASxE+1s2jl+/zLx1nHZxv0X1e1c/ikuQwTQ4YY2/DZug7xyUOTkIGPG5TTxo2PayL48Fg+YTHzZn+iHfnFypGT8iOKaIyQGSXocJBUG3Sn2gsVfgFHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww8yK/Uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6ACC4CEF7;
	Thu, 12 Mar 2026 01:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773280431;
	bh=rIJBeYtGh/oJMHX0mFZs6nFwvzQHqwAcHf5JPZv05DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ww8yK/Uc1RzrLQyLh2qBqZi9QyEyLSpVN1mFAdM2bHNfjkSpKy+H71V6cy5R3Xlju
	 BW6gaxpHf8Q4c0YuXx5T/NPPuw3w4dxbRT5Gwogz7px4ediSCRoxNATqUnsgShfNcx
	 LcqYkDQ+WwGrsQo/dDA0H8QhdHSPmU/uJsLbMVGJel0Mh1vlKNNdA6kzFARfdoa91a
	 fTpg444uSWmxUfhRWeddGT40x8u6K0FHvtuMCiF1sfnH+CbJ/HzAVeNGZofhxf6SRe
	 NtXmMDscyZyX770orT3S+n5RkTIVmG9ZWJpmuJQDMq/aFhSAUiW+lNCc8N+3TY8RmZ
	 Z1SjrTc0j7+pw==
Date: Wed, 11 Mar 2026 18:53:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: tobgaertner <tob.gaertner@me.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, oneukum@suse.com, bjorn@mork.no
Subject: Re: [PATCH v2 2/2] net: usb: cdc_ncm: add ndpoffset to NDP32
 nframes bounds check
Message-ID: <20260311185350.1e431e19@kernel.org>
In-Reply-To: <20260309203449.2594858-3-tob.gaertner@me.com>
References: <20260309203449.2594858-1-tob.gaertner@me.com>
	<20260309203449.2594858-3-tob.gaertner@me.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266841-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[me.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,me.com:email]
X-Rspamd-Queue-Id: B368326C09E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon,  9 Mar 2026 13:34:49 -0700 tobgaertner wrote:
> Signed-off-by: Tobi Gaertner <tob.gaertner@me.com>compile-tested only.

The "Compile-tested only" belongs in the body of the commit msg,
please don't pollute the sob line with it

