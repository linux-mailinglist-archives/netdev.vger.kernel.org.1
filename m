Return-Path: <netdev+bounces-176095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE71FA68BFA
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464691883EA6
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45AA254AE8;
	Wed, 19 Mar 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN0M9rQ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB720D4F6;
	Wed, 19 Mar 2025 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384461; cv=none; b=EMvx/9MTcVcByGbgXb7UrRqvH/cz6dgqSQJ+0je1zmo403mVmt24e0pkCepdfQj57SrmPzZOjHAchwzzM7CHzyxx1Y3/euLThrqj47yMcbKjJc4dWn5hiApEDdhIu6UxbHMXZpiJOxZZ6JUnqJcir99+aQjS/+clKOZOfG2ioQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384461; c=relaxed/simple;
	bh=BASFzT3ozw1qSB0PTCEsUDr/JEgnlf5aEhe6sboZ5mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P05O1wCCOjJDLPlqZscqd8g4y59tRTNWaO7DJAIWCJyaOYPfW2IXr02cK5XWGAdvwB67cecGsaKHndhMXergrtXnGh5yeA8w7nim+1uf1mDTqurztRLgU8+7kHAmSiObJgbBektIfdnfk3oXO/Feffq3yRwVipgXj1qzPDCyEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN0M9rQ6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so39003055e9.0;
        Wed, 19 Mar 2025 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742384458; x=1742989258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dF9trv6V6tj6EzP1hzQNjsFueUEo7+2EWFp7AG7Lq40=;
        b=jN0M9rQ6+CvdeUSnNA29NjkLTyok42TdR6vJUm8bJDuL2yQGfqngGvQDvHwLcTugVf
         /b/3+IHGivfxtiD82LW35iwCo7BPnLtRFkU5AtUp8DegVnI1gr8GMF/D/ALheZb9sGdX
         jlqoCGZMOIhjCBVz3wcZvaTAG3JWGkuedcv7DeO3FMNAcYjD56+GQ8ZP1Tgvn719+X21
         J14bSVuK1kGCG3nCseSkNpaYBQCFFRCooK2rDtGhtPtKMX5/Htx+HNLvMrTsLvhTJEyD
         Z1y65/3vhiZIn0hgTeeiGy4qYfktZUID7PBsoxJ/CfFH7/fqfy73b+L/6EHOI9t+G0To
         RirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384458; x=1742989258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF9trv6V6tj6EzP1hzQNjsFueUEo7+2EWFp7AG7Lq40=;
        b=lVUgZBrvpl5N1NlAEnm2cLlOhmTc1EaCUjXdshzJesG18ux3nFCSrQG03zVDW+a23M
         Ms2M9CZV3gq3hpoCklGnyrDf2nlke2E1T/Dn5QqRAk6hXm/EX+ghN4eOulnkav3KOqJT
         GURPiLOYY6vviQoPleNSQAdhl61U+6rJdVnA1vI6QzKJjpnK8XzyK1jMWEesbEYlASIq
         jR/GSJh47U8x3xasH3zTLVTeYDyvDLzEIc0aADMGRZewrCfOND9yD90FkN82MZiEm2IE
         fDCcHBCTHn7tBOqiWDm+ifIdrk/FDHHeM+kEzGKfolN3Mm+IBdq1+GWwuKgWGGIiRued
         GY8w==
X-Forwarded-Encrypted: i=1; AJvYcCUo2otzqnaLIfevDP8R0BfHJrct+TaexQTHlNho435BfNKhiNlRXhHEVPFk/2R9CcCw+2GwfqMD@vger.kernel.org, AJvYcCVnMeG5pLUb9VHahq8QJQR4CruWkmkm4mgQCr6QlksMipjOb/3J6XUQT4jLfi6mFcZzjYy+lHvN2y+q@vger.kernel.org, AJvYcCXUjkh834mL+YdMeM8nN8pp6FOOJecDQrpQvaezHdvjY0j4g2qBjZt13UTQhTIypO4+d/GQiceGxVkHqRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk8Q1QbwSpJD/6TdL41bSCNEIJR3xmo93cGLkaUj+BGtlZhtFE
	i5OoOBvojEj8l7k/0GD+mMrp0c3j4x1ULrXOG405VpNlFliBTnSg
X-Gm-Gg: ASbGncvQ+03JtJjkge7Phee8Q1RUjEWY9izp+Z/OS4c496rV/fp3hp2El7ChhVSdLQU
	XqiM+zy/Nqhpz9YXEQsgDyrU8tEcprdrtE7P9jYd/iv0Av6DSK1Y5dwuaEEmzws/v5qdQNTnjQz
	kWSxNQzIrIwec6t4+Jl9ax7Y09Gez0kGOHOnaN2pYLJFlE55WxNX8hOS5cLusvDyl/lViT2DxcA
	c7PzWJe7dQ/m6hWxFh4moxSiwvfCtTV54i0ef50CHxdYt5WPiSkckbEJL1B+nh3SpnIs1xAwi2S
	RJ7cEG0KPQ1443SUHeyg3RdKY+ewOICIO53/MRrNGIWCo58=
X-Google-Smtp-Source: AGHT+IF+J63/c+/EFcV5cqtH2UTph+pVG1DweugejbGuYXOSiAYNF//6zKmCV6HVWGAwrVuLes76cQ==
X-Received: by 2002:a05:600c:3490:b0:43d:1b74:e89a with SMTP id 5b1f17b1804b1-43d4379395amr20617155e9.9.1742384457936;
        Wed, 19 Mar 2025 04:40:57 -0700 (PDT)
Received: from qasdev.system ([2a02:c7c:6696:8300:7659:65a:5e42:31a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdeba1sm16258165e9.32.2025.03.19.04.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:40:57 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:40:51 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, horms@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fix uninitialised access in mii_nway_restart() and
 cleanup error handling
Message-ID: <Z9qtQ-oaEv9gatUW@qasdev.system>
References: <20250311161157.49065-1-qasdev00@gmail.com>
 <491430dd-71ad-4472-b3e1-0531da6d4ecc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <491430dd-71ad-4472-b3e1-0531da6d4ecc@redhat.com>

On Tue, Mar 18, 2025 at 11:29:15AM +0100, Paolo Abeni wrote:
> On 3/11/25 5:11 PM, Qasim Ijaz wrote:
> > In mii_nway_restart() during the line:
> > 
> >         bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> > 
> > The code attempts to call mii->mdio_read which is ch9200_mdio_read().
> > 
> > ch9200_mdio_read() utilises a local buffer, which is initialised
> > with control_read():
> > 
> >         unsigned char buff[2];
> > 
> > However buff is conditionally initialised inside control_read():
> > 
> >         if (err == size) {
> >                 memcpy(data, buf, size);
> >         }
> > 
> > If the condition of "err == size" is not met, then buff remains
> > uninitialised. Once this happens the uninitialised buff is accessed
> > and returned during ch9200_mdio_read():
> > 
> >         return (buff[0] | buff[1] << 8);
> > 
> > The problem stems from the fact that ch9200_mdio_read() ignores the
> > return value of control_read(), leading to uinit-access of buff.
> > 
> > To fix this we should check the return value of control_read()
> > and return early on error.
> > 
> > Furthermore the get_mac_address() function has a similar problem where
> > it does not directly check the return value of each control_read(),
> > instead it sums up the return values and checks them all at the end
> > which means if any call to control_read() fails the function just 
> > continues on.
> > 
> > Handle this by validating the return value of each call and fail fast
> > and early instead of continuing.
> > 
> > Lastly ch9200_bind() ignores the return values of multiple 
> > control_write() calls.
> > 
> > Validate each control_write() call to ensure it succeeds before
> > continuing with the next call.
> > 
> > Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> > Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
> > Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> > Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> 
> Please split the patch in a small series, as suggested by Simon.
> 
> Please additionally include the target tree name ('net', in this case)
> in the subj prefix.
> 
Hi Paolo and Simon,

Thanks for the suggestions and advice, I have sent a mini patch series which you
can view:

Link: <https://lore.kernel.org/all/20250319112156.48312-1-qasdev00@gmail.com/>

Thanks,
Qasim

> Thanks,
> 
> Paolo
> 

