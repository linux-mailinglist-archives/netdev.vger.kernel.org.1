Return-Path: <netdev+bounces-41799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104F17CBE99
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FD11C20C48
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71583F4BC;
	Tue, 17 Oct 2023 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYFrKPux"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C53D99D;
	Tue, 17 Oct 2023 09:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7A1C433C8;
	Tue, 17 Oct 2023 09:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697533809;
	bh=XzWNIY/hrbTa3IpvjUeTL3enp5iOsmUIH+SzZ2/j/S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYFrKPuxxNnAO4bIJuWAo3vtIdUGAyUiM0Ji3FbzfmtycscCLf6EbhI0QBq1XyWZp
	 v9HCOlY08mIS+7BDSJEyqQ9hbVrLXQ+qUeYPciXTcPP2mswDuUoDVITdjw8G3MYpm3
	 0yy0JpWRsLtBixnefQMKg8SBdh6hldh8rt4ltCZsuipjz11rIaPwSpRLR1s8KCcH7k
	 1oC4SuX7bcQk5aS6RpG41SLA0wEqXTzSFX2TndKUdUGP97V82uFSw+wpNHJV31PDeq
	 vvMssJPuN3bgBsQsFyDvrPPlHo6QmDFEOuLMGFSH1jCL9zh28CM9ChnDRQIK8ffU4Q
	 vioQ+2/eFWkcw==
Date: Tue, 17 Oct 2023 11:10:02 +0200
From: Simon Horman <horms@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, dev@openvswitch.org,
	kernel-janitors@vger.kernel.org, Tom Rix <trix@redhat.com>,
	llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Eric Dumazet <edumazet@google.com>, linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [ovs-dev] [PATCH v2 2/2] net: openvswitch: Annotate struct
 mask_array with __counted_by
Message-ID: <20231017091002.GR1751252@kernel.org>
References: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>
 <ca5c8049f58bb933f231afd0816e30a5aaa0eddd.1697264974.git.christophe.jaillet@wanadoo.fr>
 <202310141928.23985F1CA@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310141928.23985F1CA@keescook>

On Sat, Oct 14, 2023 at 07:29:57PM -0700, Kees Cook wrote:
> On Sat, Oct 14, 2023 at 08:34:53AM +0200, Christophe JAILLET wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > v2: Fix the subject  [Ilya Maximets]
> >     fix the field name used with __counted_by  [Ilya Maximets]
> > 
> > v1: https://lore.kernel.org/all/f66ddcf1ef9328f10292ea75a17b584359b6cde3.1696156198.git.christophe.jaillet@wanadoo.fr/
> > 
> > 
> > This patch is part of a work done in parallel of what is currently worked
> > on by Kees Cook.
> > 
> > My patches are only related to corner cases that do NOT match the
> > semantic of his Coccinelle script[1].
> > 
> > In this case, in tbl_mask_array_alloc(), several things are allocated with
> > a single allocation. Then, some pointer arithmetic computes the address of
> > the memory after the flex-array.
> > 
> > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> > ---
> >  net/openvswitch/flow_table.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
> > index 9e659db78c05..f524dc3e4862 100644
> > --- a/net/openvswitch/flow_table.h
> > +++ b/net/openvswitch/flow_table.h
> > @@ -48,7 +48,7 @@ struct mask_array {
> >  	int count, max;
> >  	struct mask_array_stats __percpu *masks_usage_stats;
> >  	u64 *masks_usage_zero_cntr;
> > -	struct sw_flow_mask __rcu *masks[];
> > +	struct sw_flow_mask __rcu *masks[] __counted_by(max);
> >  };
> 
> Yup, this looks correct to me. Thanks!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Likewise, I agree this is correct.

Reviewed-by: Simon Horman <horms@kernel.org>

