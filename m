Return-Path: <netdev+bounces-144299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04209C67E3
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 04:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F711F238DB
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D312B82D98;
	Wed, 13 Nov 2024 03:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiiYDU1z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615A1C32
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731469112; cv=none; b=pPa+MfGRABQ9owpDPmJkbVEmmB8CchIBjYAXn4iGGWE6y99iirCrvz0UvLegfWLiXrmYmRMgc0ZYb/97YfaxPsOvM4n57/rYagqNqDvEpYG+L5PsGqNXsopDQl+NQgkPTN270Z6Z7o2WVC91w/1uv5lknYOF1inYS67/Gw4QwYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731469112; c=relaxed/simple;
	bh=9OMrfdcMjY/w/J0HDNJ/y5xPvKcrYRucVMwDxmrTOy8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rYJ05eF3xUuGMTesBrOWKYSIHll0YiaA4vfcqkDbjNGJu9opzRzvwkV7BqusVC8uJCrOjwxoulDEtOxvfWhMIFdNPNFO/JEJBpsPyGL1LE1PScNUH8xLn7eEHj87kJOEtzfMaPHTbfpf5whVCJ+P7enqTPDqzxjZz0y1OCii+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiiYDU1z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43161c0068bso55212735e9.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 19:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731469109; x=1732073909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZCG8wmFJMOlggT8MGkPixBakRykFW7p3HDe6/A9QkI=;
        b=FiiYDU1zlHVXeE5cSmHj/UWnVlFkhqsZKz2JpdxWYtUgzetpOMpMYAhFg+37ChW8k7
         s+aQv91VFe1Csdo4wYuE0a8BvgcgpGMWFR8eplL9lkrzAarsK26eTP735jFMo0TfSwr8
         SxYlfzc7oyLG011svgFPhjv2F4wc8Ra3640woIIicBOFK+tMmKi3YLAPF89NaWGw1EAf
         oBycapHwFhP1QT7KGaf6BIanFjxUbZPHtGwWUhkOoMtnTCQ5J8MQErADnSrjmbSki2gh
         nBcK7tEaFoqphlLzy97c+O5U3WtVa8euXyhJ/nw1+b9N/PBNhusr9rOsOcRjhIz4DyxN
         4RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731469109; x=1732073909;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZCG8wmFJMOlggT8MGkPixBakRykFW7p3HDe6/A9QkI=;
        b=sNSY24QMt13557q5SUr6msIqhc+M3UY4JShjaAICAFVw1/+5KjlIWhE+OtUZEXiT3Z
         VJDWsjS9yN3H9MeIGbWlYLE9i2J4aAjDg9Kj0wLYwI7B1xJNcshz24rok+Gbf+hjX0OF
         SqZuk3WnpwwTUjsx97KMwU1J9P0uaQf2G5Y/m1WzHVY3uTZ2uNsM6lMCqb6uU1tB7hiF
         AstJcsD+6x3aXVqypvja1j2xOjhiPSyvft6Zci0ElyasXOo1XnqEOw6iSzkkP20Zu+AJ
         1z94iClEsupdYSM7IjmclphqsmD3D0bpljYtqT1w7zwNQ8dX7IdGPB2prL2dxUwcALWV
         3Heg==
X-Forwarded-Encrypted: i=1; AJvYcCVzuy5WGZEBJnojDYJUrXubwVkjZ/CNR4IKXTD/m8Jqfr9R5e5KSIE8eRq+ml+dOgJU9+UiZr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/UEB13QPMJiyXqkETQXvnTJvyvHXDD5Iw0GmgaDKdf+nD1Lj
	Typ+r2CyJZlStYtg2lhN4ktuUvUeXs9foVQqRoNzMVTyOe4BSp1M
X-Google-Smtp-Source: AGHT+IEXnJzXqiG1PRkG4TwqarQ4PhXQQLsBaoeV8LU6XDeJRy8lTrTDXG4zYypOYLTbtRTAtpIAZQ==
X-Received: by 2002:a05:6000:402a:b0:37d:51bc:3229 with SMTP id ffacd0b85a97d-381f1885024mr13425722f8f.51.1731469109326;
        Tue, 12 Nov 2024 19:38:29 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d550ccf7sm8067695e9.34.2024.11.12.19.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 19:38:29 -0800 (PST)
Subject: Re: [PATCH ethtool-next v3] rxclass: Make output for RSS context
 action explicit
To: Daniel Xu <dxu@dxuuu.xyz>, jdamato@fastly.com, davem@davemloft.net,
 mkubecek@suse.cz
Cc: kuba@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 kernel-team@meta.com
References: <e9de21b76807da310658dbfd46d6177c1c592fe7.1731462244.git.dxu@dxuuu.xyz>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <1e021aad-21fc-9e28-37fa-a916b8791178@gmail.com>
Date: Wed, 13 Nov 2024 03:38:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e9de21b76807da310658dbfd46d6177c1c592fe7.1731462244.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 13/11/2024 01:45, Daniel Xu wrote:
> Fix by making output more clear. Also suppress base offset queue for the
> common case of 0. Example of new output:
> 
>     # ./ethtool -n eth0 rule 0
>     Filter: 0
>             Rule Type: Raw IPv6
>             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>             Dest IP addr: <redacted> mask: ::
>             Traffic Class: 0x0 mask: 0xff
>             Protocol: 0 mask: 0xff
>             L4 bytes: 0x0 mask: 0xffffffff
>             Action: Direct to RSS context id 1

Commit comment hasn't been updated to match the current patch.

