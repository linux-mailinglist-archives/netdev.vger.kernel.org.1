Return-Path: <netdev+bounces-239526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CD0C69455
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 13:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A23F22B37B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C943C3559EA;
	Tue, 18 Nov 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ecil.co.in header.i=@ecil.co.in header.b="t1jqnwPJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ecil.co.in (mail.ecil.co.in [14.139.95.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D823546F6
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.139.95.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467512; cv=none; b=Tc1WIdjD45/bIsL1p2o8n17dxLHkFfrnmSpc8t96oLjA8tEwe/OnOvCNNSnX1z68J7mVzlSwQRpE6G/2Wag4fG2iiIeYL+Ij7NKkxMxOuKQuCuloDPeKxC6HOc+Gwqrr6R2DqIso5BmGnWHwh0xFc9RTMnYWLuYjnF6kYwVMuS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467512; c=relaxed/simple;
	bh=3oGmYAqFz+5YfHvp9+mbVBMCVmhfd+azkfEqNrYvXY0=;
	h=Mime-Version:Date:Content-Type:Message-ID:From:Subject:To; b=Oxd1alUZwANpzvDVOwTOoNWYAGY0unXU8hS/q1XciIz692A6nvJUo/jsR/I82/+VW8SJW6T8ZuGATZVZ4DfbIvJ8hBsDIXqKSDMLJmZvsCSYqlxbidzCcRZd7UbbUGhoGVSyGooUwfRJZkvcFeyJKbBh+tF3IWNhNvVcPMQQec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ecil.co.in; spf=pass smtp.mailfrom=ecil.co.in; dkim=pass (1024-bit key) header.d=ecil.co.in header.i=@ecil.co.in header.b=t1jqnwPJ; arc=none smtp.client-ip=14.139.95.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ecil.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ecil.co.in
Received: from mail.ecil.co.in (localhost [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72D94120094;
	Tue, 18 Nov 2025 17:14:11 +0530 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecil.co.in;
	s=default; t=1763466251;
	bh=qMIQWsu9sxeOUNb/76+zmGPj5L7owGnm6NlGEXH96ec=; h=Date:From:To;
	b=t1jqnwPJhdqp2fBzNkS6Unm3548oTeRRKOcZO4Xz2Oi5IEmrwEAJqb0mgErJsHV40
	 ADFSdF/lpx5pbF3SwO1dhl3ZzxC9bxUjHo4bdrQbXaH0t5+Ac95jiFY/C/WJZcE+I6
	 /e7EdUDru86Lu2hhlY4z4fKbqo0lRUZSPc3mVXkY=
X-IMSS-DKIM-Authentication-Result: ecnetcluster-email-gateway; sigcount=0
Received: from mail.ecil.co.in (localhost [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51895120091;
	Tue, 18 Nov 2025 17:14:11 +0530 (IST)
Received: from ecil.co.in (mail.ecil.co.in [10.31.0.25])
	by mail.ecil.co.in (Postfix) with ESMTPS;
	Tue, 18 Nov 2025 17:14:11 +0530 (IST)
Received: from webmail1.ecil.co.in (webmail1.ecil.co.in [10.31.0.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail1.ecil.co.in (Postfix) with ESMTPS id 5BE65200A8DF2;
	Tue, 18 Nov 2025 17:14:49 +0530 (IST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 18 Nov 2025 11:44:36 +0000
Content-Type: multipart/mixed;
 boundary="----=_Part_786_943611846.1763466276"
Message-ID: <45952240630d01c27832c4078c571d22@webmail1.ecil.co.in>
X-Mailer: Afterlogic webmail client
From: sganguly@ecil.co.in
Subject: FMAN driver issue linux 5.10
To: netdev@vger.kernel.org, linux-fsl-dpaa@freescale.com
X-Priority: 3 (Normal)
X-Netcore-MailScanner-Information: Please contact the ISP for more information
X-Netcore-MailScanner-ID: 5BE65200A8DF2.A1174
X-Netcore-MailScanner: Found to be clean
X-MailScanner-From: sganguly@ecil.co.in
X-TM-AS-GCONF: 00


------=_Part_786_943611846.1763466276
Content-Type: multipart/alternative;
 boundary="----=_Part_853_982481662.1763466276"


------=_Part_853_982481662.1763466276
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Sir,=0A=09Please find the following configuration.=0A=09*  =0A=0A=09Kerne=
l version (e.g., 5.10.131) =0A=09*  =0A=0A=09SoC/platform (T1014) =0A=09*=
  =0A=0A=09Symptom (TX =E2=80=9Csent=E2=80=9D but nothing on wire)=0A=0AI=
 am seeing increment in ifconfig but nothing sent or received physically =
on line.=0AI am attaching the dts file for reference.=0APlease help me to=
 solve it.=0A# ifconfig=0Aeth0      Link encap:Ethernet  HWaddr 00:11:22:=
33:44:55=0A          inet addr:192.168.0.211  Bcast:192.168.0.255  Mask:2=
55.255.255.0=0A          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric=
:1=0A          RX packets:0 errors:0 dropped:0 overruns:0 frame:0=0A     =
     TX packets:21 errors:0 dropped:0 overruns:0 carrier:0=0A          co=
llisions:0 txqueuelen:1000=0A          RX bytes:0 (0.0 B)  TX bytes:882 (=
882.0 B)=0A          Memory:fe4e4000-fe4e4fff=0A=0Alo        Link encap:L=
ocal Loopback=0A          inet addr:127.0.0.1  Mask:255.0.0.0=0A         =
 UP LOOPBACK RUNNING  MTU:65536  Metric:1=0A          RX packets:37 error=
s:0 dropped:0 overruns:0 frame:0=0A          TX packets:37 errors:0 dropp=
ed:0 overruns:0 carrier:0=0A          collisions:0 txqueuelen:1000=0A    =
      RX bytes:3720 (3.6 KiB)  TX bytes:3720 (3.6 KiB)=0A=0A# ping 192.16=
8.0.24=0APING 192.168.0.24 (192.168.0.24): 56 data bytes=0A^C=0A--- 192.1=
68.0.24 ping statistics ---=0A2 packets transmitted, 0 packets received, =
100% packet loss=0A# ifconfig=0Aeth0      Link encap:Ethernet  HWaddr 00:=
11:22:33:44:55=0A          inet addr:192.168.0.211  Bcast:192.168.0.255  =
Mask:255.255.255.0=0A          UP BROADCAST RUNNING MULTICAST  MTU:1500  =
Metric:1=0A          RX packets:0 errors:0 dropped:0 overruns:0 frame:0=
=0A          TX packets:24 errors:0 dropped:0 overruns:0 carrier:0=0A    =
      collisions:0 txqueuelen:1000=0A          RX bytes:0 (0.0 B)  TX byt=
es:1008 (1008.0 B)=0A          Memory:fe4e4000-fe4e4fff=0A=0Alo        Li=
nk encap:Local Loopback=0A          inet addr:127.0.0.1  Mask:255.0.0.0=
=0A          UP LOOPBACK RUNNING  MTU:65536  Metric:1=0A          RX pack=
ets:37 errors:0 dropped:0 overruns:0 frame:0=0A          TX packets:37 er=
rors:0 dropped:0 overruns:0 carrier:0=0A          collisions:0 txqueuelen=
:1000=0A          RX bytes:3720 (3.6 KiB)  TX bytes:3720 (3.6 KiB)=0A=09#=
 ethtool eth0=0ASettings for eth0:=0A        Supported ports: [ MII ]=0A =
       Supported link modes:   10baseT/Half 10baseT/Full=0A              =
                  100baseT/Half 100baseT/Full=0A                         =
       1000baseT/Full=0A        Supported pause frame use: Symmetric Rece=
ive-only=0A        Supports auto-negotiation: Yes=0A        Supported FEC=
 modes: Not reported=0A        Advertised link modes:  10baseT/Half 10bas=
eT/Full=0A                                100baseT/Half 100baseT/Full=0A =
                               1000baseT/Full=0A        Advertised pause =
frame use: Symmetric Receive-only=0A        Advertised auto-negotiation: =
Yes=0A        Advertised FEC modes: Not reported=0A        Link partner a=
dvertised link modes:  10baseT/Half 10baseT/Full=0A                      =
                       100baseT/Half 100baseT/Full=0A        Link partner=
 advertised pause frame use: Symmetric=0A        Link partner advertised =
auto-negotiation: Yes=0A        Link partner advertised FEC modes: Not re=
ported=0A        Speed: 100Mb/s=0A        Duplex: Full=0A        Port: Tw=
isted Pair=0A        PHYAD: 0=0A        Transceiver: internal=0A        A=
uto-negotiation: on=0A        MDI-X: Unknown=0A        Current message le=
vel: 0x00002037 (8247)=0A                               drv probe link if=
down ifup hw=0A        Link detected: yes=0A=09Regards=0A=0ASupriyo Gangu=
ly=0AManager - Technical, R&D-II=0AELECTRONICS CORPORATION OF INDIA LIMIT=
ED=0AHYDERABAD - 500062=0AContact -  040-27186369

***************************************
THIS MAIL HAS BEEN SCANNED BY ECIL IMSVA.
***************************************

------=_Part_853_982481662.1763466276
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><meta http-equiv=3D"Content-Type" content=3D"t=
ext/html; charset=3Dutf-8" /></head><body><div data-crea=3D"font-wrapper"=
 style=3D"font-family: Tahoma, sans-serif; font-size: 16px; direction: lt=
r"><div>Sir,</div><div><br></div><div><p data-start=3D"743" data-end=3D"7=
51">Please find the following configuration.<br></p>=0A<ul data-start=3D"=
754" data-end=3D"953"><li data-start=3D"754" data-end=3D"789">=0A<p data-=
start=3D"756" data-end=3D"789">Kernel version (e.g., <code data-start=3D"=
778" data-end=3D"788">5.10.131</code>)</p>=0A</li><li data-start=3D"792" =
data-end=3D"814">=0A<p data-start=3D"794" data-end=3D"814">SoC/platform (=
T1014)</p>=0A</li><li data-start=3D"817" data-end=3D"858">=0A<p data-star=
t=3D"819" data-end=3D"858">Symptom (TX =E2=80=9Csent=E2=80=9D but nothing=
 on wire)</p></li></ul></div>I am seeing increment in ifconfig but nothin=
g sent or received physically on line.<br>I am attaching the dts file for=
 reference.<br>Please help me to solve it.<br><div><div data-crea=3D"font=
-wrapper" style=3D"font-family: Tahoma, sans-serif; font-size: 16px; dire=
ction: ltr"><p><br><br># ifconfig<br>eth0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L=
ink encap:Ethernet=C2=A0 HWaddr 00:11:22:33:44:55<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet addr:192.168.0.211=C2=A0 Bcast:=
192.168.0.255=C2=A0 Mask:255.255.255.0<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 UP BROADCAST RUNNING MULTICAST=C2=A0 MTU:1500=C2=
=A0 Metric:1<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX=
 packets:0 errors:0 dropped:0 overruns:0 frame:0<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX packets:21 errors:0 dropped:0 overru=
ns:0 carrier:0<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
collisions:0 txqueuelen:1000<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RX bytes:0 (0.0 B)=C2=A0 TX bytes:882 (882.0 B)<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory:fe4e4000-fe4e4fff=
<br><br>lo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Link encap:Local Loo=
pback<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet addr=
:127.0.0.1=C2=A0 Mask:255.0.0.0<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 UP LOOPBACK RUNNING=C2=A0 MTU:65536=C2=A0 Metric:1<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX packets:37 erro=
rs:0 dropped:0 overruns:0 frame:0<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 TX packets:37 errors:0 dropped:0 overruns:0 carrier:0<=
br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 collisions:0 tx=
queuelen:1000<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 R=
X bytes:3720 (3.6 KiB)=C2=A0 TX bytes:3720 (3.6 KiB)<br><br># ping 192.16=
8.0.24<br>PING 192.168.0.24 (192.168.0.24): 56 data bytes<br>^C<br>--- 19=
2.168.0.24 ping statistics ---<br>2 packets transmitted, 0 packets receiv=
ed, 100% packet loss<br># ifconfig<br>eth0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Link encap:Ethernet=C2=A0 HWaddr 00:11:22:33:44:55<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet addr:192.168.0.211=C2=A0 Bcast:=
192.168.0.255=C2=A0 Mask:255.255.255.0<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 UP BROADCAST RUNNING MULTICAST=C2=A0 MTU:1500=C2=
=A0 Metric:1<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX=
 packets:0 errors:0 dropped:0 overruns:0 frame:0<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX packets:24 errors:0 dropped:0 overru=
ns:0 carrier:0<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
collisions:0 txqueuelen:1000<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RX bytes:0 (0.0 B)=C2=A0 TX bytes:1008 (1008.0 B)<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory:fe4e4000-fe4e4=
fff<br><br>lo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Link encap:Local =
Loopback<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet a=
ddr:127.0.0.1=C2=A0 Mask:255.0.0.0<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 UP LOOPBACK RUNNING=C2=A0 MTU:65536=C2=A0 Metric:1<=
br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX packets:37 e=
rrors:0 dropped:0 overruns:0 frame:0<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 TX packets:37 errors:0 dropped:0 overruns:0 carrier=
:0<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 collisions:0=
 txqueuelen:1000<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 RX bytes:3720 (3.6 KiB)=C2=A0 TX bytes:3720 (3.6 KiB)<br></p><p><br><=
/p><p><br></p><p># ethtool eth0<br>Settings for eth0:<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Supported ports: [ MII ]<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Supported link modes:=C2=A0=C2=A0 10baseT/Hal=
f 10baseT/Full<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100baseT/Hal=
f 100baseT/Full<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1000baseT/Fu=
ll<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Supported pause frame us=
e: Symmetric Receive-only<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S=
upports auto-negotiation: Yes<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Supported FEC modes: Not reported<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Advertised link modes:=C2=A0 10baseT/Half 10baseT/Full<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100baseT/Half 100baseT/Full<br=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1000baseT/Full<br>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Advertised pause frame use: Symmetric Rece=
ive-only<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Advertised auto-ne=
gotiation: Yes<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Advertised F=
EC modes: Not reported<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Link=
 partner advertised link modes:=C2=A0 10baseT/Half 10baseT/Full<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100baseT/Half 100baseT/Full<br=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Link partner advertised pause=
 frame use: Symmetric<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Link =
partner advertised auto-negotiation: Yes<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Link partner advertised FEC modes: Not reported<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Speed: 100Mb/s<br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Duplex: Full<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Port: Twisted Pair<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 PHYAD: 0<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Transceiver=
: internal<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Auto-negotiation=
: on<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MDI-X: Unknown<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Current message level: 0x00002037=
 (8247)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drv probe link ifdown if=
up hw<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Link detected: yes</p=
><p><font color=3D"#ff00ff"><span style=3D"font-size:14px"><span style=3D=
"font-family:georgia,serif;"><i><br></i></span></span></font></p><p><font=
 color=3D"#ff00ff"><span style=3D"font-size:14px"><span style=3D"font-fam=
ily:georgia,serif;"><i><br></i></span></span></font></p><p><font color=3D=
"#ff00ff"><span style=3D"font-size:14px"><span style=3D"font-family:georg=
ia,serif;"><i>Regards</i></span></span></font><font color=3D"#990000"><sp=
an style=3D"font-size:14px"><br><font face=3D"Century Gothic"><br></font>=
</span><font face=3D"Georgia"><span style=3D"font-size:14px"><b>Supriyo G=
anguly</b></span></font></font><span style=3D"color:#0000FF;"><span style=
=3D"font-size:14px"><font face=3D"Comic Sans MS"><br></font><font face=3D=
"Georgia">Manager - Technical, R&amp;D-II<br>ELECTRONICS CORPORATION OF I=
NDIA LIMITED<br>HYDERABAD - 500062<br>Contact -=C2=A0 040-27186369</font>=
</span></span></p><div></div></div></div><br></div></body></html>

<table width=3D100%><tr><td bgcolor=3D#ffffff><font color=3D#000000><pre>=
***************************************
THIS MAIL HAS BEEN SCANNED BY ECIL IMSVA.
***************************************</pre></font></td></tr></table>

------=_Part_853_982481662.1763466276--

------=_Part_786_943611846.1763466276
Content-Type: application/octet-stream; name="ecs3500.dts"
Content-Disposition: attachment; filename="ecs3500.dts"
Content-Transfer-Encoding: base64

LyoKICogVDEwMjQgUkRCIERldmljZSBUcmVlIFNvdXJjZQogKgogKiBDb3B5cmlnaHQgMjAx
NCBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciBJbmMuCiAqCiAqIFJlZGlzdHJpYnV0aW9uIGFu
ZCB1c2UgaW4gc291cmNlIGFuZCBiaW5hcnkgZm9ybXMsIHdpdGggb3Igd2l0aG91dAogKiBt
b2RpZmljYXRpb24sIGFyZSBwZXJtaXR0ZWQgcHJvdmlkZWQgdGhhdCB0aGUgZm9sbG93aW5n
IGNvbmRpdGlvbnMgYXJlIG1ldDoKICogICAgICogUmVkaXN0cmlidXRpb25zIG9mIHNvdXJj
ZSBjb2RlIG11c3QgcmV0YWluIHRoZSBhYm92ZSBjb3B5cmlnaHQKICoJIG5vdGljZSwgdGhp
cyBsaXN0IG9mIGNvbmRpdGlvbnMgYW5kIHRoZSBmb2xsb3dpbmcgZGlzY2xhaW1lci4KICog
ICAgICogUmVkaXN0cmlidXRpb25zIGluIGJpbmFyeSBmb3JtIG11c3QgcmVwcm9kdWNlIHRo
ZSBhYm92ZSBjb3B5cmlnaHQKICoJIG5vdGljZSwgdGhpcyBsaXN0IG9mIGNvbmRpdGlvbnMg
YW5kIHRoZSBmb2xsb3dpbmcgZGlzY2xhaW1lciBpbiB0aGUKICoJIGRvY3VtZW50YXRpb24g
YW5kL29yIG90aGVyIG1hdGVyaWFscyBwcm92aWRlZCB3aXRoIHRoZSBkaXN0cmlidXRpb24u
CiAqICAgICAqIE5laXRoZXIgdGhlIG5hbWUgb2YgRnJlZXNjYWxlIFNlbWljb25kdWN0b3Ig
bm9yIHRoZQogKgkgbmFtZXMgb2YgaXRzIGNvbnRyaWJ1dG9ycyBtYXkgYmUgdXNlZCB0byBl
bmRvcnNlIG9yIHByb21vdGUgcHJvZHVjdHMKICoJIGRlcml2ZWQgZnJvbSB0aGlzIHNvZnR3
YXJlIHdpdGhvdXQgc3BlY2lmaWMgcHJpb3Igd3JpdHRlbiBwZXJtaXNzaW9uLgogKgogKgog
KiBBTFRFUk5BVElWRUxZLCB0aGlzIHNvZnR3YXJlIG1heSBiZSBkaXN0cmlidXRlZCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlCiAqIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlICgiR1BM
IikgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlCiAqIEZvdW5kYXRpb24sIGVp
dGhlciB2ZXJzaW9uIDIgb2YgdGhhdCBMaWNlbnNlIG9yIChhdCB5b3VyIG9wdGlvbikgYW55
CiAqIGxhdGVyIHZlcnNpb24uCiAqCiAqIFRISVMgU09GVFdBUkUgSVMgUFJPVklERUQgQlkg
RnJlZXNjYWxlIFNlbWljb25kdWN0b3IgIkFTIElTIiBBTkQgQU5ZCiAqIEVYUFJFU1MgT1Ig
SU1QTElFRCBXQVJSQU5USUVTLCBJTkNMVURJTkcsIEJVVCBOT1QgTElNSVRFRCBUTywgVEhF
IElNUExJRUQKICogV0FSUkFOVElFUyBPRiBNRVJDSEFOVEFCSUxJVFkgQU5EIEZJVE5FU1Mg
Rk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFSRQogKiBESVNDTEFJTUVELiBJTiBOTyBFVkVO
VCBTSEFMTCBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciBCRSBMSUFCTEUgRk9SIEFOWQogKiBE
SVJFQ1QsIElORElSRUNULCBJTkNJREVOVEFMLCBTUEVDSUFMLCBFWEVNUExBUlksIE9SIENP
TlNFUVVFTlRJQUwgREFNQUdFUwogKiAoSU5DTFVESU5HLCBCVVQgTk9UIExJTUlURUQgVE8s
IFBST0NVUkVNRU5UIE9GIFNVQlNUSVRVVEUgR09PRFMgT1IgU0VSVklDRVM7CiAqIExPU1Mg
T0YgVVNFLCBEQVRBLCBPUiBQUk9GSVRTOyBPUiBCVVNJTkVTUyBJTlRFUlJVUFRJT04pIEhP
V0VWRVIgQ0FVU0VEIEFORAogKiBPTiBBTlkgVEhFT1JZIE9GIExJQUJJTElUWSwgV0hFVEhF
UiBJTiBDT05UUkFDVCwgU1RSSUNUIExJQUJJTElUWSwgT1IgVE9SVAogKiAoSU5DTFVESU5H
IE5FR0xJR0VOQ0UgT1IgT1RIRVJXSVNFKSBBUklTSU5HIElOIEFOWSBXQVkgT1VUIE9GIFRI
RSBVU0UgT0YgVEhJUwogKiBTT0ZUV0FSRSwgRVZFTiBJRiBBRFZJU0VEIE9GIFRIRSBQT1NT
SUJJTElUWSBPRiBTVUNIIERBTUFHRS4KICovCgovaW5jbHVkZS8gInQxMDJ4c2ktcHJlLmR0
c2kiCgovIHsKCW1vZGVsID0gIkVDUzM1MDAiOwoJY29tcGF0aWJsZSA9ICJmc2wsVDEwMjRS
REIiOwoJI2FkZHJlc3MtY2VsbHMgPSA8Mj47Cgkjc2l6ZS1jZWxscyA9IDwyPjsKCWludGVy
cnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoKCglyZXNlcnZlZC1tZW1vcnkgewoJCSNhZGRyZXNz
LWNlbGxzID0gPDI+OwoJCSNzaXplLWNlbGxzID0gPDI+OwoJCXJhbmdlczsKCgkJYm1hbl9m
YnByOiBibWFuLWZicHIgewoJCQlzaXplID0gPDAgMHgxMDAwMDAwPjsKCQkJYWxpZ25tZW50
ID0gPDAgMHgxMDAwMDAwPjsKCQl9OwoKCQlxbWFuX2ZxZDogcW1hbi1mcWQgewoJCQlzaXpl
ID0gPDAgMHg0MDAwMDA+OwoJCQlhbGlnbm1lbnQgPSA8MCAweDQwMDAwMD47CgkJfTsKCgkJ
cW1hbl9wZmRyOiBxbWFuLXBmZHIgewoJCQlzaXplID0gPDAgMHgyMDAwMDAwPjsKCQkJYWxp
Z25tZW50ID0gPDAgMHgyMDAwMDAwPjsKCQl9OwoJfTsKCglpZmM6IGxvY2FsYnVzQGZmZTEy
NDAwMCB7CgkJcmVnID0gPDB4ZiAweGZlMTI0MDAwIDAgMHgyMDAwPjsKCQlyYW5nZXMgPSA8
MCAwIDB4ZiAweGU4MDAwMDAwIDB4MDgwMDAwMDA+OwoKCQlub3JAMCwwIHsKCQkJI2FkZHJl
c3MtY2VsbHMgPSA8MT47CgkJCSNzaXplLWNlbGxzID0gPDE+OwoJCQljb21wYXRpYmxlID0g
ImNmaS1mbGFzaCI7CgkJCXJlZyA9IDwweDAgMHgwIDB4ODAwMDAwMD47CgkJCWJhbmstd2lk
dGggPSA8Mj47CgkJCWRldmljZS13aWR0aCA9IDwxPjsKCQl9OwoJfTsKCgltZW1vcnkgewoJ
CWRldmljZV90eXBlID0gIm1lbW9yeSI7Cgl9OwoKCWRjc3I6IGRjc3JAZjAwMDAwMDAwIHsK
CQlyYW5nZXMgPSA8MHgwMDAwMDAwMCAweGYgMHgwMDAwMDAwMCAweDAxMDcyMDAwPjsKCX07
CgoJYnBvcnRhbHM6IGJtYW4tcG9ydGFsc0BmZjQwMDAwMDAgewoJCXJhbmdlcyA9IDwweDAg
MHhmIDB4ZjQwMDAwMDAgMHgyMDAwMDAwPjsKCX07CgoJcXBvcnRhbHM6IHFtYW4tcG9ydGFs
c0BmZjYwMDAwMDAgewoJCXJhbmdlcyA9IDwweDAgMHhmIDB4ZjYwMDAwMDAgMHgyMDAwMDAw
PjsKCX07CgoJc29jOiBzb2NAZmZlMDAwMDAwIHsKCQlyYW5nZXMgPSA8MHgwMDAwMDAwMCAw
eGYgMHhmZTAwMDAwMCAweDEwMDAwMDA+OwoJCXJlZyA9IDwweGYgMHhmZTAwMDAwMCAwIDB4
MDAwMDEwMDA+OwoJCQoJCWZtYW5ANDAwMDAwIHsKCQkJZm0xbWFjMTogZXRoZXJuZXRAZTAw
MDAgewoJCQkJCgkJCX07CgoJCQlmbTFtYWMyOiBldGhlcm5ldEBlMjAwMCB7CgkJCQkKCQkJ
fTsKCgkJCWZtMW1hYzM6IGV0aGVybmV0QGU0MDAwIHsKCQkJCXBoeS1oYW5kbGUgPSA8JnJn
bWlpX3BoeTE+OwoJCQkJcGh5LWNvbm5lY3Rpb24tdHlwZSA9ICJyZ21paSI7CgkJCQltYWMt
YWRkcmVzcyA9IFswMCAxMSAyMiAzMyA0NCA1NV07ICAvLyBSZXBsYWNlIHdpdGggYWN0dWFs
IE1BQyBhZGRyZXNzCgkJCX07CgoJCQlmbTFtYWM0OiBldGhlcm5ldEBlNjAwMCB7CgkJCQlw
aHktaGFuZGxlID0gPCZyZ21paV9waHkyPjsKCQkJCXBoeS1jb25uZWN0aW9uLXR5cGUgPSAi
cmdtaWkiOwoJCQkJbWFjLWFkZHJlc3MgPSBbNjYgNzcgODggOTkgYWEgYmJdOyAKCQkJfTsK
CgoJCQltZGlvMDogbWRpb0BmYzAwMCB7CiAgICAgICAgICAgICAgICByZ21paV9waHkxOiBl
dGhlcm5ldC1waHlAMCB7CiAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MD47CiAgICAg
ICAgICAgICAgICB9OwogICAgICAgICAgICAgICAgcmdtaWlfcGh5MjogZXRoZXJuZXQtcGh5
QDEgewogICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDE+OwogICAgICAgICAgICAgICAg
fTsKICAgICAgICAgICAgfTsKCQl9OwoJfTsKCglwY2kwOiBwY2llQGZmZTI0MDAwMCB7CgkJ
cmVnID0gPDB4ZiAweGZlMjQwMDAwIDAgMHgxMDAwMD47CgkJcmFuZ2VzID0gPDB4MDIwMDAw
MDAgMCAweGUwMDAwMDAwIDB4YyAweDAwMDAwMDAwIDAgMHgxMDAwMDAwMAoJCQkgIDB4MDEw
MDAwMDAgMCAweDAwMDAwMDAwIDB4ZiAweGY4MDAwMDAwIDAgMHgwMDAxMDAwMD47CgkJcGNp
ZUAwIHsKCQkJcmFuZ2VzID0gPDB4MDIwMDAwMDAgMCAweGUwMDAwMDAwCgkJCQkgIDB4MDIw
MDAwMDAgMCAweGUwMDAwMDAwCgkJCQkgIDAgMHgxMDAwMDAwMAoKCQkJCSAgMHgwMTAwMDAw
MCAwIDB4MDAwMDAwMDAKCQkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAKCQkJCSAgMCAw
eDAwMDEwMDAwPjsKCQl9OwoJfTsKCglwY2kxOiBwY2llQGZmZTI1MDAwMCB7CgkJcmVnID0g
PDB4ZiAweGZlMjUwMDAwIDAgMHgxMDAwMD47CgkJcmFuZ2VzID0gPDB4MDIwMDAwMDAgMCAw
eGUwMDAwMDAwIDB4YyAweDEwMDAwMDAwIDAgMHgxMDAwMDAwMAoJCQkgIDB4MDEwMDAwMDAg
MCAweDAwMDAwMDAwIDB4ZiAweGY4MDEwMDAwIDAgMHgwMDAxMDAwMD47CgkJcGNpZUAwIHsK
CQkJcmFuZ2VzID0gPDB4MDIwMDAwMDAgMCAweGUwMDAwMDAwCgkJCQkgIDB4MDIwMDAwMDAg
MCAweGUwMDAwMDAwCgkJCQkgIDAgMHgxMDAwMDAwMAoKCQkJCSAgMHgwMTAwMDAwMCAwIDB4
MDAwMDAwMDAKCQkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAKCQkJCSAgMCAweDAwMDEw
MDAwPjsKCQl9OwoJfTsKCglwY2kyOiBwY2llQGZmZTI2MDAwMCB7CgkJcmVnID0gPDB4ZiAw
eGZlMjYwMDAwIDAgMHgxMDAwMD47CgkJcmFuZ2VzID0gPDB4MDIwMDAwMDAgMCAweGUwMDAw
MDAwIDB4YyAweDIwMDAwMDAwIDAgMHgxMDAwMDAwMAoJCQkgIDB4MDEwMDAwMDAgMCAweDAw
MDAwMDAwIDB4ZiAweGY4MDIwMDAwIDAgMHgwMDAxMDAwMD47CgkJcGNpZUAwIHsKCQkJcmFu
Z2VzID0gPDB4MDIwMDAwMDAgMCAweGUwMDAwMDAwCgkJCQkgIDB4MDIwMDAwMDAgMCAweGUw
MDAwMDAwCgkJCQkgIDAgMHgxMDAwMDAwMAoKCQkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAw
MDAKCQkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAKCQkJCSAgMCAweDAwMDEwMDAwPjsK
CQl9OwoJfTsKfTsKCiNpbmNsdWRlICJ0MTAyNHNpLXBvc3QuZHRzaSIK

------=_Part_786_943611846.1763466276--


