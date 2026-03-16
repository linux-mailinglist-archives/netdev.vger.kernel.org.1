Return-Path: <netdev+bounces-268237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOd5DUpCuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:47:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6A329E804
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B957300AD80
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A26633A6F1;
	Mon, 16 Mar 2026 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duj3MXX+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeLjPWdE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBCF3321C1
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683269; cv=none; b=MfAllX5LW/NNrmKr8wngnbLSjp3LisCvY4DouIQQgJDNSRHGtHrqwtk2uFI3sP/wigPFhOwpaeGbkIwccpCPRQ4K42E9Iq21AtSJE59O94LO5Jg4dfp3Bh66NvdyBJayTHM5EyEQ9Y3/RXBnV44hWSDMG8xId9YJAx5RuAaf4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683269; c=relaxed/simple;
	bh=gRVifA1HxZ+4XsSQaEhHgwmLLQrL+5Qxxw1GlMu4spw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbzZeSxqrB80e2JzRZ3kLxlSyIJ+4fP82XLow7SC19/Cfsr2dFAaybY0ScDqCeD3yxiIyVp0uh38EHNbupU7V+QZ29v6Ntg66qn18+ZiblJ0sr+NprVSB6l/BK/P6GoyT4/a2UM3Fph5Dsf1xf+9zzZpB3TfZQ3svW2F5q9DpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duj3MXX+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeLjPWdE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773683267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRVifA1HxZ+4XsSQaEhHgwmLLQrL+5Qxxw1GlMu4spw=;
	b=duj3MXX+njab/VmBcvZw8iSHnEVw8y88Qw7L3ta4xobC5cVUB6q191Irw6IgQEuTHApnha
	nuFaS2q6BLjsPjdi2ZLDLAnTRhm6sJj+AnwxMp9f4c0NjjRdCl/3SblC2HzB+LC0qFVPXt
	H8r3v61AXtLQpEsrSuELzOJ5RMokaZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-M4r8JG7NPqKJu2KgrjEr7g-1; Mon, 16 Mar 2026 13:47:45 -0400
X-MC-Unique: M4r8JG7NPqKJu2KgrjEr7g-1
X-Mimecast-MFC-AGG-ID: M4r8JG7NPqKJu2KgrjEr7g_1773683265
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439fbfd93e8so3241674f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773683264; x=1774288064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRVifA1HxZ+4XsSQaEhHgwmLLQrL+5Qxxw1GlMu4spw=;
        b=UeLjPWdEbLMPJO28dH2NeRa+MttSHYudFRa+KhmsIdInbNh44SWTBvolw470a8An1T
         TK/Rpnas9g1FszbJ/HY+Y73fAMjjHg8VzPkbH3GPzz5CMcuHNqafM04j70ESxAAPWMnu
         A+uKnEGx1SXrGDqAFMN4tIH5rO3qxuCE/xdOiN/DQ/cPXNWzQPBnovtJJZg9LAadB8a3
         cBQt4Fh5Bj+UzrXzfwOEvRhmd425vSJc1OPJTj2Ba+Ri+A/es3ZQfwqUZgJIy5qUwApt
         176a8PfkWaR65l7m1z8uKDY5efTfjWc8rxGqqDnwtx/4FNbz/wDZHw6Mur7cVp/VtgQM
         /ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773683264; x=1774288064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRVifA1HxZ+4XsSQaEhHgwmLLQrL+5Qxxw1GlMu4spw=;
        b=LyeNqzJxkWm4Xick3FQf4ZI08wOrNRDe6Y8EW3NzPFgTWJYKlqWPISeLhTtTfzo6kz
         SIKdFlfyWzk3LN7wW5AN7dV1JSBCcoEmCuKG0MjYf06dVWJtqOGpFKdDdWiOamrwIbZP
         PENCot433fsI5ofMFQt3ZN+dlDAjtemQMLyOqAoaEACqZde7nSm3/AmOyuG7KvD8ZLYh
         WR2d4NJLOU/pWs8dRyr3lxfYLejbdvXFxX9Fv1M1LsSaYgHZYoyYk/YBQpm64BlTMBYY
         3bDFphcBn5uBUZBJU+vvfWlNVKpbZADsqY+jTcwCaFcVhbzUpnEvWMTLNaup9VqeR+ne
         fsdg==
X-Gm-Message-State: AOJu0YzNwZhqqAs84+XZhntIPqilHirStlrejzE0bNapLrNVXtnnxBUs
	3/yhL9K5Ag/o0U5KLCE/vXcnQX3OZV5Uvc61tEc+mGdkaC/ElCrt7GV5CKZeXCi5vuAYN8IwNrp
	oG72bDvwOSd+f4AdVyAok0yDXktxMTYo9Ei/UsWWN6v1ky6Ngidk5uC6iuw==
X-Gm-Gg: ATEYQzyVdl8n+cBw1E+LEBmCXJMZewEfKOkRutdXBuE/+TRv4rBTJl99izJqzODTDdo
	TM8xTw7g6JdBrq26nXv+kCQRN1EPKSHlYA6/eB+wBkz3Vl0i7UUAGD8cepr5y7EyMgc9bSHfHMh
	vQEDb+eWXHs5rHX4Wa65PjpuA0sKj7xS+jgxQWqongdNrb/x/45xEIpmrRQXwUFgDg2EeCh6eJL
	QGjbXso7PHck29RbvnubStpJ1AS1lCzmEiDa36UirBYPwfAEdT10vpkW3hMFbAwynmNyVE9CsuR
	dBlxKZKdJXcxe4VBe3ANdNQkidDX5snvGhOkyQLL9gOrHglS3gH7+XX863EOp/bkLV6Uot9bMqM
	EzdPm613/9h0qzh1fjTpBNrZmgDkil12DfauZGPMp6YR2j4FAFSZcpZc=
X-Received: by 2002:a05:6000:616:b0:43b:4352:1bff with SMTP id ffacd0b85a97d-43b43521da3mr8977681f8f.43.1773683264565;
        Mon, 16 Mar 2026 10:47:44 -0700 (PDT)
X-Received: by 2002:a05:6000:616:b0:43b:4352:1bff with SMTP id ffacd0b85a97d-43b43521da3mr8977613f8f.43.1773683264127;
        Mon, 16 Mar 2026 10:47:44 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b41ff92a6sm17659188f8f.11.2026.03.16.10.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 10:47:43 -0700 (PDT)
Message-ID: <e93ce797-4153-4e6e-89b6-3839a0b8bca2@redhat.com>
Date: Mon, 16 Mar 2026 18:47:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting
 across ratio drift
To: Wesley Atwell <atwellwea@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, ncardwell@google.com, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, dsahern@kernel.org, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, skhan@linuxfoundation.org, corbet@lwn.net,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 0x7f454c46@gmail.com
References: <20260314201348.1786972-1-atwellwea@gmail.com>
 <b042de90-79e3-4976-9bbe-b6df3266caea@redhat.com>
 <CAN=sVvyNpkyok_bt8eQSmqc4f7g7QoZBUmRmNRLoFz1HasEzMA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAN=sVvyNpkyok_bt8eQSmqc4f7g7QoZBUmRmNRLoFz1HasEzMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268237-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,lists.linux.dev,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D6A329E804
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 3/16/26 6:29 PM, Wesley Atwell wrote:
> The strongest real anchor here is the already documented regression
> around sender-visible rwnd diverging from hard receive-memory backing,
> rather than a general receive-accounting cleanup.

I likely missed some of the prior discussion. Could you please share a
pointer/link to the mentioned regression report?

When posting on netdev please:
- use plaintext only messages
- avoid top-posting

Thanks,

Paolo


