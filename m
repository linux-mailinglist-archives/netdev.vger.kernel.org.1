Return-Path: <netdev+bounces-112103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FDA934F97
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4691B1C208BC
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF3057CB1;
	Thu, 18 Jul 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPS7xyNh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C45C2A8FE
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314977; cv=none; b=H8eNdNFvJev4HE6mHa+UN4d3xRS/6z1MeylCfw/aI5nYYqtScAS0HQ8M8K02mCV4g7mo0PO3YYlQN9gbYTDWLGjkPhQyWKbr8JLF2KI8eHYDzCV/UYT2VQnT7vb9detNwujf6urZizlFOofdLouaNMKoxMEcCB/LA0U02YAu0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314977; c=relaxed/simple;
	bh=w7OwxjJ/EkT3DkmLgCPAgB/bcbN4P38BpNy5FWvpcJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8atURgTdoqhB8pAW06XB/ecKYXr/P/kRz7p/4hBPvsYTtR9vy5faPLY3eRKN7WCZFsnqO8OxBgYDcfR1vKylCqTARx6nAoZiChCFT3guaTXhA2zg8CWb9f3HjtRxQ9sW0UL1bqFJmVa7+RRrT1tMPz4k4yO6GpBv5X+q4iDsxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPS7xyNh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721314975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EV9CHO83gu/NySiTRVl0vMnIcjDBOfPI560plc1pVkw=;
	b=SPS7xyNhTr90hLhlvNMlCQoEtfU5p51DRndOZmvqp/A4Mh1mX85HIKGDYIXkPKg2r7slvm
	NfF+0DVu8vaHgSSk9abeGJihr1OkB/LW6TAXerkoAjvMbNrh80AwwOTqwy2v4MVu+AASvI
	S4q8Yu8I8fSD6nRb2xVYvxVpY2BeGRg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636--0zyl8bSNsWRxRmhV4Nykg-1; Thu, 18 Jul 2024 11:02:33 -0400
X-MC-Unique: -0zyl8bSNsWRxRmhV4Nykg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3686d709f6dso94694f8f.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 08:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721314951; x=1721919751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV9CHO83gu/NySiTRVl0vMnIcjDBOfPI560plc1pVkw=;
        b=aovfuXe8Qilv1xg30uIS60peImxeIKiUrs5IJQ5DJcS/boZNugZUtX6EeYClP61Yz8
         LVRRSHeTV1IB0skyjtDV0XQWIaITwDqj/2H5/e2AobwotfC2bM1v+KksErq2as/Rnnho
         lRK6hfnMJH09ipcJcuxEJWiq5a22HZxfhdAz0pdnL6UZR6yZO3Y/yXT5Iv3WkhLtX/7V
         Kodztl8veQHXELLLd31cMjtZd5Ff7zUQR2fwdgZVwloEhE0k3Y9E81nYmcxn7SnR1tAk
         1/rcoxYEN1M1MKr91Z3qq5XqAHxlXvu0CRxdRhQc8iHHfZnNxzDl5OnvohTlPlh3fFU3
         aMnA==
X-Gm-Message-State: AOJu0Yyv50TY80wc7CTWUilK/gkUMoxZ9sECEz4Emap1fZJZQAcdF08i
	bTMGpJ6pEkrbTFolx1pQiqvCaW2pxoSwi8PSAk3dFoIGCsXc3SgvLMTw4slbD02a8aUrlIgTyCj
	mPWjFHUjtIdkT+AN6h+TaKaKrhFU1FuCQmNwA77OzFc3C2W2cuacChtuJV8c7AQ==
X-Received: by 2002:adf:f344:0:b0:367:992e:acc with SMTP id ffacd0b85a97d-368315fb74fmr3159223f8f.18.1721314951515;
        Thu, 18 Jul 2024 08:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Bl5RKqi2PcCjLbODeOlborLyQn4eSozQYqbobAE4OCc4GvAuH3Uo4qBvgWkM9Uj0M6XahQ==
X-Received: by 2002:adf:f344:0:b0:367:992e:acc with SMTP id ffacd0b85a97d-368315fb74fmr3159183f8f.18.1721314950798;
        Thu, 18 Jul 2024 08:02:30 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3683f0accb5sm3660262f8f.68.2024.07.18.08.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 08:02:29 -0700 (PDT)
Date: Thu, 18 Jul 2024 17:02:26 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org
Subject: Re: [PATCH net] ipv4: Fix incorrect source address in Record Route
 option
Message-ID: <ZpkugkU/HQ4QUPfU@debian>
References: <20240718123407.434778-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718123407.434778-1-idosch@nvidia.com>

On Thu, Jul 18, 2024 at 03:34:07PM +0300, Ido Schimmel wrote:
> The Record Route IP option records the addresses of the routers that
> routed the packet. In the case of forwarded packets, the kernel performs
> a route lookup via fib_lookup() and fills in the preferred source
> address of the matched route.
> 
> The lookup is performed with the DS field of the forwarded packet, but
> using the RT_TOS() macro which only masks one of the two ECN bits. If
> the packet is ECT(0) or CE, the matched route might be different than
> the route via which the packet was forwarded as the input path masks
> both of the ECN bits, resulting in the wrong address being filled in the
> Record Route option.
> 
> Fix by masking both of the ECN bits.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


