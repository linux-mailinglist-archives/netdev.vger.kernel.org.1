Return-Path: <netdev+bounces-161546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C29A22306
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 18:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0059E3A553C
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA671E0E01;
	Wed, 29 Jan 2025 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kYZqUmTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE41E04BE
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172061; cv=none; b=q5M74POgZ3Uva9juUVglXtY1VqK4LR1GAKwmfuNexraINZBdfU5UaAv+T5lOkY5zvB9/Z/+Manafk+UiYfz2M0hjLl8ysvoueCEkwXLev20zAQc/UXLbayuADR5k2gjzBm1bCPjQIAPRqyumjYpr4Gk7HzOhU38p7flZ+ZslTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172061; c=relaxed/simple;
	bh=zGljS/9FhfUb47+VGIh8ikTRIRMMgOhXhmPgPUZSEIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiNRIK7+3+yepxgor0RRBMGmMowt3DClLXqx9fMZ3dQ3L4d543w12C6QulYvkm326ObPV1KMPaS5iOidJwW1Ujr+yi6ct89IF3aW7fEX57p1cL/RTIU08m6dgPhlLGI38wY9xpE+FqPxBO90DgBCFmgMXAmIo47+pHwwijQWYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kYZqUmTd; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dd420f82e2so87437186d6.1
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 09:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738172058; x=1738776858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoQDpS1qfePfDFzhVnadb3EAh/sAqIsSZHWqGtMfdWk=;
        b=kYZqUmTdziQYxynReb2cOavmQh9Jbl2OPXXLWAvTm018EAB5qFGONw5033h0NrQ6Wj
         FXzIO/y3Oq4mCBQdTi7sGutH/TecQgxbOpfIMmom7EFgQtNYt8qNgpzNX/0vWXFVHDgt
         f95BWMSqFtTfLlUo/DxgNQuJc+bUBUo7flIb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738172058; x=1738776858;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoQDpS1qfePfDFzhVnadb3EAh/sAqIsSZHWqGtMfdWk=;
        b=Hh5ussl/LPQuWtiLbf+Ds0+YwjtVYIeaOpiSxU8PTkOoIVUFc9sU15fyYukpXdBasp
         TPXK/yUlzk/KkMoQYKXC3+FrajY5gbAaPrBcE+kYUMLJPrisZDs9CfdxtuTHp8FoblTF
         LwNN79e4gNUJc25U+gtJRsCYomXE2FNAEJjlwOVNSratJ+DKk8NtRBQ1nKCpsLYiSwqV
         DuHjNVQGxdnCJmseVQSBDyMwWnNEJ404MEh9fHmDf+M1Zpu81l9bHaHy13Sr6dNRCSzq
         wDtYWFOLUy05fNgOfgJ4qF2i+SEhhjUZR6CwnzRVH14TwlpS5wXUk5gwMieBTpFU+J4g
         3Slw==
X-Gm-Message-State: AOJu0Yw50CmBWDkEOrUHZvRh/U72i9XvPUb/wbDokFofwutVpU69ijz0
	qCJb/+OP89t5OfObV5JMa8b8sTNndIaAkH9HULdc9BtHhcsnCACPtUn9vAIhJjxfgvFlonx/Q89
	SSIMAV5gn1MT/yshvED7pxd9O7chVRII8aTfH5rHyTidLkVJOcLfoeGz1N9cosjTwy9/RmOokmZ
	VCeZ1XXx4Wnl2vi/LX6MuguUJnWJnjju2Q1P0=
X-Gm-Gg: ASbGncu+ZmrOwQOwWxH6ukDSzRzKRubltdKvHJdZJ9RwRN8W1QlN07N+bFD1aVrscWB
	iGl5f0TFvDsO39UqzgGdlZKhshCPdKTOpYdUtpR4Gl81dXF9xCt9unh9P17ZcmEJSNBjP6rlaCa
	2aKttpNao8t1HBwafxxs9Z+fAO+h2UvI8l/rKAZXGG0xF467YSCI4quc8IrKdg50iWFA3w+Dkvj
	N8Tue1gmwgsDmbxO89JMvrqdI5EgKRmoV9gEoKdI6727qbdkylYZbAuq+P540ZDKV7TUI9v+qZl
	YhIZYr8Pu88ui9G9DgawuoiUS9A30tEi5YOf1LasWdMdyWBWV8lXKA==
X-Google-Smtp-Source: AGHT+IF4BBG8e6/7GOvUoRvTwqooHavsdcNd1DktR9rvgjZFPh+v5/6zznBp3CHsRrcIltj/YWsCgg==
X-Received: by 2002:a05:6214:1307:b0:6d4:e0a:230e with SMTP id 6a1803df08f44-6e243bbba57mr62866726d6.16.1738172057768;
        Wed, 29 Jan 2025 09:34:17 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20525aabcsm56814206d6.58.2025.01.29.09.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:34:17 -0800 (PST)
Date: Wed, 29 Jan 2025 12:34:15 -0500
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: sridhar.samudrala@intel.com, Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next 0/2] netdevgenl: Add an xsk attribute to queues
Message-ID: <Z5pml3Hn3m3Km7Yk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com, Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20250129172431.65773-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129172431.65773-1-jdamato@fastly.com>

On Wed, Jan 29, 2025 at 05:24:23PM +0000, Joe Damato wrote:
> Greetings:
> 
> This is an attempt to followup on something Jakub asked me about [1],
> adding an xsk attribute to queues and more clearly documenting which
> queues are linked to NAPIs...
> 
> But:
> 
> 1. I couldn't pick a good "thing" to expose as "xsk", so I chose 0 or 1.
>    Happy to take suggestions on what might be better to expose for the
>    xsk queue attribute.
> 
> 2. I create a silly C helper program to create an XDP socket in order to
>    add a new test to queues.py. I'm not particularly good at python
>    programming, so there's probably a better way to do this. Notably,
>    python does not seem to have a socket.AF_XDP, so I needed the C
>    helper to make a socket and bind it to a queue to perform the test.
> 
> Tested this on my mlx5 machine and the test seems to pass.

I should have been slightly more specific, I ran queues.py two ways:

1. By setting NETIF= to my mlx5 NIC
2. By just running queues.py (without NETIF) set (which I presume
   uses netdevsim)

The test passes in both cases.

