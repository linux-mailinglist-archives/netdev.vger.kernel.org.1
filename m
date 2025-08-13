Return-Path: <netdev+bounces-213396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82BDB24D81
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC7C1A282AB
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82E23C8C5;
	Wed, 13 Aug 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwozugh0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B777260D;
	Wed, 13 Aug 2025 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098990; cv=none; b=fxr+wGcSBLhWk2gMpWrZIeMSCFuKZ5g10gX7+ve8sJF7j8PLBO2mKWYTCodDPWuGv/Q6DR0cPAQB/gu2BBP90+hEUXT/MM2jc4b3D2Rdn6GHxpCxyLQeUOySKH+Xo39ZB2G7L4tYY3nopCxG2JSqD+E6Xafom1vam1fjUpN+0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098990; c=relaxed/simple;
	bh=GsTn18GDql2jVwF/EtLnlzuCdG7Ady/F1iFVAj0vasQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyqjEC/2OAac6deyoqOluSZ2KgDd7kljOR97YOM+omxCrB7WksawfXs4yZFKk7xeL4VFddZBND9VLDTCI2ivwdZHuNyHnpSfA0QtgxsjKFcs/FrJ3Fw83+pK8uK1jsEHt8IvTsGv0FVr3sBaRrjwEvraDSB2LGxmar8VVEb+jV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwozugh0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b792b0b829so6759084f8f.3;
        Wed, 13 Aug 2025 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098987; x=1755703787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dyk6h1SXhHJg+jjJ7myywjFooeBexsFrLHNyH2/6iM=;
        b=Rwozugh0NYQudv+Kn59IduCaN76d2uAnc2L8Lg78X/Lhf3T2ZM2JlJXrTTujxoXLCM
         DAQ9LykY/Dbjx57JiaRVmkNCxOKq67e7ReE9Onfj1GglOb/4ovp3WZzVHigY9CO2LZc/
         W9peRhR71LIt+rIIuckACHnXTEWeMhv0Nc+WHtO151nSWBdGTdYLx9ix3NSKvm7Qf1F6
         IvnFraeZfYphDe4ZT2AJzN5y631s1weCZUHWXKgYGT4WzP1YCh+aAfS65SLQFAyFttwp
         v9oMLHZLmNRO4er060HL5bXIOptLA0Q0k5+Bzp5OIIYkrVd1aLXbKO/9PdIEE88UBG7V
         UGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098987; x=1755703787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1dyk6h1SXhHJg+jjJ7myywjFooeBexsFrLHNyH2/6iM=;
        b=AEEqqOLl/glqsqDtx42Jth/bTKVzxe2Tmby4ioHBJt+HHngigWGGylh9Vl/77U7ZR0
         h2rdSn7+/ymCVNshSbtOrNQS6Iv/E00TvlcLadOwI0cXxLA0E0jpx0cz5WX4gAtaW2Gs
         uz1lUFynblVMXlpYeLY8J7faqqufPvann4R3nV4BqLpbWGAEZph8wZJAsZqUBUixEI/M
         wgHrenVFsmlAeNeUSAzM+LJ5efOOhZ4gP+6KHekto7wjoPk1OJgXAPDEr+M1qtf8FgJv
         tqBHR54p7q78joy0Saxzclka3Pn/sXyVtr29SOiRIZL4I7r/vYP3E0INpcUdb5MKK9M7
         Ygww==
X-Forwarded-Encrypted: i=1; AJvYcCVVI2XOtRW69PO3EPyA4n+lIzpZVDyp5gDuAzEqNiurunJi8yAwEyYmv4uZ7Wo6KRStoAo+Z70otVLvi/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ITBGzKQmwlLgxuQ48of3rm8KbbwmL25xjjBXUylb/waAhE1c
	PSrWhqqIrt/cz8a+J3D1xQEmmv+gjmwqGOHqCsWUKRkvs62KDp9c4G9H
X-Gm-Gg: ASbGncubLMvSws++yPdNOpH/Aqk0i4qXUpq+15NvRulHI7xKuQxkrLLMKvsuGheCnvR
	BIlrah8W8R1JEGAuIX/uqcaAqzDiGlxEe7WTrIawbysyf9sXWtoJ6p3jYLsH+MkiEGhGnffrKEA
	Srta1gso2SC6nI1jHPAqisePavbrrVFU4Jy83rYco5P2IsrL+TwiJOUOu/gq4TT9aLgefxizcLO
	JqMT8B4+lzLKZyGRChh9cm0pPRvwI+ox+VRL73OMI4seML4gdxOtPXTCximLD03XLvFUlcvVHES
	xugNKxwQmdOAr2ljHB4GphJawaDABcKbpsF66/35gJVI/huj3rftRZbGQ71b/FaOIfXkKtDoCkE
	xSQNOlAxo1TsQh076GeXXn+JNZS83P8kJBw==
X-Google-Smtp-Source: AGHT+IFJ1rRDpXsPA9YCL8l0EWD+58Yjjmif63b5LRsrQ/1I8d8chjdc2aDkNwuW8YpU4by6LeMYJg==
X-Received: by 2002:a05:6000:2c01:b0:3b8:d4ad:6af0 with SMTP id ffacd0b85a97d-3b917f14e1amr2584215f8f.40.1755098986682;
        Wed, 13 Aug 2025 08:29:46 -0700 (PDT)
Received: from localhost ([45.10.155.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469319sm47053385f8f.54.2025.08.13.08.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:29:46 -0700 (PDT)
Message-ID: <7d5f84c8-a339-4dd9-a0e2-eb6c769bda7a@gmail.com>
Date: Wed, 13 Aug 2025 17:29:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 0/5] net: add local address bind support to
 vxlan and geneve
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, dsahern@kernel.org,
 shuah@kernel.org, daniel@iogearbox.net, jacob.e.keller@intel.com,
 razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
 martin.lau@kernel.org, linux-kernel@vger.kernel.org
References: <20250812125155.3808-1-richardbgobert@gmail.com>
 <aJxaDxt9T83r03J7@shredder>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <aJxaDxt9T83r03J7@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
> On Tue, Aug 12, 2025 at 02:51:50PM +0200, Richard Gobert wrote:
>> Currently, vxlan sockets are always bound to 0.0.0.0. For security, it is
>> better to bind to the specific interface on which traffic is expected.
> 
> s/interface/address/ ?

Sure, will change in v6.

