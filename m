Return-Path: <netdev+bounces-93306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C54798BB145
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7797B21B93
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86A157A42;
	Fri,  3 May 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="3Gx8diy2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1715748E
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755227; cv=none; b=G/uE2euAcUk0yzph6dbPnnUUd2Hp1paU4Y6LgqwXwVwI/TBdGKqXBvWlhuEVNOnZo+hEnSTWNdVLZcvKBvr9ur+N1M9jmmvFlRK453hxDYKudiqFRJMOFBRr8zraQ5GDQXyvk5zAWEcgQtpR468lbMK6rYgjipEyNga0oC4X1oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755227; c=relaxed/simple;
	bh=vnGKr2FU3VVj8cAyhqN9JGswO6gli0XknAZELBhdAb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ti9Pba2wEjj+3jc/3/SHuX6h82SteNUycxeyozyO17/BSbFN7PgEgQZ9booY7h9YPQrkGhbyS6ZorQV8WPNy6X0WDfZwVUsap4bDb5WHjPYAytlJe/hCcPXInLFsXQAn0Og321WHO0bGVj6jghuemHf5Ej4Eu+pYaCrtgro+FeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=3Gx8diy2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a599c55055dso117207566b.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1714755224; x=1715360024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIHt03EOBH0mo59DqWVyw7Ox3t025saq2PvgQLBWkgw=;
        b=3Gx8diy2OyF3AvphxfQ3Gyhd0xsFfwNSqswTtMgJVYRZ1SflTXmvd8bG/j6M7x+Auv
         7fsbqbDHPD+B68p1Rt8Nv4uH2p0qe8SIGhscDKIjsmZ9Wc0/+eZsW/LxiF/sKlbOs+gL
         MXQV4jDkhJNrHY3ExnOr3JprsxQuB/KliXMtbLNpLQ1/HN3LUrO8WXflKkyh40m+r2WL
         4G268+1whrYix/C/mPm0b4QaDWVQUbNnMLXNXg4rTvTIybRS091wuI3aC0BJpCYoV/Y3
         jmmn/KHDrxdoyNN99TI47XgAdytUnQTtECBq3zxGAJM2qZ822E6VnyR9fQHF/jJbs/oJ
         3h1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714755224; x=1715360024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIHt03EOBH0mo59DqWVyw7Ox3t025saq2PvgQLBWkgw=;
        b=FumLtHD5JiSt/ASMUiz626YhERuuNCelYXCe8IG8vVwH1kkeDCspGwZPD9bn7sQn28
         7IfoUo7lTqyVx+hWoHfo/To0rP/VfN43yACqyf8iCEzQztjnwxS+ikaQRv1mwbYs+To8
         edcgPZx6CwjL41QBfLQha6J4k0K7xS7S8aSviQMOhhuIR7n84C+3aFZtPsBrsKXvSVxX
         o+igqcar5Ok18Z/aXbMF39sipZi5aMH+9rVQ+GpLRmndzerwPX1psCpwvJjIwjkYfbjp
         4Wwv/cIo/aw8oYmrapIS2tOhhpwUl50i2j+TPjBJ/9YSfdYigLOWfCm7rUUJ5oS2D0tc
         b2rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfLIsnOJgrs2ky5TqrAPHwRGK2DtWDl9U10bYUVPdnzasOqImePRpoIuFDsQ+WYDutyticGjksPMgmvy0BvkwLBwe0m0Qa
X-Gm-Message-State: AOJu0YxHpgNwB5y1aFetXvUb6i/k2Hr21TAmzv1KbGzkcz1YcGgbKqdY
	7CsNvW+XycWR/HPQYDBcjdrow8GE7k3chnfp8EAmAh/87lmKp/DomAFLcfy7B0A=
X-Google-Smtp-Source: AGHT+IFa/ft1jlFy2ot8l5mUGh9Kw0YzJWlbh4cIBd6wjz+CUBz8XcGvTel9fO6zotw85rYQkccN8g==
X-Received: by 2002:a50:9982:0:b0:56e:2e6a:9eef with SMTP id m2-20020a509982000000b0056e2e6a9eefmr2092378edb.2.1714755224262;
        Fri, 03 May 2024 09:53:44 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ew11-20020a056402538b00b00572c060396esm1829528edb.78.2024.05.03.09.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 09:53:43 -0700 (PDT)
Message-ID: <d6f6f295-1f52-42db-9058-f69e4d188dce@blackwall.org>
Date: Fri, 3 May 2024 19:53:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] netlink: specs: Add missing bridge linkinfo attrs
To: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>,
 Johannes Nixdorf <jnixdorf-oss@avm.de>, Ido Schimmel <idosch@nvidia.com>
Cc: donald.hunter@redhat.com
References: <20240503164304.87427-1-donald.hunter@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240503164304.87427-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 19:43, Donald Hunter wrote:
> Attributes for FDB learned entries were added to the if_link netlink api
> for bridge linkinfo but are missing from the rt_link.yaml spec. Add the
> missing attributes to the spec.
> 
> Fixes: ddd1ad68826d ("net: bridge: Add netlink knobs for number / max learned FDB entries")
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/netlink/specs/rt_link.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
> index 8e4d19adee8c..4e702ac8bf66 100644
> --- a/Documentation/netlink/specs/rt_link.yaml
> +++ b/Documentation/netlink/specs/rt_link.yaml
> @@ -1144,6 +1144,12 @@ attribute-sets:
>        -
>          name: mcast-querier-state
>          type: binary
> +      -
> +        name: fdb-n-learned
> +        type: u32
> +      -
> +        name: fdb-max-learned
> +        type: u32
>    -
>      name: linkinfo-brport-attrs
>      name-prefix: ifla-brport-

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


