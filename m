Return-Path: <netdev+bounces-214267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A62EB28B3D
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE4E587E10
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8CC1F0E2E;
	Sat, 16 Aug 2025 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDkukHFD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE345009
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755327751; cv=none; b=Y46ZYBlVB9ReY62ZajvvMJuSbi/3PqtGXEPJi5qbHkjvn/OxQkrDw3Hbmq1r/hoyhQA0sV6XIufg3EmVwVa3h6Qb8HrQN6xSjKhc2+qYQuAUHljGVLWF5EKuAMO0/1Oe84634k0O/OBDjI2ghXXNUcjTd9BMJsgSB/mGCY2Y4Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755327751; c=relaxed/simple;
	bh=9zr4cVGmfq2TFRGx9uS4sZPGfY9cmGBmyoCZkN8MSKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SAuWHFtYiqsewU+oJMEUFWwH7xiJpz4+ZZh+R4TABGaHrM0U3VoLxcgMeL1TpYNFAOvBhz/HbrvUQjCG5ivQAHxMZm1+OLNKFtBlyFZMLfRVgAtbdRqr22fJDFVoutkkR9+uUdEXHMSvMtx++ULK6IsyR0xqcsE7I1YB0PlKc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDkukHFD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e9a98b4so2342841b3a.1
        for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755327749; x=1755932549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OZ4KPO3OTfBU5odD4L+dZ2HyAYRZd4rJ9ysQS4sj4H0=;
        b=jDkukHFDOIwJ877g6da4GwZQ8GxSWq0SKLw6nOajk+DR1B5PMawh5TSIznyn7nBzEp
         /V3vEZs8vw5BXtk16ICd84hT2C+mb26sa/43jiWtFqsrP4Wb7M4RqCd0bOx2zwPdgqyh
         eGDqjXt38g0NpJqQiXs8wbcNbrW6gYZcM5DnixnAV5wv+2SN71LDrUfVI0czOxBWDVh6
         93BHmtCyvdQseUt5At9BHEPH83q0552Gz8y/+zahFjbSe5kO4vIJgEkPLv+ZG40Ep5BD
         7dnKjzq/sU7nr9i93SzDH6CK46IbRyoZmuf/KODmH19YH2fEGV2L59DtbO3j3NUbVddS
         61EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755327749; x=1755932549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZ4KPO3OTfBU5odD4L+dZ2HyAYRZd4rJ9ysQS4sj4H0=;
        b=JUqz09kFqYP9CxDPMNiEy/t0zy78AWb2ORwprerAe+g59MxnXaTwPjkcHZeHJJHID+
         pTovCKoROCGguaCiMy5AXw2Y4rJNU7Cj4DS1MAs/yzvfcnoCW9IwMTxzjQKIEu9ZKCNl
         ukMDXNuqIvzexTrBV6HfQOPz/pfEVPjKhzznDeoN8cc/1DvEpVld+SQn4zXsmbpPOqVA
         cPySAzNhdZHbCNGtsGrzuvtvaQByADrFfEjOuWColVEKgjXaze6uB1SEI2yBAONBGNgB
         ZDBT5EUODKECUnKyhycv3vKAhn2o2gugeJaYHH8kjVMvxnxm2fITnXetPUzauHz0bGIc
         Y74Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyc5sDZlatFGhVONjjjVdNJPm9BohNKHvo4jRYQO2ArjXGoc5rtM3q6iPCSx1lnmbIOrWJ6bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHCJwdi7fBnvwfwlszV94K7wSp/ZYuh7RDSDnbCVWHeoDIcBi
	21vtHc/vUx/57sK9AIpVbrpU6HN8GqjZcMqKbpZKV7jwNn/Pvdtbkedxt/airWTnzTl48JtcwZT
	dkwJqNA==
X-Google-Smtp-Source: AGHT+IFVet8FRBdtWSJfveWRjqspytrXfyjOqMTPNLkn9G8QEMfVM2GfQ61byXK0lJ4a2jF4jPoWDawuGBY=
X-Received: from pfiv6.prod.google.com ([2002:aa7:99c6:0:b0:769:dd99:e6e4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8e8e:0:b0:76b:f7da:2704
 with SMTP id d2e1a72fcca58-76e324c93c4mr9566064b3a.11.1755327749346; Sat, 16
 Aug 2025 00:02:29 -0700 (PDT)
Date: Sat, 16 Aug 2025 07:01:28 +0000
In-Reply-To: <20250816031136.482400-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250816031136.482400-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250816070227.1904762-1-kuniyu@google.com>
Subject: Re: [PATCH net-next 2/3] ipv6: sr: Use HMAC-SHA1 and HMAC-SHA256
 library functions
From: Kuniyuki Iwashima <kuniyu@google.com>
To: ebiggers@kernel.org
Cc: andrea.mayer@uniroma2.it, dlebrun@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Eric Biggers <ebiggers@kernel.org>
Date: Fri, 15 Aug 2025 20:11:35 -0700
> @@ -106,79 +95,17 @@ static struct sr6_tlv_hmac *seg6_get_tlv_hmac(struct ipv6_sr_hdr *srh)
>  		return NULL;
>  
>  	return tlv;
>  }
>  
> -static struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id)
> -{
> -	struct seg6_hmac_algo *algo;
> -	int i, alg_count;
> -
> -	alg_count = ARRAY_SIZE(hmac_algos);
> -	for (i = 0; i < alg_count; i++) {
> -		algo = &hmac_algos[i];
> -		if (algo->alg_id == alg_id)
> -			return algo;
> -	}
> -
> -	return NULL;
> -}

This chunk will cause build failure when net.git is merged
to net-next due to the patch below.  You may want to respin
the series after this lands to net-next.

https://lore.kernel.org/netdev/20250815063845.85426-1-heminhong@kylinos.cn/

