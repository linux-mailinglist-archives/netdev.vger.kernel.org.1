Return-Path: <netdev+bounces-103452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6D59081CD
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 04:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639891F21C2D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 02:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C9E183083;
	Fri, 14 Jun 2024 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db4vAFJT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A87181D13
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332988; cv=none; b=qp9cFQc/GxJTln53WOtMVNbWWNGjwhwsuBfesIeNQHYKqBw/bGGEjYWJL+IiSv7In8UIOcWUQQI8uxB12Rjg0UVwI2RLDmg5pDjc7V5u5i43cEHC6K8vspwLNSnDjyqmw/Qqm0M2npwEUnYwFI03iMQZJ60ZF6RH0SwFOM8vxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332988; c=relaxed/simple;
	bh=MifZ4DhUPbvDFUbSsQTONtPEw2jhS26matJ6cIUiCdg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q3Ba0Rxf8d1JyK6U6bUgPedi6QOa5uqwueNzhRgI5PwWv6B6pbkUGBt5Xb/NFvmq234G7r2YIYEyBOK/oYrfttIUPBxssew0mPKxU6q/eZ7owZIm8/5bf+eE+UAXPatNel9wTl6JolgtpmtMcYxd8QNJhDNxcQfNtwFKaiRPYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db4vAFJT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c2c1473f73so278751a91.3
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718332986; x=1718937786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBTRqf40LfEGN5vHQ/vfM9lJgNNTCQL0HfEIdi1WsoQ=;
        b=db4vAFJTcdYfkAYkFAK2uFbqgZV3GXYRCxqS76Eh28w51UFFjTPSdHcFz+WXYwPsx6
         ORJFVvE9j9LcsTzFmnlr9j55X8p3eA1O5smvu/oj0JU/r5vOpRdM24wGZ/2Ks3E4ZfvY
         cU6cLdXby5eqECoKboeZBR+e8Wprpie9R16wG9vRPIhnUvh7qSJW+lZo5aniiVYbzHTo
         p/pGCvMhMMCRhszFG9I+QjMRJTAJCS3RDQzvBp0IPHr7xiUCLaPHpKOWwbRmlU1sVMW8
         rZTdIY/0yGFMHV6v0NYw48mgbebteMkD1Dua7wn/pyhldHf/wXFDH8XugbYafMrRxhVV
         WYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718332986; x=1718937786;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wBTRqf40LfEGN5vHQ/vfM9lJgNNTCQL0HfEIdi1WsoQ=;
        b=tihFyS/pN9WuAT/8b+eA2PEJpkFSW8wp26I73sH0kd4GhOCYgZ9D6x1GM7tC59217+
         KUZjgciaUuaaXX1WIztLqaNakNroNucwfd/7mmjA435QxJAh/OsE6MoGmonIgmK5ZHKj
         IJ/f88jh3vZPJueIT4m5AAvWAFWtM6FYhsfPHbGJSyLMho5XMPM2FlmxCEK1/zbWgOot
         gZnBJ4qXxbUcKW+qEqA2xuklUQosD6l8JP/EAT1Ifo6b4dHiOXauD0iqRsclHB03/bZb
         DU0VItv39PljrsDOhku0FesxTSmtya432bzB/II6M6XUcAMhB7T78632HP26Zd/uvXCk
         RYAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMvSRf3Por4ZyTJwBaFMKuGgZwdSR8b9n7gU6QwG08jZo1eusAjld45r345AgS/1fGfk2SsYGj7KpNtxJppzrkSE5AL4aa
X-Gm-Message-State: AOJu0YyRzRR3MAL1I5uGeK0vSM+3f4wkA61T46GYb0pixyNw/VGTk6ZM
	qgDSoQa/W1NoEMBGHGt7b9NqF4G8Vo0oMTuUjdOfuFmqTEzx+jlmS+hTiILr
X-Google-Smtp-Source: AGHT+IHW9WeYEorZgLaAdMBw+XYN5LVkk3SZ0yamiYLRwod1dyzggAX9vujB+055aBkKQMt9xs5vTA==
X-Received: by 2002:a17:90a:b116:b0:2c4:d7f3:faff with SMTP id 98e67ed59e1d1-2c4dbd3b776mr1589014a91.3.1718332986011;
        Thu, 13 Jun 2024 19:43:06 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45fa925sm2560037a91.29.2024.06.13.19.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 19:43:05 -0700 (PDT)
Date: Fri, 14 Jun 2024 11:43:01 +0900 (JST)
Message-Id: <20240614.114301.1799707546162462902.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240613173038.18b2a1ce@kernel.org>
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
	<20240611045217.78529-5-fujita.tomonori@gmail.com>
	<20240613173038.18b2a1ce@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 17:30:38 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 11 Jun 2024 13:52:14 +0900 FUJITA Tomonori wrote:
>> +static void tn40_init_txd_sizes(void)
>> +{
>> +	int i, lwords;
>> +
>> +	if (tn40_txd_sizes[0].bytes)
>> +		return;
>> +
>> +	/* 7 - is number of lwords in txd with one phys buffer
>> +	 * 3 - is number of lwords used for every additional phys buffer
>> +	 */
>> +	for (i = 0; i < TN40_MAX_PBL; i++) {
>> +		lwords = 7 + (i * 3);
>> +		if (lwords & 1)
>> +			lwords++;	/* pad it with 1 lword */
>> +		tn40_txd_sizes[i].qwords = lwords >> 1;
>> +		tn40_txd_sizes[i].bytes = lwords << 2;
>> +	}
>> +}
> 
> Since this initializes global data - you should do it in module init.
> Due to this you can't rely on module_pci_driver(), you gotta write
> the module init / exit functions by hand.

Indeed, I'll fix.

