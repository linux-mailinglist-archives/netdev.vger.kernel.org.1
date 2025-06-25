Return-Path: <netdev+bounces-201054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A5CAE7EE1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477373A58F8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E929ACCB;
	Wed, 25 Jun 2025 10:15:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9CA284B41
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846531; cv=none; b=mno8rWoA/srfLvcmocaToUUwDGvojU/i0d6hc3YTiS4qSg9rhBTridQEVWbABhdSlmbxJQ9IewqMQZ4BQ6JjGWTlZcdrxkaYIhO/Je1YVHzXkGdYBlpwg7c1x/3geXAYyFUrK71h4Bb4JIfNid66BJX9+FlSbybQCuIT567kQzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846531; c=relaxed/simple;
	bh=FIF8iTq1d4GjW1WpCcb7UiabgcwCEx7BEqw0LZg7exw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qiUIQNBeEJ5KlrnKp0aCkxq7SGYbcec6BOyoDDx6k6KUdDtuy8uToeOHiPuVFmHthE8ohyHURdpq+pvaDiT/Hwt/sJV4KOt1FWtBtXts+jW/5wwcRIbeywB0+A9P7aH0UsNUS2Fsu4BrhkAkItHTxTiiBuZtUZPJRJ6I/VKkyEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so1533838a12.1
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846527; x=1751451327;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbbPsk6SB4SWs1hUs3Mmb5Fa6L1piD+p6EaFsc2Xey8=;
        b=dwqwiYBKSPUZ4wD9TblxP7l+yPsx0PZ3/0uLgYhByROdeF7BgMYiVMwt09VNa3iPll
         QlkmFUyTl+CF0bm4PiOgfcAbfSL/hOWzIq/WXV4V3F8LFRNPyuUP1/w7i5PnGsY5kMuo
         BatrTmMVjwEbW5veimAsGSUBbHrpzKCO8+pu7Drxtqe7cU4Kx58NZqBjo+jsOyg72goT
         BcWOK0aoxmwMuxJSCwz2Kglf6Qf9BJ6iEGj7XBQnL2XhSvhYHsyWlIImj7MSzUvJgyPT
         /3/id0rqf83A6kwRsllCHb2Hp1xG8ELvz7uF3gJpEo6g5E5SaBnzKinSeC5JX5nkiTvL
         lqMg==
X-Forwarded-Encrypted: i=1; AJvYcCWYb86pFfGSEXyCsNm0Kt79ySUQdR9ZGWRUnW28CBqYVg93ijwOHmkLbhEbl679egOIEOtV5M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVX4BENguKv/hiZNDY6xK4l9/gxQOMUn3VpZsqWIHXCFqutcDs
	8szgjLMRIbtuXxlKGpDdjpFgBlmU+YPlxeFx2UhKRSC5cKkgStIL3HWG
X-Gm-Gg: ASbGncvnQnf+qb9uXrgJqjwCu8qDWnBRLzNTdCX+VJaBAXpJxZdZXzP9KxodGHtuGLr
	WcSY1vEN+QsYpfy3yPGGtvFarlf52ubVc5Gb8MRpmmWrujWkDRg76AC1y3iGYjMg0L7oECe/clj
	EZEwWND+8/7yrk8F6jdg7UK0rE2KBlzJWj7N6Q0/CmPcWSBU8YH6NVaOpTK4vFbLd8F91+J37kw
	fPHxkf+HvkWVZgp8vlBH7sU2/yYxi1u25a2rgc8YBUNLPKev6O3RIH2O2kD1lS4X4GP8HtQcFV0
	FJZ2/DWLy1rIm2SAgKJpNamzHvyVuDl+4uBlHxL4Noc27PGtIcCDRo3M6V1qLC/GsUyFeYZypfM
	UDlbCLqIiEYLLX9qNUlVIqJQ=
X-Google-Smtp-Source: AGHT+IG1J7knZE5apwKbx1rJuKhZc7Uf3gk9aOxkEVSL2I3TMnEK10esv5pd2ulCr9y5utdp3Eh3BA==
X-Received: by 2002:a05:6402:210d:b0:60c:5853:5b54 with SMTP id 4fb4d7f45d1cf-60c58535d7cmr1029639a12.14.1750846527091;
        Wed, 25 Jun 2025 03:15:27 -0700 (PDT)
Received: from [192.168.88.252] (78-80-106-150.customers.tmcz.cz. [78.80.106.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f196a07sm2221030a12.13.2025.06.25.03.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 03:15:26 -0700 (PDT)
Message-ID: <2026a8ac-5e2a-4852-b7da-1f07ff916766@ovn.org>
Date: Wed, 25 Jun 2025 12:15:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 amorenoz@redhat.com, echaudro@redhat.com, michal.kubiak@intel.com
Subject: Re: [PATCH net 06/10] netlink: specs: ovs_flow: replace underscores
 with dashes in names
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 donald.hunter@gmail.com
References: <20250624211002.3475021-1-kuba@kernel.org>
 <20250624211002.3475021-7-kuba@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250624211002.3475021-7-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/25 11:09 PM, Jakub Kicinski wrote:
> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
> 
> Fixes: 93b230b549bc ("netlink: specs: add ynl spec for ovs_flow")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: i.maximets@ovn.org
> CC: amorenoz@redhat.com
> CC: echaudro@redhat.com
> CC: michal.kubiak@intel.com
> ---
>  Documentation/netlink/specs/ovs_flow.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
> index 46f5d1cd8a5f..7974aa7d8905 100644
> --- a/Documentation/netlink/specs/ovs_flow.yaml
> +++ b/Documentation/netlink/specs/ovs_flow.yaml
> @@ -216,7 +216,7 @@ uapi-header: linux/openvswitch.h
>      type: struct
>      members:
>        -
> -        name: nd_target
> +        name: nd-target
>          type: binary
>          len: 16
>          byte-order: big-endian
> @@ -258,12 +258,12 @@ uapi-header: linux/openvswitch.h
>      type: struct
>      members:
>        -
> -        name: vlan_tpid
> +        name: vlan-tpid
>          type: u16
>          byte-order: big-endian
>          doc: Tag protocol identifier (TPID) to push.
>        -
> -        name: vlan_tci
> +        name: vlan-tci
>          type: u16
>          byte-order: big-endian
>          doc: Tag control identifier (TCI) to push.

This makes naming consistent across the attributes, which is good.

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

