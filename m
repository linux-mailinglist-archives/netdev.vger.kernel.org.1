Return-Path: <netdev+bounces-122851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091B0962CB8
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21521F2163A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713D21A2556;
	Wed, 28 Aug 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/yLSdxG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47BA381B1;
	Wed, 28 Aug 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859931; cv=none; b=bnNmphDjnG9xWXqFCK5gdq54M2K1y7DCUsVoh2oQCa1u/3CcLECTevlJgRV/O56Vxp+QM1O41xZCvXKX/cAZMRX9QZDcc89N8KTcweITv5NrzR5g9pCjc67rUCFlFsYuYqavkWV3YQu91xx+l73KlIMXL54Lfaq3j6gYt3k+kZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859931; c=relaxed/simple;
	bh=9rDI0xYGqmCC8+sKfivqoITazVvLBqPzlZCtPeKME2I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TA+gaSieptHF0ngTQfgLrstsQg35TKtKdbX4ggxdd5aWdlYD78f5BAHKpLtSonZhHVFVYq5rFYuSfkrc3D5Hphaaz0jSckfmxUZo3D0sIvbxR+Eb4Umv1DDDICEpry5nDKzFYO9xOrVXEZah8CJdg+HLtm1xiE2U/EJlDGPstFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/yLSdxG; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf6dedbfe1so38799066d6.3;
        Wed, 28 Aug 2024 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724859929; x=1725464729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZOUe+6mBEPTZP4TSVhRf36gjDMv1iagTqH5nqm+dEk=;
        b=B/yLSdxGGkanOBBzSZPFyJdO9JxawUspI7r8HOvkVtOwqjJKfOUWkZFlWYoa8xEppd
         0tF+tnKnG3q5SlYc1o/dSI+ndYRlvrtfY5L2O7uH463AXaX/Ogo84ExpFAU5E14mNlpW
         yJDoJZrthk6ogoUUjFku1f0m1MZRUykpx0E+2QPC6XrpP9ZwOkJ4nK+dpaFVEeuh+kej
         iJZ28nP45N0Ljv7UdjM03/fJO1WfBPZlk8TtGeOoY5wOYX2t/7Z2c0l+2UmJ7L2eb8zY
         o3EhZ9aSR2IDpYzNXVFe7XRentrz620KHtPloVnw6PmcuDF8SoO5oNaNV0pm1cGvOtS3
         Pyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859929; x=1725464729;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PZOUe+6mBEPTZP4TSVhRf36gjDMv1iagTqH5nqm+dEk=;
        b=C2C3oQsvvRyp/M2JHYyBsQPgVEUXEOxE2EhyNVsuOAuWt0w22IufPEf5IR686qxWnN
         ZWHxEyEv6yP9P4VsqoxVW/psgV6JTRdKdU3jTg/gFdMC2JM3q3pDtzThUqRMAjyQZ+Yt
         UdCPusg/xyKKF45DFzxVzuFTyTT0QiFJtx4p+Su2Ld5Z/kUi4mdOG74T2e4HsUAHKPld
         rncVZc4BLf9RDgQ+axjmD48E6yY8YBWeZWubwX5OAA0er6/sEZGmdNzHYM4eXHCGw5wq
         qvC97etRAL5K0NoyFgcwN5b4DvHwcJ+QsZKrzBQi6wBr8IiZBZzpaC4bvOYFmimMzJI/
         Dbqg==
X-Forwarded-Encrypted: i=1; AJvYcCVs1qbXlgCzArj5eeQbtCDcFJk5J/w4JKRumk/vHX65P3se0x+k2mKMS3pZ0ii9oLMgDxAbS2LT@vger.kernel.org, AJvYcCXqaEiglroDvbwzNMBDV6CVGQeyddEzwD+KBovavV0np3vUz47tNiNRgw2u29TgENApnOFs4UTBd+X4Xr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyePHCcQODBSIYkBlDOuFmmvaB+sOEAJFwrrK0ySC6QhxSMxIRI
	+TVfh+lNRiWm/Mrx4bkA9f43E9gQr9DU6dYBMpmFuYTuhgL+0NS0
X-Google-Smtp-Source: AGHT+IFQmS19Ly4t1qu81gaSL06dZhIAsQ4bEbru5NbdTJjKT/mLIQ+HckN7wPPi8lsCzxxsTBJIfw==
X-Received: by 2002:a05:6214:3c98:b0:6bf:7b7f:68e with SMTP id 6a1803df08f44-6c336337142mr33041406d6.40.1724859928753;
        Wed, 28 Aug 2024 08:45:28 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d216fasm65998426d6.22.2024.08.28.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:45:28 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:45:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, 
 woojung.huh@microchip.com, 
 andrew@lunn.ch, 
 f.fainelli@gmail.com, 
 olteanv@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linus.walleij@linaro.org, 
 alsi@bang-olufsen.dk, 
 justin.chen@broadcom.com, 
 sebastian.hesselbarth@gmail.com, 
 alexandre.torgue@foss.st.com, 
 joabreu@synopsys.com, 
 mcoquelin.stm32@gmail.com, 
 wens@csie.org, 
 jernej.skrabec@gmail.com, 
 samuel@sholland.org, 
 hkallweit1@gmail.com, 
 linux@armlinux.org.uk, 
 ansuelsmth@gmail.com, 
 UNGLinuxDriver@microchip.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bcm-kernel-feedback-list@broadcom.com, 
 linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, 
 krzk@kernel.org, 
 jic23@kernel.org
Cc: ruanjinjie@huawei.com
Message-ID: <66cf4618f313_34a7b1294bb@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240828032343.1218749-6-ruanjinjie@huawei.com>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
 <20240828032343.1218749-6-ruanjinjie@huawei.com>
Subject: Re: [PATCH net-next v2 05/13] net: phy: Fix missing of_node_put() for
 leds
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jinjie Ruan wrote:
> The call of of_get_child_by_name() will cause refcount incremented
> for leds, if it succeeds, it should call of_node_put() to decrease
> it, fix it.
> 
> Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Fixes should go to net. Should not be part of this series?

