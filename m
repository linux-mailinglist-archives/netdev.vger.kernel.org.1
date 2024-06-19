Return-Path: <netdev+bounces-104841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C590EA44
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9EF282C77
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2790D76035;
	Wed, 19 Jun 2024 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuJb/2u9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F176FC1F
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798448; cv=none; b=ZYV8HGvAhulr6d1cwe0ubCUFHxDUK+vQB/pkZNmwQASwVHF8Ol9bSB6bEO9dQ0BkJCfoDbFdex8oZwruvfaa2hdbpzy7+sY4lGuzd+AQoFLzz9ot+8I1KpzjMOcbJFV92ej8w5WkTXId2ZBN5Krt3gG+j7BuKaxQQCZXlOCcZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798448; c=relaxed/simple;
	bh=CaCiBEXQdoRfQozFJkV7i3gBXKCGfycqeLD21CG6BQU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=szG0lNPd9KFaYzn3p7VCUxuiXIAcuHqGD01rdsCHXl3pum/fTEWo7RNRrQqok3WKTvZxQn+3Vnk+Y1ikowOgKjRnbTPQJhXyXdCv7Mzwg9hKG1rJZAKvAcZsJhoGaEeO2FL34QD3m3N+l5J++UDFKKapw2CZTWeTOZbu6lK2hXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuJb/2u9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42121d27861so50662625e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718798445; x=1719403245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydYCUOOP0TR1rAsG4YbdF5EVXvhJbRg6BsZpw1YJkRY=;
        b=PuJb/2u9WJDftJwRHqQHJJnQfjfFY+NO9pknVvXYnZk7OGYyJE+SL+Zd0Qfbpje7WZ
         Rqpj2T9Pn68oLagataZZhaPRvtoDJ9TMwo82fC7f5C8EMD8RLMrVUaTgZ4fu/SEeUhD7
         yCG3PX0A5gkwBBs1nHtoGH4/7JbU1beH2vJD0NDyw423YQxRRgaDfgTs/e8sVCqqguBX
         FTLJv+QgzQmPJEs1Q7HnWxpRaMIHj/7XDFoLIW5cqxumhGGLJUJIep/E3AHOoC/n4zUa
         1VuYbgY+9gSAd+HdlWOWsDQ6OShc8TxVE1LDxId0NZGj5zUAh3/Fi2mMDO1C4jhQqiHv
         Ty1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798445; x=1719403245;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydYCUOOP0TR1rAsG4YbdF5EVXvhJbRg6BsZpw1YJkRY=;
        b=bJga4eY+E4ul1qt/3xSjPpCh3eXlu/1zzXG7EYvxJBgCjdbCKi1vbx1hoEcKMlGz9L
         O+L+Y6UTjbCif892jAHjgRkzNd4NKyflXcIiBUSL7gG3Fn4P4NG3xGNKefVkoilDMdLn
         AYzQVozq67L8WQwcXPpamyk5WErHE02ulwK3N2uycQ04WF4z3s4hFEPS/lu3mv/vuUAI
         6RXZ82J6nvJzglKIfljzR89sYbWYM0zZzDWaqdCs8fpOdh842lk8B9rLdvlZywdnGrma
         El3eWiP1UtSfedQtGbfB3IpO+ayBjwTkROaK+e7gY4b+lrcUu+sc6qfscr7af5FJwNx8
         OfbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/2p5yOLWzwnUPIpaMMZcp8Ek1CcIGX1EH4BsROoCxkzaSezMed09Yl+yqUMuS6P6QaBu6bxLOY/38Ncap0tG7USSh9XCf
X-Gm-Message-State: AOJu0YxQHa3FUx4jz+GWU8RNGeQzr/3jHWaLn7tWliczm9daX8rPf+O1
	2ONM6A7vk3fWGdslP0iGBqY61ZTv4VxLo/LHvwZ+lwpBLVLf8Ram
X-Google-Smtp-Source: AGHT+IGNtpQUZivgOnlTEMN48L4V1kiyxrr3jUPUOwIjSfF/G8IgU+8G23DyUGCCE6xdevV5j3y2ww==
X-Received: by 2002:a05:6000:9:b0:35f:1b73:1d83 with SMTP id ffacd0b85a97d-363170ec81cmr1668401f8f.4.1718798444659;
        Wed, 19 Jun 2024 05:00:44 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3641788cf4fsm504729f8f.90.2024.06.19.05.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 05:00:44 -0700 (PDT)
Subject: Re: [PATCH v5 net-next 0/7] ethtool: track custom RSS contexts in the
 core
To: Jakub Kicinski <kuba@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.com, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 sudheer.mogilappagari@intel.com, jdamato@fastly.com, mw@semihalf.com,
 linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
 jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
 <20240618171947.4f85e6da@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <c9de6c4a-add3-f76e-76c9-ca6a82b048b8@gmail.com>
Date: Wed, 19 Jun 2024 13:00:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240618171947.4f85e6da@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 19/06/2024 01:19, Jakub Kicinski wrote:
> I'll take a stab at bnxt conversion tomorrow. Do you have any tests 
> or should I try to produce some as well?

I don't have any tests, no; that would be great.

-ed

