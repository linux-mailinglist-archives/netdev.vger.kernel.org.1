Return-Path: <netdev+bounces-252541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNcqHcKXcmnBmwAAu9opvQ
	(envelope-from <netdev+bounces-252541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:33:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCE86DCA4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C45F83017FAB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C0739DB27;
	Thu, 22 Jan 2026 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7vr7vL/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1F320CD9
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117628; cv=none; b=n5HD6S6QcfZo8FiQMPeGBkn6X00GIOg8OWNAeps6IhluOBqjcfDMZNFQvtUfa1UcKGgwi1/3wU6K8hslkH65ue2jR5K8onK1IAN54yEuPPRz4YpkKTtZH/NuyS7fvIxaWWZPd8IQyDb/p4WMCOs1Tz4yOdGt1wdAYKCpuAmrUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117628; c=relaxed/simple;
	bh=VWTGDCr7KnAlmNEQXc/XS1CrE9cI7qAt5PrV1estoEY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tXwOTPxpNDhltas3/3hqILvG5MHEWUzRCbByV6gaZWJsplm9aZfDPaPcS5XG0RhDON8+I/RXJPIK8DaqGia5d5Wwz3wiS8dH0+mg1pMm58FYqznXGhxuacyy01cQl/LYGGDDJ6/iRyeplp/R8+47QL+2OJVfXHKZVSivUFJPw38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7vr7vL/; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7927261a3acso17592457b3.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769117613; x=1769722413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a56DweiDNwNIUw9ae441GHBe14i60YZrvGqHo80giZw=;
        b=N7vr7vL/GxW0aaGCQ845UIZ+mpYQx1P0ptxc3U2HKMLovtKybHYXG/KradIFhPV6Im
         n4o3icVDmMseQNITJuOSbB3XdF/hpJGpeWKOgOjQiCtUuEKsQrOTJjf/VLWMHFMDT7wd
         j6RZlfoU18x+9u7V8veG8KFBBlfuUVXuC0JmZVqUCGNs8OX08lRFp0SUhqWPx1ss2ERd
         GJPPGWnr9gOGX+q9Rgy9xkFDbgLLnuGuzmoz67kLi63o29goIW+7GXyjgRC3EEr1nxHa
         b9eVeio4+XmoDRumr9Kv5a2Kd+VlfIIfJxtF8DyKxHo+9IciJS5sHDSUX2uanIkNyaQA
         6ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769117613; x=1769722413;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a56DweiDNwNIUw9ae441GHBe14i60YZrvGqHo80giZw=;
        b=kPhO05ZZwOd64rtiEEQ14BaF3xnVxlRC3TZLi3i/SachTJ0W60yCJ08Myzs8go+l68
         5EHxHZsKEaqhgjFeU95xM5vNlRdCWgtUPHAKxn621k0jLLwJJYIclq2deSD9teeyPneL
         qdvFrVMqON5s2U8NSAZtPiTZ4JoOGrttGhCjqGcyy7t/Z5pY/oxacDcP4CdlEUL0Xd/X
         1HikxyneH2/xL3WdZz0i3ZQS0vJkGYw0GYVDBdqqmrUO6iBtSacwiofmDbZP4hoaj3sV
         7bEf53zu+3ANk6HCUAhDobMjQv9XtKwNS33sVpVan+/mP0Jr2GLHdwK+Rn2cMmf1PJHS
         D2qw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Le0Ree3DLp+IeaMQjm6rJzsvzhGuQl6e/JlFgqdvFyh1JxPEw+JZHf3qCmKAq3NYmduMqfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKFmjRBqjnuwnKe4R0jNfHyTJv4y3uTFekYkB5bNvO4zqCtlh
	G48jXz3t9B9WkN0zNR2QFj/Dmru8wJXULUBVqq+g9VlTTOvKotizuCCx
X-Gm-Gg: AZuq6aLfzr5AQQQQ9W52CXG2WYj5sbo8+LRtUf/TKGMW+Sh2dZ4ReF9eoCQCPqIpy4s
	7i9NCzhZ8hKqqZxmGegmLeAq5Z2vJaxEDgRbSr0alu6mYAbs109EUdTBbCzueFYL9oN5EvCPcG4
	oByLY39u1X98/futGs5WMc2L+XNMa/zZ6DPMz15dZ1lOngRhlGuTJ4MNv8pNgfxo7VOYnA9bKta
	CKo86YXGLq2dUej1e1rOWjoRH8pSomNMe0JboWbRLDO3W9mBFWJ8drULK/xSssrTHKSyrAQm+ml
	DMRM7G9+gTQVz80/RvteUzVywZfgmpsCShzGWminoLLsQMAWf1mHAQ+svwXgP5hIJfo7pdstT3I
	o10AzvFduK6SRYAbeZ1H6v8saZmKVd5+jNM/reCOiYDqpIkJ/JEQ8yOeWOHZK4YZTwn7PQWYI9d
	U0TYnlfV3EYwc/prKvyuDIN7attEwue/0wooFLAvGbmcVntEDCsATBGcEQfPU=
X-Received: by 2002:a05:690c:9b06:b0:786:a967:5a8a with SMTP id 00721157ae682-794399ed074mr8536437b3.51.1769117612037;
        Thu, 22 Jan 2026 13:33:32 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943b2b9e7csm1919737b3.41.2026.01.22.13.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 13:33:31 -0800 (PST)
Date: Thu, 22 Jan 2026 16:33:31 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Soichiro Ueda <the.latticeheart@gmail.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, 
 Soichiro Ueda <the.latticeheart@gmail.com>, 
 Miao Wang <shankerwangmiao@gmail.com>
Message-ID: <willemdebruijn.kernel.f1685fbda48c@gmail.com>
In-Reply-To: <20260122033605.148626-1-the.latticeheart@gmail.com>
References: <20260122033605.148626-1-the.latticeheart@gmail.com>
Subject: Re: [PATCH v1 net] selftests: af_unix: drain after peek and verify
 SO_PEEK_OFF reset
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252541-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com,davemloft.net,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDCE86DCA4
X-Rspamd-Action: no action

Soichiro Ueda wrote:
> Extend the so_peek_off selftest to validate behavior after MSG_PEEK.
> 
> After exercising SO_PEEK_OFF via MSG_PEEK, drain the receive queue with a
> non-peek recv() and verify that it can receive all the content in the
> buffer and SO_PEEK_OFF returns back to 0.
> 
> This improvement is suggested by Miao Wang when the so_peek_off selftest
> was added.
> 
> Link: https://lore.kernel.org/all/7B657CC7-B5CA-46D2-8A4B-8AB5FB83C6DA@gmail.com/
> Suggested-by: Miao Wang <shankerwangmiao@gmail.com>
> Signed-off-by: Soichiro Ueda <the.latticeheart@gmail.com>
> ---
>  .../selftests/net/af_unix/so_peek_off.c       | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/af_unix/so_peek_off.c b/tools/testing/selftests/net/af_unix/so_peek_off.c
> index 86e7b0fb522d..813e3b3655d3 100644
> --- a/tools/testing/selftests/net/af_unix/so_peek_off.c
> +++ b/tools/testing/selftests/net/af_unix/so_peek_off.c
> @@ -76,6 +76,19 @@ FIXTURE_TEARDOWN(so_peek_off)
>  		ASSERT_STREQ(str, buf);				\
>  	} while (0)
>  
> +#define peekoffeq(fd, expected)					\
> +	do {							\
> +		int off = -1;					\
> +		socklen_t optlen = sizeof(off);		\
> +		int ret;					\
> +								\
> +		ret = getsockopt(fd, SOL_SOCKET, SO_PEEK_OFF,	\
> +				 &off, &optlen);		\
> +		ASSERT_EQ(0, ret);				\
> +		ASSERT_EQ((socklen_t)sizeof(off), optlen);	\
> +		ASSERT_EQ(expected, off);			\
> +	} while (0)
> +
>  #define async							\
>  	for (pid_t pid = (pid = fork(),				\
>  			  pid < 0 ?				\
> @@ -92,6 +105,14 @@ TEST_F(so_peek_off, single_chunk)
>  
>  	recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
>  	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
> +
> +	if (variant->type == SOCK_STREAM) {
> +		recveq(self->fd[1], "aaaa", 4, 0);
> +		recveq(self->fd[1], "bbbb", 100, 0);
> +	} else {
> +		recveq(self->fd[1], "aaaabbbb", 100, 0);
> +	}
> +	peekoffeq(self->fd[1], 0);

Do you want to test peekoffeq before the non-peek read too?

>  }
>  
>  TEST_F(so_peek_off, two_chunks)
> @@ -101,6 +122,13 @@ TEST_F(so_peek_off, two_chunks)
>  
>  	recveq(self->fd[1], "aaaa", 4, MSG_PEEK);
>  	recveq(self->fd[1], "bbbb", 100, MSG_PEEK);
> +
> +	if (variant->type == SOCK_STREAM)
> +		recveq(self->fd[1], "aaaa", 4, 0);
> +	else
> +		recveq(self->fd[1], "aaaa", 100, 0);

Why this difference in length?

Because stream read will block if > 4, while datagram does not?

If so, can perhaps use 4 for both or explicitly use non-blocking read.

> +	recveq(self->fd[1], "bbbb", 100, 0);
> +	peekoffeq(self->fd[1], 0);
>  }

