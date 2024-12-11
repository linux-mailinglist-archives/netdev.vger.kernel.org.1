Return-Path: <netdev+bounces-151151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2055C9ED09D
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDEB28FCE6
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9651D88BB;
	Wed, 11 Dec 2024 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMucF2Ia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE91D798E
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932767; cv=none; b=TFP/maKbsIAUFmb5rXz9hZKsQhAt0+/uJvj7TSck8K/yWYhAq8zpyZ2ixmiUTLqLT2VlbskMVGkBDdtVE/ESlY6OixQZN091wEevIR0maPxhvtur21xq/5dsPHyYVEzpSkrFx1kb+Uz9RUjchpXbELhxgSKTw60+Tq5u9HabKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932767; c=relaxed/simple;
	bh=HuB5qIXouUtt9qv1cqiDr7t+T5J4ehqFiwO2xOKuWRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBs0XO0ltNaELiI39iXz7yFaD/RmHaeIBaQcuEakMu/Ob+3kdcTdnzUPeRfl/qm0bB7jfWDRZAmh7RSAbHGuN5gno5wPh7+nQeLjFKJIeA0KLkAeSDCnvDQ2pTonfYokl/Aac9WScPUOE6qtRNjvFHM6CDcBTeuqBKWsSI8Qr6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMucF2Ia; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa67bc91f88so72949066b.0
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733932764; x=1734537564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQo4kdQdviaktJTQUjcJ0e30Lwbr9lUNmT2EWPAUaSA=;
        b=NMucF2Iaj2KyLrHbGigImGzp1XmzzvORTq00fe5G0JiGGWBkRZNmmE+d1+ff0ZCNWr
         8IL05FS3ZLLi20iu7GPoq1xi383FwaHX/7zZiAqiJkdv76cdaOWJrNfnepCUpkydh0gQ
         9f0pJnoWPgjxgbHIW8DkbA4BKQI3GQXn/fbnJUjAWqalL+G1xBXGci3uPQdgrzUMdREY
         +7h007E1uW2UhMCz7bSTl0z7iR7RGXTtEPRaPzCDWFDQsL59t9JAoYsW7z3MQ1Mx/u/Z
         OYvm1t6niuUOGibKisYuWEabWMJBd3RJ2ctyM0yRIGtW36iz2gXBXXc7vdW2TK2ScLDr
         PsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932764; x=1734537564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQo4kdQdviaktJTQUjcJ0e30Lwbr9lUNmT2EWPAUaSA=;
        b=Rvf7JXTw7EGoo3H6XCn9TsurQ0eT4BFPQAkkabyILFTDW9/cfc1AuoCJJ3vDLzTOQZ
         eAcufYvYLjpsfxFJFFv+1j07H9wEnurs9w/fDZPI2XgQxbGmOv9pEoyNNPv0Pkz0qKTf
         6mOFswbpqf3ZEf4XnNAG8T7xLm5/bKwFjR4Eyplln5M096E842eH5/l4T1nynWQtlupu
         5THgA2JV0w/rpI093ZliugMx4PU8MNDqSdNR8EzKKRQ87FebdyAK4b9ND1PhxySduPEY
         DkEyhtwMTyQ3OJg2jX3NQugr6/VUFEWIrNESe8pDF7yjlHZN4z5Ad2GGqQqrhWc7Jnsp
         E2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUBpnE6B15zpFR6gBv/BL3EENVVtNcEK3LwHIQEcIhL2vu3x5kSh7P5YWyJyzjVCnNNAwEa1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEK/Ut4lIAIANMcIRSGNXy06aCa2AUPqaVCG+7u7wQZCrGb7LO
	UMDD3YqY3uNN14n0a5d3Eu21Oh6l926anood1UO/P/oJxJdTSscM
X-Gm-Gg: ASbGnct664a1lR9XTzprjEVQuKa5kYt9rH7hxp2SvuZWxHDf+NeSuF5PYE+nVTrN06w
	/lRadxdHH0y+mujgSk0eODb+BTyIiknx7gQFEbuQNBtscv9zWI04AXPRiI9flsFFyYixHxcZOtv
	oWO3VmC/b+Eq/SaaZFaf4pV6YNVazQTieFscYKFiqJy7aKZXOlrlvuwBdyCMhL8rxw9SFNi5sQz
	kFVZkGm8SKpvuG8m3cC5NP339viArHizmAB3AYdfA==
X-Google-Smtp-Source: AGHT+IFyV3iDXmmlLsNjwIKP7/kQgODUrCUnsTuF51JTS71xaSEMaMEtAZkpdveeiZdMK/ulibo79Q==
X-Received: by 2002:a17:907:94c7:b0:aa5:a36c:88f0 with SMTP id a640c23a62f3a-aa6b13b9a75mr119197466b.12.1733932763509;
        Wed, 11 Dec 2024 07:59:23 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa672d377fbsm596189266b.75.2024.12.11.07.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:59:22 -0800 (PST)
Date: Wed, 11 Dec 2024 17:59:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>, UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next 0/9] net: dsa: cleanup EEE (part 1)
Message-ID: <20241211155919.rv3gglwnuuy4rn4y@skbuf>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>

On Tue, Dec 10, 2024 at 02:17:52PM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> First part of DSA EEE cleanups.
> 
> Patch 1 removes a useless test that is always false. dp->pl will always
> be set for user ports, so !dp->pl in the EEE methods will always be
> false.
> 
> Patch 2 adds support for a new DSA support_eee() method, which tells
> DSA whether the DSA driver supports EEE, and thus whether the ethtool
> set_eee() and get_eee() methods should return -EOPNOTSUPP.
> 
> Patch 3 adds a trivial implementation for this new method which
> indicates that EEE is supported.
> 
> Patches 4..8 adds implementations for .supports_eee() to all drivers
> that support EEE in some form.
> 
> Patch 9 switches the core DSA code to require a .supports_eee()
> implementation if DSA is supported. Any DSA driver that doesn't
> implement this method after this patch will not support the ethtool
> EEE methods.
> 
> Part 2 will remove the (now) useless .get_mac_eee() DSA operation.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

