Return-Path: <netdev+bounces-154621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 207019FEE4E
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 10:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E7617A1168
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 09:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A61C189915;
	Tue, 31 Dec 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXzeqw9/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B9136E
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735636746; cv=none; b=B3RKNtVNc25C64SfJED5XYtjuj+pRaW4KjlNabftBcagA77/TrYWwi6QhEj0oFU3agyyvS2biXdnghcdmzq1OmqghPhVM+rLsjZ0miZQJryqVHcQFWp2szQsYN1hD3vme6IrGw8P/5aUVNEXLLENel+dD/LHUtMjixAT3CQ5Ytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735636746; c=relaxed/simple;
	bh=H/DpE4eEMZpxgmbL96rSE6tUrsSMZ6Net8ZU1kK1Mgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrS9MtFSH0tcWVSvEqkShcPPHaBxJVNf5fBUAHd17gw0cNXwUAhWzhIB9A+nbdsFQkBE/Z7jC9/SmU3U7l6IgHfCdyKXzpkGcATVOnUkEzw30OOYuj6ajNraJecZNFNCBTUrhsLkQ43Gh7QKUjKdwEw+SpHnjFa16zWiAvm5XfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nXzeqw9/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso20087183a12.0
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 01:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735636743; x=1736241543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z28ITegE2MMH3jdCqG0rTlzcVDFy5oyc7gC5AwJYBiI=;
        b=nXzeqw9/9OqhEoPu0g4aqTWkxpiYS/dydxO/swIizFN0aNMFEVNQEfa9HrreA4nRnK
         TXuJ3gCvy4JVU55p2KfR3T9utXg6902CPSDWB3eSMfXjSJv1eNr0xUumR8w8TogMZnTt
         K/VwxmvDyDIoIg6boTiwByuKq/eHWCvnxzcUnFlD/G/OwYjmw+89jEO4lKaRSC+zhpLe
         yBAMqPyuYkcMaj29dpUDW24ip9NZdeRMDPPU/3k0Hw79BMoR6AdGFMgA/tI9vnzYies2
         6x61Bt2lWnkg5U33YE0GNJ5cPeykJBs4ZIRMdsGgjy4x3bmV5z2CUZg+P5xXCboMIPGh
         toTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735636743; x=1736241543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z28ITegE2MMH3jdCqG0rTlzcVDFy5oyc7gC5AwJYBiI=;
        b=vx78SkJJ7UihOgsJexBHymxYtsvZ1ftjvSyaLi3qEVOkBfW8vb6DBP/YsNm9Fm401W
         KGh5YSPCghc+bXFBClUaBZQjDx3DFMD+fiVlc9rlrKGYPzqAZ1is7sbs7i9m4Z55Kiw4
         NRss3egnQucBHvSltirurK7cG5n0lobg7d4OId5Q4P5+zmubMzyLOQoO4LGNk9ktI78r
         a5a5T0ZonK/xK39vxBjczJqI9loBWe5pDdwvEWvWB+Ua4eAcsWoW7lhV+bR6AWgsVBVt
         njSBdElcotsa5Ddj87BkIeVd1oRrT0U2bf2dmCEA/6bc2RL1dbiDjD2hH294b+ITx+ka
         2ecg==
X-Gm-Message-State: AOJu0Yxk3NWjAh+yOfXfmIMsifN4f6EXWdVzLEr/AcJuxc9Du6r90pu2
	c/+I2m/wZSEhPDGZh0hqZX8e8e49RYRJj15XoAZ8c++0K0+Kb6MdGQtKJOM3zLQTJEvI/YUiS7b
	oHP4uuAvBLfdPRFnMqeuRAzDUmY9Tlk/faZ2sK6lCa7c2wVk+/A==
X-Gm-Gg: ASbGnctAKJM8rLqf4jYZOkNfGEApfgNNMMmuXzRnazoo5kHbl1J9ofwJnv4Yfawya9b
	oi5MHQCh8vGj1Q0pNsUNpELCm5tRSaXtITZvM
X-Google-Smtp-Source: AGHT+IGZJfTF4PVVZEZ0sxAt8EylnWIZbznQlHvLkIhHX1fRLtQ1Gumojlo3QZDQ8mUXbCw90EpPs05BG00j26Iv7YM=
X-Received: by 2002:a05:6402:2347:b0:5d0:cca6:233a with SMTP id
 4fb4d7f45d1cf-5d81dd9cc7fmr39162074a12.10.1735636742923; Tue, 31 Dec 2024
 01:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFmV8Nc758FDNK3FNSLQui4RmE3-TQr7d2tM_tOM6bC=OfEDwQ@mail.gmail.com>
In-Reply-To: <CAFmV8Nc758FDNK3FNSLQui4RmE3-TQr7d2tM_tOM6bC=OfEDwQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Dec 2024 10:18:52 +0100
Message-ID: <CANn89i++A224Of5B+Eu+qfiQO1mXfXVfzuejuXyfCwtK1rmMDA@mail.gmail.com>
Subject: Re: perhaps inet_csk_reqsk_queue_is_full should also allow zero backlog
To: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 9:24=E2=80=AFAM Zhongqiu Duan <dzq.aishenghu0@gmail=
.com> wrote:
>
> Hi all,
>
> We use a proprietary library in our product, it passes hardcoded zero
> as the backlog of listen().
> It works fine when syncookies is enabled, but when we disable syncookies
> by business requirement, no connection can be made.
>
> After some investigation, the problem is focused on the
> inet_csk_reqsk_queue_is_full().
>
> static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
> {
>         return inet_csk_reqsk_queue_len(sk) >=3D
> READ_ONCE(sk->sk_max_ack_backlog);
> }
>
> I noticed that the stories happened to sk_acceptq_is_full() about this
> in the past, like
> the commit c609e6a (Revert "net: correct sk_acceptq_is_full()").
>
> Perhaps we can also avoid the problem by using ">" in the decision
> condition like
> `inet_csk_reqsk_queue_len(sk) > READ_ONCE(sk->sk_max_ack_backlog)`.
>
> Best regards,
> Zhongqiu

Not sure I understand the issue you have, it seems to Work As Intended ?

If you do not post a RFC patch, it is hard to follow what is the suggestion=
.

