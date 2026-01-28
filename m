Return-Path: <netdev+bounces-254405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHskKgVRemnk5AEAu9opvQ
	(envelope-from <netdev+bounces-254405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:10:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D8A7854
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDC20302337E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F3037473A;
	Wed, 28 Jan 2026 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZbGMbhA6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6F374173
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623559; cv=none; b=GW0vJYsjQDY7jCB162aBAmCpItxV4ELjhv+IUZbg20ghr+eYfPqcdse826SLAxDhHPWwLm54kkzTlK+yytrrfA9bqy3QcdU0KH5F4LkbwpLy7pd4qvr9bPlnIq95e3w8AEJWGgVxh1DIOmi/JRMZS9WaY4mLj2i9I7WCDHgjSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623559; c=relaxed/simple;
	bh=KHMadrBICa5jNV71gIOsQxbjwE3VFwiNBVK3CQ6z4MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoJbPe6e3p7QyKGhcaFEhFwY3qudwfE2ufKiYh81qkHSuxKqU+OqlCXwzx5MAPc7ktLiMrDNMn4uRRyA1NOxRqDJ8e/k3wxRGlc4EbOrdjC4yyJPfqa6EH52qbxKiqVE5c9dIeKT3nvoB3y6y1OThL8jTqI21Z0aiWuvFtragyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZbGMbhA6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8850aa5b56so20239166b.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769623554; x=1770228354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+ilxlBZQu+Hua0zGnNmXXFBnz3Ws1A+X7KICF47R5o=;
        b=ZbGMbhA6Z6iMl3RwOH/qws7xuO+5xuIhxfoVQfmbuHk0pLpJ/4DRIwQeg2R7UK0BbD
         +Nnmy16QVYUhV7Zf5RLNLk26EYUmzTluJbVwuoTe1OiDvwOg4X6cQuRG4IcSRkIwewWk
         kSjbo0Xp6fSGPbg3a4FeF/uYnGwP+mnel8Bfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769623554; x=1770228354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+ilxlBZQu+Hua0zGnNmXXFBnz3Ws1A+X7KICF47R5o=;
        b=UpoTJAgjbrKPm5qZJXxb6tObLagQTtQhAH4IRTdz/447duwz6Rfp+VCmi2FuS5wSTO
         5nPXEfkUeu32SSI4/3uFwQLjRXO8i2uCF/9oGKayNd7Ya9O9YC6g96CzTg/3BF2Xf21q
         aCA8gfIUGlMENn/ZTjIy2OKeU1g/Cbh7a5hA4xBgT6CPxlOf4DyLb99QAufv7TGaogTz
         gL9QM6JyIQljaaPZgTGy5iQAYd0SJxZxAej2lGdmvaWX9SxTUqdKrHMq+6pXZXvz7+Fq
         +hs2YRQEddEIDbwAgN3bGjy3+ZD3kcQP44472kmv4f6cMs3M0F6hHDRle95JVgLDD/wv
         4G4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8NnlN3rgJDVyrnNSy9yOvNmwgyaJL1PqxixT47Kao4sYDi6llIR95YAlt5kARaeb0JBkKmLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkzXOjnBRioWA5k0XEsEcF/hFAZ+GkdcBM1t46sBWzfZ1M1Ww4
	BEyJDT2CnoQMoVXLWksX5gngW61L3c3gnZpaohA2gFbrZTZKr0iiMOsS8VptXo2wS0PVgaYrwHt
	sn8i43X0S
X-Gm-Gg: AZuq6aI+RAd8ohyLRyoM/0C0YGNoWRKgeDDmjeqW15At5CenFs4Yse4Nk0PXZ8sAYwO
	Ntz1McdOk55COUmUoF3Mrt+22DSJIz0mXbk6tr9vR4m4LgxcilHqSB8IpxJe1SWLSc+kZqyoGKr
	THogCExCAvcgjoJkol4r/O9ZGKUwNfzttqBEh/7YwRMca6OxEznv7Ybe1U9UJtK/l9KsXgcgfy0
	QgALQe+BYdVyGfqgvD4uuW2bdjP/c4rGzFvYzlvtCST228lH6N9NBJd9So/xhi/rc3Wlhymkfow
	W0rbbXlrk/4Y6NLJOS07N0ZdugCQzKb2iOE8EfRk/I9qZ0KCmgn6By64V8b1ten3AWzwkHEk0Su
	/j0ZfTE/F0/Qo57LBf17DS1Wn1SsqLxS/OsAO7Ez6nn4uy0Qpbqt0qUrhoOVJnHfssqn2FabcF2
	VERLgNM7W4YzyYwfU4LRgEIP34DWihFJNKMjctZIIctoH7OZKtaw==
X-Received: by 2002:a17:907:1c96:b0:b87:91cb:7412 with SMTP id a640c23a62f3a-b8dab469ac0mr455958866b.53.1769623554150;
        Wed, 28 Jan 2026 10:05:54 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbef86991sm156879566b.4.2026.01.28.10.05.52
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 10:05:52 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4327790c4e9so99490f8f.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:05:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPwS+NfK3LSZcuYqR1wH1aqg5yNmXM4G6a/I20tgPjumkd8pHNqCWPxbT+YI8g98J5HGi9Ttg=@vger.kernel.org
X-Received: by 2002:a05:6000:2401:b0:435:97b2:a9b with SMTP id
 ffacd0b85a97d-435dd1c0cb9mr8604361f8f.37.1769623551963; Wed, 28 Jan 2026
 10:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128070222.3393746-1-senozhatsky@chromium.org>
In-Reply-To: <20260128070222.3393746-1-senozhatsky@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Jan 2026 10:05:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WLj0fG6CqN2GwK5DntaRwQP1K4Sm-b-uwtON=-ByJfcQ@mail.gmail.com>
X-Gm-Features: AZwV_QhpWQJIZXZ_fAiJrxwycfOYe1_jmGHjkGRzqMN5ggQBM6eca6RUR66J2Cs
Message-ID: <CAD=FV=WLj0fG6CqN2GwK5DntaRwQP1K4Sm-b-uwtON=-ByJfcQ@mail.gmail.com>
Subject: Re: [PATCH] net: usb: r8152: fix resume reset deadlock
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Tomasz Figa <tfiga@chromium.org>, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	George-Daniel Matei <danielgeorgem@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254405-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F00D8A7854
X-Rspamd-Action: no action

Hi,

On Tue, Jan 27, 2026 at 11:02=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> rtl8152 can trigger device reset during reset which
> potentially can result in a deadlock:
>
>  **** DPM device timeout after 10 seconds; 15 seconds until panic ****
>  Call Trace:
>  <TASK>
>  schedule+0x483/0x1370
>  schedule_preempt_disabled+0x15/0x30
>  __mutex_lock_common+0x1fd/0x470
>  __rtl8152_set_mac_address+0x80/0x1f0
>  dev_set_mac_address+0x7f/0x150
>  rtl8152_post_reset+0x72/0x150
>  usb_reset_device+0x1d0/0x220
>  rtl8152_resume+0x99/0xc0
>  usb_resume_interface+0x3e/0xc0
>  usb_resume_both+0x104/0x150
>  usb_resume+0x22/0x110
>
> The problem is that rtl8152 resume calls reset under
> tp->control mutex while reset basically re-enters rtl8152
> and attempts to acquire the same tp->control lock once
> again.
>
> Reset INACCESSIBLE device outside of tp->control mutex
> scope to avoid recursive mutex_lock() deadlock.
>
> Fixes: 4933b066fefb ("r8152: If inaccessible at resume time, issue a rese=
t")
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/net/usb/r8152.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)

This is effectively v2 of:

https://lore.kernel.org/r/20241018141337.316807-1-danielgeorgem@chromium.or=
g/

...and you've incorporated my feedback there. Thanks! :-)


> @@ -8674,6 +8662,19 @@ static int rtl8152_resume(struct usb_interface *in=
tf)
>
>         mutex_unlock(&tp->control);
>
> +       /* If the device is RTL8152_INACCESSIBLE here then we should do a
> +        * reset. This is important because the usb_lock_device_for_reset=
()
> +        * that happens as a result of usb_queue_reset_device() will sile=
ntly
> +        * fail if the device was suspended or if too much time passed.
> +        *
> +        * NOTE: The device is locked here so we can directly do the rese=
t.
> +        * We don't need usb_lock_device_for_reset() because that's just =
a
> +        * wrapper over device_lock() and device_resume() (which calls us=
)
> +        * does that for us.
> +        */
> +       if (system_resume && test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +               ret =3D usb_reset_device(tp->udev);
> +
>         return ret;

Question when looking at the above again: have you thought about the
consequences of clobbering `ret` above? I guess it's fine since
rtl8152_system_resume() always returns 0, but it looks a little
awkward. It's been long enough since I thought through all this code
that I'm not 100% sure what it _should_ do if rtl8152_system_resume()
was ever changed to return an error. Shouldn't it honor the existing
error instead of trying to reset the device and clearing the error?

Also: I guess you've added the `system_resume` variable here, which is
different than the earlier patch. It seems fine to me, though maybe
you want to consistently use the `system_resume` variable earlier in
the function too?

In any case, both of the above are pretty nitty, so I'm OK with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

