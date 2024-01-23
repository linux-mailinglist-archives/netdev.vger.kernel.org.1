Return-Path: <netdev+bounces-64926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BEB837D08
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 02:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189E22912D5
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 01:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40065F84D;
	Tue, 23 Jan 2024 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSKTwf45"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4D5F548
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969773; cv=none; b=bel50hMH7pMMyvfrfuPczQQ7RExHE4dfwz/PPe8PuQDrsl1y4H1/WeCKlGFt/oZo1ZqgHyI7VrnGX+zcpiH6G/j1A1DxTkpXnw1crVItjuMz4cVClQJpksOZ0PhEV5Zs3G2eOCx2PXlPqeVpMroLbm1oZ4WFXjoILejPVKVPuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969773; c=relaxed/simple;
	bh=7R2DcEUwr1zpg1inccbXQ1F0srmU5iEvCyz+jnzCWUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPnutSjCrMA48qaXlUuYP/+LGluzJ/NIl8kfNNa7BMGL184U+CfF1zh21N9YnykBtpXdY6t8kgov9Whw0k/iVk4RrBNtr3oZkMnbGFAA7ndS93hUWaZllSZzds3qsM8rQAWWAwXDpMOa8PCiEhTUglsWmSVxTS5gL0wChVV1wWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSKTwf45; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ba9c26e14aso86153939f.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705969770; x=1706574570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bOLY9JEWCKnhtrT1pNUK8IfJyPj65lMh/72p9SVeAA=;
        b=XSKTwf45sA4exlDg8hn2Fh4/VhOh5WoBJ4mV+FdcZhGf0H+1OOWyoOwLWYEC3dumdg
         LOW60Xqqz6rPs1lh6J+i/RE7uGOlbrYYqohELFfXOcGvs4iSi7mZqlzUUCMR79lgVBkT
         i76mHpvZC8qjr38NlnOztcM5suFWE8NPZdiy3Rp+EqF3bTbeCFJhiU0ElCjTeHXQoVbr
         qG+5u+azbstk2eFEjK80cz4WbAe4glSMuSzYvbWGPZ0sOwJiwlD6TSSgrbE9P2zcxcDm
         9OkUuBiRON959n3BeedmIpDy8xo6vSVU44xV7GtCvtEr/OiCO+ZPxvhuPOUxQ35hL3m5
         YXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969770; x=1706574570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bOLY9JEWCKnhtrT1pNUK8IfJyPj65lMh/72p9SVeAA=;
        b=kZvji8KpnU3wZai2y/CdfneJeaqZGLBoZ/EzRKnZp3+VlMLsPBA4QSrYzwZolw2v/j
         Ak3GwBA25Hv2vzk9/udA3q6Ni1xfrYOXyawQ3QLbk2kQn3MP6YY+B7QlHka9r1sz+1ui
         sCgHFOcVbYRQQYoPeG8WohwnL4rfUpCpDQIjyHeXDIA3aXCzO/Wp67YXws8DJxceTr7w
         IaE6k1vyQJDDcz1xQTtqDwmTnRBSMJt322bLiRnjkMW0+gaUghrL5pzZVVqy34LCfQJx
         okrxQeK6N9xc8XsurIq+MrBn0Vzp5rIn3MYRcHKZqk0gaLphz2fvS7NRdY4WbkZB51ld
         /uOA==
X-Gm-Message-State: AOJu0YwZ+DE/yHEA9K5cE4bAL5EIw3Njbpga2V9s3UP58PNkvWC1HaVz
	6ayWRHWT1XBpCqwexWxdARV8VTYxY4Md6hSfbhM1ahKaH5YV2g3c
X-Google-Smtp-Source: AGHT+IFKgJV/Q+VNzOEZbnCM1X1zbBQVZEsPxpV1HYkxgavERfUiGonROsjVEtlUHL8EBQ28DgNuIw==
X-Received: by 2002:a6b:ed08:0:b0:7bf:9e23:99a3 with SMTP id n8-20020a6bed08000000b007bf9e2399a3mr796042iog.2.1705969770370;
        Mon, 22 Jan 2024 16:29:30 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:3c2c:1afc:52ff:38e7? ([2601:282:1e82:2350:3c2c:1afc:52ff:38e7])
        by smtp.googlemail.com with ESMTPSA id x7-20020a056602160700b007bf0e4b4c63sm6545865iow.31.2024.01.22.16.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 16:29:30 -0800 (PST)
Message-ID: <3058351c-c859-4023-9608-9b7b1c8e4bb4@gmail.com>
Date: Mon, 22 Jan 2024 17:29:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Vincent Bernat <vincent@bernat.ch>
Cc: Ido Schimmel <idosch@idosch.org>, Alce Lafranque <alce@lafranque.net>,
 netdev@vger.kernel.org
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder> <d94453e7-a56d-4aa5-8e5f-3d9a590fd968@bernat.ch>
 <20240122161005.29149777@hermes.local>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240122161005.29149777@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/24 5:10 PM, Stephen Hemminger wrote:
> On Mon, 22 Jan 2024 22:11:32 +0100
> Vincent Bernat <vincent@bernat.ch> wrote:
> 
>> On 2024-01-22 13:24, Ido Schimmel wrote:
>>> s/flowlab/flowlabel/ in subject
>>>
>>> My understanding is that new features should be targeted at
>>> iproute2-next. See the README.  
>>
>> You may be more familiar than I am about this, but since the kernel part 
>> is already in net, it should go to the stable branch of iproute2.
> 
> There is no stable branch. Only current (based of Linus tree)
> and next (for net-next kernel).

to expand: iproute2 follows the netdev model which means -main is for
bug fixes, and -next is for new features.

If a new kernel feature needs support in iproute2, then the patch to
iproute2 needs to be sent during the same development window as the
kernel support. New feature support will not be added to -main branch
regardless of when the kernel side landed.

