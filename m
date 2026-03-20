Return-Path: <netdev+bounces-269864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DRCKnYUvWnG6QIAu9opvQ
	(envelope-from <netdev+bounces-269864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:33:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E8F2D814E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83543300D777
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6323815DB;
	Fri, 20 Mar 2026 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXsN9Z9i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F653806DA;
	Fri, 20 Mar 2026 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999217; cv=none; b=FASgLQly93Zpme7Wtj9E9g3DYgQHPpzMcjs3WfmxDXZFWHb4p3zaq7fIpjhWuULpjT/9yj41lZEtmgahcvtlxa4tbLiuPsoXVXRTdBdv+CnvDSIMfns01f+5Kn3SLsIhipjiHTjS/YOuJF7JD0We4cLktY1Q1VvTyJ1mlCmPoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999217; c=relaxed/simple;
	bh=yBwRAo9MgmscBq8oUJqsyklSzbLhw3I9zBBJh/X4IUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSlQKerhlO6GOKW9D67ZWXToXv8Yo709QGqe+sGXz3IA70de934Y9DwGo8e0//ztDauCrIJ20VMnTLuxHQXvzc4hGwiHoJt51wfIsBuqhuzzErpL7v2HhG5hD2EIfgkXGcMrEis7zpsmjVTMF8WMRNfXyjUfXyU2rUoAk7QiHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXsN9Z9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA273C2BC9E;
	Fri, 20 Mar 2026 09:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773999216;
	bh=yBwRAo9MgmscBq8oUJqsyklSzbLhw3I9zBBJh/X4IUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXsN9Z9i3SFPYXngLwsx3i9OzV4TVDYnRw0ulzmMxpFCk6sLQvE7NYMI+uxjrB3UT
	 YwkaAeSEErQu4DR1op47RNKXBvlGrWhYtmaMGsxmWNTc+6K+6P2xtuhB++MXNUKFgo
	 ZSFsKCZnqkV7HsVD2ILhipNoPFjjmmh5V7tp4GfOrjyKnf8zXwV3SbOnPJVY6/h7bF
	 qTLwyYLWBrkhRbz1llicaJY+t2bPZXJ3lb8xU2+LSJ9VEBy60UW/GJ9a6hu5vGLmnH
	 yVIHlGl7L7ad6YOLy+UM4j7C72ePceqjDkR+3jGhjgnBYespuIYaMltEBFFS/29bi6
	 zESOjrnBnXOXQ==
Date: Fri, 20 Mar 2026 09:33:32 +0000
From: Simon Horman <horms@kernel.org>
To: Wenyuan Li <2063309626@qq.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn
Subject: Re: [PATCH] nfc: pn533: add error handling for i2c_master_send() in
 pn533_i2c_send_ack()
Message-ID: <20260320093332.GC1753385@horms.kernel.org>
References: <tencent_1F05100756A32EDA9ECB2D342AFE8A3EBA09@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1F05100756A32EDA9ECB2D342AFE8A3EBA09@qq.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269864-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[qq.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qq.com:email]
X-Rspamd-Queue-Id: 54E8F2D814E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 02:50:05PM +0800, Wenyuan Li wrote:
> In pn533_i2c_send_ack(), the return value of i2c_master_send() is not
> checked. If the I2C transfer fails, the driver continues execution
> without detecting the error, which may lead to incorrect device state
> or silent failures.

I would like to clarify that this patch addresses the silent failures
aspect, but not the potentially incorrect device state aspect. Although,
with notification users may be better able to diagnose that problem.

If so, I agree this patch should be treated as an enhancement
and routed via the net-next tree (the default for Networking patches)
without a fixes tag.

But for reference, it would be better if the tree was targeted like this:

Subject: [PATCH net-next]: ...

> 
> Specifically:
> 1. The ACK may not be sent to the device, leaving it in an undefined state
> 2. The caller (pn533_i2c_abort_cmd()) ignores the return value entirely
> 3. No error logging is provided for debugging
> 
> Fix this by:
> - Adding proper return value check for i2c_master_send()
> - Converting partial sends to -EIO and preserving kernel error codes
> - Adding nfc_err() logging with %pe format for human-readable errors
> - Propagating the error to the caller pn533_i2c_abort_cmd()
> 
> Even if ACK sending fails, the abort procedure continues by scheduling
> cmd_complete_work to ensure userspace is notified, but the error is
> properly logged for debugging.
> 
> Signed-off-by: Wenyuan Li <2063309626@qq.com>

...

