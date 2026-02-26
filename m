Return-Path: <netdev+bounces-261097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GcIIZ2Nn2nYcgQAu9opvQ
	(envelope-from <netdev+bounces-261097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:02:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E42F19F40B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 350EF3007B04
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 00:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2398817D6;
	Thu, 26 Feb 2026 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bvr5PhGd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13DA625;
	Thu, 26 Feb 2026 00:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064151; cv=none; b=qz9GZi8ohwtEAk7DSfLe2oAFyQOiCTdGzHCK7Itj55retXdM1Y81uJJxXfUJ9qzK/ein76pBQQaFQcRp8U6fT9hTBXKA9ROWTNGa+2P0Q4KFTKj5uVQsJyNpE+KY7tO7fjO0Czs5Cwb/SbU2ZemGOGSlykpB3mgTsjIpuDBleVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064151; c=relaxed/simple;
	bh=Lo5b7VCE0/JE9STFUySjJ+3lG6SXTDyi2Qu+PKyrQbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oU5eH9TzsiohMsKkMrUCQzahDPRc4PXiz62DWu5oel06les+YNFsxsX7vmBLhQCa/5FO8BXr/ncWhVR6pO2NWrT9Unc5VknqMPaEyrXPbXStYyE5jayLLOg/LWTImVt9/Qs1uTRlH8ZziqF0vS33d/EvTtux3GMC+5Je9o3nSlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bvr5PhGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F2DC116D0;
	Thu, 26 Feb 2026 00:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772064150;
	bh=Lo5b7VCE0/JE9STFUySjJ+3lG6SXTDyi2Qu+PKyrQbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bvr5PhGdAKfdUXEoN3jVzHyGVkXOp5Y271uIK3HvIrUby0JrY6dArqyzqowsaJ5wz
	 tp9YIT4BSvSC03VOofiZGZS//Az7w5VO1PINGw5bPe7kLrK3miSVuhPWrQuZVvGu7E
	 TK49VyH6ICnyPkL3gggdfEDSEL06SnO3PKJo5QZV9F1PKuqb6IY//VPjEs0A3RgU1D
	 M3kEATpOWFhYazZOrAESLHEQi4FJEVt3sLOG6i9XwkxKiEmqtVTHNyKZpXPyc/porb
	 HWrznPxmyKjSWS1DDQ70VcA9YPzwsS0XWvXkrJWfxmx8QwsnpT3nYwlAayXeW4dUzJ
	 E/DCAAAPt1EBg==
Date: Wed, 25 Feb 2026 16:02:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Junrui Luo <moonafterrain@outlook.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH net] dpaa2-switch: add bounds check for if_id in IRQ
 handler
Message-ID: <20260225160229.41d90f88@kernel.org>
In-Reply-To: <6027f2f2-43ab-41f9-9fd3-c91c4ae7a70a@roeck-us.net>
References: <SYBPR01MB7881D420AB43FF1A227B84AFAF91A@SYBPR01MB7881.ausprd01.prod.outlook.com>
	<6027f2f2-43ab-41f9-9fd3-c91c4ae7a70a@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	FREEMAIL_CC(0.00)[outlook.com,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-261097-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E42F19F40B
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 11:11:45 -0800 Guenter Roeck wrote:
> Will jumping to the out label here cause an interrupt storm?
> 
> It looks like this bypasses the dpsw_clear_irq_status() call at the end
> of the function. If the hardware interrupt status isn't cleared, it might
> leave the interrupt asserted and cause the handler to trigger continuously.
> Should this code clear the status before returning?
> 
> It seems to me that it has a point, and that the code should at least attempt
> to reset the interrupt status. Please let me know if this is correct or
> if this is not a concern.

Sounds legit, I think you should send a patch if you care.
I suspect the original author is also just using some AI or a static
checker, so getting any insights into how the device works from them
is very unlikely.

