Return-Path: <netdev+bounces-100325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A1E8D8904
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF33281573
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D31386CF;
	Mon,  3 Jun 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGZnuv+W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E12F9E9
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440893; cv=none; b=spBU8RODDEoWvRvy+7sYnXxHeQ+jlIvqaBNHa9cnAQ8+DSLx6Ns60hT+KYVKzwPebeSUJOZYyULe7TfgPnxjnSyAdSR35XIF10t8vdod6U05LLd/oSuEZ+toIrCu35btBJkARPNmLcMBSkuFXQxM3WUWvsbC9VqHa5oTFeUP6tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440893; c=relaxed/simple;
	bh=M4A7qLT5eB98nqEgS/Pqz7Aq0FuB3rkJHaYjToVQA3s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=j2dnEZeuxDzs5mNcvOhmJcXg2btsWA7b4w/7VF+uSruW/RfKYiS+IP2Sp8JlcdQEQXzcry/QxB2O2LXCyI7OI8WbW+dUsfG0joj9dpTogGZTXHEq7KgcXVxOgkV8g78oMDQx8Y4tnRtLLoLsSE03gZ/9p6zHtv2AMvVX1DoHE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGZnuv+W; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42108856c33so27679835e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717440890; x=1718045690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gnb/LTmrEW4i/ClCrQ8vtO7LKiresjEgUCdc//xRq0=;
        b=JGZnuv+WCmmuR5ugj5JoGqMgUX/OIjljB+qKBDtHJ9QyucqB27TmkTE61xhAKQJg6F
         1v0WIoUiXW1h8TF7stQS5w9OTthZQnfvbCfvNBnrvOW6UiquK8Mdn/F+mce+yTrJi7ll
         +12lnrqe1q/W22Wt99OJ0gsunNNESxXnKGpd/WxFpmcdWKTs+zpdmjQhk7ZyM8ob8L7a
         0M5emTxWPlaod+x0J6DMWEBTfoh6iRDWGDHS6S7x863ouOE42p253qrWoqQw5NO+79BY
         wjR6Epxl15YsXvzveX0CsO4Eghmz3UumGSCgi5h3bYtD89eTiPNbGDWnThcVqBkUoRhE
         z2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717440890; x=1718045690;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gnb/LTmrEW4i/ClCrQ8vtO7LKiresjEgUCdc//xRq0=;
        b=uC6A8AK+JWcuyAzKL9gXaIquNsafxYyKR/mlza0DCaqFWS03u/Sk33XRyRYVFVv6jB
         4umZWMtMOZwKTEEQriOlphyYQo8bOAwISroqXcR5vTzkLw2UYVciFvuYy7c45RNiTQIk
         h1MpRv/Zqn33KxqqlGPz+eHnedhE7AsSsM1+1dDzvwZSRZpp2d/qGxeoYyeGEY8Kwlf3
         hZ0dCsUZi32Rd6/nNlGlw4O78/K5Tn/ZDu/aPec6b9RHqyqYZ787MCFraSzeiN4WImk4
         X5R2nt4NRysRkcS/deWIiWEBn9i4PlG8M9mlROupEL9kkj8EuVPQb1ALaDrAlo06OqTO
         YgZw==
X-Forwarded-Encrypted: i=1; AJvYcCWcQ8xXSuljwQm2K0+Bzt0n80bcObDyBTNd65ociQF66ayKIjMzvpsddJnnL3KdTvLGRcPKJcOJVAmoT0lt6UfjQ6YbGC+W
X-Gm-Message-State: AOJu0YxttXr4jAfIltbyqLpjMJ8lSTOAcWJTOKmmrz3YQk+OJ+X8NyI/
	Lwj5eYtIFXCP005KtL/HE5V5w+N03xGEWFj0LAycQ23KXlhwLC4vS051lA==
X-Google-Smtp-Source: AGHT+IHeszVQY2ZKO7cJoCFJfTBt195QgF/dOjz9JMmTOutSeQCigi8gS32bbtY/OpYUDoVf0M33UA==
X-Received: by 2002:a5d:4842:0:b0:354:f5f2:1997 with SMTP id ffacd0b85a97d-35e7c520540mr446853f8f.3.1717440890138;
        Mon, 03 Jun 2024 11:54:50 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e5985c269sm4029937f8f.82.2024.06.03.11.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 11:54:49 -0700 (PDT)
Subject: Re: [PATCH net-next v6 1/7] net: ethtool: pass ethtool_rxfh to
 get/set_rxfh ethtool ops
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
 <20231120205614.46350-2-ahmed.zaki@intel.com>
 <20231121152906.2dd5f487@kernel.org>
 <4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
 <20231127085552.396f9375@kernel.org>
 <81014d9d-4642-6a6b-2a44-02229cd734f9@gmail.com>
 <20231127100458.48e0ff6e@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <b062c791-7e4b-ca89-b07b-5f3af6ecf804@gmail.com>
Date: Mon, 3 Jun 2024 19:54:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231127100458.48e0ff6e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 27/11/2023 18:04, Jakub Kicinski wrote:
> On Mon, 27 Nov 2023 17:10:37 +0000 Edward Cree wrote:
>> Yep, I had noticed.  Was wondering how the removal of the old
>>  [sg]et_rxfh_context functions would interact with my new API,
>>  which has three ops (create/modify/delete) and thus can't
>>  really be wedged into the [sg]et_rxfh() like that.
> 
> Set side looks fairly straightforward. Get is indeed more tricky.
Looking at this now, and wondering if the create/modify/delete
 ops should use Ahmed's struct ethtool_rxfh_param, or keep the
 separated out fields (indir, key, hfunc, and now xfrm) as in
 my previous versions.
Arguments for keeping the separate arguments:
* Ensures that if the API is further extended (e.g. another
  parameter added, like input_xfrm was) then old drivers will
  refuse to build until fixed, rather than potentially silently
  ignoring new members of struct ethtool_rxfh_param.
* Avoids potential confusion by driver developers seeing the
  @indir_size, @key_size, and @rss_delete members of struct
  ethtool_rxfh_param, which are all superseded by or at least
  duplicative with parts of the new API (struct
  ethtool_rxfh_context has @indir_size and @key_size members;
  the separate 'delete' op in the new API obviates the need
  for a 'delete' flag).
However, you presumably had reasons for wanting the arguments
 wrapped in a struct in the first place, and they may still
 apply to the new API.  Guidance & comments would be welcome.

-ed

