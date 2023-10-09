Return-Path: <netdev+bounces-39281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E247BEA78
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295251C20A11
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B3B3B7B1;
	Mon,  9 Oct 2023 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPOk4Ui4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F8BA4B
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 19:20:09 +0000 (UTC)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B46A92
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 12:20:05 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7aae07e7ba4so1512518241.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696879204; x=1697484004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s28im8xW83xDxs4xNIcwpy5ou/l9kkYUKlpUzoiax/s=;
        b=sPOk4Ui44WeEv24QG98iB07+uqYB461XD/6jld+hnCqBybb5Qp7H3P59o4+U9nldZM
         2c8C9G9DCpr5Zc80DGXX2xPlvOQKGaaXTgk2TZLvIOzSeII9lJy+7zslcImZZkmsbL9R
         3tBDRdHNZjgX9OOfJzldIqB2eUdA3DmbVeMYsFkp2JS81nOKJ6LDW4YMkR1mxtYE+etF
         hFYIAiL4FF6/aZO8UDkYNVP07cIBv0LDOGaGpfHi1Qj27qs6qqEhwhUilrh/qM2+OtY3
         MiRhT5Npi83AWb6tcOx7+XulPY5YB5upt6fCUig9I/l1mJX4hFrIFSpvfjTZTAwcvMmB
         4c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696879204; x=1697484004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s28im8xW83xDxs4xNIcwpy5ou/l9kkYUKlpUzoiax/s=;
        b=bJSlq2ZizkjzLJbc1cY0xVTi3Jg0izdIjiE/ptppMX6lq38brYcGCLTxos1TbjGC8v
         2rwTkX/s0TFw8R2q0zsHfTwsaAz7QRYY2ZaybUw0SOKZ/1E+9Wj0E9XHMgGWQKrmYtPS
         03bgzaEnIsT/UYsmq+ugqbRMtGgGp0h+wC4sEEEMuXsc1ct6z+tfz3A2gLUcdws9Z0UL
         UcYoP4w5JNLxz2u03pUVm7EfrDkh1kdgjSfEn8jPEObSP3jk71s9l2VgBOFnqoJvnUTH
         BomCxfhpsI1+cGS5JqHJ5S8lVLEUiCom8LBv5yphp5rOgQT3sz57MyoVq98Mue4rEc9e
         dFtQ==
X-Gm-Message-State: AOJu0YyYKnMdo+3uEgWnMSshgJLDZLK2Y3xgf8dUxaZF805sHaRxr8ft
	EpsxdcUH1hWthzE7AEjOHbZHHLgZUOsThKLjfoHqzeDImnm3WHLHGl8wCQ==
X-Google-Smtp-Source: AGHT+IF6rYlc0fE6xsoJCQuFG33Y5IwaO8woEZyhNoHVM8jG5zRYvkRXIJgyFna/6o2GOF4Y+wcvI/9DpJD9z7nx8LM=
X-Received: by 2002:a05:6102:8a:b0:44d:4a41:8945 with SMTP id
 t10-20020a056102008a00b0044d4a418945mr14805672vsp.8.1696879204472; Mon, 09
 Oct 2023 12:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net> <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
In-Reply-To: <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 9 Oct 2023 15:19:47 -0400
Message-ID: <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
Subject: Re: iperf performance regression since Linux 5.18
To: Eric Dumazet <edumazet@google.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Jakub Kicinski <kuba@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Oct 9, 2023 at 8:58=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> w=
rote:
> >
> > Hi,
> > we recently switched on our ARM NXP i.MX6ULL based embedded device
> > (Tarragon Master [1]) from an older kernel version to Linux 6.1. After
> > that we noticed a measurable performance regression on the Ethernet
> > interface (driver: fec, 100 Mbit link) while running iperf client on th=
e
> > device:
> >
> > BAD
> >
> > # iperf -t 10 -i 1 -c 192.168.1.129
> > ------------------------------------------------------------
> > Client connecting to 192.168.1.129, TCP port 5001
> > TCP window size: 96.2 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 192.168.1.12 port 56022 connected with 192.168.1.129 port 5=
001
> > [ ID] Interval       Transfer     Bandwidth
> > [  3]  0.0- 1.0 sec  9.88 MBytes  82.8 Mbits/sec
> > [  3]  1.0- 2.0 sec  9.62 MBytes  80.7 Mbits/sec
> > [  3]  2.0- 3.0 sec  9.75 MBytes  81.8 Mbits/sec
> > [  3]  3.0- 4.0 sec  9.62 MBytes  80.7 Mbits/sec
> > [  3]  4.0- 5.0 sec  9.62 MBytes  80.7 Mbits/sec
> > [  3]  5.0- 6.0 sec  9.62 MBytes  80.7 Mbits/sec
> > [  3]  6.0- 7.0 sec  9.50 MBytes  79.7 Mbits/sec
> > [  3]  7.0- 8.0 sec  9.75 MBytes  81.8 Mbits/sec
> > [  3]  8.0- 9.0 sec  9.62 MBytes  80.7 Mbits/sec
> > [  3]  9.0-10.0 sec  9.50 MBytes  79.7 Mbits/sec
> > [  3]  0.0-10.0 sec  96.5 MBytes  80.9 Mbits/sec
> >
> > GOOD
> >
> > # iperf -t 10 -i 1 -c 192.168.1.129
> > ------------------------------------------------------------
> > Client connecting to 192.168.1.129, TCP port 5001
> > TCP window size: 96.2 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 192.168.1.12 port 54898 connected with 192.168.1.129 port 5=
001
> > [ ID] Interval       Transfer     Bandwidth
> > [  3]  0.0- 1.0 sec  11.2 MBytes  94.4 Mbits/sec
> > [  3]  1.0- 2.0 sec  11.0 MBytes  92.3 Mbits/sec
> > [  3]  2.0- 3.0 sec  10.8 MBytes  90.2 Mbits/sec
> > [  3]  3.0- 4.0 sec  11.0 MBytes  92.3 Mbits/sec
> > [  3]  4.0- 5.0 sec  10.9 MBytes  91.2 Mbits/sec
> > [  3]  5.0- 6.0 sec  10.9 MBytes  91.2 Mbits/sec
> > [  3]  6.0- 7.0 sec  10.8 MBytes  90.2 Mbits/sec
> > [  3]  7.0- 8.0 sec  10.9 MBytes  91.2 Mbits/sec
> > [  3]  8.0- 9.0 sec  10.9 MBytes  91.2 Mbits/sec
> > [  3]  9.0-10.0 sec  10.9 MBytes  91.2 Mbits/sec
> > [  3]  0.0-10.0 sec   109 MBytes  91.4 Mbits/sec
> >
> > We were able to bisect this down to this commit:
> >
> > first bad commit: [65466904b015f6eeb9225b51aeb29b01a1d4b59c] tcp: adjus=
t
> > TSO packet sizes based on min_rtt
> >
> > Disabling this new setting via:
> >
> > echo 0 > /proc/sys/net/ipv4/tcp_tso_rtt_log
> >
> > confirm that this was the cause of the performance regression.
> >
> > Is it expected that the new default setting has such a performance impa=
ct?

Indeed, thanks for the report.

In addition to the "ss" output Eric mentioned, could you please grab
"nstat" output, which should allow us to calculate the average TSO/GSO
and LRO/GRO burst sizes, which is the key thing tuned with the
tcp_tso_rtt_log knob.

So it would be great to have the following from both data sender and
data receiver, for both the good case and bad case, if you could start
these before your test and kill them after the test stops:

(while true; do date; ss -tenmoi; sleep 1; done) > /root/ss.txt &
nstat -n; (while true; do date; nstat; sleep 1; done)  > /root/nstat.txt

Thanks!
neal

