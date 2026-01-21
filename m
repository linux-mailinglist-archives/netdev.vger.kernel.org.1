Return-Path: <netdev+bounces-252038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELz0Kps4cWnKfQAAu9opvQ
	(envelope-from <netdev+bounces-252038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:35:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E35D599
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BFB43A285E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA13A8FF4;
	Wed, 21 Jan 2026 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCobc10W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC923A7E06
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021949; cv=none; b=H6kQ3MTCKBq5LpIsjEsRkOFUoqhdNVPGpe11mwemzMzGJUlstwm+fVPrgf5r1iVbRIbHDnmQNLc8xpOah87gqDtq8F1iroP9KTF0jMYwTxbyRTjI4PFFkuo0RjHlOVjm9V9058+eUf4ARLs/hULMDeU8axesRu46aq58BJ/ZO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021949; c=relaxed/simple;
	bh=wrxxGjfP+5GnkRibkSGpyCxIsIz43rN4YQvaQ7oPfIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6MaxKM+0UFBhtC/fMkZajJpUQcLQO5aT/9ON19eRSDNu3PXeWhDFa29f9rkcTHkWj/s2EDB546TEBZvEJG07YD6u/ZIbSHFjgd0Anh9Z8XDnjbuFESrq7oa2wkT/qOwRMmDF5tirQBE2U8sOPhWlNThCQPiFqnQpv6b2nV+MhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCobc10W; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso1739165e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769021946; x=1769626746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3CiRXfW7OiyeqDRS/V5H9jo7jqnwu85t2dfMJoFCM0=;
        b=QCobc10W8qh+W1kpAc54iwiZcOtuAkIgrjliU3QHFE3QfrE0ZElvW/B8q4Fu0Avo6b
         J7Tl1wtv6oz7OvvXArZGOh4PNag0ch/56cJdZye2pvyjoe/bCkh3s+suNIa4Se4XPsxm
         68PFZ8kuHOFYnLxowd7ufvcJFD9phNt8cDE3yn+1+2dMXsdv9Iw3ajMS3CXhfnoQOFOH
         jg0XBcX29zU5DTN8AH6VNwG1MpBbptPi0kdlsrRo7UvE93VMghaAoyWQsjsOer9R0h1q
         nGdD3TcAVvC3iiOg7/1h+0QZYom3x61VXzj0wrUt0m5s8/jpcN7TlC0mrspnNbvuXpKs
         a/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769021946; x=1769626746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v3CiRXfW7OiyeqDRS/V5H9jo7jqnwu85t2dfMJoFCM0=;
        b=b/H6DYNTRa0sGzYlqP7J9AJNJAF6uDWIiEMC7b7LHp8wEFQ7mv5VYurqOT8Sp5pWcX
         VAEx1ffCOicOrtnOtOVXjPzZo1wHRH6XfUS7DfDyxkjkUr9351kTucL14uGfSbz6yTLu
         oZEEyuKbErF0zFWR6RxVIJxQc+q6LXz2XlxFrkYPc8bIk4G5zXlYBkIEbTTp5fFPWvJK
         4UEKFBMnaiOc2U2to+ZmD65E6/zVeueE+qGThnJL02kWvW78QrtissoZg+Hsz1wAlt8P
         BZ0znVlW7Gw3oGJzSz0/p6KefP5OlM7BH1ugsJ+62eCrcg0HS+V1lPm98yXfcQPf6ox1
         cvDg==
X-Forwarded-Encrypted: i=1; AJvYcCUEKnRPDU2OSmNX7QSnTE3GZPdfdBWqcAz3F/XY1RhivmlS+UwBL4nHxnfQpqA0JFPEjTtIQu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyth4DpGLrITQhOyhiX8l7Te5NQ0gCN9x26wUDPJhefYtc1nlvu
	A8uZ+y1gkidhPv2D04GdjxQrO7JUBG/evwhKfA9iPcGfqzLRT8Q8qK5h3DgDHw==
X-Gm-Gg: AZuq6aKxlD3NcpeuGfAiZSNt1Dkpz0bi+u4xliP1CcE6LQcZYzIjOR14LMMkSVn41nb
	Gz9v0nE4FH68Uz5ewo3rHcaR7z13RNy8diddjrfyk+ZoiXcvqqvp6mvk9OCEIpRePPDr+PpXvnl
	mwmS1+ab7vrVOFuNS+BWHLRnjs/MkRlfkfDOB3IUYOvqGwQ53LrJsYdR3iPM/iodA1hCF8Xt4EX
	V7+jtBxwPc6wsW6ekJdSjjJrJff+IOmFuKhur6uuQosbWw6NbPO0XBs/AYEowi4ZQE+l6Ww/qHs
	Q66Kc6QIElFeCuFYq8c1fowPawueSj4O4+9yvdKZgtjIp1L/4eFZ1CPv7MylTOb4qEECM0bnSBA
	Em/r6oJbzZ2q/hjkf8Ulw1qZ8lQhP5M+NtvgFXXV35QoT9R9ulqUvcCZpQZsv/8ZJPaImlcaE8n
	gJvdtMsVblRwDMwh2zP2Lqxsv8PIdw+x6PujVScJf/qmW3JfpVvYLh
X-Received: by 2002:a05:600c:1f87:b0:480:1e92:dc65 with SMTP id 5b1f17b1804b1-4803e7f3c8emr99522385e9.31.1769021945554;
        Wed, 21 Jan 2026 10:59:05 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804245320dsm9691175e9.0.2026.01.21.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 10:59:05 -0800 (PST)
Date: Wed, 21 Jan 2026 18:59:03 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 03/16] bitmap: Use FIELD_PREP() in expansion of
 FIELD_PREP_WM16()
Message-ID: <20260121185903.201abe71@pumpkin>
In-Reply-To: <CAMuHMdUo_Xow2YwMaDzPUW8w-3O12nqguzvoR6ij0X3R+syvOA@mail.gmail.com>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
	<20251212193721.740055-4-david.laight.linux@gmail.com>
	<CAMuHMdV3WAxshZL9gw4+NeovX-9FjUZrk+coUAA7+=y6GmPECA@mail.gmail.com>
	<CAMuHMdUo_Xow2YwMaDzPUW8w-3O12nqguzvoR6ij0X3R+syvOA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252038-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,rasmusvillemoes.dk,vger.kernel.org,bootlin.com,huawei.com,melexis.com,intel.com,quicinc.com,infradead.org,kernel.org,davemloft.net,linux.intel.com,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux-m68k.org:email,glider.be:email]
X-Rspamd-Queue-Id: 585E35D599
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 17:52:29 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Wed, 21 Jan 2026 at 17:50, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, 12 Dec 2025 at 20:38, <david.laight.linux@gmail.com> wrote:  
> > > From: David Laight <david.laight.linux@gmail.com>
> > >
> > > Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> > > not be used outside bitfield) and open-coding the generation of the
> > > masked value, just call FIELD_PREP() and add an extra check for
> > > the mask being at most 16 bits.
> > > The extra check is added after calling FIELD_PREP() to get a sane
> > > error message if 'mask' isn't constant.
> > >
> > > Remove the leading _ from the formal parameter names.
> > > Prefix the local variables with _wm16_ to hopefully make them
> > > unique.
> > >
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> 
> Oops, just noticed  commit 2fb6915fa22dc552
> ("compiler_types.h: add "auto" as a macro for "__auto_type""),
> so you want to do s/__auto_type/auto/g.

That wasn't there when I was writing the series.
I knew it was coming but didn't want build breakages.

	David

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


