Return-Path: <netdev+bounces-131475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C5598E940
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4040287BC1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 05:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC8364A9;
	Thu,  3 Oct 2024 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSbS/xn+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFE224EA;
	Thu,  3 Oct 2024 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727932059; cv=none; b=lZHEwOecJXZ/+3b4RoRbjfNc0tgoep/4z+sdA5TkCS3sxtrv0Jdnw76oG19ccKY64w2vb4H68kiyD7FRVcw09dYhwcDbqNYThKAI9toFYx2D4jfejy/RQqozoqZI3gPYzF4kvtkEXPnyMpeDr+ejFhcktKacDpzA0IUY1x4r11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727932059; c=relaxed/simple;
	bh=9IoJU6jTEuoyGkTbeSfT2pwABITRvMWUogRgOn/0ukY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MwatcvdzfV1tJx5GBlx+7k5deCZPD6IRcCZMVMDbRSPNBtiIPgyZBdsqa+SYelOtOQBSIow3P2FGB2NyOVwD42ILnHh44gGehLKzCqM6lg/pd6VGRS4bUnY422ExgK+YdKW9TI8qQE5WAC0WD/kWCcds4U2wJIa3H9a0dZ9+C28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSbS/xn+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b6458ee37so5044695ad.1;
        Wed, 02 Oct 2024 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727932057; x=1728536857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zMWuseD5uO8iPKDZb2vIk6waix6EUBSwtVjV6EXAl8=;
        b=GSbS/xn+Sd9QRJniTjvlBBhBP3oFeIOViAtU+GnGmfXxAS4Xo74JkTvU7eWZttO6vw
         2aN+5quYQSj9tWy/dImuo93p7Hz8w6Shw7hCvnD3xsHnfD0P6Y5IB3OZWHYbfd0yhltM
         98PELw2oUX25KY32XsxH9q+aIeeD8Qov3w1u3Sow5pSxITcboYw+kxwNs3XHjnRG9OEC
         HJkJO3rloc4/J6ZIkJqXg3hMIH3FCNi1MBe3Xo5TvAeePGjyON5FMDu3TRhuWnlQkw1l
         I64qPkOYbGSsy2drhwuthaTkeux5b5Xqh89o2NqPxfKEMPpMdnEyqKZr+NrhfKRzVF2U
         9LEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727932057; x=1728536857;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7zMWuseD5uO8iPKDZb2vIk6waix6EUBSwtVjV6EXAl8=;
        b=PYjmbFuh6L9LIbmEYBCY95DhUmR8TCDqzkX07Ov/JI5/lX95th6JQMsf3U3WWoMDzm
         yDkwIs5efXMn9cE+lwL7YRikIj19QgluXBAU8zeS6vrTRexOEo6aBqMMDiZcKd9wxAYz
         zDz07+ZgbRj7Fgyom5KkoDr3idLmpzczvA6PDLeClqy2BDYil1q6IS6P4CECOuOyMVbi
         PnAhd+f9HKPbjOGEd4iXNA6r66Se/iwqWGT6cE+sKCpmAJBQgyojTXtZMQpiX/xkb1Md
         1OqQjdmI6l5W23wyeLVZkJ2GFjJoNE0inWVz72hWOXkhUe/ORW7rA/+dQ6Jj14UFW/6C
         lVCg==
X-Forwarded-Encrypted: i=1; AJvYcCVHEGsaJAt7bEmxwxQFL1WTWCjwdLoo9wXBkx9zMQaq2FHCvsyf+piia69ydoVmPn4dpXc+e18=@vger.kernel.org, AJvYcCVhW1M9/zW4f3VU2zzTdmegkWSY+HbYKZwjECMXefjxAypVQxDKdUIXADzl5MCHJfLhkwe5kxqouGRCAvq/BUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ZSBO7uDUdLnMVMeCjLkwyaV+2pAVci/BtlmU9wNRUCFYvD0P
	3N72h9/bzBDQ00WQBUVcUy9r2rsNIAY7mX8hqn0NyqTNpSYeTFGp
X-Google-Smtp-Source: AGHT+IFA+cBSks7/4z7FPlkjwighWdqBBI7nG2LYqL3AkuJdBb8QLkUpwJ6TH/P6xM3XkA316pxY7w==
X-Received: by 2002:a17:902:db12:b0:20b:9998:e2f4 with SMTP id d9443c01a7336-20bc5a8ebecmr63520795ad.61.1727932056896;
        Wed, 02 Oct 2024 22:07:36 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeadad4csm1819785ad.27.2024.10.02.22.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:07:36 -0700 (PDT)
Date: Thu, 03 Oct 2024 05:07:22 +0000 (UTC)
Message-Id: <20241003.050722.44816085254739536.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, aliceryhl@google.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: [PATCH net-next v1 2/2] net: phy: qt2025: wait until PHY
 becomes ready
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ec7267b5-ae77-4c4a-94f8-aa933c87a9a2@lunn.ch>
References: <c8ba40d3-0a18-4fb4-9ca3-d6cee6872712@lunn.ch>
	<20241002.101339.524991396881946498.fujita.tomonori@gmail.com>
	<ec7267b5-ae77-4c4a-94f8-aa933c87a9a2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 14:31:07 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> There are some subtleties involved with PHYs, which is why we have our
> own wrapper around the macros in iopoll.h:
> 
> https://elixir.bootlin.com/linux/v6.11.1/source/include/linux/phy.h#L1288
> 
> Normally an IO operation cannot fail. But PHYs are different, a read
> could return -EOPNOTSUPP, -EIO, -ETIMEDOUT etc. That needs to be take
> into account and checked before evaluating the condition.

Thanks, I didn't know this function. I think that a generic
read_poll_timeout in Rust can handle such case.

#define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
				sleep_before_read, args...) \
({ \
	u64 __timeout_us = (timeout_us); \
	unsigned long __sleep_us = (sleep_us); \
	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
	might_sleep_if((__sleep_us) != 0); \
	if (sleep_before_read && __sleep_us) \
		usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
	for (;;) { \
		(val) = op(args); \
		if (cond) \
			break; \

The reason why the C version cannot handle such case is that after
call `op` function, read_poll_timeout macro can't know whether `val`
is an error or not.

In Rust version, 'op' function can return Result type, explicitly
tells success or an error. It can return an error before evaluating
the condition.

