Return-Path: <netdev+bounces-12996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4925D739A10
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79ADC1C2110E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA01B901;
	Thu, 22 Jun 2023 08:29:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9813ADF
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:29:47 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0673E212D
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:29:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f9c88ac077so13727565e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687422544; x=1690014544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hbwxpC0xw7XkVnrjIVAB99ci2nPRrRz36dwT+e9vk+g=;
        b=PVWLOK+VR33Zm/prePEVibZyKmpsMLa6AG/3v2HLcBaaxJiNcE4xgCyD3TsmX/32TP
         GI7MOq5F5KjjU1/1o/1EjRmQrtKCuadWBGeg9T+qWjqplKAYjvI82JTEIjGKqJw4MFic
         ll9Hbkx09TDC08wgyYhSwH/ZFan3DR5oSIO5Oq70oIbnRLKvWXnK9f92cnpBnlHeZokD
         Knf0nvvPIEc3kf32wPjVHwsORwvu/UU9wQgSCb5lHTCSOo9OfzdOhDenFrpUhWc0lfoN
         N3akc6xvZqyAoJ/2ewdjalMBQRHY3j1vdGWMbuoTfVe4qeYkF3BXXZbEXgWEsWEOwV6D
         yt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422544; x=1690014544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbwxpC0xw7XkVnrjIVAB99ci2nPRrRz36dwT+e9vk+g=;
        b=RY0I894jnszxXwqz8hmm6u+qs7UBQTMUsPKjMXlpqwobMrQgGSfeZ0hyrm/cewK5/k
         uA0EUC88kl7jwOozmltxpxkAi9OdS8ZG3feFZTZgn0PabG5GqnsBJkMKOiQzBse1ttR2
         Y3uo1rbyODFKEHYwRPAuTSzL++sXxdPGwEk9hmNd//Q4G4e+X5ywWE0a+ZlJfNGBlahI
         lvoW+g45H1q5NyvRnjKWHWtSQiaXcE8d5cood/5fsVnb43OYPV+j7Eq7ZOMZG4ZKbDoX
         nshPy23aLPMCgdJ/+50qrDNI/iJRmbjSY3VcR0c9rJx+RS6pmuwpcGNbbnOHJWe+mVXi
         L/qA==
X-Gm-Message-State: AC+VfDyVPFOCxH3yX45PjUFO0OsimpgmtYayQkaDcHXxozHqX51pZb37
	IJmh193Slt7TieXloJeNT39I8Q==
X-Google-Smtp-Source: ACHHUZ749vYbNDUpKIGtN032IquZOUkkd28SNYNQpx4KYD2HsyusPmVYrylB4hM6b3C4ipkRP34XTg==
X-Received: by 2002:a1c:7211:0:b0:3f9:206:c3a6 with SMTP id n17-20020a1c7211000000b003f90206c3a6mr12273569wmc.20.1687422543961;
        Thu, 22 Jun 2023 01:29:03 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003f80946116dsm18142424wmb.45.2023.06.22.01.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:29:03 -0700 (PDT)
Date: Thu, 22 Jun 2023 10:29:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net] netlink: fix potential deadlock in netlink_set_err()
Message-ID: <ZJQGTnqo6IgMGZ4j@nanopsycho>
References: <20230621154337.1668594-1-edumazet@google.com>
 <ZJQAdLSkRi2s1FUv@nanopsycho>
 <CANn89iLeU+pBrcHZyQoSRa-X_3G-Y8cjF6FJy4XwkJc7ronqMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLeU+pBrcHZyQoSRa-X_3G-Y8cjF6FJy4XwkJc7ronqMA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jun 22, 2023 at 10:14:56AM CEST, edumazet@google.com wrote:
>On Thu, Jun 22, 2023 at 10:04 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Wed, Jun 21, 2023 at 05:43:37PM CEST, edumazet@google.com wrote:
>> >syzbot reported a possible deadlock in netlink_set_err() [1]
>> >
>> >A similar issue was fixed in commit 1d482e666b8e ("netlink: disable IRQs
>> >for netlink_lock_table()") in netlink_lock_table()
>> >
>> >This patch adds IRQ safety to netlink_set_err() and __netlink_diag_dump()
>> >which were not covered by cited commit.
>> >
>> >[1]
>> >
>> >WARNING: possible irq lock inversion dependency detected
>> >6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted
>> >
>> >syz-executor.2/23011 just changed the state of lock:
>> >ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+0x2e/0x3a0 net/netlink/af_netlink.c:1612
>> >but this lock was taken by another, SOFTIRQ-safe lock in the past:
>> > (&local->queue_stop_reason_lock){..-.}-{2:2}
>> >
>> >and interrupts could create inverse lock ordering between them.
>> >
>> >other info that might help us debug this:
>> > Possible interrupt unsafe locking scenario:
>> >
>> >       CPU0                    CPU1
>> >       ----                    ----
>> >  lock(nl_table_lock);
>> >                               local_irq_disable();
>> >                               lock(&local->queue_stop_reason_lock);
>> >                               lock(nl_table_lock);
>> >  <Interrupt>
>> >    lock(&local->queue_stop_reason_lock);
>> >
>> > *** DEADLOCK ***
>> >
>> >Fixes: 1d482e666b8e ("netlink: disable IRQs for netlink_lock_table()")
>>
>> I don't think that this "fixes" tag is correct. The referenced commit
>> is a fix to the same issue on a different codepath, not the one who
>> actually introduced the issue.
>>
>> The code itself looks fine to me.
>
>Note that the 1d482e666b8e had no Fixes: tag, otherwise I would have taken it.

I'm aware it didn't. But that does not implicate this patch should have
that commit as a "Fixes:" tag. Either have the correct one pointing out
which commit introduced the issue or omit the "Fixes:" tag entirely.
That's my point.


>
>I presume that it would make no sense to backport my patch on stable branches
>if the cited commit was not backported yet.
>
>Now, if you think we can be more precise, I will let Johannes do the
>archeology in ieee80211 code.

