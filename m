Return-Path: <netdev+bounces-291363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJEBD6BvFGqXNQcAu9opvQ
	(envelope-from <netdev+bounces-291363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:49:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B9A5CC800
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 605E43014663
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DF53F54BD;
	Mon, 25 May 2026 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqxEf95K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB25385519
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723964; cv=none; b=mXbdDqx5v+EZxmOMtG5om1+A3bXYiap9allNiBKczlS2vbKReguTjBmFBC0LZOPHTz0pljfWDxomdUqsFljmEwV8LvwjUek6Lt21ciw+OWyTozpsTNELqXZYEPZnkR3XeEUmfXoI4eYq20rEtiMI57ri6wGLlmF3OY+naVYdfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723964; c=relaxed/simple;
	bh=vLJPIkJDNTxgPfGn+jE7fN1tk1CROCLkukpsE7fuqTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgqQmsifNzEmtp/Sn3iwjogE1w0odZJwz9dOmA/JOfpGEZZVNNCqw8ihWTB7GEcm9+o8kkt7YKhnnrEN9ppkzivqfTYK4jEkHjKNyyx4L1lthkZp8MvlGGtYrq9zBqu1LHpFp43b7hHY6mA561d0Jgkxejtpp5nVoH4rqpidhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqxEf95K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C54F1F000E9;
	Mon, 25 May 2026 15:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723963;
	bh=vLJPIkJDNTxgPfGn+jE7fN1tk1CROCLkukpsE7fuqTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FqxEf95Kx+Touz5zOQbKB2YNNiJhgaGZRh/v1eU0dSZ8UngOZh38CxMNrx7S0xiph
	 rEBsWPaAmlyagpGpZn7mjkMKeZ6VKCFADZt5oWfvHdpH7FfY5AEN5ARgHiy2QdIFa9
	 XZgagJASjq4KTI8x8snnl4e1/VQQJjAiqemdTyCJjxlm43JTzDQQQR46jq2iwFs6iI
	 IjuvN9T6ObBl14Xtn0eKKaWd4hGlUyKw0jVcG7cM2tYq+7hqLjIlF1do1RySdl9bxX
	 jVpOp9jlJEMoYsxKdlX4o8G9YMlRyVzexbjCvai+dwHt5q3EqRTlG6OB7UjuXRMpkP
	 K03tQwEyC7vRw==
Date: Mon, 25 May 2026 08:46:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/2] pcnet32: stop holding device spin lock
 during napi_complete_done
Message-ID: <20260525084602.685e450e@kernel.org>
In-Reply-To: <20260525125437.4061-2-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
	<20260525125437.4061-2-oscmaes92@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291363-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D7B9A5CC800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 14:54:36 +0200 Oscar Maes wrote:
> napi_complete_done may call gro_flush_normal (though not currently, as GRO
> is unsupported at the moment), which may result in packet TX. This will
> eventually result in calling pcnet32_start_xmit - resulting in a deadlock
> while trying to re-acquire the already locked spin lock.

Looks like a legit bug fix, please add a Fixes tag and repost for net
(rather than net-next)

