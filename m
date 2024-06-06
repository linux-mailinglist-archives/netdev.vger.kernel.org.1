Return-Path: <netdev+bounces-101352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32C18FE3B3
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702FB1F22BA9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDA31862A3;
	Thu,  6 Jun 2024 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JI8/AOJp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C18185091
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668082; cv=none; b=Q9kcrTFf93z3uL/ZvEbANOJ7wv01mE2jOhU4m8sIuz61FDyA+0VfJu5csu5Kb68Ul3Dzhhna7bdqNFA34JTD0V/mtuuxApHUbOGmJzT7neWOAxkvrBSAV7qjF8iC1DizSzFP7W3Ws9U1yXnqDlYPSUfL/S7f8XLpSN9+25+c0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668082; c=relaxed/simple;
	bh=hFw/OwJFDaBDH2vIVZfCBgGnW24BGWiNLNzRY0eBe8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QwOLYvS8Xo6jwmKUm23rus+NLly7jy8bEleZ8DwJZgMkMn7vSyir7J7EKOI6oYYR1PHOTtmbJGwNc0gQWQya5/AMmpKN8SDQw49N2HdFh0hNQ3uvKr/ksytVi/bgNB92YAmZ8KKasWDS6qu56fdvgGWBDMWZ7BXhQANQubl+AdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JI8/AOJp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717668079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d8qIrwRbP4XNy0uEBCd/Ze8cX7JjSk5ShBkhDt8QGK8=;
	b=JI8/AOJpMniUx6nzvWsE9J6LN7fX1IExA/ZB3ivjBH5zVmUtVrabKcia67cgPYgZEESYup
	LyVqNzJmriYafgl/MutZPYS4JBVokBEmGMBCUolmhLaJcidPXdPGl+qTTCRldkMSysaE5j
	CrbjhaXdlBckp5YtpdtcWNbtvq1JxNs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-U9s5PTVbPsaTSP6BMZofPA-1; Thu, 06 Jun 2024 06:01:18 -0400
X-MC-Unique: U9s5PTVbPsaTSP6BMZofPA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4212e2a3a1bso6554255e9.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 03:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668077; x=1718272877;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8qIrwRbP4XNy0uEBCd/Ze8cX7JjSk5ShBkhDt8QGK8=;
        b=maF2DWWiJUZIMRsOmRbh+sy/lF8pFOMnqhCRiw9neR2dMaFDqI5bxlj4JyKEUYO1jr
         GtINEYYE2BLsuSlBQPZTP59f5und8k8kI5MJlzbhu3Y8/5jm6kvXK4DWc4C1loy7GjZM
         ilwPE9BeKyGHRB3O/sGZXBT84lb9AhcXUaakgFKKnje2XjbYEM33u0B3H7Ee0wm3ITdd
         Y6rpOixLR+o1M8EiSx5zBGdfeFPNaeOFURv5VmvjpB0QLs64ZQFgs3zAnHtjS9EBh6mG
         wJnEBHaQkqfiLcU9LzNhpFI/gCObEOXnthhnKzoGG2roMGh6+CJyoL2HDjRakBZ6nupB
         mtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo506hDGsV5HMJ1Zg2fsk3pJSjAdBwAJeZTe95NdspuEE4LiivwaZIL8UXXKC9aafbv+i5sHwiIPrRdgi5R9f3zhDppdZe
X-Gm-Message-State: AOJu0Yw0cfDXJk81ClzWpOgH2r+P7WJnN6cKFd6on7uoFJ1iJ4Mj73tX
	GYJtbmtyUlYHSB6bztnJOJx5Gg5WGkO0lgCfrpQvyk0DzW0CDjBaa9OPlsA1u6wfQ8uSfxpBcjd
	x3styFzqF7tuGdIyn4OEuTW4SqHjD52wu8mPZarEf45qVuXqIcdBGMg==
X-Received: by 2002:a05:600c:1f84:b0:421:59cc:db32 with SMTP id 5b1f17b1804b1-42159ccdbc6mr23725675e9.12.1717668077052;
        Thu, 06 Jun 2024 03:01:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH79AVMtuTqR3foxL7s9eS9oyh+xxCa/5hLpAkaK8+R/STAV6Qk9WpqWl2HhorjlugJ6Lzp4g==
X-Received: by 2002:a05:600c:1f84:b0:421:59cc:db32 with SMTP id 5b1f17b1804b1-42159ccdbc6mr23725165e9.12.1717668076100;
        Thu, 06 Jun 2024 03:01:16 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa2easm16164435e9.12.2024.06.06.03.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 03:01:15 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, tglozar@redhat.com, bigeasy@linutronix.de, Florian
 Westphal <fw@strlen.de>
Subject: Re: [PATCH net-next v7 0/3] net: tcp: un-pin tw timer
In-Reply-To: <20240604140903.31939-1-fw@strlen.de>
References: <20240604140903.31939-1-fw@strlen.de>
Date: Thu, 06 Jun 2024 12:01:15 +0200
Message-ID: <xhsmhv82me6fo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/06/24 16:08, Florian Westphal wrote:
> This is v7 of the series where the tw_timer is un-pinned to get rid of
> interferences in isolated CPUs setups.
>
> First patch makes necessary preparations, existing code relies on
> TIMER_PINNED to avoid races.
>
> Second patch un-pins the TW timer. Could be folded into the first one,
> but it might help wrt. bisection.
>
> Third patch is a minor cleanup to move a helper from .h to the only
> remaining compilation unit.
>
> Tested with iperf3 and stress-ng socket mode.
>
> Changes since previous iteration:
>  - use timer_shutdown_sync, ehash lock can be released before
>  - fix 'ddcp' typo in patch subject
>

With Sebastian's suggested changes:
Reviewed-by: Valentin Schneider <vschneid@redhat.com>


