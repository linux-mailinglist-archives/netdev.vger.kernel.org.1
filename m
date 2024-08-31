Return-Path: <netdev+bounces-123982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3C967245
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 16:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE872831FA
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 14:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3C51EB5B;
	Sat, 31 Aug 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP10/FtK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B4A932
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725116209; cv=none; b=EVtKvFBnZeqUk30EfwtWZ+Qdfu3xmZwPYpXfRuWIQzlCYqfDR7Augio9Nh6209YxU8URsg1oxZv+5pxAn3kiZRroP0PDglem0t9VwKCLaEBJXndfWmxfapxpLMK4YKMSjCSNSzBfl0M/tPxaWIDEwila/+BRWcqxnKiEqrhxKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725116209; c=relaxed/simple;
	bh=Saubaa/0qjmaJzsqBkedoZQv7DxiZvDFMBgi2tr/4S8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ix5kB0N2b00TRcAlwpNTsxSD4gjmL/niF/TvepqainRSxVmQKtxGkoJpexZELB9HEbMpDje+U2rRiL7yvRkImqF+mwmaIsadynaTtvlH874LqTJe6M+D4ljEXhsMWIQ2DDizGA93bUn0WWuhoIoZ30qW3OCYlX5izF3P7F4WQ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jP10/FtK; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70f794cd240so136925a34.0
        for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725116207; x=1725721007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=137h5K99bfSqX+ixAOUXHoU8dzwJpgqEq5UIyoQERbY=;
        b=jP10/FtKziYAKYdSkQABaTc0ieYEK6UjesTHRFSFj7t9ygsOtVdcTvQ9jYoSJ9MEGT
         J+9og6GBcPR68MSAb2emIjUuouSeN3QNpOx+9jD/+4A5MPNIFtlEGEtNfjsZ3T9S+VbB
         8eZJqbiSbbU7EFe1D/4q3XaaXSMfPs+LL44l/RCop3BAVbjXbwiQ7WVKI0TlIOyOAAjb
         L2vo2fC84Dv2cXprTIFHN4+uSO7zkdNHtDpNMiDAT+hv6/FYCzUw/raSnJVHQnrouD4s
         yul4cPJHJGoX3QjZ4IIPFFK740uIy+OV+8laICsgHM6U4taZPHIPQV6txcJ7/hvpuNQ6
         7+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725116207; x=1725721007;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=137h5K99bfSqX+ixAOUXHoU8dzwJpgqEq5UIyoQERbY=;
        b=PtZcx+6SOVXHNPLQh0FMUujvq3HYzzmmweTYekibfU4mjV5AOmb5hg2JYqPCaO+Luh
         0Yv1qMJnR5QaLA7aKwJ7jOfWzlMu/eTUfxD3oHd+ihaHO7gXSnZTR4CU5oLZBcbkEKSe
         aUVOvg96zkTQ2AMZ+mntJGiXJezSpmFRqNz/+mnsmd6AolpdNm91GNFzg2IVJ51U9pEA
         pAhCvzcHFiLTQFB7x4WCVBBZQMqWXCp1iFDxCvHlr21bL18oqdhS1LZVR5VaOOMi81kr
         g/A7psdtbHcvugzhmPorGpMqItmjPqcnamwa3qEh7lHbxDub2cxxO5zm8dNoLYyzYBiS
         8Ptw==
X-Gm-Message-State: AOJu0YxHYsENwPKH2NxZdk9MF1jAOAcNu08DcsDhKhTkYF7D6bSPqped
	T1LUa9/PL2EBRV96INFtR6p7i3ZaQgMp+lBaHI45uzOq7oJRAMVkFmVuaHGU
X-Google-Smtp-Source: AGHT+IHfGufPQ+EJBIdOlZBwtpK/bFIM4chSIOAZLg+qa5q51avgFcun3ML35be3/gRVxph8fvvlSw==
X-Received: by 2002:a05:6830:264a:b0:703:fdda:fe2b with SMTP id 46e09a7af769-70f72bb5aa8mr2522052a34.11.1725116207066;
        Sat, 31 Aug 2024 07:56:47 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340ca65besm25087976d6.121.2024.08.31.07.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 07:56:46 -0700 (PDT)
Date: Sat, 31 Aug 2024 10:56:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Guillaume Nault <gnault@redhat.com>, 
 David Miller <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, 
 Martin Varghese <martin.varghese@nokia.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66d32f2e54231_3fa17629419@willemb.c.googlers.com.notmuch>
In-Reply-To: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Guillaume Nault wrote:
> Bareudp devices update their stats concurrently.
> Therefore they need proper atomic increments.
> 
> Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

