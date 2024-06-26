Return-Path: <netdev+bounces-106955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6654918429
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF151C2214F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B38186294;
	Wed, 26 Jun 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIRmKcdV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2B1862B1
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412110; cv=none; b=acuSgd21UPT5TwbudR/vyZUYgwxKfgwt6Ld5gJlGB1Po2D8tGEV0tWTy0ICbrrYyFCtkrfwG/4uLSXXwrqqebL3VAHbEQYAyQSSGpMuPM30JKJ2u2ZP660SeJUf29eJWz+s0e/3OxRNM2aea5K1DBlAFPYUlvLxl9r4xF5Il0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412110; c=relaxed/simple;
	bh=qclw3hNdRZPu9FR309qbQzi7OVWGtjqbBigYh7+EjTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzeFNdW9n3xMyBaqdzPWfZP4iROimKYmwdFOGJH+Fxz9yCtxJpVqJ4fJH+6svsJ23VUIAuHB/j8K6oMrTK8/7Jc9Ppqd6+vvQw+zpJmjSvrSpFg0kQFY4hI6/ot1cWwue/SMpm3Sold8yK7AYOYCHkM4yAy9rihLkIM8ZABauoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIRmKcdV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qclw3hNdRZPu9FR309qbQzi7OVWGtjqbBigYh7+EjTc=;
	b=IIRmKcdV9mwSRsGFhHB/SygL9vbadiXuRCszAtnaU+sC0AZ4puNH+xVzSjBc4d/4EUHJcm
	hVDxtFNtyDhtfgXqdEUWGjbTKJYjEhMoevial236q5Yse3CfwRB0qv2xll1TyHQztlcYpa
	nQpBCXwQMtI3xpqpSbKR0nqYBqfv3tk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-oBCzk3Z2NDmWExW7Y0jjUg-1; Wed, 26 Jun 2024 10:28:26 -0400
X-MC-Unique: oBCzk3Z2NDmWExW7Y0jjUg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7135459efbso257782066b.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412105; x=1720016905;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qclw3hNdRZPu9FR309qbQzi7OVWGtjqbBigYh7+EjTc=;
        b=tSQTduHrcqUpwU790KG9h3i58s/GpvtedC+c2+SxaMh18Y2Jg5WfidpL8otJYLb3Hy
         K6n9sJPLgYNYoxpnQelUSVlGtv5u6D7NOtj1NIksLyi9QLMZXXmJHbGCCaSC57dTVytu
         j2oWB+llN0JxWsHInTr+QINJ5er0idw5EIgNR7nLzcpixlxVE48Q3nngt5RFDzLS8AnL
         xnr65GBwhCvHLr9O/Z8ZCPA4KFAeeXqRhiTkw5nBqPsbnfT3m2/qnBlQmwSituajgKfx
         craxTM/gOpvdhGLc4UZv+jr6QLC8b3bL1Nq81yCXIAYXFlj1bOyPalkwZ1EEwfAa6aIY
         yLFQ==
X-Gm-Message-State: AOJu0YyPDNVVZ5nu+oCMhmxXnDixzNt6rn5oFASJRrVZO3PsVQJF9108
	2xjoF0e9Lu5i/QB35actVH1qb8csOKyjZtPDkFQ5e/cK73zfg2WIGeU/o/npM+4QxmX6MvmUlgg
	EhkFui8Q43vTxn1bA+pVegN/Nb1z1bgjGgnf/Tksmu5fewLBtuSLYeQ==
X-Received: by 2002:a17:907:7ea8:b0:a72:55da:fb27 with SMTP id a640c23a62f3a-a7255dafeb9mr614663766b.5.1719412104904;
        Wed, 26 Jun 2024 07:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEapJi3f74BhkPhjlfRvacWqVYnKggewt5I2zL+WOXW6YqOZnd/6nAKEhMYOQSETUj3uEfgoA==
X-Received: by 2002:a17:907:7ea8:b0:a72:55da:fb27 with SMTP id a640c23a62f3a-a7255dafeb9mr614663066b.5.1719412104609;
        Wed, 26 Jun 2024 07:28:24 -0700 (PDT)
Received: from [10.39.194.16] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724ae806dbsm383611766b.41.2024.06.26.07.28.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:28:24 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/10] net: openvswitch: store sampling
 probability in cb.
Date: Wed, 26 Jun 2024 16:28:23 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <7AB95FAC-2D5A-4D9A-BB9A-9B0C8C01CA61@redhat.com>
In-Reply-To: <20240625205204.3199050-7-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-7-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 25 Jun 2024, at 22:51, Adrian Moreno wrote:

> When a packet sample is observed, the sampling rate that was used is
> important to estimate the real frequency of such event.
>
> Store the probability of the parent sample action in the skb's cb area
> and use it in emit_sample to pass it down to psample.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Acked-by: Eelco Chaudron <echaudro@redhat.com>


