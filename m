Return-Path: <netdev+bounces-53224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F44801A9D
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 05:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E10E1F2110C
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F478F6D;
	Sat,  2 Dec 2023 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKN5sxY/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172FD8F55
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 04:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA5EC433C8;
	Sat,  2 Dec 2023 04:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701490844;
	bh=Q5sTfh6XDzNIXrht9g0ro8YBIqK0zlToGlBkJL7c0vI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SKN5sxY/XlhNrm9/y15bJS0Uf+LOxBEAjxjTx3q3svyEUakk7EE2prdGNL4oxigrx
	 J2iZt7feAfJvb3NEmkDC6ELKrWeQI7WW+tCAxeCJNoWw/XzSAoqg2D74KPsF3AMIQc
	 nsMZvMmbRN3eJP4NAEJnAvNPsUTX6+CpS2wC/L7Bxefw4Y1OZs8G1Mcyf7vxPKw/qM
	 YU7RC7keRAPpr6e/GDZhj/abpw0WDTuU8T+Zn2Ga4spBr5/ULZHgqhkIRs8bi2iv9E
	 IWZAdEV3yFEd6bpfVvHm6RBZCIbBgjVSfRV/aRwgajOhl9ayMbeTSrD3St9ZeWZCAW
	 ORiQ5sODQy2PQ==
Date: Fri, 1 Dec 2023 20:20:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Coco Li <lixiaoyan@google.com>, Eric Dumazet <edumazet@google.com>, Neal
 Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi
 <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, David Ahern <dsahern@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu
 <wwchao@google.com>, Wei Wang <weiwan@google.com>, Pradeep Nemavat
 <pnemavat@google.com>
Subject: Re: [PATCH v8 net-next 2/5] cache: enforce cache groups
Message-ID: <20231201202042.1d352825@kernel.org>
In-Reply-To: <20231129072756.3684495-3-lixiaoyan@google.com>
References: <20231129072756.3684495-1-lixiaoyan@google.com>
	<20231129072756.3684495-3-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 07:27:53 +0000 Coco Li wrote:
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 08a3e603db192..0a890fe4d22b1 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1592,6 +1592,11 @@ sub push_parameter($$$$$) {
>  		$parameterdescs{$param} = "anonymous\n";
>  		$anon_struct_union = 1;
>  	}
> +	elsif ($param =~ "__cacheline_group" )
> +	# handle cache group enforcing variables: they do not need be described in header files
> +	{
> +		return; # ignore __cacheline_group_begin and __cacheline_group_end
> +	}
>  
>  	# warn if parameter has no description
>  	# (but ignore ones starting with # as these are not parameters

Hi Jon, would you be okay with this chunk going into net-next?

