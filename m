Return-Path: <netdev+bounces-243698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED408CA616B
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 05:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1992430AE0AE
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 04:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328622D8DD4;
	Fri,  5 Dec 2025 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOhgHku+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3D19C566
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 04:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764908213; cv=none; b=geLcjFTNQlie7X22jl2CVNyMJr7w1wD1yn6ABbUSfzuvcr/QucJzmlXkfaggEmyZN+WAdB0tTsJd/C8AGHgWTrug/txFwX7hmTgGI1Z8blv2W0ebx01MwRcN3o4wzQ7oPE3+9RofEzrXmLjWKWkOwuRJt+1O7SiJTVFdBw5RauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764908213; c=relaxed/simple;
	bh=dxw02qcsWeoZgD1xFo+JtEl1GOxPVpGiPAPAeQW4TsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldQwsW9vfE1AFJ4003ypx6d6Uank7HVbiXNQLqvOMtIymEzv10a5B7oOhgvMHf32X0wvIHL1s9Rg3+JGeDF201uot0W4saBHVU7r75qXDNAjbVzMSAtLPEQPItv7+il7zkgzoGH7sPXGKX46cJ5XanJefJVJVTQTOR3OlGyw8Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOhgHku+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so1696731a91.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 20:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764908210; x=1765513010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBW4yg5h+y5NyBTEUuEzw2xT+B6nf8gmsqhkGkk4wrw=;
        b=NOhgHku+RZC//0KMej6BeCTj4zPow1M1PGbMGhdoJ4WpbWoKBKLqgiXzi6Edu5WBxi
         tUWG+34GrGfqpsonlKCIipcOvz+IS5yV9eXmhCLMn35ovooy9wNp6RO3wQUAHVBspXQL
         s/oITyhU/r4yDkJCOUnmDWuIMwYsRfGjlU7T5bss1R3m5JHke+S1Kw1HX+hOd07qczRW
         6xm8CgLhUhLdmKxhPaAtaqOpZeoCTVBhoaR9+MoxskMyeyKfQppQ4Vei6onoO3hHBiqO
         gWj3sjKH+ro+yn99Odgs8ppsudmHT2ueWy2RrK3qXagKpRNFgkVUkK2xRF4Vq2GmZhkN
         klXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764908210; x=1765513010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gBW4yg5h+y5NyBTEUuEzw2xT+B6nf8gmsqhkGkk4wrw=;
        b=arAUFvHS6cbA1zr+MnWUVauUnynGQBtf8Bu5cN/SaQj63X0rlk3iuIngU66qe7lW4X
         OoAFndebmSI94QbqDYeUCqfL19gd8Wic5XYfMCspliw9ulVZe/MwHG1Dk3q8rd2/hOOf
         N5KRK/0xL9rPqXONKy3ID0XkpvHqT1SwwpIbTX5mG8ON0zGOP4EprVIDAmE2GQjA4Hb8
         OQhSCMDcYjD1NAFoPsN54rYDpEDzMpmgEkWHLCk13DRp3v3QRJgab6TLxZvhCfJR7+dD
         1nhSEeOP2rQCHEWDLgpvx75tKVdIN9hpoI88BhLLodrojW14hS9/Cxi7zekksh96wsU7
         AJDA==
X-Forwarded-Encrypted: i=1; AJvYcCW/ancWRUaIzlteJJrQk9MtlBPaCgjW4EM1Z6xLltNtDvSsE55IoJAQaAZAeDr2j0PmYYiXco8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhJjCCmvQrBzfvf3usD6Yduw9YjNr6QTA7Mr7921aorthICqF
	HfZFweIunQF2Af6piE9BjIBfi2jvFDlmytUx+V8mizOWuaOpOpgATepn
X-Gm-Gg: ASbGncupSf7Rlg9CcazCJqfPV4vOZeBkyjslAG4Tc30WQz1W72r3LEnDNXSnB+EmDhz
	8FpniPb63PZErJprM6DAY+Fw/rw58MI840OQHR/+8VgfyfxYXCKc2fb2Rar9oVjxC4sILUqzzZ3
	QHE40/FzadbXoLHhVGYJJvFsKRM6TJR4I3dmyTR01bMCUiTsnTFCnSUkghPsMRROqrFC9wnv/BO
	PR8EtpZwjpZtkn3vI5qU+xP4bcfvCVI4SqAiOvrkBP5y+zYg1fRUIXiKo/2aZ3ToBSnOI/N3OGw
	yymX8I7akBDPzGiAkJNpjBkmPO10cQFiMhD79wgkWXryiFX21uWmmOiyu0u3R8KsdrXvIoUHYN+
	a4g/q3uTlr4K4CewljZ//u44JWrkmNzD8Rj+LLGcpE8IDKsWYQErdugkTDplmTZgqCUcnACcuFb
	kfO0YUm1t6wvRFwWnmBKE+T3pwolAyrQ+SGQ==
X-Google-Smtp-Source: AGHT+IFPM4tJWEJo1KtUYT7trSAyUM/sJov0oTxTpBLUgPdWMcAI1975L261q4edEQkelnqT7yTjbQ==
X-Received: by 2002:a17:90b:48c4:b0:341:8ac7:39b7 with SMTP id 98e67ed59e1d1-349127fd714mr7851540a91.25.1764908209939;
        Thu, 04 Dec 2025 20:16:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-349128be266sm3818595a91.0.2025.12.04.20.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 20:16:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 20:16:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, bpf@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: Re: [PATCH bpf-next v5 2/3] net/smc: bpf: Introduce generic hook for
 handshake flow
Message-ID: <3a0d2f44-6f1c-4f79-b8cb-f57387933a5a@roeck-us.net>
References: <20251107035632.115950-1-alibuda@linux.alibaba.com>
 <20251107035632.115950-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107035632.115950-3-alibuda@linux.alibaba.com>

On Fri, Nov 07, 2025 at 11:56:31AM +0800, D. Wythe wrote:
> The introduction of IPPROTO_SMC enables eBPF programs to determine
> whether to use SMC based on the context of socket creation, such as
> network namespaces, PID and comm name, etc.
> 
> As a subsequent enhancement, to introduce a new generic hook that
> allows decisions on whether to use SMC or not at runtime, including
> but not limited to local/remote IP address or ports.
> 
> User can write their own implememtion via bpf_struct_ops now to choose
> whether to use SMC or not before TCP 3rd handshake to be comleted.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> ---
...
> +static struct bpf_struct_ops bpf_smc_hs_ctrl_ops = {
> +	.name		= "smc_hs_ctrl",
> +	.init		= smc_bpf_hs_ctrl_init,
> +	.reg		= smc_bpf_hs_ctrl_reg,
> +	.unreg		= smc_bpf_hs_ctrl_unreg,
> +	.cfi_stubs	= &__smc_bpf_hs_ctrl,
> +	.verifier_ops	= &smc_bpf_verifier_ops,
> +	.init_member	= smc_bpf_hs_ctrl_init_member,
> +	.owner		= THIS_MODULE,
> +};
> +
> +int bpf_smc_hs_ctrl_init(void)
> +{
> +	return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);
> +}

Building csky:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/bpf_verifier.h:7,
                 from net/smc/smc_hs_bpf.c:13:
net/smc/smc_hs_bpf.c: In function 'bpf_smc_hs_ctrl_init':
include/linux/bpf.h:2068:50: error: statement with no effect [-Werror=unused-value]
 2068 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
      |                                                  ^~~~~~~~~~~~~~~~
net/smc/smc_hs_bpf.c:139:16: note: in expansion of macro 'register_bpf_struct_ops'
  139 |         return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);

Should this have been

	return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl_ops);
									^^^^
?

Guenter

