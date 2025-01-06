Return-Path: <netdev+bounces-155476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE1BA026CA
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508AD3A4F47
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3901DE4D2;
	Mon,  6 Jan 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkjLoYGF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8C1DE3AD
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170735; cv=none; b=DgF4606+RDZLAS/lRiYaUs8VTPhFDjllRzm3sOB93jg1LUVTxq2wNEBMOHHAuiep5ckqC88DhIm6dEI/XZJkjoujKzH4RP/CCBCXij3GdAdOdfHbH3ZdQBzb4bK+gTSI0cdDUcUkqw7V4h4XrwXjEIuo8k3/Sry6ioP7Xqkdi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170735; c=relaxed/simple;
	bh=hjCxZydMzSLqC7uozkWiy6PV/LyYEbMQsEPXgWmlDuE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=uWTRpRaOIeHV4er/oNrX4qnsn9qSrkMk8kwNs9LHhPkZUG07V31b1083QhbR/cyUqpiMvxKIGDtl1lhqo7X7Jo1cEWg+xnvP2aweQxJ4Dhzbgu/m9aSAv5r+VBifW5FLIDtNtKHoSHgHH9f2cor1Vwt/AieYj+tZuHCfmT+RL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkjLoYGF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436341f575fso148814055e9.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 05:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736170732; x=1736775532; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjCxZydMzSLqC7uozkWiy6PV/LyYEbMQsEPXgWmlDuE=;
        b=dkjLoYGF3U6VkrqA34zGZLGbySSdoEKOLkk88E3eIe3ThYpQF5JEq07aH94gM5Qy5Y
         Ehi/1gzcoA2OliHWO4F/GyDryTqRBlBfFSL+XiPuMv593utNUutvPNDlGeDTBoHj5IN2
         TYEMXdOGjFd7xR2B+wQFgSZ84I86l7rIt/OfjrdIJaoNxm42T/E53UwdzJaMJf/YBIHD
         taI5yxAXsaA+TDVUEVmCHTQYbX940AHPROL4cIQj5+pCOpAhypvEPS4ebFUas+oBHXu3
         C8bROYScYbeyNiF1yJY7E3ZYWZivBFvMYReh+zjKC+IkbDxKHacnhibimMUKiFq/WXjQ
         CMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736170732; x=1736775532;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjCxZydMzSLqC7uozkWiy6PV/LyYEbMQsEPXgWmlDuE=;
        b=fzz/EHTk7QPTW5CTqPWeWyb4d0WrIuV3YuftVA1cDaibPL09RnBxxjPhw187yoAjzM
         7D6creypvaXAxr+T+cIH7slYdkfjdeTYDj393lKpg8YqA9nmHdcFAXamcNXJe9n7zV0p
         MyyzbRpcQhT+Oz2kq58DO2UrkjdMSkjO8AaLEmPTQyJTDZNgX7O4ZgK/qaYgrciIVXVz
         UAPGiE3BzRIixJ3F9AhDOfhobRabtzbicln5Tv2yUC3MC74r6UBuoVtREZpTWDi5GIbO
         WEZSYfpir9HrWUWi8P9qgwcskU4lXbr0A6EcDrkruMoSyayWb+6rR+t0yuAs66E/2BMp
         rVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXTeauHQXe/bEH5ZoriKdw5Tjfuh0qn+rTYLGkTirE7z0WxF7OnroJCL7SNKNxygo/Dm8jLyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxdY5hthCtjD2HB3+O15AKEoH59EA86aV4kCAzNqok79sMr3as
	tJjODSJ8vpwNkK7SEalxYM+ryLmnEp/TFdje3pNoX372xTrlVCbS
X-Gm-Gg: ASbGnctcEKzClSPzmwOJb41+fhlHbr+BRzmeeiase7H9B+NB2T4zVIkBEpU749z3eFc
	Yf6BrM4qAq0PDxjilToTF3GcdxhP4UORPOUf6p3gH6eimwRpJcnf41H3HPKkz9ArajYAZj6csqR
	iBMcl17pJijT7lvOiB31uPMoCGApzfnRnk3udAqbV6N2pb33Ij0Q+QnjiZCOnwTzT3AFkwIMZNn
	V8ncYxrIjyWsa1DoO7GdNx8XYS5c9rEmTQniXoq/9STc1KhFNdAI8Ck8MtoFGSyJ/UdOQ==
X-Google-Smtp-Source: AGHT+IHpfZQExGjYlcEb/b3Fyn4akRcbffXRjiDg3YJLNb1aCt4ztPRCcyMIeTujDEjMFMzzrM6clQ==
X-Received: by 2002:a05:600c:1d07:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-4366854c049mr521680255e9.9.1736170731424;
        Mon, 06 Jan 2025 05:38:51 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:d10f:360f:84a5:c524])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b053e91sm631124615e9.1.2025.01.06.05.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 05:38:51 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 3/3] netlink: specs: rt_link: decode ip6tnl,
 vti and vti6 link attrs
In-Reply-To: <20250105012523.1722231-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Sat, 4 Jan 2025 17:25:23 -0800")
Date: Mon, 06 Jan 2025 13:38:40 +0000
Message-ID: <m21pxgnjtr.fsf@gmail.com>
References: <20250105012523.1722231-1-kuba@kernel.org>
	<20250105012523.1722231-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Some of our tests load vti and ip6tnl so not being able to decode
> the link attrs gets in the way of using Python YNL for testing.
>
> Decode link attributes for ip6tnl, vti and vti6.
>
> ip6tnl uses IFLA_IPTUN_FLAGS as u32, while ipv4 and sit expect
> a u16 attribute, so we have a (first?) subset type override...
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

