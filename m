Return-Path: <netdev+bounces-289223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMEvHeqtC2omLAUAu9opvQ
	(envelope-from <netdev+bounces-289223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:25:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCFD575885
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E5113049141
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D1196C7C;
	Tue, 19 May 2026 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny6PtYzq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB17262A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150228; cv=none; b=BT4ISllaH7zpR82BkgStcGSqOXr51ZMUi/u/LKlTRncxYRMdcCB1MZ1WRQWoaNtXg7chKAt4AYJOb+/d0s8/JcpGUg7DBSxA6rxI6fADXypaGRzc/DUy8vKo3TVdlI177ewg27jG2y98iHq8MN7XXVftwb533yPCye9o4gurvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150228; c=relaxed/simple;
	bh=rNw6wYF1JK8hQpSNh1nZ2UxNKo2L8wQUYcfBM40BBjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUVm6zZt78aUGYJBVZuYc/DlUstdgU4fbZhbyF9tIF2s2D88Kdrrcwk+Qsep7sYHcJdZsa5DhJA2oUYS8MPB60cc/C1AOYt70Fu0mCR7NbSTszbo6gypDskY+lbQzJeH/k89B3tZVtZVQG9qyrm3VRUxmMkxg9aGVtOlpwqjD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny6PtYzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3DAC2BCB7;
	Tue, 19 May 2026 00:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779150228;
	bh=rNw6wYF1JK8hQpSNh1nZ2UxNKo2L8wQUYcfBM40BBjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ny6PtYzqpPQzBWph4yt6QI+V2gAjyg1aXKg2MzfwNzYu1UVM2HkOqg2jL+4r2ImJ+
	 /Rn7OApnsksLA4gPUOQmkMofgl4Qivzz+xU51PMq2SxmrHwXMIeCQu4nK6ALyR/Pre
	 dm9lKLAxc+XN0WCs8+4nUwsT9Jo+qxbNv50RLurn9BA0Y/6/PgB9v/VDM7ra13aM2x
	 JJU8/euE69sf+yWFHKxX7p9CKzfxIpP1gFO8ma2HlbYfVpwKRA2AN5VG+sZdTKg0Sd
	 q5vW492Mijf0IZvxOZT6Ws6Q/xAMsXin6qI+sLuYG/KAxWNb998cF6ysFR+aa8jNRP
	 ObWKZi9G9BZ2Q==
Date: Mon, 18 May 2026 17:23:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 1/5] ionic: Small improvements in devcmd
 retry logic
Message-ID: <20260518172346.30c32a73@kernel.org>
In-Reply-To: <4c18744d-742e-49c2-bca1-90c86cdcc2ed@amd.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
	<20260512224421.25236-2-eric.joyner@amd.com>
	<20260514182646.16f8ad33@kernel.org>
	<4c18744d-742e-49c2-bca1-90c86cdcc2ed@amd.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289223-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EBCFD575885
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 17:01:57 -0700 Eric Joyner wrote:
> On 5/14/2026 6:26 PM, Jakub Kicinski wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Tue, 12 May 2026 15:44:17 -0700 Eric Joyner wrote:  
> >>  Another commit uses this return value to help
> >> signal that a deferred probe should be performed due to the firmware not
> >> being ready, which is why it would return EAGAIN.  
> > 
> > Where can we find that "another commit". Reading this I was expecting
> > it to be another commit in this series, but I don't see any EAGAIN
> > later.  
> 
> It's in a commit in the series that's targeting net that I've posted; but I
> think it'll be clearer if I roll that into this series in the next rev.

I see. Maybe wait for it to be committed and add a git commit quote
here? The hash won't change once it's in tree.

