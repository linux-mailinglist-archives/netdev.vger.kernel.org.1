Return-Path: <netdev+bounces-251776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AExwB09kcGkVXwAAu9opvQ
	(envelope-from <netdev+bounces-251776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:29:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3195187C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 640AA429481
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F903ECBE6;
	Wed, 21 Jan 2026 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5Mlk7u9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D53E9F6F
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973381; cv=none; b=K4epN2zoFlEhtKQW8yuem8spupha8HP9sj100XJCpF6S3G0nIif1HGtxj6IK/1SlgJnuUhDH/Qb6NFzUvKsF3ahuT7tRwF8bsddggl60oSi/tNQO5Srx8qAVnMviwrqTZlA9bQ2RFJRYxfcDjU7XfVudxFkBJzgGwaTVw7i+Zyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973381; c=relaxed/simple;
	bh=uQc7kvpnr3eWQJ+H7RqNdRd5OZKaD9lrnlN+V2TeZpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUD0KcjebuHt+ICo7EUdSdHe+ejANV5RsLFSVVLLuLrVcxZV4ZrzsOPLHTbnQ8g8dvyaFUL2GqpPbKV3MYqdnIr6IyWCBYc3cL0p6Hw6Ws1ub38QdvKEJYNdYM6ONxGoXYKSbKRoHYN7NlC90ek/TdjaHtbQNIQHL+2jup33/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5Mlk7u9; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6420c08f886so8190776d50.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 21:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768973379; x=1769578179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj8z6sgYRSc2zcxSy7UyhR6bNJrDd7gH3jcOHm2KVdE=;
        b=N5Mlk7u9FDtv8iuzab4wtE//XR4wWyXKvWvfNWKiMhMYaY2hk90IsgZpkX9QxE5r5W
         E+qUf/NIq8OaJIc13eE5mtj6u9w7AAHIIoWzH5gg9L15O6Gpkq0vl64BijAuY+dpdn1l
         Cd3MmbfbEGxleWpjm6Qz/UbSFqFOZ9oFZnKUfmoKwvefd+DUMatAKmC7j6CtXDqMy3wb
         oKDTDIyRwiIuvQvjbjA3GujyM2WPByE0MUuc7FrndL7Og6k87i8CnbJAosSKeGKiJjob
         4tZXjTKNqik++zdsjhNAQVzTeWVwaTbOEpfXcEJp4VjS9nLKnffIbWsvhZN+tSimS6Rr
         upOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768973379; x=1769578179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj8z6sgYRSc2zcxSy7UyhR6bNJrDd7gH3jcOHm2KVdE=;
        b=uk465802dGmAt6tsMRP4Vl3camDt6nw7hLMxzttJjlwkEK9f6PPh+8T7wpDwl68rWk
         /kB4WghCZdFkKeiYgKsE1P7doYs8VuGmQ2Ik9es6j23Vh7sSmTXqfIIysSD9sJcL24gI
         94BHGazG2g/rncA2Vki2y8QVeNbgu9lBBYFUFPfsGuV8bjBSlUb2Yp0RZiMpeim/qMYq
         7fsvKWtpmBFRC44MrPGggkcT62ZFAIVzUulH9ckb6uQgLunKsEbPvB4rOgqhxDzCMAlL
         Zj5TRDsMo0eRopKyHKfd/9fc44qg8gBpRYroUlZWcVF8PZfqrJPlYlzzV7gWruErFmeu
         hWjA==
X-Forwarded-Encrypted: i=1; AJvYcCUQOpCEHDtXrIFhsPqhsqErSFxS1UI6TDi/PHkOiORr5qWbthGq5Vdy7My6Q3OmIX0mAxcK6rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGAHZ9qA5SGyxL0EhtTCVsIe04sLc3psMB/qeaHEgfXwSQVRy
	5nnPbkNtKfgPi+ZTgWI9RB/GXlyDQ6nl03zl9aRnTVS/+auCsxnRFo6W
X-Gm-Gg: AZuq6aISD6HaP47lihMhIaedmP8cveySKCapVjdHnA+CPtOPFp0U8kEQrrwumvucbhg
	id9JEs7LTNJGJnVb6sizTdW6l+TAPupm7IqJeztHtxFQhBHIgh6YA1A6YiyTFqj5pp4yENpZT2H
	o9n3ujLfY2E4BF+ihnVt1Z/CtMOTX13si5x3ma/9XGLgQz2H66tDBcfTP5+sz6ZHS1HCxBxKfqY
	kBcApavwk3xdzklybNdZccdTPONUKw3ikS/SePhSGij3cb+XWuaXPtvjolHXOZ+2S9pmwjHQQX6
	h5IxaoUW7Dl3iApFCE8OWtYwJap7wsGsPANDOH4Vf86NGB+9O6eFsKkAUfJjqJ0vIz7wkGqiCHD
	dauogzBfplmG/o92+xNkfQvIMLBn86zoSNacmc0ESalWLqTYpeus4MxWgY6AZd/HeIyYctPch+U
	mf5WP1T1NquRJkEu97rcGmFhLRfTwsd3MkHw==
X-Received: by 2002:a05:690c:f09:b0:78d:b1e9:85f0 with SMTP id 00721157ae682-793c6831d0dmr118307367b3.47.1768973378948;
        Tue, 20 Jan 2026 21:29:38 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c6888b83sm61022937b3.48.2026.01.20.21.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:29:38 -0800 (PST)
Date: Tue, 20 Jan 2026 21:29:36 -0800
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
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
Message-ID: <aXBkQErscGzJwh2i@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260120170749.101e8bcc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120170749.101e8bcc@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-251776-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0A3195187C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 05:07:49PM -0800, Jakub Kicinski wrote:
> On Thu, 15 Jan 2026 21:02:11 -0800 Bobby Eshleman wrote:
> > This series improves the CPU cost of RX token management by adding an
> > attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> > binding to avoid the xarray allocator and instead use a per-binding niov
> > array and a uref field in niov.
> > 
> > Improvement is ~13% cpu util per RX user thread.
> > 
> > Using kperf, the following results were observed:
> > 
> > Before:
> > 	Average RX worker idle %: 13.13, flows 4, test runs 11
> > After:
> > 	Average RX worker idle %: 26.32, flows 4, test runs 11
> > 
> > Two other approaches were tested, but with no improvement. Namely, 1)
> > using a hashmap for tokens and 2) keeping an xarray of atomic counters
> > but using RCU so that the hotpath could be mostly lockless. Neither of
> > these approaches proved better than the simple array in terms of CPU.
> > 
> > The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
> > optimization. It is an optional attribute and defaults to 0 (i.e.,
> > optimization on).
> 
> IDK if the cmsg approach is still right for this flow TBH.
> IIRC when Stan talked about this a while back we were considering doing
> this via Netlink. Anything that proves that the user owns the binding
> would work. IIUC the TCP socket in this design just proves that socket
> has received a token from a given binding right?

In both designs the owner of the binding starts of as the netlink opener,
and then ownership spreads out to TCP sockets as packets are steered to
them. Tokens are received by the user which gives them a share in the
form of references on the pp and binding. This design follows the same
approach... but I may be misinterpreting what you mean by ownership?

Best,
Bobby

