Return-Path: <netdev+bounces-39644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0CC7C03F1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02AF1C20B85
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7212FE0C;
	Tue, 10 Oct 2023 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVQKplQS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F43228F0
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E87FC433C8;
	Tue, 10 Oct 2023 18:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696964285;
	bh=RCraxHVDCNw1JrxtxjUhuxkhghH7N5gwZ3Fzb/Dp3zA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XVQKplQSjlKkBgp8PloaO3US0gSycvfYaoPOTWgfIyB8FGSjNASv2oIMO8s64cUsh
	 q8grkEQ0zAuDiAJQ4VJROAZJm7p+pZ8iJLKy48L91+h96F3sKyoGYYrElvFNM80pMJ
	 4QqwiMq2eM2BMsReolloFPJ0ODWMQdorRkWLPUC12RFjRBZf+tvs1tYhEuohk67gqi
	 2jbEbnQ4h2qzX4rFEDyDSCyeps85fem+63S4iKR4Qu95DZ4cB7rhSyQ1SKRLURbEL9
	 ni7NXSXX9cZim7dZKrvzYO52qLfYpSmiCxTCnRSsTkA9j3agQUmnSLHpu0Rjj9lWSS
	 /R5zYv6vJjRJA==
Date: Tue, 10 Oct 2023 11:58:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, johannes@sipsolutions.net
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Message-ID: <20231010115804.761486f1@kernel.org>
In-Reply-To: <20231010110828.200709-3-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
	<20231010110828.200709-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 13:08:21 +0200 Jiri Pirko wrote:
> Introduce support for forgotten attribute type bitfield32.

s/forgotten//, no family need it so far

> Note that since the generated code works with struct nla_bitfiel32,
> the generator adds netlink.h to the list of includes for userspace
> headers. Regenerate the headers.

If all we need it for is bitfield32 it should be added dynamically.
bitfiled32 is an odd concept.

> diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
> index f9366aaddd21..8192b87b3046 100644
> --- a/Documentation/netlink/genetlink-c.yaml
> +++ b/Documentation/netlink/genetlink-c.yaml
> @@ -144,7 +144,7 @@ properties:
>                name:
>                  type: string
>                type: &attr-type
> -                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
> +                enum: [ unused, pad, flag, binary, bitfield32, u8, u16, u32, u64, s32, s64,
>                          string, nest, array-nest, nest-type-value ]

Just for genetlink-legacy, please.
Also I think you need to update Documentation.

> +class TypeBitfield32(Type):
> +    def arg_member(self, ri):
> +        return [f"const struct nla_bitfield32 *{self.c_name}"]
> +
> +    def struct_member(self, ri):
> +        ri.cw.p(f"struct nla_bitfield32 {self.c_name};")

I think that you can re-implement _complex_member_type() instead
of these two?


