Return-Path: <netdev+bounces-303318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mGzVBhgJRGoxngoAu9opvQ
	(envelope-from <netdev+bounces-303318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:21:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C743D6E7285
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:21:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QJLmBWBC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303318-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303318-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D22F53017F84
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E423E122F;
	Tue, 30 Jun 2026 18:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123BE3DC4B6
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843667; cv=none; b=OoWO9QyDTE6KyQE2W8sDJhdPkW3KgehLjPmLRg68PDvbuqeQ6GFcNwaf7Jw4E6+gAfCfSnLg+RGwUf3QbyXXC0TzyUQReb1+yZ1SQwKMjqM6iyTPksryqfGthGRhhVgfoph34MaH7EXw9anONHb+w3gtEwVJnVjkh3JMGLcX5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843667; c=relaxed/simple;
	bh=jyjbQQuuLqwyY8KykaQ4Bai2JXxyDMIAgnVHW2Taqp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn+iMIEFh1ALe1+h+SvK+FG+8WL3HqLVDg1AWK84+66UpJODxaBSin7HLMNo9xzV/ldWBc6AFIEF1fwYpzAyL5TUOKoLrZFQO+HB5qa4uMe8eROx13uFMWdAa3IVnsFIkvraQjoPJfGzmj98wnjIrinTKVOLkMuAwo8j80s80Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJLmBWBC; arc=none smtp.client-ip=209.85.216.66
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-37fc01881f2so3164929a91.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843665; x=1783448465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iDrH0SRjEQYISUiTw7blrmw81K2a/xcAsjrbs4oVuRY=;
        b=QJLmBWBCwt0ckIOAIqN8BBUvdSaTkjPnAkBsyMp8DYR+hkf1XqZJZ+Bl1vRGkXgx53
         0IO4TpX06ec8N4GHYrlOQN8yZjSB3ycBYVQsIrj6DAc2oHRjlQmPAq8q0ldztvaRW8gR
         8uuMlojRvceso/Wl4n9qQBQjX3tq06EXONZX8PeoUGJjsxiNvRorKwrIDZcyONT19upT
         YgUJN5Mjhw5Y8Ph9++ePnxcy2u7N+lon1uHLOnXTBG47YLh+ZEMH2XdaA8qhWOtb5c0r
         e1yMnKNs5DdFMyl+KLliQNPeJVOEvuRsg/WDVTRC2jNe2Ja2CUd2A/eRshotSH77BJVk
         rv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843665; x=1783448465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDrH0SRjEQYISUiTw7blrmw81K2a/xcAsjrbs4oVuRY=;
        b=WxdIBKF07B4aaGV8syZ0ViIwBygc7mdWcr2qWvllc1baqlT267Eh7PNSPDeS9oiFFw
         Ndppn8Y5MKe5Aw4l0ufwuyzfshmkXmXalfopUKDvZmUMmAMcat16aEuNKTWdAn7zoDNx
         dB7rXS0kG381lUb02XXzfbBG/VWMs2ThNjHyvlIfXGPKBGJg5AGPJCGqW2Iqia45zEor
         T79yiVzGS3ugW1SDadFrlBQ91V3hek+qHO9bEJjZsd6gaN8Avm3ks88DLqNeAtrm5GQK
         aQi8ITkjnkVd5lD/neJtA8t+rWAergw2OHP+FXyrQcLove+RA8cAp+ICN+GiHdssCmzI
         qoFA==
X-Forwarded-Encrypted: i=1; AHgh+RpFfk360eaYdRo5vNpa2dzoamY2g7uS0xEsM2NIrXH5d2JlmgMmCbwxRIm0jho3y+JursfUN+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZApTAtJ7bntWOUBuEnv4uOgvKC6iWBMC886MqU4I0PiwX7dU
	GfGd5Jkx9Q9l8Rv6I7a26JLLzrD550VPHKuqjqBxpZk4wqqfb0uKPFgzMujQUp1S
X-Gm-Gg: AfdE7cmv6RAb9ZycC/5nyCoal+UM7aby4LWXwU2KPrszghMrt9DdUgvVBGOvJXDyNMN
	xpDE//KgGKoR9iWs2b/g7x4JsbyC1WaNQPLxBxpCP89CPABuqRpJ3Mna6/AkDrgpN1MHKbmRZxa
	+33g0c7C1gfrF7DlT8tSwYcB7G88mjLoirzu3119s4VzQMrLX5cRyHFGw/8JkAvBisEUg73F9q7
	XLq7djfDjo6ti3belZPKycUSMEYU0vDex7vtnrFblGEziAr3Qn/F5vq+a7CUO6XLvFTU3Ca8bEH
	0U0uEU3rwx/ha/mxxL+j2ZbnlDepM1QYn6lAMxp+TxkLRC3IXHaUh1/1Si4fBmLaDe/dqCZ2NKv
	GzQaRIMf+ZDVoNiLY4gq7iA0C7JCX9/bdmc+6xu5aYUGxxzNW/rNWUw9YV1JtbtOcwctQFNcah/
	r+3IZjk9hrfzzuk3HH
X-Received: by 2002:a17:903:15cf:b0:2ba:924b:3948 with SMTP id d9443c01a7336-2ca2d56494cmr38378155ad.15.1782843665333;
        Tue, 30 Jun 2026 11:21:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382bba19sm19483585ad.70.2026.06.30.11.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:04 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:19:57 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 1/4] net: add sockopt_init_user() for
 getsockopt conversion
Message-ID: <akQIw-CNuDasW-yd@devvm7509.cco0.facebook.com>
References: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
 <20260630-getsockopt_phase2-v2-1-193335f3d4d1@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630-getsockopt_phase2-v2-1-193335f3d4d1@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303318-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fomichev.me:email,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C743D6E7285

On 06/30, Breno Leitao wrote:
> Add a helper that initializes a user-backed sockopt_t from the (optval,
> optlen) __user pair passed to a getsockopt() callback.
> 
> It is used by transitional __user getsockopt wrappers while the
> proto-layer getsockopt callbacks are converted to take a sockopt_t, and
> is removed once the conversion is complete.
> 
> The goal is to help to convert leafs. Example:
> 
>  sock_common_getsockopt(... char __user *optval, int __user *optlen)
>       → udp_getsockopt(sk, level, optname, optval__user, optlen__user)
>                → udp_lib_getsockopt(sk, level, optname, &opt)   /* needs a sockopt_t */
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

