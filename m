Return-Path: <netdev+bounces-59820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C381C1F4
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 00:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D541C21EC9
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 23:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2C47947C;
	Thu, 21 Dec 2023 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJrlg1/9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCAC78E8F
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbdb5c2b1beso1604672276.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 15:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703201238; x=1703806038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQBK3S+cxkss8EKQd6OTegL/cKtMcOEpQ7fU5gL2SH4=;
        b=nJrlg1/9MsnYkYSlpCdysaWME5jsY7BOeIB6SURa0FBW520SU7TwqQJNMse0oWSVuN
         0oUGTCxGmN+I351T6b2HvFRJD2QYJfPBtfdd6r+qdMLQXUoimHxvsqKBenyfl+/weepN
         WWd4WHTz63z3kvqzzULHw5lyYmElT7c1LjKP0oBqTz+sHWIkdDibsU/6dZQhnGHwHxcP
         IgA7H+DKZPpHcCostzbnAOY8j1IlA158aWRTXkH4Xf+x962B9nWRCPmBxBxV5Pmc4nVr
         Q6FK0AXYtSsiGWT2wUoYKYHadAt5+R3+d1GSmj923qoG7zXpSPawlUK1rlCO4yqUyxnJ
         e1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703201238; x=1703806038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQBK3S+cxkss8EKQd6OTegL/cKtMcOEpQ7fU5gL2SH4=;
        b=GMu5mK6RPfNDeBe24WcEVTBabDXAZ60ft2cVK7j/sXHOQqzyO0OyxztERbkoiAEOVU
         JPNSKRpLTkrtbxdxpqZcLFEKptVSFDRs1IN1Gpx+uFrFGQ+hH85RPLxDwohxTOEe/MGU
         IRL6O7I0zDpr/4Awt14MRNEk2NrKWMuo2mdqgxbLYZzUkM0pnWT56thBN8qJziIUB171
         crz2aCLb8D7M4149/ezByuk2X7Psi1fPPZVUm8XCjNn3qptsRnF9J1OX2zlqegqgg1m0
         pcCrfGZnQtqY4LcjH+KAIc2k3heGDBOPKSbkobCf3DhoEbik0KQf9qjv0QyI0n4k6JTA
         BUsw==
X-Gm-Message-State: AOJu0YwBnmpszPz3q/JtqOMgObbMOTkFQ0nWbI5xXhhehjjSovxqUaKP
	ZfSE9vez8r/xsP89iPYtpOwbLLw4HGg1uGRfx16M
X-Google-Smtp-Source: AGHT+IHz6Vx9BVCm69eXFOwEY+5r5/zDa9Kri6vSrgY7qRPuVVIYL/un696UdtbG9xPdf62Sv/ozrRMtnVdK/Q==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:844e:0:b0:dbd:2c5a:6c53 with SMTP id
 r14-20020a25844e000000b00dbd2c5a6c53mr188580ybm.6.1703201238254; Thu, 21 Dec
 2023 15:27:18 -0800 (PST)
Date: Thu, 21 Dec 2023 23:27:16 +0000
In-Reply-To: <20231220214505.2303297-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com> <20231220214505.2303297-4-almasrymina@google.com>
Message-ID: <20231221232716.4fspnvngfuqhaycu@google.com>
Subject: Re: [PATCH net-next v3 3/3] net: add netmem_ref to skb_frag_t
From: Shakeel Butt <shakeelb@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 20, 2023 at 01:45:02PM -0800, Mina Almasry wrote:
> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index 65d1f6755f98..3180a54b2c68 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -636,9 +636,15 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
>  		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
>  			msize += skb_shinfo(skb)->frags[i].bv_len;

Don't you need the above to cast to bio_vec to get bv_len? skb_frag_t
does not have bv_len anymore.

>  
> +		/* The cast to struct bio_vec* here assumes the frags are
> +		 * struct page based. WARN if there is no page in this skb.
> +		 */
> +		DEBUG_NET_WARN_ON_ONCE(
> +			!skb_frag_page(&skb_shinfo(skb)->frags[0]));
> +
>  		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
> -			      skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
> -			      msize);
> +			      (const struct bio_vec *)skb_shinfo(skb)->frags,
> +			      skb_shinfo(skb)->nr_frags, msize);
>  		iov_iter_advance(&msg.msg_iter, txm->frag_offset);
>  
>  		do {
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

