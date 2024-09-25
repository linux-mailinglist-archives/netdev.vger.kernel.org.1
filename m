Return-Path: <netdev+bounces-129777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B2E9860F3
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABBBFB2FA6A
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BBB19F415;
	Wed, 25 Sep 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROU1Vf2S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6F19F12C
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268462; cv=none; b=f9n8xw5ZPx37Xy2Bk7YPEZrvve/UsatpX8AUi/s+8Z/mLT6vdwOupd8KiBAGdfPxrcy64zJJvBHBj+9nZ5KBgoG2d9MypPF+rz0FFKT/nWhtkMG5RWcxFtDFgPz+HMgbasUpmFBUSwa8E3lyH/ltEJzSGq0dObR/Hq8AVgAKGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268462; c=relaxed/simple;
	bh=IwiAnX1rPg5TjrPxhDdDIYABeDwvk6e44OA+3hcSRec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SspnAP+Fe5ygdd8kocP8fJVLbfLEJ5+782BA/qfG8/1BfW3R6J96SraxFt6hwOsc7zhvaUZipbVm0RI3aiovkFIcTqwXquNh83rndqMJiSTYBK6nfNbqsOGoijYN/jIxYc/QjOpmmPjEmuBizq6KDmVb1tqOueW+asKEbX4iHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROU1Vf2S; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c5b6069cabso761147a12.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727268459; x=1727873259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+LBbRfeJAH476Zzo/DwglJa17IfHtD4nGJ1Jvwz340c=;
        b=ROU1Vf2Sb+R+TKYkxC5G/VO5B5AWFoRdRQ7fw1pHM3y6SmXmE656Vdpi5rZ5B8ECXb
         9Z+OuBELAzwo2jaNPUG6kBKEZrVrnDvWiqtaL7WWXcr0Oc73uK1cj6saqA42+CPqX4GV
         oe7nqila4xPjnudN+lUjNhpwbKEQ+mvohrKMxzZqaE9S+CeXRM2+mIi92Ypnt7zgGOUC
         yFAu7uj3wXOYza7Kl3jYxYuTNVaVooc1df62JDmRWkjM/FPPce/4Ji701TrT4t34qa1P
         ibs5nPQESaMCh+VhGAbqUBYnlGr8cMUuXJBLsdctzVZe1l8jueq0h4G3+MG5OiBiNoAa
         AWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268459; x=1727873259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LBbRfeJAH476Zzo/DwglJa17IfHtD4nGJ1Jvwz340c=;
        b=bzbv6KoIglpkAtJOJVwyImPeGvpK1v9WF7FsNv+Jn7O05Ugvipb5EF8p9ACOV/+Zhk
         /s0szMpSx58CJfsfyKgSNo4hWfw/Gol/DJwn7nqqJu1HUnyAmPGJ5cgjOWy3RN7vzbxF
         v7u+O1JiSPH5zMJKajd+8b+1Z8WB6f5CYZBOneUQNxix97vK8h3Npi96LQWU1edxQdQj
         FCJrVyka5WQljF9OQx7RAbtRe3GCY5K0I1nL4JMxpXqrRL3Ntl47Iq25tw3wqftUwZz/
         xyqSKADJh4TAZvqoChfLx0PcaaE+sknqRw9pUXg2uhXLp5TcK2FHFVJymSgx03J7Q7ZC
         RPlA==
X-Forwarded-Encrypted: i=1; AJvYcCXmSdQEcaiJIxu/TFE264Z/1cxeZ1yNhiQTrJEl+7lV/JBnVd0Lp3j5xXmDXcxOSWtx6k8DSzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJiKEmmIt6rCntM/ZOBiw6gu2aUsJDeYpFhv8paGxQrWe+GiVg
	t5eXdyEOCefjlsD/aGwgHvG7QkFLVKDNTuFtNCzhyWvoVTdgsU1t
X-Google-Smtp-Source: AGHT+IHxuXkv4oPA1flcUn4EbmUBgsnBEfqQgzMJGZtYhKE/Cn7w4pP0ReLZxF6SU0fNuoXpjV/0Ew==
X-Received: by 2002:a17:907:3f96:b0:a80:a294:f8a with SMTP id a640c23a62f3a-a93a035c2c6mr112023866b.1.1727268458883;
        Wed, 25 Sep 2024 05:47:38 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f50b26sm206042966b.61.2024.09.25.05.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:47:38 -0700 (PDT)
Date: Wed, 25 Sep 2024 15:47:35 +0300
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
Subject: Re: [PATCH RFC net-next 02/10] net: pcs: xpcs: drop interface
 argument from internal functions
Message-ID: <20240925124735.65xud5f5eo66mle5@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjce-005Nrl-UX@rmk-PC.armlinux.org.uk>
 <E1ssjce-005Nrl-UX@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ssjce-005Nrl-UX@rmk-PC.armlinux.org.uk>
 <E1ssjce-005Nrl-UX@rmk-PC.armlinux.org.uk>

On Mon, Sep 23, 2024 at 03:01:04PM +0100, Russell King (Oracle) wrote:
> Now that we no longer use the "interface" argument when creating the
> XPCS sub-driver, remove it from xpcs_create() and xpcs_init_iface().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

