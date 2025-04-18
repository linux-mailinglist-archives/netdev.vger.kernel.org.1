Return-Path: <netdev+bounces-184111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FEBA935E3
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BD18E32AD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AB52586EB;
	Fri, 18 Apr 2025 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZtjOcg7X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF8254AEF
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971324; cv=none; b=EzMOW0nW03LJJMHuyRWSguSYrKQW6/1tn4SrHdbM3FDDatI22UxSMPZ8Ysy4NH+McCND3sKBqib3CIgn9K1pGCFnEyWckenXGmVfFs4VQTnFYNNJLDOEuRFaKajzLJUGAodAfRnE4iaU/ZYs7MqDno6Bwmq04PRal7EuZI2g7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971324; c=relaxed/simple;
	bh=37tl/LX/bxQYI3COfj9UlTXKLXaBbKnlJVfNUowpuUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZtkvI5yGYJW4y+owAYmC86336eDKbf33MADQDpMUYt6MxGzNHyx62K8exZc7mjO20l2tjL8e62p/1L+02bboIZBkbzJGnZlEo06uqwDwCaFWNV22K7SxL0ACSIzVX+z2ysXliTkpC/MmZG/WYy1G5oQsJZpUt32OiEp8uzwoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZtjOcg7X; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso1121587f8f.2
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744971312; x=1745576112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ar6Goz0eZAj6x/Qyy9ODaKnE/UHABk8XbUh3s6MLuno=;
        b=ZtjOcg7XXhMnSePgi1SUt5fKLMHvn7/D38J53PLt9r9bGV3XBpwlIrBzAsqExJ0Ihr
         E8nGSIVftVd3Ym0XM9+5E0pvTmxe+EdKsqP1Cbi88dpEuEtI20Rc9bsldGI2edyHtztG
         LXlpnpNeKSqE1ERGiGo4maoJqUz2Ghe6CgshqiCZO6xd6eal62J2AQX/uls0bOEn0tDZ
         ZCDRLuGUWz4erPfSkMajdLZKYrRpnhetuKyMYdAiy1g5i99Ugalk705z+e+UTMF/zdye
         IXh44HGr5XCBc4oTlFK0tTG2cXMpxadXs97xXeswlz0RqBMEWJzd4zKkBSl7WKZTgDnJ
         ooqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971312; x=1745576112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ar6Goz0eZAj6x/Qyy9ODaKnE/UHABk8XbUh3s6MLuno=;
        b=YZ5YvojaR23twcY70rfkJPf3q1jLN7+BnOpP2ObbQ18ynSkF2cFEgcIQkfhfQ6jzG9
         WMwSptAvvrz+HlEyaVd0UYQw4KDvGMzKZRGBsdmP2WJASxt4md0UcfnO5bopCV8SMb3a
         6EwWlysFHIWo99zXQll1Vzh+YRQQa/RblDRA/8cSABIjK8ok464VlaH0TFaHuW5p0h8Z
         jXcQmirg1yPB9Pp8SnjTjtRMIyypw4gwKcTCaveWYXZdjIRyubpd7xWtikyAcjXpK8nL
         zuwltKrP2Ip8QZGQzmNVIrLUedrUv1/CLqThGO69T+51Mw+TYcuKlq2Kh+jPq4zMCea/
         nNxA==
X-Gm-Message-State: AOJu0YxiIOaCHGGYcYN+iqTQUSJfx9c9qMFRYYVM0mepRgWAjvGMuBfD
	Sjv9RbjrAehjb4YjSH8KYbCigRguCVh8HKpa7yZWPKDsL5TIG/U19cAYiUF0p/4=
X-Gm-Gg: ASbGncvpooZyVYRaYV7vkgVdvwB19wXNd4jJ5Ec3nVolNXoulz5VtS1agTncwJewmK0
	hXN90T88pvES5HACxMQM8Mq67lHTkqwCGv8/d/uOVXgCULCxBWvGg6QMApy4stfu1YyleayagfA
	dh/pUAezNCXaPcExVpy5Kwe3Qt/L619UouST0QjN7j8aj2HS0NIgeX3rC8b33ENFJY+fSWOJcF+
	QnZRBlHhZgzurkDZMgkLLd2IznSleEA4TakPOy58a0Oa/DWrlzb+tXsT0qV/ZoTfxKYIfQA2ZgV
	lD705HTa4vPaIe2gNwJl5Wp9P1+4e1Orb/WbYkRsgqmzudbp
X-Google-Smtp-Source: AGHT+IGOhSZPCbuXCHMKbTav072M0rp6zWXhfd61IEM+NhLvGJAc0dTn8WyuzvGKv7VjHT/HuAcBwg==
X-Received: by 2002:a5d:47c9:0:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-39efba38482mr1527033f8f.9.1744971311539;
        Fri, 18 Apr 2025 03:15:11 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6dfe4esm16144975e9.33.2025.04.18.03.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:15:10 -0700 (PDT)
Date: Fri, 18 Apr 2025 12:15:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com, parav@nvidia.com, 
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
References: <20250416214133.10582-1-jiri@resnulli.us>
 <20250416214133.10582-3-jiri@resnulli.us>
 <20250417183822.4c72fc8e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417183822.4c72fc8e@kernel.org>

Fri, Apr 18, 2025 at 03:38:22AM +0200, kuba@kernel.org wrote:
>On Wed, 16 Apr 2025 23:41:32 +0200 Jiri Pirko wrote:
>> A physical device may consists of several PCI physical functions.
>> Each of this PCI function's "serial_number" is same because they are
>> part of single board. From this serial number, PCI function cannot be
>> uniquely referenced in a system.
>> 
>> Expanding this in slightly more complex system of multi-host
>> "board.serial_number" is not even now unique across two hosts.
>> 
>> Further expanding this for DPU based board, a DPU board has PCI
>> functions on the external host as well as DPU internal host.
>> Such DPU side PCI physical functions also have the same "serial_number".
>> 
>> There is a need to identify each PCI function uniquely in a factory.
>> We are presently missing this function unique identifier.
>> 
>> Hence, introduce a function unique identifier, which is uniquely
>> identifies a function across one or multiple hosts, also has unique
>> identifier with/without DPU based NICs.
>
>Why do you think this should be a property of the instance?
>We have PF ports.

Ports does not look suitable to me. In case of a function with multiple
physical ports, would the same id be listed for multiple ports? What
about representors?

This is a function propertly, therefore it makes sense to me to put it
on devlink instance as devlink instance represents the function.

Another patchset that is most probably follow-up on this by one of my
colleagues will introduce fuid propertly on "devlink port function".
By that and the info exposed by this patch, you would be able to identify
which representor relates to which function cross-hosts. I think that
your question is actually aiming at this, isn't it?

