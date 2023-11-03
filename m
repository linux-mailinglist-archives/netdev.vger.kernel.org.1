Return-Path: <netdev+bounces-45878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DCB7E0016
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 10:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB3E281DA4
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 09:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE24E11730;
	Fri,  3 Nov 2023 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19D11702;
	Fri,  3 Nov 2023 09:45:34 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CE11BD;
	Fri,  3 Nov 2023 02:45:31 -0700 (PDT)
Received: from [78.30.35.151] (port=34830 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qyqk1-00EAjx-Tf; Fri, 03 Nov 2023 10:45:27 +0100
Date: Fri, 3 Nov 2023 10:45:25 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nf_tables: fix pointer math issue in
 nft_byteorder_eval()
Message-ID: <ZUTBNcA7ApLu5DMA@calendula>
References: <15fdceb5-2de5-4453-98b3-cfa9d486e8da@moroto.mountain>
 <20231103091801.GA8035@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103091801.GA8035@breakpoint.cc>
X-Spam-Score: -1.9 (-)

On Fri, Nov 03, 2023 at 10:18:01AM +0100, Florian Westphal wrote:
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > The problem is in nft_byteorder_eval() where we are iterating through a
> > loop and writing to dst[0], dst[1], dst[2] and so on...  On each
> > iteration we are writing 8 bytes.  But dst[] is an array of u32 so each
> > element only has space for 4 bytes.  That means that every iteration
> > overwrites part of the previous element.
> > 
> > I spotted this bug while reviewing commit caf3ef7468f7 ("netfilter:
> > nf_tables: prevent OOB access in nft_byteorder_eval") which is a related
> > issue.  I think that the reason we have not detected this bug in testing
> > is that most of time we only write one element.
> 
> LGTM, thanks Dan.  We will route this via nf.git.

Thanks for your patch.

One question, is this update really required?

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3bbd13ab1ecf..b157c5cafd14 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -178,9 +178,9 @@ static inline __be32 nft_reg_load_be32(const u32 *sreg)
        return *(__force __be32 *)sreg;
 }

-static inline void nft_reg_store64(u32 *dreg, u64 val)
+static inline void nft_reg_store64(u64 *dreg, u64 val)
 {
-       put_unaligned(val, (u64 *)dreg);
+       put_unaligned(val, dreg);
 }

 static inline u64 nft_reg_load64(const u32 *sreg)

because one of the goals of nft_reg_store64() is to avoid that caller
casts the register to 64-bits.

