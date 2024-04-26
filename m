Return-Path: <netdev+bounces-91823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE938B40DF
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 22:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786DF28420C
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974FC28DBF;
	Fri, 26 Apr 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlw9ecwa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC57125AE
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163767; cv=none; b=FGkKDU+zhZiV1dsKKr+U44l7AEF1ZMSmKGDG7iXn7YUEP9jJHmoap+4Sg6gQj5HeesVnpmCsW7mjORStJu2J+iEDBvFrFKoVGVmctq0+Ay62M8RQhb8Tj9BYUsbF1ohJvOtinMOx5tj+YJKmOZ/wnv77vqC0xTWMlFUI7uhTnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163767; c=relaxed/simple;
	bh=nFDKK3TrNjYvDOKfWO08v7x7Xtz9S4pHHAvyccoTU5o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SpGpFSco08lHV1nX8DftgTlhlAWM8IOeAHrqUFl7tCj21tB/ff8vZJ5wXT6Wf2leTT9rQ/rV87gGxrObd9jXOV1u7z3/fs9L1xrFPaeF1GDrjdby/Za5FxzD9RYbrT18btBdh/JKIjFf19XqVlYXnpv5gl8B6TpsZbBgKdDgUEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tlw9ecwa; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so2508925b3a.2
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714163765; x=1714768565; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MLyFeao1ebroNBWDVmyIXeO9ftXrv61s8m5GkOFXbbg=;
        b=Tlw9ecwaQFfMsE5IVYiU8ATA7voB1CHLMwIAkzJBbiZQFrO+VCN4Baq7Xphx0Vqgrh
         Ja3qvI4DBpRzsedUfy64t+3CXWUdW7WyPEB176u73Z6gNNofYeeEW95Exjz/++dl0nn1
         r94vG7grLYbWYJep3pIWLlPN6wrOT9aK0ctdb2GEG6n+mCujQ2tyt94n/ZFyYf+DgXad
         JrhjFgL+ZR6gBqx7obMUSMhC5mXfvnCmv1c0I2lsK8gCPn9SRzsRPIFZt+SSNQUGeHuq
         1rphL9pwxunDAoKjF3pVsrpSPS/6HFNtS1pUEzoIIbvGT2mruLyH21HTmuPtmO96muhe
         NngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714163765; x=1714768565;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLyFeao1ebroNBWDVmyIXeO9ftXrv61s8m5GkOFXbbg=;
        b=qnHAmpPnOrh5arHFqQ+9Df4qNkYyDUcJDD++b0BqxYPMon/QPAKerdfR/63rusefwM
         oDs2JrtFElsfue4ON1ncrvOhej2GTs87CoG8ileNdJcanecRaeu/Pp4mOboGVDXSzJTW
         iTiWlvSZUm7Nx52+lvLkDnltvGXzWzzF1F2gDrLr9G+kyRVEqM7J+GCaqieiIonqHx0N
         w3f+FiIIQwQFxfQ2EQxzXopFo+ek2OjWPJ6N75YXr7jPKyOjLREjdzBVpLkf3ULERwbV
         HZLEM7oyT3jGrb4xDUiqiOGN0jq5ebw91y2Jnk2jCoGQLzfhs4dQDDwCMU7tfBQZmrEA
         lUxw==
X-Gm-Message-State: AOJu0YxoeH30VP7ydIP73jjdbDetpAX7zYxnU2TEk89ydRorNWzPSdx3
	WU/xQyW6cGXE2rr5Sp1Y8wzG/EPCuq3qZnj/KbU8LlsNX9Ftlk6GbPOy3Ex07HUIsrStURMoxN9
	d7ru8aIgJFSOLN3yDgvlZ7WY9f0ggzmad
X-Google-Smtp-Source: AGHT+IHUpRcJYrNhoC2zgIATzuRyZIYWOG5GwkIwslHd03b6dClnn4pbd3sOtUwpv0oIzBKM1H+sSsyxeGm2PZ40NZg=
X-Received: by 2002:a05:6a21:2707:b0:1a9:9eb8:20e1 with SMTP id
 rm7-20020a056a21270700b001a99eb820e1mr4078273pzb.22.1714163765068; Fri, 26
 Apr 2024 13:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shane Miller <gshanemiller6@gmail.com>
Date: Fri, 26 Apr 2024 16:35:28 -0400
Message-ID: <CAFtQo5D8D861XjUuznfdBAJxYP1wCaf_L482OuyN4BnNazM1eg@mail.gmail.com>
Subject: RE: SR-IOV + switchdev + vlan + Mellanox: Cannot ping
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Problem:
-----------------------------------------------------------------
root@machA $ ping 10.xx.xx.194
PING 10.xx.xx.194 (10.xx.xx.194) 56(84) bytes of data
From 10.xx.xx.191 icmp seq=10 Destination Host Unreachable
Proximate Cause:
-----------------------------------------------------------------
This seems to be a side effect of "switchdev" mode. When the identical
configuration is set up EXCEPT that the SR-IOV virtualized NIC is left
"legacy", ping (and ncat) works just fine.

As far as I can tell I need a bridge or bridge commands, but I have no
idea where to start. This environment will not allow me to add modify
commands when enabling switchdev mode. devlink seems to accept
"switchdev" alone without modifiers.

Note: putting a NIC into switchdev mode makes the virtual functions
show as "link-state disable" which is confusing. (See below.) Contrary
to what it seems to suggest, the virtual NICs are up and running

Running "arp -e" on machine A shows machine B's ieth3v0 MAC address as
incomplete suggesting switchdev+ARP is broken.

Problem Environment:
-----------------------------------------------------------------
OS: RHEL 8.6 4.18.0-372.46.1.el8 x64
NICs: Mellanox ConnectX-6

Machine A Links:
70 tst@ieth3: <...LOWER_UP...> mtu 1500
   link/ether xx.xx.xx.xx.xx.xx
   vlan protocol 802.1Q id 133 <REORDER_HDR>
   Inet 10.xx.xx.191

Machine B Links With ieth3 in SR-IOV mode in switchdev mode:
# Physical Function and its virtual functions:
                                                 2: ieth3:
<...PROMISC,UP,LOWER_UP> mtu 1500
    link/ether xx.xx.xx.xx.xx.f6 portname p0 switchid xxxxe988
    vf 0 link/ether xx.xx.xx.xx.xx.00 vlan 133 spoof off, link-state
disable, trust off
    . . .
# Port representers
893: ieth3r0: <...UP,LOWER_UP> mtu 1500
link/ether xx.xx.xx.xx.xx.e1 portname pf0vf0 switchid xxxxe988
. . .
# Virtual Links
897: ieth3v0: <...UP,LOWER_UP> mtu 1500
  link/ether xx.xx.xx.xx.xx.00 promiscuity 0
  inet 10.xx.xx.194/24 scope global ieth3v0
  . . .

SR-IOV Setup Summary
-----------------------------------------------------------------
This is done right since, in legacy mode, ping/ncat works fine:

1. Enable IOMMU, Vtx in BIOS
2. Boot Linux with iommu=on on command line
3. Install Mellanox OFED
4. Enable SR-IOV for max 8 devices in Mellanox firmware
(reboot)
5. Create 4 virtual NICs w/ SR-IOV
6. Configure 4 virtual NICs mac, trust off, spoofchk off, state auto
7. Unbind virtual NICs
8. Put ieth3 into switchdev mode
9. Rebind virtual NICs
10. Bring all links up
11. Assign IPV4 addresses to virtual links

