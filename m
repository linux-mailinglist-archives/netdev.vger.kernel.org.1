Return-Path: <netdev+bounces-275784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM3+HbRR1GnLtAcAu9opvQ
	(envelope-from <netdev+bounces-275784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 02:37:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ADD3A8715
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 02:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08A6A301BA66
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 00:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067DE14B08A;
	Tue,  7 Apr 2026 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVp70/+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56542B9A4;
	Tue,  7 Apr 2026 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522223; cv=none; b=nJpU9OGeoiHqy7741+9zHxEfZliiV/o7Fkenm+iUEJpZHrW0GX7lOQTjZnAW1mRMZRsRDWQRk/TtNHdaZTDcRvz809SiS/Bh8oSYGaF7CtE6EzkvzMpPZy+cDO1LxQP004s8yRxOQKdvQymEuJma7OSeq9wk7Kq0+VU44M9qSjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522223; c=relaxed/simple;
	bh=XlHyAzaJklqxmNalMDD6OKRU12ck+jCq8qKnCst96gI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOp13/D7oCLbVRspT3Zm2iGikcUYSMi5tur+hsZ/nIUWn5fWodrge7oD8+nHWiEdjZrBdKtkXO8bSqsqz8gvnqwvAZ5Z9BrHtzbuFotNCu/UoHt2JVLe/Zc4AYmJpc9z1yvx2sXisteysgxBsUMhAJzOuWVzQ3QTOoAB8kFPMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVp70/+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F58C4CEF7;
	Tue,  7 Apr 2026 00:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775522223;
	bh=XlHyAzaJklqxmNalMDD6OKRU12ck+jCq8qKnCst96gI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVp70/+tlQHEJnueuLtQClkQR1/+dtsCJj9DulgO1WpCNXWprnF+zoscNNJk7ZVux
	 a7lIqu3QkET4z0bHxNT78dqjeGhEVNuyUpnV3xNo2ps6CS7/dba2r1Pm9YDWFmyta6
	 O6biJMb8Z+jNYrQrdlKM0BDxBHCwoDxeR0s+9OqWjcz/7XaamRjeW0lGHPyQy33DGI
	 CulDptKAPmAhC8VBZ/xiex0X7VAP9YKXcVw0rxC8T4MlkRDg93+A+MSU+Mey2SC7kL
	 wtiSDz64hFL76ad4FoNrt1SUuqu69i30mO3OHlp+p99NYRMNRmQb9TWL2xYCH6Xj4j
	 pcCPc/b+x61iA==
Date: Mon, 6 Apr 2026 17:37:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Norbert Szetei <norbert@doyensec.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Villamil <john@doyensec.com>
Subject: Re: [PATCH v2 net] vsock: fix buffer size clamping order
Message-ID: <20260406173702.56239557@kernel.org>
In-Reply-To: <69317E49-40AA-4985-8A4E-447C58665A68@doyensec.com>
References: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
	<acuKUpZQq6z1DY_n@sgarzare-redhat>
	<102981F1-2CAE-481F-8FAE-4F3085E25E89@doyensec.com>
	<69317E49-40AA-4985-8A4E-447C58665A68@doyensec.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275784-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03ADD3A8715
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 22:04:26 +0200 Norbert Szetei wrote:
> v2: fix indentation/whitespace issues in the previous patch.

This is not a correct way to submit a patch, but please wait until
Stefano responds with any further postings.

