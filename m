Return-Path: <netdev+bounces-88033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1F8A565D
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F7D282261
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9BB78C75;
	Mon, 15 Apr 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YriKVBW5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCAF76046
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194855; cv=none; b=gCczXaA3qb2KaFXkok16r1bxkRg2O1vDwtXfR2vE/A87MRx9PcafblnY7IWCXkvGdJAuXiD/Dep/5Gz29wB2/lovNU4En4euBH1MshkYRE7386JRSu06lsLf3dPG1W1S9M03r4FwtNKPbE6dqBgHo0DnHvRG1UL0RpvTNvC7FOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194855; c=relaxed/simple;
	bh=U6MwTHQts3ueK1pmFz5i4IUS0KYgsWiNF2E+bQp/GBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FB5r5KY2kFHYpTvJ2c24JUKElviOHzb8BpUpwZOrZP4URKmj9bikUD4OaA58HMSo6y3IU4d1G1k+l/jrdS6VNN5V8zUU+SJmw6vNppSC2VWhrX5W5Ww8UXauTZD2QvYU0Vq1F11dr4vUAJGStTQqW2Utm72xYkbq1TEfEa3nh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YriKVBW5; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43493745415so16034191cf.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713194853; x=1713799653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WNbDcb5ydh2sjgDOavChgiz7jlCWIxUV458orncVUFA=;
        b=YriKVBW5GZtMLKFZUDK6oniQGQ0q+oI90rLg21558vJ4AOobEjXMziGebdOIwerbRi
         xXUoH9lOIb4zsq+PGTGOqi65UMTnOUD1IzjMg2kjR6PPp31+yJ5sfvzXNXl9WRdOxY4Z
         9VlgWXLgE2tVubZZ5hFcx/SkhO4HK0KAkDY3AZOP0XrloW9KnzSlUZhjLJpkimi2NUno
         c97HxWpQ5zDnILrNqNuUA7XBrMo77guiMBpsSloP9WdNZwoPFZ0o2c7HeKHChEqisNir
         kuuOPvC0CHp5iTNee1Tt+W60iE2qmctuOIeLOcARMHkPOgfXFlZyfEde7qzwintCooYj
         1zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713194853; x=1713799653;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNbDcb5ydh2sjgDOavChgiz7jlCWIxUV458orncVUFA=;
        b=YzmILhP63KrggwXt4a8gT1H7EPq9+Xhi+856W4Os8p/XzOJ8hWycgFxi0C+9cqCTsr
         E8Lhc65YtZfLD/sgKESrflfLHIocZZjT8vJmu4P7osk9WeKRPIQ6ylVb+Z0cnG1FI3Ih
         M78QBh3VdR/SGHOt55XY7qRUiaokFUfR+ZBValTY57HJFhhtM2RPChfx61GFqJn3oTxR
         bfvZmjMZXCpyB+8HyPqAlizzrAtOjaA7f8074VIDgwt0JNLB6TBcKI7ihDGDVCs8JTzy
         yuIG3m/N4q9qRu77KuzcEh+IsFfB+jXB2zphEO/AAEpd+Wz7UmckFgrnbWFL9RQVPKjf
         fdEw==
X-Forwarded-Encrypted: i=1; AJvYcCVgY3Jq87M2NKVdDbfK+Tbex1TyYPXrQ7Vw9q0DRKiWgjjjgClwYZo5KGS4HwHZO/7q42lq34efb4POg/uQ8sMnRGrgB5rb
X-Gm-Message-State: AOJu0YxnckvSr0R5jA+EmmXfIYOaKus0j2j2vVv9sA2Jx5rd0BeKCboY
	Q4B1OBU3OcCOtYCDQLbxCJ9FaSlQP3BaZ9I1NDQ+xXWvfW0EVjlm
X-Google-Smtp-Source: AGHT+IHwEQWcmhY+GTJHeaOIYVgvgOsWOKkWAklfy5ZunmvAu7xqqynEa2yP4f+OWVFNloKZzvQkxA==
X-Received: by 2002:a05:622a:308:b0:434:5e7e:9538 with SMTP id q8-20020a05622a030800b004345e7e9538mr13458965qtw.16.1713194852772;
        Mon, 15 Apr 2024 08:27:32 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id h11-20020ac8514b000000b00432bd953506sm6132256qtn.84.2024.04.15.08.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:27:32 -0700 (PDT)
Message-ID: <2ff3df2f-a300-45fe-95b7-64f4b5190f90@gmail.com>
Date: Mon, 15 Apr 2024 08:27:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: qca8k: provide own phylink MAC
 operations
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <E1rvIce-006bQi-58@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <E1rvIce-006bQi-58@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/12/2024 8:15 AM, Russell King (Oracle) wrote:
> Convert qca8k to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

