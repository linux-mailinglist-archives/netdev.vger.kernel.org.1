Return-Path: <netdev+bounces-82749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF2588F8F2
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B459B232E6
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F8452F86;
	Thu, 28 Mar 2024 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czD1dUEf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0045103C
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611722; cv=none; b=WJZxMPo2NMdEnJBqkrQOXy3l6Kw9NYQ0CTti61M4AjBSlTSODzC8kNPimFok7cZftOMD3i1Uhix66AUJQWAFugjgr3kGJVGYcCLP1m/DWFr4ygMUvI/6jvq2zw4UlLbLZ7OruQJDgZL68W+5WrrVXyyzwg82dO/FZ45ey505JTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611722; c=relaxed/simple;
	bh=p7jvhF8UUU6b5qtcY5scW2h1alVWQdrkZG26kAGLKGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRY1F/SAXeljva4Hr4q3C3vaSWmGQwhTjLe/PrPwcXTAd2Wmwbhg8oD0STNVNVsY/hbol3dT9aYMGp7oIXCethizDNh1N7UHHau+qTf9L2kT7076soO1VFr3dvzRFr1Rm/vwe/5Kfwpiro1sT0kdcEmT5v41Vf2TtD5YI06ZPyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czD1dUEf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e220e40998so429585ad.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711611719; x=1712216519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMfmnNl2s+7VPPO/R9AcmHutU4IE2lFTYwc+b74dMn4=;
        b=czD1dUEf7RU5NXfy0c4yDHdTE0OWgQ/1y8n9dR3attJQv1y17JHwpF1ySAGQ3b3os/
         8hS4HmuH3Y6Oz6izPTrH7hZTkmcYApMudlGubit/Vc6JqoK8CgiotlLTCghJ8y0TByUl
         q1XazQFlQNx7XUMqCjw9YyPvteCu/s0JIsqfbgR3HLZ9r+bXmJhWD0uruA57j0iYD3pE
         3d9EV11taHet/yDUNzCvGG8lB2UokEK4Sb0cwgOZL+VHhZPf/Px5x6zrwqocRuqnCOKN
         OoTQHnon13ovvwMTfHuZa6Sxny+mwOCtkL89HZbZcvM2uXoTfJpieQOiKlZSHyEKP8Cs
         xi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711611719; x=1712216519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMfmnNl2s+7VPPO/R9AcmHutU4IE2lFTYwc+b74dMn4=;
        b=IT1oJF+M2O3/3QcC/bg/bTCkjUYW6ZmSwG6vE9T2j5wEZtssR6dP5fCQbF4h898sVh
         Hayi+G6tKJSQRooV4biLz1KtsuNOXpdkBIfSUfoTBT5znYWaQPZ4Of5CqILfbqQX9arZ
         RnCeZk0DDhmrZUNDrzrdm82+t/G8OftUjdsIsqFmVYEreGZxWa93/ed23Xkn6s1aSijZ
         LhvLFnclo+cKaZLucpASqBnY6RN9NVRW8cSiIUTzeJW3r7sAKFdyVpVAfIaQXVHaPT5c
         rXnEE9XFdhI2wLQQY2YKsLZyLnPG8plfD/zAs3ADyMPTOuCQYT3WJVvFzghSi3Ejf4+r
         BYCw==
X-Gm-Message-State: AOJu0YxQ2vXDQwcwjzNm/YmcRfqkrP37HnkMDG7xEBGCXo/J2cdzCv4i
	aja10OgaXCKMnUJExbV41nifmdtV6tZCTxUmJTDMQ2kZHPr03A8zNZEfFJUbCj3QQK4w
X-Google-Smtp-Source: AGHT+IGzJczr+ojZexSdjZS2WaStIl++hRRVXfFp3T9szZta571U1Do3n3QmAJMYdWqFc/vhxUikvw==
X-Received: by 2002:a17:903:1ce:b0:1df:f859:91bd with SMTP id e14-20020a17090301ce00b001dff85991bdmr2296633plh.4.1711611719404;
        Thu, 28 Mar 2024 00:41:59 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902e99500b001e208707048sm842581plb.117.2024.03.28.00.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 00:41:58 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:41:53 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next 2/2] ynl: support un-nest sub-type for
 indexed-array
Message-ID: <ZgUfQTtEjkFDwCX9@Laptop-X1>
References: <20240326063728.2369353-1-liuhangbin@gmail.com>
 <20240326063728.2369353-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326063728.2369353-3-liuhangbin@gmail.com>

Hi Jakub,
On Tue, Mar 26, 2024 at 02:37:28PM +0800, Hangbin Liu wrote:
> Support un-nest sub-type for indexed-array. Since all the attr types are
> same for un-nest sub-ype, the index number is used as attr name.
> The result would look like:
> 
>  # ip link add bond0 type bond mode 1 \
>    arp_ip_target 192.168.1.1,192.168.1.2 ns_ip6_target 2001::1,2001::2
>  # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
>    --do getlink --json '{"ifname": "bond0"}' --output-json | jq '.linkinfo'
> 
>     "arp-ip-target": [
>       {
>         "1": "192.168.1.1"
>       },
>       {
>         "2": "192.168.1.2"
>       }
>     ],

For index array, do you think if we need to add the index in the result
like upper example? Or we just omit the index and show it like:

    "arp-ip-target": [
      "192.168.1.1",
      "192.168.1.2"
    ],
    "ns-ip6-target": [
      "2001::1",
      "2001::2"
    ],

Thanks
Hangbin

