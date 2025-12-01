Return-Path: <netdev+bounces-243082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A206BC994C1
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5781E342A40
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EEA2848BE;
	Mon,  1 Dec 2025 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awW4FuAi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF425F988
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626795; cv=none; b=N/Naqalfl2SgatX1IIjqrsxDR7xgOYe7kpfILV/zXKZTUlFOpdT7U6yFB+soIswCTSoajX2Ch03sW9PIYeBDMYpi/YW1OmJw38l2xZBCPWzCT+SzPiRRgN7XxTrCQXFKGnCsf0b5KesopJ6wriZtoTGOJQshb7ztaM0eWOS8l2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626795; c=relaxed/simple;
	bh=a+/3Ja2D/pQZL1X0Dhkaimbdc5lxjQT2Xnvsi0l8mf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7KslACnnuDqz/Bjid+z62bEvX39ncJB+BCTT6ihggUB2mwiXiObEUdl+6lj/coEiZaiymXSj7HTm3JwfFyTxwxcIvxGJkCw0HBa61sW5n7l9bPwyPvdxw20pAGBuuFK5xcybQuD80YpOFNWfke91hzOYNPAi3YV2RnLq6Lm9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awW4FuAi; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bde0f62468cso4849648a12.2
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 14:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764626793; x=1765231593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzBsG4oWJXV6B7jpmlKeQ9wP6eF71jAwh85HbHOqniI=;
        b=awW4FuAi/RtjVS0xcsfdV4j+6Molx9MNsVRFq9YrhbctvqJJii0nQNzzovsyGD97pH
         XniicBI9J/ibOWuaJ9HczsVnYMvV4vvrt9U8GyvndxTypPgMwdKuvMgC+9BPh9POmB3z
         1oNVS1Vcji40EcYnuLbxNJALzIxL2DM7cHJdJ5YMuBZGdbIt0sHQwe9p5VHJzIOV2vmq
         xS2nZLBE0RaATbcOLUw8fxPnqzxUk/lQcEkNmpHjM3mbEINxz2916DPEq6kPyHAmXYMg
         XUm6ev9YzNFrI7aN0yyA42nAJYXgKwsNysUBZZF5PQkxcFnt99BEZk3Y72c9V/6wD2G6
         UfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764626793; x=1765231593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzBsG4oWJXV6B7jpmlKeQ9wP6eF71jAwh85HbHOqniI=;
        b=LCQQeBpA/rFzhIh7c2eNZPuJh0GDHzfYh8x8KMkVNTYZh1icFeCKcwpNScEeLiYRJf
         pISYJCPJqVFDAaPF/dbQOK4RYDnZxgmAA1ToLHrc82Yv5WUsDZj8pgyWGjrzrAGU4qSi
         StROaJgWrY3rhGrjl9HZzCAdjLws26S2Tt7dIE9ofJt1mToL0p792IW2HOBNOg22VgJR
         jYutG23FqSDyw7XQxBjh8ZynSApJnjKfWMHuGXdQRkvskUdHWEzyuAiwE4EFKooCGbb1
         /N2PMtL3RhV2PkVW8nziMUEgS5iszM9Yj5h+d2EEOWemgPmQSDdvoPk1o5BbM5mB1tmf
         Za9A==
X-Forwarded-Encrypted: i=1; AJvYcCVDgcB/REXiWdqsxvPgDviaRTeLzIBs0OdMGsQRuUOS7jKyLBa+0aZ2emWqRncAOdoxb2bj3Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9s83fxWO6bvXV0nq5nL9fIpcDIIiWC6Vtqn/uDhzrkouSssQh
	HXiZ7pB8cnF1/PpBkrmjInCG8AXNpUyL/KD7O8Gnn/ivYicyV2g2CRLT
X-Gm-Gg: ASbGncvc4gL4DffO61CmlgWZSsC8kAxQOHH9+S+hRLa24h1rSM4RYRstnQCnGoKUBCl
	LCyW89G3mNhXl9RNzOWHRM7mMOFlZyZA6s5EBf6PSLrhzLBo7jAciLfyqfjLy7ewp0XOS/2+c+o
	VGkl8GcMIGvPKwpTbRhuvejGZzNsH7VLPo9ix5XGDlJDTbaT6LfUEyX4YlDbMSFdmboLi+utUqr
	zAw38xoqUfu7oTs32CVAVtAkkBe+DpFWDVJBuMbl4OQ30Enm3sjW2jltqJMAmWCi+PjPZT2HFe5
	4BGexf5EF9JYsg5SE3jb2fGCVJbdgIE2s4ogiwXspYM99IlDOJu2NRzdeXjNJPJNtmhABFYRRa3
	arWEZolPJ+iucP79fMxnW6brx2PYSJcLfQqzK5LntVo4OnB32M6+nbSV+REeGavNIvyZiTNBD2z
	Lu+nrlYrJJqQ==
X-Google-Smtp-Source: AGHT+IGhmMxPsgaoPXnzgSVj6wNtw4Ah5MXEyylsvvZXtki7UPfq2bXLwFkO2O3wbGKc+QoBFG6+CQ==
X-Received: by 2002:a05:7301:b16:b0:2a4:3592:cf6d with SMTP id 5a478bee46e88-2a9415cd90emr11088569eec.17.1764626792802;
        Mon, 01 Dec 2025 14:06:32 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc3:d24b:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b47caasm50506902eec.6.2025.12.01.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 14:06:32 -0800 (PST)
Date: Mon, 1 Dec 2025 22:06:24 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 4/5] netconsole: resume previously
 deactivated target
Message-ID: <2sqyjsod2s6kdukgipgcpjqdoysaw6trpgymxci36lmi3gykvx@tvg4qh3veuiq>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
 <20251128-netcons-retrigger-v8-4-0bccbf4c6385@gmail.com>
 <65vs7a63onl37a7q7vjxo7wgmgkdcixkittcrirdje2e6qmkkj@syujqrygyvcd>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65vs7a63onl37a7q7vjxo7wgmgkdcixkittcrirdje2e6qmkkj@syujqrygyvcd>

On Mon, Dec 01, 2025 at 03:35:04AM -0800, Breno Leitao wrote:
> might hit a similar problem to the one fixed by e5235eb6cfe0  ("net:
> netpoll: initialize work queue before error checks")
> 
> The code path would be:
>   * alloc_param_target()
> 	  * alloc_and_init()
> 		  * kzalloc() fails and return NULL.
> 		  * resume_wq() is still not initialized
>   fail:
> 	* free_param_target()
> 		* cancel_work_sync(&nt->resume_wq); and resume_wq is not
> 		  initialized

Checking this a bit now and I'm not sure if we have the same problem. On 
alloc_param_target() the cleanup is simply kfree(nt).

free_param_target() is only called as part of netconsole module setup/cleanup but
only for targets that were succesfully added to the target list (so are guaranteed
to have resume_wq initialised) before we hit the error.

Let me know if I'm missing something!

-- 
Andre Carvalho

