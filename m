Return-Path: <netdev+bounces-137241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C9E9A515F
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 00:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C62283DF0
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 22:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C635192D69;
	Sat, 19 Oct 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsBARTou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D418D622;
	Sat, 19 Oct 2024 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729376474; cv=none; b=Rey5oYJSE1T6ef/KgRzwWr67tkvfehIZW9/fOdIc2Y4PEDVPGRbUftJMNDLeRA8m7zFwn8i2IuZIsrL69SieYxXS/E4rVlO5D90y8nFvb84/4gEvcm8vLlDKkoiAAloRPlu/GEl4/4ufjnSTJwJV7DkSAoHKQvGbH76x8klMkJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729376474; c=relaxed/simple;
	bh=DW2f0dCd7lmAs3F0ZOU9WDzrALgv7Yd8I1/TQsqoAu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgPK3SWTUcF0bgVW8Pk6SoM1Xy1jnzJ+TBxqpoypv3Vh9f5QvmSpeSwUqeEKrGeIqXl3feRUQ/18p0e4TswslHCLXYgAiRakqotnhpH7xBpGd5sDzgsq579AfRIICJd7SZSOnNgYnb9omqQN4KTGiENV4N/JLyqWam7Qv8Hm2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsBARTou; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so1630965e9.3;
        Sat, 19 Oct 2024 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729376470; x=1729981270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+Gi4zOMS2jtf4kmC902rpd5Em2fADaOylgewPthYiY=;
        b=WsBARTou73hKgbs0WEWwfhOQUJwtw1tXM93vU8q4vNyZazCUc6edvpbXoY556srnux
         Om26BmAYehr6e9DGfTHL2igTy/ZRkfIugs2KVeige4rgybxU6+EoEIl8TbnRY/PtqMIz
         zAPPSk729J4ZkuVEtogAc+9mqBDtapnwhY+XOcmOnlquRiM5aENaOWVFINlULKrB73f4
         g/hp7suZtlv5IPl8T/zdxxvSo3oMd9fZJbLsZJoCrcTPtooRiWKYGtH5P8t57T9yiTjX
         2UkL1NLbLFL19+rVcz5tSZSdWLEp7cQ7kJhjCwOj/JYWc3jeSQPfD7VWZifDzkBMFQp8
         H8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729376470; x=1729981270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+Gi4zOMS2jtf4kmC902rpd5Em2fADaOylgewPthYiY=;
        b=PYlnkPeuEjAY1WPSwBapTgODlBaOsy33gHt91jr4VM/RTD5b1nMUGz5sNpDz8O9YsE
         nX9AAjC+OZ5/TGDtcJ9HjMj+QAX/lAUZ230Hj+h5IIDQGGKRm87kpcK+boWCW3oADGJr
         LJ5QmpOEaHmt4FDHdl5Irt2baxGko3g/63Di9Fai0zTG98SJaBhKt5Pp6xksXyneOBnT
         oagDqw2mHAg7aabVWPmKUSy9sjZIEID0iY30uCIS/k5nogX4uly+VKPoOpXiPIvAdbDs
         lYOTzLvV9QunSQslvuJ6iQFqXarP88bMqFZJHlrzhHSypMzwxNou2ALrkjNBb2pzUBMR
         CrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUvBMW+fePIoAY7ny8qAWmKk0wxuDRQEvU39yvkEBoBlMItPQN3xj8EkqWT0MjQ+pwZFzdf4uE@vger.kernel.org, AJvYcCWUaUjcFON8sBUKKBPqT8razpre0iBVBFD1WRfAkmsiTKsNmlpI9O4WtONBem0cXjq8ZG1XbfULBp+l1+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxS+SFg1faVYfb+Ywa1YErd4+IaCadUN7WH9d1crmY9xzCwHK8
	0i+V7loCGfutozIX4mYAfrSCQpnLwJ3gFUQvYXqZQQMyIk0AW8fY
X-Google-Smtp-Source: AGHT+IGhTtntpNIh8+aiXLujY4nU+cM525H6B8/VTJu7AzjO1voGW77dY5iSbAaxEovF+6H77/+aGg==
X-Received: by 2002:a05:600c:458e:b0:431:52b7:a485 with SMTP id 5b1f17b1804b1-43161655dd0mr48393245e9.19.1729376470237;
        Sat, 19 Oct 2024 15:21:10 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:b52e:418b:b11e:b488? (2a02-8389-41cf-e200-b52e-418b-b11e-b488.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b52e:418b:b11e:b488])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc88esm5660595e9.46.2024.10.19.15.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 15:21:09 -0700 (PDT)
Message-ID: <f148a61d-4ad5-4f62-b1f0-d216e1873067@gmail.com>
Date: Sun, 20 Oct 2024 00:21:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: fix unreleased
 fwnode_handle in setup_port()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241019-mv88e6xxx_chip-fwnode_handle_put-v1-1-fc92c4f16831@gmail.com>
 <11c644b5-e6e5-4c4c-9398-7a8e59519370@lunn.ch>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <11c644b5-e6e5-4c4c-9398-7a8e59519370@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/10/2024 23:59, Andrew Lunn wrote:
> On Sat, Oct 19, 2024 at 10:16:49PM +0200, Javier Carrasco wrote:
>> 'ports_fwnode' is initialized via device_get_named_child_node(), which
>> requires a call to fwnode_handle_put() when the variable is no longer
>> required to avoid leaking memory.
>>
>> Add the missing fwnode_handle_put() after 'ports_fwnode' has been used
>> and is no longer required.
> 
> As you point out, the handle is obtained with
> device_get_named_child_node(). It seems odd to use a fwnode_ function
> not a device_ function to release the handle. Is there a device_
> function?
> 
> 	Andrew


Hi Andrew,

device_get_named_child_node() receives a pointer to a *device*, and
returns a child node (a pointer to an *fwnode_handle*). That is what has
to be released, and therefore fwnode_handle_put() is the right one.

Note that device_get_named_child_node() documents how to release the
fwnode pointer:

"The caller is responsible for calling fwnode_handle_put() on the
returned fwnode pointer."

Best regards,
Javier Carrasco


