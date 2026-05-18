Return-Path: <netdev+bounces-289083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLd7Kh0eC2q8DgUAu9opvQ
	(envelope-from <netdev+bounces-289083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:11:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AB256E6F2
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F31830A5F08
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60148A2BA;
	Mon, 18 May 2026 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRLYoCMe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217B48164C
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112621; cv=none; b=gW4gwAZljr+P2Oz/E6tzlPJJ8YnPaczeAa6DDXTV86+pjs6W9DX4+bT0wWpl7+odrsOi8Vy6mMpysbnX0SWQvA8THIgE5rLgvx+TKtPPeKhjJakRxjIPsRqMcyZBhniOi7AiO3lpJdx7dLyP2XHRGabmDQiwHRaya9SBTA0adTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112621; c=relaxed/simple;
	bh=/ZopyxUJ4BHQ8VFZ2mTirhqVPzRSqA18N6sc9R1+nNs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=qMz+C9dHICSbbaDYBEOhJrSbqYk3W9iUT7R4Uds74dbRB4RodiU7XsA900X/UOX9TFaK0JFjOuub0k/aLyyccg8T5LXDQ3lGpLBt9DFkYfvW4B/GFcy8jgcTtVtR8IIW2rVgIQRC7S5ZRRNfUYnZVBLkhMJ7gw+bov9g8fK5Xkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRLYoCMe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ad135063so16870905e9.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779112618; x=1779717418; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wie7kwbgVs0FbqIBvim/mRMkxKR/9nE8uxhleDtct4E=;
        b=lRLYoCMeNSY+K1JBJ71TR3VheLU9MPkWE5zXMgoIlX05c0YO/nOs36Li1KH5vpg2Y1
         LlLf2js1+2xiIaKPZRcOIQrZe+5XaKyF22OPKlgcG5vXwQOKqpg2GhaBZ/pDzLXGFKw/
         h+f8pBE8LWcHHQ4Wa6Zv3ZgDmzYZKy47wZHs+XuHjC145+wyCgLlxlDIBybRqCW29Z0O
         RXJ07q5jOy3drJe8sIx8ptFXAz3w8Vk1wV0nB3q2H6G1Yy0tNdDJiximvSvlPsgMUrrd
         WxIzY8Z/mYUaSYGZGpdX35i+VzPt++PguU1eUrvSVdPl2B9da1abB4il58mw2AdGm4m4
         d82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112618; x=1779717418;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wie7kwbgVs0FbqIBvim/mRMkxKR/9nE8uxhleDtct4E=;
        b=muRHCjv4HcdSV3Y77iPK9Rm6V85Ul3bCrLOn+LvMtDRu3m3VoSNuOW8Cy/sN1dVXM9
         wrkG9GxSSS+VuoUtq69dFF5sbgH0TKoy4wyApfWuCzkYWyEuHqDhjqSiKmLW9l2T+G7w
         3JFTWljbb9X0JtcpxW3LVzLrM3F8ptFb+HFGOhRXr67e7cAHzr6Qrn+4HtXpJWJviW2e
         YfKtToU5LBuBFm2Dxo0JTYHfz77dy62aAhzHfIY7f5kX0WN5Yowuj1XRY7iB3+R9JhR3
         zTjOjDuGq2noItUvmS6lmv3ZKK6BfyVlRTXOrXXh04dl1VBYSPGZX7xw1BruEcrCnG5J
         fzwg==
X-Gm-Message-State: AOJu0Yz1zooyDZpzmuTNO/EHASXcjdzOJOCRXxymDMl0N4YBJYE3xQcI
	J2r+ccZy11nogTbgy5LydPyyBMLfn+uTlA/50EypfD7UoDAYLujUAXo1
X-Gm-Gg: Acq92OF8pr2BV2NJFATtvibJeBRSFcWivb6UEo2fiYmO5s1EYcIj/Qq0lbrim/EcUQn
	xSZ+NWbKrxWbYRdx/l/e0XiZwbkLnEh2bUXK2XJHbw9LkT+7/0FD3W1waJNOsLrJfmyh3WI+b3S
	mfQ/pkmXcop3n5EBf3h6wmSmEdw78bMsrZcI5bZ9iq2uT49Kp9aOgHM0Cc2yGJKouV3np+u8lIx
	3Anep8jvvjgjJaxAKBz5iUeOSPPqCNjzRuSqAXnhS4NZRxekQUFwR4ikmsFQdUWK0mpEZgcTRK1
	+ND7zM3MlmYEevNtr86/0XV+UOUlSfq3o9lvl87DjMw6tTv+UI03wNXZUusfsnU9/hSP/D5jKHP
	WUvet79Qv9cmvOuRxOx9yHY3h2CMcewV58phYkn7AMm7pYA6J/Xz7gsouBmLIkhG6/vZq6wCgEj
	wmPu1MHvdazgiCo+iuWa1Oi0ar+w==
X-Received: by 2002:a05:600c:4fc9:b0:48a:5821:5ffc with SMTP id 5b1f17b1804b1-48fe60e473bmr207386315e9.2.1779112618361;
        Mon, 18 May 2026 06:56:58 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7e442sm79968555e9.33.2026.05.18.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:56:57 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S .
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Aaron Conole
 <aconole@redhat.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tools: ynl: add unicast notification receive support
In-Reply-To: <20260517083358.2088599-3-houminxi@gmail.com>
Date: Mon, 18 May 2026 14:56:45 +0100
Message-ID: <m2fr3ovn1e.fsf@gmail.com>
References: <20260517083358.2088599-1-houminxi@gmail.com>
	<20260517083358.2088599-3-houminxi@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289083-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A9AB256E6F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Minxi Hou <houminxi@gmail.com> writes:

> Add ntf_listen() method to YnlFamily for binding the netlink
> socket without joining a multicast group. This enables receiving
> unicast notifications through the existing poll_ntf/check_ntf
> path.
>
> The OVS packet family sends MISS and ACTION upcalls via
> genlmsg_unicast() to a per-vport PID rather than through a
> multicast group. The existing ntf_subscribe() couples bind()
> with setsockopt(ADD_MEMBERSHIP), which does not fit the unicast
> case. ntf_listen() provides the bind-only alternative.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---
>  tools/net/ynl/pyynl/lib/ynl.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
> index f63c6f828735..8f526c683f99 100644
> --- a/tools/net/ynl/pyynl/lib/ynl.py
> +++ b/tools/net/ynl/pyynl/lib/ynl.py
> @@ -748,6 +748,10 @@ class YnlFamily(SpecFamily):
>          self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
>                               mcast_id)
>  
> +    def ntf_listen(self):
> +        """Bind socket for receiving unicast notifications."""
> +        self.sock.bind((0, 0))

Can you add ntf_listen to the docstring for YnlFamily under the
"Notification API" heading.

> +
>      def set_recv_dbg(self, enabled):
>          self._recv_dbg = enabled

