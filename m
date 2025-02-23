Return-Path: <netdev+bounces-168815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D201EA40E80
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 12:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2520177839
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 11:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23BE20551A;
	Sun, 23 Feb 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="h45+iB0H"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162F1FC7DA
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740311353; cv=none; b=DJGVkQdeX6RtCWI67DddZTFR5IitUUoqLI9HLLD3JP7KVpRC35HF3MT3h2IYUoLQUQ+IoyyzjUH/z3YkLqNY5A4SaVavtsBDz/xDPMvkE3MwGPXnJa9ie1tx45i8D/LUlLzgBNAYhNA/y4FBvOtnteDmaC7AwN3UL8Frxwnms28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740311353; c=relaxed/simple;
	bh=12/3eubhDFm4sLNlZh3gp0omW2qRBKiQ+TpFOHKn8i8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A2RUREye0ceNCDkwGGIMs9uggWvnwYEsBm3VEMeot1lnnQ2hDaMvggjH/5dmaGqlKcwYuhcmOw9SoWK7gYplFRaCt+97k0JJIJ+Xsyw3Q5TDVPUA19UwIwknylK4PLown17MV0uc7deJNdCLEDZhq11neTzonnIW/X8IJEWl5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=h45+iB0H; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=h45+iB0H;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10de:2e00:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 51NBY5n1913617
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 11:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1740310444; bh=yG+72XPi+ZhAmV+0LiZ7iiClG9t9cXwxWcaWLrxHyGA=;
	h=From:To:Subject:Date:Message-ID:From;
	b=h45+iB0HCIIqoHNnGOzGNWZV4GqlxjWDCD8oK5p0J1ZE/AOGYq7v10xix07DkXYbC
	 PbZV/hTJ5jLTHueRA0Ld/gvKQPSMBZkhltCjhu0NVRllatSZPPpLItud3YmgiagKZy
	 eLdduhQ16s48JuFAx//fagJEgy2JWVCxiOu9nimQ=
Received: from miraculix.mork.no ([IPv6:2a01:799:10de:2e0a:149a:2079:3a3a:3457])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 51NBY45v2201663
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 12:34:04 +0100
Received: (nullmailer pid 927749 invoked by uid 1000);
	Sun, 23 Feb 2025 11:34:04 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: netdev@vger.kernel.org
Subject: Phy access methods for copper SFP+ disguised as SR
Organization: m
Date: Sun, 23 Feb 2025 12:34:04 +0100
Message-ID: <874j0kvqs3.fsf@miraculix.mork.no>
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

Got myself a couple of cheap 10GBase-T SFP+s and am struggling to figure
out how to talk to the phy.  The phy does not appear to be directly
accessible on 0x56, and it does not respond using the Rollball protocol
either.

Are there any other well known methods out there, or am I stuck with
whatever SR emulation the SFP vendor implemented?

This is all it shows, and 0x56 just reads zeroes no matter what I do:

root@s508cl:~# i2cdetect -y 8
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --=20
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
50: 50 51 -- -- -- -- 56 -- -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
70: -- -- -- -- -- -- -- --=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
root@s508cl:~# i2cdump -y 8 0x50
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 03 04 07 10 00 00 00 00 00 00 00 06 67 00 00 00    ????.......?g...
10: 08 02 00 1e 4f 45 4d 20 20 20 20 20 20 20 20 20    ??.?OEM=20=20=20=20=
=20=20=20=20=20
20: 20 20 20 20 00 00 00 00 53 46 50 2d 31 30 47 2d        ....SFP-10G-
30: 54 38 20 20 20 20 20 20 41 20 20 20 00 00 00 0c    T8      A   ...?
40: 00 1a 00 00 46 32 35 30 31 31 34 54 30 30 31 30    .?..F250114T0010
50: 20 20 20 20 32 35 30 31 31 35 20 20 68 f0 03 eb        250115  h???
60: 00 00 11 6b e0 e7 c2 e1 ff ff 18 79 21 c8 24 ed    ..?k????..?y!?$?
70: d8 45 85 00 00 00 00 00 00 00 00 00 1c 24 98 22    ?E?.........?$?"
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
root@s508cl:~# i2cdump -y 8 0x51
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 50 00 f6 00 4b 00 fb 00 8c 9f 71 48 88 b8 75 30    P.?.K.?.??qH??u0
10: 1d 4c 01 f4 19 64 03 e8 2b d4 07 46 27 10 09 28    ?L???d??+??F'??(
20: 2b d4 02 85 27 10 03 2c 00 00 00 00 00 00 00 00    +???'??,........
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00    ....??......?...
50: 01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 7e    ?...?...?......~
60: 42 33 7f ca 0b b8 13 92 13 92 00 00 00 00 00 00    B3????????......
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
root@s508cl:~# i2cdump -y 8 0x56
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................


Bj=C3=B8rn

