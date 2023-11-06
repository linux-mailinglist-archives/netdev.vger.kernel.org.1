Return-Path: <netdev+bounces-46183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5FB7E1F96
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 12:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81482811D7
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 11:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8231805F;
	Mon,  6 Nov 2023 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="MCwGn8+D"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055A1A592
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 11:09:09 +0000 (UTC)
X-Greylist: delayed 728 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Nov 2023 03:09:06 PST
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FF8BE;
	Mon,  6 Nov 2023 03:09:05 -0800 (PST)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3A6AttXT2689685
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 6 Nov 2023 10:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1699268150; bh=my/IgPfusIE4M9FRFP6RHKyylmz6+9fhEowX1+bbe38=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=MCwGn8+DghdfNDHGtgSJCQgkkHvYfBJp9eZMdWQh65g8EiKO4Y2vYaT9hwGBzqm4q
	 C3X8Tm5W1cNEXgHTfRLk7AotWV78E4snZIQEOV9EtQgI8hnFYn7O9uLU5ziY5a5Sp6
	 2/m7OFwxcBFnCHC4Ht6ISMJTVgkWEY1EVtf8FJ3M=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3A6AtnvE1598821
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 6 Nov 2023 11:55:49 +0100
Received: (nullmailer pid 1536086 invoked by uid 1000);
	Mon, 06 Nov 2023 10:55:49 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Oliver Neukum <oneukum@suse.com>
Cc: Ren Mingshuai <renmingshuai@huawei.com>, kuba@kernel.org,
        caowangbao@huawei.com, davem@davemloft.net, khlebnikov@openvz.org,
        liaichun@huawei.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, yanan@huawei.com
Subject: Re: [PATCH] net: usbnet: Fix potential NULL pointer dereference
Organization: m
References: <20231101213832.77bd657b@kernel.org>
	<20231102090630.938759-1-renmingshuai@huawei.com>
	<80af8b7a-c543-4386-bb0c-a356189581a0@suse.com>
Date: Mon, 06 Nov 2023 11:55:49 +0100
In-Reply-To: <80af8b7a-c543-4386-bb0c-a356189581a0@suse.com> (Oliver Neukum's
	message of "Mon, 6 Nov 2023 11:18:39 +0100")
Message-ID: <871qd3up56.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.3 at canardo
X-Virus-Status: Clean

Oliver Neukum <oneukum@suse.com> writes:

> yes it looks like NCM does funky things, but what does that mean?
>
> ndp_to_end_store()
>
>         /* flush pending data before changing flag */
>         netif_tx_lock_bh(dev->net);
>         usbnet_start_xmit(NULL, dev->net);
>         spin_lock_bh(&ctx->mtx);
>         if (enable)
>
> expects some odd semantics from it. The proposed patch simply
> increases the drop counter, which is by itself questionable, as
> we drop nothing.
>
> But it definitely does no IO, so we flush nothing.
> That is, we clearly have bug(s) but the patch only papers over
> them.
> And frankly, the basic question needs to be answered:
> Are you allowed to call ndo_start_xmit() with a NULL skb?
>
> My understanding until now was that you must not.

Yuck.  I see that I'm to blame for that code, so I've tried to figure
out what the idea behind it could possibly have been.

I believe that code is based on the (safe?) assumption that the struct
usbnet driver_info->tx_fixup points to cdc_ncm_tx_fixup().  And
cdc_ncm_tx_fixup does lots of weird stuff, including special handling of
NULL skb. It might return a valid skb for further processing by
usbnet_start_xmit().  If it doesn't, then we jump straight to
"not_drop", like we do when cdc_ncm_tx_fixup decides to eat the passed
skb.

But "funky" is i precise description of all this...  If someone feels
like it, then all that open coded skb queing inside cdc_ncm should be
completely rewritten.



Bj=C3=B8rn

