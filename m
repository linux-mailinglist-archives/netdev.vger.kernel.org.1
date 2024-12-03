Return-Path: <netdev+bounces-148423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA26D9E195E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F03B22C55
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F5F1E1A2D;
	Tue,  3 Dec 2024 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQzpSESY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031D1E0DA0
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218847; cv=none; b=BUFvT/3dIVl4+PmjYEVrkhr2b9dm7jyafV+P/8obZ0zjY1kIddTj3rPG1rB5l9NefpyTwohf8uA9S0NFa6hAkGew2kK4u8+fBgIr4ACRjFjFMTcs3b+yoegx2cZDRA6fMzqo0aODkOU3l8VGcTEAnYw04YTfg+TrvQtdhm/yMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218847; c=relaxed/simple;
	bh=/jz3ugyvl3+mRbslHfzgJQkWC8Bn2VbuAFAAXgr+R4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atD2eroSky1+Eg7alTt3mLWwdQO87AMLx8PA6s6pG3kjAk2BmxMiqkSrC6fuo+RVmeG8odKJCGkO+k/anOzZhQQH0id66Ns4PDwVfkHz8ahJYpm1hFQ1BExyD1FIqwO+5kogzDIEyTzn0842JCWxq52v5gbXBNXuLuLt7sANaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQzpSESY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733218844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OfpgMux8ECyhFr0Gd9nm/Ka0QyflmmO41wuknGXI9mQ=;
	b=IQzpSESYqUDU3vpHH3i9pgRquW04XIumaHSp4wmKI+Bn18OAAbjSnwNtgtIe7/yPlC4IwK
	jHqDNYLkc7p/JvUvGQVsDd8JRJL1ZMX6TbvGmmSm9Udg6ZYKHRwz2TuowyV47TjHrlqAQT
	1JSqGnJH3GitFIH7MEihTUel4/kcjsI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-DW9mEkEyP5Sz8KTNbSgugg-1; Tue, 03 Dec 2024 04:40:43 -0500
X-MC-Unique: DW9mEkEyP5Sz8KTNbSgugg-1
X-Mimecast-MFC-AGG-ID: DW9mEkEyP5Sz8KTNbSgugg
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d88ccf14aeso54291396d6.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 01:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733218842; x=1733823642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfpgMux8ECyhFr0Gd9nm/Ka0QyflmmO41wuknGXI9mQ=;
        b=gDxASTKT1p9gzxk6Hu8BI1/Dbs/C8bf8iQbLYfLsYZ4klGJlk7A+jg+RNRiFiOJHsO
         pAYzWHgt++7O6g0UFIkoBO5GpfV72BTjVbNUC8deCcuVYFiSVBayxxhy5qNnp1peofIN
         NECSrwqIw8b3SpjIhtENy9SfdFPVGS+R89tcK5gIZEOxEgoE2Kv6MWMD9mqqOJfaYesf
         OOp6NWT+A+Fc6Av6UzqjW7NDrAhmTcQe1LswNHGmV4p7Aae7QnBlBW6t346AcHR9l5Df
         SruSvzi5PRG+G7xRrIje+fhie9hW779ilBcVPPNIsXPZqWpJMeMFvvoL+IgeSxz5y7u3
         o/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyuTEYICqt85iBU9eaZTCGGFiR8CCiPBsqkHmD4+jXTvGDYv1NHGELrA79xUEXEG+PU1b5AiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjVb0vkCHQV4lEgdYWqFpiPfVkrurgxrp3bdypbGFxXcTEeIb2
	yqTsBwXTGwNNYrEIvCsvWnRduUjvQ5AuN1y2npyI6sGK5uajY9HvnQZrXtbDplbCEAUTV7wo0IK
	NM0QUuW0NJGzPqSbIQKdk17i7hp2ZhyGTfe4Xj+X+PozcyL+v8Coumw==
X-Gm-Gg: ASbGncsYXJakbXduhwHUjoRFpN6od9NY8pE4/SX7v0w4OU1OBwzWzrQ3Ndoe0hHrbMf
	bbVtFnctejiS2Pjfqfr0swlJhUcV/ItnW1+GpUp5UowQbCUPg2We/rZU965BlGT1ZaQFxm424qE
	69sfh+YcDbyEBXIjVRT8D7d0roJ1e0I7sRTvBsBkoFWjhvvdrRR+0MT4Yyscojs2w1LU0YkQRna
	c+5JQ4ZwqQaGTnBghAltpE70ijFtaT0gLf4o/gGktdoRrzdKWEgaNb1cKI0NWkEgbqHbF0SvRMY
X-Received: by 2002:ad4:5b8f:0:b0:6d8:7d63:f424 with SMTP id 6a1803df08f44-6d8b7317487mr30754596d6.12.1733218842748;
        Tue, 03 Dec 2024 01:40:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFJKe8gYVOPoz1stB/4vivQ+4YFVkTPEy9VAY6XLYvVEvdF0MJBe+Y0neETndfuzsQtUI/OQ==
X-Received: by 2002:ad4:5b8f:0:b0:6d8:7d63:f424 with SMTP id 6a1803df08f44-6d8b7317487mr30754466d6.12.1733218842494;
        Tue, 03 Dec 2024 01:40:42 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d896a2a706sm35947496d6.112.2024.12.03.01.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:40:42 -0800 (PST)
Message-ID: <96747b28-1548-4503-838b-e7a994be4647@redhat.com>
Date: Tue, 3 Dec 2024 10:40:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] octeontx2-af: Fix installation of PF multicast rules
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, horms@kernel.org,
 andrew+netdev@lunn.ch, edumazet@google.com, sgoutham@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com
References: <20241127114857.11279-1-gakula@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241127114857.11279-1-gakula@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 12:48, Geetha sowjanya wrote:
> Due to target variable is being reassigned in npc_install_flow()
> function, PF multicast rules are not getting installed.
> This patch addresses the issue by fixing the "IF" condition
> checks when rules are installed by AF.
> 
> Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support").
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index da69e454662a..8a2444a8b7d3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -1457,14 +1457,14 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
>  		target = req->vf;
>  
>  	/* PF installing for its VF */
> -	if (!from_vf && req->vf && !from_rep_dev) {
> +	else if (!from_vf && req->vf && !from_rep_dev) {

This IMHO makes the code quite unreadable and error-prone, as the else
branches are quite separate from the 'if' statement and easy to miss.

It also breaks the kernel style, as you must apply the curly brackets on
all the branches, if one of them is using them.

Please restructure the code a bit:

	if (!req->hdr.pcifunc) {
		/* AF installing for a PF/VF */
		target = req->vf;
	} else if (!from_vf && req->vf && !from_rep_dev) {
		/* PF installing for its VF */
		...

Thanks,

Paolo


