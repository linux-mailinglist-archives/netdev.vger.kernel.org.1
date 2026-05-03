Return-Path: <netdev+bounces-283509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCTnMlek9mlfXQIAu9opvQ
	(envelope-from <netdev+bounces-283509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 03:26:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 693024B3FC6
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 03:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE3FF3001FF3
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 01:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464952264A9;
	Sun,  3 May 2026 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9k5TN4H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212BF86329;
	Sun,  3 May 2026 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777771600; cv=none; b=sh/62fIQYSRPSbVS2zPkjPZTz8Xi8gEy0IWrCZYhr+tf/743xDieh+gkQ+Bh5VHBPNIBNAaZAgGZryizFLAPh+RFw3aZDw4I8QyLMNy7JsnVswgOo/83VxTU2RZ1eukGLeeASZgi197buX1UkCzQnMpgfyMxBNXa3IJZPx0gW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777771600; c=relaxed/simple;
	bh=RnFDZamsttLUqXOACgPINZSnkXDGAnCNp70OoODu96E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KieMv4w1panFfEHOvgyxtb/8DjQi0hJMXQ1a01BzFtcAIdjiIkPI+qOHWsWKWALJH0FwdVoRbv0+eQcX7tGMFy0ZMhw51t9wmbK9wvoLD8Rwg6YDE8XYaVKxcQvsMVoSAI3X5/oeKGMOdpX5sWl0kqHnIfFvPbI77mg4f07VCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9k5TN4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110D5C19425;
	Sun,  3 May 2026 01:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777771599;
	bh=RnFDZamsttLUqXOACgPINZSnkXDGAnCNp70OoODu96E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f9k5TN4HDWAbh1YAQqpyuO9U1tPJfFAZ9Q0C5yt7XD8KCeRqiQmFay5PBnklHsFRC
	 d2wAWcqxA6mFaTi8l2vp0BB5AlXKeVBc6AzmLkiY99EEUuBY1Qi3aI7Dik7n89wQO5
	 kU7BhQIUAw37dLjrw9Q+7a9DejDRNNmObvT9OIyNzrLas9sKE+vMpmrn1lJh2nu8Pe
	 BqqS4ZGId8hnnI5UX1Qep7FxZ1sBv0YyBVS9WSrZ+cVwnceQZ/BGvzB1dKFHjNnXSp
	 4exSREE2oAvRTbdpDmbRNlMmbCO5J6I/uH16lRRsi1S5RO5eRNjecPv4KpXxxt4+vp
	 ESNXjSxhhBuWA==
Date: Sat, 2 May 2026 18:26:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bpf@vger.kernel.org, john.fastabend@gmail.com,
 linux-kselftest@vger.kernel.org, =?UTF-8?B?6ZKx5LiA6ZOt?=
 <yimingqian591@gmail.com>, daniel@iogearbox.net, jonathan.lemon@gmail.com
Subject: Re: [PATCH net 4/7] net: tls: fix off-by-one in sg_chain entry
 count for wrapped sk_msg ring
Message-ID: <20260502182633.60d6a07e@kernel.org>
In-Reply-To: <afTXe_kAumf2vjvE@krikkit>
References: <20260429222944.2139041-1-kuba@kernel.org>
	<20260429222944.2139041-5-kuba@kernel.org>
	<afTXe_kAumf2vjvE@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 693024B3FC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283509-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,iogearbox.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]

On Fri, 1 May 2026 18:40:27 +0200 Sabrina Dubroca wrote:
> > -			 MAX_SKB_FRAGS - msg_pl->sg.start + 1,
> > +			 NR_MSG_FRAG_IDS - msg_pl->sg.start + 1,
> >  			 msg_pl->sg.data);  
> 
> And get rid of the [start] / NR - start dance to make this code a bit
> clearer?

Heh, yes. In hindsight that is quite a silly construct..

Let me apply the first 2 since the first fix is trivial and hopefully
find some time to check what Sashiko was saying some time this well.

