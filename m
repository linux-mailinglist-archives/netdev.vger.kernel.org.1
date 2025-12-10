Return-Path: <netdev+bounces-244310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB7CB4589
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 01:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBB3B30006DA
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 00:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B7187346;
	Thu, 11 Dec 2025 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlvJdnpL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8886352
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765412558; cv=none; b=fGmWDplVnEGVdGLErepHprRUO2vSLEYN65fwjbWHF2vsHRKuAFi3qI12eNKc2RgQ/vGZx3Z6bKCSfMnH3KqxhHMUiUExdIiXmmKzbFUSBfT6JlDPqncHeRAuMxgENXjHESRseBmGPTG5qUGIPkZgmwITR/zLj0rIAEuCVGdMuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765412558; c=relaxed/simple;
	bh=Zm++eM/Y4Y4Mw3cr2RFaF779TF5CMVf3HozqFbdbsqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F20vhwucqoQyoXa2MpT+Tx8vD82cB9LM4ialzP/Tw9sDtebaUQOxeBvFetSLxT0v2aKdTRmTO5CU6zf0jfeB93rqsNL35ZatGgM8YEpb6tYVRj9JoTCGThEKgC5tmZqCSweIVRHgutkeIh6oaKmxnEqY+txGXj4mBamyZBPEFwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlvJdnpL; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7636c96b9aso56030166b.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 16:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765412555; x=1766017355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5IMWQm5sz3Fn5h8gxR9KjhSHgtxoVBDtTdmB7LD/rY=;
        b=DlvJdnpLd51riV0LRYbCt2CnEXYE2Io7mnPwfhdoAh9bOcaoWAaBV/jr80dFyUiWVP
         voNTCHdTCXYsOMy1HcHrAUKHi9TFkMbBJIKmxClYwRt9rsi99MO1qLAput4Y1iEhcmS6
         ZjP+O/J+vd67SiOt0IGXtIgq0ELjc9Mk4DjK00me0IEdHG2Qi+mUDIelh0JfkOIBTHdS
         mX/b3ebS3kGgY/SJbVsW8FGIl0ya74gAKiCDSmKqU+2svI77UA3d3H/Bl8LDbeFhwhaU
         sqnTGXg5Tn4txePHwT+NhJq/AZD2uusxqTBdRAsqsk7JxP4JdDc7il8Drd+bbp0AS6Wj
         90oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765412555; x=1766017355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B5IMWQm5sz3Fn5h8gxR9KjhSHgtxoVBDtTdmB7LD/rY=;
        b=RUsQk9F3yL5ekDybcf4H21JRK7D5WaP1FPHc03vA+MDgjDTZaCvE8gOutgICN5qk2e
         1KW0Loy6kzy2HcRo7rYL/jTvyRZj8inLIBD28Qm2xhbLb5KtxafJYwMXPqJmbZY884xa
         5AbOE5GuzL6izCVzXTet9tZiybyiXD559oTD2BkaAP/eCqtySNwoxohtorO9mBd1l34n
         gQ3XA5+oxTDll72Mdues0iKK7y2QTQc6Daz7ZStXBIupDGmewzavaKuoScDgM/y/EpoW
         v/yl+uugRnK+LEx8zSp+hoB04yfW0+0jrSL4XMCiDbcmKXkvl1dAIQUk6xbnSLS1MpF5
         f4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV8oHsL14XCrAMv13FCw6CNZDtCgIVU8ljkYFpke17VeRSp8bXGFVD+mJB0X/adx80aO9n5oBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBeDq1PVftynR/9X03b4BA4t+ZpgCAra46V3ZGfGrleHG2nuYE
	5cQj7LeBT8JJhSgf6DY/KQP7a3Z+Phzk9pCbv5hR9IGbYHbWOSXdUlvd/uQ2aQ==
X-Gm-Gg: AY/fxX64qNr224l59RbJRzvHO7x+Jyq8slkjKILPGHHLykhFiQMPc+uu1ragUrly4FF
	/XReGYGMp/C9Bx66E8F0rx/KdThPROyD0J+XNRYMA/nK5CFk7iEoULaWG2GzorPKGWcWAxkmTH4
	pmGcmD2SLNSmAlNo0+u18szFo4ZOMEXVSGsxz8JdFunMbWe74cYgpevly9lGbb7OE2thPCKHSE9
	HxdORjNK7HM0RFAdKih1clXBVIQc9IWZfQdydSwnY7ykua3tWRfeuAlR1BKmnY8qXUQdigk6qGn
	HlWMAjMdJI1dVlAQc7vIaA+R1NxJ8q+sIYi1oey4I8pWJl74mgzxGMEI8nGdWQpm7Ddcb902OBI
	n012Fsb4ORMtkKcxFLbwKqlpLrKOF17EdY1T2qlmTCOwL0eTeUtNcLlWXiqolBgCFqYvEKAapod
	D95MsAUG6lRGIWq7ua+52KpzAoz1twSPno64BeERg1vhSZWE2Y08rJ1ZWaMD9iRAw=
X-Google-Smtp-Source: AGHT+IHJ5unPIP4qklvnNP+tvcAVqaSk7cuFkEwR0o5WYQPqgnyOEHIo7FqFLamdSrbYRL5Ra9cg8w==
X-Received: by 2002:a05:6000:2901:b0:429:b8e2:1064 with SMTP id ffacd0b85a97d-42fa3b05105mr4387383f8f.47.1765406443112;
        Wed, 10 Dec 2025 14:40:43 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a66b1fsm1691501f8f.9.2025.12.10.14.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 14:40:42 -0800 (PST)
Date: Wed, 10 Dec 2025 22:40:41 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Geert Uytterhoeven
 <geert+renesas@glider.be>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Simon
 Horman <simon.horman@netronome.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 0/9] bitfield: tidy up bitfield.h
Message-ID: <20251210224041.36bbde25@pumpkin>
In-Reply-To: <aTm54HCyCTm5k5ci@yury>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<aTm54HCyCTm5k5ci@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Dec 2025 13:20:16 -0500
Yury Norov <yury.norov@gmail.com> wrote:

> On Tue, Dec 09, 2025 at 10:03:04AM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Re-send with patches going to everyone.
> > (I'd forgotten I'd set 'ccCover = 0'.)  
> 
> And this one again appeared in my spambox. Have you any ideas why?

I'm getting the copies sent to my gmail account, but gmail has a mind of its own.
It bounces and spams a lot of list emails (never might the emails/minute limit
that meany you only get 'some of' lkml).

The email headers are a slight lie, the From: doesn't match the 'envelope from'.
Basically you can't send more than 100 emails/day (count of To: and Cc:) from a
'free' gmail address, so they are sent from elsewhere (with a 500/day limit).
But I don't want that address appearing in the emails - hence the subterfuge.
But the 'envelope from' is correct for where the emails come from.
(A test email to xxx.gmail.com with an envelope from of xxx.gmail.com sent
from a different smtp server confused gmail! The mail was errored, but it sent
the bounce to itself!)

	David

