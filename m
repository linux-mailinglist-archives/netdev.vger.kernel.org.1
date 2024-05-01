Return-Path: <netdev+bounces-92750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9934E8B88D8
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 13:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2FD282B9D
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7D054FB8;
	Wed,  1 May 2024 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="VdwlPyo6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063D33CD1
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561253; cv=none; b=o0fGlP5XScG6vsJdYKNHFbXxVc7yWSIaWcViU6sbyEP3+SmceXuojdQTJOnbUr9YmojduuoBFhLg6T0GhGoyyaQ0UyJYprbnJOXR4PWP/kr9qt9BFTT7l2fEghmcLSvf53xlpxmaDHGr83Ef1q94sJvbxaI37XQzJCT9ePf1TtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561253; c=relaxed/simple;
	bh=ZhgdaBC+oAJSKJMQRDm6s8TQlCArceN6M0F4xI0U+r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKyIaGYGFrD1mH6PsxE2AtMfd+JiHbQGjIkAt/ESSe4mHqi3SjE7xBLVUq4wrRKO2jz8HGCqXM7+QBhyZrMhuBib0njN6jIDeBO0vJAE0zDlWXTgSPOjWWnIEoDvShwOlQYAw+lW0ruvjg5AUl53HWXmZa34IyVe/LmhGt3iSrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=VdwlPyo6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso25626895e9.3
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 04:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1714561250; x=1715166050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScEtUN04w6nvxq2p5sRa6QzxhIyDeaZK6u9wNnHkDeQ=;
        b=VdwlPyo6zdsf8ljMA+8FVt5/c4V0dSIA69aWmiEmYu8+S1Y2znRnKODEcKEF0yHVmI
         xrVzIH5fRI6awgquhOZw5XUGwCu7nV/KqsD/TtYqxWa2jL2TU+BveKpwp/cgnhT0/sv4
         6el756Keq4oz2Udj5LYc1m2o5JhyzRA3R/U15m0VUggmZR44eo5XHNsUSZESB0d4PhvN
         zZZVw6ZECw8K4zH8vskX5fW2FoCG3niRkoxvheZRokPaboibWn4ZjHJ2OIQcsu+45Nwu
         T8zbudclShLaxKsWx9vqV3x9rD+s+zIVIy5m+GC+5Gxx1QhGXbvCWrfVZsvb4XwYn10W
         NZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561250; x=1715166050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScEtUN04w6nvxq2p5sRa6QzxhIyDeaZK6u9wNnHkDeQ=;
        b=I1C+8oIfcv2SaqZjN7eYqwwfrUGvqDhnaM4zFqzxDoK3MeaAf9Y4ufYZKBKYP/ZPbe
         9QDbg+7aFbwqCzhxcMp7czblOzkQrAdijHzSB4wdAp0JfJ74SxqmCg98H+N7maTh7+/F
         EPdlvhXmu81AHFtavFcOw0hFcF7KmYfWp5Q8voTVqc5QnTBSCL+eEA/e4nWIGTApgm5X
         T4RmhH1LmsW14qYb1cf+hdKEdoAYzMJznQ0uiG3lF3vPfHt5wssSznCMJAEh+HQfe/Fc
         MRSJEkF+ZpF7OVyqgRIgIYnlrgheR73/njToahPSfFq1wgeSMWiBw/c5YVRbvIXIWwiX
         ATCQ==
X-Gm-Message-State: AOJu0Ywp2Dk7jewbKYeiKQTG+FWnECpWCBFHYT7uPkQrkp4GPWLvdxxX
	fn0xLMnXpsu0CMzBa0PfhcJbSAWxFGw9brHL3/uM+39dz5KuXhvsiMp41/Um3o8=
X-Google-Smtp-Source: AGHT+IHhSBRauPHUnVnqEV9C/bRhJjA8N60xiBd/oDexsr8kzcxWjeVdR8Xq4htf2GSHA/DkSfQvZg==
X-Received: by 2002:a05:600c:5111:b0:41b:f48f:9e6f with SMTP id o17-20020a05600c511100b0041bf48f9e6fmr1978486wms.3.1714561249619;
        Wed, 01 May 2024 04:00:49 -0700 (PDT)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id iw5-20020a05600c54c500b0041892857924sm1826980wmb.36.2024.05.01.04.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 04:00:49 -0700 (PDT)
Message-ID: <aa710275-e2b5-4bce-a94a-40ad42cf6b83@blackwall.org>
Date: Wed, 1 May 2024 14:00:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vxlan: Pull inner IP header in vxlan_rcv().
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Jiri Benc <jbenc@redhat.com>, Breno Leitao <leitao@debian.org>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <1239c8db54efec341dd6455c77e0380f58923a3c.1714495737.git.gnault@redhat.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <1239c8db54efec341dd6455c77e0380f58923a3c.1714495737.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 19:50, Guillaume Nault wrote:
> Ensure the inner IP header is part of skb's linear data before reading
> its ECN bits. Otherwise we might read garbage.
> One symptom is the system erroneously logging errors like
> "vxlan: non-ECT from xxx.xxx.xxx.xxx with TOS=xxxx".
> 
> Similar bugs have been fixed in geneve, ip_tunnel and ip6_tunnel (see
> commit 1ca1ba465e55 ("geneve: make sure to pull inner header in
> geneve_rx()") for example). So let's reuse the same code structure for
> consistency. Maybe we'll can add a common helper in the future.
> 
> Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



