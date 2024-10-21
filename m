Return-Path: <netdev+bounces-137546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BD89A6E20
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C119B1C21A2B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEF61865F0;
	Mon, 21 Oct 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7mXt33i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402418453F
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524574; cv=none; b=XBHW3Fb9tGx85jSwXupQWfk/4KCX8hMUha2gYOsIu/ztwh8/fA1UVxHktnc9rfTfYuckefdvlqQfMyaLNExywi6ujjWPs/HhZpy19lpFOTYoQmJ1I+1fYqt03DebFzV7tYRaQlizPw+nyhRwaZJxL3WNWNqPI7/0+GNzdNr9DEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524574; c=relaxed/simple;
	bh=iWtNGW5Lv+npAxLvYrzDrlBlld7h6q5Bl55LXxDdRso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJASahEfz86KAL7f3PNqRHkYo/hFZ3iKRWCEGtK+wqdfaJ9+rDjTB0FqQSwbzW0cc2nwPbC8yheO5rkg/ZayT4jB3kooni+RflZHrEJXPsEZ52dT9swfDleDRBHlRnIaNusElfAiQRmDYMcTMNQWPe8ZfT2IVTA6nrn49OmatqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7mXt33i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729524571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6AOTgcFjOO6pusSxpBSQAWFHjn8ww3tmBzZVY0f3ik=;
	b=V7mXt33iBsCWvZrWtCw/vRifvWrDxvHjULE7gKuPN8+US517C8paT1uEURlEdDM1KTqKf+
	eQI+quqWF4tgpCZLpBLt48nhdgR97HDM2ei3gzt+DwltZMVBXUlUwC/BSEFBDaQ6sMimzk
	ge5QMS5KoMQkFav/lUvHfGmt8VoH/A8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-yiIEqylrOU27ZiR36LUlrA-1; Mon, 21 Oct 2024 11:29:29 -0400
X-MC-Unique: yiIEqylrOU27ZiR36LUlrA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4314f023f55so37658235e9.2
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 08:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524568; x=1730129368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6AOTgcFjOO6pusSxpBSQAWFHjn8ww3tmBzZVY0f3ik=;
        b=qx8tsUdo3FuLKzmiX2FQeDkFiLWinSYfF02LDVNOynH8BDSbZaPlXWjHlXXKUt271f
         HL4jwvlXzcJTMcP1nYlGALzO8MdmAxhCGXj/Lv4BoJ68rphS7VnP0RkgZLPQO+xUPgrL
         OXo5G5xq+07+LhJT3yuAL/Grw+KeCTWHMXJFY1LtTao9B6RcEUiiLcnZLYWjh3x49Gbi
         jrxhxslnrzvv/GjObKjxfT30QskJGLK8exf09wSfxmJ/9QWtHJaozohA4M1XK8NQCel7
         R9Ph1TM5X0VvaQOnxc5AmEgkDb4G52T+BCl7wPh2VxaU1zHks+l5gwE11BC7o7QJWsIU
         NYfw==
X-Forwarded-Encrypted: i=1; AJvYcCXTpvfVW4ZkW5Rlx0q9MJDquc09YQWv7mpdeVK9kyagcHu6yBQ9u/HF3N/OGRgF/mgHuwVVmxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWH0WKlbKdoKhshPW70HFQkYG1uTw8yizvJTx9T3h9WBSGlf9E
	J5F/DjSitB41sKS7oKarvva9lC7YtsRVnqVfYEqyrhHB3gtWbQxoBohz2+S8YX2NruLi0h+e0f3
	letPeKugvKffwXmZ7JlHH0snP+dQtZ1pe+SD6wTCh6btZ+g+oWvk4Ag==
X-Received: by 2002:a05:600c:34cc:b0:426:627e:37af with SMTP id 5b1f17b1804b1-4316163330bmr91910255e9.3.1729524568389;
        Mon, 21 Oct 2024 08:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET+SVD6cbZPCbhAIxGjhJyIGRpEiTOiTUfwm0zjdZFXEhVQsAXQnRDfXRtvoOHzmodD7KyJA==
X-Received: by 2002:a05:600c:34cc:b0:426:627e:37af with SMTP id 5b1f17b1804b1-4316163330bmr91910075e9.3.1729524568028;
        Mon, 21 Oct 2024 08:29:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570d49sm61532135e9.7.2024.10.21.08.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 08:29:27 -0700 (PDT)
Message-ID: <be9ead27-bd67-49a8-a311-a7ce5e82d4fa@redhat.com>
Date: Mon, 21 Oct 2024 17:29:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: bluetooth 2024-10-16
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Eric Dumazet <edumazet@google.com>
References: <20241016204258.821965-1-luiz.dentz@gmail.com>
 <4e1977ca-6166-4891-965e-34a6f319035f@leemhuis.info>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4e1977ca-6166-4891-965e-34a6f319035f@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 07:30, Thorsten Leemhuis wrote:
> [CCing Linus, the two other -net maintainers, and the regressions lists]
> 
> On 16.10.24 22:42, Luiz Augusto von Dentz wrote:
>> The following changes since commit 11d06f0aaef89f4cad68b92510bd9decff2d7b87:
>>
>>   net: dsa: vsc73xx: fix reception from VLAN-unaware bridges (2024-10-15 18:41:52 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-16
> 
> FWIW, from my point of view it would be nice if these changes could make
> it to mainline this week. I know, they missed the weekly -net merge,
> despite the quoted PR being sent on Wednesday (I assume it was too late
> in the day). 

The net PR is prepared and sent on Thursday morning - either European
Time or West Cost, depending on who actually is cooking it.

Wednesday is usually/nearly always a good time for PR to be send on
netdev to land into the next 'net' PR, but due to some unfortunate
scheduling, we are lagging behind the netdev ML traffic - to the point
that I'm processing this email only now.

The limited capacity will last for all the current week, but we should
come back to speed from the next one.

Cheers,

Paolo


