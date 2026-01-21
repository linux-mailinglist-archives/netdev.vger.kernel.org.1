Return-Path: <netdev+bounces-251779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJkHBeFncGkVXwAAu9opvQ
	(envelope-from <netdev+bounces-251779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:45:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA43D51A6A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C147F484C9E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5A425CFE;
	Wed, 21 Jan 2026 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYKYkTXV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974AB421EFB
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 05:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974260; cv=none; b=eNEcxUhiqEJzWmh9uZC2hW7nuxNLkgsEgFn80symDlUmoVvBmsGPjnv1N+Bx4CvxME1JnT+8bha33x+l0rIj4lW9ySLuATw2rsXBEZUyy/ECDxXOtGmBqo7DUdOLx8RTXPTxa4W9ydtEO6gc2mmjV0Xq1wTvE/Jg20kTf/PssuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974260; c=relaxed/simple;
	bh=cCuhNoXS4wqZqsj/4ZE7U7PQyth2hfbCAfjifFmdGbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYYlhhI7ygaDsAjfTGvC3a3NVyc6eFzqxcCxS35uIrgwhH04EQA5+z0Mc7jkDphgwxwCcE7lgpvjvbA490Yu3Gn39KWePz4tTmEQbreJuO11426eKoQJkCKeag8mhb6+1VHIAi9YJpmV30rh8pUI8XHylbmOC5yQEKcI5JoyGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYKYkTXV; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64669a2ecb5so779742d50.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 21:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768974251; x=1769579051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MoupjKqNDGOAMGhI8qwEY3FdnLYKFkn3HlTzVq0GQs4=;
        b=PYKYkTXVVq1VPftFvETtr5mYeEShg+MMb1rf49mjquldDupu+J0rYNp5AG4YUt/wnC
         iWTvlbLzNVvicwf/bUvzkFOEpdz8CCymPflmTgxZ6kgQfwNfgIPe9X/hPGzHc3CvPaw4
         cAe2yJ2QKNSuWpyXAs+4SjHIZHpDtDzenYvCoNIODYtw+vS1vYOdqIGfwBhYL3VOT2vq
         qUTVyUL1jzEtC0SGwAXu0tMOV9z1h2q/rVHDBYO4YHeJWrEmVUsMoE/C4BHTmWndQTDz
         pwCtBEsAUmG6rORLtaG+tYFuhJ2GsjUOC81nt7n3NWXP12zx63Pw3pGLF8Ccsf3VW/fV
         YWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768974251; x=1769579051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoupjKqNDGOAMGhI8qwEY3FdnLYKFkn3HlTzVq0GQs4=;
        b=nTZ0C9IuFvadgjjR643w5nuQbMCJUv/YYA3Wd9tmFZuxB16xtJ9pJNFn45efUfHXsA
         +G4C4VsGLu8ouzadwTDm0am+qbYa4ZNP7saAvv95PJbmWx/wN2bP6oSrq9jWjwgQmWbC
         B9stAGvdhoxO1/wh/dWsmhkb05jYNdzSlbmu9cyVSzbTJq0FGn/RJXWFjDgA+51omoQ/
         Co6QvIV4rWMwRGz5kl+e77rpA9nUbMU3gKKxtyAqTFX+RrO/MZAde2CZo6f/Q+9KSmq1
         GhkI7mLU1KTplu3OOtaxG7KOMBaErNgW1pHGNw63xku1SwA5uSWXo/uEvuXwTUz34MLP
         uZOA==
X-Forwarded-Encrypted: i=1; AJvYcCVUfT7ZtL1/NhV0vVE6/iZg84fgf+R7cEWk5ZT568j7pSf3tuwL+/y34pTPaPc+BC+VbT4R2nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUc8RN3e1s8uDRnyrbfaQHCE3BxV6YybOJh4wHYMz5ZRVV0nr5
	lYmXcDyC9gXaC8KkSitLVOC5U5oC9USs53afviyfU2H9+YA2lxc8AiwI
X-Gm-Gg: AZuq6aIr+Ahn3QmyY7xsoPakonJw3qxPI6Qrnu2Xmrl9kj5ChxPBvDYts6JRXKKL8KL
	SsFUXU8pIl2Mp81XmpQbA+pOJRYHGp+LXP+ZMnqysWwHMPPsqZ3LOpGfZ7hxesFqWSIrhiQljv7
	iyYURVlHYxV6YaB7VFWZfh0ovsruRyEUrXiN6FISaA2rBJPKkgOA8NtTAsnu0QE6w759MR9Lf0w
	r2plbh+IB2OrUPTXE+DmyDVUP/7wtVI9SmrVE27qcuCI87U0XSLvdcCOuaqrgl7tuiJVIkPb0jf
	Tr19Qe/uWkyVfslfiLZKRclMb8sT8nSc6oL+V9fUEOVW3rBqgK68PY22RtzqC+REekeCoTDdr7F
	CrXED5b4v1dhsXFj+Svg0GRItEzpCNQW5Ydg3xgHlXDgm38kKrwPPe9kyVySXkvsxgLT5BpF6Pv
	3nLrJLX1icQ7ETJOdTPt9bjw04BJybAU97774=
X-Received: by 2002:a05:690e:1907:b0:645:5297:3e5d with SMTP id 956f58d0204a3-6490a6a0761mr15697554d50.46.1768974251183;
        Tue, 20 Jan 2026 21:44:11 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6493dcbcce6sm1687077d50.24.2026.01.20.21.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:44:10 -0800 (PST)
Date: Tue, 20 Jan 2026 21:44:09 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
Message-ID: <aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
 <20260120163650.5a962648@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120163650.5a962648@kernel.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-251779-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: EA43D51A6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 04:36:50PM -0800, Jakub Kicinski wrote:
> On Thu, 15 Jan 2026 21:02:15 -0800 Bobby Eshleman wrote:
> > +- Once a system-wide autorelease mode is selected (via the first binding),
> > +  all subsequent bindings must use the same mode. Attempts to create bindings
> > +  with a different mode will be rejected with -EBUSY.
> 
> Why?
> 

Originally I was using EINVAL, but when writing the tests I noticed this
might be a confusing case for users to interpret EINVAL (i.e., some
binding possibly made by someone else is in a different mode). I thought
EBUSY could capture the semantic "the system is locked up in a different
mode, try again when it isn't".

I'm not married to it though. Happy to go back to EINVAL or another
errno.

> > +- Applications using manual release mode (autorelease=0) must ensure all tokens
> > +  are returned via SO_DEVMEM_DONTNEED before socket close to avoid resource
> > +  leaks during the lifetime of the dmabuf binding. Tokens not released before
> > +  close() will only be freed when all RX queues are unbound AND all sockets
> > +  that called recvmsg() are closed.
> 
> Could you add a short example on how? by calling shutdown()?

Show an example of the three steps: returning the tokens, unbinding, and closing the
sockets (TCP/NL)?

Best,
Bobby

