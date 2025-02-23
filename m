Return-Path: <netdev+bounces-168821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B1DA40F0F
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 13:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF06177D70
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3C6205E3C;
	Sun, 23 Feb 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="I5jhzO/g"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339AB1C84CA
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740315464; cv=none; b=QHZPziKSjo/78qTTHebytaiXevfII0aFWeZwlkdhhcsYjCHJIkK31gTi5OgEEBpqH0Kv/D3bEeF5R20rA8DBUi2YJs+WPdKm6eJelxJVxyTqTIOAFBqxKx2YSYvmFCdAkE1fQKxFO8OuJJpoC9lrd3bogqeCQKpu534R8eEDbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740315464; c=relaxed/simple;
	bh=cWFg/4XQPu9TxO1eUTU1iCc6m+m2ksEYmo0e66R3q/Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=O0Qq5G2mISdLWAnKXgCA3oRm9wtxjVJQpLO5SPNT/iW0Rp6WnbRhY5BVxuLYkD2w8s5ZgA7pW4TWRHqZ/nR8vUAhthQDOXRoGl2mXWuY1ypUxAukd1jJW7GOk4Xdrtz+cnkmNeyEX0MtdDwn12dhmVzUu5gpZFlJDcMiOpmEr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=I5jhzO/g; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=I5jhzO/g;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10de:2e00:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 51NCvV1e917165
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 12:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1740315451; bh=+vmuiUGsBsvDd+Dn0ewmfcHBlvki4QH51CR1IUeHmRc=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=I5jhzO/gLLP6Gevm1/TEobTCJT4geup8RKFYyRISmml+kypjFP5uwPUuDHRzsy9jX
	 rcHf+r5IOHbwqCVkykGlXRbVLAzp3zfYSKEfZGBRTgiBijLwsDFXik8wEUkNcSjtWl
	 gBSaLcAR7Khw23EczU9lHS/wG0xQJdIiH9qwH7rI=
Received: from miraculix.mork.no ([IPv6:2a01:799:10de:2e0a:149a:2079:3a3a:3457])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 51NCvVGW2213768
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 13:57:31 +0100
Received: (nullmailer pid 934254 invoked by uid 1000);
	Sun, 23 Feb 2025 12:57:31 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: netdev@vger.kernel.org
Subject: Re: Phy access methods for copper SFP+ disguised as SR
Organization: m
References: <874j0kvqs3.fsf@miraculix.mork.no>
	<TYCPR01MB8437B8B1654ED6575F3019F498C12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Sun, 23 Feb 2025 13:57:30 +0100
In-Reply-To: <TYCPR01MB8437B8B1654ED6575F3019F498C12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
	(Shengyu Qu's message of "Sun, 23 Feb 2025 20:29:59 +0800")
Message-ID: <87zficu8cl.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.7 at canardo.mork.no
X-Virus-Status: Clean

Shengyu Qu <wiagn233@outlook.com> writes:

> Maybe rollball protocol?
> https://forum.banana-pi.org/t/sfp-oem-sfp-2-5g-t-kernel-phy/15872/

Thanks, but I already tried adding a sfp quirk enabling Rollball
access.  It does not work unfortunately.

Manually testing RollBall still reads the same static eeprom data on
page 3, register 0x80 etc, where we expect the RollBall registers:

 * 0x80     1     CMD       0x01/0x02/0x04 for write/read/done
 * 0x81     1     DEV       Clause 45 device
 * 0x82     2     REG       Clause 45 register
 * 0x84     2     VAL       Register value

Page 0:

root@s508cl:~# i2cdump -y 8 0x51
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 50 00 f6 00 4b 00 fb 00 8c 9f 71 48 88 b8 75 30    P.?.K.?.??qH??u0
10: 1d 4c 01 f4 19 64 03 e8 2b d4 07 46 27 10 09 28    ?L???d??+??F'??(
20: 2b d4 02 85 27 10 03 2c 00 00 00 00 00 00 00 00    +???'??,........
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00    ....??......?...
50: 01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 7e    ?...?...?......~
60: 45 49 7f 78 0b b8 13 92 13 92 00 00 00 00 00 00    EI?x??????......
70: 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00    ..........@.....
80: 43 4f 55 49 41 38 4e 43 41 41 31 30 2d 32 34 31    COUIA8NCAA10-241
90: 35 2d 30 33 56 30 33 20 01 00 46 00 00 00 00 c6    5-03V03 ?.F....?
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa aa    ..............??
c0: 53 46 50 2d 31 30 47 2d 53 52 20 20 20 20 20 20    SFP-10G-SR=20=20=20=
=20=20=20
d0: 20 20 20 20 33 32 00 00 00 00 00 00 00 00 00 35        32.........5
e0: 1e 28 2e 2e 31 34 29 36 00 00 00 00 00 00 00 00    ?(..14)6........
f0: 00 00 00 00 00 66 00 00 ff ff ff ff ff ff 29 e3    .....f........)?


Set password:

root@s508cl:~# i2cset -y 8 0x51 0x7b 0xff
root@s508cl:~# i2cset -y 8 0x51 0x7c 0xff
root@s508cl:~# i2cset -y 8 0x51 0x7d 0xff
root@s508cl:~# i2cset -y 8 0x51 0x7e 0xff

Read page 3:

root@s508cl:~# i2cset -y 8 0x51 0x7f 3
root@s508cl:~# i2cdump -y 8 0x51
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 50 00 f6 00 4b 00 fb 00 8c 9f 71 48 88 b8 75 30    P.?.K.?.??qH??u0
10: 1d 4c 01 f4 19 64 03 e8 2b d4 07 46 27 10 09 28    ?L???d??+??F'??(
20: 2b d4 02 85 27 10 03 2c 00 00 00 00 00 00 00 00    +???'??,........
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00    ....??......?...
50: 01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 7e    ?...?...?......~
60: 45 49 80 62 0b b8 13 92 13 92 00 00 00 00 00 00    EI?b??????......
70: 00 00 00 00 00 00 00 00 00 00 40 ff ff ff ff 03    ..........@....?
80: 43 4f 55 49 41 38 4e 43 41 41 31 30 2d 32 34 31    COUIA8NCAA10-241
90: 35 2d 30 33 56 30 33 20 01 00 46 00 00 00 00 c6    5-03V03 ?.F....?
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa aa    ..............??
c0: 53 46 50 2d 31 30 47 2d 53 52 20 20 20 20 20 20    SFP-10G-SR=20=20=20=
=20=20=20
d0: 20 20 20 20 33 32 00 00 00 00 00 00 00 00 00 35        32.........5
e0: 1e 28 2e 2e 31 34 29 36 00 00 00 00 00 00 00 00    ?(..14)6........
f0: 00 00 00 00 00 66 00 00 ff ff ff ff ff ff 29 e3    .....f........)?



I have another cheap 10GBase-T SFP+ which *is* talking RollBall. I do
not have problems accessing the phy on this.  Including it just for
comparison with the above. Page 0 looks similar:

root@s508cl:~# i2cdump -y 5 0x51
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 50 00 f6 00 4b 00 fb 00 8c a0 75 30 88 b8 79 18    P.?.K.?.??u0??y?
10: 1d 4c 01 f4 19 64 03 e8 4d f0 06 30 3d e8 06 f2    ?L???d??M??0=3D???
20: 2b d4 00 c7 27 10 00 df 00 00 00 00 00 00 00 00    +?.?'?.?........
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00    ....??......?...
50: 01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 23    ?...?...?......#
60: 23 f7 82 6f 00 00 00 00 00 00 00 00 00 00 82 00    #??o..........?.
70: 05 40 00 00 05 40 00 00 00 00 00 ff ff ff ff 00    ?@..?@..........
80: 43 4f 55 49 41 38 4e 43 41 41 31 30 2d 32 34 31    COUIA8NCAA10-241
90: 35 2d 30 33 56 30 33 20 01 00 46 00 00 00 00 c6    5-03V03 ?.F....?
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa aa    ..............??
c0: 53 46 50 2d 31 30 47 2d 53 52 20 20 20 20 20 20    SFP-10G-SR=20=20=20=
=20=20=20
d0: 20 20 20 20 32 36 20 20 20 20 20 20 20 20 20 58        26         X
e0: 1e 28 2e 2e 31 34 29 36 00 00 00 00 00 00 00 00    ?(..14)6........
f0: 00 00 00 00 00 66 00 00 ff ff ff ff 00 00 00 00    .....f..........


But switching to page 3 we see the RollBall registers on 0x80 etc:

root@s508cl:~# i2cset -y 5 0x51 0x7f 3
root@s508cl:~# i2cdump -y 5 0x51
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 50 00 f6 00 4b 00 fb 00 8c a0 75 30 88 b8 79 18    P.?.K.?.??u0??y?
10: 1d 4c 01 f4 19 64 03 e8 4d f0 06 30 3d e8 06 f2    ?L???d??M??0=3D???
20: 2b d4 00 c7 27 10 00 df 00 00 00 00 00 00 00 00    +?.?'?.?........
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00    ....??......?...
50: 01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 23    ?...?...?......#
60: 28 22 82 58 00 00 00 00 00 00 00 00 00 00 82 00    ("?X..........?.
70: 05 40 00 00 05 40 00 00 00 00 00 ff ff ff ff 03    ?@..?@.........?
80: 04 1e c8 31 00 00 ff ff ff ff ff ff ff ff ff ff    ???1............
90: ff ff 00 00 ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff 04 00 f0 02 0a ab    ..........?.????




Bj=C3=B8rn

