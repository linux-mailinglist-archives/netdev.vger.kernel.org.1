Return-Path: <netdev+bounces-291877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAFrC1zpFWqXegcAu9opvQ
	(envelope-from <netdev+bounces-291877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:41:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C21955DB78D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FF683015719
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0DA40B6DB;
	Tue, 26 May 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nz6bHEkR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A081156CA
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820886; cv=none; b=hq5ajKV0lrWeTkOJMNXBfF6fVqv+OoeTbFVTLl7MWEI/Hu4hzfqcV7BfJwfUuoFTdr5cn1gwcR8Drm/+DA8M0xO9QJB6oCD7dTHP6e/vZlbkD5lJzAItf7+GWYCF5gLCQdgNEBnNV0DYGlknttoi8qv79sbfoqqZ5b47TH4Cr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820886; c=relaxed/simple;
	bh=RkW0Bv1L0Js8MNsa7V7ZK7EapQX1yrgXE71yF21qq5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/I/FzK9F4JxFKTkURNw5Jlz5sgKgC7IqLwAcQC0EP6yYferJACIhG2bSpTBdBMwDWKXMkmwv93Dx8FQPNDMGQvmtL4N3feCIXjQDKzrZYG7oRFWu/s5cmOyOz842+uMxnueGIjTVYdGhRTii+FXrRkYyP945PYijxheaqvyUYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nz6bHEkR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1455F4E42D63;
	Tue, 26 May 2026 18:41:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC1C66011D;
	Tue, 26 May 2026 18:41:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B77FE10888A19;
	Tue, 26 May 2026 20:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779820880; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=PIYj6/EhK5ecVCOsnUMdIrM77xOW3tv5CbH8SY6+uiQ=;
	b=Nz6bHEkRxZkrj8vpiUPjypNGWtvq3iwyzcEPzXlDt/ZjsnM2mMc3ZBQKVKFjDosV/fSwYu
	TOmGaW4YA4bya7sR3S4VRXWbjxOpLwxVUkYcTIzeH9yvppmgf+UE2XxwA2DtNexdyEWFXu
	iz2b30KR6R+VPfzeSyqkdDfQFfBZkJztustGXA6DEeAUVW33kuNQTEPilC6NIV1EASdwS2
	YPc2a4cYBJjKpk3PjVi+s5KrE3BdkWIWMzjn+LoZt7JGk1FPEhfqGi8MSeEa7qn8zr/UDQ
	G8ZiYPgKccD3Y68+Y/bPGnsmFohUlBOjNBjLOByh08kocJcnVajrTzn5ZsUtmQ==
Message-ID: <422219d6-8377-423c-8ccd-641b2fccaa1a@bootlin.com>
Date: Tue, 26 May 2026 20:41:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/10] docs: net: refresh netdev feature guidance
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 vladimir.oltean@nxp.com, willemb@google.com, sdf.kernel@gmail.com,
 ecree.xilinx@gmail.com, jesse.brandeburg@intel.com, linux-doc@vger.kernel.org
References: <20260526160151.2793354-1-kuba@kernel.org>
 <20260526160151.2793354-7-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526160151.2793354-7-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291877-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: C21955DB78D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub

On 5/26/26 18:01, Jakub Kicinski wrote:

>   
>    1. netdev->hw_features set contains features whose state may possibly
>       be changed (enabled or disabled) for a particular device by user's
> -    request.  This set should be initialized in ndo_init callback and not
> -    changed later.
> +    request.  Drivers normally initialize this set before registration or
> +    in the ndo_init callback. Changes after registration should be made
> +    very carefully as other parts of the code may assume hw_features are
> +    static. At the very least changes must be made under rtnl_lock and
> +    the netdev instance lock, and followed by netdev_update_features().
Feel free to keep this description as-is, but can we get somewhere the
actual meaning of "hw" in "hw_features" ? I've seen this cause confusion
before as this is sometimes wrongly interpreted as "Hardware features",
which isn't correct as the hardware may do stuff without allowing users
to change that behaviour.

I vaguely recall something along the lines of "Host-Writeable features",
but I am not sure at all about that...

Maxime

