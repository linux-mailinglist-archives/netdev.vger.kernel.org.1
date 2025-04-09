Return-Path: <netdev+bounces-180747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4BA8254E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2BD4623F2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246AC2620DE;
	Wed,  9 Apr 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtDkjdn8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EFA25DCE9
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203070; cv=none; b=juz1o1fX3ahxi6mfYhQfdpeFtc4PFR3RDXT9Gsz5kOeBGDTUiRxft+QtyMOUAUzvJ9Mb2Vehg+b8KE6JL3u/oryHYV80lw2UH1IqZa1iOl1wDXaSxTnGA0cg/UTkV80vzE8P2CcnIwRw5OU7N9R0dfiF9p/ZJAyZYvcNFb8qPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203070; c=relaxed/simple;
	bh=ivBWUmrBEsphlSTtAheA1QnzR4YPC/AttkoWuoi1SE0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Uyox+/nwN+4Q+Q2J8YugLW1YO1Twvsod//8v1p/cs2h5GR+MLwshJ7LSV9xGoczB5XLCmbSLOXIl2nSywYP5jfnqZcz4lwqDpRDYPiylFxaQodJno/801wkrxCd3LvyVy+DfJNruCt4eb7aZvfl2nkWvIenfEZt48VUq7U26ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtDkjdn8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso38912985e9.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203066; x=1744807866; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3epfHpJ5P/weLlmx6AU4L/pmmjFFyTJ+32AFgxhzdsU=;
        b=AtDkjdn89Jmm4CFZd8DYZtZCJl6k0c314HJO+VnLYew5viXO3t75Vd9/BUTSv3y6Dv
         HOR7+2JZgVo3T9ON13iE291YZ1tYv46hALwY8P70Kfo8TWkfu+AzKp3hsQggHljdAkZp
         xVlGqtvxo/T8PuNrGjRulokTyv7dU//MGoRBuSAkpRCOlMJMusfBAv4dCwufGsbY7t21
         6xIIzBBYsO+2spMtbtNTCmckqC/F+2n8U8SksTROuvTThB0CwBp3hUgshkgg3bhbMxfH
         mt4bRY/Ffu0V/crl7N/6RdkdPG543qn3jWr536K7qANF0Rf00q9oJZdppy15Gvn1K78B
         OQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203066; x=1744807866;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3epfHpJ5P/weLlmx6AU4L/pmmjFFyTJ+32AFgxhzdsU=;
        b=FPhijeICNUaZ8i0BR5qh/PMGPXbneDKvA8jMFsWl+/bSKTgOhV0avRU4KGPkddQzam
         JXV1ijSsve0MAkOA2PhF78RPIvF+ow18wW9Ob6HUM0qDHPqAm0K2W+1KvKfpApEQu2vS
         MmyPnIvP2tEKaSt/lPji8mBUquSy9GHr38Xko0nXhCSdj4KYk/1N/KfHuaGKq927Fhm4
         UlXk4IERM10JVihoYISLqzoGno+0z2BGRgqTsuvTr4ociekSSvoyk2h9JnMiL4OPeBX8
         jvcDKPd+VskpLCCCJeCfZvUg4DORACeefTYbrQAhHnM4PKC9rsBaFvf32DXrd/mIulW3
         P+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUVA0D8eyXdG5HcFUjcHJgPaxdAQ1abn0EvzksBXQMI3L+cEVdyxVypoyqimUv68IW4tAQdYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp6QUoUu3ObGmhvvTAsKqCUV7NZK9T/fX1yHNqyfvm18BreWRG
	WjhjFsdXVXDRgUKzgv+4pM+nHaAFIEEKF3n0pSR8W8XpJv7VdCYR
X-Gm-Gg: ASbGnctmTUKmIMb9xackhbhHZrwf8MDl59xa0wZmu/oJb4Wv4eBLnSRaN3dQVmi/McT
	WTqZV48zN/u9Dylh6RzTHXiEemL2A6QMPhe3y4XTfBooyT2j09fmFwk1qXgef4+U1GBopltRPgX
	j85U4yjRt7EYQySv/j94DhUURlgUACf1B94lp1Eaqa3JLjj2KhV2nxccEz1gk0PQDiUklNHfS31
	mtkobgg4Mq2rH/8lchymk9w0uJfG1ySsSAEQ7XO7/VVKnC6fjQM6BlvOZJV/4rH1jrkJb/xs2wJ
	FkauYABDVIFD+/YSEL6+fWdgWaRbYGGH7f4CpgkNhD7GjQWU6R8orw==
X-Google-Smtp-Source: AGHT+IGGlsGG5naSfAsFE8UMkhgFW9vGkZ+o5CHmdRXBDbY4UFlIzp0eWhBGVdfNGnwfeOaFZBf7Sw==
X-Received: by 2002:a05:600c:1d16:b0:43d:fa58:700e with SMTP id 5b1f17b1804b1-43f1ed6f12bmr21187375e9.33.1744203066308;
        Wed, 09 Apr 2025 05:51:06 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc8esm19038175e9.30.2025.04.09.05.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:05 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  yuyanghuang@google.com,  sdf@fomichev.me,
  gnault@redhat.com,  nicolas.dichtel@6wind.com,  petrm@nvidia.com
Subject: Re: [PATCH net-next 02/13] netlink: specs: rt-route: specify
 fixed-header at operations level
In-Reply-To: <20250409000400.492371-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 8 Apr 2025 17:03:49 -0700")
Date: Wed, 09 Apr 2025 13:16:46 +0100
Message-ID: <m21pu14jip.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The C codegen currently stores the fixed-header as part of family
> info, so it only supports one fixed-header type per spec. Luckily
> all rtm route message have the same fixed header so just move it up
> to the higher level.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/rt-route.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> index 292469c7d4b9..6fa3fa24305e 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
> @@ -245,12 +245,12 @@ protonum: 0
>  
>  operations:
>    enum-model: directional
> +  fixed-header: rtmsg

It's a cleaner spec this way too :)

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

