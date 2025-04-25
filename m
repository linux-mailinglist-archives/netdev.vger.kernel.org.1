Return-Path: <netdev+bounces-185983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C368A9C8FE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 14:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8B99A1B93
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11112248878;
	Fri, 25 Apr 2025 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b="n8NIp3Rt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6C242D60
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745584429; cv=none; b=qBAloD3b7NiWGJ1lGX8RTS+IrRqMUZi/zhtd/V73n16uLHC8cTq16lhb2ePpgvPd+DQo+lHLSTt6uQaiKGWU7IDS3HyM8CB12fCE2P2Jz86f+hTsMMAGn1b5WVnBO+x0ZTfKW4M7oeXWrz48K6Ueq4/sCrI1geFMkbHtypAM7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745584429; c=relaxed/simple;
	bh=tQiTl86FEuO5UgYuomByyvi5w9Hmntw7EaR1CWYauKg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=YD8CMzKD/CZr6ZgTyDfY3x5oh5g6hCMF1NxwnwbvY8YPtdrCNF/pEZwfwc9NFoTa/kaEik0e1vcsoJquJC7RKxec98zUN9Gn1o3Og+YBCqvumm6aA68tm3iEjLoWGDKiq4QNIyyhw6GxfjGJKWM4XQBdX8sKss7xNQ/jYRKhvPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai; spf=none smtp.mailfrom=avride.ai; dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b=n8NIp3Rt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=avride.ai
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c30d9085aso1608899f8f.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=avride-ai.20230601.gappssmtp.com; s=20230601; t=1745584425; x=1746189225; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yntU4EniIC3f4h3SJqk8e0Y5d89MUpTfrJEc3h0DwPg=;
        b=n8NIp3RtaxRSPhznbjqt3okMg5XBZYxPOPDthnGlHDUgb6WHvQhdPL1U4fNGcfwIxM
         ZFC8r1F3Dqi5xuh1fTjWg5mH5MtBBPNjlSNy5Eyf+v22636urX8qSpu5inyhHRYCei4G
         aW4uu7myOaZD5cPjmeq5UNkvTnRooUpS01suyscA3CShtcf1FgXwQMl4H+/CZX0/Z6i7
         UfyyWCMwKpc2JMUGDwi5j5Bj1XwaO9ysWj/zP1NgAGSqzK7J+oOAegG1RJwspJSqlOHT
         M1pYkdBUufp5WQZrn6qda7C+Sge8awSWpoc1ox10lXub0gUKGyCGWXtFXahqMPc+bJIZ
         1JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745584425; x=1746189225;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yntU4EniIC3f4h3SJqk8e0Y5d89MUpTfrJEc3h0DwPg=;
        b=j6AzhqlMWvV+ulr6Sq58tchojZyOiXJRCBzbbas9rupfV6AcyN6TK6dNcaMnpo9Kxg
         6I2whbQNpX795a2qQh6rQD59YAqU7+6KLFnwPYGuilACoO9MPV/ziyOt6StQ/5Y17ovg
         VXwyUdt7yFcGsTjj3vdJ/tUQtYDyTl6UArDaWC1L3AA1A30mPHKwFgV9p7lpXyljFCcb
         QHhWiT05ZetVAB+i0ehfZziDMN2iZVQjkhmYB2pbvd+wX+mAo0WhgDLc16/kQ4BJKRDK
         B1j7z88ZLW1g4kgqKGj9Quk2I//I1JNMKYXHI56TiaCKy8M1yce8mmHjJgcXiQvg8+8/
         DczQ==
X-Gm-Message-State: AOJu0YxhB0xrJ06go0h9+wucPJGvJs8mfyP5J/qLnYBzOG0vQ1kfj5Gm
	lefM71aP5jFjlzNFji0DhzDlh55qBe7UIQxWSh7sDMlGXQj3gnbLfJ6Qba2ZJfo3912mZO2R84Y
	9GiM=
X-Gm-Gg: ASbGncsopIPBknNc0bNwu3QynCXlOTN60qNMg5NvgA1tt5oyzKq+7xmWLdns+bFjqyy
	uqkuLOPTp98Qe8Xo4xWvTGy5wBi0H7CYd7eQ0+XWgyAEzudLVvb0ziqykAwrNblP3EmUhsa/Q5V
	t3S4dp0QfgGnhqAzcNlLiZN0jWTwrIdxIAut9JSrgc+oK84w4GHYyBplZKeipMKdNoGa/wb2EB7
	SPyXB39NCcFGzRQBT8xp0P3jWUgxuonkJCV72X2D0AUwk5CAqHHc/A5N5SJ9LU+HNJws26m26Tz
	Go1p1J3S645e0mQueiriTHxuGEHCMtAgR6OUiICELDIA5Q0bvYiRW10RB5fEsCGz0wZZrA==
X-Google-Smtp-Source: AGHT+IE8ax6S19eZtBWnOqc/2avNz/0bVbmMzwBWPw2GA5x/PwSj+C2zecdCnOz8WETDsB+ttPzEPg==
X-Received: by 2002:a5d:59ae:0:b0:39a:ca05:5232 with SMTP id ffacd0b85a97d-3a074e0ef10mr1729900f8f.5.1745584424611;
        Fri, 25 Apr 2025 05:33:44 -0700 (PDT)
Received: from smtpclient.apple ([2a02:14a:105:a03:f827:4b18:cd52:f8b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5e345sm2244398f8f.94.2025.04.25.05.33.43
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2025 05:33:44 -0700 (PDT)
From: Kamil Zaripov <zaripov-kamil@avride.ai>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: bnxt_en: Invalid data read from SFP EEPROM
Message-Id: <ED8A7112-D31F-4C4F-94AB-0F0D0DD5DDE6@avride.ai>
Date: Fri, 25 Apr 2025 15:33:33 +0300
To: Linux Netdev List <netdev@vger.kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

Hi all,

I=E2=80=99m seeing corrupted EEPROM data when reading an Intel =
E10GSFPSRX SFP module plugged into a Broadcom BCM57502 NIC (bnxt_en =
driver). The same module gives correct EEPROM content when connected to =
Intel E810 (ice driver) or connected directly to the CPU through I2C =
controller. So probably the issue is specific to BCM57502 + bnxt_en + =
firmware combination.

Output below shows corrupted dump vs correct dump:

# BCM57502 + bnxt_en (corrupted)
$ sudo ethtool -m enP2s1f1np1 hex on
Offset		Values
------		------
0x0000:		03 00 f3 00 58 00 f8 00 90 88 71 48 8c a0 75 30
0x0010:		19 64 07 d0 18 6a 09 c4 27 10 09 d0 1f 07 0c 5a
0x0020:		27 10 00 64 1f 07 00 9e 00 00 00 00 00 00 00 00
0x0030:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0040:		00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00
0x0050:		01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 a3
0x0060:		1f 94 83 f9 0b d5 16 81 00 15 00 00 00 00 32 00
0x0070:		00 40 00 00 00 40 00 00 ff ff ff ff ff ff ff 01
0x0080:		5d 01 01 01 01 01 03 04 07 10 00 00 00 00 00 00
0x0090:		00 06 67 00 00 00 08 03 00 1e 46 49 4e 49 53 41
0x00a0:		52 20 43 4f 52 50 2e 20 20 20 00 00 90 65 46 54
0x00b0:		4c 58 38 35 37 31 44 33 42 43 4c 20 20 20 41 20
0x00c0:		00 20 03 52 00 48 00 1a 00 00 41 50 4b 31 45 48
0x00d0:		30 20 20 20 20 20 20 20 20 20 31 33 30 35 31 34
0x00e0:		20 20 68 f0 03 cd 00 00 00 00 00 00 00 00 00 00
0x00f0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

# E810 + ice (correct)
$ sudo ethtool -m ens102f0np0 hex on
Offset		Values
------		------
0x0000:		03 04 07 10 00 00 00 00 00 00 00 06 67 00 00 00
0x0010:		08 03 00 1e 49 6e 74 65 6c 20 43 6f 72 70 20 20
0x0020:		20 20 20 20 00 00 1b 21 46 54 4c 58 38 35 37 34
0x0030:		44 33 42 4e 4c 2d 49 54 41 20 20 20 03 52 00 89
0x0040:		00 1a 00 00 41 34 31 41 53 59 4b 20 20 20 20 20
0x0050:		20 20 20 20 32 30 30 37 30 36 20 20 68 f0 05 e4
0x0060:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0070:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0080:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0090:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00a0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00b0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00c0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00d0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00e0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00f0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0100:		5d 00 f3 00 58 00 f8 00 90 88 71 48 8c a0 75 30
0x0110:		19 64 07 d0 18 6a 09 c4 27 10 09 d0 1f 07 0c 5a
0x0120:		27 10 00 64 1f 07 00 9e 00 00 00 00 00 00 00 00
0x0130:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0140:		00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00
0x0150:		01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 a3
0x0160:		23 56 85 e0 10 f8 16 94 00 15 00 00 00 00 32 00
0x0170:		00 40 00 00 00 40 01 00 ff ff ff ff ff ff ff 01
0x0180:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0190:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01a0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01b0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01c0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01d0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01e0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01f0:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Problems with the BCM57502 + bnxt_en output:
- Bytes 0x14-0x23 should contain [49 6e 74 65 6c 20 43 6f 72 70 20 20 20 =
20 20 20] (ASCII string =E2=80=9CIntel Corp       =E2=80=9C), but =
instead contains [18 6a 09 c4 27 10 09 d0 1f 07 0c 5a 27 10 00 64] which =
is not valid ASCII string.
- Diagnostic part (0x0100-x01f0) is missing, probably because 0x5c byte =
in first part is 0x00.
- Bytes 0x001-0x05f in BCM57502 + bnxt_en output is the same as bytes =
0x101-0x15f from Intel E810 + ice output.
- Other bytes look like garbage, but this garbage persists between =
request, different SFP modules and different ports where modules =
inserted.

Given all that facts probably there is an issue between bnxt_en driver =
and BCM57502 firmware in I2C commands propagation interface.

Is there someone who can help me to find out where is the issue? The =
only bug that I find in code is that bnxt_read_sfp_module_eeprom_info do =
not fill bank_number field of the struct hwrm_port_phy_i2c_read_input, =
but it is not relevant for my case.

Kamil.




