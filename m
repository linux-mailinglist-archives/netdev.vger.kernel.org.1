Return-Path: <netdev+bounces-186310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4007EA9E280
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 12:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C3018986EE
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400E61CAA85;
	Sun, 27 Apr 2025 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkF81ZG4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC220FA9E;
	Sun, 27 Apr 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745750812; cv=none; b=rh/24wAdxW3SdHMeFM4O9Tn0ZFZPX0H0FStoOW0nATIdQRRUfti6uY8kJyEsAix8xPv7hznYE0puNkOwyExU8M1u1aX9bR3/9qMP4H5iTcEU/dZkyxg5sSXbd9/rBfQ+ZeUBTy8q+xH/aDMpGnD3PyqVegIOBQVF7VJ7cvlfm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745750812; c=relaxed/simple;
	bh=89oIJurDleZCWMcum9C/95n6oPTTVUoE7SRYjQXQAa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hd7dWvU6GVyp6eJuT+yuOO/MRTWnyfVfqfzyR63nnimtkFlS3zC2gveO/Eowj3+LijQ/Fv4T+Ubc4RYmM9+69ztIlTh+gCvyOtKDnJrdD8vmMmYP+KhThvFRdYjeQ3rqjqbg9xGK07WvTQrP7NoLLoBRS+9oA493OFBOGD8gGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkF81ZG4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39149bccb69so3396147f8f.2;
        Sun, 27 Apr 2025 03:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745750809; x=1746355609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfYdI2QMrU/YgMx02oqGgwewbVMGDLfbMn9txjVQQQU=;
        b=GkF81ZG4qlPcRbBlVDX/nMk3+4KJEgg1OncNZWCI/kmSOT5LDomQrftMyXBVZzwYSq
         8rKL0y6ApFnRzzM9AS8GO5DkKUfTFdxLGIATOrLPAqeT036WLKLMWsZxmtG1/QEpY72F
         Pcn07JjSSHgQJ1AFvQFCNQNjbht3b3EKrGGeip+XxEqYwDRP+yN+7WOJ8SPBrlh6x8Od
         A8N64o6kxyRf/32GMTu1SkF17Cit0jV4RbdnYjOUm741Iqzs0xe2hrMNOU+RLkaSq5rA
         MQ14YdF74DlbLNHlfn7U9d39zzjlu2tLwHgc68guU9Y7bIyzb0uGNmldXCuMJMQcF67a
         0rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745750809; x=1746355609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfYdI2QMrU/YgMx02oqGgwewbVMGDLfbMn9txjVQQQU=;
        b=O5xIEo6TmGFOukfBj1nGSU7c1x4rmy61kXpQzUqXleucuB7bjjpVbbh7ls+GkM0i0I
         nf6KFZjhKKcVL5iA07MGETKCMcHUd8KX4g7DmBqo3WsDTPNVHuWCW6zDXiwI8aEYINMg
         kOtaXutfhiXYVSl1geJiwSviLcVUfugXJFKlKd7XsUiv0zzRJde67hEvDplao4I/b+a0
         YeXqOFFZ1xGtrhDyvuH1dn8RpibQl8tD2IMz6f9Of3u0DPkvOBQeBizMCU+FzVMpKbJB
         aUyEI4j1mC2+rAivATn0AasY8iGURcHTqIVAGRQuwGYz/qbhsJY3AYb0fPjlkaVjyksv
         jQBA==
X-Forwarded-Encrypted: i=1; AJvYcCV1yEBwRjgYDm+wrT+oCYX51ehdjr+ycc+R+1Uk2xwEv5aXQUj1fiZIvNg2GLq+LHEk5H1deRve9YnnFUo=@vger.kernel.org, AJvYcCXmukdCfGcPuR9EXGD3VJxIOambZcEkMZa8m7hYuWbRduB2hO/uF/0g5zvh4nC86Gau+J7FUtSi@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXz+tFl/fW5wTXUpJ5UppyGjdLstQGxYEQPPmDZSxpNeXC/k8
	lEbR+ENLWU/3xRGH1nOUzU1R5KEJTnBRbEMSim9hmOBpJBeMhTU1
X-Gm-Gg: ASbGncv4JBe91ZOgUMwcRcPTlp48oN1aRIOwls0xXeQDb/mVaP9wq7mDzuFOq4a9dTe
	R0M2/j1jeMXwoSyrfL0BKVA4LqMsQv28zfwZ+A53zksyXQ35a5S5vr8+787debi89Nvnu3HFmqB
	FfP7scgFLx9JKmwDtK0e4Vl7rA4vWbStc5kZpkqN+2OhZq75+0c9dte/22UYXhfI/+bgCC4Ju1S
	ujZZVmTIokeG+FbHpylpqAW5LgosT95k6dg4+Us6Gz6QkMJYTyeTxTy4YS5zInfGNhAAugMQch4
	zjFoKWBB82wIYg7ad+NeYFqTJR5H6zVy1BqbcDMUToaTryhik5ILMT8OB66mH07NaYxjPF9VpcW
	nh9g=
X-Google-Smtp-Source: AGHT+IEgHTgWsgiR2ymodQy5ZCXcHYIbCWocVJl7Q/IZ42e7Ck55BBEMJdI0HemvJEaz6hEQyi3AVw==
X-Received: by 2002:a05:6000:2283:b0:39c:f0d:9146 with SMTP id ffacd0b85a97d-3a074f11d7fmr6620694f8f.45.1745750808505;
        Sun, 27 Apr 2025 03:46:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e464eesm8071840f8f.68.2025.04.27.03.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 03:46:47 -0700 (PDT)
Date: Sun, 27 Apr 2025 11:46:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <horms@kernel.org>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net v2 3/3] rtase: Fix a type error in min_t
Message-ID: <20250427114646.4253b39d@pumpkin>
In-Reply-To: <20250416124534.30167-4-justinlai0215@realtek.com>
References: <20250416124534.30167-1-justinlai0215@realtek.com>
	<20250416124534.30167-4-justinlai0215@realtek.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 20:45:34 +0800
Justin Lai <justinlai0215@realtek.com> wrote:

> Fix a type error in min_t.

NAK, in particular u16 is likely to be buggy
Consider what would happen if RTBASE_MITI_MAX_PKT_NUM was 65536.
(Yes, I know that isn't the intent of the code...)

As pointed out earlier using min() shouldn't generate a compile warning
and won't mask off significant bits.

Also I think it isn't a bug in any sense because the two functions
have a single caller that passes a constant.

	David


> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 55b8d3666153..bc856fb3d6f3 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1923,7 +1923,7 @@ static u16 rtase_calc_time_mitigation(u32 time_us)
>  	u8 msb, time_count, time_unit;
>  	u16 int_miti;
>  
> -	time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
> +	time_us = min_t(u32, time_us, RTASE_MITI_MAX_TIME);
>  
>  	if (time_us > RTASE_MITI_TIME_COUNT_MASK) {
>  		msb = fls(time_us);
> @@ -1945,7 +1945,7 @@ static u16 rtase_calc_packet_num_mitigation(u16 pkt_num)
>  	u8 msb, pkt_num_count, pkt_num_unit;
>  	u16 int_miti;
>  
> -	pkt_num = min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
> +	pkt_num = min_t(u16, pkt_num, RTASE_MITI_MAX_PKT_NUM);
>  
>  	if (pkt_num > 60) {
>  		pkt_num_unit = RTASE_MITI_MAX_PKT_NUM_IDX;


