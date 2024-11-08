Return-Path: <netdev+bounces-143421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7C69C25EE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528261F225CD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFAD1AA1F4;
	Fri,  8 Nov 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUaX1rcZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23451990B3
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095806; cv=none; b=oNTB/UHx2l0XaaNBTbHnpBy/f+NN97Rb0iQ5zTu3/fjgvY67SKiM13xxpk69mJ9KX+Ff/Y2q3tLKqbG8DZ2SPMPyt/hQCSOQnN3xcaRrf7MUlLjASo0XA9kT7XG9EdLG56jcIoLJ9HEP8Oq7mm9LQV9fNODqBdozPczlCDkbtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095806; c=relaxed/simple;
	bh=HcqYMtQi9+yM7VVPHPyvFyj5lhzi4OYqG594F/rXDr4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dQ93dbfxTgQqRggonR8lZa1oP83pFphZ9vPSSsM/oIW0xExXUKSedwFamHguLbSeavYOcu3ivSy9+f5cIW+83Dkw+jABfzjYse2dH+s8yxjyZzsiy/E5pBnn372JOlO6wUrJ4A8+MjfwlQmJ/4NqkuGbzZHJ4wB5gU+dR/l6EHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUaX1rcZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso392874666b.3
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 11:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731095803; x=1731700603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/svvMOmwbpZns8Qqc7goCFjEY0buCpbK3MS1Rsur8g=;
        b=OUaX1rcZjUYNLINBpxZyhM8bl6KdvuRO4RzUQ0XhpgICK5NnuYWJLcwUEk3rhRBXkU
         Pn9AtlMyA87pOmvzGvmKb5ZHmY3nja+Lg2jOk0IFAwldpoKAweomkzlTrAF343sez4uw
         4ypLpr/FWE8HZrqenF1Aa7dR9POVQX6KJ6GT0LRNANo7Pp7PtnC/qwNhMDWNCAJHRrgT
         JQaEHxCQ+32towKJm0uB7GF7E1A9pMysYY7bsKpYEfMUM8Yz8tw7OPZodS7J439wZceH
         TI9ACXliIft2su4x7bPsDI+Qv/t6epB0QDJprXaUmgzwoz7jxsUr24xpr5qyPrNW2An6
         zX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731095803; x=1731700603;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/svvMOmwbpZns8Qqc7goCFjEY0buCpbK3MS1Rsur8g=;
        b=Um11O5SCn1aMj79x+hq6JmBdsgKRUmkKGwGxFlDo4RWs/hNuO0UJbMi/Vax/wjfUVY
         6bKMGFB0qUDRS+Loc3LIO4xoru51qP465Hob00atXkZ5iJipkcy27kMIaJpIxeKmFH9/
         3dwQ7IGRX0UGzenpu30lW1jkXAXJCl+JXBEdLZs2eMq8j55pbermaxZK1T4pRcZRDDPD
         QS9AxqnjeBujSeKazh2oQhbX8WZcn0ra3+RXPUQ8i5nTdJW+sJLNODTKDGkEvOr0b4JV
         lUZnJS0CPuoATwBUprWfxJUZV0LK26aChgm0w8mXXPfb21y8lMRS9N9q4nFfp6wtNvd0
         iNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuE0c4Mbi6gq7AgnuNYI5QY1fIiTS84bhN3FA1YpqRSWASSgUTQh5gfsxHA96oAPQwP5gjB9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8K0uiYjSBJ659UCYGTDLue2W9jkyjqORYzDBI72vnFbannHG
	qfbRNmOe1bQoDDbPzHrlruqLSb4GUie7PP9x1DDx6P+uVG2bsSsS
X-Google-Smtp-Source: AGHT+IH/IBl7juMcyY1RNHRNqgS+qxmtT09yVC0DcMxc2jPxPqUamsvPZ9qxtdflJAICO02VuJiZiQ==
X-Received: by 2002:a17:907:7e8f:b0:a99:f887:ec09 with SMTP id a640c23a62f3a-a9eeff39e7amr395031966b.35.1731095803023;
        Fri, 08 Nov 2024 11:56:43 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2e908sm270873166b.196.2024.11.08.11.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:56:42 -0800 (PST)
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context action
 explicit
To: Daniel Xu <dxu@dxuuu.xyz>, davem@davemloft.net, mkubecek@suse.cz
Cc: kuba@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 kernel-team@meta.com
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
Date: Fri, 8 Nov 2024 19:56:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 08/11/2024 19:32, Daniel Xu wrote:
> Currently, if the action for an ntuple rule is to redirect to an RSS
> context, the RSS context is printed as an attribute. At the same time,
> a wrong action is printed. For example:
> 
>     # ethtool -X eth0 hfunc toeplitz context new start 24 equal 8
>     New RSS context is 1
> 
>     # ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
>     Added rule with ID 0
> 
>     # ethtool -n eth0 rule 0
>     Filter: 0
>             Rule Type: Raw IPv6
>             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>             Dest IP addr: <redacted> mask: ::
>             Traffic Class: 0x0 mask: 0xff
>             Protocol: 0 mask: 0xff
>             L4 bytes: 0x0 mask: 0xffffffff
>             RSS Context ID: 1
>             Action: Direct to queue 0
> 
> This is wrong and misleading. Fix by treating RSS context as a explicit
> action. The new output looks like this:
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
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

I believe this patch is incorrect.  My understanding is that on
 packet reception, the integer returned from the RSS indirection
 table is *added* to the queue number from the ntuple rule, so
 that for instance the same indirection table can be used for one
 rule distributing packets over queues 0-3 and for another rule
 distributing a different subset of packets over queues 4-7.
I'm not sure if this behaviour is documented anywhere, and
 different NICs may have different interpretations, but this is
 how sfc ef10 behaves.

-Ed

