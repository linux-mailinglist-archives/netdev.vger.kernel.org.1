Return-Path: <netdev+bounces-53030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4E2801233
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24A21F20C73
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724394EB2D;
	Fri,  1 Dec 2023 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yeru570v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110AA12A
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701453917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QnLRP+rHS2RqlJuua+HIfj0D3jwT5nHmopztNQ4aPBA=;
	b=Yeru570velAEUDxTTM4J6I3VAG7vZ7fVLLBdMOD9nKNj2P9lzh4iFFaoIXx3PqAEK0DA94
	BVIM9p8+zlK8AuSfEULIfjigUrHlJOlLDVJks7jtCQlN4vKJWvRxoxGnuYrIFVZuY7OVdQ
	1HL+42T49AcsO9/hc451oN4sGWEmB5w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-TZT9iVFgMWKbHszeMSM1oA-1; Fri, 01 Dec 2023 13:05:15 -0500
X-MC-Unique: TZT9iVFgMWKbHszeMSM1oA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54b7e11013bso1714835a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453914; x=1702058714;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnLRP+rHS2RqlJuua+HIfj0D3jwT5nHmopztNQ4aPBA=;
        b=iiYPvQZnA/NuIF9MloH7VLdIK9FhETZupJj3ZUvmKKtrsOUwdUOThwRXzJXXkgYDgg
         n5+mtSdZWCp00xXWfSK8dwzm4RMXE6vCNtqFhHBcG/Bi3Yk+2FmNt4UQAwNFJp+V2LZy
         zKUTeOPgyclZnEncztEKym25uCaTpPHNnqIMqzF1so7U0QE3FQWl8WbjJc5pBxL1UsOL
         /S2ywTBgWMOpTkwZb/XXEJxZnilStbugTTnWiHaPU4KeiNaI2J1K3ZRJmLuTUaK63+8h
         6pbTfzRv671aSVd/tIT6Chd8dCsNzjcQuwrFZkqx85BOvGjeaW7qDZmN3Pb6oXayUjFP
         rHJA==
X-Gm-Message-State: AOJu0YwncYL1+KXZFYPANccqJX3D1dYEpQfhFV/BkUC15Im9ut1Um2TR
	yzamGl/oy2crjznxQS4TIZc7irtNo3kPOyVoqRf0E8vP5wzAmfDhVW7oVcESBS485/vhmNdkSCP
	ddUkoIzWAynwEMl7P8GlX1EYgrDY52duYjePUWnm/
X-Received: by 2002:a50:bb44:0:b0:54c:4837:7d39 with SMTP id y62-20020a50bb44000000b0054c48377d39mr688740ede.120.1701453914234;
        Fri, 01 Dec 2023 10:05:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE79EM7om4xFKyq7DC6WnXnNnI005l+IA57J2EJWmk87WU2wZbb8Er4SbwI9QoZdTuH4IG5PG+mK9cwAS8TV30=
X-Received: by 2002:a50:bb44:0:b0:54c:4837:7d39 with SMTP id
 y62-20020a50bb44000000b0054c48377d39mr688723ede.120.1701453913589; Fri, 01
 Dec 2023 10:05:13 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Dec 2023 10:05:12 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20231201175015.214214-1-pctammela@mojatatu.com> <20231201175015.214214-4-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231201175015.214214-4-pctammela@mojatatu.com>
Date: Fri, 1 Dec 2023 10:05:12 -0800
Message-ID: <CALnP8ZaVt6swzFY_aa_FTigA=SHKQDMERDS4398yDcUjYBTYKA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] net/sched: act_api: stop loop over ops
 array on NULL in tcf_action_init
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 01, 2023 at 02:50:14PM -0300, Pedro Tammela wrote:
> -	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
> -		if (ops[i])
> -			module_put(ops[i]->owner);
> -	}
> +	for (i = 0; i < TCA_ACT_MAX_PRIO && ops[i]; i++)
> +		module_put(ops[i]->owner);
>  	return err;

Seems you thought it would have been an abuse to use
tcf_act_for_each_action() here as well, which I can understand.


