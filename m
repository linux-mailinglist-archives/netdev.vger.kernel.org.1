Return-Path: <netdev+bounces-166674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9AA36EE4
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 15:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1F33B1371
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01521A9B39;
	Sat, 15 Feb 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAwRjnT2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CC4400
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739631015; cv=none; b=Xa8oPiluCQMGO4Fn2QWgiw9yZHhY11vbThNRGJq+yRvnqaxzsLkKwD+Fnubz976858ykBgZDlpfD0Cjl/4twA+rToO7WbdgLYAFTO59A/hMcCOZnkHLt37Qx75JXSdDnZR5J0nbu21BFAW07SdlwjP9cSNtcsTX/XneCIEiYbjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739631015; c=relaxed/simple;
	bh=USp/g6mK2FIAmOmvqDNtZFZ2mgSy8HqnCWIJgfRUsJE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ita4rBzJKIXyNj3DC+uDk+7byNsSrVxZs4UlakfYmrYGb62eq2mEEmWno4ID0kikxF1r7+Sjd3+OQWFF7GuWE7CZ3+lhvACTy9Kgsq9chJEeL6bUenIQ+lTNS+bBQCBtzXVuMXFVpIBra8YRRsQoljTIF2KIsKYVFr1z83aFag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAwRjnT2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c090bccad3so23737785a.3
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739631013; x=1740235813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0D1R7CgsbRWDczKNoNsCCos1UsxwdvtBttdx+RRaV34=;
        b=XAwRjnT2iQyZfnxlHZzdcr2blcyBtSctMruEd/N1Uh4XBZT/GGCtTPwcbYbzOanxdM
         xLefwLSRVIr0wCaazMy38mt+CSmjMkkammoGvFW8I6B2AC+y4F9Ul78KJZstQMR9t0lC
         5+JivuU6uVdyy6Nrik0mpStHM5D6KeJPlIh9d3ob3v7R9+4LyFbG89SfxEvnzamLJwa/
         UsxZMcLCaqr6akLcYE3ruWZC0CxGQ7VmhdKxuY09GTCDN4txiSih3j3Ce/fGzg3WYDt4
         3t5uoitVElNQ6+ZXrF6IQT1OL6bbogjQ2d724+W3ITyo7UpmrS6u3GgcxW7IK23mwMmH
         MaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739631013; x=1740235813;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0D1R7CgsbRWDczKNoNsCCos1UsxwdvtBttdx+RRaV34=;
        b=XE5IqGjNwmlnztzDRzqkPtLjFOhncWnuGnd+wtJgdRaAM44dXK6gNlY0prIPL5bY6t
         APh6PWWedGErvnFM3c49sZAqwoP9/2fSjmKOtYjGGeHH6Yod85vbD3o8XXZuVteIS3bs
         as5n5c2B2sxnuihF4icjnmuc2+yHkRe3T2tLqUHenGwPwxi6YZBVKAn9cLbczb+4uvp8
         r3K08kGqyL7lDQmByz2XnaHhgtWp2K1pV3ahLMBSpLMPV1gXhYgolC3Hi3w/WW+MxXr5
         1qqRD2Ai1a+WPPyCYM77D72/QA+NBhZp/Mu+hQ8SYSDxZceW34UDur3QvdmsuWc+pb2A
         mDNw==
X-Gm-Message-State: AOJu0YysRdCTEhxjkqtFqKZxEC3M0FqO990DTaNGfDgNzLisQyA8LpBK
	CMSG6b7dDsXxMFW4aQSX+bxpclezOjmwKQpGDp4NnhPO/XpnZ6tWVazO4A==
X-Gm-Gg: ASbGnctzv8fjf6/Atar6pLwxnaSI5BogdDkNeehsZBJqGSoZpGWf0Zy8p4DxRPVwpDg
	JFtDHlG1H1KI8fVFdgp/QuesaVRy8+A6esa0p7OJgplY9JzUkiQXdJmVQQvuTXC1syjxIS8o1lF
	CXCxuN3Q6/9QucKdvvUXQ7CGAGnEeEuBsU4nvrP339ri+8FIk2rRXVreRxyt7eaEOYktfbGZnEn
	VE3R+GfVTmIcOveFzv1p+poROVvQBkpHkww6GVWtxQFiHVAAoL3tO0wcaIqOPfDvtZ9LQ/NAhYD
	Fhl4I4wZk5YfqQGw657xHy3307BGEPGN/LY6Vqf6GKkyP+3X/+dw4qPaX6GeKn8=
X-Google-Smtp-Source: AGHT+IFYngZeA8oeHKOMBPUQKCw9auMNkmR/zhMkQumYbn4klFFbT3Jk4pIFZH5LDbGH+MvIhdMNKw==
X-Received: by 2002:a05:620a:1788:b0:7c0:7303:8d78 with SMTP id af79cd13be357-7c08aa89bdcmr427145685a.44.1739631013307;
        Sat, 15 Feb 2025 06:50:13 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a3f9dsm32487306d6.56.2025.02.15.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 06:50:12 -0800 (PST)
Date: Sat, 15 Feb 2025 09:50:12 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 petrm@nvidia.com, 
 stfomichev@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67b0a9a477972_36e3442943f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250214234631.2308900-2-kuba@kernel.org>
References: <20250214234631.2308900-1-kuba@kernel.org>
 <20250214234631.2308900-2-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 1/3] selftests: drv-net: resolve remote
 interface name
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Find out and record in env the name of the interface which remote host
> will use for the IP address provided via config.
> 
> Interface name is useful for mausezahn and for setting up tunnels.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

