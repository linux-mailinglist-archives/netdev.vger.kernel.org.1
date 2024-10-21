Return-Path: <netdev+bounces-137513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCBB9A6BE7
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31370B279FB
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B91F8F1E;
	Mon, 21 Oct 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUDqdu88"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216138DE0
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519841; cv=none; b=H5VAxG+up1+tyBPRlBLcyMqKz2MdksUSA2HMY2iPrbNG/FdO4yDnvjRsjcmLWn+GjjH6jGe/QhatkY2jx9pwfyAlAq5KGrUTdbkSbZr9goQDDnflRZ7J9WTgMBb/zDh7Gl9k3B0kH4Z/AU6fqWQ7I5Nnj0TGepkMlksw6LSEj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519841; c=relaxed/simple;
	bh=ZtzulUMRK2VFZqKs17vJAxZiX7pJDX5n/6suEZFdky8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUEgK/TpUPqdOsZ48bnqQKn08jI3ybDQv1/EvuFgMk5eYx5XMYbW+6DvLXF4DW5xpJHHDd/+m7KI6q+ZV8Qucmjur37WDuQD8CKYRxwL9X8I5+1/iemgJEUoOmHU/7DrWbeZQvdA1zbm/T6xK8xSeRLMkOgyCh089X4mjgV2yfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUDqdu88; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b14554468fso376856185a.1
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 07:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729519838; x=1730124638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pn+sN5qx63MI1q4XiUg2OyfXRGcuw7GeyXe44oSUQ8I=;
        b=LUDqdu88nyq/30Lj+2l24r6DyL2UxJKyHSUXEQjPhIDj7wCwORrAYSW+yidX/7FcE9
         2qS6H7Q6b7ImN/jbVv/v1bdAPiqMfVsaUZO57apoFVlBcuDNvp7+oOP3T+nw77LzCruw
         6WVFvwGkbSSG2d30HobnaLTQMWIn31o5MzGlsPm/VTBTCIXDsda7zhh8hwd/SjtBlFMF
         8JcIswqEtNPWgfDpGSo4J9WALT0NboLilu5jnRIRDVK4xs58nwo0GrOuPPJn00Qa2LXN
         G0WxrHecnoZriRSq9GJxQPwSq8Xd+cx4Zzbp5g3AKXO0Ookv2zSAmhJ4SGjebDGJP9eQ
         Hg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729519838; x=1730124638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pn+sN5qx63MI1q4XiUg2OyfXRGcuw7GeyXe44oSUQ8I=;
        b=gbtQpW+Gs9Cmuxz4+tfuuqH0qbKWuFmOj3EwE00Ygz9mRYGktxTfW1HdN6vJDg9pf/
         rgbLv4BUeppFH1jo0EeSdo+vISjYPpvKqdnxqcg56B6ljLXkn+C+VvvBhOAtIIWebvnJ
         zdUpNcdUsCchJXe/yUMZJUNPwOpIdM8AXabErWNUTLNUWSPB7XUZKzZkys7hl4DE3mpK
         04OXeK57a4ANtOiM9pqENFpYYAGSedtrYyzeKptz9ahcFQ2zTlulwTIOW2g2pVJNs+Os
         6Y2UyB37LZj5X+yJAmXRNcwyU/nmRIjrsBqGA9ySxj+l12zz8ORguchpRdQFk0As1Pd5
         PNNQ==
X-Gm-Message-State: AOJu0Yy1YmSyr1kJQE1DkBsMd6Jr7j7aaZ1eUxSyMAyQYt+htTgs5SUw
	7+LneOhDJwLO+zbTCpyvpUymiquTyCzap3i3WeVfQI9NWCBBCjAI
X-Google-Smtp-Source: AGHT+IGkb1PfCEOsO85EF89LWIbUF8KSmBaduVoLD57/jKHZUTkUuNZZIufOwkdgJwPJYSUGKLBEDA==
X-Received: by 2002:a05:6214:3c9d:b0:6cb:2f11:6b9 with SMTP id 6a1803df08f44-6cde15272aamr209550196d6.23.1729519838247;
        Mon, 21 Oct 2024 07:10:38 -0700 (PDT)
Received: from [192.168.1.155] (pool-98-116-165-200.nycmny.fios.verizon.net. [98.116.165.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009fd21asm17461046d6.133.2024.10.21.07.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:10:37 -0700 (PDT)
Message-ID: <f0d2811d-e69f-4ef4-bf0f-21ab9c5a8b36@gmail.com>
Date: Mon, 21 Oct 2024 10:10:37 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC ethtool] ethtool: mock JSON output for --module-info
To: Danielle Ratson <danieller@nvidia.com>,
 "mkubecek@suse.cz" <mkubecek@suse.cz>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <DM6PR12MB451628E919440310BC5726E5D8422@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/20/24 6:42 AM, Danielle Ratson wrote:
> Hi Daniel,
>
> I started to work on this feature myself lately, how far along did you advance with the coding?
> If you are in advanced stages, I guess you'll prefer to finish, but if not maybe I can do it, according to the below RFC and my comments, please see them below.

I have not started coding. That would be awesome if you can post code! 
The changes proposed in your comments LGTM.


