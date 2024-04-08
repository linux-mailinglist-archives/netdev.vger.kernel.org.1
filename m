Return-Path: <netdev+bounces-85919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAB389CDA3
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29DD1C21814
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C4814882B;
	Mon,  8 Apr 2024 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yw1T7jLk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA651487E0
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612105; cv=none; b=d+VpTfoACvGu7YtO1UV30gjlIMT0VsU0bkvwSW46d8LPNPc1md/2abWnkHGNMPEexh9CWebm+5CCSbwZxRrzxfoJSXL4JotIc/h7upOwoYgo4VSivXayQxW5zY16bcvxk/hoEeA/2JyC2qIN50UQwYKd+rZuL+e70GwW6fomkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612105; c=relaxed/simple;
	bh=/nOvjmJ91jQb+qzpXpfMlSnSf1RVGQ++/tlSfZTbIVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdNpc4gnxCs0RXuSdx4XY3yRwVJtelu7KDTGVsTahm6fzV/GMj2XPIp7kGTdSnJ2siGPxCxItfjPNEOKJ68Sl/XCNs1IciBLp32bafo0EIk2i/V8vZwktmn51RV0/N6sbhqs4sWhAkmh/JYZXAgUp3sos41TlGttFH9ELBcf6vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yw1T7jLk; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c8d2e0e9cfso131685139f.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 14:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712612103; x=1713216903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vt9E9ocYakJzoJGxxxpSMK28+2pLBkDtvg+Rt4wpS/Q=;
        b=Yw1T7jLkSiefvwt/qMGREgvc9VQGG5sr3wNYRcFJoaYLVQM6wj3PebMjPYw9dQavXp
         h8mgm3J31ip2SNeyMH6lp9TcjLSBIBdXrTDR9jHDE4wVda0A0Hl08blxp8y0Xm4u9WhE
         QjQaI5EMoSEBnHanooBk5xgsbb1Imi4c8WbvbYPhK1t0GNDC6aXWjW+aHFwM7+j0r7bX
         ypGy/EvnAUNMrBiVvtLUKS1CR0Yhl9WuKlsgC7ClDF1nEyVra3XnRgdQ8NztxpQr2RPK
         te6vPfZQ7hrkWIFdAV+RTH/+FzgxLkmJwPbWNLRSQEOpspIQTqJAvLmMpjV7gDiHyP+/
         aJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612103; x=1713216903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vt9E9ocYakJzoJGxxxpSMK28+2pLBkDtvg+Rt4wpS/Q=;
        b=LSqQ42vmjcCaFYaBfPSBy7OvsuSj81HqZgGcQ/cDHcJfAyp0DjdnmgX0eWFyDadj0f
         GSgTO3QlGYrPiBfPSrelTM/CteyMGLUkJB7dmlfsqzLcBMQlK/TY+vhxlXdpwMxpj+kY
         lJm250j0jYalcukFzE2xVjHgcai2U5YVCJOTuMOP0ZmfdWJqpgS04m0ajTJi3GMWHt+C
         b+0v41jvbBZwlHUNdGP2tZ4cjc4DsWlBSX1frCc5EPKWiDcmyn02Dg7a8rRh5cGGkZpv
         dJcEzMpVEOhocwKInbGzSuYla5ofgUed+gQPBOlJTV72VHe3T6vKshBtOyt/rsXQA/iO
         iLig==
X-Forwarded-Encrypted: i=1; AJvYcCUAX26/hQEXV9oH2vw2bmaKiTr42JNwRS7QjjsyFpA7XvXIuv78VHwpA6f9y6WABn1/12Ot4uyEbDvGL6zVnrgwYhtKmdFb
X-Gm-Message-State: AOJu0YzgkS/0vx5vzaHkP/9mzrE57Ucc8q2z/SjwkKqGbh13qS8pzrjK
	5aIurwtyqFU6MyWjyarlTY9OYbwwJbTV3lfihw5LPfa8kN/kJFG/0fh/4iKxng==
X-Google-Smtp-Source: AGHT+IEdFSK5QqqKt9qncsKp7ryKn9H+Sg05GW6WePIo293/2ywIdxNeDfZ0TNP8GETEknDCzR6JAA==
X-Received: by 2002:a05:6602:3946:b0:7d5:f931:c48e with SMTP id bt6-20020a056602394600b007d5f931c48emr3089366iob.17.1712612102715;
        Mon, 08 Apr 2024 14:35:02 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id ep7-20020a0566024b8700b007d06f222614sm2590462iob.32.2024.04.08.14.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:35:01 -0700 (PDT)
Date: Mon, 8 Apr 2024 21:34:59 +0000
From: Justin Stitt <justinstitt@google.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: Long Li <longli@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 1/3] net: mana: Add flex array to struct
 mana_cfg_rx_steer_req_v2
Message-ID: <zrqicnpeu52n42yulmrupxmrejd7mhbsu35ycd2bgfjz6gmm2a@dtpv5qdxhmnu>
References: <20240406142337.16241-1-erick.archer@outlook.com>
 <AS8PR02MB7237E2900247571C9CB84C678B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237E2900247571C9CB84C678B022@AS8PR02MB7237.eurprd02.prod.outlook.com>

Hi,

On Sat, Apr 06, 2024 at 04:23:35PM +0200, Erick Archer wrote:
> The "struct mana_cfg_rx_steer_req_v2" uses a dynamically sized set of
> trailing elements. Specifically, it uses a "mana_handle_t" array. So,
> use the preferred way in the kernel declaring a flexible array [1].
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions).
> 
> This is a previous step to refactor the two consumers of this structure.
> 
>  drivers/infiniband/hw/mana/qp.c
>  drivers/net/ethernet/microsoft/mana/mana_en.c
> 
> The ultimate goal is to avoid the open-coded arithmetic in the memory
> allocator functions [2] using the "struct_size" macro.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

I think this could have all been one patch, I found myself jumping
around the three patches here piecing together context.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  include/net/mana/mana.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 4eeedf14711b..561f6719fb4e 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -670,6 +670,7 @@ struct mana_cfg_rx_steer_req_v2 {
>  	u8 hashkey[MANA_HASH_KEY_SIZE];
>  	u8 cqe_coalescing_enable;
>  	u8 reserved2[7];
> +	mana_handle_t indir_tab[] __counted_by(num_indir_entries);
>  }; /* HW DATA */
>  
>  struct mana_cfg_rx_steer_resp {
> -- 
> 2.25.1
> 

Thanks
Justin

