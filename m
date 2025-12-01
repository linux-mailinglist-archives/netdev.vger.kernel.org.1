Return-Path: <netdev+bounces-242938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A19C96A75
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAABB4E1AD3
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A95303CBF;
	Mon,  1 Dec 2025 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRHchNO7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F27303A2A
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584931; cv=none; b=iyIJ9X/dbiRpuNtdTksJrhMszr+SfpaLdknecwosklNiYxec04Tia9TxvLBdMd9+kxZFry8QCu7OwjsKzJZeT7yYaB697ICxDyouoNOceO4/Iy17piqA7AutwnP19+KTg71qKntfvwzF+XA6MyyhfX7ILia5+RGOLQXfeheX1/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584931; c=relaxed/simple;
	bh=coKQmnQOeVL2OgF0ptAkfJC94MDFt2dY6q7vB6WFLOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6225jEi6Yket2OxVbuGMosMb1++SmFs/UnczHcsPaX9em+/2dXIy6CWyYbBOYdqfbXv7ywY+L1HIuiU2umJKjQnbNCXZ4Lxhr+KvQ/z9Td3pnZlZJ5kGwLRzoEGDmSiWccU+1SIV6gVwuGvUA4JcydrFB+zShUMlmxIK7wfgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRHchNO7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b737cd03d46so573567366b.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764584927; x=1765189727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Trv2vBQvyezhPFCSlLnIlg78sYOVaGWphXC4AQCe9So=;
        b=eRHchNO78riX9WOSFDzaI6092nBLp/OYpUwukl8uniM+1J2CKZizKv7yaiGZspgKdU
         X9tM9GMVOyQG64GbCO+09+3LvypHLAV9w+d392LuQrIRpzrJk4Lk2pXcmGKW6j3DmIaR
         yLPgpPqMzw7YZsF18c22Nfm2/DTAkyTgW+veYjt3Plr5JBdzEdbW//qoVe7Z6TtGXH+I
         eGj/WWpKLMmUf3rwlY706NBHZdu/qRoFX7IOTLrNHYr6Z2BmZegx12TKK8OkqXvIqOmL
         vsZILymUye0SR9Ft4gMf4iFitgZZjaRVs9vZ9Jb6dSwjzdsFQ3H/4sfX9BPwXBsz9lco
         NLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764584927; x=1765189727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Trv2vBQvyezhPFCSlLnIlg78sYOVaGWphXC4AQCe9So=;
        b=RKIIdv3T+veJ8dhG2+1T+hyPSPVWL6ne1Ibzd2Ep5SAID7vuS6WFen/tdidCF40s/f
         YpavvFQs8cjRfAHrVf7LPWXvSYVHE1iHR19eIfCQBp8Ziput1cdfR9cVaNdOX1XLOB+p
         UYCyfLQwisa9mz/AVK3L/yywFzC2cn7+wOkL1B55j5eysmJNlxegCgWBUnQCKsA2NSLl
         WGV8nvTbuKNTJVzKrUk+uZjCheiyBxjDxBdv++TEBzGD6P3Xs2T1b3e8xLhAS2rjxG5f
         Lyb/GnxnHbS6jOdbYXF79UoiyuGzU1oiwyfK2UhaAykxzSf9ZVWps3bDix72KpSSUc9Q
         ohcg==
X-Forwarded-Encrypted: i=1; AJvYcCWWPKBS7xRD6cphvxxrpwqOgekYgkd7cGXYm/1lgI/i0IAvGCsXZ4YqgDFJyzboPRBNPt3sdEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuF9ScouiKoH+P5XSm+XuUuNu+6Zz9KxNSzy9JAqGnpaYeBs1Q
	OnlrdtnwscwPs10yzIR5R13Y7SUkQE2KS+H1a0UnZH6oUxXdPPkdkVFJ
X-Gm-Gg: ASbGncu7Jk4iVyx4BjbBqsYJQ93cxA+H4z4fqOvOE5oJUqQhw2nkVzyD0uiSpTe/3/t
	KboVcJ2vVM55t1LI5qznUQYwqFcF775QDcSHDqvmFi7gDm5T2th9kmeytwDlfpGzVjuqu/TQjMf
	+TstoL2t4/P1eAt5MEPoIjvL4lAXwWkNPNs+PQZJJFbphbxYUvqtgVKb3ZPCky6l6OqyXmBReZl
	jP0yk8L7FnLIjUJz0mo4nw9354PBubEl5bbyGdSLZC4ARiBV1DVkY+9c9NR7pmR7IrGrLvijbqI
	O+OmidsxCeeklEUWYtVtyu++KE3tB6TIgyPIVEKV+/hHeYU+DzZb7D1T4KbQhQFoZy2N1+P5ViR
	sS9ZU1fBx7gw7QMivIPM84pzySNU4iHNSg+q4s+fLJxtREjq0tfyDfTmAnD6iupSw+KFKOOz+3B
	mEeRe0kg5KNhxmF4pPn0Tm6mX9uJ15GPaQ/UDFSWUldbLiByDUjexpN/vpPM73K6cmZU8=
X-Google-Smtp-Source: AGHT+IEpYaDw6CB+PRG4a7CypPzPVOz1eYsdJhEGj+ut8QOSYl9UkcEcJaF3eu3S807y5FJLxRb/8A==
X-Received: by 2002:a17:906:fe49:b0:b72:b289:6de3 with SMTP id a640c23a62f3a-b76719d0982mr4315736866b.58.1764584926734;
        Mon, 01 Dec 2025 02:28:46 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162d31sm1193157766b.9.2025.12.01.02.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:28:46 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC/RFT net-next v2 0/5] net: dsa: deny unsupported 8021q upper on bridge port configurations
Date: Mon,  1 Dec 2025 11:28:12 +0100
Message-ID: <20251201102817.301552-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/networking/switchdev.rst is quite strict on how VLAN
uppers on bridged ports should work:

- with VLAN filtering turned off, the bridge will process all ingress traffic
  for the port, except for the traffic tagged with a VLAN ID destined for a
  VLAN upper. (...)

- with VLAN filtering turned on, these VLAN devices can be created as long as
  the bridge does not have an existing VLAN entry with the same VID on any
  bridge port. (...)

This means that VLAN tagged traffic matching a VLAN upper is never
forwarded from that port (unless the VLAN upper itself is bridged).

It does *not* mean that VLAN tagged traffic matching a VLAN upper is not
forwarded to that port anymore, as VLAN uppers only consume ingressing
traffic.

Currently, there is no way to tell dsa drivers that a VLAN on a
bridged port is for a VLAN upper and should not be processed by the
bridge.

Both adding a VLAN to a bridge port of bridge and adding a VLAN upper to
a bridged port of a VLAN-aware bridge will call
dsa_switch_ops::port_vlan_add(), with no way for the driver to know
which is which. In case of VLAN-unaware bridges, there is likely no
dsa_switch_ops::port_vlan_add() call at all for the VLAN upper.

But even if DSA told drivers which type of VLAN this is, most devices
likely would not support configuring forwarding per VLAN per port.

So in order to prevent the configuration of setups with unintended
forwarding between ports:

* deny configuring more than one VLAN upper on bridged ports per VLAN on
  VLAN filtering bridges
* deny configuring any VLAN uppers on bridged ports on VLAN non
  filtering bridges
* And consequently, disallow disabling filtering as long as there are
  any VLAN uppers configured on bridged ports

An alternative solution suggested by switchdev.rst would be to treat
these ports as standalone, and do the filtering/forwarding in software.

But likely DSA supported switches are used on low power devices, where
the performance impact from this would be large.

To verify that this is needed, add appropriate selftests to
no_forwarding to verify either VLAN uppers are denied, or VLAN traffic
is not unexpectedly (still) forwarded.

These test succeed with a veth-backed software bridge, but fail on a b53
device without the DSA changes applied.

While going through the code, I also found one corner case where it was
possible to add bridge VLANs shared with VLAN uppers, while adding
VLAN uppers shared with bridge VLANs was properly denied. This is the
first patch as this seems to be like the least controversial.

Still sent as a RFC/RFT for now due to the potential impact, though a
preliminary test didn't should any failures with
bridge_vlan_{un,}aware.sh and local_termination.sh selftests on
BCM63268.

Also since net-next is closed (though I'm not sure yet if this is net or
net-next material, since this just properly prevents broken setups).

Changes v1 -> v2:

* added selftests for both VLAN-aware and VLAN-unaware bridges
* actually disallow VLAN uppers on VLAN-unware bridges, not disallow
  more than one
* fixed the description of VLAN upper notification behaviour of DSA with
  filtering disabled

Jonas Gorski (5):
  net: dsa: deny bridge VLAN with existing 8021q upper on any port
  net: dsa: deny multiple 8021q uppers on bridged ports for the same
    VLAN
  selftests: no_forwarding: test VLAN uppers on VLAN aware bridged ports
  net: dsa: deny 8021q uppers on vlan unaware bridged ports
  selftests: no_forwarding: test VLAN uppers on VLAN-unaware bridged
    ports

 net/dsa/port.c                                |  23 +---
 net/dsa/user.c                                |  51 ++++++---
 .../selftests/net/forwarding/no_forwarding.sh | 107 ++++++++++++++----
 3 files changed, 127 insertions(+), 54 deletions(-)


base-commit: 0177f0f07886e54e12c6f18fa58f63e63ddd3c58
-- 
2.43.0


