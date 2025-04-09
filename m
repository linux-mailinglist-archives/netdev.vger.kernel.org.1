Return-Path: <netdev+bounces-180756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A92A82556
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1248C16AA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2AF25F7B4;
	Wed,  9 Apr 2025 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQfXRnj+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB8264F8F
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203084; cv=none; b=a9I+FGoRX+2zPlA3uz3mWGsK7pRhiCDgNHtn0v/KAi8/RaZVdzqz3hkvZXDD3PRdPefeoUFbHvWvj4o2u1elQK86/QZ4ACOMSTE3PHdZqHLNazQHe6eAJhaeAU9J+24j25bRfN9MOZ7wM7414+e4kZXYFzuCspRwpvfpfvok8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203084; c=relaxed/simple;
	bh=ZL/JZ2ECHLE1H+I7CSsSfvM0Mup06T3PAeuwnPSTyMY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ss9IeQ8PnljEATPfJcMBMBIIluqj9CpRIBdssZKCTHRqiPu1NIP0+jFzo5xDD8UUlUkpWKZqnFDtGIlEuo8GW3IL7h67cJJEZC7jVI6qYFhwGYmlLWSacPnS17Vdm5cRyX3ufx1QJotMTmBy18cshRpBIeANiiyQSvzxtYZ2+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQfXRnj+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so66110215e9.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203081; x=1744807881; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bMRe0/Qc8BgXu4RZFd8WfQk/o6t3j9EROBotDvmBX6g=;
        b=PQfXRnj+zSzw2fQYik5NjbTz+f2/kMkcIVvy1uzrDBPAwA2xG3h81BIYGkNp4hHGxB
         +hUeoe83lV+oxr+SSnl0eXXvqtiCreMmeta0Q/I67A+SzK/cU5dZx4vjCgf/Nyv/ml7s
         RgRT8B1yeXTCzmwYloNKgJRRkkszBnxgycbpxz5lmjx3Z9i17ZLUWGvSQhntfNNsMPjr
         lKeflkVKg8xzYz1euOKmampPvREScLXqiG1EuO57rTtyI/CE+zgciRDjJVCnaWaNn3db
         otqEfH7fYNtWjAW1QQmEg6xBjP+cicaMymHp2awOTc/RJVNIbt7E2TWiaLK/oQ2mOFcP
         UBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203081; x=1744807881;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMRe0/Qc8BgXu4RZFd8WfQk/o6t3j9EROBotDvmBX6g=;
        b=ja7TCaJUGz300+fEwFd4fowDI9HcE5XVaXUi4oZunF1fIc5fz1A381Wk2ny/yNhvwd
         SHdzNT0DByBWmOMv1abDGQbIsl0M90syi7b2KEwzyl1/oS4ceFMe0JCRPUTB9zbg4l7c
         FNkYI5ICPZUNguaf9Twofjs6VcLSpiMnGeDku81fD22+OnJl3cNdfOvNZ6m8EQdH3/yl
         wzMAzmQfWUik9QrwXsTb97j4OCeqysCLK0mGBF9xzag2NSitqgfbjKWkNXPVyIRbQ98c
         QhJhkiSPa08/iUaKi0x6+tKd85S51MYw0NG67Kv+cboBP+wwOIPeDz7STAlGfzwruX7I
         wPpA==
X-Forwarded-Encrypted: i=1; AJvYcCXwg3oaBpYv8x5YFrKvbGARY+a18UwUxf93wV9fbVDyg3B4t1XxzFH+5UwaV2XzeXCjdmxtJuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZqk56ZrWtXb488PygrlgwAnX4MEtJ9TcuxvF+PplzPVuZfJ+
	mgTcHGvBeaXu0ahX8xQZQ3Zc0jye7YOWVNm9/q7XPJIc2/fzlOcH
X-Gm-Gg: ASbGncvgmOHmY5BpmOGz/RXNJkt2VObVeXAMvuDXDycg3R4nqldc0qGpNfb1EiZhvBN
	543CsD7lDdGgEk7njcFEzkfTLXWgalkvlFQglV9Gp3INQNwImIfQPuMwpP3nlG+JvqJfVuRyLXw
	WhESw5D+x7YS4vHWxQKPZppAKB4jfY0XrVyaClQYaOOorOQ4k1WRWXp5Abphl7MhEPD9O2kKETs
	jX80xy+o8yQdbQxYKCH96CVHuDytEF/CoN1yAZZiNoLiuSucgOgz4hRxvPbnRttre5xs5joULnH
	mXQxOSNN7GHy+MipOTfhTtevHTO5hNL32JZ5Cw1n82Gg/082thSDVQ==
X-Google-Smtp-Source: AGHT+IE5+bHzInmCqrdsOrclLinotyL/pSCByMCr8DgzNtboOeRshLd8QgJBbPNKuURwYjNrRyGxrg==
X-Received: by 2002:a05:600c:4ec7:b0:43c:fcbc:968c with SMTP id 5b1f17b1804b1-43f1fdc3e5fmr18407855e9.7.1744203081225;
        Wed, 09 Apr 2025 05:51:21 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893774aasm1597137f8f.30.2025.04.09.05.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:20 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  yuyanghuang@google.com,  sdf@fomichev.me,
  gnault@redhat.com,  nicolas.dichtel@6wind.com,  petrm@nvidia.com
Subject: Re: [PATCH net-next 13/13] tools: ynl: generate code for rt-route
 and add a sample
In-Reply-To: <20250409000400.492371-14-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 8 Apr 2025 17:04:00 -0700")
Date: Wed, 09 Apr 2025 13:49:39 +0100
Message-ID: <m2y0w91ov0.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-14-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> YNL C can now generate code for simple classic netlink families.
> Include rt-route in the Makefile for generation and add a sample.
>
>     $ ./tools/net/ynl/samples/rt-route
>     oif: wlp0s20f3        gateway: 192.168.1.1
>     oif: wlp0s20f3        dst: 192.168.1.0/24
>     oif: vpn0             dst: fe80::/64
>     oif: wlp0s20f3        dst: fe80::/64
>     oif: wlp0s20f3        gateway: fe80::200:5eff:fe00:201
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

