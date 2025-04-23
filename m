Return-Path: <netdev+bounces-185101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBDAA98843
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F063B6653
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E66F26D4CC;
	Wed, 23 Apr 2025 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uTTjZ0vn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0126B099
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745406792; cv=none; b=MuU8XHDxzHQEXDVyjI/4gb/NfKRPeKEwyoWS0VDyje0fiY/bG3xXtluYSs2rURCmnydmSwjVX2Y99C2eN8i1Hm47Rev6tW+oIVhUHeRo3LvyR5Kg6cIQAM85Wk70mPIMGXnYfpP110fkbipOKh/h+/6bNrpTDESg/kQ2ZRzee6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745406792; c=relaxed/simple;
	bh=z8RrRdhcUjbqoX2RuDxs8KBckaz1DBpRIM7v6Ptanlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKa5SKQxDCNEBSEfcZLX4X1QDQjeOrbrwexvBocUtrzbo24vYaIH7qpT/CmLSjcHuvH5vq+kuL8Oq9Py/4c7JRhvT5UzUtZ5B7w12paKgEBPPJ2XUKUt627Gxu+KDCJQ0jjxzyHMz+JBJQU54t3NpfFHBqPNBws9oNKhSIq7kcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uTTjZ0vn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so57301755e9.3
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745406788; x=1746011588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9GFYx8qJoY9CCSncpYAexU3+mJqhwMWqryfmBNBNc6Y=;
        b=uTTjZ0vn7ARxZG7NJbdjLbUTyTtVgAAzfZnn583+ubWwh2O0DgprEg/JL5IWYfi4BO
         Tbn2O2C+Ih5e0Iah5Eo0Jc6U6drBakfOf12sj0wKJw9g+ZBvCnANy0JwLM6djdqbSnbL
         P7LTytFMxCOmk83GK/XOSwJ7BS/zObvo3IKocAIC0b8ze5r/Jwx/Huff9nrgY/sInyaZ
         RafHKX494WeYdA0PclgTLjnYFwnqq5QGezg0YstIIi5PceG+t92KTEXH4S1ffS1kw0X5
         jISJyobsbe4CMmKKDxVxmjDkwJLTNmPV3ufKFCZr5bndk43LYbw7JEq4sAeNEdEJIscH
         lvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745406788; x=1746011588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GFYx8qJoY9CCSncpYAexU3+mJqhwMWqryfmBNBNc6Y=;
        b=s5FpMN4NiI2IM9hTGkUr/nqdabWr4OkCI6Mxk8lX2dZpo8vaFoqNGqB/ouGD1zp/p8
         3eNjirfQtXlir7FjVxfARl3AOP+TZtawk/mTLtKw375u+HNh12Zl1gp8Hwre+rIHHyZr
         HyHtNJa5SzP/Z3CIMCU9bx7/E13DAZjvQ0DiZVaRM7uvis/Kw0kD4Z7gKgPuqjM+zC1v
         aaAwbf+PbYaLhtwQwRYhm8dvjEiKwVvVAc/KWEnmK3QOsriHAB42JJljZ0lDs470m/9L
         RdSw/IaR+y+BbVoAz1VrG3gVNTpJTBCDA7bE9IH0RMdE/CuPndCCeou0L49o19NQRufN
         yiPg==
X-Forwarded-Encrypted: i=1; AJvYcCW9NLMyk4T7TaJyT8iWrIawRK7qDP/3auSo/h87Flu5cLkZxKLW0WHOo1Cg7nxmYoPvz+t167c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHpJ6VOzwxbSYEt7f6ChcumPWkokPphKH2cKgDV+34JBNublNN
	MsrEEkXUPVQtpVsWRq8GQUgx4FTpARggflqN0hVsD/JzvKUZy+X0udlL0V+yxkA=
X-Gm-Gg: ASbGnctF7pXxqBeldXYntBV/OEvaQoqxJbpRPWdTJQrrAH3P+qeBfYiC4byi6rNxid+
	CscBP6P+pezYI+ZjKiulZePt/peTvZ5rLEHyU7LN7ooHF9DDGo9f7uoEd1aKoxYDIQgYdP7PjDj
	oj8ut7MAY6oVQlmO7in/dSEKgCzQMSUuvDDBZ8tmiWosYPDMfbcDT2Ie9PiUIaa4h0RYy+TgSr0
	4roNIXbD8RBqKz0wa53qBQi3VE03ROdvL8cYJ5hWrOULoCOk5Y94yKilweZJwFTUJmXSwd7jZFX
	oqbIw+kzAKCQI55UdbtmLesDY5ss/bkT81DhWh/M9eed6iQ0
X-Google-Smtp-Source: AGHT+IFHPTkvj4iEwYE+xPPfxMeMcssmSayZZR5ZNZvZNHdFY0ipox3EK9e2j/CLTZBuJV3YFtarIA==
X-Received: by 2002:a05:600c:54ce:b0:43d:fa59:bced with SMTP id 5b1f17b1804b1-4406d831a7dmr100998465e9.32.1745406787383;
        Wed, 23 Apr 2025 04:13:07 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4332b2sm18736491f8f.30.2025.04.23.04.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 04:13:06 -0700 (PDT)
Date: Wed, 23 Apr 2025 13:12:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V2 01/14] devlink: define enum for attr types of
 dynamic attributes
Message-ID: <ccwchffn6gtsy7ek4dhdqaxlbch4mptjqaqmh43a3rk7uu6dxu@jfua3hr6zxvw>
References: <20250414195959.1375031-1-saeed@kernel.org>
 <20250414195959.1375031-2-saeed@kernel.org>
 <20250416180826.6d536702@kernel.org>
 <bctzge47tevxcbbawe7kvbzlygimyxstqiqpptfc63o67g4slc@jenow3ls7fgz>
 <20250418170803.5afa2ddf@kernel.org>
 <v6p7dcbtka6juf2ibero7ivimuhfbxs37uf5qihjbq4un4bdm6@ofdo34scswqq>
 <20250422075524.3bef2b46@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422075524.3bef2b46@kernel.org>

Tue, Apr 22, 2025 at 04:55:24PM +0200, kuba@kernel.org wrote:
>On Tue, 22 Apr 2025 11:14:36 +0200 Jiri Pirko wrote:
>> >Ugh, I thought enum netlink_attribute_type matches the values :|
>> >And user space uses MNL_ types.
>> >
>> >Please don't invent _DYN_ATTR at least. Why not PARAM_TYPE ?  
>> 
>> Because it is used for both params and health reporters (fmsg).
>
>I see. Still, a better name is needed. "Dynamic" sounds too positive,
>and the construct is a dead end and a misunderstanding of netlink.

VAR_ATTR? Any other suggestion?

>
>Coincidentally - you added it to the YNL spec but didn't set it for 
>the attrs that carry the values of the enum.

True. Will drop it.

