Return-Path: <netdev+bounces-77920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D28873778
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 14:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C4B2839DC
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF08130AD5;
	Wed,  6 Mar 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoEEqVzI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB6130ACE
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730718; cv=none; b=jsYWnLtyQY0R0ULZmKScDx0kwMAlrDEbpWc95umZmsBuYhlvLCgOarnsQ7hueT5ItzT8/XczuG8YHU5cxQRb/Ypraq2ghaEgzlZo3UIcCYjVmd+f/tC5NLxYJJzULjDDrypndabDWJW8Zms5jaCiEL0yWhiAgVWicrQbjUZaQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730718; c=relaxed/simple;
	bh=MyTGXpauDDIZTdqFSLaDAMUyVwzwMH+DjckyXC51ekM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaxco6uatJaRORJHbfA0QsqP2NTN9dCRfKoKttH06m7/dhzALAT7WCUrEey1gYMC4hxjcEphhVfvTAhtiS9LDhecmiFkXbRu3Ep8Zta14o0NiSldAbPtdOwPLU7h7XQUx6r1BYGPsR5QdtNnwrAc1Qqi9O2ebUwZrD9ljA10fMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BoEEqVzI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412f62ee005so4539695e9.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 05:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709730715; x=1710335515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyTGXpauDDIZTdqFSLaDAMUyVwzwMH+DjckyXC51ekM=;
        b=BoEEqVzIOe9XRhyr4tf05D+P524uMC7da9JyV4jr9jnsRuNQ0MwcjnYBK/VvORDs2y
         f1QYn9D92ebeLHj51Im1v7W+mC3UEwr6YvGLw7vLyr/Hs+YMc7fbGQVQJEqcD2zh/kgh
         0bb5tEpUP/hSpsGKzCmIcHx3tn/EdS0bMBDUWn42O/RwbieslkjmY0UMQcnsejwFrUDG
         F/8rspFScPrjBlBVgg2Ahl4OWE2LUKuTtVBThS44OpI3n1IaNOTTFjDGbyxALLoxppBc
         5esi8RgAcNVADgmtbK7btpgfOVq49K4EPwY5J/RLBmyrxplAjvmgkpoHp7hC5mO30Ouw
         Arbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730715; x=1710335515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyTGXpauDDIZTdqFSLaDAMUyVwzwMH+DjckyXC51ekM=;
        b=uJB7pd344w1EunhOfoLm4L5+PRYcwEluidiPOLAX+9aMY24RKSb9HNzWY+dwK0LKJJ
         u6raeLsoDI55Wo+ACy0oki0YFdy0QL7/tLphBwsc6BpiVi1E22kHd86LQwc3NUFBxM8z
         uaJMhIbjsctV1jf4TwCnV3p7HLX/8zI5TKwge+yu+DKP4MczM9UF9aVC5YDKMWJVNBc3
         dLMScw8kk0fWSKGQqNtHu6S2ZWAautJF6rtaws8i5FMwCn3LeRSjv2xjdlIlSwHjp6YH
         am8fwoGkDwyTf6RZW282OC32IC1CiZDv2Sp2lc3YustPMjYEV6rcO3bi6Iflwx35s3Rx
         OCBA==
X-Gm-Message-State: AOJu0YwXoon8pbGSFVahnUhRCQfVkwYi7bWEf2nD0vRjwpRiHL5+fBOW
	UGnmcLPUFwsHyjb9qK0tBt7m8xZcVTYmDT6y6KXDH/h1yGhdcKjbCAItxql6BB8=
X-Google-Smtp-Source: AGHT+IF7GO5OA0PwwnZlztd2sD5oTPcfPYFSjiOysQ7OV1tc5Un35e4UOQF1ZoMQigMLjOkAajbh4Q==
X-Received: by 2002:a05:600c:1994:b0:412:c9f5:c36b with SMTP id t20-20020a05600c199400b00412c9f5c36bmr10889040wmq.30.1709730714883;
        Wed, 06 Mar 2024 05:11:54 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c451000b00412ee12d4absm4658320wmo.31.2024.03.06.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:11:54 -0800 (PST)
Date: Wed, 6 Mar 2024 16:11:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hsr: Provide RedBox support
Message-ID: <4c03d94a-948f-4a72-accc-0326a1c332f3@moroto.mountain>
References: <20240306123826.235109-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306123826.235109-1-lukma@denx.de>

You still forgot to add the interlink port to hsr_del_ports().

regards,
dan carpenter


