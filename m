Return-Path: <netdev+bounces-141934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E729BCB6C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E5C1F21A36
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF761D27A9;
	Tue,  5 Nov 2024 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaqLRMSH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A9192582
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805349; cv=none; b=mQxrFW0F1cT48bdZnZDgy7930WDN2yODPexU3BmqrWr9TUjJXajkS8ixXPNMGK/D4PdnhiTdNcnN5VvAS5xbLFjWYWzU0F7jg7N7uZrGkqTIC2B+XcCSS0vBqLrlEy65OsUe9K5kl+lh9351adW47/9KxD6SGWCnvJwPcwmMY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805349; c=relaxed/simple;
	bh=Qmpq8ltap2OKqE33MH4Bs8XjoolNmnk0/NbcRdvsbXg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=TTRxV2v38GovoQXNpB874FMNeWQXIg8AGLWvfXEndcHECKDlAJBjjoVTyQq8T7PH8fW8kUMomwYVJdU/5tG1fxtAS18KLsRk9sYf66desCsne/Z0lmhiYF58C+kv35bCmO/gfWz5iglJR+Jyn542gdnUdNVqSh0zvg6WjtQA5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaqLRMSH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so43489475e9.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 03:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730805347; x=1731410147; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PnEP8RR0o2uUp6yXcVtAGkcnRyCqg4+04NJsoxL2vNQ=;
        b=CaqLRMSHeov7TPgMi3O0nqGC4NT0HwI16a4CiK0GrwflA3LfGVGkqLnYPL8SLKigic
         pdW5DmWHpclFiZeLxlcNe0QdIoKLAtDuy5MYiC6qIoMghUni8an9w192HgjZYXUIsmkH
         zLpiEzjbzXPsJBfpEuyudwgodbFRUrTe2ynUc2t5dhiuKW79j88Z3/gqFFVBFJ0/rr4G
         w0Z1T+RMwe29La2p2hl2Zlg1drtiUbAPUYPXpBmy05Ts7dQ7ZGdNeCDNIq78eJI5ym5/
         8rGSPSf+5nK/CAMeYdWtXYkIMrhHL7gzlZEANqzT/rxcyPPuwSuj0kjLS75Iey3rKGXF
         vaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805347; x=1731410147;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnEP8RR0o2uUp6yXcVtAGkcnRyCqg4+04NJsoxL2vNQ=;
        b=uyqFMi63A2B5wsFrlH2p16q5j/Ud9Bi7+zg7dW0w0cNWyyz6ZjLFiMuA/Vjv1ChQvT
         fIEmWRfpRHiE4Iq6wogkdVC8UYv5OpwfhxG7WqGgmEz4mOYS/qGcG/5tLbIB3jiBotEp
         Tsou/e4uVTkS5wFKG3iKgdkwPYoErP6VSKfD5xJWA8PbwEOXVvdNUwjzb1q700R2M78J
         3GCu9eDZsmxX86Ncv5v/HHIW/nKmje3PcpEfkDU8QbCOi9zkb/TwRKfItggzNL8pdBau
         X9LpO44iDM6jghzHGxNhtB7a3K/BmWDAof6TIGo843hVylSae2KTM9lEKomr0dohPO7R
         WcTQ==
X-Gm-Message-State: AOJu0YxFv+IbFfz69ryjeh2qFbn39lEkRiNaCaRzIZQs5o7PGx44yKY8
	qabUJyCdyi1oaOMKBmkdrBuzPdRN7JZFBspid6m6qKRHE2Z4Bb4h
X-Google-Smtp-Source: AGHT+IEy3P4GmZVAYram46JLC4woVJVufKm9vdEIlXjb20S6tVva+jvXV1eVuPNnU1hq9UrBwXu3lQ==
X-Received: by 2002:a05:600c:1614:b0:431:44aa:ee2e with SMTP id 5b1f17b1804b1-431aa7ff3acmr259313965e9.4.1730805346590;
        Tue, 05 Nov 2024 03:15:46 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e89b:101d:ffaa:c8dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d15sm16073720f8f.8.2024.11.05.03.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:15:46 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  donald.hunter@redhat.com,  gnault@redhat.com
Subject: Re: [PATCH net-next v1 2/2] netlink: specs: Add a spec for FIB rule
 management
In-Reply-To: <ZykRRvZ-lvfEz_EG@shredder> (Ido Schimmel's message of "Mon, 4
	Nov 2024 20:24:06 +0200")
Date: Tue, 05 Nov 2024 11:06:06 +0000
Message-ID: <m234k6vt29.fsf@gmail.com>
References: <20241104165352.19696-1-donald.hunter@gmail.com>
	<20241104165352.19696-3-donald.hunter@gmail.com>
	<ZykRRvZ-lvfEz_EG@shredder>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ido Schimmel <idosch@idosch.org> writes:

>
> Donald,
>
> We added a new DSCP attribute in the last release. Can you please
> include it in the spec? Tested the following diff [1].
>
> Thanks!
>
> [1]

Good catch, thanks! Diff applied for v2.

> diff --git a/Documentation/netlink/specs/rt_rule.yaml b/Documentation/netlink/specs/rt_rule.yaml
> index 736bcdb25738..8d1a594e851d 100644
> --- a/Documentation/netlink/specs/rt_rule.yaml
> +++ b/Documentation/netlink/specs/rt_rule.yaml
> @@ -169,6 +169,9 @@ attribute-sets:
>          name: dport-range
>          type: binary
>          struct: fib-rule-port-range
> +      -
> +        name: dscp
> +        type: u8
>  
>  operations:
>    enum-model: directional
> @@ -199,6 +202,7 @@ operations:
>              - ip-proto
>              - sport-range
>              - dport-range
> +            - dscp
>      -
>        name: newrule-ntf
>        doc: Notify a rule creation

