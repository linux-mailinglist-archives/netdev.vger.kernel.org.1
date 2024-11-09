Return-Path: <netdev+bounces-143521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D29C2D89
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 14:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895A11C20B23
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 13:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5236B1922F1;
	Sat,  9 Nov 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ZTRatWNs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED11547EE
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731159131; cv=none; b=GoURcVcfPYWns/qyQUBNu13jAYyX74upMODe0rIziaPYUXesXQEqtR69XhFB7JUhnr3TuLUl038lwUKMoQ08OeztOGdHwV13NzGnfrxIL97RJgucCX1L9Ogn38dCCCp49qNX94VBVVNrwaDj9e7b5N+/6ShPLMGcew9EQwJzi4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731159131; c=relaxed/simple;
	bh=32gf9hT995PQq1aAYXY53/SFI2peqGmru9vlcv9S7mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlV7TysfOd3RGREK/0iMYaDtJbW5C1PvuY2dpDENuE9G/tvTxbrH13khFQNZUSdM1cuYZgEw9Bk4V5FBZKNrzjrPjPr9QyBMkxKh3qQYXDsA0G8O9QJ1CvOBTz89wohpXPb84oRTt6W7+h3CNmoqhnaxauoNT1ub6tp8USJQytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ZTRatWNs; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so3643316e87.1
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 05:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731159128; x=1731763928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPkYK2jE6W+k/K+5sgYeu+6Wgp1BX3wJYLP9Zc4crPI=;
        b=ZTRatWNsgbgDfLBJ/Ki/WjrfKdMwB3WeltQZ0beSKSgoKQloLnKHeJAB4N62AU94B0
         iBYsNuSDRrmrR8YgMWWJJKfCZrp+wUlTSIeoBRuIsf3qYyd58fXu7MjkQbn/otYoFOf+
         nbpiW4K1YznAUnptiqYPpv/JMmmDVksgLVtrpN08Z9oJhaodjjJv4w9GHo6Cs2FRFHGp
         hbY7ed1zCpUnmw6UVt8rQ/CXM+IT6pNmPwmM7ex6XceZ7i5TKPWModuFxQIpjfhoYCIE
         ZJErRgdCQxF2eHargGZKi6qs5Lns6qtHchJQ5OVZxuvU10LLLHXmgnHaUShKeYmsQHAL
         l7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731159128; x=1731763928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPkYK2jE6W+k/K+5sgYeu+6Wgp1BX3wJYLP9Zc4crPI=;
        b=GHB8PfRHZrErjgh/mw3ZL7xh1EHMgZI81Dyh9r2Zk/pklkdwKtTVeRw880N2juPzCn
         gZ/p13gzlcd6Pp18reoT6iEM8iRyZOtH0knxi4D2xY17aWoVu8DlIFwOdmptOny+ElZ5
         QYRgN3dqQeQAROqLTs495vnryJecEITBaSCpGPFYUU4p/YjekKZo4e3LTV4KcfxzpbSv
         AYcJkKKR1oY1QX6fAxqqmwjr9NBNY/AOtf8iTR72j1Zhdwuy5IryThRzLDAfzur6yB+V
         1iRn3tBLJCUsxVSAXadrHyqRIYdOGP/+lzxst+MvnWfy8soNPRDfBnfFEZprxjeHOmku
         ktzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEDDOYW9fbNB0SVHjouRWzhc2MwvAWuxHN8vt6E+F8T1NgyXniuc1XtDTLJ5UAfNZviHc/d/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9o6qQNm9zdq6FYCA+vkbcALbQkm+FdMVyk/8tPbvGB2wqKnq
	zRptrks/dek3MqvgElx9ijlPyAAVimpca4shFXFgaEbXSUPcPZmsgqYI22HFcuM=
X-Google-Smtp-Source: AGHT+IGj0D/6yjP10y7ie3xxsGiYheBK1EFju+ttcIftGp5WJQJIP4vfOq3SOeC0NwuE0PHhvjMsvg==
X-Received: by 2002:a05:6512:3f05:b0:539:fd1b:baf5 with SMTP id 2adb3069b0e04-53d862bd445mr2637845e87.16.1731159127417;
        Sat, 09 Nov 2024 05:32:07 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7355sm916769e87.129.2024.11.09.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 05:32:06 -0800 (PST)
Date: Sat, 9 Nov 2024 15:32:05 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Cc: davem@davemloft.net, Roopa Prabhu <roopa@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 1/4] net: bridge: respect sticky flag on external
 learn
Message-ID: <Zy9kVceo3w-YRA8S@penguin>
References: <20241108032422.2011802-1-elliot.ayrey@alliedtelesis.co.nz>
 <20241108032422.2011802-2-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108032422.2011802-2-elliot.ayrey@alliedtelesis.co.nz>

On Fri, Nov 08, 2024 at 04:24:18PM +1300, Elliot Ayrey wrote:
> The fdb sticky flag is used to stop a host from roaming to another
> port. However upon receiving a switchdev notification to update an fdb
> entry the sticky flag is not respected and as long as the new entry is
> not locked the host will be allowed to roam to the new port.
> 
> Fix this by considering the sticky flag before allowing an externally
> learned host to roam.
> 
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
>  net/bridge/br_fdb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

So you have a sticky fdb entry added, but it is still allowed to roam in HW?

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 1cd7bade9b3b..d0eeedc03390 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1457,7 +1457,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  
>  		fdb->updated = jiffies;
>  
> -		if (READ_ONCE(fdb->dst) != p) {
> +		if (READ_ONCE(fdb->dst) != p &&
> +		    !test_bit(BR_FDB_STICK, &fdb->flags)) {
>  			WRITE_ONCE(fdb->dst, p);
>  			modified = true;
>  		}

