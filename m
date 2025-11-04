Return-Path: <netdev+bounces-235424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0616C304CC
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86C3C4F23DE
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9196D2FF644;
	Tue,  4 Nov 2025 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT2dbuxr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtWWSJs9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1B2EF65C
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249094; cv=none; b=EOSZtW+RlGpA9U83jcx7jLEdeMUZI6qw0NF3L7V/BTRmOlhLAlWbqlgdj2fYSFcG9y8jqAF6upfxnYcEASsAVBxPiy1vwmcJTFfpsp4DSHiEL2BuQD51xBkCSBOViCnUq9g/Ja2sX1X8bHNe8Xtzy9HqHm8OQVnX21MgWbRw+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249094; c=relaxed/simple;
	bh=ArUnwMfmIEzmSnA8EtwjQrV26Mp15GPDfG/Jc+Af2u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIAxExVSsTVdD0P1jlmcjlb72SgFiA7sKl9PRoe69c6gGt9iXxD/SROJgbMEd0YB+O938QVip51ZN5t9Zj7whMPT269ujQiBR8IWfN6gEo5jSmPONV9Se6CsKUnLh6B0mCbzy66whjZS1q4iD3H3NCx1X18EH7W1olhVqXihTOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jT2dbuxr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtWWSJs9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762249091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pyvHBDgoa9Lgk2kT7iDSPcIKDbs+wNswe6QWBYpGLg=;
	b=jT2dbuxr3xGR14Ovgv3UiaA+pACK23TDy/0tFEHjJqOJuv6+J0MoPzwXamEPSRmJy/AoBx
	hpOHD8ZwUC3hGefScZG3a+QW5ciqBh34ieR8PDHmsNAFiBuEH0k9yPtnPoycC8i0aSRot+
	NXqwrebk39Ar+Fvs52hUhCuxitM6JcE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-kHcoupfnP4iZJZSiLVQggQ-1; Tue, 04 Nov 2025 04:38:10 -0500
X-MC-Unique: kHcoupfnP4iZJZSiLVQggQ-1
X-Mimecast-MFC-AGG-ID: kHcoupfnP4iZJZSiLVQggQ_1762249089
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475de1afec6so18505745e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 01:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762249089; x=1762853889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pyvHBDgoa9Lgk2kT7iDSPcIKDbs+wNswe6QWBYpGLg=;
        b=YtWWSJs9zg3NSSLRVdZCz4cndOeWKzlW3/yp8+eB/uDmDL5rxF/w4m3weYkguNjlsn
         lTzKkFBnz8kjoRCcATR2jvHgojM8MH/n7pNjDLhfRXKduTHg59TyG2rq0kqvaYisAsh7
         Enb1H3OGs1GrETn3PnYxZDQPqjUct28uX53mLZ5gqitASOmt+6dzxJgczv9bDZXcVXf7
         PpkD6BCRMldcZbyAHzwUSY1Ub65pORcV3LspEMRUB9BTSHNqGIDBceDRvFKQHxWwgKMv
         YAPBL+K3zqWoaCtJL26S/fSTgNsaV56KhQ6tgV71NMa0PItYhXEIkxYSiWuZUyBALiJX
         e/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762249089; x=1762853889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pyvHBDgoa9Lgk2kT7iDSPcIKDbs+wNswe6QWBYpGLg=;
        b=DZHq/nt+FT4hsBQS3AcoQliEb/Xz30AHAicoU9Dl0EaH9LYeKBSmxOgidDBQRMJ3mt
         +1opsSwMPjnt3/NTcFziAkze1hHuc0ApmK1/fo3peb0VcuZIS3oYKhs0U8d2LjC5MLCq
         26n3sW+Xj8DYOd9Vc8BHbiYkOXOvm5EhBriOCQnAwOa5oRmpnuNpXYQ/J/zOaBCV17py
         O7gBOrvR1K551Qm3JNxgxDV3v34gLr6jWmRwlphHoA9bPun+W4BD/B0Z7LldxqGHtA8r
         iYJ41mo3YOn9bSOXtdv5IscNpSDw0MeV/OhqRBZ3zsx2iSIWoBNw4/5Fsj1v5AHUTRGZ
         AYJA==
X-Forwarded-Encrypted: i=1; AJvYcCWIzA8vVl+Kl4USuLCnDzGBhCMUGJeYsKeP8jvEKfQkiy2g1jnIAIh3quEtFpB1RwXsURLUnlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Slpix0GYKeJtQ/CY9jIokG/9RNJi+qGDrjgb2myWYJfjk8yY
	u5KDOyGDi4CvOL+iu75tV1mjzDaPUhMKaz3Lu1Dy7yBu317CakZeSebkptcEOpnKUy8mzEXcXXT
	TnTYgLuSUpyrU37GnxCYhaaTem3060ukxMlbohpvPhsf4IkO6GF+sjNVhIw==
X-Gm-Gg: ASbGncsr92zVybCkSQrpHQDFhKYUHSjBarUu2CqrIPo3pUH9gXl+nGWSTH5MuVM60PB
	gXeU1Rbs56HT93DVeZE6nn+GY1jTD2IvZ1o1SCYzKRVMnbEnIlG0+Qeh5CvgK7j6KKtFylsl3xr
	o0o3pL/2fkv9OT7DcLQHh7By6FCUHzfpu2di0nRMaVVoIsMHdYCyR/SvRYrSoJWZORtR5ocZaoF
	ipkVTIZYt8GPW9Gd/GapcjfeN/uLhY9BZZIHiVhtvCGFMYQinarrc/xRUcL4vsPkbSlrzrFRyy7
	Y0cU80KBH4IuuEJh4wbbQLjy7bMCyYPL40SRYgJy7Kzv92kJsN2tdi8V8eYyhNFcaLApFa8JZRs
	skDneGfNxLrpSfsnn3VplVYYfIUq0IDfqFOJtscXZsNto
X-Received: by 2002:a05:600c:a4f:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-47754c451bcmr27965345e9.19.1762249088951;
        Tue, 04 Nov 2025 01:38:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG80tPo4mrfA3siN/+q+3zHsJR+5U2uhmtdOUUiclztFGU6pmZw6TuGG8AfTCenVCWwmNLdzA==
X-Received: by 2002:a05:600c:a4f:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-47754c451bcmr27964725e9.19.1762249088492;
        Tue, 04 Nov 2025 01:38:08 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c383b75sm248333615e9.11.2025.11.04.01.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 01:38:07 -0800 (PST)
Message-ID: <ffe0715b-7a60-49a4-802a-a2bd75c7dac4@redhat.com>
Date: Tue, 4 Nov 2025 10:38:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 02/15] net: build socket infrastructure for
 QUIC protocol
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Benjamin Coddington <bcodding@redhat.com>, Steve Dickson
 <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1761748557.git.lucien.xin@gmail.com>
 <91ff36185099cd97626a7a8782d756cf3e963c82.1761748557.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <91ff36185099cd97626a7a8782d756cf3e963c82.1761748557.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 3:35 PM, Xin Long wrote:
[...]
> +static struct ctl_table quic_table[] = {
> +	{
> +		.procname	= "quic_mem",
> +		.data		= &sysctl_quic_mem,
> +		.maxlen		= sizeof(sysctl_quic_mem),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax
> +	},
> +	{
> +		.procname	= "quic_rmem",
> +		.data		= &sysctl_quic_rmem,
> +		.maxlen		= sizeof(sysctl_quic_rmem),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{
> +		.procname	= "quic_wmem",
> +		.data		= &sysctl_quic_wmem,
> +		.maxlen		= sizeof(sysctl_quic_wmem),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{
> +		.procname	= "alpn_demux",
> +		.data		= &sysctl_quic_alpn_demux,
> +		.maxlen		= sizeof(sysctl_quic_alpn_demux),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},

I'm sorry for not nothing this before, but please add a Documentation
entry for the above sysctl.

/P


