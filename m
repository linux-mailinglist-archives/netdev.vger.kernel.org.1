Return-Path: <netdev+bounces-129783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA019861CF
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 17:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49EFB2BF57
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B98DDC5;
	Wed, 25 Sep 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQsfl+ol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BAC347B4
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271024; cv=none; b=kJRUwB9zz2JqQnEtrXDPMvJTgXFpB0g26KncTu2L0dfOFwAJ8rE+pXGeCes3mhJPocf/iHTFfZjCoQCYYEXDpQJOkSbVKf9IyOdHt4z5uu6EwUxiTeB48MwVlK5V+JtIuMtZw2GWa3rhugbpL0c4h8r8ukfowE1ITDZO1vySps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271024; c=relaxed/simple;
	bh=+GMeBe7bQ/01StG2zfSYQVIiCSpbqoEZxiimjxvIeTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXi423oqzlTnqK/s3P7l17NGo6twtrLZ9r8MoSN5LCdmJoLa+lJU/5kTr7oaaZTObj7iwJi68OSHE9ub+aaDICpEayj+N+cghrjdLPEW/NhXpzmKAr/Poohpk3JZ7/3UZcJdXcyPWyMDuW2+LV3wjz2+sUM/1RB8X0eyP/z9Sig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQsfl+ol; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42ca4e0014dso9888135e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727271021; x=1727875821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcExjZD6GjJkh+Ch/TQ0zSPJzI/BvYIuC1gYrl2MmA0=;
        b=VQsfl+olwb50XUHW/6N0dO+y4YYCQXAadduQRDV8XTwsDJVm0q2C4hhz4HFuQ7xYtj
         aSE46spNiA/AK2DPSm5/abdGLg5puMMyfYIHkAYv1qJbygAhFztHIwWe5elY/OVRLR+V
         v5wY2YISGr98Aoy2m5RgugG9LXO1BLHauGDT4yZlFnMmI56R9Y5f5dqV33kOLPoPeJrH
         hpXav225SwpgpLS9X/whMN6yzNcLF4cj3Bx+LO7MMRzzjDnRU9zfUiZMeiWj20pSsRJo
         HwN+v9Fb8C82/+Y6VUdMg6Pp2HaVn5qHEgLa4SyWiSnn5Z/WPEbf77b0pJpdVOGQ4C89
         kcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727271021; x=1727875821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcExjZD6GjJkh+Ch/TQ0zSPJzI/BvYIuC1gYrl2MmA0=;
        b=Rbqmb0N6W3zt+qSA47AwFixoi6F7z4KNJ9pDczzCB5bGU7CjgBasENtrHcWZM8JHAw
         6ZiKiAdqY3zi9Zve9EbjeBtzXXXIkJGJgy5mFCqB7t0KxuL4SRk8fxq8sbcWzaC0bkOb
         jlZzTrA5GbtBe8PhalkBx4OW66VxvSpiKKw8xOXiliBDpx949Ya/VBoDX01y+gvFOL4G
         2mNdGItAZyxgbj3icZXMRdUilO3i7oc32wOTZ+PWgy3NyML5li+LtSfmeBcXozviNgci
         /Gmy6yeslxRF77rVJQbOCo/XJMawg/k3nRaUJmZeKfAR4Z/Na9RfXQLpinr4UDJ4+lkb
         ZbQg==
X-Forwarded-Encrypted: i=1; AJvYcCU85pcLl1pE6pZeBqxcjEfDsX5qiwf10Of2YpqWE5dtpMiCD95W4RNGHnnyv4ReolzoXaOfqTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWuinnAPfD6BuaoMwUp6ilE5gV3sRCSR9015MowmaoZIbJq2ku
	HzqM3aMZlnYMZO54nmyrx54lPDIVg8vOwWKXMt4UmvXgA4z6f0cX
X-Google-Smtp-Source: AGHT+IF/+L5Ux4OC3vvpK1CYy2l0wO3oeoT3+Zdrd7bfiNMUm91iREsXW6wGQCOPxXZd1JHnIRCkvA==
X-Received: by 2002:a05:600c:4751:b0:42c:b172:8c53 with SMTP id 5b1f17b1804b1-42e96144d4dmr8619215e9.5.1727271020959;
        Wed, 25 Sep 2024 06:30:20 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969e1957sm19177795e9.9.2024.09.25.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:30:20 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:30:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: sja1105: call PCS
 config/link_up via pcs_ops structure
Message-ID: <20240925133017.qerqjslhzs7l2h7q@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjd4-005NsF-Gt@rmk-PC.armlinux.org.uk>
 <E1ssjd4-005NsF-Gt@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ssjd4-005NsF-Gt@rmk-PC.armlinux.org.uk>
 <E1ssjd4-005NsF-Gt@rmk-PC.armlinux.org.uk>

On Mon, Sep 23, 2024 at 03:01:30PM +0100, Russell King (Oracle) wrote:
> Call the PCS operations through the ops structure, which avoids needing
> to export xpcs internal functions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

