Return-Path: <netdev+bounces-236586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB2C3E236
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 02:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75BA64E4A19
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 01:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577F2F60D1;
	Fri,  7 Nov 2025 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azuCJLZD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5F262FFC
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 01:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479235; cv=none; b=UOfAHGNMpB5kvNGnm99QRLJQYiD7aHlaeDjsqw0F7V4gV3ftYdOx0pUCQcS/7C+4AFPLLrfHlt+RfN/32UOPhlUzB/togTZMABEwEVQM9C8x+iWzdhbXgh0M4Yu3qEXhqteKWO+ACd8sySHVxRLNSfTeOu/sVUGaPrz5gtgO1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479235; c=relaxed/simple;
	bh=s4//rXzDBRVBNwADTTn5nejLJJDM9DaWd5NHxwgbfFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBfwqhafmimvKGAfXTq1GF85mv7C96Hqu1w0Ztalwi7Z9VufI3VN2XbrBcDkxesN/ux9Y/jAM8/FR/OHrZHvtukHXTsPcXdn0HVF6/ukWalqmGotqLLXTOwOxfmg+v1kHoPVH7+us92f7bIuiamngWhluEzTPj8sKy/x76rlr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azuCJLZD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso419979a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 17:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762479232; x=1763084032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s4//rXzDBRVBNwADTTn5nejLJJDM9DaWd5NHxwgbfFk=;
        b=azuCJLZDrK7XHpNTBl5dUynyjRxkmd7I7TaFfGN4CTX4slSOY0jvJXksqcGPFE8Pyz
         psRfUu/H4av079oQPJdR0COdE9nr1Kves2VsOzHSYN+IPSH6w+ijJ14RyjCzYV2qt3y/
         0y6RGdxbmn9v3/ltBV842Lvzef+CLhzNDpKsWIO3uWElYrMv7XF+vTcBr+jHKk8ljTJh
         iYbhWSSAlYtMy0rtouzjCYb6XG/ilzu9ibptsIfCeY/eqiUgiqedHxGurR0XjnSC5ZFb
         GmSqfEF9E0zSa4Hp+LAeYmA+7YiKOaLXrJvy9C5VIZLpEetvBk4GaDnwdViB/JXrriTJ
         hmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762479232; x=1763084032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4//rXzDBRVBNwADTTn5nejLJJDM9DaWd5NHxwgbfFk=;
        b=mfbTsfebqgMokpWSMuW7OsGEgUf2T6DdjK+AtyAgMCKOG1ONku6xM3i2NPgxNMfmi+
         RTj1EeKkgs8UyCASJmJy461V4bYj19vRoeIOJ5dvLyhRzoll7a1WCLND3JfhU8dya3uD
         aJHapmaZz0d38qUQbUv6HxLOw1IiqMQ0hfKo5APD6ib/E/B0vjXq24SDYfRPzo6SPxEN
         60kTgvHl9tresVoJwM+ccWui84s4P9DmWU1jYRgelsw5blFXUpuGK5gGLmoK7sXOpsXq
         w3JGd5IsFPy5D/ozlFZAwI6ElLOA61OlBzFF3AsCO2xGYkHXl66e7S5nW23w1vqIG9Xb
         ToWA==
X-Forwarded-Encrypted: i=1; AJvYcCWIpYmzbg2xBFhWOpCwFXzKSc7co5u26LvFjVMjtWAeDl4NlcXNhp9I1qWqSvc2afg2v6NwL54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9kSiFy0Mm1lOhAsc6zFU0UwyeJSxsOq0qPRuK+9s9OYC0gM3
	rMEHl299PmVwI35wsL5GLsMhfmqBsKQibTVp0aPXFZ13tlqLv4i+IdWVBQZjMCKBCS0P1aXKd7r
	g34Ba+uQ9NtzCM8swnIi5q9vaHj/npBk=
X-Gm-Gg: ASbGncsF0ufnUBpd5ztNJRu0OO7DCZLqwO+FareVwBAxCaWbNVm6p4RucE9GFpSy0Gz
	Er41FH4uhGHpf8crRt5OW1Z5FIsagdbolQ0BvhS2VN/4jvZOxQYwsWVinRuYTe5lQIEEcv1/kfn
	W30CIMCr+FkX8C4+KUe3Bjh55GbhUYysnAGV2g+MsxmARqjc8pMiPpqUbf60FnRgQ8J+y766l43
	enj8R25ZbVXdE0LkJ7jgh8f8raAbgt4Yp9s21iIeHrGzFSzMClGr5N5rWwpnaKWX8nk4DanDK30
	MbBF4xmjqZtjAV/aSw53GHqVhNXBqLXDRQ==
X-Google-Smtp-Source: AGHT+IFs0p/ZshE8oSECFwYJl2O8ACKc9M/8ieJ8+hrmMK00uOd/hgBZgPKKUSuUkRJGeii5nbJkqvK+f3dDoKjW+Mc=
X-Received: by 2002:a05:6402:1446:b0:640:96fe:c7bb with SMTP id
 4fb4d7f45d1cf-6413f0f3f18mr1383801a12.28.1762479231677; Thu, 06 Nov 2025
 17:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
 <20251028174222.1739954-2-viswanathiyyappan@gmail.com> <20251030192018.28dcd830@kernel.org>
 <CAPrAcgPD0ZPNPOivpX=69qC88-AAeW+Jy=oy-6+PP8jDxzNabA@mail.gmail.com>
 <20251104164625.5a18db43@kernel.org> <CAPrAcgMXw5e6mi1tU=c7UaQdcKZhhC8j-y9woQk0bk8SeV4+8A@mail.gmail.com>
 <20251106141259.60e48f1e@kernel.org>
In-Reply-To: <20251106141259.60e48f1e@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Fri, 7 Nov 2025 01:33:38 +0530
X-Gm-Features: AWmQ_bkJ2FriPSSvVAi2fzsx9ERxZ0UVfTFti4bNiLHi8cCqoPmyaQ1vev0pUMY
Message-ID: <CAPrAcgMtF0cKkJ3RAGbCPozcK7YRdnYOg_tp98kLsXb_nQ9ycg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH net-next v3 1/2] net: Add ndo_write_rx_config and
 helper structs and functions:
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, jacob.e.keller@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 at 03:43, Jakub Kicinski <kuba@kernel.org> wrote:
> The objective is just to simplify the driver. Avoid the state
> management and work scheduling in every driver that needs to the config
> async. IOW we just want to give drivers an ndo_set_rx_mode that can
> sleep.

Fair enough. I will start working on v4 with virtio_net

