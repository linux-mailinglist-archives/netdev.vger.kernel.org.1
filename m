Return-Path: <netdev+bounces-120619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 666D5959FEC
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C0FB20BF9
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBE580C0A;
	Wed, 21 Aug 2024 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BknJ/2XU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4E364D6
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250730; cv=none; b=ASgAjY9Uzslq8MnuCXBYrHxAAU3fQ2K0abZQ+YPpsA2ceOIw7W8nziLYs54pQP/9clgbb+qR6DZlLpkYTx3A6fEYgWxYR8M9lOBsLlojtTAahM/Um8t8bpheSmfMRXhlOk5aGDreqyJ30QCRtcXvjBJnagZCn/PTENHTDyzWayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250730; c=relaxed/simple;
	bh=wwCdzE241j55ZnMrLGn1aWiFt0ydIB8RlCfw16J1VYo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KVt70u5Sy1jmY+1Wjll5hWW8WNFb+TEDl2hv8U17tUoezReiK8iWionnP99ulvipDryDXai5QKUy2yDleT3pwh78w2qyN3ZwG+NaVBERKNEE9KbaM5+wSJLgoau80JhtYIUsY8FTPbbrorraP2KxqxEie/uma7IWOh5GSplrax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BknJ/2XU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a5074ebb9aso339374085a.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724250727; x=1724855527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biVSu46zBw/d45X/5pV0QE3qmX7CqejUbyRqyBHiwko=;
        b=BknJ/2XUJykBp0Rtz+eaqrrzyX05uIBU6LPnClB+vwXIYHqTxXEVwo3MFswOVIbkPs
         TdeJtxwWR7NfvKcOjtIsYx6c7N+e3l+qVgKV/mkgdw6/WE6xX/+xOpAqJYoEzQqfy/Hd
         mcPH9z/UaNK2dWq/47JJHlzkPBYEUy4XSaUqSYtyZe3vHGmOOLWVa36xY8hgcTl5s7Yr
         rJ5sVkVGWqsckVe9zoozJq1U+0rxKFD+2xnD7mOfo4AUjJhyUCF1i3VchiLSDhQB5NUA
         b31p/mtQ2OkfxpOuCqct4EMneVVorxE1MwVNkkZOo4OE2zP6guwu2F0OA9FS9iKYKjw0
         718A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250727; x=1724855527;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=biVSu46zBw/d45X/5pV0QE3qmX7CqejUbyRqyBHiwko=;
        b=Cf5dGlDQu3zDGNmPYiY/lXbYN5HUh5dEEfoaHHWiPisLzByX2/LGpu+pXGq6NR+aCd
         PnsLCn/DaGi8vNozTfTn/HkOAz6BOWk6zIF75oC+7hklAMZoUb4BfV8cicMcSLxRWoBw
         txxupdTHeFQrxbBh2XNiLi0fmf9JD8MdHK6zALlgICgcUetnSoaBzXCAU0w1mattup+U
         qqpRQ9B4xOgTS82A2i1S8K3YkibIqtQo6ESdg84mEEL6BCJZSU0YXF1aTq0u+N9ldw58
         YHHXZdPEJYKHaPvJrgiH48WsfdDELYcJzOMTNjQwEEZ9vsjoGcb+/nQoH2GF8fnrv5vo
         NmEw==
X-Gm-Message-State: AOJu0YwozIAA7Qp0LVzaG7V1PYSd7uZgOTUsM1fU1uRPBAPWKv+TE6pZ
	RnpmQIq+NkfzKJNYc2vVsA/Osh/QxPpg/a12CdP9Af6QJORCDO60
X-Google-Smtp-Source: AGHT+IE2DHCr84PEpAqQls+B0QryLYvQ0CnKet2drBbYwwxjPkBAQG7j1JIGKJA4tQoL/ZAiF953BA==
X-Received: by 2002:a05:620a:1a27:b0:79f:170d:8b7f with SMTP id af79cd13be357-7a674023332mr320905085a.24.1724250727292;
        Wed, 21 Aug 2024 07:32:07 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm626421085a.11.2024.08.21.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:32:06 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:32:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Krzysztof Galazka <krzysztof.galazka@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 Krzysztof Galazka <krzysztof.galazka@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <66c5fa663e274_dc0c22942f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240821142409.958668-1-krzysztof.galazka@intel.com>
References: <20240821142409.958668-1-krzysztof.galazka@intel.com>
Subject: Re: [PATCH iwl-net] selftests/net: Fix csum test for short packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Krzysztof Galazka wrote:
> For IPv4 and IPv6 packets shorter than minimum Ethernet
> frame payload, recvmsg returns lenght including padding.

nit: length

> Use length from header for checksum verification to avoid
> csum test failing on correct packets.
> 
> Fixes: 1d0dc857b5d8 (selftests: drv-net: add checksum tests)
> Signed-off-by: Krzysztof Galazka <krzysztof.galazka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

This is not Intel driver specific, so can be sent straight to net

> ---
>  tools/testing/selftests/net/lib/csum.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
> index b9f3fc3c3426..3dbaf2ecd59e 100644
> --- a/tools/testing/selftests/net/lib/csum.c
> +++ b/tools/testing/selftests/net/lib/csum.c
> @@ -658,6 +658,9 @@ static int recv_verify_packet_ipv4(void *nh, int len)
>  	if (len < sizeof(*iph) || iph->protocol != proto)
>  		return -1;
>  
> +	/* For short packets recvmsg returns length with padding, fix that */
> +	len = ntohs(iph->tot_len);
> +

Are you running into this while running the standard testsuite in
csum.py, or a specific custom invocation?

Since the checksum is an L3 feature, trusting the L3 length field for
this makes sense (as long as the packet wasn't truncated).

>  	iph_addr_p = &iph->saddr;
>  	if (proto == IPPROTO_TCP)
>  		return recv_verify_packet_tcp(iph + 1, len - sizeof(*iph));
> @@ -673,6 +676,9 @@ static int recv_verify_packet_ipv6(void *nh, int len)
>  	if (len < sizeof(*ip6h) || ip6h->nexthdr != proto)
>  		return -1;
>  
> +	/* For short packets recvmsg returns length with padding, fix that */
> +	len = sizeof(*ip6h) + ntohs(ip6h->payload_len);
> +
>  	iph_addr_p = &ip6h->saddr;
>  
>  	if (proto == IPPROTO_TCP)
> -- 
> 2.43.0
> 



