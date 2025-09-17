Return-Path: <netdev+bounces-223895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37C3B7DD2F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE74A520749
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830D02D063E;
	Wed, 17 Sep 2025 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdF5H7pe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FF2DEA76
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095144; cv=none; b=ZEFTkI+N0uqRysAgCJFYi21mqrST8FpTS7JHSWRXDAmxbADJH+SKOBg5ZyQAvuT32KdXCccDvywH1UDRVj4pBNelwga2rRzKR6ajSLYfVfcQISko4uRax1a61ZSliY0QSmCEnkjP7y+0IoieaWSMT9FJYHqPPmud6K052mTCnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095144; c=relaxed/simple;
	bh=VuANqMa5rXUe4iT43Lw7PbSvkgG3E3jO9Qqod1i4wOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRbS9cduFFo+BPmxJkthNHcqw9iWxaWHOL6adVw0IbwIbI3M1p6nFKPleQWw8jd16T8eJKxf8Khvz6ouoNjVMaEXU+yclwjw069z+yIib8l3KGcA63M6Td3tKblKfNGknKJBKVfVWlSJSB1GJeoRZV4v+8JzRxlZ11WsT04rs2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdF5H7pe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45de4ebe79eso8062505e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758095141; x=1758699941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0QGfVLuLdMyhumFCXJB4wuAALuJd1MUyMagn3o+9ac=;
        b=PdF5H7peXwQ74wVoyQ8+RsncWK9Kvidu9ia/yWUdLc3oxm22qQFryvCJgspLiF9Tjn
         5KQJoCIL6peLaCTKHFI+//tArrehvlQqiCurNCeLNJ9QdbeoyBSGayFmiXZ8+Pk4R2BZ
         ecyECpZBtTUWZarrWqpx0N2uMy6e0uTu17++KHY/jqIuSGqlCRX1zWmhYGQLNxDQQX04
         UFeOA+3dk4GrxKfHrz1cCu8XNSx3u56IH1iFunFb27Lp8Bj1fW6PnOOuswVv9dIikhHO
         0sUbhO1OBXdODyjbozIwLZCklATJa7zgXbyDGGy+KK0GhUpfUMMunr2Ce/doBJFBXRg9
         5jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095141; x=1758699941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0QGfVLuLdMyhumFCXJB4wuAALuJd1MUyMagn3o+9ac=;
        b=Fg6wm/JFaoJQMN8OVF+42qyzr51Fpn0HJqhakiJYAeFaEEqjclUr4BZK5a4QGyvXiS
         y9uBtEpGc2u8AxSLyUHLdDU55jbcwNciHpfveL7DXxhN50uUXzUAhlBvtPXCrpIPOQt7
         vTzbbCHVy501k0YOyAnuCAB6ezsn7MjV0VqTbY/pqP9+WvjBhRdZomt2F3TnsH0AnmIn
         Lrazv+1Wg2NkYNUWdHTPVS9OxdsD7rH4S0dEK5C5q+kC5zruAJAoUkViXITcYyAIuDS6
         tkjVBI2AaI9hNk77W726GQ9rBuztd2Go7xn1CV4JKBz9do7TYGvflj9+4aDA5KADu3/w
         Zp6A==
X-Forwarded-Encrypted: i=1; AJvYcCXRjkgxmGEeOvNWwwpvSQMEAqIL45HSzP1vnJl2GAR9mjUP0yKUnZQ0rfUN2V5OOaapA7b8zQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyhfy1ZIMw3Q6Mf9ZKh9tFStEC58uUwjtL1u+g1bpRyeS3mo7M
	iaxkycsmTvjR4oHY4Wdi/NJiqceeALngoJ8J+FECJgUVdB3F8xSu53aO
X-Gm-Gg: ASbGnctLy1HvOyy7JQhMOG5Rr9tXqy76ds++tmiN1n/BC5A28piTlm7TMmq00hv83Vm
	OJSvyDj7q8bnRgmN9EP7mwsgAUlaaZnD/o4a0wCZpldvDXXp90F+2lvdAcFG2YIb0BPwgfxGv1U
	2ltixWKJ/052MxR1O5GUIit0CYdOKpUkvAGsKgyZanSquwlrpwBkQ6Ma/dyKcxJUPcRwXLY+ovO
	Ydx+CaeSzLNqBQC1T8tJdfV7vw5I+4ubEx9aEVHPmysvgXDNVwogTzbLDAxQLgjAg03Fa0P4PX6
	xrqCzSTdDvnUgAhUMzXfnn1D1TjOyJg3FnDSKiI/WbWyy2/hS4sz9LwsoJ+13+NcQbKMjG4W64r
	2C8FB8ov7GHiJQuU=
X-Google-Smtp-Source: AGHT+IH8RmFFjNhojj0XqfH1n7mmTs1aKG9YohJHS+lk9Ma00ithMaqPdkkBQ6vUDQlCKNbEiH9SLQ==
X-Received: by 2002:a05:6000:4013:b0:3eb:21ee:bdba with SMTP id ffacd0b85a97d-3ecdf9be891mr482549f8f.2.1758095140860;
        Wed, 17 Sep 2025 00:45:40 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecddc97bfesm2262635f8f.51.2025.09.17.00.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:45:40 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:45:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v2 1/5] net: dsa: mv88e6xxx: rename TAI
 definitions according to core
Message-ID: <20250917074537.rjlzg4gnzirmagso@skbuf>
References: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
 <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
 <E1uycO0-00000005xap-1rbr@rmk-PC.armlinux.org.uk>
 <E1uycO0-00000005xap-1rbr@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uycO0-00000005xap-1rbr@rmk-PC.armlinux.org.uk>
 <E1uycO0-00000005xap-1rbr@rmk-PC.armlinux.org.uk>

On Tue, Sep 16, 2025 at 09:34:48PM +0100, Russell King (Oracle) wrote:
> The TAI_EVENT_STATUS and TAI_CFG definitions are only used for the
> 88E6352-family of TAI implementations. Rename them as such, and
> remove the TAI_EVENT_TIME_* definitions that are unused (although
> we read them as a block.)
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

