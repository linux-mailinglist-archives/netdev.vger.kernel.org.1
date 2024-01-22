Return-Path: <netdev+bounces-64739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E0836EC5
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA2D1F2F095
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106B54FA7;
	Mon, 22 Jan 2024 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAgys+5E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980861693
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944299; cv=none; b=F4vhE99i9BENPI74+yFgq4gZKtFWkO0Xj3lnBYcqqTkqbSKSaCJYJ3v5VnSgjzN5p6r2jA4fHbpOjXej6vpcdhEO2HWR/D5V0e/9nmWgfoBJWGQTdUS9wNDYRKgvmogIgLbe2966hg248c+1wm/gfhRtKy23JRONFz5Ge41w4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944299; c=relaxed/simple;
	bh=GLKrUxyUALQSq9fwpY8O3C/BV3WYCVeFB6nxgTw9uhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF5UYAFLpYtuTi2CEZE24S/eEpQ5g7fim6aPjGsmSYN9hfxsDQqdQHWzlA2yKmIeHZEMvd5payJ6VmfwSbrs+rMxWoAXiqc+VVxFal2ddA3BFLSn42eXe/MbP4hbHRXAoB9xnaLZeEFMtIPw9uPdznhXUPSyFbuO3Uk5mKe4esU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAgys+5E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHT5hl8+BLdILjj1xi8MQ0aOcIL0yqmoqgp/WV8qlxc=;
	b=JAgys+5ERO9dz66Fe0YbF1q49Z++uygEiA/ThJakfCxncE+NbPWWJxgh2dPPcgrZt+ZTiH
	o3d3TSwz5Me9gEZHC0XNVLIpZt5KV2NbUrqf8Cz21eWYfAD4KX9ApN1n8b/Yl3I803fYaW
	bPt9SrQ5vGlPFJQkst1YDPlElq8mOJQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-Bi0WzT4hNTWofg08LaHiyg-1; Mon, 22 Jan 2024 12:24:54 -0500
X-MC-Unique: Bi0WzT4hNTWofg08LaHiyg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-59927811bf8so4005076eaf.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 09:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944293; x=1706549093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHT5hl8+BLdILjj1xi8MQ0aOcIL0yqmoqgp/WV8qlxc=;
        b=fFblDzZHPm0PPxdUdLVic63iqAV5vH0UB03zLWdjead2kQ81GSB+Par3zOUnV+T1xZ
         SY9JfIGwlsb2dYNJcswSM5UGz/cIR1i5FYmEPPPrB7Pn9PptHOkYAkshuiCaoS9RSoyV
         EzeNVCU4FIlpInSofq+i2JQZ/PicVtTTgP6xrfjNWAgzd3+wzXTN6WU/w2x9EBJPAiWq
         3M6ReTSuvo1/jQcpAIqpAH3J1IGNuCUgoScNokrSrwSzya0zGnpVh/DkigY378ZR+RZY
         YeWr4GeIFTE+VTDdTDcz3WJMsR9gvXv+a3tG62CWQrwGeRIjp5EiMbWz7PlgYpml6OFd
         GchQ==
X-Gm-Message-State: AOJu0Yz6kw13bMMElVtTfs1C6/TfuCWEWNaRbpcMo/+RvPhsZEPFwYBl
	PFJqjv1A6eQttJVWe+zPNePDFadxeUjOB3I+1QzAMs339Vg0f4zLOoFFFNWMLydwsU/qZ6s82La
	rtlskdP5ltU4/LWTGINedRl/TyX0zM7HTx+Atty4p1/B8pPofEgOhUg==
X-Received: by 2002:a05:6358:224a:b0:175:fc1a:c7df with SMTP id i10-20020a056358224a00b00175fc1ac7dfmr3920459rwc.15.1705944293661;
        Mon, 22 Jan 2024 09:24:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWJJtcXzQYMuheVKrhee/bQQMW5AoBwjJN8Pb77kx7v+HPIe/kZYwgSGcA2jyjQAfq1FSomw==
X-Received: by 2002:a05:6358:224a:b0:175:fc1a:c7df with SMTP id i10-20020a056358224a00b00175fc1ac7dfmr3920448rwc.15.1705944293469;
        Mon, 22 Jan 2024 09:24:53 -0800 (PST)
Received: from debian (2a01cb058d23d60079fd8eadf0dd7f4f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:79fd:8ead:f0dd:7f4f])
        by smtp.gmail.com with ESMTPSA id ly4-20020a0562145c0400b0068688a2964asm1542850qvb.113.2024.01.22.09.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:24:53 -0800 (PST)
Date: Mon, 22 Jan 2024 18:24:49 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 5/9] sock_diag: add module pointer to "struct
 sock_diag_handler"
Message-ID: <Za6k4bpSj9OGAwij@debian>
References: <20240122112603.3270097-1-edumazet@google.com>
 <20240122112603.3270097-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122112603.3270097-6-edumazet@google.com>

On Mon, Jan 22, 2024 at 11:25:59AM +0000, Eric Dumazet wrote:
> Following patch is going to use RCU instead of
> sock_diag_table_mutex acquisition.
> 
> This patch is a preparation, no change of behavior yet.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Guillaume Nault <gnault@redhat.com>


