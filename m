Return-Path: <netdev+bounces-55496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5615D80B0C9
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C47281961
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A5637;
	Sat,  9 Dec 2023 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5bJKfk5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD33862B
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 00:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84209C433C7;
	Sat,  9 Dec 2023 00:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702080476;
	bh=IH5Q/4RTe/biVprR3pkKaMTmuuvteHRQ4er0Evx011Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W5bJKfk5l2D4tG+I1UPPQr7CTQZ8CPT/Wv6GzbGLqDWyDxFpkJEVjhakme9dNyXSf
	 1NML2siDMw61KJdfV/3tma0Ed2syJBqMYJkeBYBBDvYQ6VHXQsvJR/mzWrX/uW19sY
	 dRQ9rW48uAqzVSytXf13uKaiHpDFROG6pkn5JIjzgZk9YNB1yotBkXQZyBr3KDKnAB
	 CjKDoMvNivQ7DgSZ7SU+J8+f/4W/Q54wLVRURGqL4klkOJ/V80rV+VKp8QX6rmP2VS
	 GgYc7Pfm1i+/Y2sszwVD5JN4IZB8Cp5yp+pJfdJL8rHeVbY1jqrqrmtTy4z0Y7YsZQ
	 g9WkHm8x8G/1Q==
Date: Fri, 8 Dec 2023 16:07:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: =?UTF-8?B?xYF1a2Fzeg==?= Stelmach <l.stelmach@samsung.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: asix: fix fortify warning
Message-ID: <20231208160755.4271a283@kernel.org>
In-Reply-To: <20231206133822.620802-1-dmantipov@yandex.ru>
References: <20231206133822.620802-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 16:38:04 +0300 Dmitry Antipov wrote:
> When compiling with gcc version 14.0.0 20231129 (experimental) and
> CONFIG_FORTIFY_SOURCE=y, I've noticed the following warning:
> 
> ...
> In function 'fortify_memcpy_chk',
>     inlined from 'ax88796c_tx_fixup' at drivers/net/ethernet/asix/ax88796c_main.c:287:2:
> ./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   588 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ...
> 
> This call to 'memcpy()' is interpreted as an attempt to copy TX_OVERHEAD
> (which is 8) bytes from 4-byte 'sop' field of 'struct tx_pkt_info' and
> thus overread warning is issued. Since we actually wants to copy both
> 'sop' and 'seg' fields at once, use the convenient 'struct_group()' here.

Can we change the definition of TX_OVERHEAD to be
sizeof_field(... tx_overhead), to make it clear that
the two are indeed identical?

