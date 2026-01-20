Return-Path: <netdev+bounces-251532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JPpD1TXb2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:28:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E570C4A5EC
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A1AC9690C7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFCF334373;
	Tue, 20 Jan 2026 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyO+c4Py"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A33314B9
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924821; cv=none; b=Z6atMHkUCDRaAV1j60rxDYapkCFhUobcaAEbxz07xGl0GSiKAodgoAMjra32aUdBa89hUBS/KKYfnS1fBkObZDe4FjMhw79+9eQbvDE417Y70kOj8b+1Ch9WPGsLBfrunVqG55IGoBumDYvyQH+NW878vCeHOL2k8TN8GSKBhB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924821; c=relaxed/simple;
	bh=IB+sIXEjGEhU9cqcsuNosGFcQqX5n9sKNDGU5mhonx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiimXBxRQXSADq6YERZ/K2ZrDU5hbKh/uw8PfQ39q2Uv9JtCfjJEc70gtlIb3Vb2sEO6OxrIssjthVWN5S5oYuclCTmr0huDSzieiEGw7OyevmQ70B5EjRM7AUYJRxpqm1fIhGwQyOA0rZHNRxghC0ENYSWuS9hy1BM/P3KEgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyO+c4Py; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81f3d6990d6so3298588b3a.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924819; x=1769529619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayo5jQZPeaTZqwD9/xDSR/da6D6Deuo6ebApFmbkVFM=;
        b=UyO+c4PyElHC5I/PVdjmqMq9rLYRC8UrYJTG7X1iLbsB4yd5gpsffjH8WOWQZxXMJE
         SiJbFD51O9/8aKIHBVdSLvAfoRHQgwUaFxkKiH5WzkozI9/mzKUnMbsTv2BQ0dxBOakZ
         ypCgTOuFx5MrWATlxgRO+NMiYvtMIL4QtBQb0MXTkqM51M6UfcdNhrJMPvJu1jR0NyIU
         z5IF0GrHtOeWegVH9Ab7nHyseYI8RZxwb79zrJG6zvCTyFBe470UW+/gaHmY0wc0MTJ/
         o7OxLqx5MTO21lngRhMjbdSPJjUpCsbxMKqz+oj2hy0CaETmEdjLv/orvmbH7DGUKgia
         6jIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924819; x=1769529619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayo5jQZPeaTZqwD9/xDSR/da6D6Deuo6ebApFmbkVFM=;
        b=X0KjnTDFTlAJFD8F8YHmGGlqjN1QWTzRwq0eDxuGkDKuFkFRTCmT0PLJSjZzT8I/gJ
         M8Hboce+1GoCCyRHZ26Inzuy3IvF1REKoxvY6wcqyLBCJbyNlynnj2eB9k+5ZnhZ0dcG
         4wT6BJMSrUXkVYBJRXEtsMEtxei4Ko+JTWugER3hFf40lPk2mR8i7h1kjrqJKuJFQ6Qp
         VIyN2/bf+aOldyqOkT6JXwS+FHB+33uzjFaCJW4JZCENr0u5B1eMbNO6msY3YUblBfjS
         wW54oK4lizgoktQy9v7L9DSp5icM2HpJ21o9T8AWdMHVnK0z4IZShVkyj+uiIpi0GvLw
         zSYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlcMafbvaorAHsjkJo74G1bkMmlzAmzgDwRUvzxgdjbR9m2EUJx6uzhEDpP9l2M9UjHB7WXKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJ8zUMSUefGyeJGckbntVoaE60J2qS0dfgGbPxJqiDvq5L0ml
	Bscg9noHWcS/fwdkxfOSQGkH/HymCu5NZ4jE+09UgCVyn1jRwUFDMIyk
X-Gm-Gg: AY/fxX6zFJeFd3JlzDwVYBQxQk7KETEVqxlueXzTYZ0oQBsEmdH+rfAa2LLwxYi2ZfJ
	y4rIklroE9vPB1N4mCJci2MH8vbgNJhBAuvHHa5k6P7WLkNi+th4dcY6dKQaqkEvFwJ3kiC8Xi2
	X0QlInnihWk0LqUdVI0Uzhshc4pQGHOhMvKhJ0K96TPnt6Mevs4qLf5H6TsJDHaqIiygsfRaYTw
	FASKZAi12CzHQH4poxDCBxClWwNmTcw3R9cFeoLRIzUZCNMuQTvguMkYvWieUbZTeogwVxglSLg
	sjsVU2FmDgMtoklHzP6qaXzX8ZFi9VIuK9psE7NzPrCuIslYkGaNOFkqER2oF5RFdLZm5Q0oglN
	29gPCnVLkHcRjV8xGQSm31R/+JmYOFD5rUlnUTdEqFkN735jntgFbM2wwuSiwgZt0YmoscmRn6V
	XT7qTvwTc6l5I=
X-Received: by 2002:a05:6a21:103:b0:35e:e604:f78b with SMTP id adf61e73a8af0-38dfe590340mr15226404637.3.1768924818506;
        Tue, 20 Jan 2026 08:00:18 -0800 (PST)
Received: from inspiron ([111.125.231.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d68asm12193550a12.18.2026.01.20.08.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:00:18 -0800 (PST)
Date: Tue, 20 Jan 2026 21:30:08 +0530
From: Prithvi <activprithvi@gmail.com>
To: dranch@trinnet.net, f6bvp@free.fr
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+3f2d46b6e62b8dd546d3@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: Testing for netrom: fix memory leak in nr_add_node
Message-ID: <20260120160008.2kylsycgrpzcwvak@inspiron>
References: <20260117142632.180941-1-activprithvi@gmail.com>
 <f108f1f4-cdd3-4b14-ad24-d1ef328ca316@free.fr>
 <46f8fefa-f549-0b8b-d37e-0d608c5ee5f6@trinnet.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f8fefa-f549-0b8b-d37e-0d608c5ee5f6@trinnet.net>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251532-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[trinnet.net,free.fr];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,3f2d46b6e62b8dd546d3];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E570C4A5EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 07:37:07PM -0800, David Ranch wrote:
> 
> Thanks for catching that Bernard and I sure wish kernel committers would
> test their code before committing it! Does the kernel show any sort of
> diagnostic information before it resets?  An oops on the serial console,
> etc?
> 
> --David
> KI6ZHD
> 
> 
> On 01/19/2026 01:06 PM, F6BVP wrote:
> > 
> > Proposed patch is lethal to netrom module and kernel causing a reboot
> > after a few minutes running ROSE / FPAC node f6bvp.
> > 
> > Bernard, f6bvp
> > 
> 

Hello Bernard and David,

Thank you very much for your feedback. I sincerely apologize for the
instability caused due to this patch. I take this instability very 
seriously.

Unfortunately I am on a low-end backup system right now which does not have 
resources to build or boot custom kernels effectively, locally. That's why, 
it has been difficult for me to test the patch locally due to which I have 
been relying on syzbot for testing. I am grateful for your feedback by 
testing that patch on your setup.

I will work on investigating further why the kernel isn't stable with this
patch and try to create a better fix for this bug. 

Thanks a lot Bernard for testing this patch. In case you get any crash 
dump or similar information, it would be very helpful to understand the issue 
and fix it. 

Thank you very much and best regards,
Prithvi


