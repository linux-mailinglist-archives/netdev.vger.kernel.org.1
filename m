Return-Path: <netdev+bounces-299266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IBg3Bg/9Lmo07AQAu9opvQ
	(envelope-from <netdev+bounces-299266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 21:12:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A609D681FED
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 21:12:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=Ydp5yoLK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299266-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299266-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17FD63002330
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 19:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B52DEA64;
	Sun, 14 Jun 2026 19:12:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822D2DAFCB
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 19:12:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464330; cv=none; b=UMq+miYYiE7ZyM+PFVSwziYJ3LBw0psW1YnRreIIBu9KINn32+dH1bqBpZKTX0MbaFpsDyWmFJtG5zW6fvZrNey2kL3rY5cfe/RiEZxpyZr6oXIDxsHWsYhHsotq0zl1eyo9O85ZwzP+tqsSRCNDk/EPnyi8L+/DRQv4SByjobE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464330; c=relaxed/simple;
	bh=w8H8VF4ay2nFrbeburyYYNENKSJcO+w6YhkDtVoSxMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oCLmuV/smxeSq9zJ7hylGZ0WxHlj0duyolTWBFmXbfY3Fm6i6MTjy5uvSfU2EpCx2Ys06830nquc4QrMlAvgcTrVhzNWiO+z0OShdXG5EH4+3xB+y/sD009XQufrq0XUWR7bGT7XflLhGrhXM8Kf1zz+SPeA/pBBiwMhajNp4hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ydp5yoLK; arc=none smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6913160c9ddso4806910a12.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781464328; x=1782069128; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQbr/DVUC2MJPasVAk/HJTfXKnamDXGW7esLMB8WW/M=;
        b=Ydp5yoLKUAgfhAqvsp7GVRJh0ShPQ2nKG5dhnWDBIULD5G13YZygIlKYn26RNhhPn5
         ire0ed8isgPdiq7omhcHXhkMSlNtxj7ghvPCWijfj9I1ts3MzMsDVSl1NHkuR9BbHxzD
         NYQA8enkDO/HLx+ebvsk41gO0pyJjhEbcbCvizN3miaeFZy+SxadFn9kEvuZIf1Ofj9v
         sQVd7hH1Xb+Z8CBH00XnZzEVFEeN75P2uqP9M8maEsWmzMmyd13RYC5f0XxOML1G9cWp
         F3mXcwQ8rbNzFgnExqHHZhxgEDq/JzTPQ3sYsaURv8qwcfPq9VXJumMH37Cpzj/fDLS0
         S3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781464328; x=1782069128;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lQbr/DVUC2MJPasVAk/HJTfXKnamDXGW7esLMB8WW/M=;
        b=DVk+NG6CngLuuqwSZf695gw8Po/qP8VqzMVayDVayruwQA0eh3vp9IVeY2SDCsDgAI
         kbgCN/J1SJZW6AwC3El0vNub8Bkfs0eiAmsz2endIsvzsHkAQ/Okc7t6YdMDa+R/yWZk
         Av+Td4dGW/4O2PFC8VezE+PFrJs7Btnu8wp9PGLFVZLBnVg5PjcdCj6Lx8ForcRecf/G
         ljqRXP9nlZnO0oPxgU6yoLqGsgsEoWfG5oTrsCo1gULxErKgCbevmiXObutxDgLrl3Gy
         huizDpCAv2KMBzQ2qBLyx72r5sxxJfFrch9Zeqzz2Vn4SAhfBnxxdAL89QZlMOerYTeJ
         oXjg==
X-Forwarded-Encrypted: i=1; AFNElJ/yed5+ELwRTQvX4iqCFdEYzK28/GsDoMe++8ta5bJhw7TjUiOZVvONoM4vQRkD6opbdFGHOJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAu/uFzeICRgFYJoIfBocn3N0G4KTJrDAaizg3pEHar0cIsx2m
	XXIx3h6eVWgj3uxoo3dCTDoqr4UQlEYSeakOg35ZJ9XSyYBjWcDz1ajR3AnkhaIM2qM=
X-Gm-Gg: Acq92OHr5bDeTKU4dNhGe6aQIgWpbrMZzd2SzxoWckveYlkJ54P2r+0zlR5XXtubdFy
	6dFo4zTAp+vle9n9cg5QS23k0bPdXf/fOIGkouHT1kFxE3MKxSPTOK2mfQCLPAoqm8Mq5hrJfdY
	6WCnYxudjQWDRy0vqohhp9HJAbSJXWMsg+CWQRr31Kk+aUrMtzmpRmkUwkm+jWLd2LhX8NfwBm3
	BbYPe9eN+e391us+UgkxUigF8LwM1Z8p97ihqNFc9cGh4hABTQST1OdCxfl2rRxXdZxWHEmARTJ
	Cl8gUcKt616QSRk6SKhu1aqFTtAwDl46hH+bQL7+2uh5ESOpB6U1dlOZr0PPuKn+oO2sfVdo5L8
	hZlDKLz5/1lLA0uPo+kuD3mWeLj1xFN68moRD81twW19ka2OMEs/gTwgVVXJM5wGlgbAgx1VHV5
	GRut0RwwE7gyn5i1XPGKdQFHC5ug==
X-Received: by 2002:a17:906:cc58:b0:bcc:e8f:c3a8 with SMTP id a640c23a62f3a-bff4bbffc88mr220569866b.29.1781464327163;
        Sun, 14 Jun 2026 12:12:07 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c01d667f63asm68108466b.19.2026.06.14.12.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:12:05 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  andrew+netdev@lunn.ch,  horms@kernel.org,  bpf@vger.kernel.org,
  john.fastabend@gmail.com,  sd@queasysnail.net
Subject: Re: [PATCH net-next 1/5] tls: reject the combination of TLS and
 sockmap
In-Reply-To: <cbfca457-d118-44cf-b51e-9b0221ae0973@redhat.com> (Paolo Abeni's
	message of "Sun, 14 Jun 2026 10:09:15 +0200")
References: <20260614014102.461064-1-kuba@kernel.org>
	<20260614014102.461064-2-kuba@kernel.org>
	<cbfca457-d118-44cf-b51e-9b0221ae0973@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Sun, 14 Jun 2026 21:12:05 +0200
Message-ID: <87bjddc4xm.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299266-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,lunn.ch,kernel.org,gmail.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:mid,cloudflare.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A609D681FED

On Sun, Jun 14, 2026 at 10:09 AM +02, Paolo Abeni wrote:
> On 6/14/26 3:40 AM, Jakub Kicinski wrote:
>> TLS and sockmap (BPF psock) integration hides a lot of latent bugs.
>> Bugs which may be more or less relevant for real users but they
>> are definitely exploitable.
>> 
>> We could not find anyone actively using this integration so let's
>> reject this config. Adding a TLS socket to a sockmap was already
>> rejected by sk_psock_init() through the inet_csk_has_ulp() check.
>> We need to reject the attempts to configure the TLS keys (rather
>> than adding the ULP itself) because checking prior to the ULP
>> installation is tricky without risking a race with sockmap getting
>> added in parallel (sockmap does not hold the socket lock).
>
> Aren't both tls_ctx_create() and sk_psock_init() under (write) the
> callback lock? Isn't that enough to avoid races?

+1, but we would have to tweak inet_csk_has_ulp() to check for
icsk_ulp_data in addition to icsk_ulp_ops. Only icsk_ulp_data is set
under sk_callback_lock.

espintcp faces the same race...



