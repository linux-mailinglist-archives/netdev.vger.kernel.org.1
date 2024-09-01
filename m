Return-Path: <netdev+bounces-124005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC7C967552
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 08:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FB328299E
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 06:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35151381DF;
	Sun,  1 Sep 2024 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="LsUi6FfC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7239879
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725172447; cv=none; b=aSGFH0pmCxKpOeKHle/GGBwiP27AKDOdnQpKi7hTziYUBr35B1y1prai8YnwJATYvB0ByA3+XPflQW1f+FV0Z7ze5dyTunzJf4VXApC6ZGvn7vjwRfLQfNXfBtyLcNpQ/k/izI8CsiKbNhYTZrNlmq9pitzFZXODU2sAZmUmsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725172447; c=relaxed/simple;
	bh=5l9c9nUT9miF+p/k8RzXg23g4Vp4Ohb4st+XtAcJS+s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=PTdLb9fIbs1o/g/pRWphTq9aQQathy+fVSbYm0WImEoIoFSLT3TuCKB0Kg7ddy/gI3JK09Hjofzl1DgGi6ZgIffqZCvU5YlomP0t93yaWGmLVNZGIHil4LLgkNahwk7/Yc4Qw70o9vcEj3Xt/WzdHwsNrbgT69A4J6v1iMYxw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=LsUi6FfC; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 4816S5ZJ001506
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 1 Sep 2024 08:28:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1725172090; bh=vuUeHsMgLWaa8b3qXWK86Lho3AknKtX+veiyrc+wmCQ=;
	h=Date:From:Subject:To:Cc;
	b=LsUi6FfCUTpfTtZCMUPiwsnKms2kMwFcMm/KzPi6zgVNgOXD87eU4cgtQ6vjIHmuv
	 Cf+KuAH5WEcSqXR4eedUsMybWsPBQZLaOp8HWdUWtuSnBms8ll2vnXsdwWftyMWEAA
	 WdT4fZ0mM24mjDv4IMgxF9B8bu2RMS5+74qOw2Bw=
Message-ID: <a7904c43-01c7-4f9c-a1f9-e0a7ce2db532@ans.pl>
Date: Sat, 31 Aug 2024 23:28:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Subject: [mlx4] Mellanox ConnectX2 (MHQH29C aka 26428) and module diagnostic
 support (ethtool -m) issues
To: Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I noticed that module diagnostic on Mellanox ConnectX2 NIC (MHQH29Caka 26428 aka 15b3:673c, FW version 2.10.0720) behaves in somehow strange ways.

1. For SFP modules the driver is able to read the first page but not the 2nd one:

[  318.082923] mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(1) i2c_addr(51) offset(0) size(48): Response Mad Status(71c) - invalid I2C slave address
[  318.082936] mlx4_en: eth1: mlx4_get_module_info i(0) offset(256) bytes_to_read(128) - FAILED (0xfffff8e4)

However, as the driver intentionally tries mask the problem [1], ethtool reports "Optical diagnostics support" being available and shows completely wrong information [2].

Removing the workaround allows ethtool to recognize the problem and handle everything correctly [3]:
---- cut here ----
--- a/drivers/net/ethernet/mellanox/mlx4/port.c	2024-07-27 02:34:11.000000000 -0700
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c	2024-08-31 21:57:11.211612505 -0700
@@ -2197,14 +2197,7 @@
 			  0xFF60, port, i2c_addr, offset, size,
 			  ret, cable_info_mad_err_str(ret));
 
-		if (i2c_addr == I2C_ADDR_HIGH &&
-		    MAD_STATUS_2_CABLE_ERR(ret) == CABLE_INF_I2C_ADDR)
-			/* Some SFP cables do not support i2c slave
-			 * address 0x51 (high page), abort silently.
-			 */
-			ret = 0;
-		else
-			ret = -ret;
+		ret = -ret;
 		goto out;
 	}
 	cable_info = (struct mlx4_cable_info *)outm
---- cut here ----

However, we end up with a strange "netlink error: Unknown error 1820" error because mlx4_get_module_info returns -0x71c (0x71c is 1820 in decimal).

This can be fixed with returning -EIO instead of ret, either in mlx4_get_module_info() or perhaps better mlx4_en_get_module_eeprom() from en_ethtool.c:
---- cut here ----
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c	2024-07-27 02:34:11.000000000 -0700
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c	2024-08-31 21:52:50.370553218 -0700
@@ -2110,7 +2110,7 @@
 			en_err(priv,
 			       "mlx4_get_module_info i(%d) offset(%d) bytes_to_read(%d) - FAILED (0x%x)\n",
 			       i, offset, ee->len - i, ret);
-			return ret;
+			return -EIO;
 		}
 
 		i += ret;
---- cut here ----

BTW: it is also possible to augment the error reporting in ethtool/sfpid.c:
---- cut here ----
-       if (ret)
+       if (ret) {
+               fprintf(stderr, "Failed to read Page A2h.\n");
                goto out;
+       }
---- cut here ----
With all the above changes, we now get:

---- cut here ----
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
(...)
        Date code                                 : <REDACTED>
netlink error: Input/output error
Failed to read Page A2h.
---- cut here ----

So, the first question is if above set of fixes makes sense, give that ethtool handles this correctly? If so, I'm happy to send the fixes.

The second question is if not being able to read Page A2h and "invalid I2C slave address" is a due to a bug in the driver or a HW (firmware?) limitation and if something can be done to address this?

2. For a QSFP module (which works in CX3/CX3Pro), handling "ethtool -m" seems to be completely broken.

With QSFP module in port #2 (eth2), for the first attempt (ethtool -m eth2):
mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(50) offset(0) size(48): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
mlx4_en: eth2: mlx4_get_module_info i(0) offset(0) bytes_to_read(128) - FAILED (0xfffffbe4)

However, if I first try run "ethtool -m eth1" with a SFP module installed in port #1, and then immediately "ethtool -m eth2", I end up getting the information for the SFP module:
# ethtool -m eth2
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
(...)

I this case, I even get the same "invalid I2C slave address" error:
mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(51) offset(0) size(48): Response Mad Status(71c) - invalid I2C slave address

If I immediately run "ethtool -m eth1" I get:
mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(1) i2c_addr(50) offset(224) size(32): Response Mad Status(61c) - invalid device_address or size (that is, size equals 0 or address+size is greater than 256)
mlx4_en: eth1: mlx4_get_module_info i(96) offset(224) bytes_to_read(32) - FAILED (0xfffff9e4)

Alternatively, if I remove SFP module from port #1 and run "ethtool -m eth2", I get:
[ 1071.945737] mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(31c) - cable is not connected

At this point, running "ethtool -m eth1" produces one of:

*)
 mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)

*)
 mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(50) offset(128) size(48): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
 mlx4_en: eth2: mlx4_get_module_info i(0) offset(128) bytes_to_read(128) - FAILED (0xfffffbe4)

*)
 mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)

*)
 mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(50) offset(0) size(48): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
 mlx4_en: eth2: mlx4_get_module_info i(0) offset(0) bytes_to_read(128) - FAILED (0xfffffbe4)

*)
 mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)

I wonder if in this situation we are communicating with a wrong device or returning some stale data from kernel memory or the firmware?

Thanks,
 Krzysztof

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx4/port.c#n2200


[2]
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
(...) 
        Optical diagnostics support               : Yes
        Laser bias current                        : 0.000 mA
        Laser output power                        : 0.0000 mW / -inf dBm
        Receiver signal average optical power     : 0.0000 mW / -inf dBm
        Module temperature                        : 0.00 degrees C / 32.00 degrees F
        Module voltage                            : 0.0000 V
        Alarm/warning flags implemented           : Yes
        Laser bias current high alarm             : Off
        Laser bias current low alarm              : Off
        Laser bias current high warning           : Off
        Laser bias current low warning            : Off
        Laser output power high alarm             : Off
        Laser output power low alarm              : Off
        Laser output power high warning           : Off
        Laser output power low warning            : Off
        Module temperature high alarm             : Off
        Module temperature low alarm              : Off
        Module temperature high warning           : Off
        Module temperature low warning            : Off
        Module voltage high alarm                 : Off
        Module voltage low alarm                  : Off
        Module voltage high warning               : Off
        Module voltage low warning                : Off
        Laser rx power high alarm                 : Off
        Laser rx power low alarm                  : Off
        Laser rx power high warning               : Off
        Laser rx power low warning                : Off
        Laser bias current high alarm threshold   : 0.000 mA
        Laser bias current low alarm threshold    : 0.000 mA
        Laser bias current high warning threshold : 0.000 mA
        Laser bias current low warning threshold  : 0.000 mA
        Laser output power high alarm threshold   : 0.0000 mW / -inf dBm
        Laser output power low alarm threshold    : 0.0000 mW / -inf dBm
        Laser output power high warning threshold : 0.0000 mW / -inf dBm
        Laser output power low warning threshold  : 0.0000 mW / -inf dBm
        Module temperature high alarm threshold   : 0.00 degrees C / 32.00 degrees F
        Module temperature low alarm threshold    : 0.00 degrees C / 32.00 degrees F
        Module temperature high warning threshold : 0.00 degrees C / 32.00 degrees F
        Module temperature low warning threshold  : 0.00 degrees C / 32.00 degrees F
        Module voltage high alarm threshold       : 0.0000 V
        Module voltage low alarm threshold        : 0.0000 V
        Module voltage high warning threshold     : 0.0000 V
        Module voltage low warning threshold      : 0.0000 V
        Laser rx power high alarm threshold       : 0.0000 mW / -inf dBm
        Laser rx power low alarm threshold        : 0.0000 mW / -inf dBm
        Laser rx power high warning threshold     : 0.0000 mW / -inf dBm
        Laser rx power low warning threshold      : 0.0000 mW / -inf dBm

[3]
# ethtool -m eth1
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
        Connector                                 : 0x07 (LC)
        Transceiver codes                         : 0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
        Transceiver type                          : 10G Ethernet: 10G Base-SR
        Encoding                                  : 0x06 (64B/66B)
        BR, Nominal                               : 10300MBd
        Rate identifier                           : 0x00 (unspecified)
        Length (SMF,km)                           : 0km
        Length (SMF)                              : 0m
        Length (50um)                             : 80m
        Length (62.5um)                           : 30m
        Length (Copper)                           : 0m
        Length (OM3)                              : 300m
        Laser wavelength                          : 850nm
        Vendor name                               : IBM-Avago
        Vendor OUI                                : <REDACTED>
        Vendor PN                                 : <REDACTED>
        Vendor rev                                : G2.3
        Option values                             : 0x00 0x1a
        Option                                    : RX_LOS implemented
        Option                                    : TX_FAULT implemented
        Option                                    : TX_DISABLE implemented
        BR margin, max                            : 0%
        BR margin, min                            : 0%
        Vendor SN                                 : <REDACTED>
        Date code                                 : <REDACTED>
netlink error: Unknown error 1820


