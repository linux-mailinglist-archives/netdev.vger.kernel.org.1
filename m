Return-Path: <netdev+bounces-95750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11A08C3522
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 07:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E822B21132
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 05:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7009DDA0;
	Sun, 12 May 2024 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0BJTzV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65BCA62
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715491207; cv=none; b=ElefgDzEh3UfH8g3hKIJP94l9OdWmRyzh6uVHl+Ks5z59Sh/jmHcMSNjBZH+55SWkIcEbyBloE4G28KA7gcPGMwkX08vLj+nxspQN6hn3t4N4vaXkErjJaa9bTByUtt71esGCDpyN9qWZHraErdI22Y+IFlVeRqx/SNDbOIgCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715491207; c=relaxed/simple;
	bh=BUMb1fyfL7zv3hSazDVR3q/7yPscFPgH2+/VVsBhTBM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CJoanJhcXBa2xUy1rXTlUdW5B5wv/BewG36FaF4pRvvQD1JreRR2anA3/DM62fs1RgY3xBRcAi9Jn1Xc2krxw93MaId9wk+1K2Vmfn5VpaNnXPGxw6RsIzG5MpaYxuBFgpJCNbrV0xq296vbWFfMEUGiXtKNjCxQkpyXIVdPm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0BJTzV6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f44e0336a5so10759b3a.1
        for <netdev@vger.kernel.org>; Sat, 11 May 2024 22:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715491205; x=1716096005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQL7NyAlNFOLyVZx7ITxVR0WvEU4yQnVAYKTsTBPgA4=;
        b=Y0BJTzV6dpNLzTUZnfgDIQICMx7DT1k3x9DPv77CFLyYNRCqTNK0ZfKlG+46oaFmp5
         cxgxy7szT8t1M0rhdF/JqkiN7FvQizO0IScNdQ6BGjJPs6Idtui1H5vkolwCl7t/MjOb
         6xijHv1R9aie8VldN/pmsVzeob4MhN710y7pBvbnQJ8rLzpugkKHfpv9XOZMWnB6QqYe
         uoP0TNvVb3c2XCASfulY1N6EAgTcRVbaEHkNw0+W3yn67RfKUTpHs8YS4fFWFQBo88uv
         kEjUJ37XcTSGHC+QV0yGBjmNHaPBE0xgUPRaLFVMJ+7b2191Tl3yrmNiJujHGD/JeATs
         k+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715491205; x=1716096005;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QQL7NyAlNFOLyVZx7ITxVR0WvEU4yQnVAYKTsTBPgA4=;
        b=UIwF95D5KyOgvpsa/S5lQDqpJl3erod4K1bIhPL0uME3QtarzjkJZSaqlVZYqEJcIw
         u9KNB/P3PNYKzwEjM6WMxOjZcZ44qDtxwu4D7ER2iDTRTVtN0i/D6e2Q2Dmopzr5UBjZ
         XDUHx0jd2uiHqiILg32d4LOv09lPAs/71PtGPBjXhTe5xLObLocFy5V3Ike1BIbzzTYk
         N7T+OqmH2HE8TgLFfl+GzMG15qjPr7TN3tNws8+bPBfnwzaIFrePw5o/a9HT00P5EKwe
         xKY530C9uDhfb/y2JBHXgbaAlau0hGNs+qwIGnWo4BygumJPAjHbuyix+z8NGo9GDgw4
         uL1A==
X-Forwarded-Encrypted: i=1; AJvYcCUtNWbJlUn5pfPRJX+0a99wVnNhSHvibk1hJMZ3SGndRS6rDjIZVHcVqKzzM391kid2Du//0z3gEXxc58JmWORqXTXpJkuJ
X-Gm-Message-State: AOJu0Yw3hBMiRJ72UNYQjh4nXpdexbxX2gEKDCYx0yA6FQurnCsDtc+3
	Mfjf3QXFGjlwvoODRRLOlHjGzRAGaCvzEwu7POeF99yjt5cDmL9e
X-Google-Smtp-Source: AGHT+IFd97k2wqmVX/395ZytnPe+sk+Z9aZhU6SlEw03kG2eNpRoGPs1eerEGN9BIXI6JKycsluXgA==
X-Received: by 2002:a05:6a00:1895:b0:6f3:e9c0:a197 with SMTP id d2e1a72fcca58-6f4e0156188mr7200305b3a.0.1715491205271;
        Sat, 11 May 2024 22:20:05 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f7130sm5497705a12.64.2024.05.11.22.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 22:20:04 -0700 (PDT)
Date: Sun, 12 May 2024 14:20:01 +0900 (JST)
Message-Id: <20240512.142001.791439237151047486.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, kuba@kernel.org,
 jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v4 6/6] net: tn40xx: add PHYLIB support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <a7c9f272-9c5c-4aba-b7db-ae62e9cc8d0a@lunn.ch>
References: <20240508.221851.1563324062182870165.fujita.tomonori@gmail.com>
	<20240509.132341.474491799593158015.fujita.tomonori@gmail.com>
	<a7c9f272-9c5c-4aba-b7db-ae62e9cc8d0a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 9 May 2024 15:37:55 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, May 09, 2024 at 01:23:41PM +0900, FUJITA Tomonori wrote:
>> Hi,
>> 
>> On Wed, 08 May 2024 22:18:51 +0900 (JST)
>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>> 
>> >>>  		priv->link = 0;
>> >>>  		if (priv->link_loop_cnt++ > TN40_LINK_LOOP_MAX) {
>> >>>  			/* MAC reset */
>> >>>  			tn40_set_link_speed(priv, 0);
>> >>> +			tn40_set_link_speed(priv, priv->speed);
>> >>>  			priv->link_loop_cnt = 0;
>> >> 
>> >> This should move into the link_down callback.
>> > 
>> > I'll try phylink callbacks to see if they would work. 
>> 
>> I found that the link_down callback doesn't work well for the MAC
>> reset above.
>> 
>> Currently, when TN40_REG_MAC_LNK_STAT register tells that the link is
>> off, the driver configures the MAC to generate an interrupt
>> periodically; tn40_write_reg(priv, 0x5150, 1000000) is called in
>> tn40_link_changed().
>> 
>> Eventually, the counter is over TN40_LINK_LOOP_MAX and then the driver
>> executes the MAC reset. Without the MAC reset, the NIC will not work.
>> 
>> The link_down callback is called only when the link becomes down so it
>> can't be used to trigger the MAC reset.
> 
> So this sounds like a hardware bug workaround.

Yeah, looks so.

> But it might also be to do with auto-neg. The MAC PCS/SERDES and the
> PHY PCS/SERDES, depending on the mode, should be performing auto-neg,
> to indicate things like pause. For some hardware, you need to restart
> autoneg when the line sides gets link. It could be this hardware has
> no way to do that, other than hit the whole thing with a reset?

I can't find a function to do such in the original driver.


> Take a look at struct phylink_pcs_ops and see if you can map bits of
> the driver to this structure. It might be you can implement a PCS, and
> have the pcs_an_restart do the MAC reset.

I can't find anything that checks the link periodically until the link
is recovered.

I dropped the workaround and does a reset every time the link is down
(mac_link_down). Seems that it works.

