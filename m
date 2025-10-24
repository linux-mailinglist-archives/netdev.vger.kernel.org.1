Return-Path: <netdev+bounces-232348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3B0C04669
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B6C3B8490
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411112367A2;
	Fri, 24 Oct 2025 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG5Wuwsm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD941459FA
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761283925; cv=none; b=uEePnwUGSiOSKye8kZjnGcnNKDZKUcL23NiO9WXCTWkEaUfQWAErrhf5ft9KQyPQ9KuqemH/dS+6jfAZbECuZ5K1Jap4UruZG5XHt6ppYhbXWMgIReNYUN83FK+qbE3/V8HXKcBAhC5TFFk0x0JfFSRGtz/v2+HCuxkF6r29jlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761283925; c=relaxed/simple;
	bh=jrZFDTVAnVgZ12PpGzZA6oTE8Uvz8Wa0TIbGoyoIcmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxtYwXuDoukoI8wUrD7vXN/1ca/POdB/Cql+jDhyj4OaFtm+X5OS1X8myAei2feRgOTEI2v+Y0Sxg94lbwzFe5z6079+v1uuad5Mia3JohflzSWnROSnAiZLlVbcIeudeEcmkstLRO8NpRjHK832rdUcjZr6NnWbs26HqQXfWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG5Wuwsm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso3268812a12.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 22:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761283921; x=1761888721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jrZFDTVAnVgZ12PpGzZA6oTE8Uvz8Wa0TIbGoyoIcmo=;
        b=FG5Wuwsmi0i9CuE5RfHexYc+eh9TInLYYI8KVrzMq2vk0RiHZbSMNjt3mSu+gqRwYU
         yb7ezkXe7gGXpjBqwkO1eH3wPNsWx22o4YVnSEzfYZXUBARSTn3v/v989kKrZNH9d0tm
         nwl1oH5/lEbtFnxFhijolzDtxjrOBo2WWy1evTeuUjNsTNxpUrh6SUi3D7Q+rSFAiJvH
         8jtG3j9/gNQWhJs9Q3EUoqd8uuoWJfzjiwnQQvdh2Ud4LIaQvDDj9kzKU2k3xpavqh/h
         wU4veUzblYnD1CTdlt2A/v6i2+dGegMjfOAMYxd4IMWQnUuw2klzX/9AAkquXNOqfZQX
         cdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761283921; x=1761888721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrZFDTVAnVgZ12PpGzZA6oTE8Uvz8Wa0TIbGoyoIcmo=;
        b=Bjecsr1S235YmB4mjKycpQj+EeY3tv/IaWPl2tlAF9RZJiB8uXf8Fpg4I8ymlTN0M9
         pjatAZUAwSQqNaGkm4ZcFeDhQ3WdvKa7/icIxrvlMJXNdhB02I3uGfN+OTIpfjdQB0Mt
         D59vLYI6JBKNAIMsarjeOPZKSmFU0iTuYoFnioNw5sLxkwsK3PPpIbkzV2FslQXhbgdX
         p7yhvxesCubDjkMnOKsGcN+MKZgoKIpu/0EIVW3B0JZAoQvnzILKYWNPfL8MmjiwKWol
         0UVuJ/Y8agyJ/cm4AY06/HM4Nw+XJxGsa6eyOh0wc2PLd5DmOGsTk9u0Jcx4tDbEVlLE
         0INQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJGtL0Vnw8+nI3r7b2H0YXBNRHjcFCyqlsBhzDy/2jKPS8NV7XAz1Z8U6u3xxZJ93CoS5dyyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRV/64TFXVPujbs3uKudpS/84Up+k2VrH4XuXQftQhbhNLMTdA
	ozPrz/8sX3NEuCZ4MSiOxpTyLinsJy1Gbz3UqETZR/T4hgQIp2A/vaaMp2rjqcnjeTFC4y8w1yK
	N3V6SzwvtYQMdHTnkB/dxiP8UHsnVJUE=
X-Gm-Gg: ASbGncsSx3Im+ozrqkeHOXb6ZvLdh3vkT7VanzSjX8q7ReV9tDM2y3rwXW2zlfMmaQ5
	AzMCVzorr/goYbAcLEST/e4pjcpMznmg1/70ehJuTZemM5iFmSBJVjXOBjnoo7Y32Hzqej5Xo02
	qDkupWdPnY5A7XocZpUrNR+CcAAz4cqVHM656neHhG6g23vBhIT844NPMOCFQdHlPYuVBgh0THu
	dlqMgotAzuYONfIrup6TiLF6em653ycRfBU/xXN2pwk2OJPyhis02rrSnJedheYpOxTmdKOMj7t
	BcbAqw3uoAYhjrsC4VTMY+2RmcAmquX+qHt9uCijbQ==
X-Google-Smtp-Source: AGHT+IGFabAhZAJYuPfr/6rC/PYhEDpQyVDuFdX5CgymYZMIeCEsElgNay6QkpiOoSX+UbWLt45lbDkjDPoIV9KaDOI=
X-Received: by 2002:a05:6402:2787:b0:63b:d7f0:d940 with SMTP id
 4fb4d7f45d1cf-63c1f6300fbmr24095995a12.1.1761283920553; Thu, 23 Oct 2025
 22:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020134857.5820-1-viswanathiyyappan@gmail.com> <417c677f-268a-4163-b07e-deea8f9b9b40@intel.com>
In-Reply-To: <417c677f-268a-4163-b07e-deea8f9b9b40@intel.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Fri, 24 Oct 2025 11:01:48 +0530
X-Gm-Features: AS18NWDs_5xaC29vC8E21DedXs-dJA_wBfE3U9f9TDVAjvKKLnU69pQirhtU_eY
Message-ID: <CAPrAcgOimjOR9T5K07qR4A8Caozq5zimD23Nz4G2R9H_agPgWQ@mail.gmail.com>
Subject: Re: [RFC net-next PATCH 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, 
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 05:16, Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> Is there any mechanism to make this guarantee either implemented or at
> least verified by the core? If not that, what about some sort of way to
> lint driver code and make sure its correct?

From my observations, The sane drivers modify rx_config related
registers either through the set_rx_mode function or the unlocked
version (prefixed with __)
I am not sure how to convert this to a validation of that kind.

Basically the end result should be that warnings are generated when
those functions are called
normally but not when they are called through ops->set_rx_mode.
Coccinelle might be able to do
something like this.

Related to this, I don't think a sed would be sufficient as there
might be (in theory) cases where
the function has to do a "synchronous" rx write (flush the work queue)
for correctness
but it should be good enough for most cases.

I am also not sure what is to be done if the scheduled function just
never executes.

