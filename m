Return-Path: <netdev+bounces-192013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2302EABE3A8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E89F7A0760
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219F25C707;
	Tue, 20 May 2025 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="kQ8Bt8Nc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE125B69D
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769170; cv=none; b=OrUrPExgQ07Fm3lDMQpFC2Y4jg705ttC6flQHmyHvgRRJzc0nCRUc3mGOgALAdRdpBvUqIz29USd81GlHHwkNkCmgzYIji3dKynymlKrzKcdQzdcumaZrwkOVNk9BFrRMugr2Z9tp8lFQy5FnQ6D7Wh8nD8A4G7RCJ7yNM3NZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769170; c=relaxed/simple;
	bh=lPikNURIwj4C2vxqkfVYouwl+I21nX35i7XXW2NzsWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9tgsEXlHxxYXpoZUL65Qxtb62tDR/EjZePvkiVdrzSTmk0XWsjopGB7yRkrTmMdYnZf2X17uT7Mcik+eA2u7ielMz4cJYDfV0ZiPhq8qWJN0xLLDxRz82VYTiX5jiJpbISm4aEIvqRwyuA6CyEOMy8jRgHAIhLLxh9WM04iq0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=kQ8Bt8Nc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acacb8743a7so996056366b.1
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747769166; x=1748373966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FdjGFd+Ul79wVXtZk1gl1aEEUiTdYeZqsE+QD37BLA=;
        b=kQ8Bt8Nc4hAg/sRUE08/PDATv0/6IA7IkOyam+WpOoDtz7uJFbihZHycNctzuZLuba
         67q2zQAyhItsw7Qst5u/D2gefurMpMSN4ExLl0TgNd9DpF9oW/f76fTZkDtF5wz+z0Hu
         vjqsmRrZgHBvuA+c9P+vKz8jsQfk2mJXc+eSG9kmGgEXUgf2EsJlVqklQoTiHeSHJ5wI
         NGAtH02DLV18sdvpDWTBSfsD03fAXjLKPV5qhNSc/uLfYZcoppsEkaNXS2IrxuYBgaef
         D1X1k3CFg8s2TxXd/wgou6fQbFAjRFeMJqi6bklTr+JDDAYiF3bOZ1ASBRffuCK9eZYd
         szkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747769166; x=1748373966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FdjGFd+Ul79wVXtZk1gl1aEEUiTdYeZqsE+QD37BLA=;
        b=eWeScZXhdcpkKnTNYbjE4KX32lZTKm/lU7SLUU/NPDJ/yd8XGlvEc8YH3PF28ZETNW
         mUoCnZ7MD0ERcbVyrRqR4gcoVnvVTf/XOyFasqlCP0yeyEZ8Ss6nK2A2sjdrPFXp1FAo
         khwpQOzK0AIdK6Sd+yh9IdW5GuJ47kzgYCvGif/0VONaVeM1NAApnR839UCIPA1Q2L1F
         d2Yn6nLhrWD8IMeGHUEhfI2EZOF6LEDMftXy+zo6yHn4dz0PbgdiAeglkmoGu99kaGUi
         dwZvUbdhttiXniOd9E+ky15wcz8Z21KEFsCMq2HqWsGf/umQoIUS5Pkt5DfX0qIKS6lW
         kEPA==
X-Gm-Message-State: AOJu0YzFrjI8eX4Qw3/3BAhz8fYAy7gLPTzCunp/USkazg0BSZC0AXXX
	pYBNvK9EVhoKe0ci7IatnZlUTqnaEs0JASHO3e2Lb9dHqVb2TOCfKKFV+7J3f+WssHKrcE2142t
	q+6/N
X-Gm-Gg: ASbGncvWvVv7hyRdtq2VW8MAJXqsfsKooESIbUu7drqH3uub5vOvNETVrrEpB5ZpMCB
	ToSj/rtJyuXH2rHzCjo8h6LkAuLojtKslcOVLMt+yXZQ9MT2YwKQpiT8ST+T/n7ZSf7XNbMfy0f
	DLKmqF1+RAjsrt63UjsOe24u65OPtAkfJWPKSSpilHAlK70aBT+cbvfI0J6NmspSLg/12OzW72f
	50GbgOhom6AsfIMa+0hHF5THtGr7y7M3wKpAjyR70CCy1yZbtk3VFFjKXrpT/jcxSXb51CWitAJ
	9NWjLfJBTzIt5KA9msh4rsDDGnO35unQHnvpnV152s92TVs9OerwxA71TEsyAzy+DxeoltexkUT
	7RPQsoWV2drDWLpOt6VGnGWyvH5WmUyLzqhJldW8=
X-Google-Smtp-Source: AGHT+IEpTsP6Oc/Cqba/STKtrBvSU9obXw4TBVhUmqIERyKYVCSDIyStfyQ4UEJO1f3ichJUfoOyBQ==
X-Received: by 2002:a17:907:1c22:b0:ac7:81b0:62c9 with SMTP id a640c23a62f3a-ad52fa5a6bamr1468520966b.20.1747769166423;
        Tue, 20 May 2025 12:26:06 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04ef59sm771972466b.36.2025.05.20.12.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:26:06 -0700 (PDT)
Date: Tue, 20 May 2025 12:26:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, dsahern@gmail.com
Subject: Re: [PATCH iproute2] ip: support setting multiple features
Message-ID: <20250520122600.30f3bd00@hermes.local>
In-Reply-To: <feace2e1ac81af7dfbce514727229a5b2767d5a1.1746565372.git.sdf@fomichev.me>
References: <feace2e1ac81af7dfbce514727229a5b2767d5a1.1746565372.git.sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 May 2025 14:03:40 -0700
Stanislav Fomichev <sdf@fomichev.me> wrote:

> Commit a043bea75002 ("ip route: add support for TCP usec TS") added
> support for tcp_usec_ts but the existing code was not adjusted
> to handle multiple features in the same invocation:
> 
> $ ip route add .. dev .. features tcp_usec_ts ecn
> Error: either "to" is duplicate, or "ecn" is garbage.
> 
> The code exits the while loop as soon as it encounters any feature,
> make it more flexible. Tested with the following:
> 
> $ ip route add .. dev .. features tcp_usec_ts ecn
> $ ip route add .. dev .. features tcp_usec_ts ecn quickack 1
> 
> Fixes: a043bea75002 ("ip route: add support for TCP usec TS")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  ip/iproute.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/ip/iproute.c b/ip/iproute.c
> index 0e2c171f4b8e..a692e7c47110 100644
> --- a/ip/iproute.c
> +++ b/ip/iproute.c
> @@ -1374,16 +1374,23 @@ static int iproute_modify(int cmd, unsigned int flags, int argc, char **argv)
>  		} else if (matches(*argv, "features") == 0) {
>  			unsigned int features = 0;
> 
> -			while (argc > 0) {
> +			while (NEXT_ARG_OK()) {
>  				NEXT_ARG();
> 
> -				if (strcmp(*argv, "ecn") == 0)
> +				if (strcmp(*argv, "ecn") == 0) {
>  					features |= RTAX_FEATURE_ECN;
> -				else if (strcmp(*argv, "tcp_usec_ts") == 0)
> +				} else if (strcmp(*argv, "tcp_usec_ts") == 0) {
>  					features |= RTAX_FEATURE_TCP_USEC_TS;
> -				else
> +				} else {
> +					if (features) {
> +						/* next arg possibly not a
> +						 * feature, try to rewind */
> +						PREV_ARG();
> +						break;
> +					}
> +
>  					invarg("\"features\" value not valid\n", *argv);
> -				break;
> +				}
>  			}
> 
>  			rta_addattr32(mxrta, sizeof(mxbuf),
> --
> 2.49.0
> 
> 

This really needs to be a function and handle them in any order.
Also then the unwind would be cleaner.

