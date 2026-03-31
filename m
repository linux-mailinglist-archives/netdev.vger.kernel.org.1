Return-Path: <netdev+bounces-273440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFgvE+gry2n8EQYAu9opvQ
	(envelope-from <netdev+bounces-273440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 04:05:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE9F36342B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 04:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C1F2301221A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C5D3630B5;
	Tue, 31 Mar 2026 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/Qmf6NO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9D20B810
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922722; cv=none; b=kYfUb0T36LiXnJygGbMTDUzEgAyY24NCVK4AYCIDBuMOweUwnAapTwJOsqBQJHRXJ5V9jLFEAEXGr294W5t95azC1YJORgXAPIO2AsZ5zn0sQprvmPDqp04WGEGh2XA8gVz5gY/JAX1kvzcHJYpuZkQJfshlAmH+D3RzHy5uWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922722; c=relaxed/simple;
	bh=3VUo7hidnWbhKnZlfxzV8rYkT77hLlyjr3jQs8W9obk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNl1FTp5PQi3gvtzQEAt9OySDJiTzpEE7HkIHBg+hSNrvKDQWrUES/OXFtojJDKnHVCRWyO00LVmwOkDV9+mATp39k2vmvD6f/+tYO9d032qiO6a+ESFl8v3ikbMYZfgoqXg7BjN1VXoaYouwZhvfl8a1pct1ZTZSPMRSqCEMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/Qmf6NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBCDC4CEF7;
	Tue, 31 Mar 2026 02:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922721;
	bh=3VUo7hidnWbhKnZlfxzV8rYkT77hLlyjr3jQs8W9obk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k/Qmf6NOGhoohkreJkfzxJtbROcS9aSStjaVhP9ugv2VERlnfjL5TCOOMF/5ajToI
	 dxE+FkRC0f3oQkw2eCNAPVJoxF8jJOe/sp0HboRwVm/Yw6qbAx+cj4gwNMxUdri5iP
	 63uHH7qG5YOQPBt9PCqAoHIgZqIVAniLYtRslwGPUd2dQwlJ2K4Ws1D5dWqBEuK7+R
	 WXJ2tNquewMYIbuNIS7PjxigIwaWNnFUOytAyVftY1W1ZZ/k3TwE9PBb0vw9dMmMYg
	 ETxRj+02ge/x+C0kMuiqDY11BgE4jJ+SjeHcBl38uqHdZmYc5hXHI8KetnYxKA7ovN
	 jRDIBTrumce8A==
Date: Mon, 30 Mar 2026 19:05:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net 2/3] bnxt_en: Don't assume XDP is never enabled in
 bnxt_init_dflt_ring_mode()
Message-ID: <20260330190520.13fa773f@kernel.org>
In-Reply-To: <20260329232528.870637-3-michael.chan@broadcom.com>
References: <20260329232528.870637-1-michael.chan@broadcom.com>
	<20260329232528.870637-3-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273440-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9CE9F36342B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 16:25:27 -0700 Michael Chan wrote:
> Fixes: 93550a9c7939 ("bnxt_en: implement devlink dev reload driver_reinit")

Fixes tag: Fixes: 93550a9c7939 ("bnxt_en: implement devlink dev reload driver_reinit")
Has these problem(s):
	- Target SHA1 does not exist
-- 
pw-bot: cr

