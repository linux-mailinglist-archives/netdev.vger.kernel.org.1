Return-Path: <netdev+bounces-252148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKfTDpWNcWkLJAAAu9opvQ
	(envelope-from <netdev+bounces-252148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:38:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D489E60FF4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6603D460F0D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C13C3803E7;
	Thu, 22 Jan 2026 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhMSVqhT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B842727FA
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769049485; cv=none; b=ZwsTiVd3KHK8xDIW5WvmH0b39FUMmeKfFmlC9nKOjzEMrsbtsdYet4bL2VBGEYYa0usAWwXDVXKg/5ln+qbgczirBIaYXNv19S7yUl0r8nnjUYtbEwJVvRh9whiGUEb0W9gPEk+INqZ4tOuZnmb0PQluEPvHNL7Rdl/eLYaqHfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769049485; c=relaxed/simple;
	bh=xOcQ9yPADCbR7UJ1g9E1fC0dWQ0e9bXQE17TrQyLXSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz8MIg+omZ+DQfPhkeDWf2vAXCXGVHyEPy53JMmW9RJRfAN0sv96T0OxezvyEbK5mP6IMet/kuaT8qHsYZYO8N8hB616k0RnqaHhQI4CvO2EKxjG6m7x1YsKK02JElkkPbuMs63qvCRts9dchI0aXM71OSMpiwBzPCr+QEfxlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhMSVqhT; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-790b7b3e594so5250677b3.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 18:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769049482; x=1769654282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=easMu0gMme66zzGb0htyoe1e3dWIakHvb8ICaoPX2OE=;
        b=nhMSVqhT8cDD5V79j5llAu8Dpk7kaoNjxpg8wQ8t2nnjIFEvXbSAckbH/3wPWX2A01
         DKy1aAUAwuGO+yY119Qoj03a3+XkJlq89Y9htnOClD6ggWVXz8P+gE48HONb/L2sKA+4
         IyqTxVmrmKLLLmFDwgWk7eotBVZI3Ke5ZLCYIyBiGgStAGNIQweW6KkeN3l2yErzHDS1
         afBsrnT727tUEeedrWpDYgvPOPLTuFA7F8nA4lIeAM9q9/Ha1IrWo4Dkzm4whG3Xpbyt
         NwpUPJeqPhjnsyTzGqWBtjysWiOn8Dagp8B802EQoN/CoCyaGhUVAFRER//v6uAHCPu8
         hZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769049482; x=1769654282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=easMu0gMme66zzGb0htyoe1e3dWIakHvb8ICaoPX2OE=;
        b=nNis1iRCmX3npHV1CR+KxNun2v/U1sGr9/cnc+krcEOPT52je1XcTN6+TsTX+2iKYp
         JkEfZM7O9/+B0u5PfC6UNIGnvN5zsvQ5HkGq68mhTyWs/1FHEqTbZSxkixRwt9eyRq9K
         r3Df3i9UfH6p+JtPgzqHGS63epDw1XZz3gey4MqpzFfJ1PRcV53xdJE1xVfX+TiGaxyg
         eRDn7lMpY/diaSEN8ahLnR7KQoOtVXO95SiVdWJSdB8GE9pSFH+Oifif5ZY87Eu5K41P
         tqJeRYoJHE4bI4C5AySWZpyOOksPAFpTtYNDOuFdKdOVaKq6b1oX4zqSuHNqwk9SVoDF
         UkZg==
X-Forwarded-Encrypted: i=1; AJvYcCU9thJPvm1ihYqBWpynTwDmKe7eYAdZsDGLM4nsxr4SNb+/PBZKD5IN21iEY2AcayYheMXguDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyte+5Tkwu5zahU4DPsRyAwhLsmu8KJmVtTv7e9JpJOZQpNU409
	KaE25hRFPIfilOnzqHOpRM1KoJ8rtBWdnyZSTRL9q//LD/jHufEHUP8i
X-Gm-Gg: AZuq6aLXGUtIsv9MSn7S0t9om8xvl10czYE43OLYRL8/i3CWOWpKpQbKnR8MRuOOebe
	XxXzZajnYBXSNUP73IJMgFVPfJV3JLPMu50no97Yho54nUYCo5zsqTtp11uBfR8hVpjX4x4oCHO
	Pnu49XvAzMl4oYz5wAHlDEo0U84m15zTXF/hvGbULyB54mAvDI+35GnU6O6nNLD82gynQHYzXBG
	7jkgQd3/qpTe00DeHrUbxSXGBUeeQkNkhh4/O5Ecgo6NNYF+A6f1xmJQQEmY1VdTSFqqP7reR/D
	TjsHIZE2j3dojt29fCgfmTh6GuH+2mley6SaYqqaiTKixGpuGSb/fSnY3Mvs+f1hXXNldLYttPu
	9oHJlPNnZ8IkQgaNBUSiaUlZitJtUvEcA1/jO4v/St80onqnxTEOv39BoPJiYRotny49K9o5jMt
	DoB4YAw8Qk3XZCnBJaSgCAdS45fXyK4Y9i/Ag=
X-Received: by 2002:a05:690c:dc2:b0:786:4860:21fd with SMTP id 00721157ae682-793c536b2c4mr146755317b3.39.1769049482395;
        Wed, 21 Jan 2026 18:38:02 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:57::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79429985287sm7862007b3.11.2026.01.21.18.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 18:38:02 -0800 (PST)
Date: Wed, 21 Jan 2026 18:37:56 -0800
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
Message-ID: <aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
 <20260120163650.5a962648@kernel.org>
 <aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
 <20260121173512.748e2155@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121173512.748e2155@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252148-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D489E60FF4
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 05:35:12PM -0800, Jakub Kicinski wrote:
> On Tue, 20 Jan 2026 21:44:09 -0800 Bobby Eshleman wrote:
> > On Tue, Jan 20, 2026 at 04:36:50PM -0800, Jakub Kicinski wrote:
> > > On Thu, 15 Jan 2026 21:02:15 -0800 Bobby Eshleman wrote:  
> > > > +- Once a system-wide autorelease mode is selected (via the first binding),
> > > > +  all subsequent bindings must use the same mode. Attempts to create bindings
> > > > +  with a different mode will be rejected with -EBUSY.  
> > > 
> > > Why?
> > 
> > Originally I was using EINVAL, but when writing the tests I noticed this
> > might be a confusing case for users to interpret EINVAL (i.e., some
> > binding possibly made by someone else is in a different mode). I thought
> > EBUSY could capture the semantic "the system is locked up in a different
> > mode, try again when it isn't".
> > 
> > I'm not married to it though. Happy to go back to EINVAL or another
> > errno.
> 
> My question was more why the system-wide policy exists, rather than
> binding-by-binding. Naively I'd think that a single socket must pick
> but system wide there could easily be multiple bindings not bothering
> each other, doing different things?

Originally we allowed per-binding policy, but it seemed one-per-system
may 1) simplify reasoning through the code by only allowing one policy
per system, and 2) allow simpler deprecation of autorelease=on if its
found to be obsolete over time (just hack off that particular path of
the static branch set). It doesn't prevent any races/bugs or anything.

> 
> > > > +- Applications using manual release mode (autorelease=0) must ensure all tokens
> > > > +  are returned via SO_DEVMEM_DONTNEED before socket close to avoid resource
> > > > +  leaks during the lifetime of the dmabuf binding. Tokens not released before
> > > > +  close() will only be freed when all RX queues are unbound AND all sockets
> > > > +  that called recvmsg() are closed.  
> > > 
> > > Could you add a short example on how? by calling shutdown()?  
> > 
> > Show an example of the three steps: returning the tokens, unbinding, and closing the
> > sockets (TCP/NL)?
> 
> TBH I read the doc before reading the code, which I guess may actually
> be better since we don't expect users to read the code first either..
> 
> Now after reading the code I'm not sure the doc explains things
> properly. AFAIU there's no association of token <> socket within the
> same binding. User can close socket A and return the tokens via socket
> B. As written the doc made me think that there will be a leak if socket
> is closed without releasing tokens, or that there may be a race with
> data queued but not read. Neither is true, really?

That is correct, neither is true. If the two sockets share a binding the
kernel doesn't care which socket received the token or which one
returned it. No token <> socket association. There is no
queued-but-not-read race either. If any tokens are not returned, as long
as all of the binding references are eventually released and all sockets
that used the binding are closed, then all references will be accounted
for and everything cleaned up.

Best,
Bobby

