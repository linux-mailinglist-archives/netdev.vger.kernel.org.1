Return-Path: <netdev+bounces-68099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D77845D4C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4361F2182E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7DC7E0F4;
	Thu,  1 Feb 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpdjrV9u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC06118
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805073; cv=none; b=FuIUm0gvpYifMCPpIZRy6kmx6KJswyFt959OsfL5wre2AL+ssFsOLxuBfbvOk2Xo/tD2IjIly2ltBsMF8y5dUCVEUxYDvg5JvfnGmP1oga9j1eesXuCGWNpJKdVC4Q+6ozkbS4jU9nm2caD741e/68OI3UAyDAwWDFpdVsNMToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805073; c=relaxed/simple;
	bh=z4p0eUtzSH2+zOajb45y1qhbg1vRFA8eBXjCuzvj7JI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=DtmlcRGkNkAMDhMe0tLxQ3ijTyXu+jHL1e7Mxsp/ySYG1CtwvouZwHJa9g7f44br7rHpCeD2jMFw0lUwueEhUBdNGT1u/BuakV4aCf7eJTV/P69PkoWDj/rYwp6ZWfd5xbVOVCxNJLQa2vyB4oFvcpeMNWza4p+Q4zy3SeVszRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpdjrV9u; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51025cafb51so1786841e87.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 08:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706805069; x=1707409869; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4p0eUtzSH2+zOajb45y1qhbg1vRFA8eBXjCuzvj7JI=;
        b=cpdjrV9uuuSRslCd5tCGwId4cyEmW88GNBiTTJms9FBnZ8lhL/zpjCOSRe+pGqNwmp
         kzhOq6nHhong60AY1DOI/v65iN71JphVw1BLMh7UL0/TyBJs5GKUMt6siFs+eurc/5Je
         J9tLaEi9QHAQGlsbcsj9BFQCKr171gstbYqkXLL+MdIKP2T+EeKhyFlmDt33TeUpq2pe
         L50NtPz/ruibhWpFQAjWnafNapXe/Wc5Cxy2vC1NbbIhnBBD8g/VTCHRrWjKWxo+TljM
         AVZJAp185f8nL0O+0dEoUb7fc84240EFR0QfLzeoZ8T6pGWslrH2xWqp2f3NXA1xjc0b
         Ms1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706805069; x=1707409869;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4p0eUtzSH2+zOajb45y1qhbg1vRFA8eBXjCuzvj7JI=;
        b=VFVUb1Ux0ZChi6gnW4nEzbhuoQbtDY1LDrbsd6GUwX/ljQX2mPIdTJJeaKMcqEX39s
         /wG4mNGLb2pZTVq0Phkf11XTKoX77wJRuqra9YM1Rpy/aZ7L77JqdMDGr11/llY7H226
         5xG1h/JPNRWTiCz8bUsekxdbs+D0yghC54nwoQG0sxj8dqdjhM/O/I0iYlxq7d9wkQKg
         FC99uCIDZ6y1CHSe5OSQR79i15vkub9AOKzpLoAclE7GYi6WFDjnxmUMZQK/RJBrVJKx
         MlROM8sYK5Di5HkMcproiIixH/uPAm9aDJUjnpdorXDbAhNIuTJ589JKYK0zojAujvx/
         2F0g==
X-Gm-Message-State: AOJu0YxGVIyf2d6NVc74Dow1JD0ustCn2rblnWN9wJviTxmK0ilvHQ4P
	fFNziozLP51v4uOiVUNnBshBQQrgnmKHpWoEzR/D4v8bRPZkSwGDAjP9aoRoUsA=
X-Google-Smtp-Source: AGHT+IEFTeQiqcqkOLK89BuL/CWZiGMU1+WJxgiIGekePkkU17f+jlhVMGSTZY3AJ0RTWcrH8742aA==
X-Received: by 2002:a19:7019:0:b0:511:313c:d248 with SMTP id h25-20020a197019000000b00511313cd248mr1363306lfc.42.1706805069055;
        Thu, 01 Feb 2024 08:31:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWosr3w5k/tFJzkVS0vBAZ0kHZhsH0Qmoi9Ty92qw7XXKmqRVStyxLfuN+7bhcFA3BKaSb/mzrB7GrbQDrXaAgNLx0IHSgZnNMBt9KtceHX3a8pB8mE5qeahR7A00+nUcd8s98uFZqKwcwpIxL+3XtAH2L4UutL/r+SF2CXlM+XC1AD+VpYM168xJ3EeCuO4JsZF69gzyKrpY7WX9nUQZLrvciVbKMfQI96xgjR4f/3yO27wYsegLnyEiDuOzNDz/3y/KWWWjhK/bzSyR7WvV6P5FUKODMkGZCekBtHM3LndrLq/u8iPwY=
Received: from imac ([2a02:8010:60a0:0:e4de:af88:4153:20eb])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c444800b0040e54f15d3dsm4926353wmn.31.2024.02.01.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:31:08 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  sdf@google.com,  chuck.lever@oracle.com,
  lorenzo@kernel.org,  jacob.e.keller@intel.com,  jiri@resnulli.us,
  netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/3] doc: netlink: specs: tc: add multi-attr
 to tc-taprio-sched-entry
In-Reply-To: <e14fc185dff74792aec4323249137a2d397d2ecc.1706800192.git.alessandromarcolini99@gmail.com>
	(Alessandro Marcolini's message of "Thu, 1 Feb 2024 16:12:50 +0100")
Date: Thu, 01 Feb 2024 15:48:10 +0000
Message-ID: <m2r0hwuqx1.fsf@gmail.com>
References: <cover.1706800192.git.alessandromarcolini99@gmail.com>
	<e14fc185dff74792aec4323249137a2d397d2ecc.1706800192.git.alessandromarcolini99@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:

> Add multi-attr attribute to tc-taprio-sched-entry to specify multiple
> entries.
>
> Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

