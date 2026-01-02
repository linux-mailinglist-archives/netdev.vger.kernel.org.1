Return-Path: <netdev+bounces-246614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37FCEF3E2
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 20:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61DF83008FB4
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 19:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF98A2222C5;
	Fri,  2 Jan 2026 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="CXIeZykw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265342B9A4
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767383175; cv=none; b=Xxhb4SjrXDonwDW7Chciu5V0vCmPdHFVEYCLmTA1rAEFax+RpZqotU2p9y8wzc4/L1dtQbMKDCfdHXgcRDuQOnOSvkeyj5/FRTkPvya1tFYcjoQYyJ4sV6/Qrjmhr4hPmNShjT/nHhY3XSf68/0ssn2d5vU4EUT2QX1zcwUaQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767383175; c=relaxed/simple;
	bh=tUPvNq+brCEvqEkPtoGEbl9blft3DoNf7XrRYtoJTLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mjOCoJ/oBQuGhuMHfRKM2iyiM9OQLP4iPXZIYD/2LY3AtxAjI1jYrk/zPG7Y7fvNecPpSU6W2a3gNHt1fVAR+xn0Y7PEyJDLCCPci/4duXyWZ6YRCl3dPGEB8cj5USmrWZ8lRsil8v3AiQiFqYhBA3TPqY1CupSgD23w7ArzNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=CXIeZykw; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64fabaf9133so1245029a12.3
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 11:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767383171; x=1767987971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdR43gW7NhBkLmU102umHMGoizgWyMa2gK+zGPoFsFY=;
        b=CXIeZykwBWyWBZQ7GOBzQEleVYY6F40aH1m5wm7qy6O+iGCowVkawGONdHtTiCLRfb
         NF9QGnRHjTgJiDIQ4No4XDbs8bLAgnoydJNjiaUCJLycVuB8pkAjJcTyLu/K6igdn8si
         rrUVkwnUYEfTJT+/qb7qPsRs2Qc76Cepc0Z4nh3VPE8zlPt8LbCOw+tDWFMwz2xYM0qg
         JhvlfaU880MfqXTSK+co+6Qlaa3dSMwKwQFdoZQ5VYtVxDVrhrQm90DD9+lqXm02X96Q
         P4doTfJt7hadDSj2Brtbk6w3keN7o/OvQSfb8QgRm4wSt7eZwYgjC0fclOaEhWxl34c2
         rd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767383171; x=1767987971;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdR43gW7NhBkLmU102umHMGoizgWyMa2gK+zGPoFsFY=;
        b=po774q5Qk7hfCN6vnFdK7Rz5Ulu9KueiryAmpuREu7FycPZhpK2omCfovJhBJ6fHal
         bsR93LN+iVAhls3Fq0fhgw5exeURX0xv6iOO0hPETvDdUtuMgWqABQ0/xPlWGAbmb9rf
         KhigPFU0yMO59ujmpXhN1QBnduqxV6y/Ns0IE28OE3S1XBrdCPDeGZOfzFiykkmiJvLN
         OCvSO0ODIKaAQfPokwF/uCYXguuX8HEX6XfCoNwx/g5wiUFSF5OD1xRYzm83pbY3Wnx8
         GNQrEHSLA5OfW/Nho0/mF+sNbj5Q+b3MigJS+HvkhuZXigHjdoMoNSJaF70Jb5OMc8wh
         mMrw==
X-Gm-Message-State: AOJu0YxEdem6yQRTwIQJcSC5jjhG7lw22BzMl77Hwlnc2rxyoisySF14
	Sq6P70nfBd1ciEeaO7An1H5Vl4UhaNKA6ohvv0lHjozZxLMc46FH1Fg+Y6u9/o0d7ccPCVqW/GS
	f6k7gmiQ=
X-Gm-Gg: AY/fxX4wUwFTflxrcpyzeljCU7H/IvIJbQxgUnAeNGk+6qe0kzsN26O238PDtNXeob5
	meEqmSMwLnk2nNeZaoWAjUwRn1ghq/hvSZD2k6DapB77bxgSRNOUp1SW5B1eb789vB9BlkPFOL/
	QRIgnAfuuwF/ddFiVpOhq98juSAXXuWHZs8YWyPpoGsY8z30CztEKPLFqjPA/qcw8CtNgCMErCS
	K3ECLyIqdA+OlFRdUYGv7gEmgNAa9b0+O4iq/uzh1IISyXywPWd6NH/2X1LpA3iYLkTpOzfF9Uw
	W8+mVQbMjuhMbdj+KSyKWP/AFNlw97bEvA40CgqBvDi/rKp0jZYYtsC8fvUbAdYRvM1W4aak5n8
	S2QyboJPL3q2XKC4CsJQCKCJso1LpVY3cavSQsc2EQMXmsc7yYJDUuNxhCSVk6MGgSUy9PeU+x/
	gCj6DwsdNa4tuiByayWWrGSeY6nwpIqF5rc8rXdPV/cfTG28Q8Nf0/
X-Google-Smtp-Source: AGHT+IEIGVKFQGFBH16br5Wj0y1n2Qi8X8f5aeDr8D10UMTJmQfgVoisHpR7ZnbnUZLn7GUBIwY3Xg==
X-Received: by 2002:a17:907:7855:b0:b83:246c:c50f with SMTP id a640c23a62f3a-b83246cc9d7mr1819294366b.34.1767383171126;
        Fri, 02 Jan 2026 11:46:11 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ddffc7sm4661267666b.43.2026.01.02.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:46:10 -0800 (PST)
Date: Fri, 2 Jan 2026 11:46:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Fw: [Bug 220932] New: Possible bug (use after free) on DSA driver
 removal
Message-ID: <20260102114605.3351c6eb@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Begin forwarded message:

Date: Thu, 01 Jan 2026 22:56:38 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220932] New: Possible bug (use after free) on DSA driver remo=
val


https://bugzilla.kernel.org/show_bug.cgi?id=3D220932

            Bug ID: 220932
           Summary: Possible bug (use after free) on DSA driver removal
           Product: Networking
           Version: 2.5
          Hardware: Mips32
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: luizluca@gmail.com
        Regression: No

While testing a driver patch for OpenWrt (dev), I noticed that the system
sometimes crashes a little after I remove the module. I dropped all my patc=
hes
and bruteforce it:


echo 'file drivers/net/dsa/realtek/rtl8365mb.c +p' >
/sys/kernel/debug/dynamic_debug/control; echo 'file net/dsa/* +p' >
/sys/kernel/debug/dynamic_debug/control; rmmod rtl8365mb; echo 0 >
/proc/sys/kernel/panic; while true; do sleep 1; insmod /tmp/rtl8365mb.ko; s=
leep
10; rmmod rtl8365mb; done


After a couple of cycles, I got this (repeatable) crash below.
rtl8365mb_get_tag_protocol and rtl8365mb_port_stp_state_set messages are fr=
om a
small debug patch I added trying to trace the crash origin but it should not
matter.


[ =C2=A0469.884379] DSA: tree 0 torn down
[ =C2=A0471.094669] rtl8365mb-mdio mdio-bus:1d: found an RTL8367S switch
[ =C2=A0471.100980] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_get_tag_protocol
priv:126ea59d
[ =C2=A0471.349018] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set
priv:126ea59d
[ =C2=A0471.357364] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set
priv:126ea59d
[ =C2=A0471.365716] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set
priv:126ea59d
[ =C2=A0471.373964] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set
priv:126ea59d
[ =C2=A0471.382228] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set
priv:126ea59d
[ =C2=A0471.390503] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_stp_state_set
priv:126ea59d
[ =C2=A0471.398580] rtl8365mb-mdio mdio-bus:1d: rtl8365mb_port_change_mtu
priv:126ea59d
[ =C2=A0471.647590] mtk_soc_eth 10100000.ethernet eth0: port 5 link down
[ =C2=A0471.674092] CPU 0 Unable to handle kernel paging request at virtual=
 address
702e7660, epc =3D=3D 702e7660, ra =3D=3D 80001e90
[ =C2=A0471.685048] Oops[#1]:
[ =C2=A0471.687381] CPU: 0 UID: 0 PID: 7473 Comm: modprobe Tainted: G =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O =C2=A0=20
 =C2=A0 6.12.60 #0
[ =C2=A0471.695837] Tainted: [O]=3DOOT_MODULE
[ =C2=A0471.699401] Hardware name: TP-Link Archer C5 v4
[ =C2=A0471.704029] $ 0 =C2=A0 : 00000000 00000001 81c40560 80a63cdc
[ =C2=A0471.709403] $ 4 =C2=A0 : 00000cc0 00000001 0004c50b 82ab2f00
[ =C2=A0471.714771] $ 8 =C2=A0 : 0004c50c 00000cc0 00000000 77e89000
[ =C2=A0471.720139] $12 =C2=A0 : 00000003 82b8dc0c 00000001 77e8afff
[ =C2=A0471.725508] $16 =C2=A0 : 00001173 77e89000 7f958894 00400dc1
[ =C2=A0471.730877] $20 =C2=A0 : 8383fbf8 77e903d0 00000000 7f958730
[ =C2=A0471.736246] $24 =C2=A0 : 00000003 8084aba8
[ =C2=A0471.741613] $28 =C2=A0 : 81c1c000 81c1df28 00000000 80001e90
[ =C2=A0471.746982] Hi =C2=A0 =C2=A0: 00000000
[ =C2=A0471.749926] Lo =C2=A0 =C2=A0: 00000000
[ =C2=A0471.752868] epc =C2=A0 : 702e7660 0x702e7660
[ =C2=A0471.756798] ra =C2=A0 =C2=A0: 80001e90 work_notifysig+0x10/0x18
[ =C2=A0471.761975] Status: 1100b403 KERNEL EXL IE
[ =C2=A0471.766269] Cause : 50800008 (ExcCode 02)
[ =C2=A0471.770366] BadVA : 702e7660
[ =C2=A0471.773309] PrId =C2=A0: 00019650 (MIPS 24KEc)
[ =C2=A0471.777406] Modules linked in: rtl8365mb(+) rt2800soc(O) rt2800mmio=
(O)
rt2800lib(O) pppoe ppp_async nft_fib_inet nf_flow_table_inet rt2x00mmio(O)
rt2x00lib(O) pppox ppp_generic nft_reject_ipv6 nft_reject_ipv4 nft_reject_i=
net
nft_reject nft_redir nft_quot
a nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload
nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat
nf_flow_table nf_conntrack mt76x2e(O) mt76x2_common(O) mt76x02_lib(O) mt76(=
O)
mac80211(O) cfg80211(O) slhc nfne
tlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_=
ipv4
libcrc32c crc_ccitt compat(O) i2c_dev ledtrig_usbport sha512_generic seqiv
sha3_generic jitterentropy_rng drbg hmac geniv rng cmac leds_gpio tag_rtl8_4
realtek_dsa dsa_core gpio
_button_hotplug(O) realtek hwmon i2c_core phylink crc32c_generic [last
unloaded: rtl8365mb]
[ =C2=A0471.854523] Process modprobe (pid: 7473, threadinfo=3D674a8fb4, tas=
k=3Db017bdbf,
tls=3D77e98dfc)
[ =C2=A0471.862981] Stack : 00000000 00000000 00000000 00000000 77e97290 00=
420f38
77e97290 00420f10
[ =C2=A0471.871571] =C2=A0 =C2=A0 =C2=A0 =C2=A0 00000000 00000001 00000000 =
77e1f644 77e89000 00001173
00000000 00000000
[ =C2=A0471.880157] =C2=A0 =C2=A0 =C2=A0 =C2=A0 0000000c 83855940 77e85000 =
77e77000 81b911e5 00000001
81bbac60 77e85fff
[ =C2=A0471.888745] =C2=A0 =C2=A0 =C2=A0 =C2=A0 00001173 77e89000 7f958894 =
00400dc1 8383fbf8 77e903d0
00000000 7f958730
[ =C2=A0471.897333] =C2=A0 =C2=A0 =C2=A0 =C2=A0 81bbac60 77e556d0 00000001 =
00000000 77e97290 7f958450
00000000 77e1f674
[ =C2=A0471.905921] =C2=A0 =C2=A0 =C2=A0 =C2=A0 ... =C2=A0
[ =C2=A0471.908431] Call Trace: =C2=A0
[ =C2=A0471.908437]
[ =C2=A0471.912653]
[ =C2=A0471.914177] Code: (Bad address in epc)
[ =C2=A0471.914177]
[ =C2=A0471.919517]
[ =C2=A0471.921240] ---[ end trace 0000000000000000 ]---
[ =C2=A0471.926052] Kernel panic - not syncing: Fatal exception
[ =C2=A0471.931404] ---[ end Kernel panic - not syncing: Fatal exception ]-=
--


The RA value (80001e90 work_notifysig+0x10/0x18) indicates that the crash c=
ame
from a notification. Maybe DSA didn't unregister/drain notifications after =
the
tear down.

I'm using kernel 6.12.60 (LTS) and I also didn't notice any relevant changes
since that version. I'm just not sure if
2bcf4772e45adb00649a4e9cbff14b08a144f9e3 would be related.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

