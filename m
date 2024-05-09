Return-Path: <netdev+bounces-94782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897638C0A6F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 06:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8C31C20DC5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279CA1487C7;
	Thu,  9 May 2024 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc34M4sF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F31487E3
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 04:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715228634; cv=none; b=hSBPTI4P1fc9utMGIeFLhGXC4UE7TRiQT9sdKYesDiBt+Yku9mWnai1ASvxXgwOgOOCcd/kZS+DFRiY5OcEoLr8bvmkQmCUwS1YRDg0KBjwbqb5eJLNOFhuOnf7WNNasrRNmdU+8E24Un9HLntB0ZU38uJWVC2WAD9rLPWIhQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715228634; c=relaxed/simple;
	bh=6OFUMUhSmwMoJwB51578TSO2L/7cQW+OTPZJuxMq05o=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kkYGt1rk0k6x6I2LTsSFM8gZtc0BAbX5tTC/ImMu6wpM5NBmBQb9y0gCFQBxs4x2KnSE3TBC+3mySJRYKnNSK413qs486Zdav2FctgmdU3CIMSv4l4qG7OKC0mMA8Y8smOi5RkyNqWVZJQUf1Zky09Y+P1fgK4oEntDJgYwH42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc34M4sF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b516b36acfso125055a91.2
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 21:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715228625; x=1715833425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhKWM9z1T6xr1z3zM6wWSWG9CZBIm2fQpDjA9/7/O3o=;
        b=jc34M4sFa89oL036GfgToBOsRihw4zI+GMDCY97aCbOfrngwdgevA5Nm84FCYJyoPU
         xT8Us/LP7gbZ9lts3dy6sSCQewZqMkeAwfBwjGKTfgmLG0H31u9Hyk3K3OXsUu0DQ93Q
         hX5siH63YfyDmkzBkAeBLIEPeuVo5IfMwrKFBQPggvE6YM1bCR3fui3kIZaMkNBuuBqb
         IPtWxFK+TuPgeCMZFZnu3rX54cjSHH/bZE2AQOa/r3RKalIQ9fWVcKTL9i1L41oT1RGu
         1E3yXlcUciSunQybbNDq4ubvoOys0gvN+yNHBNCqDe1X97nEAo/TzHxxCEAOA4TFQCIv
         OXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715228625; x=1715833425;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JhKWM9z1T6xr1z3zM6wWSWG9CZBIm2fQpDjA9/7/O3o=;
        b=aXwqLyvdLcJP2LsNugTm9sBwTFZOD8mVFsasBrJhghyiyY2SFJfE7PAut90Dee/n4w
         6RH6TpMpqlWMGjISDttqMylcio2OW7bKyWjSCeGcvTYcnt80Y+al7GDYBHr+tpvw5q1L
         FhZArHmzUwm5vQu9u/JCvwTWWgsI/0kQaLjF1vgKw1Oh2j3cxEdbu6vy3O6V4GsfAz01
         9p+L+qHDC/tdqJrXPHfiooNyjSK5EOWhd6HKydEJwWb6mOS9IUlzO6dtbmLVhJM0DhDL
         pBNHQbBOL4zqJeCRSaWpVnPYbBDwueAuecOWAqu2Be+FUbUh8ra5oDWTImmAU8zGzSam
         1/FA==
X-Gm-Message-State: AOJu0Yw4tyYIFMnsW3PwmzABU2wYLHROMAhLhtsDU56R8IPnvIrI50Xb
	Zk0mt9H0rghAqGLrz8l1/0BzqGwaAWcNStGH3vXxztkcWsrMr+bb
X-Google-Smtp-Source: AGHT+IEzS509rmQCuaYUTh/1+pPEiPcFJDklxOzo9vj6SUU59kTdW4ZCFZdVxH0N/hDwN+V+fEwYtg==
X-Received: by 2002:a17:90b:90c:b0:2af:6b92:ff6a with SMTP id 98e67ed59e1d1-2b616be542cmr4317107a91.3.1715228625244;
        Wed, 08 May 2024 21:23:45 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a270sm2273804a91.11.2024.05.08.21.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 21:23:44 -0700 (PDT)
Date: Thu, 09 May 2024 13:23:41 +0900 (JST)
Message-Id: <20240509.132341.474491799593158015.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us,
 horms@kernel.org, fujita.tomonori@gmail.com
Subject: Re: [PATCH net-next v4 6/6] net: tn40xx: add PHYLIB support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240508.221851.1563324062182870165.fujita.tomonori@gmail.com>
References: <20240501230552.53185-7-fujita.tomonori@gmail.com>
	<7bd09ce5-5844-4836-a044-c507f65c051d@lunn.ch>
	<20240508.221851.1563324062182870165.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 08 May 2024 22:18:51 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

>>>  		priv->link = 0;
>>>  		if (priv->link_loop_cnt++ > TN40_LINK_LOOP_MAX) {
>>>  			/* MAC reset */
>>>  			tn40_set_link_speed(priv, 0);
>>> +			tn40_set_link_speed(priv, priv->speed);
>>>  			priv->link_loop_cnt = 0;
>> 
>> This should move into the link_down callback.
> 
> I'll try phylink callbacks to see if they would work. 

I found that the link_down callback doesn't work well for the MAC
reset above.

Currently, when TN40_REG_MAC_LNK_STAT register tells that the link is
off, the driver configures the MAC to generate an interrupt
periodically; tn40_write_reg(priv, 0x5150, 1000000) is called in
tn40_link_changed().

Eventually, the counter is over TN40_LINK_LOOP_MAX and then the driver
executes the MAC reset. Without the MAC reset, the NIC will not work.

The link_down callback is called only when the link becomes down so it
can't be used to trigger the MAC reset.

