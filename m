Return-Path: <netdev+bounces-53957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FCE80565E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667A0B20F23
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13F65E0A0;
	Tue,  5 Dec 2023 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="piEwCZuX"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 1792 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 05:48:06 PST
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05412A8;
	Tue,  5 Dec 2023 05:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=MlRWkhJV0qSH5U01QGui4oeTrYqJubGpGLDBsWklraw=; b=piEwCZuXLbbZffbD9RGKdATv2V
	lX7W3X2jTvFhBOMIx1Lzdjkem4jhtNxBBF9vhEi0jsinJi/xaTTSiiWZxCNl4SN99ZNY2E/Vd/dv2
	XmMq34fW6blMK64yeTu1vzV5NqxUI5phRButXMNKebRmcLjeLjgC1edbxzdSxuvBI3BuLdXuTK6PZ
	q7BLzVO7nKzn9aTw8RHoxw3mbFUGJ3i61lZUKK+4rkr+23lQV4J9bc9vG8dtYHAt76BDcCrZ+5Gep
	v6KXGWhHrb/LP2M9VThSPFYFvXNHy1zzihNVOwIybbi9HBZKbFXFFciiQQm3U+Z2gigQHgSJaqU9O
	Q4KZioqrhI9Lukv9a4nxCHZtrXqXhaJGL+atif60c0igPeAAErevIzaa8e29K1iVljWAMh+sb+gYq
	LtsCDw8b9YFyldvL0yW8mGTSY3lbXlVIXP85jzXZlN2dOguEjnknzBm908I6tNIQ0GayTn5PCKYVg
	E8giISdkklKHaU/xPpeb4tdzBND1+O11KoO9oxUfFhjNGxEAxIeBQmcz73LPgAV7QUSBI1DAVOe5L
	uE+k6iLYnGqHAKeM/MaPVvk+dVIv3m9CHIhYOCZEWHCalsxDB6hkRZ1DIgK3HJK3WIwZcVXJ60bPh
	2Zv/K88X8HOgsRQNivAvtkcv2Ru+Bez6Oq1t1WNDc=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
 Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, Latchesar Ionkov <lucho@ionkov.net>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 v9fs@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Date: Tue, 05 Dec 2023 13:29:49 +0100
Message-ID: <1741521.OAD31uVnNo@silver>
In-Reply-To: <20231205091952.24754-1-pchelkin@ispras.ru>
References: <20231205091952.24754-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, December 5, 2023 10:19:50 AM CET Fedor Pchelkin wrote:
> If an error occurs while processing an array of strings in p9pdu_vreadf
> then uninitialized members of *wnames array are freed.
> 
> Fix this by iterating over only lower indices of the array. Also handle
> possible uninit *wnames usage if first p9pdu_readf() call inside 'T' case
> fails.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> v2: I've missed that *wnames can also be left uninitialized. Please
> ignore the patch v1. As an answer to Dominique's comment: my
> organization marks this statement in all commits.
> 
>  net/9p/protocol.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/net/9p/protocol.c b/net/9p/protocol.c
> index 4e3a2a1ffcb3..043b621f8b84 100644
> --- a/net/9p/protocol.c
> +++ b/net/9p/protocol.c
> @@ -393,6 +393,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  		case 'T':{
>  				uint16_t *nwname = va_arg(ap, uint16_t *);
>  				char ***wnames = va_arg(ap, char ***);
> +				int i;
> +				*wnames = NULL;

Consider also initializing `int i = 0;` here. Because ...

>  
>  				errcode = p9pdu_readf(pdu, proto_version,
>  								"w", nwname);
> @@ -406,8 +408,6 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  				}
>  
>  				if (!errcode) {
> -					int i;
> -
>  					for (i = 0; i < *nwname; i++) {

... this block that initializes `i` is conditional. I mean it does work right
now as-is, because ...

>  						errcode =
>  						    p9pdu_readf(pdu,
> @@ -421,13 +421,11 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
>  
>  				if (errcode) {
>  					if (*wnames) {
> -						int i;
> -
> -						for (i = 0; i < *nwname; i++)
> +						while (--i >= 0)
>  							kfree((*wnames)[i]);
> +						kfree(*wnames);
> +						*wnames = NULL;
>  					}

... this is wrapped into `if (*wnames) {` and you initialized *wnames with
NULL, but it just feels like a potential future trap somehow.

Anyway, at least it looks like correct behaviour (ATM), so:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> -					kfree(*wnames);
> -					*wnames = NULL;
>  				}
>  			}
>  			break;
> 



