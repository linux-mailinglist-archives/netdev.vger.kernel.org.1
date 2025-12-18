Return-Path: <netdev+bounces-245342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2AECCBC73
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 13:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE09C300ACC6
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D732E694;
	Thu, 18 Dec 2025 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnRTC42z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N94p0YOL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F42E6116
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060738; cv=none; b=J9mjKkGp0NYnl/voSIjhtOwCv7/LyZv8ZFbTXR8MxYoBGATPU6PyYOeAlARxB5pBkysbZnwfkJv5dpohKsgd5EnO9u0isNt4C88mcV2aA26QGyyRQQD3EZK96L/WGq6IyebVFhDS3folDDQhAyT7RP64/KTpxWxlgTcXnPEscHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060738; c=relaxed/simple;
	bh=g446pCxbogOPmsgxR1U2hiPWo0yTiw4jPgm7h5n4srk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sq91TkqPsLoN/jIunD185eYbKYlpmfKh/E1lSM6zlB8MrU9pkK+lZ5O3fULJiq5Vxz8ohQtJ99mNs+FBZjooj5sZf/X7ms482nIKsrrBPAp7qdnwWFSvD2KIxiPBZqJwPg3eqOEGpDQa60qXPbzGdJoSarfdv1hDqBGDXEeI0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnRTC42z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N94p0YOL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766060735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBDR/C8OIycMQnw+mvtf+lZVrY6YnjRU6cUOlstz+PE=;
	b=TnRTC42z1tkYLpaXlhOzFnLtqKoO0pHBJKepo1cbA/m1EPdULCam8uLUKxF5yJEYPHN2Q7
	Cxm2nyp8cNcZxXax42mCweNb78GoYdDsBggoGouOBbW1InS67p9BUhZKj/k+OJCUO19OBT
	5M6ZWcHwwRt6bkIrIyf5JLZvpelz+DE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-Bt6hR859PdeUmGU8pjv87w-1; Thu, 18 Dec 2025 07:25:34 -0500
X-MC-Unique: Bt6hR859PdeUmGU8pjv87w-1
X-Mimecast-MFC-AGG-ID: Bt6hR859PdeUmGU8pjv87w_1766060734
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47a97b719ccso3516495e9.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 04:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766060733; x=1766665533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBDR/C8OIycMQnw+mvtf+lZVrY6YnjRU6cUOlstz+PE=;
        b=N94p0YOLN1MPvm39ZFNMRAi4uAuNPj5gUwhVBjYaVFNyHaa87FmOMjivWm3U3U4RTH
         pU5ijKSSoYX4yy3bw5OyWizlj1fQHvRAkyueCYJCaDNplklV2QoxB0OtYIG9sKpfjxtt
         QgneX71Lrt8xV1boJD3h6C/7OibYpQdRElQSVQSCB4BriypAfolZGf+26n951lGnkyJP
         nbnZPDeETC/cwv+NZLlyYMuyHhAOj1yDp0M40oj09DQH6WHdxb/oqSBGNXGjsfnArbtp
         g24kn1DfvDkw/f20G553g227UgxKkfvZbfUktykQVGnOw+uRYckYXykLHPZyjjVgcn0h
         0Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060733; x=1766665533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBDR/C8OIycMQnw+mvtf+lZVrY6YnjRU6cUOlstz+PE=;
        b=ajRncQ5rEVADlPB8/V9qiIr8Ddm7Tv+RJEb028BiLIc4x5TlC3OUQKy0wTYgmntf4+
         OPcn5bRM441saga9pSUmAmuYZZTE1h3hteeupD8fdQQKEoZQ+vKCO4u3/UiGeBl0T/WM
         iqAjlwhYxhevuoJCh2z3zxY/lIHA4H3iYUM2f1qlCzVNTIUPqJpREOFWE7beNQ9tur1n
         3VUX+0adTBO1DXCOPS0ssJncUG+niGsAolq/pKJjtOWJoBBG5VJE3unsBrwCiSyvcvC4
         ZuZAMLLE+yMT50+9Mp7358IACX5RG8jA+UFFfrusr2yr6AjAnGw6lCUDt/q+u4sppL4l
         op9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvdp8vXBp5oHYztVnt0MzLMdHJoc31cy+q84AQlepppSiSWqm9QVHfU7gIDmZ5PEYG5Mq0I2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAD73MsmJn9ljgiJgr82isAq0XWOMe3MRfw1r8J9V1fXngk1Me
	wwJB9IDZlDO580jAiOuDe/MNIrIdC2VLGAmEgkpnhPUtnEM3BoaqIKWd3c+P5+v5lql2q1yaYhI
	4omD/adbjZ/vbUHiv2F2lYOvYR0X1d1GdoSNrwzzZi1EgPotr6qj2eG2NPpG9lXosPA==
X-Gm-Gg: AY/fxX7dQHYXTyo+XyqHeLoIFsX9nUw0bQQ4y+d5rqVyrpYdo9S8b7VCe+Vs4qqZdt/
	1XYbxiEOmYxLFY/glaT5U1ky0TCO2sy3Q+GFmCZ3GK+foLZkQCNZnSA6Aii3f2t860mrB0JkdIk
	0FpIH0lSmDjLkhYhQtK4KnLnuv2N20oR8NH5i9gcuelJB1vQQb07iWLydzRWh6dMPtALqKIF94f
	NToQ72VTVjC5EdxKu+qH/H1+gUNXmlAcdo9iK55LPFo8INAe1ZjzXHvMohtMtKePxyRPvKLlTEa
	bNKrPWA4p7K8gt/iAqgJKMurFA98QoEXAhZRLC3siZhaU36oD3P0xnOebo//riyJKKSSzVM+3LJ
	zY85FGrhfkW6QQA==
X-Received: by 2002:a05:600c:45c9:b0:47a:8154:33e3 with SMTP id 5b1f17b1804b1-47a8f90f951mr208747595e9.28.1766060733385;
        Thu, 18 Dec 2025 04:25:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbohIX9qIDX4l8X76X4mdFhyfXapGsjSNeRZsdrYz2q5Lor1FPIikVN63HsWMIrEqKvhUx/g==
X-Received: by 2002:a05:600c:45c9:b0:47a:8154:33e3 with SMTP id 5b1f17b1804b1-47a8f90f951mr208747385e9.28.1766060732987;
        Thu, 18 Dec 2025 04:25:32 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm4745537f8f.40.2025.12.18.04.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 04:25:32 -0800 (PST)
Message-ID: <280b18c6-2348-426f-a1b1-8c17d229c21c@redhat.com>
Date: Thu, 18 Dec 2025 13:25:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] ipv6: fix a BUG in rt6_get_pcpu_route() under
 PREEMPT_RT
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20251209124805.379112-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251209124805.379112-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/25 1:48 PM, Jiayuan Chen wrote:
> @@ -2299,11 +2308,13 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
>  	} else {
>  		/* Get a percpu copy */
>  		local_bh_disable();
> +		migrate_disable();
>  		rt = rt6_get_pcpu_route(&res);
>  
>  		if (!rt)
>  			rt = rt6_make_pcpu_route(net, &res);
>  
> +		migrate_enable();

AFAICS, this part is not needed: local_bh_disable() ensures migrating is
already disabled, if !CONFIG_PREEMPT_RT_NEEDS_BH_LOCK or preemption is
disabled, when CONFIG_PREEMPT_RT_NEEDS_BH_LOCK==y

Side note: this patch looks suitable for the 'net' tree, please change
the subj prefix accordingly in the next revision.

Cheers,

Paolo


