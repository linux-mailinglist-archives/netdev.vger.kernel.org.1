Return-Path: <netdev+bounces-187389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF9DAA6CD1
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B339E1BC1E86
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3722B8D4;
	Fri,  2 May 2025 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGM3UH/B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566E1F76C2
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175571; cv=none; b=nA/YrREbrtFPt2ST7Zh6QHQImBJ5SIEYOXjLtZ10WABowv5mnK7YwkJcy2bJXmampfJ8ucnLO0+9NcP6mWqgxPtSRkFX+lYZmSnr7XZ2KCzRneNEG40TGDLkK0I5M/BxUZopnrNc15dMoiJVab1Kmej56cO+CaNy97GqxmuBG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175571; c=relaxed/simple;
	bh=K4n6OSMgmZzGwORvCnmeTSGEVj5+u7yaqDjtdKdNNnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ro4x0g3CLXlvemPH1ChErmleMCr9x8tKHoCBvhMF3i8nigbqQVsgGP0mbauptKHAbRirqrqpZXFyYXSC9ADWazxqvNU8WQCmaUl00ypQhIEEnAEzYbqwx//SVHBb5lpkWsQ5f7VqhR5n3C4/np8m8aflZVgzV7x1IMqX/JrWiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGM3UH/B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746175567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0S/o6xgo9t+7UAMzIJWxBv0bL1jmctzRzHr37NpFa0=;
	b=SGM3UH/BmyH0KflCJex0PM702zT9kZ2bNcZdyLWazEXMUngHK3OCtJmwfnAGQ6DfUyM58n
	Nl+M5ujU4ov1SR51pl02ZDHXCcUUb5GO/hVF4Yv8h9yaYkh8e9F72v2dpzYQjkjW/2RTDD
	GSNzUYyjl9H3gmwq9ya07PWcUE9MFcM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-_GMyUpQRPq-H18LTysYF4g-1; Fri, 02 May 2025 04:46:06 -0400
X-MC-Unique: _GMyUpQRPq-H18LTysYF4g-1
X-Mimecast-MFC-AGG-ID: _GMyUpQRPq-H18LTysYF4g_1746175565
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a07a867a4dso881491f8f.3
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 01:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746175565; x=1746780365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0S/o6xgo9t+7UAMzIJWxBv0bL1jmctzRzHr37NpFa0=;
        b=h8YJeAulatSjgWsEt4VAabkii1LSW4pkJbZxwPwBMpii5EsGuI8pWZTPaL3Pw8cj7U
         ymhInB4wkKi0ZslHsMCEFBhLBETfb7W4q9D/gptYN2822I7CGYtH7H837K7xyvJQ9/8b
         WlRHdLxbAbBsHtKnVtO6Gk9MME8l8db1KYfiOQjImUKRujmPQm4a4ywUgkCmVmK8SkAj
         JKu3TfXasyAskPCYsIjMRLKNgL+K57KZpupDBQMhBWDE3vnvw+99j/gfRUPgABBz8DU7
         K+gnXfZbjW86EXwY8g56dfCKMmuePu7exdHmKDQKJk7iI1dR/Cz8y3EaxANm5hH+x6kF
         6Q5A==
X-Forwarded-Encrypted: i=1; AJvYcCWnWjdYdJ8VkBcLxNudSDhAEwwgKkRMyS5tLWrOnzdDr2gunCBcddOYXsZEOISOjk2jCyXy3Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrHV55gX77Nl2zIpyXSDrSlRs68BQYj5cnX9gUlW1jNZKpVBQ0
	ZcvYh6GawqbA1J7/WuPK6xdCWuUiif9PElkbS+jCAiNwGHbCPTfivderOuOFSzcYSyiDTPdRIwH
	rJKxfHOezivuBZqMotH4OYQpkirLwtnBs0+zAFGW/NXliGmwUm7V4ow==
X-Gm-Gg: ASbGncsye0zaHPCydN88uEZf+ENRoa2JkzLYjM7r4a9moLdnfalRUeAwtnpX8/BLaTS
	kUryhAbICg95kmTPi5Am3QD1+pDre7sw35uVVLfcpDLxG4Xs5oOGcSE6OosjqPAKYXEo/dkW44i
	NAprVAjfXfbFmGbJrgdKyhAaP1IL/5zx/pUR8StvWwkvmQa8hJ/9jv3ZEvxZ7GfBv2DUzvkUXMW
	Yg+MZXnlUljKuaTNW3mnX3iId1D8Bbh2CI4+GwMlghs4bJuNI4WjQEb93LT0v76N3+MOQ7reTOu
	430J78jyFTXUKfPj16g=
X-Received: by 2002:a05:6000:4008:b0:38f:2766:759f with SMTP id ffacd0b85a97d-3a099ae9d04mr1137180f8f.41.1746175565326;
        Fri, 02 May 2025 01:46:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTEziSGfOUv+JnuXr70r6TvcxY29K/JkxO4QYwaYI++/LoyBYIanXjyXfHCszu7xVy4fBf6Q==
X-Received: by 2002:a05:6000:4008:b0:38f:2766:759f with SMTP id ffacd0b85a97d-3a099ae9d04mr1137168f8f.41.1746175564990;
        Fri, 02 May 2025 01:46:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3b62sm1534788f8f.34.2025.05.02.01.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 01:46:04 -0700 (PDT)
Message-ID: <f82fe7ac-fc12-4d50-98d4-4149db2bffa0@redhat.com>
Date: Fri, 2 May 2025 10:46:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: expand and
 clarify EEE_GET/EEE_SET documentation
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
References: <20250427134035.2458430-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250427134035.2458430-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/25 3:40 PM, Oleksij Rempel wrote:
> Improve the documentation for ETHTOOL_MSG_EEE_GET and ETHTOOL_MSG_EEE_SET
> to provide accurate descriptions of all netlink attributes involved.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

This looks like an almost complete rewrite WRT v1, a changelog would
have helped reviewing. I'm unsure if it captures all the feedback from
Russell,

/P



