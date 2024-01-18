Return-Path: <netdev+bounces-64112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4F5831290
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 06:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042D1281360
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 05:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D6749D;
	Thu, 18 Jan 2024 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRENaElS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B5125A1
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705557360; cv=none; b=iR5bIAojJMTI+FQgOokI3kYDhkj3rY+PZkG1La5EptnXZ3GiSB0KEAAaGJ0p1VZZUL5yGpa1V/LJLAl4xwsbD9wEmE2lWw7np2mp+ea99xR1f4mJOs9wtmm1xokbMndKajCiOV07XyN5fh6eKI+vVxuy78GERBVhnwMerJrLMIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705557360; c=relaxed/simple;
	bh=J51DROh2q9HcrktYaKvfGfWFdO2nlysGA+y50w6ncxo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 From:Date:Message-ID:Subject:To:Content-Type; b=uVTnhSAjFUEY4qvHcXUPxlXttRM4MPQEfNfhPeK4VxMDrh+2YBjfiGCgSvrJZUK4O8mf19a7uA+7/8W/ew4KvtLr6o772n/roH+vo7qLCpm47q1rX0nAqexfF8EZhhNCm5O9Rg7YDoWY3rLPNYD2YYj8oSyy5Vttn2jTtp3njb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRENaElS; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e7b273352so13270699e87.1
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 21:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705557356; x=1706162156; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J51DROh2q9HcrktYaKvfGfWFdO2nlysGA+y50w6ncxo=;
        b=NRENaElSvolTDyi2lxQAg21mYZKqyvRhxcCffsg+PNlounEHvysOxbZP3LanxpgjID
         KoqyVNEB+QX6+djuzvixITQjaE6vD1929onHqUyOjEu/2DHpr+k1D14dYh0oPyV4kJHa
         4NDz8hCN7qGvmPygWsM+rC4yFSYuv+jhwfvyn5SPoREjABBoEcdQ+4L9JHZrrGB5QMkM
         B1DqDe8awArwFj1zQnPY77CSELhvB62/woaaddWwSktE9JyPl7PUjs2Jz6IEoRS6F95W
         /GpfEcOAx1MTN7YeaQ7F35Bia8P+stDUpNd6R4pFoSp/6rvBKoSh0JMGiuhRH8Ln9IsR
         AlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705557356; x=1706162156;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J51DROh2q9HcrktYaKvfGfWFdO2nlysGA+y50w6ncxo=;
        b=AOj10JpR00mseT/9PpkbntnGZt75Nbqb9B3A2Uq+QrdORUw43VXvxi4hKUTucNxPFy
         6h4VyjAeApzEC0XkY2ua/2nBOX5X2eoo9/RK8amgOkxXYxn0I9rfXhVoIZbHW6ZFnVYK
         2XhmlmzvXO8nLaU/xuaDzup+s1OMFZ9vDtmGhQC3wQdBuZqASuiHGKyGeywhpV1Rw/IW
         Vw6YNzmdbbRmmJgJCZ4CSVyHO9LKpEQWoujssz0eE4vcKnzPut6EbR894cIF0MFvBeNe
         Y8Fj8Do/bQYPA+g3LenXz/ql3j1nMzSzrDjtYZwcMoRmP8dOQl/L825nmPy9S/8tgqXO
         X5vQ==
X-Gm-Message-State: AOJu0Yzv0s9Q3jiqqrFE1Pwf0nq7awEyiT8O2HjlxM6kh/P3gywZAU0C
	yjO1WVoDtO8zNHml1H1bsDTegpQg98bQnbskMd7ADftpuEzUnORNPbyJ4MR2hICewAz1lBqsQJc
	ZQxyRhkvIZK4Gn4iBkqUNRGE00SLm/vvWJJQ=
X-Google-Smtp-Source: AGHT+IHXR3HpmZhyLz1SZZ+rmZvEEGtMKWaVW3ANmc4NXme8CjbvdOVUU1VYG4And3Rp+sk1XcsO0Td99A7/DmcJXLM=
X-Received: by 2002:a19:6903:0:b0:50e:aa30:5ea1 with SMTP id
 e3-20020a196903000000b0050eaa305ea1mr117116lfc.61.1705557355828; Wed, 17 Jan
 2024 21:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 18 Jan 2024 02:55:43 -0300
Message-ID: <CAJq09z6u+=zHPQT05t5pdXCZdTuy=zLiT9N8Yayc+MoFb1L5iA@mail.gmail.com>
Subject: DSA driver support for RTL8367R
To: "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Christian Lamparter <chunkeey@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

While net-next is closed, I played with a device that uses RTL8367R.
It might not be a popular version, as most next product iterations
switched to RTL8367RB or something else.

It looks pretty close to the registers rtl8365mb uses, and I could
bring it up with some tweaks. It also reproduced the bug Christian
reported last year
(https://lore.kernel.org/netdev/802305c6-10b6-27e6-d154-83ee0abe3aeb@gmail.com/T/),
which we still need to fix someday (no supported devices affected). My
device also has LEDs that might help expand the LED support to
rtl8365mb. However, I could not enable the CPU tagger. I played with
two registers: RTL8365MB_CPU_PORT_MASK_REG 0x1219 (by default 0x0000)
and RTL8365MB_CPU_CTRL_REG 0x121A (by default 0x0002), but nothing
seems to be changing what I get in eth0: external packets never have
the CPU tag, and the switch does not react to packets with a CPU tag.

GPL packages from products that use the RTL8367R indicate that they
use the rtl8365b "vendor API." That API does have the functions to
enable the CPU tag touching the same registers I mentioned before. I
wonder if that switch does support CPU tagging. Does anyone have a
clue or access to docs/vendor support?

Even without the CPU tag, we could try the 802.1Q tagger. I didn't
find what limitations that kind of tag would introduce, but it might
be enough for some cases (or else ocelot-8021q wouldn't exist). An
802.1Q tagger would also be interesting for those devices that cannot
handle the checksum offload with an alien CPU tag.

Anyway, an 802.1Q tagger might require VLAN support, which rtl8365mb
does not have. Before digging into that, we need to fix that
limitation. Alvin, you were working on forward offloading/vlan
support. Could you share how it is?

Regards,

Luiz

