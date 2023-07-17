Return-Path: <netdev+bounces-18405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE33756C89
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 20:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569CD1C20B78
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1976CBE4A;
	Mon, 17 Jul 2023 18:53:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54823C8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 18:53:56 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB49DAF
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:53:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b9c368f4b5so38068995ad.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689620034; x=1692212034;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=92cG1k59+YM20Ni2fBSwRgRziULSCJmF7NbZO50ZJPg=;
        b=iqweFRK60ELeBty6vLU6PVkUm8licLY49vjxBYAWrEOOjvnw1ffq1KpdjalIXzwZ06
         FvFK3kJeGYO79BotSDuo4MclHn0go/qvRgw7Z2otBdBLprFOyRE22Ey/ZgRG5f8h/SD8
         +i5YIO6INA8QnvogepvU9aucrXY6ImxyLfI4hQoydQn1LIZ5rheoypv0R1XTkqWzl/zk
         CNalNrRnyZeboJhzx3ClXPzvRHlfQS2r8LZH12MvPEX2h2CrEy26Iu0jLHqcu33Lb8lZ
         a+5LPjcT6NSl1P7p5B+95EKhD6Tu8Zz0i034rh5Hm2/554W17XQ134Uimg0v+nCHsA6b
         X+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689620034; x=1692212034;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92cG1k59+YM20Ni2fBSwRgRziULSCJmF7NbZO50ZJPg=;
        b=bSx+jJS16+BCt0uik6lTXDPzpb2zlHClSoTOqHCNb0DhUoPc2WkJ6gffJACRYbrvnG
         cwejK8KOQxjK0EUewLClNnmRClzGLIySob4jEhYCptrUtb1/eUIQdP9jFomNig2sN3sG
         6dpnxrfAuAKpqn8MAtA4PU9+YIcUB2LpcSo2PpUjFNm6KSkBbOvakZFW6dc+gob+W1ne
         JE8Yvv+4uSgBMc8HxgOKKUjrn/DmeetZT9qb4OR7nxmEsnewikOTLiV8TEbG3Aogf9t0
         /OZV3p47p5wWPAzFGFPXKEMvfLsBXMK4ZEQg8I64CMqfIDOhLpoHDTK88naBHGhAAQQf
         H+/w==
X-Gm-Message-State: ABy/qLb3g73KVBso5GlEqEeFdqr7YcoVaX/vdopZLGes64GyLMncB9SU
	z+uYgFfzF4PBLpWcyCeJRH6fvdCubf+kQ3n1fwHScw==
X-Google-Smtp-Source: APBJJlHc4elCqlsmQyPq6HCXBIdrD6GQRCXB0gGj/5dny2qO7E/nmyZ4qdmrdkoA1QcWKIoYqzoqWQ==
X-Received: by 2002:a17:902:ce90:b0:1b8:417d:d042 with SMTP id f16-20020a170902ce9000b001b8417dd042mr13964468plg.20.1689620034176;
        Mon, 17 Jul 2023 11:53:54 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id jc6-20020a17090325c600b001b54dcd84e2sm199887plb.240.2023.07.17.11.53.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 11:53:54 -0700 (PDT)
Date: Mon, 17 Jul 2023 11:53:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 217678] New: Unexplainable packet drop starting at v6.4
Message-ID: <20230717115352.79aecc71@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Begin forwarded message:

Date: Mon, 17 Jul 2023 17:44:27 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 217678] New: Unexplainable packet drop starting at v6.4


https://bugzilla.kernel.org/show_bug.cgi?id=3D217678

            Bug ID: 217678
           Summary: Unexplainable packet drop starting at v6.4
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: hq.dev+kernel@msdfc.xyz
        Regression: No

Hi,

After I updated to 6.4 through Archlinux kernel update, suddenly I noticed
random packet losses on my routers like nodes. I have these networking rele=
vant
config on my nodes

1. Using archlinux
2. Network config through systemd-networkd
3. Using bird2 for BGP routing, but not relevant to this bug.
4. Using nftables for traffic control, but seems not relevant to this bug.=
=20
5. Not using fail2ban like dymanic filtering tools, at least at L3/L4 level

After I ruled out systemd-networkd, nftables related issues. I tracked down
issues to kernel.

Here's the tcpdump I'm seeing on one side of my node ""

```
sudo tcpdump -i fios_wan port 38851
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on fios_wan, link-type EN10MB (Ethernet), snapshot length 262144
bytes
10:33:06.073236 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP,
length 148
10:33:11.406607 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP,
length 148
10:33:16.739969 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP,
length 148
10:33:21.859856 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP,
length 148
10:33:27.193176 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP,
length 148
5 packets captured
5 packets received by filter
0 packets dropped by kernel
```

But on the other side "[REDACTED_PUBLIC_IPv4_1]", tcpdump is replying packe=
ts
in this wireguard stream. So packet is lost somewhere in the link.

=46rom the otherside, I can do "mtr" to "[BOS1_NODE]"'s public IP and found t=
he
moment the link got lost is right at "[BOS1_NODE]", that means "[BOS1_NODE]=
"'s
networking stack completely drop the inbound packets from specific ip
addresses.

Some more digging

1. This situation began after booting in different delays. Sometimes can
trigger after 30 seconds after booting, and sometimes will be after 18 hour=
s or
more.
2. It can envolve into worse case that when I do "ip neigh show", the ipv4 =
ARP
table and ipv6 neighbor discovery start to appear as "invalid", meaning the
internet is completely loss.
3. When this happened to wan facing interface, it seems OK with lan facing
interfaces. WAN interface was using Intel X710-T4L using i40e and lan side =
was
using virtio
4. I tried to bisect in between 6.3 and 6.4, and the first bad commit it
reports was "a3efabee5878b8d7b1863debb78cb7129d07a346". But this is not
relevant to networking at all, maybe it's the wrong commit to look at. At t=
he
meantime, because I haven't found a reproducible way of 100% trigger the is=
sue,
it may be the case during bisect some "good" commits are actually bad.=20
5. I also tried to look at "dmesg", nothing interesting pop up. But I'll ma=
ke
it available upon request.

This is my first bug reports. Sorry for any confusion it may lead to and th=
anks
for reading.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

