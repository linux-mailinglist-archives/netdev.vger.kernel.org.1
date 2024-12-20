Return-Path: <netdev+bounces-153538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9C69F895D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EBB188BE26
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831689476;
	Fri, 20 Dec 2024 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3XKDy3u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E553C17
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734657852; cv=none; b=OAAMg2BGz3eqHT/O+o8cdqf7b94cYo4FSR9HLjhgoLvhp0+ev6QRj7gYPINGvCeYaAbRuYA5QAShTjfShhPQI/4G7D9hv6zjFcy7P4E777FVzKQjd6bX9zFeKVkCqdhanJ81y6j54FdsyfcOzCAV/+eQS1XByZ6CnsImHm5n5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734657852; c=relaxed/simple;
	bh=fWcvIsas5MhC/ByJ4SplBPGgziLnaxlT6FHRsPGA1PU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dWzbmCS85a/wjdw0YOlDAPwHJh00JjFmo1ANyNj2MNFgJe6L9Xkp6M9ho7BrTj+wBmAYHODnMStpD4QwpIY8YDUknPCPipMyIAWDpFD8uxPJsqtKoOWFvbV/kASEv6caRt+psn4o+Hye4dDHLZyaLrAfr9HbFuXoi1vdlZ26ruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3XKDy3u; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2165448243fso15096345ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 17:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734657850; x=1735262650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVe8uGYzHcopdi4aDYiFW+esZuf1pcKpD8sGVyYLhTs=;
        b=f3XKDy3u4Ogxd3ZEdnu67QE4YS8/hjkZGxFzMuhxcbtjFk7BpiitRzHcjvbZSjN9Ss
         8uyPJataVOQXBUHdnAH5PqSjH0ubqK9yqwqvcBW9wD4ls30Sz4yoX5FbL/OrFCcyqx04
         2K32meQrpEmBZtqQy5b0r2IIIcIooOiF/hXyNo2pLEZ0s17ySKoMTXNBa7/sZiz+Zqqd
         W2YUqJdu0tks89jnqSPAnxQXa6Myr+WjX7KwityuuYW7vcuVq8AE85uwEfpl9QLHguoB
         5DLhVYOkW3TZVDpq1xdaikcrUUBVDD3to6gA9eoFvOpfw3eQIvC1PLybW50pi2zKOLof
         vGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734657850; x=1735262650;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AVe8uGYzHcopdi4aDYiFW+esZuf1pcKpD8sGVyYLhTs=;
        b=LXH0ljppxznRDI5nUQIxoGaZco3bV3f1Gj+CoQ6aOL30T1nug0hgeLAmMqtg5ZgQJK
         nm5umcakJ4R42tiPOhanGUKbx7d9u9qfl76s1vPuTd73Tf1lENZYUlu/ycOnwuHHtaei
         lBPuPMyCZ8RzCabfu0/aKmdipIGCw7VmELBM11D+2CdUH+fzEcm3ysh3ug9olgxXFgzk
         F5lnkUZ4i+2dslo8zKBcgvN50ro4KVKwwlyKhqW/0uuWmj+MR8LPjedzvuGzOdSiQgzV
         o1LOW4h+j2WKlt/EoLd6mbBeESOSpww43gExRQ6TcujMnwJHggEm+Ohe7M7eCjXvwHI6
         U6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXPC/ZGuW+9vgL/5E6PKkM2vCuOfTAT5wT1ftP2ly/8XpGFCPEDwv/zLXjH+SrpGPuXi7vepvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbpizVubcxQ+fNSnC87yr28JrjZ5NjaNmvl3KmamxIxU+/NJJs
	U44X0tjCkIHfqyZocMGsThjaYURYhD4b3SgzMqx06fJtEuBZDoGp
X-Gm-Gg: ASbGncu8g3COsP5z7EHfX97r2zGd3/GFPt3yhWkzDeTRzF1ZdQyW5intYKa0LEuJmdB
	X8r0yY9TO7LJd9Sm7vlYrq8DYCOqTbxQpskfQA+DerSTivKvTWSWwClAxHvQUBKRJxKMS/y/A7M
	Qr25Ig9GUwVp8p/9aFWe514VY6jFfz2qLLKBH81MCjxHodjv77263OlWntnWc7H9bQFgGXErpVW
	Zm/YEq24zyppZNudO/8tctn7Yt9qrrd0GdAxixGv8hx/eYXmgdivX/2q/xCP9ZoLeduaDW+2rjf
	kFoMdzL9st2BV7jGNQ==
X-Google-Smtp-Source: AGHT+IFN1jtSaGy6aVtc9cMuS8Knwtx+fhnL4GA4pW6BoI1AjXflwdvzTlbut4ysDcZDEvOruEHkJA==
X-Received: by 2002:a17:902:cec5:b0:219:d28a:ca23 with SMTP id d9443c01a7336-219e6f1484emr10759555ad.36.1734657850264;
        Thu, 19 Dec 2024 17:24:10 -0800 (PST)
Received: from localhost (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f68efsm18523735ad.177.2024.12.19.17.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 17:24:09 -0800 (PST)
Date: Fri, 20 Dec 2024 10:24:08 +0900 (JST)
Message-Id: <20241220.102408.968249477814979263.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net, devnull+hfdevel.gmx.net@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, fujita.tomonori@gmail.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/7] net: tn40xx: create software node for
 mdio and phy and add to mdiobus
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20241217-tn9510-v3a-v3-5-4d5ef6f686e0@gmx.net>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
	<20241217-tn9510-v3a-v3-5-4d5ef6f686e0@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 22:07:36 +0100
Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org> wrote:

> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> Create a software node for the mdio function, with a child node for the
> Aquantia AQR105 PHY, providing a firmware-name (and a bit more, which may
> be used for future checks) to allow the PHY to load a MAC specific
> firmware from the file system.
> 
> The name of the PHY software node follows the naming convention suggested
> in the patch for the mdiobus_scan function (in the same patch series).
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> ---
>  drivers/net/ethernet/tehuti/tn40.c      | 10 ++++-
>  drivers/net/ethernet/tehuti/tn40.h      | 30 +++++++++++++++
>  drivers/net/ethernet/tehuti/tn40_mdio.c | 65 ++++++++++++++++++++++++++++++++-
>  3 files changed, 103 insertions(+), 2 deletions(-)

Boards with QT2025 also creates a software node for AQR105 PHY?

