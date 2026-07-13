Return-Path: <netdev+bounces-307160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ryEpOj3mVGr8ggAAu9opvQ
	(envelope-from <netdev+bounces-307160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:21:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0B74B7AE
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:21:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RNI1qXYy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307160-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307160-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51AFA304DA12
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB79F4195D7;
	Mon, 13 Jul 2026 13:12:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53541C2E8
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 13:12:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948352; cv=none; b=S+g+fbw49lKR763R5Ut+9rxchHMMGKsmw8ygYk0CeSAcfzPCG8po6zbYX+ucO1NawB4IjpqgoP8iGBskevh9kxN0/jkMLqpYERQ6P2itbd50926PI+0jQnRtCiMiMvjoXgDKRcLj1qepfTJRFk8rVPuSHR++5be5i4pM8WszlE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948352; c=relaxed/simple;
	bh=eOXs1SKrQwk11D0Um+Ni+sRdoOwMo07YqSbXEUA/+1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVNLyEZabbsuiryeGkvQ4NMt5DpUcuaTi1zjoqL56WGna5WuW533IaikWlqrrNnL+OKhrAN974EuxrkYPimxFQzOZnTCNAxN2nMuQhPW427Mvnw7D/izPm/lu7R64M7Emn1nmEsC8PbchAQQEoAIaXL1ZyLVa6yEO3gM2w356Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNI1qXYy; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c733f15aso30047375e9.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948349; x=1784553149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7QjD1+Kfbgq2XrbSxv8Jp+hCC17bDU4edXaLS0HJTto=;
        b=RNI1qXYyVbWkKDlF35SukhLpwTyZ1OxlejTdiyyzGW48zXKI3cY1Qgp1nkZlG5+rWN
         ME2xXu8o4UbPCAezrbKXLCJGsdjAkX7u7N3iQnmhuq4Vcfof1PHqvYBf3RK8ZO7aGVR6
         234C59s9qk4f0t4BZnTiM9ytIiGz8qWGrqDeedLUKfekab+08VvsyX7h5cFQc7EiyNXJ
         Y+SS7LX0cDvCOQQOt0pA8c8BVexE3iQ3LsozLc3ymCpwqtcAezNQ15zSBY/Yx8JCOV8e
         utTkIfPF232EcVXL1N+uKg9v5R/gPkY2WftIiV7u66+WpE/fDtTqIjWoAAeMXHfkuZfF
         Dc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948349; x=1784553149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7QjD1+Kfbgq2XrbSxv8Jp+hCC17bDU4edXaLS0HJTto=;
        b=Az0m2lGMlk5KXlVDd7Iy8FIxtnn3roi4rwdIldzzGDEerONMb2WahVKr2drGymlkO+
         Um57TN5TwJdWpzTp8HocX5Faq+j4cO34AS/j72HVSVwNXXh2DEkQ6XbHV6wq4bwrrMBs
         6gYmo9WMTH+uzG4Eg6h62dlh/PG1sbwD7U2K9h89DuLidRRPG4B2p4irhf0/tcnM4Tw5
         k8k9rJWmzWTGjnoMgBsX6dU1QGD+uVovXeM+AdJDrmn3gQ5mHLkndyv45dgWaNA0iHF4
         7SB8kaFSrLvujIFzNa0j7NcWSzXC5lO+H6B1pOo533sWQcaaauGNBvH/cOMFASNv4llL
         /Vlg==
X-Gm-Message-State: AOJu0Yy4wo6kbPZs3DUPMu6H8C4CsioK6prJ6gMNcq4tVDrPukuqYFLw
	oHr156v0NWQG7/c8bG0Ww/AGtzMWyZVT8wwSpdKWHj6tNqRYoZX2H8Aav7P3sg==
X-Gm-Gg: AfdE7cnhnvHSd8O2oFsU9ltdl0SYiMpzRQkkU69HVbdns4duuP1w0DQago6WM6HR/MZ
	Iqawdb92oYBL3nBSG1tOWJMIm/F21ANMvskiNE1Irs+eEvk72ZsskgEEtLqG350iv5PGJhrSKHu
	WOY+sQK7GnIlLtrKdbBPzlIhUiXVRPZ0N+1SReiwSPpalrFAB50Vg+ACFA4Z7Au4lII3DHgrK43
	rV7WtPfBm4n2/CcGO0vBjLhFy/wBs1JlG4C0nwyhxGAKTHzpM4kKP3yQ32svU0Mf6LoFqDAp+t8
	Bml46H480x3D5DA+o9vU4Qp29L7+BxGuxe0SsxWzNN2QUNmM7R+qPhRP57mAUW0Orn1jOFrblCh
	DIBkJFU0I41iZP8difwqFnq+pjfBwCQCehnTe2O6spnttwjHCjpd7LmH61HJ9qVRYfhQhKUl0BH
	Yz317jP7v+HR4W
X-Received: by 2002:a05:600c:858e:b0:493:be08:c372 with SMTP id 5b1f17b1804b1-493f88b5d6amr87585035e9.17.1783948349019;
        Mon, 13 Jul 2026 06:12:29 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3dcdsm354106345e9.3.2026.07.13.06.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:12:28 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 0/2] Add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver
Date: Mon, 13 Jul 2026 16:12:21 +0300
Message-ID: <20260713131223.279555-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-307160-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:a.shimko.dev@gmail.com,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:ashimkodev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ashimkodev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashimkodev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77A0B74B7AE

Hello,

This series adds support for the DAPU Telecom DAP8211R(I) Gigabit
Ethernet PHY, commonly used in enterprise and industrial networking
applications. The PHY supports 10/100/1000 Mbps operation with RGMII
interface and includes features such as IEEE 802.3az Energy Efficient
Ethernet, IEEE 1588 SyncE, and an internal packet generator for
diagnostics.

The driver implements extended register access via indirect addressing
(registers 0x1E/0x1F) and provides comprehensive device tree support
for RGMII delay configuration. The rx-internal-delay-ps and
tx-internal-delay-ps properties allow precise tuning of clock delays
in 150 ps steps from 0 to 2250 ps, with automatic selection of the
nearest supported value if an exact match is not specified. The
optional tx-inverted-clk flag enables 180-degree TX clock phase shift
for boards where signal integrity or MAC requirements necessitate
clock inversion.

The driver also includes a debugfs interface for diagnostics, exposing
PHY status registers (info) and providing runtime control over the
internal packet generator (pkg_gen), CRC corruption, and loopback
functionality. This interface is particularly useful for development
and field diagnostics without requiring external test equipment.

This PHY is used on the NDA platform with 1G Ethernet tile and has
been tested on that hardware with successful link establishment and
RGMII delay tuning.

Due to the specific PCB layout of the platform and FPGA configuration,
the default RGMII timing configuration was insufficient, causing packet
loss during normal operation. Tuning the TX/RX line delays and enabling
clock inversion restored proper signal timing, resulting in zero packet
loss and stable link performance.

$ make dt_binding_check
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
...
DTEX    Documentation/devicetree/bindings/net/dapu,dap8211r.example.dts
DTC [C] Documentation/devicetree/bindings/net/dapu,dap8211r.example.dtb
...

grep -i "dap8211r" Documentation/devicetree/bindings/processed-schema.json
chema.json
    "http://devicetree.org/schemas/net/dapu,dap8211r.yaml": {
        "$filename": ".../devicetree/bindings/net/dapu,dap8211r.yaml",
        "$id": "http://devicetree.org/schemas/net/dapu,dap8211r.yaml#",
        "title": "DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY",

Working with xgmac.

Board side not pkc_gen mode (normal):

$ arping -I eth0 192.168.5.100
ARPING 192.168.5.1 from 192.168.5.100 eth0
Unicast reply from 192.168.5.1 [board.mac.addr]  8.543ms
Unicast reply from 192.168.5.1 [board.mac.addr]  3.295ms
Unicast reply from 192.168.5.1 [board.mac.addr]  4.301ms
Unicast reply from 192.168.5.1 [board.mac.addr]  4.096ms
Unicast reply from 192.168.5.1 [board.mac.addr]  2.872ms
...

$ Unfortunately, there is a dependence on the axibus speed here
$ iperf3 -c 192.168.5.1
Connecting to host 192.168.5.1, port 5201
[  5] local 192.168.5.100 port 58936 connected to 192.168.5.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  7.88 MBytes  65.8 Mbits/sec    0    150 KBytes
[  5]   1.00-2.00   sec  8.50 MBytes  71.4 Mbits/sec    0    165 KBytes
[  5]   2.00-3.00   sec  8.25 MBytes  69.2 Mbits/sec    0    165 KBytes
[  5]   3.00-4.01   sec  8.50 MBytes  71.1 Mbits/sec    0    165 KBytes
[  5]   4.01-5.00   sec  8.38 MBytes  70.3 Mbits/sec    0    165 KBytes
[  5]   5.00-6.00   sec  8.50 MBytes  71.5 Mbits/sec    0    165 KBytes
[  5]   6.00-7.01   sec  8.62 MBytes  72.0 Mbits/sec    0    174 KBytes
[  5]   7.01-8.00   sec  8.62 MBytes  72.8 Mbits/sec    0    174 KBytes
[  5]   8.00-9.00   sec  8.62 MBytes  72.2 Mbits/sec    0    174 KBytes
[  5]   9.00-10.04  sec  8.62 MBytes  69.9 Mbits/sec    0    174 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.04  sec  84.6 MBytes  70.7 Mbits/sec    0 sender
[  5]   0.00-10.12  sec  84.8 MBytes  70.3 Mbits/sec receiveriperf Done.

$ ethtool -t eth0
...
The test extra info:
 1. MAC Loopback                 0
 2. MAC Loopback (diff. queues)  0
 3. PHY Loopback                 0
...

ELP side not pkc_gen mode (normal):
...
17:29:11.974973 ARP, Reply ELP is-at elp.mac.addr(oui Unknown), length 28
17:29:12.975199 ARP, Request who-has ELP (elp.mac.addr(oui Unknown)) tell 192.168.5.100, length 46
17:29:12.975217 ARP, Reply ELP is-at elp.mac.addr(oui Unknown), length 28
17:29:13.975022 ARP, Request who-has ELP (elp.mac.addr(oui Unknown)) tell 192.168.5.100, length 46
17:29:13.975035 ARP, Reply ELP is-at elp.mac.addr(oui Unknown), length 28
17:29:14.974837 ARP, Request who-has ELP (elp.mac.addr(oui Unknown)) tell 192.168.5.100, length 46
17:29:14.974849 ARP, Reply ELP is-at elp.mac.addr(oui Unknown), length 28
17:29:15.975026 ARP, Request who-has ELP (elp.mac.addr(oui Unknown)) tell 192.168.5.100, length 46
...

Accepted connection from 192.168.5.100, port 58932
[  5] local 192.168.5.1 port 5201 connected to 192.168.5.100 port 58936
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  7.12 MBytes  59.7 Mbits/sec
[  5]   1.00-2.00   sec  8.50 MBytes  71.3 Mbits/sec
[  5]   2.00-3.00   sec  8.50 MBytes  71.3 Mbits/sec
[  5]   3.00-4.00   sec  8.38 MBytes  70.3 Mbits/sec
[  5]   4.00-5.00   sec  8.50 MBytes  71.3 Mbits/sec
[  5]   5.00-6.00   sec  8.38 MBytes  70.3 Mbits/sec
[  5]   6.00-7.00   sec  8.62 MBytes  72.4 Mbits/sec
[  5]   7.00-8.00   sec  8.62 MBytes  72.3 Mbits/sec
[  5]   8.00-9.00   sec  8.62 MBytes  72.4 Mbits/sec
[  5]   9.00-10.00  sec  8.62 MBytes  72.4 Mbits/sec
[  5]  10.00-10.12  sec   896 KBytes  62.3 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.12  sec  84.8 MBytes  70.3 Mbits/sec receiver

Board side pkc_gen mode:

To send pck_gen patern frame to ELP
$ echo N > pkg_gen_loopback
$ echo 1 > pkg_gen

To send pck_gen patern frame to MAC
$ echo Y > pkg_gen_loopback
$ echo 1 > pkg_gen

ELP side pkc_gen mode:
$ Ther is expected patern
$ tcpdump -i ens16
17:27:18.993518 5a:a5:5a:a5:5a:a5 (oui Unknown) > 5a:a5:5a:a5:5a:a5, ethertype Unknown (0x5aa5), length 60:
        0x0000:  5aa5 5aa5 5aa5 5aa5 5aa5 5aa5 5aa5 5aa5  Z.Z.Z.Z.Z.Z.Z.Z.
        0x0010:  5aa5 5aa5 5aa5 5aa5 5aa5 5aa5 5aa5 5aa5  Z.Z.Z.Z.Z.Z.Z.Z.
        0x0020:  5aa5 5aa5 5aa5 5aa5 5aa5 5aa5 5aa5       Z.Z.Z.Z.Z.Z.Z.  
17:27:18.995522 5a:a5:5a:a5:5a:a5 (oui Unknown) > 5a:a5:5a:a5:5a:a5, ethertype Unknown (0x5aa5), length 60:
        0x0000:  5aa5 5aa5 5aa5 5aa5 5aa5 5aa5 5aa5 5aa5  Z.Z.Z.Z.Z.Z.Z.Z.
        0x0010:  5aa5 5aa5 5aa5 5aa5 5aa5 5aa5 5aa5 5aa5  Z.Z.Z.Z.Z.Z.Z.Z.
        0x0020:  5aa5 5aa5 5aa5 5aa5 5aa5 5aa5 5aa5       Z.Z.Z.Z.Z.Z.Z.
...

DTS node example:
&ethernet_1g_tile {
  ...
  phy-mode = "rgmii-rxid";
  phy-handle = <&phy1>;
  ...

  mdio: mdio {
    phy1: ethernet-phy@1 {
      ...
      compatible = "ethernet-phy-ieee802.3-c22";
      rx-internal-delay-ps = <1050>;
      tx-use-inverted-clk;
      ...
    };
  };
};

--
Best regards,
Artem Shimko

Artem Shimko (2):
  dt-bindings: net: add DAPU Telecom DAP8211R(I) PHY binding
  net: phy: add DAPU Telecom DAP8210R(I) Gigabit Ethernet PHY driver

 .../bindings/net/dapu,dap8211r.yaml           |  78 +++
 drivers/net/phy/Kconfig                       |  10 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/dap8211r.c                    | 544 ++++++++++++++++++
 4 files changed, 633 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
 create mode 100644 drivers/net/phy/dap8211r.c

-- 
2.43.0


