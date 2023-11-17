Return-Path: <netdev+bounces-48512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442DB7EEA71
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 01:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F381C20986
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 00:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56AD38F;
	Fri, 17 Nov 2023 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZK3rDC6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3DC130
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 16:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700181996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXPMAIuOJobnbk4l5EMtqu+6sDBuXU0ppSLkGsUmTTE=;
	b=FZK3rDC6aljkmVcu3W0ypRVgri3RM+rHCtxfWtKu1QPjOqLoVUH20JcUSWE4Kai6x/+82h
	rivrU47aF1BszSaY+7JuKcdM8rRxXphdgWY4YYKQ9QOtbSP84fWtliDX/rWvE7s1X75BIg
	7AajemuzMtMiUtYwccJpnA1kuqSJ2mA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-pTq9jwi7OGemlkG1VEFXUw-1; Thu, 16 Nov 2023 19:46:35 -0500
X-MC-Unique: pTq9jwi7OGemlkG1VEFXUw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c53ea92642so12772721fa.2
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 16:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700181993; x=1700786793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXPMAIuOJobnbk4l5EMtqu+6sDBuXU0ppSLkGsUmTTE=;
        b=HpDKcsqg0vw4/JUjRJXgt0RPBJ7rh5KEpb3GbByD+5Zd5q4qNn11nWxXpMuGjbvAb7
         b49oBf95JpOwACWkw+rN3gQXs8MQCUwzu/fbMNgN2AQvv5IHlGQFqIYXUquiZX3SAm2I
         n5y0xs+cBf1F4okFD26jpplmvon7h014qJreprbG9UvyypheoiULMauyyJebDwiVOcGh
         qXS1BuKvEez8KjcPDmDBTUcv7rq9jJY89b2rQAfIa3DpuVcgMpo7mIORo0oOqxiQavm4
         P4ZZ0JuDSz6tH9bFnueeqPlqGRqMO6NX6OpVMkUBAHELDkIP6A+E/H0X7359NXtFDTfu
         CJYQ==
X-Gm-Message-State: AOJu0Yw1JE1HEdmYHf6HcLY2C5kCMRGTnz1wtQ/QQwBQpKmTVvuyeUo8
	ivMakTc0TYry+ZV3jugO7UchEQ2L96YI4KEEO5Sz9mKMC8BnPz9Djy4P4lRxVRTze1Pq6P6WTZN
	B2PxNyS79bQX8UYMPuiBQ/Adn3qQ=
X-Received: by 2002:a2e:a4a1:0:b0:2bc:c4af:36b9 with SMTP id g1-20020a2ea4a1000000b002bcc4af36b9mr7275396ljm.52.1700181992960;
        Thu, 16 Nov 2023 16:46:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/Y489bvhVNh4j1D0RXhb0CrxFegRhnNK3FBPCMCq2tPFWJ7GBl1JPM770O22kir5tBB/VPA==
X-Received: by 2002:a2e:a4a1:0:b0:2bc:c4af:36b9 with SMTP id g1-20020a2ea4a1000000b002bcc4af36b9mr7275388ljm.52.1700181992526;
        Thu, 16 Nov 2023 16:46:32 -0800 (PST)
Received: from localhost ([78.210.17.86])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090608c500b009adcb6c0f0esm198205eje.193.2023.11.16.16.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 16:46:32 -0800 (PST)
Date: Fri, 17 Nov 2023 01:45:51 +0100
From: Andrea Claudi <aclaudi@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: heminhong <heminhong@kylinos.cn>, petrm@nvidia.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4] iproute2: prevent memory leak
Message-ID: <ZVa2Oha4ahHnYw16@renaissance-vector>
References: <87y1ezwbk8.fsf@nvidia.com>
 <20231116031308.16519-1-heminhong@kylinos.cn>
 <20231116150521.66a8ea69@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116150521.66a8ea69@hermes.local>

On Thu, Nov 16, 2023 at 03:05:21PM -0800, Stephen Hemminger wrote:
> On Thu, 16 Nov 2023 11:13:08 +0800
> heminhong <heminhong@kylinos.cn> wrote:
> 
> > When the return value of rtnl_talk() is not less than 0,
> > 'answer' will be allocated. The 'answer' should be free
> > after using, otherwise it will cause memory leak.
> > 
> > Signed-off-by: heminhong <heminhong@kylinos.cn>
> 
> I am skeptical, what is the code path through rtn_talk() that
> returns non zero, and allocates answer.  If so, that should be fixed
> there.
> 
> In current code, the returns are:
> 	- sendmsg() fails
> 	- recvmsg() fails
> 	- truncated message
> 	
> The paths that set answer are returning 0

IMHO the memory leak is in the same functions this is patching.
For example, in ip/link_gre.c:122 we are effectively returning after
having answer allocated correctly by rtnl_talk().

The confusion here stems from the fact we are jumping into the error
path of rtnl_talk() after rtnl_talk() executed fine.


