Return-Path: <netdev+bounces-38785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2687BC745
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 13:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB82821BD
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664471A5A7;
	Sat,  7 Oct 2023 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=safebits.tech header.i=@safebits.tech header.b="JiKeRER2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F087199C3
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 11:48:23 +0000 (UTC)
X-Greylist: delayed 514 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Oct 2023 04:48:21 PDT
Received: from thor.cnix.ro (thor.cnix.ro [IPv6:2a02:c205:2011:3247::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C38CB6
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 04:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=safebits.tech;
	s=thor; t=1696678784;
	bh=HrkNLqrmpju0NvGshPfIPdBaFSFqyfTH4KPWG+bddzA=;
	h=From:Date:Subject:Cc:To:From;
	b=JiKeRER2l2CFqEPJshQNfagSdFknTlw5PR+TEMRTJimwY62CsAJIXj6HK7SPYtnI7
	 kxqPMGvTj47RMNyuIDhE0EY17d0G/olg8+Ek21MMpo1JUVbtFrKuBS7BrboIvqM4fZ
	 TFFvgKo0lPPHUGF2DLYrZdb13K5K7AHbMHrTfE+U=
Received: from localhost (localhost [127.0.0.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: luci@safebits.tech)
	by thor.cnix.ro (Postfix) with ESMTPSA id AF133557E0;
	Sat,  7 Oct 2023 14:39:44 +0300 (EEST)
From: Luci Stanescu <luci@safebits.tech>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_F57F5930-E3C7-4BE6-A67B-52D64919E13B";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Date: Sat, 7 Oct 2023 14:39:31 +0300
Subject: IPv6 recvmsg() wrong scope for source address when using VRFs
Cc: netdev@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>
Message-Id: <06798029-660D-454E-8628-3A9B9E1AF6F8@safebits.tech>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--Apple-Mail=_F57F5930-E3C7-4BE6-A67B-52D64919E13B
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_E68AA811-F6B4-4F3B-AC8E-7CB2C4428A06"


--Apple-Mail=_E68AA811-F6B4-4F3B-AC8E-7CB2C4428A06
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

I've discovered that the wrong sin6_scope_id is filled in by recvmsg() =
in msg_name when using VRFs. Specifically, the scope contains the index =
of the VRF interface, instead of the slave on which the packet was =
received. This scope is unfortunately useless if link-local addressing =
is used. The context in which I discovered this issue is using non-local =
communication with UDP sockets and multicast (specifically having a =
DHCPv6 server on an interface enslaved to a VRF), but I believe the =
issue may be applicable to other transports and it certainly applies to =
unicast, which I've used to reproduce the issue in a simpler way.

Here's how to reproduce. I'm going to exemplify using Python and local =
communication with veth devices for brevity. I'm using Ubuntu 22.04 LTS, =
with kernel 6.2.0-34, but I've tracked this down in the source code in =
the master branch (further down), so please bear with me. I'm going to =
call my VRF interface "myvrf". I'm going to create a veth pair and =
enslave one end to the VRF.

ip link add myvrf type vrf table 42
ip link set myvrf up
ip link add veth1 type veth peer name veth2
ip link set veth1 master myvrf up
ip link set veth2 up

# ip link sh dev myvrf
110: myvrf: <NOARP,MASTER,UP,LOWER_UP> mtu 65575 qdisc noqueue state UP =
mode DEFAULT group default qlen 1000
    link/ether da:ca:c9:2b:6e:02 brd ff:ff:ff:ff:ff:ff
# ip addr sh dev veth1
112: veth1@veth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc =
noqueue master myvrf state UP group default qlen 1000
    link/ether 32:63:cf:f5:08:35 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::3063:cfff:fef5:835/64 scope link
       valid_lft forever preferred_lft forever
# ip addr sh dev veth2
111: veth2@veth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc =
noqueue state UP group default qlen 1000
    link/ether 1a:8f:5a:85:3c:c0 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::188f:5aff:fe85:3cc0/64 scope link
       valid_lft forever preferred_lft forever

The receiver:
import socket
import struct

s =3D socket.socket(socket.AF_INET6, socket.SOCK_DGRAM, =
socket.IPPROTO_UDP)
s.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_RECVPKTINFO, 1)
s.setsockopt(socket.SOL_SOCKET, socket.SO_BINDTODEVICE, b'myvrf')
s.bind(('', 2000, 0, 0))

while True:
    data, cmsg_list, flags, source =3D s.recvmsg(4096, 4096)
    for level, type, cmsg_data in cmsg_list:
        if level =3D=3D socket.IPPROTO_IPV6 and type =3D=3D =
socket.IPV6_PKTINFO:
            source_address, source_scope =3D struct.unpack('@16sI', =
cmsg_data)
            source_address =3D socket.inet_ntop(socket.AF_INET6, =
source_address)
            print("PKTINFO destination {} {}".format(source_address, =
source_scope))
    source_address, source_port, source_flow, source_scope =3D source
    print("name source {} {}".format(source_address, source_scope))

The same thing happens, as expected, if sysctl =
net.ipv4.udp_l3mdev_accept is set to 1 and the receiver doesn't bind the =
socket to the VRF master device. The sender is going to use the =
link-local address of veth1 to address the packet on veth2 (scope 111):

import socket

s =3D socket.socket(socket.AF_INET6, socket.SOCK_DGRAM, =
socket.IPPROTO_UDP)
dest =3D ('fe80::3063:cfff:fef5:835', 2000, 0, 111)
s.sendto(b'foo', dest)

Please note that the destination address is the veth1 link-local address =
and the scope is the veth2 interface index. The receiver will print =
this:
PKTINFO destination fe80::3063:cfff:fef5:835 112
name source fe80::188f:5aff:fe85:3cc0 110

Please note that the scope of the destination (from IPV6_PKTINFO) is, =
correctly, the interface index of the receiving interface, veth1. =
However, the scope of the source in the msg_name is the interface index =
of the VRF master device. Unfortunately, for link-local addressing, the =
scope of the VRF master device is useless. In my original problem, a =
DHCPv6 server wouldn't be able to send a response packet to the =
link-local address. While an application could certainly use =
IPV6_PKTINFO to work around this problem, I believe it feels like a bit =
of a hack.

I've tracked this down in the source code to the following (please bear =
with my explanations, as I've not really familiar with the code):

First, in 2014, the scope of was changed from IP6CB(skb)->iif to =
inet6_iif(skb) in commit =
https://github.com/torvalds/linux/commit/4330487acfff0cf1d7b14d238583a182e=
0a444bb. At the time, that function from include/linux/ipv6.h simply =
returned P6CB(skb)->iif, so that was a bit of a NOOP.

Then, in 2016, inet6_iif was changed to return the VRF master if =
P6CB(skb)->iif was enslaved to a VRF in this commit:
=
https://github.com/torvalds/linux/commit/74b20582ac389ee9f18a6fcc0eef24465=
8ce8de0. Now, that also made sense because at the time you couldn't =
connect() or sendmsg() over a VRF by specifying a VRF slave interface =
index as a destination, you had to specify the VRF master interface =
index in the scope. Using link-local addresses of VRF enslaved devices =
at this point in time would've been impossible anyway.

But then, in 2018, a series of patches allowed things like connect() and =
sendmsg() to specify the index of a VRF slave interface, thus allowing =
link-local addresses to be used. For example:
=
https://github.com/torvalds/linux/commit/54dc3e3324829d346c959ff774626d9c6=
c9a65b5
=
https://github.com/torvalds/linux/commit/6da5b0f027a825df2aebc1927a27bda18=
5dc03d4

I do not know enough about the code to understand whether after those =
patches in 2018 inet6_iif() could be changed to return the VRF slave =
device instead of the master or whether recvmsg() should not longer use =
inet6_iif(), but I do believe the scope returned by recvmsg() is a bug.

Thank you for your time!

--=20
Luci Stanescu

--Apple-Mail=_E68AA811-F6B4-4F3B-AC8E-7CB2C4428A06
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><div>Hi,</div><div><br></div><div>I've discovered =
that the wrong sin6_scope_id is filled in by recvmsg() in msg_name when =
using VRFs. Specifically, the scope contains the index of the VRF =
interface, instead of the slave on which the packet was received. This =
scope is unfortunately useless if link-local addressing is used. The =
context in which I discovered this issue is using non-local =
communication with UDP sockets and multicast (specifically having a =
DHCPv6 server on an interface enslaved to a VRF), but I believe the =
issue may be applicable to other transports and it certainly applies to =
unicast, which I've used to reproduce the issue in a simpler =
way.</div><div><br></div><div>Here's how to reproduce. I'm going to =
exemplify using Python and local communication with veth devices for =
brevity. I'm using Ubuntu 22.04 LTS, with kernel 6.2.0-34, but I've =
tracked this down in the source code in the master branch (further =
down), so please bear with me. I'm going to call my VRF interface =
"myvrf". I'm going to create a veth pair and enslave one end to the =
VRF.</div><div><br></div><div>ip link add myvrf type vrf table =
42</div><div>ip link set myvrf up</div><div>ip link add veth1 type veth =
peer name veth2</div><div>ip link set veth1 master myvrf up</div><div>ip =
link set veth2 up</div><div><br></div><div><div><div># ip link sh dev =
myvrf</div><div>110: myvrf: &lt;NOARP,MASTER,UP,LOWER_UP&gt; mtu 65575 =
qdisc noqueue state UP mode DEFAULT group default qlen =
1000</div><div>&nbsp; &nbsp; link/ether da:ca:c9:2b:6e:02 brd =
ff:ff:ff:ff:ff:ff</div></div></div><div><div># ip addr sh dev =
veth1</div><div>112: veth1@veth2: =
&lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc noqueue master =
myvrf state UP group default qlen 1000</div><div>&nbsp; &nbsp; =
link/ether 32:63:cf:f5:08:35 brd ff:ff:ff:ff:ff:ff</div><div>&nbsp; =
&nbsp; inet6 fe80::3063:cfff:fef5:835/64 scope link</div><div>&nbsp; =
&nbsp; &nbsp; &nbsp;valid_lft forever preferred_lft forever</div><div># =
ip addr sh dev veth2</div><div>111: veth2@veth1: =
&lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc noqueue state UP =
group default qlen 1000</div><div>&nbsp; &nbsp; link/ether =
1a:8f:5a:85:3c:c0 brd ff:ff:ff:ff:ff:ff</div><div>&nbsp; &nbsp; inet6 =
fe80::188f:5aff:fe85:3cc0/64 scope link</div><div>&nbsp; &nbsp; &nbsp; =
&nbsp;valid_lft forever preferred_lft =
forever</div><div><br></div></div><div>The =
receiver:</div><div><div>import socket</div><div>import =
struct</div><div><br></div><div>s =3D socket.socket(socket.AF_INET6, =
socket.SOCK_DGRAM, =
socket.IPPROTO_UDP)</div><div>s.setsockopt(socket.IPPROTO_IPV6, =
socket.IPV6_RECVPKTINFO, 1)</div><div>s.setsockopt(socket.SOL_SOCKET, =
socket.SO_BINDTODEVICE, b'myvrf')</div><div>s.bind(('', 2000, 0, =
0))</div><div><br></div><div>while True:</div><div>&nbsp; &nbsp; data, =
cmsg_list, flags, source =3D s.recvmsg(4096, 4096)</div><div>&nbsp; =
&nbsp; for level, type, cmsg_data in cmsg_list:</div><div>&nbsp; &nbsp; =
&nbsp; &nbsp; if level =3D=3D socket.IPPROTO_IPV6 and type =3D=3D =
socket.IPV6_PKTINFO:</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
source_address, source_scope =3D struct.unpack('@16sI', =
cmsg_data)</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
source_address =3D socket.inet_ntop(socket.AF_INET6, =
source_address)</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
print("PKTINFO destination {} {}".format(source_address, =
source_scope))</div><div>&nbsp; &nbsp; source_address, source_port, =
source_flow, source_scope =3D source</div><div>&nbsp; &nbsp; print("name =
source {} {}".format(source_address, =
source_scope))</div></div><div><br></div><div>The same thing happens, as =
expected, if sysctl net.ipv4.udp_l3mdev_accept is set to 1 and the =
receiver doesn't bind the socket to the VRF master device. The sender is =
going to use the link-local address of veth1 to address the packet on =
veth2 (scope 111):</div><div><br></div><div><div>import =
socket</div><div><br></div><div>s =3D socket.socket(socket.AF_INET6, =
socket.SOCK_DGRAM, socket.IPPROTO_UDP)</div><div>dest =3D =
('fe80::3063:cfff:fef5:835', 2000, 0, 111)</div><div>s.sendto(b'foo', =
dest)</div></div><div><br></div><div>Please note that the destination =
address is the veth1 link-local address and the scope is the veth2 =
interface index. The receiver will print this:</div><div><div>PKTINFO =
destination fe80::3063:cfff:fef5:835 112</div><div>name source =
fe80::188f:5aff:fe85:3cc0 110</div></div><div><br></div><div>Please note =
that the scope of the destination (from IPV6_PKTINFO) is, correctly, the =
interface index of the receiving interface, veth1. However, the scope of =
the source in the msg_name is the interface index of the VRF master =
device. Unfortunately, for link-local addressing, the scope of the VRF =
master device is useless. In my original problem, a DHCPv6 server =
wouldn't be able to send a response packet to the link-local address. =
While an application could certainly use IPV6_PKTINFO to work around =
this problem, I believe it feels like a bit of a =
hack.</div><div><br></div><div>I've tracked this down in the source code =
to the following (please bear with my explanations, as I've not really =
familiar with the code):</div><div><br></div><div>First, in 2014, the =
scope of was changed from&nbsp;IP6CB(skb)-&gt;iif to&nbsp;inet6_iif(skb) =
in commit&nbsp;<a =
href=3D"https://github.com/torvalds/linux/commit/4330487acfff0cf1d7b14d238=
583a182e0a444bb">https://github.com/torvalds/linux/commit/4330487acfff0cf1=
d7b14d238583a182e0a444bb</a>. At the time, that function from =
include/linux/ipv6.h simply returned P6CB(skb)-&gt;iif, so that was a =
bit of a NOOP.</div><div><br></div><div>Then, in 2016, inet6_iif was =
changed to return the VRF master if P6CB(skb)-&gt;iif was enslaved to a =
VRF in this commit:</div><div><a =
href=3D"https://github.com/torvalds/linux/commit/74b20582ac389ee9f18a6fcc0=
eef244658ce8de0">https://github.com/torvalds/linux/commit/74b20582ac389ee9=
f18a6fcc0eef244658ce8de0</a>. Now, that also made sense because at the =
time you couldn't connect() or sendmsg() over a VRF by specifying a VRF =
slave interface index as a destination, you had to specify the VRF =
master interface index in the scope. Using link-local addresses of VRF =
enslaved devices at this point in time would've been impossible =
anyway.</div><div><br></div><div>But then, in 2018, a series of patches =
allowed things like connect() and sendmsg() to specify the index of a =
VRF slave interface, thus allowing link-local addresses to be used. For =
example:</div><div><a =
href=3D"https://github.com/torvalds/linux/commit/54dc3e3324829d346c959ff77=
4626d9c6c9a65b5">https://github.com/torvalds/linux/commit/54dc3e3324829d34=
6c959ff774626d9c6c9a65b5</a></div><div><a =
href=3D"https://github.com/torvalds/linux/commit/6da5b0f027a825df2aebc1927=
a27bda185dc03d4">https://github.com/torvalds/linux/commit/6da5b0f027a825df=
2aebc1927a27bda185dc03d4</a></div><div><br></div><div>I do not know =
enough about the code to understand whether after those patches in 2018 =
inet6_iif() could be changed to return the VRF slave device instead of =
the master or whether recvmsg() should not longer use inet6_iif(), but I =
do believe the scope returned by recvmsg() is a =
bug.</div><div><br></div><div>Thank you for your =
time!</div><div><br></div><div>
<meta charset=3D"UTF-8"><div dir=3D"auto" style=3D"text-align: start; =
text-indent: 0px; overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div dir=3D"auto" style=3D"text-align: =
start; text-indent: 0px; overflow-wrap: break-word; -webkit-nbsp-mode: =
space; line-break: after-white-space;"><div dir=3D"auto" =
style=3D"text-align: start; text-indent: 0px; overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><div =
dir=3D"auto" style=3D"text-align: start; text-indent: 0px; =
overflow-wrap: break-word; -webkit-nbsp-mode: space; line-break: =
after-white-space;"><div dir=3D"auto" style=3D"text-align: start; =
text-indent: 0px; overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); letter-spacing: normal; text-transform: none; =
white-space: normal; word-spacing: 0px; text-decoration: none; =
-webkit-text-stroke-width: 0px;">--&nbsp;<br>Luci =
Stanescu<br></div></div></div></div></div></div></div></body></html>=

--Apple-Mail=_E68AA811-F6B4-4F3B-AC8E-7CB2C4428A06--

--Apple-Mail=_F57F5930-E3C7-4BE6-A67B-52D64919E13B
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCjAw
ggTTMIIDu6ADAgECAhBm2u8D24RhkWsluoP7F04TMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYT
AlBMMSIwIAYDVQQKExlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEuMScwJQYDVQQLEx5DZXJ0dW0g
Q2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIjAgBgNVBAMTGUNlcnR1bSBUcnVzdGVkIE5ldHdvcmsg
Q0EwHhcNMTUwNDIxMTI0NTI2WhcNMjcwNjA5MTI0NTI2WjCBijELMAkGA1UEBhMCUEwxIjAgBgNV
BAoMGVVuaXpldG8gVGVjaG5vbG9naWVzIFMuQS4xJzAlBgNVBAsMHkNlcnR1bSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTEuMCwGA1UEAwwlQ2VydHVtIERpZ2l0YWwgSWRlbnRpZmljYXRpb24gQ0Eg
U0hBMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMXgVrv+CZfjKNqcnk5TvUOn3z6o
4OTx4yA5BWu3CqgW7mEez4WlFuPdCVTshvZ+28Yl5lmZ3v/44J+DCI3/nVr7729zaucJI4UsJVPY
mp+5dJfy4NmraGKrhhe7GSxIPFJihexNItJFl36wj3n1Gzggk81/i6LjT7lsDvOifiuBPxGiL4Qx
OxL6nQlVmydHNydqx8hA8n2GTDxIzZ6ERQWcNLxJgHCu+BtEMP+L57n8NEjVbW/2J3pUIrS8Esm2
rlkYPFF6aJON6zOWvntQ2+aenJ0xCip7Y+xvsL74+eVenAKRBVTMzMLevIaE799+7GkfbwYiX9j/
GQorMHSzo2UCAwEAAaOCAT4wggE6MA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFD/KWOrxyQl+
bjPBI61OrT49bEWnMB8GA1UdIwQYMBaAFAh2zcsH/yT2xc3tu5C84oQ3RnX3MA4GA1UdDwEB/wQE
AwIBBjAvBgNVHR8EKDAmMCSgIqAghh5odHRwOi8vY3JsLmNlcnR1bS5wbC9jdG5jYS5jcmwwawYI
KwYBBQUHAQEEXzBdMCgGCCsGAQUFBzABhhxodHRwOi8vc3ViY2Eub2NzcC1jZXJ0dW0uY29tMDEG
CCsGAQUFBzAChiVodHRwOi8vcmVwb3NpdG9yeS5jZXJ0dW0ucGwvY3RuY2EuY2VyMDkGA1UdIAQy
MDAwLgYEVR0gADAmMCQGCCsGAQUFBwIBFhhodHRwOi8vd3d3LmNlcnR1bS5wbC9DUFMwDQYJKoZI
hvcNAQELBQADggEBAAu9CcEJlt/B/nZI1fXxhekorONITDb7P93cFmK7kgZ239iLT81i82C0gjPe
sCQOL7LejnVmP3bM2NSLwYMiUp+pUgblyKC/5nWaRBaakyL+kfbIpd4zmaVHUK+ZMhTcl40F6CgG
LmsXlHiLqsbCVEqG1Z+wPp3Jx4aO2JyyYu3eRZbV3FapB9jUTKF2YPGU1dHbTtHNPsSKypHEcHiu
ub5YNjqSe294eUupVQR4+wEHewz4OCNjFczvJ1EUj9l6v0Epl8pb+/V/QZA22HYN+xXkxSzwrLPD
oCoMJHHse7AA533JrsRhs6t4yLwdvb3nmmajpWFqrYo++M9igLcpKmUwggVVMIIEPaADAgECAhAu
9X6Vlhxq2FAqem3c+oZTMA0GCSqGSIb3DQEBCwUAMIGKMQswCQYDVQQGEwJQTDEiMCAGA1UECgwZ
VW5pemV0byBUZWNobm9sb2dpZXMgUy5BLjEnMCUGA1UECwweQ2VydHVtIENlcnRpZmljYXRpb24g
QXV0aG9yaXR5MS4wLAYDVQQDDCVDZXJ0dW0gRGlnaXRhbCBJZGVudGlmaWNhdGlvbiBDQSBTSEEy
MB4XDTIzMDMyOTA3NTI1NVoXDTI2MDMyODA3NTI1NFowgZMxCzAJBgNVBAYTAlJPMRIwEAYDVQQH
DAlCdWNoYXJlc3QxKTAnBgNVBAoMIFN0YW5lc2N1IFIuIEx1Y2lhbi1BbGV4YW5kcnUgUEZBMSIw
IAYDVQQDDBlMdWNpYW4tQWxleGFuZHJ1IFN0YW5lc2N1MSEwHwYJKoZIhvcNAQkBFhJsdWNpQHNh
ZmViaXRzLnRlY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCgJPYJlH38uDlUdm0B
hkJ5us8JtY2ZmS7D5Y9tLF3igTCYhg49PdUk1shCT4f5sVbqndaqhNk6jOrA6W+i7GYu/Wu3hrLA
tlEgVOjsDEWUaYRtq0msBSkaJPpKxabYc02A6VU/7AI7iaZ8aTC+gwjqJ34INYPXLJu4aa8YHRh3
t4tv2Eh5HPcJtgXfJa46DycOpdmRY1umBq2Ok2DSV36OyHKXDhFq/CRa/PzK02jILXytB/fTupa/
Si++9PwVRKmt5b8Amf0TW/4lAKPePJY7AeA/Ou+C1deGhbFdNrhtx5bZEGRtcXZMRi0mZl1mBvrt
GqCX4IG7yIglygb+v8lRAgMBAAGjggGqMIIBpjAMBgNVHRMBAf8EAjAAMDIGA1UdHwQrMCkwJ6Al
oCOGIWh0dHA6Ly9jcmwuY2VydHVtLnBsL2RpY2FzaGEyLmNybDBxBggrBgEFBQcBAQRlMGMwKwYI
KwYBBQUHMAGGH2h0dHA6Ly9kaWNhc2hhMi5vY3NwLWNlcnR1bS5jb20wNAYIKwYBBQUHMAKGKGh0
dHA6Ly9yZXBvc2l0b3J5LmNlcnR1bS5wbC9kaWNhc2hhMi5jZXIwHwYDVR0jBBgwFoAUP8pY6vHJ
CX5uM8EjrU6tPj1sRacwHQYDVR0OBBYEFKnxwN1IcZoSIfyAcvhTs1jt4hTlMB0GA1UdEgQWMBSB
EmRpY2FzaGEyQGNlcnR1bS5wbDBCBgNVHSAEOzA5MDcGDCqEaAGG9ncCBQEGDjAnMCUGCCsGAQUF
BwIBFhlodHRwczovL3d3dy5jZXJ0dW0ucGwvQ1BTMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDAOBgNVHQ8BAf8EBAMCBPAwHQYDVR0RBBYwFIESbHVjaUBzYWZlYml0cy50ZWNoMA0GCSqG
SIb3DQEBCwUAA4IBAQBTJ1uDMYA6LpYLQHU0d5naZ2VdOLN1IOsrh+QAMm/a4wih7hNd8klqMtH6
3I1Sf3xGDusRnF4dy5WBtX01sl7gwVq3vBq2i8JlhIC2k2+fHdxn0ZJGvlVHn0+q0paOaeZ+sDrD
VW6DUObpq1NJYhsiqSMs0BnRw3sWYnlGHjUkAXOO1dwuwf77/cJg8krdzGf564Gn/rfIVYACwKBQ
ARKUBaG0s2K7tOjXmSCrArlX8QXYHxE+llqoqYwMDG5pC64CZc69h2cy/7zvmpgumo4Xl2xX2VXl
i/5AO8asUoulLnVyPdChswG3+ksP9haANOMl5G/5s6JmRC1+m5ZwL7MDMYIDoDCCA5wCAQEwgZ8w
gYoxCzAJBgNVBAYTAlBMMSIwIAYDVQQKDBlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEuMScwJQYD
VQQLDB5DZXJ0dW0gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxLjAsBgNVBAMMJUNlcnR1bSBEaWdp
dGFsIElkZW50aWZpY2F0aW9uIENBIFNIQTICEC71fpWWHGrYUCp6bdz6hlMwDQYJYIZIAWUDBAIB
BQCgggHRMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAwNzEx
MzkzMVowLwYJKoZIhvcNAQkEMSIEIGo9VQZew1iARyovgwgBPBGj+YnsOMXIUJimR4a5ll1nMIGw
BgkrBgEEAYI3EAQxgaIwgZ8wgYoxCzAJBgNVBAYTAlBMMSIwIAYDVQQKDBlVbml6ZXRvIFRlY2hu
b2xvZ2llcyBTLkEuMScwJQYDVQQLDB5DZXJ0dW0gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxLjAs
BgNVBAMMJUNlcnR1bSBEaWdpdGFsIElkZW50aWZpY2F0aW9uIENBIFNIQTICEC71fpWWHGrYUCp6
bdz6hlMwgbIGCyqGSIb3DQEJEAILMYGioIGfMIGKMQswCQYDVQQGEwJQTDEiMCAGA1UECgwZVW5p
emV0byBUZWNobm9sb2dpZXMgUy5BLjEnMCUGA1UECwweQ2VydHVtIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5MS4wLAYDVQQDDCVDZXJ0dW0gRGlnaXRhbCBJZGVudGlmaWNhdGlvbiBDQSBTSEEyAhAu
9X6Vlhxq2FAqem3c+oZTMA0GCSqGSIb3DQEBCwUABIIBAD2Vk+5d9PQOU23ocPBEVIKtB26fAROE
Tuvc3DhVjJWyPRyyr0y9C3r4qqrc8bAMcWT0IHa4bcmBwvTF8QwleFQ3YbPSHvUBT2YA5pFPN2T4
YTSL6KD56muriztsxbBuzEmZd84/CfpOaBq4uA99svhMGT/W4EEZe2uOAb8ct4VkWHxw75TqH8f2
LqnDfL0ToksRhEdmcScJ/igcFJViCqOLgdHJA7P1ltbZl5v1EB/prXXu9uv+qcihEbUP9chfGakY
RaAPdvVYFRuKGY98hrXU5nV8gqZW1y+qIZ+09K+WsxHf4W0B7ctt+YfZdW6/gj7/37rt9m/Lh73m
9vzax1EAAAAAAAA=
--Apple-Mail=_F57F5930-E3C7-4BE6-A67B-52D64919E13B--

