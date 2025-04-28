Return-Path: <netdev+bounces-186448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979A7A9F23B
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2D93BAF1C
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C0D26B2A6;
	Mon, 28 Apr 2025 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="DuM5gyu8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D826F445
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846650; cv=none; b=De0T/DdbG/19CC05FRY47IhysHjCt0dKLHCtl4KSFm2Vdjj8+TTzbtihk2gSvX4SlS+iZu3KXfbod5QWPNHyjsQpNpv9h94Gzly8oouprMKpZSa8X1w15a5PCVhkPLd1M95LD+VxaXPAq1/6G6tJViU9oOTKh1yBIXy6kpyMN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846650; c=relaxed/simple;
	bh=PmQyLy7Aq6bk7O/SQ4dpOpkxecVC1cJ0WPk/IprbQq4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DS6wNOOdLfnhm9TPbwktXggYCt2EDTfn8zdydOrvT6t153Ne2uHp+iWeKqC1ovBuVjEIOZ+o7jinfWYVe+427yRR/Ku4rrsWNs91teZkDr4bZTLmKJaYSFMcYXIxKEZG1cDmwxmKwapxSauDxexjnTLhErmHvXiUv80oRoR/dK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=DuM5gyu8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22928d629faso49910815ad.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1745846647; x=1746451447; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cc1JltRnEXVoXfxQnmGodF9hXnPX5Gy9UY+RVdWukzM=;
        b=DuM5gyu89ACQPhJb5NBYZvBXeS18ZdJQ68vH7LjWWkfwRu3QeYh7H6xJtu46ienyqj
         C4vTzyZyn24nHHWYP2PnzouJ2SGol45C1Uh8wD21DX+yLFxyxTBP0RNw/fdpeE8u9yfy
         xaw5U/2wqar1YwQOlTot1B2fSKQm1qeD6SkEc0Q0NRAO78uXubK9q65Et1tSsSXCS42K
         IcrvySOuoTWg+pBWcR0rk7qd6DPDyZv5QiYyB00+gbL0zGrGLZKAZp73I03FAsQFsxKt
         pgS21wFQmKqGSlApUQK9vHlhwcd6ujXutHQ4I338DM6UCWeSJrXsv8MPtr/kJBHGJJjw
         JWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745846647; x=1746451447;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc1JltRnEXVoXfxQnmGodF9hXnPX5Gy9UY+RVdWukzM=;
        b=npzjbBUZQhh8gbbrHYKsheWpxp/BGqBpUHigF7KkPFrx53B8UEdke/c7P1f1pO91ij
         sMPLSttZ6QqVuiw58kbOpUjzzYuNYikgBjj2dKaGZhv7HjqiuZ+favD3zPPX0rmtZ4iP
         68VXr+2IAbt0Kt7usRt8ZVEKXZ2/3Y/FNB6R1iRkQSclFfU8cH5N1rczkH+2cwExnvmj
         thav110cJuAnDuITHxnKPIFo/DtOoqqqktk2MhDpwLDMzzdp14T41OMNDOtRTROdbCDf
         mqQLQ3hzGf7VR8oPdBxOABUbLQCEO31xgXKMsgg5DUpZSrAW0qTzrCHaroma3J9HUNFd
         HxIw==
X-Forwarded-Encrypted: i=1; AJvYcCUZLB7bTpShn02fsRJM2UYjNrTfG6FmYq/bYHXEba2VExwgVOza65x+90FW2SQWyVJVkh3mAsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWy+hAwF55hEA6uWZypgWC+Vsstw3dJU8ofBWZs+qkFjzLXaAg
	zT0uNL49KQ1ghBz/k8HtYiGeqhppwj4nePz1NCRPgWDKDYa/s56vozCMQ9Qa0ck=
X-Gm-Gg: ASbGncsaACV8nk1bE3PpnV/0PIaXj+36AEA4QRi6KST08zFIWqDGbikM15bGC/mUQ1d
	HIPeIEI2NXAGZh4t+/ES1zF/0JMTjuF+mGNSJbrKByhvrEDSQrD8v5krnIAjcMADD8iH7KNm2BE
	HDXIpkqv5VufmR4f8fcx8LIRyzfUGCij3l8jnB2Rye8p3dznBqVZKw7XV1vd+MeC8C5CqHoIZrk
	1Vh6AIw+U01ygi5JGZiq8hSu1dkujXw1IQMoo8QdT3UC71BCmSVK7nGuuXQ4u6Ot+/Jgicq1Iob
	0pAdCgz5e8+run+HCpLpnUsOV45pWh+Jokxz0zR4mKFiw4jjHA3uUfSK/uPbMA==
X-Google-Smtp-Source: AGHT+IHCGED2CBj8LlmkLPuATxF0Vcn88OUmifmERICAB1lW0PXM4o1XOdPHW0EQbJ34BAvw2G/avw==
X-Received: by 2002:a17:902:e786:b0:223:44c5:4eb8 with SMTP id d9443c01a7336-22dbf63a03cmr175810165ad.32.1745846647290;
        Mon, 28 Apr 2025 06:24:07 -0700 (PDT)
Received: from smtpclient.apple ([210.186.183.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221c60sm82013865ad.228.2025.04.28.06.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 06:24:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Muhammad Nuzaihan Kamal Luddin <zaihan@unrealasia.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 4/6] net: wwan: add NMEA port support
Date: Mon, 28 Apr 2025 21:23:53 +0800
Message-Id: <4D47E70F-D3F3-4EB6-8AE0-D50452865E58@unrealasia.net>
References: <7aed94ce.2dca.1967b8257af.Coremail.slark_xiao@163.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 David S Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Abeni Paolo <pabeni@redhat.com>, netdev@vger.kernel.org,
 Qiang Yu <quic_qianyu@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johan Hovold <johan@kernel.org>
In-Reply-To: <7aed94ce.2dca.1967b8257af.Coremail.slark_xiao@163.com>
To: Slark Xiao <slark_xiao@163.com>
X-Mailer: iPhone Mail (22D82)

Hi Slark,

you cab add udev rules to set the permissions.

Regards,
Zaihan
Sent from my iPhone

> On 28 Apr 2025, at 4:28=E2=80=AFPM, Slark Xiao <slark_xiao@163.com> wrote:=

>=20
> =EF=BB=BF
> At 2025-04-09 18:42:59, "Sergey Ryazanov" <ryazanov.s.a@gmail.com> wrote:
>>> On April 9, 2025 11:30:58 AM GMT+03:00, Slark Xiao <slark_xiao@163.com> w=
rote:
>>>=20
>>> Hi Sergey,
>>> Device port /dev/gnss0 is enumerated . Does it be expected?
>>> I can get the NMEA data from this port by cat or minicom command.
>>> But the gpsd.service also can not be initialized normally. It reports:
>>>=20
>>> TriggeredBy: =E2=97=8F gpsd.socket
>>>   Process: 3824 ExecStartPre=3D/bin/stty speed 115200 -F $DEVICES (code=3D=
exited, status=3D1/FAILURE)
>>>       CPU: 7ms
>>>=20
>>> 4=E6=9C=88 09 16:04:16 jbd systemd[1]: Starting GPS (Global Positioning S=
ystem) Daemon...
>>> 4=E6=9C=88 09 16:04:17 jbd stty[3824]: /bin/stty: /dev/gnss0: Inappropri=
ate ioctl for device
>>> 4=E6=9C=88 09 16:04:17 jbd systemd[1]: gpsd.service: Control process exi=
ted, code=3Dexited, status=3D1/FAILURE
>>> 4=E6=9C=88 09 16:04:17 jbd systemd[1]: gpsd.service: Failed with result '=
exit-code'.
>>> 4=E6=9C=88 09 16:04:17 jbd systemd[1]: Failed to start GPS (Global Posit=
ioning System) Daemon.
>>>=20
>>> Seems it's not a serial port.
>>=20
>> It is a char dev lacking some IOCTLs support. Yeah.
>>=20
>>> Any advice?
>>=20
>> Yep. Remove that stty invocation from the service definition. For me, gps=
d works flawlessly. You can try to start it manually from a terminal.
>>=20
>> --
>> Sergey
> Hi Sergey,
> My device could output the NMEA data by port /dev/gnss0. Something like be=
low:
>=20
> $GPRMC,071634.00,A,2239.372067,N,11402.653048,E,,,280425,,,A,V*2D
> $GARMC,071634.00,A,2239.372067,N,11402.653048,E,,,280425,,,A,V*3C
> $GBRMC,071634.00,A,2239.372067,N,11402.653048,E,,,280425,,,A,V*3F
> $GNRMC,071634.00,A,2239.372067,N,11402.653048,E,,,280425,,,A,V*33
> $GNGNS,071634.00,2239.372067,N,11402.653048,E,NAANNN,02,500.0,,,,,V*15
> $GPGGA,071634.00,2239.372067,N,11402.653048,E,1,00,500.0,,,,,,*59
> $GAGGA,071634.00,2239.372067,N,11402.653048,E,1,01,500.0,,,,,,*49
> $GBGGA,071634.00,2239.372067,N,11402.653048,E,1,00,500.0,,,,,,*4B
> $GNGGA,071634.00,2239.372067,N,11402.653048,E,1,02,500.0,,,,,,*45
> $GPGSV,4,1,13,04,00,038,,05,33,240,,06,41,033,,09,25,058,,1*6F
> $GPGSV,4,2,13,11,47,344,,12,33,286,,13,09,185,,17,29,128,,1*6E
> $GPGSV,4,3,13,19,54,113,,20,62,284,,22,15,174,,25,09,311,,1*68
> $GPGSV,4,4,13,40,00,000,28,1*58
> $GLGSV,3,1,09,10,19,245,,06,38,185,,09,06,203,,11,13,296,,1*79
> $GLGSV,3,2,09,05,60,064,,20,39,013,,19,17,084,,21,15,321,,1*7E
> $GLGSV,3,3,09,04,16,030,,1*41
> $GAGSV,3,1,11,02,30,297,,04,32,076,,05,10,188,,06,41,107,,7*78
> $GAGSV,3,2,11,09,39,140,,10,26,055,,11,42,027,,12,09,071,,7*7E
> $GAGSV,3,3,11,16,36,198,,24,19,176,,36,39,317,,7*45
> $GBGSV,4,1,15,01,47,122,,02,46,234,,03,63,189,,04,34,108,,1*7D
> $GBGSV,4,2,15,05,23,253,,06,04,187,,07,86,194,,08,68,284,,1*75
> $GBGSV,4,3,15,09,03,201,,10,78,299,,11,56,025,,12,29,094,,1*71
>=20
> But the gpsd progress were stuck with below errors:
> =E2=97=8F gpsd.service - GPS (Global Positioning System) Daemon
>     Loaded: loaded (/lib/systemd/system/gpsd.service; enabled; vendor pres=
et: enabled)
>     Active: active (running) since Mon 2025-04-28 23:16:47 CST; 20s ago
> TriggeredBy: =E2=97=8F gpsd.socket
>    Process: 5281 ExecStart=3D/usr/sbin/gpsd $GPSD_OPTIONS $OPTIONS $DEVICE=
S (code=3Dexited, status=3D0/SUCCESS)
>   Main PID: 5283 (gpsd)
>      Tasks: 1 (limit: 37272)
>     Memory: 652.0K
>        CPU: 10ms
>     CGroup: /system.slice/gpsd.service
>             =E2=94=94=E2=94=805283 /usr/sbin/gpsd -F /var/run/gpsd.sock /d=
ev/gnss0
>=20
> 4=E6=9C=88 28 23:16:47 jbd systemd[1]: Starting GPS (Global Positioning Sy=
stem) Daemon...
> 4=E6=9C=88 28 23:16:47 jbd systemd[1]: Started GPS (Global Positioning Sys=
tem) Daemon.
> 4=E6=9C=88 28 23:17:02 jbd gpsd[5283]: gpsd:ERROR: SER: device open of /de=
v/gnss0 failed: Permission denied - retrying read-only
> 4=E6=9C=88 28 23:17:02 jbd gpsd[5283]: gpsd:ERROR: SER: read-only device o=
pen of /dev/gnss0 failed: Permission denied
> 4=E6=9C=88 28 23:17:02 jbd gpsd[5283]: gpsd:ERROR: /dev/gnss0: device acti=
vation failed, freeing device.
>=20
> And I checked the gnss device attribute, it reports:
> crw------- 1 root root 237, 0  4=E6=9C=88 28  2025 /dev/gnss0
>=20
> May I know how do you fix this?
>=20
> Thanks
>=20
>=20

