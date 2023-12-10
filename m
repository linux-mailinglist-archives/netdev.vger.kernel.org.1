Return-Path: <netdev+bounces-55610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235FC80BA7E
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27E91F20F9D
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E16883A;
	Sun, 10 Dec 2023 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bQ56ldLp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C59B99
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 03:50:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso5110784a12.2
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 03:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702208999; x=1702813799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqwLJ3RrYO3hk+Mdmp+YlcT6RMLst80h2mTyTavCCqE=;
        b=bQ56ldLp5y/2qTKrdaQbAdYmtVB6pZ+luLHCZdXcjp+OYGLzfL0X7xdJBe0Yn7mpku
         k4zYPO4pjTa5teCaVs1XZTlRnD97fj98YzyqHPJSwmj5yZ7Yvi5eTQrXDPLJ+kGBapi4
         JRKilfTLR+9EOiqpVQWr/+zYnavM8N66LqrMbkp+4AtZnXdUwDgrQqqaY7UsZ3/gqOSD
         NJJ6VZX7R+bQmyDboN8Z60gtVflWMaCKcXNm+qUvtFhYe2hIJaX+Fb8szbz86fDqUJcx
         ZChfpuGpxzaN9OS0ozVavibqyZCtPQ5e70DM4P2tN5Zj+WFsmB0vAh6v4JygNk0Ws2hj
         pwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702208999; x=1702813799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqwLJ3RrYO3hk+Mdmp+YlcT6RMLst80h2mTyTavCCqE=;
        b=cba6fIl+tvokNFXrg6SsWhAkpvXHpoi3S8Psd2EI/vA/YXJqYbnRmHW7c7dJ/c9luO
         RHEdwUlrdPZHI5NexrCK+ZHlitfZUEDSxQxbivML6wyEok9AyUk1klCx0NHJcT0G6d5R
         805RIp4j+usb2P8B4CN0Nqtp1vtIVb5/WvsMwVvkMXN0y090qUj3UZIEiNqEgu4eNlJV
         BaYKc33K3hiX+OreDDhbU0DevUr1q606TthrtXTpmP3ImEH4Pi6Q64Y0NvlKIk9uyvEC
         EDqyxDbskpJQHQ2x/G6Wn2tLrw8z3i/0UpKa1bU9GK6Pp9UsUoAFRvqBIeATvextFin+
         HhyQ==
X-Gm-Message-State: AOJu0YxfcDJzmCGiehvPGWz7QhpQYCvu18cKHPzEzU9Q+mneBT/e1ojL
	vyU+AGdjH8ZnBrxQCDNlnPT6xQ==
X-Google-Smtp-Source: AGHT+IFK+LjixYENp0kPg5aPkTzj/1CenJMuzPkmDXc4aDjC9sFPxQRStKMbwO6aC0uCTMCTqJgUwA==
X-Received: by 2002:a17:907:830a:b0:a19:11cd:fba3 with SMTP id mq10-20020a170907830a00b00a1911cdfba3mr1468944ejc.26.1702208998961;
        Sun, 10 Dec 2023 03:49:58 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id wb2-20020a170907d50200b00a19084099a4sm3352684ejc.16.2023.12.10.03.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 03:49:58 -0800 (PST)
Date: Sun, 10 Dec 2023 12:49:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, marcelo.leitner@gmail.com,
	vladbu@nvidia.com, horms@kernel.org
Subject: Re: [PATCH net-next v4 6/7] net/sched: cls_api: remove 'unicast'
 argument from delete notification
Message-ID: <ZXWl5Zqou3N6TzQX@nanopsycho>
References: <20231208192847.714940-1-pctammela@mojatatu.com>
 <20231208192847.714940-7-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208192847.714940-7-pctammela@mojatatu.com>

Fri, Dec 08, 2023 at 08:28:46PM CET, pctammela@mojatatu.com wrote:
>This argument is never called while set to true, so remove it as there's
>no need for it.
>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

