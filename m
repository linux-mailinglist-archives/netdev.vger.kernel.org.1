Return-Path: <netdev+bounces-119298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A883E95517B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4B01C229FA
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106331C3F10;
	Fri, 16 Aug 2024 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iExN2Aj7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE678C7D
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836536; cv=none; b=AiXEqmyiIXz94HkG6D645KOWnIvBB/cmayapWMM+2CYhC0ccj9yMEyHvlDeYFbhCLvNOi1bp3QZtRBkKkpnlzgoNKODtXHRZgNwY1ZuJ9l8sGk/jd5hyqH5UFa7tq+/1xZjohNl+cUAc9f4ZP1dSe/ca5CY7YXfdaNA+dhGBY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836536; c=relaxed/simple;
	bh=eHo2KIaiz/IW/6nXwJXjlcPyUjEb8STBdSua7wg8eFA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PCW7BMqpUTLylCTOf1W6/miB4mussXCh8eW8Jstwd6yhS7JblCvO/nX21Ibjk4OPM676TEf1bmuGvNKSPAf0fLPuVxCOKyZh8TIYz0NDvz6pbd4BruvjeTodHPIjnTXVjjzilWy/2Z88uAPDV3kPKxVQKu3OE5YuuJQ+50Gwf2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iExN2Aj7; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-49291b02e20so905158137.2
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723836533; x=1724441333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beM9g99hn88evPQH+Fc6TptJ0os3Myc738yYGRWfGQM=;
        b=iExN2Aj7fZZCtsHT2dlPKlD/9CfbHrdJuXmLCMqy1++VHUHWmzp0YkyfmsxjdaK2Dc
         n4n6UWucJ0yp4LeSwU3GhuyTT7eO/H3zdnpAoJhQGiU1zuqtPSx5MY2koQQx/bZH+PQW
         DmrAbKOeKY9yfOMJsaOkUJF3Fx2/0QJ+hJ0Vj7mK4JrJOupWh85PNZdt5WYHVjP29LyE
         jjUsn6PgL388LYFxwlwS3QtqW0nlzT0lIC6yLLEDz9q/Xwms8l0LQQFLIypWuKW62ybe
         exZlP29PBos359thRJCHnNsrp0ccrOVd6SvEFz0PK7tYfjgMdO3Z2bkXzPa25U1Xd/bz
         bjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723836533; x=1724441333;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=beM9g99hn88evPQH+Fc6TptJ0os3Myc738yYGRWfGQM=;
        b=pXWG8CNDTJ3kpECVO4XoxPM0Pz5bz9rYtXd6DyxTzXGQJu0DJHYZROhcLfTvAqZ1UC
         BHyzZIbs8st7o22o9a2TCDWJ0B9zTRPtsPA8qYFe/JSToiz9pFz3N2XKvzkGiPGSjdPl
         SHA+QervbQeJL22EHYHr93+1I/ToI9ainAZtK0A01XeYUKDes2wR7+z9uavDzLGgwY2F
         cRh7KnM0dC3k5mv7kJ0jbvBOYtnW+6skVDguSNtmGR2PeMSJGOf+1XrxXG1eNwbaCPw+
         UV8pjDvl/HBjNVzl2uQZagtY8uRqSs4UuTTBVQ8ohZ9tEUTCw922+axyITPcxxUoD/Vi
         9PPw==
X-Forwarded-Encrypted: i=1; AJvYcCXPwSTsxP7ogrJidC7GHAu+bESzoUpLkHI+5aSvhFlyRrOHJngyimCGnoGWd1nNSXkhkvMKu2pP9JEsYk3QjHvzmV2lCIrD
X-Gm-Message-State: AOJu0YwtcxiIydNYReIbmrJh9LOJP72HErkAv34pNxiGxKIvVA5KO+a1
	oNt7/naW96t/k/U34epF/X3bdaXZuqLGXy3Z0GiLLM15Lf7x1078
X-Google-Smtp-Source: AGHT+IHptX8a5rWt+2JuIvQ34JS7Ui2hI+GCU1m4x0MXsHcs6J3V8r7VF5HKGW/U50KipXIFrexYuQ==
X-Received: by 2002:a67:fb45:0:b0:494:5a0b:7164 with SMTP id ada2fe7eead31-497799e66cdmr4310370137.23.1723836533404;
        Fri, 16 Aug 2024 12:28:53 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e53d8sm208998885a.85.2024.08.16.12.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:28:52 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:28:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io, 
 willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66bfa8747e389_189fc82946e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240815214527.2100137-13-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
 <20240815214527.2100137-13-tom@herbertland.com>
Subject: Re: [PATCH net-next v2 12/12] flow_dissector: Add case in ipproto
 switch for NEXTHDR_NONE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> Protocol number 59 (no-next-header) means nothing follows the
> IP header, break out of the flow dissector loop on
> FLOW_DISSECT_RET_OUT_GOOD when encountered in a packet
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

