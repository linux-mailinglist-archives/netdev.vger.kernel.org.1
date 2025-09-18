Return-Path: <netdev+bounces-224495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3B9B8587F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7397E2198
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9449E30E0D0;
	Thu, 18 Sep 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFjBut7y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F6C30DEDC
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208557; cv=none; b=dww5f6RH3MXmO8c0YX5J8cuhwuCZVk02oCbba6XgD+SP83TgWf3hxuzmO7fnJ6a+aTFukvHIqBtUfzRtudqBePpkcbjMyftgZ9lT+bm4WJUiDUPSWVAQtjpCQQmxAjZOMtciFcXChZXUDuYCHL7uMzVWn72U56wJyBNoT64aQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208557; c=relaxed/simple;
	bh=Vd4Mi4+dhTAD9JQsvqND34y7BYzoC2X0tL4Kp8hyzEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6WAQEKlenkYx1jomGEGN6B7KwuGrVCDSncof8B0UldmKZGh231QJsG1XYJ8cG2diVzMK7jIVrNisre4EyKpiqgHdJc9qwM0CcexbWRjPNdimEqEHN83WmNFkzC2klrQSqqbr8GWL8w9VWyBhGwZkXIJdLbczLA4eR0EZTtfo2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFjBut7y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45de5246dc4so2657375e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758208554; x=1758813354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFqF4tQ3DTVA6cnQpV1IEnryDu9fHmC9hbOlqi1e1lE=;
        b=BFjBut7yP2PPL74omtsda2X2CHY0ybXXsqlndUbjAbBc/n1Fu/R3yp5CKRsAxTEO76
         iX4EhgV5xBDYqSX6zFpU9CCfHJbZ4D5Ff1qWHv8TMpxkhrMCypNnXdu4R6U4r/02pi5C
         +oUN1Gv4pyKvbqhQdbATehD9TSTdbdEfCZycqszCDh72B4S7PxZuZNfvN+wSshaMBEzL
         RPqWVlqqNlJ9GihCbMmnnH3pWAxxi/Hoc7tlHFcOte5nTcGLpufYPjSDxXYSaCgkbqGG
         n93LGxp78OMUBuNSZvLwN25/DBDFvoqyNVgFbXZ1UkCsQmWKMZ5LCjiw30XLee3qlT4b
         dqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208554; x=1758813354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFqF4tQ3DTVA6cnQpV1IEnryDu9fHmC9hbOlqi1e1lE=;
        b=d8LufW7yLNRPbo8HjM4rzZ49AZ5ddpwNOHT3lQerfbhLpWkW6YR9+/FHW33XNrDPHx
         hwK2RCkt8b3wiXR5jqmZOYS70Fol9VQCPjfiIKOvLAZOvOLBe0Dgf8grQ4Fpg2Z4iExl
         /NJsHFHeSRtVSGFUqp9ygYk45k1uofGWY6YpR5Lg+NBnt2NZRkmccLuGuJXTSPlbF5Fa
         0J22gZ5mS5AZxijtMbxUxb9Isbn8qBxY7+anMkkuBDge6qXFPei6KmwO1aEi/8r+0yQm
         VcyEzifx/TMqJdSJ9Ta3f08L7QOSoWYDyalrYMLzh93nkBQVrrwJLA7LzY+b4VaiuJQM
         YR0A==
X-Forwarded-Encrypted: i=1; AJvYcCUOeg3Ks0kYedLgZqVetnIRy925cJV7JurVE67zMKygUmKjhYZZayLF8Gzb2ycZwkajbzmkXhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytMecOy2hdxlXOtAVkVILY1uptC1MFVY83roPUIzI9MlAFujVm
	S95sOg+DSIez37Z6bavndd0OQMiqNQBxyiHg6Wf4QWNqTOutVLTsRT4l
X-Gm-Gg: ASbGncv9Kx4Ovydl3PXb1h75E7NY+pzt1E1nGAOoSmfL9d8hKVxydod5Lhjc79PhFc5
	urnc05Kjx2cQpr6W2hIY5hv4EY2H4/XD3FoaTEsY0en+G3z7GCbV72Rgek1JDXa/d46HeHYDR0M
	96+XndAVpoJ3gOMsJWZTR9jfEfBn8LRu7QTaPF8/Icwv3LeoQzzkRrqx26UF7jyfcTG4UQ+bW21
	enaajHQjqFVaBjgjc0vMxg0nOb6KbnVMgOStk6Z19y/+XfGSmZu7V7NlIbVFrtbqHBWWFE6Rx9B
	p54S8Ce+L9v5XAjXFq5SRPHv6HHZLov9Qq1M5T9e0xBOq2uJMVGyYP9AnJM+6PHYHOG20kTLI/V
	1ChMTMQN0A5DyuSThnergimKMgVV49f1sxw==
X-Google-Smtp-Source: AGHT+IFb+tHKCZw1t7OMSXs86DI8CD1BdrSgNvBCnBbAlBUrnqjrnCxiXXFSGBkIcJBROiBqVtBUSw==
X-Received: by 2002:a05:600c:474d:b0:45f:2d70:2af6 with SMTP id 5b1f17b1804b1-46201f8b2fcmr31266265e9.1.1758208553672;
        Thu, 18 Sep 2025 08:15:53 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:f1c5:4cb3:f4ad:bef0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f16272e4sm51790755e9.9.2025.09.18.08.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:15:51 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:15:49 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: dsa_loop: remove duplicated
 definition of NUM_FIXED_PHYS
Message-ID: <20250918151549.nysee6zjxwycqbwl@skbuf>
References: <67a3b7df-c967-4431-86b6-a836dc46a4ef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a3b7df-c967-4431-86b6-a836dc46a4ef@gmail.com>

On Thu, Sep 18, 2025 at 07:54:00AM +0200, Heiner Kallweit wrote:
> Remove duplicated definition of NUM_FIXED_PHYS. This was a leftover from
> 41357bc7b94b ("net: dsa: dsa_loop: remove usage of mdio_board_info").
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

