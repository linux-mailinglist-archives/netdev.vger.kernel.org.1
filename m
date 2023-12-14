Return-Path: <netdev+bounces-57335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21811812E4B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1636282570
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DED14120D;
	Thu, 14 Dec 2023 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpRUkU+v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68360118
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:49 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bfd8d5c77so9223923e87.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552367; x=1703157167; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yV+H1iUcW23IJbiepd3475zmIxfPgIm3FP/Cq0IRb3k=;
        b=hpRUkU+v+AJekPum5viWv7gdwRp5WK/KLi4geu9gclY8OlP7fZW5nwR9dzZkeAKr1b
         DFxkjF+PT0OEGfjT3skQUBgqQAmKArg4mgMuT3byinmXvllos5GhTFvGtvAAubVEnQy/
         sLj7vC3DEvwYMEXpeGoFnw5r++aTcxbpEUJvwbqN4G7bUtVBDdIvB0NVMUL8DVSGHvUn
         kYWvzTyNMs8pfQB3VLqaHF1/PtrWgRz2hW5zn014XZILdclRcNjVbpjkSMyy4bUAbfx9
         BM1QIw2jgRLRRVoc3kwyn2j/j3U/isE7p+eNHJnh9zX/auiUnSU6BdcbIdnoSeeystLV
         B57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552367; x=1703157167;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV+H1iUcW23IJbiepd3475zmIxfPgIm3FP/Cq0IRb3k=;
        b=FM5kNIVmnOJkm+0Sl7WmBUCUm69/5w4pOmRPxQhdyxpPAAat3Nzh07N0jxvttsuBwV
         Bq7j772HJBwuQqpJHAMbZRF6E3GWpjHPq0qlOxv+vVEtQCpJjjhSiu6XhVrK4UEyOOYV
         1etnXDh+EarSUjR5FabM9MHL1jO6XNLnXx+KE5NDGZ1k3C1T68QBy2Vhb4TAQIoi1/Li
         5CZm7KQhN4hinkxfHCdbMpJZC+FarYi9w0zXHYH1omEaVJnI65YFY01hcNVOTtoPS94B
         e+rrC6tv4PBUCWBI68K78TMgs1vkSYuSYcDL4/mbEBGcJyFpdflcwPLwpIg0ufHAydra
         NlLA==
X-Gm-Message-State: AOJu0YzX4JxrMAfWQ1PBIIUXzIQ6JihOrm71iE3Opnw43BbpEA7RrJFu
	vf4R1B02HcTv0KQyXxeB9Ck=
X-Google-Smtp-Source: AGHT+IFgF+YJIpl3xRRUoR9ZZ7+I00SSKdiPAWYEMCmqMkNHvxPPE33sfVokuZw8DJ3QzxO1toxHCw==
X-Received: by 2002:a05:6512:750:b0:50e:1680:83ed with SMTP id c16-20020a056512075000b0050e168083edmr243852lfs.84.1702552367433;
        Thu, 14 Dec 2023 03:12:47 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id d9-20020adfef89000000b0033342978c93sm15743138wro.30.2023.12.14.03.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:46 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  nicolas.dichtel@6wind.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 6/8] tools: ynl-gen: re-sort ignoring recursive
 nests
In-Reply-To: <20231213231432.2944749-7-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:14:30 -0800")
Date: Thu, 14 Dec 2023 11:12:13 +0000
Message-ID: <m2le9x3unm.fsf@gmail.com>
References: <20231213231432.2944749-1-kuba@kernel.org>
	<20231213231432.2944749-7-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We try to keep the structures and helpers "topologically sorted",
> to avoid forward declarations. When recursive nests are at play
> we need to sort twice, because structs which end up being marked
> as recursive will get a full set of forward declarations, so we
> should ignore them for the purpose of sorting.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

