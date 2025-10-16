Return-Path: <netdev+bounces-229936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55681BE2382
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EC654055E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9222C158F;
	Thu, 16 Oct 2025 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O03AjARc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB93254B3
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604517; cv=none; b=SVvqftoHiiU4e0K2g3EwthM59wa+KoGXsvxNUTTdL2gG/YED6A9qekWaDHnoHxPSCC7C2kTa0nZXH7GIJZqzxhkyOXA/2wLXxbB6JE/5HpbYQuDQTZ90OBVk7wJao1GfQO4GMyaWhLe2opB6NGFgetKzXrocPnXHzcu8ZVJKKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604517; c=relaxed/simple;
	bh=kkrnDxMYNrznAE3Hee5XF8MX8bDoYkPgWg1IrtAOtqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCg7S9+YFP/Qt8IFMNCmK9hMZ87W90fF5qtHEpD7nzBaNufyVZ7q1PMjo1hgvdViWJg0b5G3pqR9oWyF4iklF5FY1PaE7xpjMoxSB6G/ISa0ItY4Pzh6Jfmy+TRgwhswlIzDjz1H8f7oCi/HIbSvXeELAZls1kQBxWTvHixXHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O03AjARc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so317614f8f.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760604513; x=1761209313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVEUrQi9cWOpaDRyBLGip7wyDUSKU6wiRqunzh1l3BU=;
        b=O03AjARc9R27ZMZrKE8djRKA3KxAYGJsRMNyCcIfOfm0XJVskqFMYGOvH2ejD0qYws
         JERlaM6Qo/06NIrHKXPky1XbjwK0LbcJIZjVPLl9pJ/ZmUsajnZ3Lh/yfelonwkORXyC
         8KmD/hOAf+M+KxL+C1SliHXXqCrh5npK9Gl6GtcDDYIaW7+VUZ5D//PTM2jQHh6XxKNQ
         ftzWrbmwf1yf6h7OPgy4nmu4VSrefeSEZisvv/aFYR7L9Z9+UWdrtRSaLpY5vnANO9qG
         uj9/DeVr1uzDySUvtszyuixQt5nwHZTfvRt3Q9qzYrI98cXhP2Do67uUrpD8mKKcOCqr
         MSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604513; x=1761209313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVEUrQi9cWOpaDRyBLGip7wyDUSKU6wiRqunzh1l3BU=;
        b=HnnMBi5QyO5T3TZdB3bPinrfCWY79F9SXKzNIB4XuermsLb1Nl27IigKa9QwtfM4hR
         yX2x1FWAlEzpLgqCbCZcNmbNavPKp9PM64lSySLvLGryp3tQem7KNAzVQWFZ99lNlGL3
         /2ZE5dPloZC+a7kN81NC4Cce+egcsujUHhwCDuCWo3gqLrccxcyubTeA5bWoUz96aeW1
         IBhtKB+yxArRc4k3gA3NVr/ppcS9s6FMTySieqL/hoZr98uKpfWhtThRKQWFOm8cuQ/x
         6jLa0KVgZHiox0NG47j8LKM7bhdxQe/CEmZ3AFR6AKDAExPqnr2A4xzn5PoQ2HYHUF1U
         Re6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsT8+0H5DiIT3zMyZkax/Is9h/IbP7r2CWBxTc8jzJwEYSZLsRuh8NKh0nDPyr7iNJQqwDD68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kHtUeuiGQ9cHBd4s5uMQFkjPiqw6lN/TUMJwOlKPxAAKVg9v
	bJKg8jaztgGASPTvDk5k9QKaauAdt20fS1HCo2b/MY2OM71VHrruXyCI
X-Gm-Gg: ASbGncvyCRZn2po01g60B47kTKi2+WsEzCpRW9JjCh4K/fy82ZBiXeWYYCZz0zXCKE0
	wX6jATvcEUuFHft+RfTwkRVWg2wSYLT4A+4PR48MyB9S4auFH1AG0V313tMGi5WamPSf3bhn7MZ
	Nv5oCMxnkpUmF4u9yJ6eQ9364onaiFlGhIBe/UEwNWBVjbW2YnU38qsQRf997rV/sKCVz3tgLRT
	KvuOt8GnO0JLcJf+pqmC1Jd1rwXv+zshFHXqD7DVvgg9NWEAViwAOWj3d4700j/wKClOhRzmSQ7
	YwtJM+GzeQc5jcJXrK7PWtg98QAldAKlKtGvlctEne17PV1rP3nx8RMcwiOOx0uuy/PRJMZtUvK
	h6jowy1r/BnFh8BCX2GPH101oANoTnRxzH2tPqcNAgxy4QNhUTF4aOHfp71QoSLdCZn0M0VN52h
	zUP5XytpwY3bdUhP4sbjkdVvWBLolRkLCszD4=
X-Google-Smtp-Source: AGHT+IFcjkeuZRpv+IRzVM4XciTTJue0s3dCI3MiZ144Kh9FyQmKyef1x1llDDTMWlEp/vC66d5XcA==
X-Received: by 2002:a05:6000:2010:b0:402:4142:c7a7 with SMTP id ffacd0b85a97d-42666ac6f35mr23068224f8f.16.1760604512220;
        Thu, 16 Oct 2025 01:48:32 -0700 (PDT)
Received: from [10.221.203.215] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42704141cdfsm42311f8f.4.2025.10.16.01.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 01:48:31 -0700 (PDT)
Message-ID: <abe2f4c3-086e-4023-911d-f2ecbdff24cd@gmail.com>
Date: Thu, 16 Oct 2025 11:48:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Return 1 instead of 0 in invalid case in
 mlx5e_mpwrq_umr_entry_size()
To: Nathan Chancellor <nathan@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, patches@lists.linux.dev,
 llvm@lists.linux.dev
References: <20251014-mlx5e-avoid-zero-div-from-mlx5e_mpwrq_umr_entry_size-v1-1-dc186b8819ef@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20251014-mlx5e-avoid-zero-div-from-mlx5e_mpwrq_umr_entry_size-v1-1-dc186b8819ef@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/10/2025 23:46, Nathan Chancellor wrote:
> When building with Clang 20 or newer, there are some objtool warnings
> from unexpected fallthroughs to other functions:
> 
>    vmlinux.o: warning: objtool: mlx5e_mpwrq_mtts_per_wqe() falls through to next function mlx5e_mpwrq_max_num_entries()
>    vmlinux.o: warning: objtool: mlx5e_mpwrq_max_log_rq_size() falls through to next function mlx5e_get_linear_rq_headroom()
> 
> LLVM 20 contains an (admittedly problematic [1]) optimization [2] to
> convert divide by zero into the equivalent of __builtin_unreachable(),
> which invokes undefined behavior and destroys code generation when it is
> encountered in a control flow graph.
> 
> mlx5e_mpwrq_umr_entry_size() returns 0 in the default case of an
> unrecognized mlx5e_mpwrq_umr_mode value. mlx5e_mpwrq_mtts_per_wqe(),
> which is inlined into mlx5e_mpwrq_max_log_rq_size(), uses the result of
> mlx5e_mpwrq_umr_entry_size() in a divide operation without checking for
> zero, so LLVM is able to infer there will be a divide by zero in this
> case and invokes undefined behavior. While there is some proposed work
> to isolate this undefined behavior and avoid the destructive code
> generation that results in these objtool warnings, code should still be
> defensive against divide by zero.
> 
> As the WARN_ONCE() implies that an invalid value should be handled
> gracefully, return 1 instead of 0 in the default case so that the
> results of this division operation is always valid.
> 
> Fixes: 168723c1f8d6 ("net/mlx5e: xsk: Use umr_mode to calculate striding RQ parameters")
> Link: https://lore.kernel.org/CAGG=3QUk8-Ak7YKnRziO4=0z=1C_7+4jF+6ZeDQ9yF+kuTOHOQ@mail.gmail.com/ [1]
> Link: https://github.com/llvm/llvm-project/commit/37932643abab699e8bb1def08b7eb4eae7ff1448 [2]
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2131
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2132
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> index 3692298e10f2..c9bdee9a8b30 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> @@ -100,7 +100,7 @@ u8 mlx5e_mpwrq_umr_entry_size(enum mlx5e_mpwrq_umr_mode mode)
>   		return sizeof(struct mlx5_ksm) * 4;
>   	}
>   	WARN_ONCE(1, "MPWRQ UMR mode %d is not known\n", mode);
> -	return 0;
> +	return 1;
>   }
>   
>   u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,
> 
> ---
> base-commit: 4f86eb0a38bc719ba966f155071a6f0594327f34
> change-id: 20251014-mlx5e-avoid-zero-div-from-mlx5e_mpwrq_umr_entry_size-e6d49c18a43f
> 
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
> 
> 

Thanks for your patch.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>




