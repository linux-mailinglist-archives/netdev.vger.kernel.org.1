Return-Path: <netdev+bounces-81581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE688A606
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969FE1C39E00
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E95B137921;
	Mon, 25 Mar 2024 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzfE28eV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB20168AB
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370015; cv=none; b=sg2s+AfKeLK1p6l/9PJKe1jJs+uebWmk459C40kN8cLxxTSHHAOmlOsZszFV4ORVQScn5RjRbRJw/LGTc0uLmqlRNGmSBRyLISfk7vsp0mV72CFsFmpOxmHVm4RTfTVE7FOcxbVXdPzFmFLNGIjFyJxGxXmWMLAH9s/SPGulyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370015; c=relaxed/simple;
	bh=VWypHvDqgbH8+lPEDiiHWB/9BcQ3jMgQ/+WP7uFRF1I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LVZXkh9KwaUxmlXGPQTcQoKfuw114QcAnQKQX9qAaHtPYBrMcvwhieSuV3AC1/5KHXaFjLSO8jKIGtgs8tqNdNGviP1rHjFkolx+H+dmpUHuwzAsYpGxzJv3x4wE13ymUquIOQUyN9ld7QKOGalCggF405us7+OGKenpHyz1C/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzfE28eV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41482aa8237so14339385e9.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711370012; x=1711974812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmsNGz/SjS01nd2DN2qF7dW1osscxRz3VTWdKl4iAko=;
        b=GzfE28eVdUJWjCn7Lzf29EHa8AvEFjfbb/wgFoYZ2XNdD0hIuekDDa6xXVo9rqwTKS
         n7J3AzmpbXk+QWMWOou6+4ZX+AJM2toluA7kJmyShUU59ioBqQ5keOo3gzGgFhflMvUb
         DkEdGvcc1EkdAJ0Pu/nQm6FMyB/qrl64zucm1hG//AxE8Rwdgc30xCRhQT4j8jmY5r9U
         IgLrJrPpJ/VdxQ89xgwnnMVL4AgnN9l+e85PBVZ3dZXFu/JGU8qIoeM43i+pqoQ8WIT9
         FY7lF26J+DaLUVe7Vbcg8z2di4Cf+58ak/M39DD9nYnanvLwyG/Jh6r8YgDBuKTicj0I
         P7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711370012; x=1711974812;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmsNGz/SjS01nd2DN2qF7dW1osscxRz3VTWdKl4iAko=;
        b=XaLAYb1aFM18jj4AlG9w6kykcumnoDTuU+2zcm+XQBsKWTDh0GtbchdBSJC51+QFtr
         rMWTdnuXe5qGia00olwjzUtujFHxcwRvSdm81E5eaWLvzPTW4v4wvYDmMB0BwER/UcJj
         +fJ3JywYAKdf/2QLsRKbGfefEx6VFu/Vu+0PU7X8MyEYacKVFQYjrSXKWAIi+2+LOnPr
         DY1NHkjaqdjMKfPIsXdPUfY1Qj+UuRJfeicgoS7o4nz4bd1YZL/VJha7Ryuuu9CsdbJi
         B/kkUgennjGqZAriSJPtoL4KHmIDiTaDs7eJNJO2YCI3xsRjuR9IGGC+C9b7NVEMuAWu
         zw5g==
X-Gm-Message-State: AOJu0YyK5yqcd2icMnpUtEXgeLeMTTaYGSUDsyLW482s54SHT70dmxUE
	fg8ckM9mCff/q2T5y+lqg4M6FtgQMozKAxpba78Rf/0t9TC45LsF
X-Google-Smtp-Source: AGHT+IG+27VzqWLIHxcr5Aj7meKj47pkoq0+ixCtIODoAioj8TBpbct8mifSSWcSJFFdnpr7uaRQ4g==
X-Received: by 2002:a05:600c:4792:b0:413:e8db:2c9b with SMTP id k18-20020a05600c479200b00413e8db2c9bmr5309307wmo.40.1711370011823;
        Mon, 25 Mar 2024 05:33:31 -0700 (PDT)
Received: from [192.168.21.70] (54-240-197-225.amazon.com. [54.240.197.225])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b004148ab95c36sm1780656wmq.41.2024.03.25.05.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 05:33:31 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <857282f5-5df6-4ed7-b17e-92aae0cf484a@xen.org>
Date: Mon, 25 Mar 2024 12:33:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: Xen NIC driver have page_pool memory leaks
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Arthur Borsboom <arthurborsboom@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Netdev <netdev@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <CALUcmUncphE8v8j1Xme0BcX4JRhqd+gB0UUzS-U=3XXw_3iUiw@mail.gmail.com>
 <1cde0059-d319-4a4f-a68d-3b3ffeb3da20@kernel.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <1cde0059-d319-4a4f-a68d-3b3ffeb3da20@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/03/2024 12:21, Jesper Dangaard Brouer wrote:
> Hi Arthur,
> 
> (Answer inlined below, which is custom on this mailing list)
> 
> On 23/03/2024 14.23, Arthur Borsboom wrote:
>> Hi Jesper,
>>
>> After a recent kernel upgrade 6.7.6 > 6.8.1 all my Xen guests on Arch
>> Linux are dumping kernel traces.
>> It seems to be indirectly caused by the page pool memory leak
>> mechanism, which is probably a good thing.
>>
>> I have created a bug report, but there is no response.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=218618
>>
>> I am uncertain where and to whom I need to report this page leak.
>> Can you help me get this issue fixed?
> 
> I'm the page_pool maintainer, but as you say yourself in comment 2 then
> since dba1b8a7ab68 ("mm/page_pool: catch page_pool memory leaks") this
> indicated there is a problem in the xen_netfront driver, which was
> previously not visible.
> 
> Cc'ing the "XEN NETWORK BACKEND DRIVER" maintainers, as this is a driver
> bug.  What confuses me it that I cannot find any modules named
> "xen_netfront" in the upstream tree.
> 

You should have tried '-' rather than '_' :-)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/xen-netfront.c



