Return-Path: <netdev+bounces-51400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0617FA884
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 19:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E8A2815DD
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12953BB36;
	Mon, 27 Nov 2023 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f+Rfs9Ta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AAA12C
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 10:02:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54a95657df3so6437688a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 10:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701108147; x=1701712947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k5z90397pi7ekr0aSwm5AbyvVXSw/l+8AB8O/MLV8Fg=;
        b=f+Rfs9Ta6Cth2Y4CBoEYSajNgiLDkvfPEbUIJ3/E/WiDXwqXPGXgPJ271/enZffIYD
         ZNCtcCsbNPkRdxTY3ovkb3HgF3u30X7uJweYnUt1JWEV6d2LmuTWwfQIx3AqgfyvMG3U
         XcSsyEWczdR/KyY3tb+HFWppxNV1UF8wVMUJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701108147; x=1701712947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5z90397pi7ekr0aSwm5AbyvVXSw/l+8AB8O/MLV8Fg=;
        b=a5iWEEm7aq9sW5mt4dJ53yZqKKWjxmw8HYRLH2l0uA096VHro8//SxPb9KZ81n+KCU
         SijzVyzZp+2ttmzFMafowg1EnNrR5VXWJDVPXp0sfz6EL+lhPA+dD3vRv/k5zgIrEGOz
         FSUHL2ckcfRA1QtXUeUleUq/ecqilZgM/1LmB+aP9cfyPA1UjVh4B2drXqwbvQsZVHmJ
         7hV2DWmybEVYmfQajvlr4r7vEQA31If/Ruvu7zNHe+7Z24omyXg8IBj2EVWjkPzemOFd
         1uvU6DIyF+Yq7dkDW42K2gVsQ1jK8fGCyUx1S2RUyOmc86sAqbG81Scc48H2LGkOUqKs
         /H6Q==
X-Gm-Message-State: AOJu0YyAq496PvPPZ+MWmrqnUiO7sdILDXepea5gbgSputsoI5HQph33
	RXEYidgNrMEPK4GJRp5MpFQXS3PdX9fPcHqXlFL3Lp/h
X-Google-Smtp-Source: AGHT+IEN+3WNCZ1stg3wQGmYgbgHNZT8TSD827AO2K44DJgr9It6KKDy6uhloZHwQ/RW1tVQ4N8GSQ==
X-Received: by 2002:aa7:d68e:0:b0:54b:22a1:e70b with SMTP id d14-20020aa7d68e000000b0054b22a1e70bmr5652707edr.5.1701108147078;
        Mon, 27 Nov 2023 10:02:27 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id y13-20020a056402270d00b0054b50b024b1sm1925716edd.89.2023.11.27.10.02.25
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 10:02:26 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a03a9009572so621996266b.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 10:02:25 -0800 (PST)
X-Received: by 2002:a17:906:3bdb:b0:a04:7d85:2a6e with SMTP id
 v27-20020a1709063bdb00b00a047d852a6emr9464433ejf.24.1701108144964; Mon, 27
 Nov 2023 10:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
 <cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
In-Reply-To: <cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Nov 2023 10:02:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLsdX=Kr010LiM2smEu2rC3Hedwmuxtcp0pYtZvFj+=A@mail.gmail.com>
Message-ID: <CAHk-=whLsdX=Kr010LiM2smEu2rC3Hedwmuxtcp0pYtZvFj+=A@mail.gmail.com>
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
To: Igor Russkikh <irusskikh@marvell.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Nov 2023 at 09:29, Igor Russkikh <irusskikh@marvell.com> wrote:
>
> I'm trying to repro this on my side with some artificially increased structure
> sizes, but no success so far.

So I suspect that one reason I triggered the problem was simply
because the suspend/resume happened while I walked away from the
computer when it was copying a few hundred gig of data from the old
SSD (over USB, so not hugely fast).

End result: the suspend/resume happened while the machine was actually
quite busy, and presumably a *lot* of memory was just used for disk
buffers etc. The "duspend when idle" logic doesn't really take
background tasks into account, and my logs leading up to the suspend
shows

  13:54:09  systemd[1]: Starting systemd-suspend.service - System Suspend...
  13:54:09  wpa_supplicant[2401]: wlo2: CTRL-EVENT-DSCP-POLICY clear_all
  13:54:09  systemd-sleep[12477]: Entering sleep state 'suspend'...
  13:54:09  kernel: PM: suspend entry (deep)
  13:54:19  systemd[1]: NetworkManager-dispatcher.service: Deactivated
successfully.
  13:54:22  kernel: Filesystems sync: 12.738 seconds
  14:06:30  kernel: Freezing user space processes

and while that last timestamp is bogus (the timestamp comes from
syslogd logging, and it actually happens at *resume*), you can see
that the filesystem activity was pretty significant with the sync
taking a long time, because the copy process was still on-going the
whole time. And it continued *after* the sync too.

So I - accidentally - ended up hitting a lot of "that's not great"
cases on this, that I wouldn't hit normally (because I obviously turn
off suspend-at-idle). All on hardware that isn't normally used for
suspend/resume anyway, so it probably has somewhat limited testing to
begin with.

For triggering it, you might try to change that

        self->buff_ring =
                kcalloc(self->size, sizeof(struct aq_ring_buff_s), GFP_KERNEL);

to use GFP_NOWAIT instead of GFP_KERNEL. That makes allocation
failures *much* more likely. It will still work at boot time.

Or just artificially make it fail with a "fail the Nth time you hit it".

Also, make sure you don't have ridiculous amounts of memory in your
machine.  I've got "only" 64GB in mine, which is small for a big
machine, and presumably a lot of it was used for buffer cache, and I'm
not sure what the device suspend/resume ordering was (ie disk might be
resumed after ethernet).

                Linus

