Return-Path: <netdev+bounces-71992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325168560F1
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A3B285746
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C712BF39;
	Thu, 15 Feb 2024 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b="Gey/D1rY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ycharbi.fr (mail.ycharbi.fr [45.83.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024A12A142
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995265; cv=none; b=EF6+U5zogW6vUslGclNiuZnyBfCMyzfEnuoTu7yQmQ9oTdOi6dyYLNOK2vPxI4Xc3kZN3EkWnaVCH/J8jQZbANgbBLZFOo/cBvxYigShj1Wf5fGXPqRvgkk+NLGVvlsHNHDrMCm9cwfqruiecA9jher6kG0pinhh4VCLjyQoDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995265; c=relaxed/simple;
	bh=IT6a5Nw4dZlYOm4J/MrtHC1WGfvjoiWJ6lT8CMBCrxg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=TbNjqURcZOSj0uxNNd3vdzXSMG7qHOD8bZdU9HbnB70QYMcwhwxstkW/c9kRRQ1ie1MGbtBY0iUK/zSQGuubSdhY7A6tKuCBQLN8YmyPoLQuOwyCGlUOv/ssXtp07Rebla0lYN4EekS4AGtVtJgGvRuPVZKmAt05hc3MzbQ5sOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr; spf=pass smtp.mailfrom=ycharbi.fr; dkim=pass (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b=Gey/D1rY; arc=none smtp.client-ip=45.83.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ycharbi.fr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ycharbi.fr; s=mail;
	t=1707994938; bh=IT6a5Nw4dZlYOm4J/MrtHC1WGfvjoiWJ6lT8CMBCrxg=;
	h=Date:List-Unsubscribe:From:Subject:To:Cc:From;
	b=Gey/D1rY1Hh6LQ8897aj1ktICIoWwsHtOVA1Dz4ABSCaqriRfzCPyfCC36nDOKxzx
	 7WDcI7QIoQZQHF8pWTWu4i+sQtg2J7u5JyMgFRIg4yf3oJ7EFeGAlV1btEWdfnOCmk
	 FkldulEYtnKqVKDO5/ahsGkhUftH0Fri5FFiBp2u+PQZLs7NMXr8sOSjS+16q2InpM
	 1B4DU6JHi+WXQGnQqcje6fGZnBoVzrDo8Tu1hXqNFVr2WnyenJJskK3etGXvkDjSoP
	 UWnXwsCE5f63JNvIMrdt8kodP8s98azNKIz9t/1hMVj4OLOUcwW0x14wtuDMfVnuCY
	 hgfNVT8UiarSj/XniYofUtMAe/8UqYNRULX6wjzin9MHdl1mwXLtHqoCy/uijoXBxy
	 CYoo8ORCyLuof44QM4725YIFKCfu9vG5oJ/69ogGFk+F/TnXRpUbTFY4dYmWjw4iY+
	 LJf5JaTXYo1p0kxJ1/DJyGeZFLO16A+DeT4pUh+ircDF2eIOSzsfo1HIhgMtUvEGuk
	 bv6ICX2XyptQAJtjFnjF8piGk6d55sI1o/TudOxWge1L27FEz0wxaqT74TvOwlzzBQ
	 ck2qRo3k1z0SGSbC+4dJBRLG3tiAZ3QwgNUzCSaI4WomcJqyqxEhc0ffdVU0YLnYBz
	 jaUqQSjaPoDOYK7wxeTulh/Q=
Date: Thu, 15 Feb 2024 11:02:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: kernel.org-fo5k2w@ycharbi.fr
Message-ID: <8267673cce94022974bcf35b2bf0f6545105d03e@ycharbi.fr>
TLS-Required: No
Subject: Non-functional ixgbe driver between Intel X553 chipset and Cisco
 switch via kernel >=6.1 under Debian
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*       valid
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
	*      author's domain

Hello,

(Please note that I don't speak English, sorry if the traction is not fai=
thful to your language)

Following Bjorn Helgaas's advice (https://bugzilla.kernel.org/show_bug.cg=
i?id=3D218050#c14), I'm coming to you in the hope of finding a solution t=
o a problem encountered by several users of the ixgbe driver. The subject=
 has been discussed in the messages and comments on the following pages:
https://marc.info/?l=3Dlinux-netdev&m=3D170118007007901&w=3D2
https://forum.proxmox.com/threads/intel-x553-sfp-ixgbe-no-go-on-pve8.1351=
29/
https://www.servethehome.com/the-everything-fanless-home-server-firewall-=
router-and-nas-appliance-qotom-qnap-teamgroup/
https://www.servethehome.com/intel-x553-networking-and-proxmox-ve-8-1-3/?=
unapproved=3D518173&moderation-hash=3De57a05288058d3ff253ceb42e9ada905
https://forum.proxmox.com/threads/proxmox-8-kernel-6-2-16-4-pve-ixgbe-dri=
ver-fails-to-load-due-to-pci-device-probing-failure.131203/
https://bugzilla.kernel.org/show_bug.cgi?id=3D218491
https://bugzilla.kernel.org/show_bug.cgi?id=3D218050

Having myself decided to purchase a Qotom Q20332G9-S10 machine with X553 =
chipset for testing purposes, I can see the effectiveness of the connecti=
on problem between the PC's X553 SFP+ and a Cisco switch SFP+. For my par=
t, this happens under GNU/Linux Debian 12 - kernel 6.1.76 and Sid - kerne=
l 6.6.13. So it's not specific to Proxmox.
I should point out that under GNU/Linux Debian 11 - kernel 5.10, the netw=
ork card (X553 via ixgbe) works without problems. So this is a relatively=
 "recent" bug.

Here's my test environment:
- 1 Qotom Q20332G9-S10 (I used a 16GB Intel Optane M10 M.2 SSD with a fre=
sh GNU/Linux Debian 12)
- 1 Cisco DAC cable (tested with a 1M and a 3M)
- 1 PC with Mellanox Connectx-3 2x SFP+ network card (running GNU/Linux D=
ebian SID installed several years ago)
- 1 Cisco 3560CX-12PD-S switch (2 SFP+ ports) with IOS 15.2(7)E2

Connecting the Qotom Q20332G9-S10 (X553) to the Mellanox Connectx-3 works=
 without a hitch and without any special handling (the linux-image-6.1.0-=
17-amd64 ixgbe driver works in this configuration). Full 10gbps speeds be=
tween the two with an "iperf".

At this stage, I've ruled out a hardware incompatibility (OSI level 1) si=
nce the DAC works with the X553. So there's no need to use compatibility =
tricks as suggested in the link comments with the "allow_unsupported_sfp=
=3D1" parameter. This will be useless in the following tests (I've checke=
d).

Where it gets tricky is when you connect it (the Qotom) to the Cisco swit=
ch.
Before an "ip link eno1 up", the Cisco raises the link on its side, but t=
he Debian doesn't (link DOWN). After the "ip link eno1 up", the link drop=
s and never comes back. There does seem to be a driver problem in recent =
kernels (GNU/Linux Debian Stable and Sid).

After compiling the driver manually (https://downloadmirror.intel.com/812=
532/ixgbe-5.19.9.tar.gz) following the documentation already shared by ot=
hers (https://www.xmodulo.com/download-install-ixgbe-driver-ubuntu-debian=
.html), it works with the Cisco (after a "shut/no shut" of the latter's 1=
0gbe port).

So we end up with a working machine (I even configured and used the SR-IO=
V successfully right afterwards).

PS: I also tested with Debian Sid

I've finally tried the commands you were giving Skyler without any result=
 (rmmod ixgbe; modprobe ixgbe; ethtool -S eno1 | grep fault).

For the moment, the Qotom machine is dedicated to testing, so I'm availab=
le to carry out any manipulations you may wish to make to advance the sub=
ject.
Can we work on diagnosing this problem so that the next stable release of=
 Debian is fully functional with this Intel network card?

Best regards.

=E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80
=E2=A3=BE=E2=A0=81=E2=A2=A0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 Yohan Cha=
rbi
=E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80 Cordialem=
ent
=E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80

