Return-Path: <netdev+bounces-213212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC757B24221
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4B21B67BA2
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1125C2C3240;
	Wed, 13 Aug 2025 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRZ6dh8e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402BD2EAB65
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068607; cv=none; b=P6LGBQxK5tHeNcIne98yulutEFlEI1FIMA9rlAFtQ7j+ipU6gQp5BPq7cQRjv1MUmqSSGz/FikLLI4Gna6rpqI3t8+yIQpdPEYu2RKWxp4ZjadH/zKdhBSH7dQFjQqQhVl4fItKBRhBl2vfuvP339YIn+qHHfBJSXSab5wLaS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068607; c=relaxed/simple;
	bh=H5z02AYmdzPhHmCo1SGqNx9GNbnUFBP4212MNdfWEuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIG+1C03hWxmwuEBtKYbLLnkQt5k+yEueBmYqmHa7V9r4quNy7fElkr/dN+v4O87CdsWKTQBY5r0hbRDb0/y3esgvPvdyF5aZfx4Y4Ow2gRD6jyN+Y3KNMXVe71N2OTu/uy8t7/Hm7QBN94D0f5HNTDJJNYPlHkRLF71E+E5O/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRZ6dh8e; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af925cbd73aso1140736366b.1
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 00:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755068603; x=1755673403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZCBSjCWunjxZKST/AisCAK3JlX0TKwYYNkdRE0YRfs=;
        b=SRZ6dh8e67laQvQX1WOTlOxNQwOZN5spThh8A/PPWvXLceOQUdrH8K1r0xg4JGehIO
         aLrkhH478FZJCz2oIw6EcntKvjrH7TS8WHyeoX/3IX+TMqYsluOJSo/pKIOoGIZOLuDV
         ugOk7JZW0JtZH6TO6h1TTneshaXqQjQs2x1kO9z79Pz36X0C7YJwWNiEapblDWAYOC13
         bRfD5p9auWP1FxU6vu8YN1Ve0ub6ardOk8j/UQj33rIwTxG25VnMuaR+cfBbVBH7AsXO
         +NordpGyEG8extiyMaQPJpAYCx4Vfl0K59hhCDg0wUioNeVoNYxxDM6xqmaqPCRM+Bjr
         fJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755068603; x=1755673403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZCBSjCWunjxZKST/AisCAK3JlX0TKwYYNkdRE0YRfs=;
        b=GS4JtWND8oyqgEUdg7h2tpb6dnzJivfaynqf8Yvz/M+WbtDAgpUNagNyor1+QS4EB8
         JO87z3b3PVpP37guXhiORVUBftS55jdYaxpjnLYVegCc5LzwC6frfcafyoN5DC1kbjcH
         MHSza46ijzc6Sb/oz+iDZCXLQpFsRoDs1qkLMWFhAbEhy1HAX2elVv5s/MTtnXnU97Xr
         7vSmtt4Kn94amT+O/JPHX3BarzOYnQvRqDWF3IqnV2cezxRSC60PLBfI0oZXbrFwFDSk
         g+hneCbKoZWgUf119ZkjX2F9dmyJwzGfkvW1j66MPP2gUPf+S9jlIC2KPZqQFphjSNsN
         cQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCWsmmFzn8BNCmJXOvl8VqYSqlRjDa8OEBTO+kYik3eUw9Qhu5jUXIv//qsASa9C/M8kleJPLN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7zXJScmduHziBdTzvRYZHs7SQgA6DioQz022OwRU/nCJ8Gb2S
	mSIKr241NE+CdbHpRHOZarTh8R9XuQQWEBj8QQqu/23To8m7MAs9MYmU
X-Gm-Gg: ASbGncuSYeq+YVZSO6k3uCI4aQKZtcfOA6F8wr5DEiCQc/eKUUKisKu/p+1X+bwemV/
	YEdFKfApeTEgGxXpgsIqPUpqSqe5KTzoF0GwiJU5jV173V9OqhE23MBIHGJSG/pPOmsJYhgBQfa
	dQBSpIfBXpnY5l54+lDpoNEWfAszu9yUhrEKCxxbEBvUATkx3BKxDbbmFLeT62xF4QK47ch0aWH
	Z5QXXvji/YD6m9WzCtgNFZ9lUXm7L4wA3BwhcACb9T/6ck57Efy9nEC4tR/B2AyDUkoH9I5enu1
	fdsTHoTlgMpffmliW8S88lF6Hi2o1Z+wBV7aeMiH3QBli/qZFk1pzalvJj/fRbIA3SS8JIIiNRq
	j7bfYdBjWlgHEiNV0/oHGLSnE
X-Google-Smtp-Source: AGHT+IG+KLskCjPK1qORs7Hs2jydZYYS5NkK7o6reDcZcrdj0kvJ7aXkNI0m85p/0pB3oPJWJ22ZzA==
X-Received: by 2002:a17:907:f497:b0:ad5:d597:561e with SMTP id a640c23a62f3a-afca4efd347mr195460466b.56.1755068603186;
        Wed, 13 Aug 2025 00:03:23 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af919e96050sm2331497766b.0.2025.08.13.00.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 00:03:22 -0700 (PDT)
From: vtpieter@gmail.com
To: tristram.ha@microchip.com
Cc: Arun.Ramadoss@microchip.com,
	UNGLinuxDriver@microchip.com,
	Woojung.Huh@microchip.com,
	andrew@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	marek.vasut@mailbox.org,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com
Subject: RE: [net-next,PATCH] net: dsa: microchip: Do not count RX/TX Bytes and discards on KSZ87xx
Date: Wed, 13 Aug 2025 09:03:21 +0200
Message-ID: <20250813070321.1608086-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <DM3PR11MB8736FCDDE21054AC6ACCEA44EC28A@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <DM3PR11MB8736FCDDE21054AC6ACCEA44EC28A@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > > Actually that many rx_discards may be a problem I need to find out.
> > >
> > > I think you are confused about how those MIB counters are read from
> > > KSZ8795.  They are not using the code in ksz9477.c but in ksz8.c.
> > 
> > See [1] TABLE 4-26: PORT MIB COUNTER INDIRECT MEMORY OFFSETS (CONTINUED)
> > , page 108 at the very end . Notice the table ends at 0x1F
> > TxMultipleCollision .
> > 
> > See [2] TABLE 5-6: MIB COUNTERS (CONTINUED) , page 219 at the end of the
> > table . Notice the table contains four extra entries , 0x80 RxByteCnt ,
> > 0x81 TxByteCnt , 0x82 RxDropPackets , 0x83 TXDropPackets .
> > 
> > These entries are present on KSZ9477 and missing on KSZ8795 .
> > 
> > This is what this patch attempts to address.
> 
> As I said KSZ8795 MIB counters are not using the code in ksz9477.c and
> their last counter locations are not the same as KSZ9477.  KSZ9477 uses
> ksz9477_r_mib_pkt while KSZ8795 uses ksz8795_r_mib_pkt.  The other
> KSZ8895 and KSZ8863 switches uses ksz8863_r_mib_pkt.
> 
> The 0x80 and such registers are not used in KSZ8795.  Its registers start
> at 0x100, 0x101, ...
> 
> They are in table 4-28.
 
Just wanted to chip in that for me, with a KSZ8794, the iproute2
statistics work as expected as well after commit 0d3edc90c4a0 ("net:
dsa: microchip: fix KSZ87xx family structure wrt the datasheet"). I'm
on a 6.12 kernel and I see the following:

ip -s -h a
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1501 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:d3:36:00:38:06 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::ad3:36ff:fe00:3806/64 scope link 
       valid_lft forever preferred_lft forever
    RX:  bytes packets errors dropped  missed   mcast           
         2.22G   30.3M      0       0       0    922k 
    TX:  bytes packets errors dropped carrier collsns           
         3.70G   19.3M      0       0       0       0 
4: lan1@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
    link/ether 08:d3:36:00:38:06 brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast           
             0       0      0       0       0       0 
    TX:  bytes packets errors dropped carrier collsns           
             0       0      0       0       0       0 
5: lan2@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br0 state UP group default qlen 1000
    link/ether 08:d3:36:00:38:06 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::ad3:36ff:fe00:3806/64 scope link 
       valid_lft forever preferred_lft forever
    RX:  bytes packets errors dropped  missed   mcast           
         2.62G   30.3M    250     247       0    922k 
    TX:  bytes packets errors dropped carrier collsns           
         3.61G   19.3M      0       0       0       0 
6: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:d3:36:00:38:06 brd ff:ff:ff:ff:ff:ff
    inet 172.18.210.112/26 brd 172.18.210.127 scope global br0
       valid_lft forever preferred_lft forever
    inet6 fe80::ad3:36ff:fe00:3806/64 scope link 
       valid_lft forever preferred_lft forever
    RX:  bytes packets errors dropped  missed   mcast           
         2.19G   30.3M      0    252k       0    922k 
    TX:  bytes packets errors dropped carrier collsns           
         3.60G   19.3M      0       0       0       0 

ethtool -S lan2
NIC statistics:
     tx_packets: 19385247
     tx_bytes: 3615291269
     rx_packets: 30391568
     rx_bytes: 2623613208
     rx_hi: 0
     rx_undersize: 0
     rx_fragments: 0
     rx_oversize: 0
     rx_jabbers: 0
     rx_symbol_err: 3
     rx_crc_err: 3
     rx_align_err: 0
     rx_mac_ctrl: 0
     rx_pause: 0
     rx_bcast: 3985303
     rx_mcast: 924951
     rx_ucast: 25481561
     rx_64_or_less: 5781438
     rx_65_127: 24601395
     rx_128_255: 8744
     rx_256_511: 231
     rx_512_1023: 10
     rx_1024_1522: 3
     rx_1523_2000: 0
     rx_2001: 0
     tx_hi: 0
     tx_late_col: 0
     tx_pause: 0
     tx_bcast: 3
     tx_mcast: 5128
     tx_ucast: 19380278
     tx_deferred: 0
     tx_total_col: 0
     tx_exc_col: 0
     tx_single_col: 0
     tx_mult_col: 0
     rx_total: 2745200072
     tx_total: 3693245281
     rx_discards: 247
     tx_discards: 0

