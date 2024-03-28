Return-Path: <netdev+bounces-82923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9D7890326
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3A2293550
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28C712FB37;
	Thu, 28 Mar 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJbRTXkc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE44E12FB03
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640122; cv=none; b=IrOiWD/MyMFCrD8QV0h9zUMALqH0ATVEf2Tg3m99yLGMgKVt6QRVrSBO/sx45KVmr1ig02RMQNtgVkR/jcJK2blo99Bg+fdUaZYchf55o32pFuh3BmjNHlgf127+29oBJ+56cjOC0a1QCPV4fSzUmcuM1p8z1Cog8eHpNZCEIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640122; c=relaxed/simple;
	bh=wx7WG5GbsCTYhf3900yH3LirB2/rt1lI45ZHHP/hzl4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Kvpj2I3aW+pF8jo5VWzuFTquPCP63f20XbqFijQmH7gOhqrlYuafE7YsMBHe+KBpjWespqJ6+dxJweKT2XkdYytUc1bA9w4Wy0mkU+nxxBRD+T1Wz8q3tXnfg9a8V3MxezJ3UZxSnEjO2khF/GzOkRUoJEG/UvAfP52ifJAhr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJbRTXkc; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d23114b19dso14772321fa.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711640119; x=1712244919; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wx7WG5GbsCTYhf3900yH3LirB2/rt1lI45ZHHP/hzl4=;
        b=DJbRTXkcDmCiuQ4Gri+BTiyQ4q/Gq8lt8DQJ18b3si2x8ho98t1skXvkI+d70HYpGm
         aJn0WFz+nh/k2Kbf6YSP42Wgs5YOr+yiEAjiEYaO6b1GvmpdXn4JDoI9JQ2KzQxY4e6r
         h53WntUH/WCbM4NjT1nCkCYlUxrIKKUvJar2AYnffVBqYA1l/+qOWoax4LDdkANdAQfx
         UA/he8MlTQRoAPfajzLwBBVj9xVQk4yqM2hMx7V3H7dQIqwRg/cPXjC+KisrDFTGH0GA
         tcUzhu9ZSCKH9m9V2uy1vne45G0VwRP4whUczpAW/V6vLHJ83ef0tb4Cc3+5nsXg2uAg
         GuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711640119; x=1712244919;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wx7WG5GbsCTYhf3900yH3LirB2/rt1lI45ZHHP/hzl4=;
        b=qbznI9CsAiTiUq9MQaIyUq2XOITXw/eXitVWm8z5RvT1BX1WSMnNyZkg4YOXzlOKSD
         fwzTJgFoxy8+nFZtrrp0qv8BzR6foWZVTVe6B8O02lxjdhyvD1VYTeONHdjROn1QBBGH
         MTRH3wNyvZ1uYNVvDvV3GbGul7lfgSiqcuI90PO8Ou/z/P8KPTHnEWIeGMyF0sA++MVT
         0BnWP41bXWdU4dfQupB0VvwURa8otpQUkvesavwL7PU4g+uHZmIjwo7UL/AjIXR7WVj3
         4yAZOjmjaDLO62xggQnwzkkWpV2dYDkiB4jMjUvEa/eq0p3tiI42z9EMCss8FME4UQwL
         z4LQ==
X-Gm-Message-State: AOJu0Yw+WwU1n5pgTxpYwquzZQwY5cWK/Lym6XgJ28lklwEsR0RpUJdA
	kMpZUvKPsD1yu2jHwpSIMxfXG+7p8iT7Hs4OOnkZZRyxPznzvtMT
X-Google-Smtp-Source: AGHT+IFfkJeeQUh07kuRzzM/4d1OYVoHJbh/f34K1D1WXi/FBdgoBPMvW/35hel65Nx9qk9jxsB3AA==
X-Received: by 2002:a05:651c:a07:b0:2d4:522e:62f3 with SMTP id k7-20020a05651c0a0700b002d4522e62f3mr2532975ljq.44.1711640119144;
        Thu, 28 Mar 2024 08:35:19 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:7530:d5b0:adf6:d5c5])
        by smtp.gmail.com with ESMTPSA id h16-20020adff4d0000000b0033e72e104c5sm2021811wrp.34.2024.03.28.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:35:18 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Jacob Keller
 <jacob.e.keller@intel.com>,  Stanislav Fomichev <sdf@google.com>,
  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 0/2] netlink: Add nftables spec w/ multi
 messages
In-Reply-To: <ZgShpYf158Yc7ivH@calendula> (Pablo Neira Ayuso's message of
	"Wed, 27 Mar 2024 23:45:57 +0100")
Date: Thu, 28 Mar 2024 15:33:43 +0000
Message-ID: <m2o7ayjrqg.fsf@gmail.com>
References: <20240327181700.77940-1-donald.hunter@gmail.com>
	<ZgShpYf158Yc7ivH@calendula>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Neira Ayuso <pablo@netfilter.org> writes:

> Please, Cc netfilter-devel@vger.kernel.org for netfilter related stuff.

Okay, should I resend then?

