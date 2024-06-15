Return-Path: <netdev+bounces-103777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6973F90972A
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 11:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5931F2261F
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A9199B8;
	Sat, 15 Jun 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJgDH6TR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30F91429A
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718442136; cv=none; b=r+4UUDY2bsl0bWiHxDcx1ubv68Ri0VcPHamJnJ73xSUbPbl2Ii9XittoxBsZTRRLiptYjlVgRcbmg+k+PC1xBjdgnD+ww8o58t/mq3jlWDbxLxopk9QDJJxNttOA7HMiYdbLkXSQJM/NsGqEiP/xOB4jjBWzS2vkYmHuFmqgjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718442136; c=relaxed/simple;
	bh=e83Pd3E9cr4t1dmELOKfWbHwlvkzO7B5BM8qvmb5zKQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p4Lao9XZtizjT1ROdQsCX8f3Q2/Rqd9/+ytV2HLGUgtvXAQsI2C+pPRcU8Azq015fm+fHc7MV5x0qrsIt8AzQImgVzlvYKzN1PZBhuJUaoRtdtm6rgs67Czn4nsCyKKvYHL48Qq383z/XUUVk1DTetKykowV/FXAMEaWJpj/1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJgDH6TR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c1baf8ff31so549770a91.1
        for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 02:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718442134; x=1719046934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXvRWZLtvWP1sERUUqTRkTkej0eH4KfaicDkLn3ZlY4=;
        b=aJgDH6TREcIS1+Rgcy2kMSZRR73/uUYabQ7scJ2hzi520CI3ZdvdTUkqfMyOnoolqY
         l7yTiYJ9UlN4FFC0orLo9yNDCOZdVFEvJJ+fZQjfCpSN6OImQ5+Y2kKrEtyv1er+AnZX
         gKbF2M4s9ByK2g0KOcjVHxjv6URy3C1PpEr0TXoQRavny4Ua752VnHuVFM3bYbldWdjQ
         OukAcG7UdxgMHsSEAEHR9theThudBJhCEHPG6xwqNfr8F94Zwb0/4RBamnw5VDPaMScx
         u+l51ynmDhZ7qnBBF8uCo14Feb4eOITbwmr2m2JbHJ2e9mVNho57fUlTHnv7xx8yxb9B
         gTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718442134; x=1719046934;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jXvRWZLtvWP1sERUUqTRkTkej0eH4KfaicDkLn3ZlY4=;
        b=bnuHzF8GshiwyauiU/7Yp4piy7yQXqSbAaxwHCY7zOK7ABNeC4os7XQ1w6MBVfhGoK
         16uLGWwFzDQpPV67yguyyTDwBYmC9LDhfHMiTl8uQLPXJnlZucm/vQYOn5xx20ByP+K9
         jq6fSF+LWWKFptU9Pjw28IqVHBa3mfqIsN6C2DhxHuN/dJSS0eQTk0cmLiBHDKKf+Ep1
         26fdrvCzjjPrnYofy3JCxPw5E/Kt76FTcpOVJsgn/VACwPl4qGfVDhKJ6V570xHy/jdf
         JviQesRP5UaZCLA1N7K1ZOpZkNZ5EnVN5+fIKz7HFfFiV2hdpt8NyWMz23i4yyt/KCC+
         gIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbXQGLZ/EolD8sgAH7OPz+g+hn4RUK5o6o8PPRcSDm5ofuDM5o537oVZkTdj0gaMhsiSR/EbhJxm2YwYVyREu0OE6NC/7b
X-Gm-Message-State: AOJu0YyZJjKcZWWcQ+Ey/tKYJEZuqD/CpQP+q3vmz8u3j2ZFCiRvv05G
	tqNtj29HQyMsqbZwctJTzzRaPZBmcPbu2jR+tqJqYH8ppgQX5/1i
X-Google-Smtp-Source: AGHT+IEmvYlSQdwaCkctA1ei17OiWOCUD3y7h3e4RMOyBGjQXi+cKW6jxJQPZ0JED/xFxrLl7Wo+PA==
X-Received: by 2002:a17:903:1246:b0:1f2:ffbc:7156 with SMTP id d9443c01a7336-1f8625c6f31mr52597785ad.1.1718442134161;
        Sat, 15 Jun 2024 02:02:14 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f020b8sm45280535ad.197.2024.06.15.02.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 02:02:13 -0700 (PDT)
Date: Sat, 15 Jun 2024 18:02:09 +0900 (JST)
Message-Id: <20240615.180209.1799432003527929919.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: kuba@kernel.org, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 andrew@lunn.ch, horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <1ae2ddab-b6d2-499d-9aa1-3033c730bb87@gmx.net>
References: <20240611045217.78529-5-fujita.tomonori@gmail.com>
	<20240613173038.18b2a1ce@kernel.org>
	<1ae2ddab-b6d2-499d-9aa1-3033c730bb87@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 15 Jun 2024 09:44:31 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

>> On Tue, 11 Jun 2024 13:52:14 +0900 FUJITA Tomonori wrote:
>>> +static void tn40_init_txd_sizes(void)
>>> +{
>>> +	int i, lwords;
>>> +
>>> +	if (tn40_txd_sizes[0].bytes)
>>> +		return;
>>> +
>>> +	/* 7 - is number of lwords in txd with one phys buffer
>>> +	 * 3 - is number of lwords used for every additional phys buffer
>>> +	 */
>>> +	for (i = 0; i < TN40_MAX_PBL; i++) {
>>> +		lwords = 7 + (i * 3);
>>> +		if (lwords & 1)
>>> +			lwords++;	/* pad it with 1 lword */
>>> +		tn40_txd_sizes[i].qwords = lwords >> 1;
>>> +		tn40_txd_sizes[i].bytes = lwords << 2;
>>> +	}
>>> +}
>> Since this initializes global data - you should do it in module init.
>> Due to this you can't rely on module_pci_driver(), you gotta write
>> the module init / exit functions by hand.
> I would rather move tn40_txd_sizes into tn40_priv and initialize it at
> probe-time. Just thinking what will happen if there is more than one
> tn40 card in a computer. Then a driver-based global struct would lead
> to
> all sorts of problems.

The tn40_txd_sizes array is ready-only and the same values are used
for all TN40 cards? So no need to move it into the priv?

