Return-Path: <netdev+bounces-210165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7B3B12379
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8403E17D240
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6340123D2BF;
	Fri, 25 Jul 2025 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDoP2bde"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1061FECAB;
	Fri, 25 Jul 2025 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466643; cv=none; b=BPfD7b+PzQhi+FQT1Urau2GPu491D38diiApD+oxrfElJZWUv7KqwHmVwIkV2IIxwq2hn62Vwr8k7E/HnmztMcEs5SWWiIAmxFX3m8DK4OZ+AntF76yf2JHzDEtCwV8C9SGhEvGgSDwjRsnzTQhvXTRGlveo1yGdK19yGWCNAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466643; c=relaxed/simple;
	bh=t1ElelA+AA/2eA0Ed3WXAKbt0xtm+gc2ukuMnnrTE0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8FjmgrSmJkL9HgvLGV0fNEC06eN3CDRcM7jcaHNjGlxsMvSL6yTYwrf8nHQVr5163nxIPI5PeaspwLb75d5hOHd2lW042/FqFefBC9GgKdaXxjHOmE8FDqq24tPhfbuMVzOgbRiTE0Ev/1ekeSJ/pfwTu0dDsvr5Ikz5dSK+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDoP2bde; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23602481460so25592495ad.0;
        Fri, 25 Jul 2025 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753466641; x=1754071441; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YiBSr+Y9I1a7gYBTBbf9MjCA23vsvTi18jLkmTr9ZuQ=;
        b=gDoP2bdezyy5ufmp9ZToEjiONrY6ILr6o/1fr50oScZoZInQZ3k2uQo8nPV4Oq5Vy0
         iKjLpzxenmDLUiZdeHgHSsJlrqYNc81FpAHyBPMUaGzsIYQL4NAnvw3/Bof/E2XWJelu
         E/1THo33X1RNPKVO5VoHR6wGl6YhHk1Ty1Oc8SQZD5+POyK0awnHBEt6lWK4vLu7jJXi
         ZacrFvNVoDNdeEf3xRRISnEwSTf68JMeAl69b1L6I0AFgR/ny+TrfGQeflHIp/YIef/B
         8rSrrjQuVudqYgG3Zn6uOg3Zh2wHQpK0vvZybOYKzu3I2/ZgBK5VlM/yQA9QWoEEnHHI
         UxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466641; x=1754071441;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YiBSr+Y9I1a7gYBTBbf9MjCA23vsvTi18jLkmTr9ZuQ=;
        b=mK5nASL69tv6AjixNBhX6WXx9FXcnp9mWaWOvbZuObYxXUc8LEFTztm5WmpGB/wo3f
         oduKnLGlwDqo8NvI+xOJl/Zxb9SEGeP9mfRxOEt0quCnVyrKkJlWr/ngVkZpyU4xgZ7a
         X2ty6gxGQEy3MzyCOD3N8EuIi2l08fJ3QmCYdHxj90j0EVURcXAIqkK0NSvEZnv5wUFf
         if2YlI6/vHhBVjvjggTfgNqYsfqdliUz+jMppqHjUFQyoNrbjNkxJpgHCHlvu9JwYO5r
         Ew8KsXWbULN1jTu7a8d0WeUu16SyBoCeaVEWxDn8w/rrcoBAm3Vn4UK9DygrNvbZPf0g
         Y3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUmCLqPTPPGbLvXuNKogAYOf/S2NPDUA33JsJHp2tjSIGwKIqZzKigPpladIV8VHhNcrULgq/E7@vger.kernel.org, AJvYcCXIngND36vMLS3GxXnwxFrF4wl0MVH++HQ83+H0pGz/QMCYRaYXo70+snzQBZkofVnU3ZnS7euoRsqgBAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UXhlvGq8G6ofKprK3FR2a0UGD9S+Fnk7q7+j4ndoGNFj7cox
	w+O278S9WNvmkDx9WPB9IakVJ8hcvHtWbglDCQxRPZp6YEfn1PxfvkFm
X-Gm-Gg: ASbGncvsBWHdzmk5Zky94FGd4rF6CjySTXYYsPmoosdIPDBdMkw+vq/R+ckkpu5tGA7
	6g9fBp/20X3G4pEavn3weCThSvU948NpbxX3V8MbU2XRdOheUIWfXVj8SBRhRlKLifGmx8zBeuL
	oU+kr60SAf7J+Q1jOPsjjEHrMYEzdDNmGjx3TzWazOszM9epP9q9LfSVslxHxrhUt8xlB85PyXH
	3xyIUNwVhvkGLCQ9BxJpPDyRaMfrhpI3NMcwr0ofFtg+lalxMg1ZeEc+UKRJmpkuSHlCb17OJBf
	mL+/Z9DeiZnky0TvZQO1J5KYQlNCWnlzRKoZalQAMIrYygYEyj2FzsNsvbVt2MI/hD/kU6AmpBx
	eJTE1EyuBVOmAn3m4pEs57RwASQ==
X-Google-Smtp-Source: AGHT+IFWBHpa1pjnELupSorF8h9dbYaDoUC9qL1FEZ/Kp948tO4ShFFH+LE0kHus4iTgvDF+HlM1YA==
X-Received: by 2002:a17:903:1a87:b0:225:abd2:5e4b with SMTP id d9443c01a7336-23fb3084dc6mr41756345ad.16.1753466641192;
        Fri, 25 Jul 2025 11:04:01 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe512cafsm2018095ad.124.2025.07.25.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:04:00 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:03:59 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Maher Azzouzi <maherazz04@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Ferenc Fejes <fejes@inf.elte.hu>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] net/sched: mqprio: fix stack out-of-bounds write in
 tc entry parsing
Message-ID: <aIPHD7Ktk8Q2kyrL@pop-os.localdomain>
References: <20250722155121.440969-1-maherazz04@gmail.com>
 <20250723125521.GA2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723125521.GA2459@horms.kernel.org>

On Wed, Jul 23, 2025 at 01:55:21PM +0100, Simon Horman wrote:
> + Ferenc and Vladimir
> 
> On Tue, Jul 22, 2025 at 04:51:21PM +0100, Maher Azzouzi wrote:
> > From: MaherAzzouzi <maherazz04@gmail.com>
> 
> nit: space between your names please
> 
> > 
> > TCA_MQPRIO_TC_ENTRY_INDEX is validated using
> > NLA_POLICY_MAX(NLA_U32, TC_QOPT_MAX_QUEUE), which allows the value
> > TC_QOPT_MAX_QUEUE (16). This leads to a 4-byte out-of-bounds stack write in
> > the fp[] array, which only has room for 16 elements (0–15).
> > 
> > Fix this by changing the policy to allow only up to TC_QOPT_MAX_QUEUE - 1.
> > 
> > Fixes: f62af20bed2d ("net/sched: mqprio: allow per-TC user input of FP adminStatus")
> > Reported-by: Maher Azzouzi <maherazz04@gmail.com>
> 
> I don't think there is any need to include a Reported-by tag if
> you are also the patch author.

+1

> 
> > Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>
> 
> I agree with your analysis and that this is a good fix.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>


Thanks for the patch.

