Return-Path: <netdev+bounces-256820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ+gCwiwg2l1swMAu9opvQ
	(envelope-from <netdev+bounces-256820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:46:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AEBEC8BF
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C75F300DF62
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680438B98D;
	Wed,  4 Feb 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX/x6/pB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE55214A64
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770237957; cv=none; b=AGDeSZFfnsdDmkOuELxZhzmVCpbLrNS0IAYg4KrhMtGE61QL/mknXVXLnFj0M/tq6+uLJLlhXPMtk/NMy0h+uqh/fYcaBFf9ZpAecBrl1mEE/2Yqb2f4Bz+OZ2qsWccCTj41gNalaEb8wAoNSSJ94c1HDKl/DQFsYhsi7tqQDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770237957; c=relaxed/simple;
	bh=+ZPlCLyFbv56EWcS4ecmR/INDwI/6I9mXAdIgZj9ob8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uxg3C7zwi/j6IV0IIkGYANTf0S1KZwkUGFQ6b3/mNH3+V7az8kIqezn0R1+dnBKZSoyev54MDr4Gtlzd2B7J09gkmyg+HKXv+iG6oCjh63BVwKxMi0dHVQHzKXALAxkjIs1fPF7Ep+Iu88u+AaGq93ggP7KNMchx+Bo2nUFuCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX/x6/pB; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7950afac0ffso9000657b3.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 12:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770237956; x=1770842756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmhmeFhOmptzVfU8Ket2zRg/1yOdaQIeRxT7DL1GOYw=;
        b=PX/x6/pBMHut4DD9SVXKYhgECFLfzhOyMpGjAB287Bmag2kptOsbFFG7FzadD4UGB9
         v+ei0TYEOoh/VV/uTREH6QKuxD7jP+Iiy+E4P2CVxiw29qp4qogNOb/JHkYs2oiwtkxR
         BJ3iZEavABcNmrRZgM3m5SwQmHNDMzaZUYSFWOTMTCRT0WkVvPh/5iSTjJRnINqJNFXV
         C2ZflabbN/pVckd1k2p01dymvLHbV6VR3lTIjg6oSwWncRv6m9JXOlHaR+GTw2t1NxoS
         sFZUsf4EMkca9NXpOXmunug0dkluTni+yHmfAX7hZnbpVACRYTq6KzU1BWrTJWwAQ7mp
         vaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770237956; x=1770842756;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmhmeFhOmptzVfU8Ket2zRg/1yOdaQIeRxT7DL1GOYw=;
        b=OhUadvyz2jShU1lQlva42m8K4jBFC45gvHQzxz3/3GIY5d5l+dbb6Fa3ulE/dDhiwo
         92T8WkPoXJyYhO5l6pvaH6M0TfMm599ysLggOCoqw91cExI5V10y0p4NY8EvJteZDgSb
         gnXlsj3GrPJSB4DN8yLhz79GetJrNhsrF0AV4HBYcEvJwCRNkNniNlAn46P6jJVlYe/A
         SYXAHpCECZp0jgWtZrPddUfK9NqGxc9Fe62ie7XLpBj/Nrh/4PN6dBIQhkdDp6G+8Ttc
         GsMcckr4TMVh/4BjxOt4iAoa6bw9Jv0OnAChfIrSR7ZB28hLtixAX38i/IDn/F0OxvTs
         gQpA==
X-Gm-Message-State: AOJu0YyY9p5fbPW5Ca4Emkgn+wQMod8lc/lH3etlCiPc6TIxVNOy/VRt
	3QQd6v6QmbDxNrzY1Je32MY2vP9dfu+3tEhwErEycnTbPV0mh7wV8gUY
X-Gm-Gg: AZuq6aJ0bnnGrtr6a++OLl/hwbwHhs8zZ1mONNtzqpbEizgGjvsCu9N7EBlAHH8k1dh
	p0tpA6e0OSqXXJdLAts5Fv3ItlwpuWqhezW7GGWKplTV7YDaFtQM0VdN6+EDEfEeInj05/OoXLA
	qU76icRAOTyUn23dEwGqLu2F8Cf6gnA75SSB6LUTvBv5ci55gRn6YdCoFBoGZb1cCM2iSXZ5H+R
	1iZLcTz4ZBDnQqybZp+sdzpMdzLYqnF/wlLmAWnAENhJayo/jeTQIokJSwk5ihvm1VV+DX4zH+4
	Co4rkF3/SjtMgqwon+d96kozDawRUuhTWRsDg0FDR45j0h2vr8SFywtYcFZk9fGhb0gipZKagHF
	S3nT1+I3yN/6A8FLI1flNc8MZwvU15fN2KCCkhB+6gLc2jEMMp9DO+cMwQjwYmbleJ3REPaJC3o
	0GUh/l+ONgmkTeeX/1jhs0FCwO0XDXOupr+MqGJ+w/U0kNWoyve2vfKImSqKs=
X-Received: by 2002:a05:690c:c50d:b0:794:d9f0:2375 with SMTP id 00721157ae682-7951501ef63mr5799507b3.0.1770237956288;
        Wed, 04 Feb 2026 12:45:56 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794fee8294csm30725247b3.2.2026.02.04.12.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 12:45:55 -0800 (PST)
Date: Wed, 04 Feb 2026 15:45:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
Message-ID: <willemdebruijn.kernel.37bf21c78aadd@gmail.com>
In-Reply-To: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
Subject: Re: [PATCH net-next 0/9] psp: support rekeying psp protected tcp
 connections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256820-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83AEBEC8BF
X-Rspamd-Action: no action

Daniel Zahka wrote:
> The PSP architecture spec specifies the need for rekeying connections
> in the event of a device key rotation. After a device key rotation has
> occurred, a new rx derived key needs to be generated and sent out to
> the other end of the connection sometime before the next device key
> rotation occurs.
> 
> Because PSP connections involve two different keys at each endpoint,
> one for decrypting ingress traffic, and one for encrypting egress
> traffic, there are two types of rekeying events that need to be
> supported. From the perspective of one endpoint of the connection:
> 
> 1. rx rekey: we need to allocate a new spi and decryption key on the
> current device key to provide to our peer.
> 
> 2. tx rekey: our peer has provided us with a new spi + encryption key
> pair which we should use for encrypting traffic immediately.
> 
> In the case of rx rekeying, there is a period where it makes sense to
> accept packets authenticated from either the previous or current
> spi. To deal with that we allow a socket to keep a chain of a max of
> two psp assocs at any time. If authentication state does not match the
> most recent assoc, the previous one will be tried.
> 
> In the case of tx rekeying, as soon as we install the new tx key, we
> have no use for the previous one, and it can be disposed of
> immediately.

So this defines a rekey event as an instant in time. An alternative
choice is to rekey at a specific seqno.

The difference matters only for retransmits.

Not sure there is a strong reason for either. But probably good to
state the choice explicitly.

> The only catch, is in the case where hw uses a key handle
> in tx descriptor state (as opposed to inlining the key directly). If
> this is the case, psp core needs to be sure that any of these
> unaccounted for references to key state are gone by the time it tries
> to sync a deleted key to hw.
> 
> To deal with this race condition, the series includes a driver api for
> implementing deferred tx key deletion, where the driver can signal
> back to the core when it is safe to dispose of old tx keys.
> 
> Lastly, some test cases for rekeying are included that go through key
> rotations and rekeying.

Still reading the code, first pass only.

