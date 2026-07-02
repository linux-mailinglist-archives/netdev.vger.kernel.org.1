Return-Path: <netdev+bounces-304274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DAtpMLXPRmoieAsAu9opvQ
	(envelope-from <netdev+bounces-304274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 22:53:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E686FCD6A
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 22:53:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ej8i8WDa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304274-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304274-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE77300DF5F
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F42370AF0;
	Thu,  2 Jul 2026 20:53:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569E1A6835
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 20:53:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783025586; cv=none; b=S5YXFCJsfXDx3wXilXOfhAWvdgERr5SE3V+4hhGZNPFiEC7EPayPRD36heyy3etbw3hf2rxxI4Y0X2mHg4iwYurzD2uQC1HXKnbGeBSD0D/BvKFW5oSdwoT0UNTNzE4s7PgcxvMLRspE8p7eFR3/gP+zoINpvXMo/d1x1oJnrAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783025586; c=relaxed/simple;
	bh=90X6nwoMcrMyfEKMt542bHgq7hQLvNHeiApFXnkbcls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQv4+pUKDgTDNAOcmbwvzgIcGQh0jSArbV88Drf+6zTlU5tsdpLpREWEeJgvr2N/RBeHi5pbuaSPvQXR9QPlrKhWnr4lJP8mIyGLbk/jJW4sIQnviQUNukcBiHscaIprR0MnUEDVHkXZw93xPLRUb23nAJAgLvEP0g6O398LiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej8i8WDa; arc=none smtp.client-ip=209.85.161.45
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6a0c7c4f55fso1575617eaf.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783025584; x=1783630384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUUT9U/zE34DOVJLI19IRKYtBuKLwinorFscWJ3YAUg=;
        b=Ej8i8WDaiCF8QhuUucg46HRkTgyDFK4XLMMhz07Cm/BDxjqAARpU6kiy4uYGFbePiy
         13fccyYoGUCd8x8B9Wqt/mGFU2Uct7Ziqb3LYsMULCp43t7x9DBk6l8ywKglfw+X5iAh
         ExNFilcHLxiL08I/TXkUyOywfdcsFTKNtzznRLZL7CszwsLf+4mAvZ8yo+hIEEWgQ+n4
         Mj6FbJLqmvsGSR9GDc6klI92qQ45FlTuqUCt3qASMNr6q/W0R78sjlwPa33JYX+LGeT1
         4SEQRqO8RC9oxDFqol6XErRaaNvPaiys0p1oxmpG3C/LlAN1jFrevh38PtuXnK9+S+ay
         a0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783025584; x=1783630384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUUT9U/zE34DOVJLI19IRKYtBuKLwinorFscWJ3YAUg=;
        b=erhKoS2/wQ3DA5mnwCwQwLuMSNgFzCPdIM8f4YeLVULWf/BofyXcDty+DBZ2XmslFV
         X62AnQBmNoO9lHuZHI3TPmhJoJUL3demryUT49ahh6XzaSQaFmOHvMGbGkMhtwuHuz3S
         VIzhqRcXkJ8vS47BUaRFYO21ykGb+CJrHbGHn2VCc8zlzOu7tENdI778v4XeFiXh6wZK
         wQVqsGn6W4fXnueNsrHgR3C2/sj55O1OcALuRHU4oNJw1Sj4EsYCJRMUsiV/y2OiTUSb
         8dhvT9Mfh1nwfuI0no5o9hWFy5fMzTMy9o/zS+YSL56f57SCWLwxEJhR0+affMvUwvOe
         sqWA==
X-Forwarded-Encrypted: i=1; AFNElJ8cvCEn+feCBE2pn3xZz+wxaoW0P/kjZV2hQAAOCQk6Z/R7PmmXDyqC2vT1D4L2IEbadNUknB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUYxmTcHRUwX++aCxersHQ+sqrusN8S8PWdaijOoQ045mtdKw
	SFuoiHZgP6cnBQ0dwdUOpCDfmD1oPd8MEurjws67u1oYcMCwRficFO8K
X-Gm-Gg: AfdE7ckkHPW5lLW9Ue4Z7LkrCP675QWP7zzjiVpUMgib99eXwPfhQmuH+FIhrRE31AX
	yMLIhdVg2xaOWsnVPmlWpcUkuyCh4cog1rv1osoti2vwvEtrFQ/Z4ig5j6wTNXxY2H8M4TTRkTG
	X2VyTO8F/g9QHtTmGLjVzr+37y5eVKhMZpqKtud0uhEK1x8B+6AsI458NPDZB7VRH/dU3w6qrBf
	LXTcn96q/0uJL/aH+OLAQH1n+c2SKD24Wxe3LkY4WGZP+cH2f1MjEZw3Od1w+iv2w111z9W96n9
	/8UyzfQHRTWio2u7uG0KoYDGiqHG746jPrKaUIBNyuhdbTVACgnWfNFi+Fyh0WRS8ENuQ0ZuR/6
	H0ypLOX+d0EnADnNtVXGXy7p+e8Uf3DJ+R+4PMkiNzuDNcLehVxYtEHOVHsIrAR83OJttid7wWo
	e6zLgijqltU8BdCnm6hNWm/5nzutkAdC7N
X-Received: by 2002:a05:6820:1512:b0:6a1:50eb:2110 with SMTP id 006d021491bc7-6a309b831e1mr4672517eaf.69.1783025584368;
        Thu, 02 Jul 2026 13:53:04 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb54534789sm3393061a34.26.2026.07.02.13.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 13:53:03 -0700 (PDT)
Date: Thu, 2 Jul 2026 13:53:00 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: kraxel@redhat.com, vivek.kasireddy@intel.com, kuba@kernel.org,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] selftests: Open /dev/udmabuf O_RDONLY
Message-ID: <akbPrI67h5btdI44@devvm29614.prn0.facebook.com>
References: <20260701192210.2997769-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701192210.2997769-1-tjmercier@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-304274-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tjmercier@google.com,m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:kuba@kernel.org,m:shuah@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19E686FCD6A

On Wed, Jul 01, 2026 at 12:22:08PM -0700, T.J. Mercier wrote:
> Write permissions on the /dev/udmabuf device file are not required to
> issue ioctls and allocate udmabufs. Applications should be opening this
> file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]
> 
> Users are pointing to these selftests as examples of how use udmabuf,
> and encountering permission errors on systems where write permissions
> are not available on /dev/udmabuf. Apply the principle of least
> privilege to selftests which use udmabuf by removing the write access
> mode from drivers/dma-buf/udmabuf.c and drivers/net/hw/ncdevmem.c.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=v7.1#n49
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  tools/testing/selftests/drivers/dma-buf/udmabuf.c | 2 +-
>  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> index d78aec662586..ced0b95c876c 100644
> --- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> @@ -140,7 +140,7 @@ int main(int argc, char *argv[])
>  	ksft_print_header();
>  	ksft_set_plan(7);
>  
> -	devfd = open("/dev/udmabuf", O_RDWR);
> +	devfd = open("/dev/udmabuf", O_RDONLY);
>  	if (devfd < 0) {
>  		ksft_print_msg(
>  			"%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> index e098d6534c3c..8114a29692fd 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -149,7 +149,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
>  
>  	ctx->size = size;
>  
> -	ctx->devfd = open("/dev/udmabuf", O_RDWR);
> +	ctx->devfd = open("/dev/udmabuf", O_RDONLY);
>  	if (ctx->devfd < 0) {
>  		pr_err("[skip,no-udmabuf: Unable to access DMA buffer device file]");
>  		goto err_free_ctx;
> 
> base-commit: fbb7ad31ab376c5101b2ac7205fad0344fd2de60
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

