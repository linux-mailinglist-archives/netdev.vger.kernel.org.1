Return-Path: <netdev+bounces-166489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A054A3624E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA331893B33
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5ED266F19;
	Fri, 14 Feb 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJxuJ3jy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE53245002
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548309; cv=none; b=MlPb+LfLoie9XzJo5SSJhmarzV0bx6BFCnuFtgSaHSf0lUcJO9TI/sDBEjnJWnhKsvurOJiKOOKIuQB7iJUUCYgKsYWForsFe+oCZ8uwtmQWDAklqghqs9VSwTyhA6Iw1jQfD6p0h4BsXC1xMxeWgVVQACJ4e7M/4il9bVEn9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548309; c=relaxed/simple;
	bh=B5BMCwsrwljOTs1fvz+eowxkbq1MLTZU7LRZTS0t5g4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c+QHO0w20I/iMYyjYgxMaONNfP6ocA6jSjP72EkdHCeCXRhkpUMk7/Txpi+NW/DAK6usHCTeJYiEqbS/kRkjcoGv0tebtrcVD6cbBCZvah/VQKm/4XQdJB9gUR+pVMxrKS5qlKF5kR17G3vPwhQlJcagidcoCNmYn+pDqf8ES5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJxuJ3jy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4396a82daf5so6429745e9.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739548306; x=1740153106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8QIcrdzcS8wkgbPKzpM+T7U0zUo6nrwmzo/Tq8rwbw=;
        b=hJxuJ3jy3grP1WvgQSAwb0ieiDZf5TWCYiNLMhdnWZX03xEKVjyEWXtOVGCzTeB2C9
         XzDxDehzdykW6PUQiW9xhEXvxIi5qO/yot7P27knr0+BzrPl2nmFhEaZ32eGp3oFFNqR
         kWLqi3T5+RNDOGTDNyYjN8qq3abWarR8qdPYupHMlhUQ7du8EkcTXv9vvNfc18/F+xEx
         J24E0A5d1/w/LCiTssBiipsgWPNpXIYnzmdawYOOiPOZ+0+sayvZbg53W4VEZYLc+D8Z
         WuR9HjdIzk3mY/lfr+jvysTEh5dG7H5jYuKEPGom6pJHHd4p/yQIy4X6N5Y9jfn45yEd
         NqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548306; x=1740153106;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8QIcrdzcS8wkgbPKzpM+T7U0zUo6nrwmzo/Tq8rwbw=;
        b=V/obGkXVK/sbdlxZ/wQsESd0hjncB+FikvU1otNoJLTMRRdP0QgP9i/k8xIwUGvitt
         tzMel4vDCicq0ZkjB8Z1od4xt0w+ULhu8AUP9pBEZcru8xBEq7m3QlHeSEVu2wMLaGoF
         Pqai1CkKK9uqq+pQHhrBKbxu25th6vuWyh4fFs3c4HnzGmAKh+u1QTfDui/qo96PDrfN
         6YH5bl39sWISU9wv/aXoqAd0Ixyu+cgKUkfIzNTTsy/sV1VtdUi4LCYkhVnyCIBzB/kM
         dYwZvIIQ0aEEwlGXIYvfpAOGtHwnit1kqvOzi2yuSjTbVxUOOgXA3w9gqLbkGds/jd68
         +bFQ==
X-Gm-Message-State: AOJu0YyT01qIHQkkxmlqW5c/bDbbnGwFkmdDN6JsGl+VUtjgLZ4pood/
	e+99/IDos1rWsuZKL2R4CuvynP/420KjZ4kKy+PFwOptjXCLwLyo
X-Gm-Gg: ASbGncuWwvPbLiqZVijSbB1sZTrFC42LHrySch3djMpmyR7aabfen8KmFmefyC68K6T
	uBd//44qgIa8KaEIVTGiBVtfkkENjAuOAgtBsWU0rjzXFGv3uFg6dXZJSR2vbt6IXcnWWayW4B2
	qi0KbvgGrxd50fltLtdboEC2e20vjMIsjCPtRDtcV3ChKumJy2GrfTBWSPJpea9jkvZ7SNx+U5r
	4e4YHZCjsRW8YjriF13Sc7X5yeFv2m3svskNP4zweEWVpzGGF3OYQTzNDgZQkKA6BF/mXgt+hle
	jIGhes/ox8wwDxZJx0ZFbkhfYM2M/hkH4X/7yz1CXedQeo3fmmQdEy4buGbxIB0a111Y9ItuzUv
	5iGw=
X-Google-Smtp-Source: AGHT+IErZ+xfHMLxaxQE/ywzDMzYrypUC9I797mLNUkMm6XYS0WGXFCwuoFKBPdlLS1O+VEBnmX0/A==
X-Received: by 2002:a05:600c:4791:b0:439:5a37:814b with SMTP id 5b1f17b1804b1-4395a3781abmr125395745e9.20.1739548305531;
        Fri, 14 Feb 2025 07:51:45 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961884f88sm47097265e9.28.2025.02.14.07.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 07:51:45 -0800 (PST)
Subject: Re: [PATCH net-next 3/7] sfc: debugfs for (nic) RX queues
To: "Nelson, Shannon" <shannon.nelson@amd.com>, edward.cree@amd.com,
 linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <a5c5491d3d0b58b8f8dff65cb53f892d7b13c32a.1702314695.git.ecree.xilinx@gmail.com>
 <0d1d3002-ff8b-4601-84d5-ee26733af54e@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <a73e6859-6a64-db5a-66ec-4fa884dd5b74@gmail.com>
Date: Fri, 14 Feb 2025 15:51:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0d1d3002-ff8b-4601-84d5-ee26733af54e@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 15/12/2023—
wait, has it really been more than a year?  Yikes.

On 15/12/2023 00:05, Nelson, Shannon wrote:
> On 12/11/2023 9:18 AM, edward.cree@amd.com wrote:
>> +       if (snprintf(name, sizeof(name), "rx-%d", efx_rx_queue_index(rx_queue))
> 
> Adding leading 0's here can be helpful for directory entry sorting

True, but it's not clear how many to use — the hardware supports over
 1000 in principle, and in practice it's normal to have one per core
 (and more than that on TX) which can get over 100 on powerful systems.
Yet on something like an 8-core box having queues 000 to 007 just looks
 silly imho.  I don't plan to change this line in v2.

>> +           >= sizeof(name))
>> +               return -ENAMETOOLONG;
>> +       rx_queue->debug_dir = debugfs_create_dir(name,
>> +                                                rx_queue->efx->debug_queues_dir);
>> +       if (!rx_queue->debug_dir)
>> +               return -ENOMEM;
>> +
>> +       /* Create files */
>> +       efx_init_debugfs_rx_queue_files(rx_queue);
>> +
>> +       /* Create symlink to channel */
>> +       if (snprintf(target, sizeof(target), "../../channels/%d",
>> +                    channel->channel) >= sizeof(target))
>> +               return -ENAMETOOLONG;
>> +       if (!debugfs_create_symlink("channel", rx_queue->debug_dir, target))
>> +               return -ENOMEM;
> 
> If these fail, should you clean up the earlier create_dir()?

No; these errors mean "we didn't do everything we wanted to", not
 "it's all broken", and the files/dir previously created are still
 useful.  The caller treats errors as non-fatal.
See also the kdoc comment on efx_init_debugfs_rx_queue:
>> + * The directory must be cleaned up using efx_fini_debugfs_rx_queue(),
>> + * even if this function returns an error.

I can't think of a suitable comment on these return statements to
 clarify this, but suggestions are welcome.

