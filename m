Return-Path: <netdev+bounces-85831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D731489C7CB
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 17:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4793B22286
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D713F42A;
	Mon,  8 Apr 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrArsnHF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D94126F07
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588723; cv=none; b=fn52Nd0CO1J5jh5cNgW/DD3Hk9FTAlz4flrQFsWoeYZvGEEFeUAlQm6HylE54yW6u+0bEs7siqtdjvLj9FIeoBiynVANV+Ry6SfybHNrXeHtZYWyn2knrLgZwYcDNWnnjdC7S78uoBQeaMtUo8B2vW2BQlpVahfMU6PGJJZ+Uqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588723; c=relaxed/simple;
	bh=Mr0KSB+aEna7tyduCw6xtPdsJzJTWwmTtYFs1KH583w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRYaG0sTyN8QLEBYPLxZWsXyS1DJcYj1zZuEy9M5jr1x3NNDKpVDTIgR+V6ZOrA2cLB8n3Vq1F7B2nUdYP0J11+TB0ghCPu1pLCLYnL7riJeWyb7QTWJzOmFk/rp7cNBee3GSCD1s97UqFnZJEdKbUbXeAwtxlEq74K2ftLWBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrArsnHF; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a2b2714dfso1907395ab.3
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712588720; x=1713193520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymsgK/LMs/auSujAEk54zTCikrqocIz6G6hLetZ4TUM=;
        b=QrArsnHFw0AUaJK76xKMvgn0jmc4DC1o9Jj0FSjFJ+Kuugl24nIWFWYgVQlsfS95Aa
         63AF811IY/r6xJCRw+2doHiSwnLkd69DkLBUAZmRZ9pFSxecENS8qcPfo8mmp6NWUHxB
         ryJ930ERla1uYH60FpaClQYL3ObMaAfKWN731+EXI/N/wwhVvMK6zrG8CldGVgv5oPfb
         H2IQid8leEE0AfxTX6dCqxDppB6l2UQEIA+ImCTehyN3gpzG/8bLSwZUWRrXU5hOp0Ot
         tPtwGSgRhgbF5BDFlNgBV+nMUFOtXn66Knp5xB/VUz9+XV+ZXURKXVt6k685nNt084qu
         //uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712588720; x=1713193520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymsgK/LMs/auSujAEk54zTCikrqocIz6G6hLetZ4TUM=;
        b=hD7voOYp3SNZGlSbKKBW8aKjj3Wz+MtDHRI338+ZOG5w2JEUU9hkkmAlUdCcJFG02T
         Y7xQ4z4/0TRvjkt7MIQrD4ryTJYLoyznK52R2fyKVCS20UVKm9vBsK80m9UdLH1fpzx8
         Gx55snGtNDDyfyL9FX3eIx5FvSbyg7kbp+F+PEYCyl+0qOhoERpFyFCIO6fJw+Xrq45F
         6xwYbnR9X9oLkhTiYQ++Ljdeu+lX7L7U9KI2Tg1teg5FyaCGKx4cTG7o0k/5WLcBQLiW
         Fmn67wWDsc1WGJvSJOYklJv0DevXW3GxvkgJQXQa0ujC8nPmgGQexS3tbzfxR4nHF9jM
         Tapg==
X-Gm-Message-State: AOJu0Yx1k8nQaVINNW0drHtVj78DI/wHotGQfjk7n0jIjGb0gMrdEVe0
	zmf40zU3vVP2cDwfYd3/roMbiwUXWfQQtOzhT+lwGIbfhnWrpkO66kJT3CwrDXy/FE+zJ8UQehz
	vPpReg9P2UdCqpiiHySSZdOFJR5s=
X-Google-Smtp-Source: AGHT+IHXkYAcQeZEKCFgYHJMHpsIJ73Jpq3YrMWSqI0DBoLrF2+pj9KPGPHbo1QwM0c0GqBen71SX+rcO944I3UbHYM=
X-Received: by 2002:a92:c54b:0:b0:36a:2a29:662a with SMTP id
 a11-20020a92c54b000000b0036a2a29662amr1337786ilj.31.1712588720393; Mon, 08
 Apr 2024 08:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710173427.git.lucien.xin@gmail.com> <c6378168-387a-4ccc-9dcf-44e0452e6fd9@akamai.com>
In-Reply-To: <c6378168-387a-4ccc-9dcf-44e0452e6fd9@akamai.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 8 Apr 2024 11:05:09 -0400
Message-ID: <CADvbK_c=wnjM3cY4c3015K71jqAJeB4N-RRZ+3DBq00teH4XfA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/5] net: In-kernel QUIC implementation with
 Userspace handshake
To: Jason Baron <jbaron@akamai.com>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Chuck Lever III <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 10:07=E2=80=AFAM Jason Baron <jbaron@akamai.com> wro=
te:
>
> Hi,
>
> This series looks very interesting- I was just wondering if you had done
> any performance testing of this vs. a userspace QUIC implementation?
Hi, Jason,

I only did the testing vs kTLS with adapt iperf:

https://github.com/lxin/quic?tab=3Dreadme-ov-file#build-and-install-iperf-f=
or-performance-tests

For userspace QUIC implementations, it's not using common socket APIs.
I couldn't find a tool to do the performance testing for them.

Thanks.
>
> Thanks,
>
> -Jason
>
> On 3/11/24 12:10 PM, Xin Long wrote:
> > Introduction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This is an implementation of the QUIC protocol as defined in RFC9000. Q=
UIC
> > is an UDP-Based Multiplexed and Secure Transport protocol, and it provi=
des
> > applications with flow-controlled streams for structured communication,
> > low-latency connection establishment, and network path migration. QUIC
> > includes security measures that ensure confidentiality, integrity, and
> > availability in a range of deployment circumstances.
> >
> > This implementation of QUIC in the kernel space enables users to utiliz=
e
> > the QUIC protocol through common socket APIs in user space. Additionall=
y,
> > kernel subsystems like SMB and NFS can seamlessly operate over the QUIC
> > protocol after handshake using net/handshake APIs.
> >
> > Note that In-Kernel QUIC implementation does NOT target Crypto Offload
> > support for existing Userland QUICs, and Crypto Offload intended for
> > Userland QUICs can NOT be utilized for Kernel consumers, such as SMB.
> > Therefore, there is no conflict between In-Kernel QUIC and Crypto
> > Offload for Userland QUICs.
> >
> > This implementation offers fundamental support for the following RFCs:
> >
> > - RFC9000 - QUIC: A UDP-Based Multiplexed and Secure Transport
> > - RFC9001 - Using TLS to Secure QUIC
> > - RFC9002 - QUIC Loss Detection and Congestion Control
> > - RFC9221 - An Unreliable Datagram Extension to QUIC
> > - RFC9287 - Greasing the QUIC Bit
> > - RFC9368 - Compatible Version Negotiation for QUIC
> > - RFC9369 - QUIC Version 2
> > - Handshake APIs for tlshd Use - SMB/NFS over QUIC
> >
> > Implementation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The central idea is to implement QUIC within the kernel, incorporating =
an
> > userspace handshake approach.
> >
> > Only the processing and creation of raw TLS Handshake Messages, facilit=
ated
> > by a tls library like gnutls, take place in userspace. These messages a=
re
> > exchanged through sendmsg/recvmsg() mechanisms, with cryptographic deta=
ils
> > carried in the control message (cmsg).
> >
> > The entirety of QUIC protocol, excluding TLS Handshake Messages process=
ing
> > and creation, resides in the kernel. Instead of utilizing a User Level
> > Protocol (ULP) layer, it establishes a socket of IPPROTO_QUIC type (sim=
ilar
> > to IPPROTO_MPTCP) operating over UDP tunnels.
> >
> > Kernel consumers can initiate a handshake request from kernel to usersp=
ace
> > via the existing net/handshake netlink. The userspace component, tlshd =
from
> > ktls-utils, manages the QUIC handshake request processing.
> >
> > - Handshake Architecture:
> >
> >        +------+  +------+
> >        | APP1 |  | APP2 | ...
> >        +------+  +------+
> >        +-------------------------------------------------+
> >        |                libquic (ktls-utils)             |<------------=
--+
> >        |      {quic_handshake_server/client/param()}     |             =
  |
> >        +-------------------------------------------------+      +------=
---------------+
> >          {send/recvmsg()}         {set/getsockopt()}            | tlshd=
 (ktls-utils)  |
> >          [CMSG handshake_info]    [SOCKOPT_CRYPTO_SECRET]       +------=
---------------+
> >                                   [SOCKOPT_TRANSPORT_PARAM_EXT]
> >                | ^                            | ^                      =
  | ^
> >    Userspace   | |                            | |                      =
  | |
> >    ------------|-|----------------------------|-|----------------------=
--|-|--------------
> >    Kernel      | |                            | |                      =
  | |
> >                v |                            v |                      =
  v |
> >        +--------------------------------------------------+         +--=
-----------+
> >        |  socket (IPPRTOTO_QUIC)  |       protocol        |<----+   | h=
andshake   |
> >        +--------------------------------------------------+     |   | n=
etlink APIs|
> >        | inqueue | outqueue | cong | path | connection_id |     |   +--=
-----------+
> >        +--------------------------------------------------+     |      =
|      |
> >        |   packet   |   frame   |   crypto   |   pnmap    |     |   +--=
---+ +-----+
> >        +--------------------------------------------------+     |   |  =
   | |     |
> >        |         input           |       output           |     |---| S=
MB | | NFS | ...
> >        +--------------------------------------------------+     |   |  =
   | |     |
> >        |                   UDP tunnels                    |     |   +--=
---+ +--+--+
> >        +--------------------------------------------------+     +------=
--------|
> >
> > - Post Handshake Architecture:
> >
> >        +------+  +------+
> >        | APP1 |  | APP2 | ...
> >        +------+  +------+
> >          {send/recvmsg()}         {set/getsockopt()}
> >          [CMSG stream_info]       [SOCKOPT_KEY_UPDATE]
> >                                   [SOCKOPT_CONNECTION_MIGRATION]
> >                                   [SOCKOPT_STREAM_OPEN/RESET/STOP_SENDI=
NG]
> >                                   [...]
> >                | ^                            | ^
> >    Userspace   | |                            | |
> >    ------------|-|----------------------------|-|----------------
> >    Kernel      | |                            | |
> >                v |                            v |
> >        +--------------------------------------------------+
> >        |  socket (IPPRTOTO_QUIC)  |       protocol        |<----+ {kern=
el_send/recvmsg()}
> >        +--------------------------------------------------+     | {kern=
el_set/getsockopt()}
> >        | inqueue | outqueue | cong | path | connection_id |     |
> >        +--------------------------------------------------+     |
> >        |   packet   |   frame   |   crypto   |   pnmap    |     |   +--=
---+ +-----+
> >        +--------------------------------------------------+     |   |  =
   | |     |
> >        |         input           |       output           |     |---| S=
MB | | NFS | ...
> >        +--------------------------------------------------+     |   |  =
   | |     |
> >        |                   UDP tunnels                    |     |   +--=
---+ +--+--+
> >        +--------------------------------------------------+     +------=
--------|
> >
> > Usage
> > =3D=3D=3D=3D=3D
> >
> > This implementation supports a mapping of QUIC into sockets APIs. Simil=
ar
> > to TCP and SCTP, a typical Server and Client use the following system c=
all
> > sequence to communicate:
> >
> >         Client                    Server
> >      ------------------------------------------------------------------
> >      sockfd =3D socket(IPPROTO_QUIC)      listenfd =3D socket(IPPROTO_Q=
UIC)
> >      bind(sockfd)                       bind(listenfd)
> >                                         listen(listenfd)
> >      connect(sockfd)
> >      quic_client_handshake(sockfd)
> >                                         sockfd =3D accecpt(listenfd)
> >                                         quic_server_handshake(sockfd, c=
ert)
> >
> >      sendmsg(sockfd)                    recvmsg(sockfd)
> >      close(sockfd)                      close(sockfd)
> >                                         close(listenfd)
> >
> > Please note that quic_client_handshake() and quic_server_handshake() fu=
nctions
> > are currently sourced from libquic in the github lxin/quic repository, =
and might
> > be integrated into ktls-utils in the future. These functions are respon=
sible for
> > receiving and processing the raw TLS handshake messages until the compl=
etion of
> > the handshake process.
> >
> > For utilization by kernel consumers, it is essential to have the tlshd =
service
> > (from ktls-utils) installed and running in userspace. This service rece=
ives
> > and manages kernel handshake requests for kernel sockets. In kernel, th=
e APIs
> > closely resemble those used in userspace:
> >
> >         Client                    Server
> >      ------------------------------------------------------------------=
------
> >      __sock_create(IPPROTO_QUIC, &sock)  __sock_create(IPPROTO_QUIC, &s=
ock)
> >      kernel_bind(sock)                   kernel_bind(sock)
> >                                          kernel_listen(sock)
> >      kernel_connect(sock)
> >      tls_client_hello_x509(args:{sock})
> >                                          kernel_accept(sock, &newsock)
> >                                          tls_server_hello_x509(args:{ne=
wsock})
> >
> >      kernel_sendmsg(sock)                kernel_recvmsg(newsock)
> >      sock_release(sock)                  sock_release(newsock)
> >                                          sock_release(sock)
> >
> > Please be aware that tls_client_hello_x509() and tls_server_hello_x509(=
) are
> > APIs from net/handshake/. They are employed to dispatch the handshake r=
equest
> > to the userspace tlshd service and subsequently block until the handsha=
ke
> > process is completed.
> >
> > For advanced usage,
> > see man doc: https://urldefense.com/v3/__https://github.com/lxin/quic/w=
iki/man__;!!GjvTz_vk!UsLPnlAN5OZvmKIETR2k4xtGO49kJw5h_my6mmoYzVfohMrtGl2Be1=
zG9WOV3L7scd5SspyzNzYcUkjf$
> > and examples: https://urldefense.com/v3/__https://github.com/lxin/quic/=
tree/main/tests__;!!GjvTz_vk!UsLPnlAN5OZvmKIETR2k4xtGO49kJw5h_my6mmoYzVfohM=
rtGl2Be1zG9WOV3L7scd5SspyzNy4xr52Q$
> >
> > The QUIC module is currently labeled as "EXPERIMENTAL".
> >
> > Xin Long (5):
> >    net: define IPPROTO_QUIC and SOL_QUIC constants for QUIC protocol
> >    net: include quic.h in include/uapi/linux for QUIC protocol
> >    net: implement QUIC protocol code in net/quic directory
> >    net: integrate QUIC build configuration into Kconfig and Makefile
> >    Documentation: introduce quic.rst to provide description of QUIC
> >      protocol
> >
> >   Documentation/networking/quic.rst |  160 +++
> >   include/linux/socket.h            |    1 +
> >   include/uapi/linux/in.h           |    2 +
> >   include/uapi/linux/quic.h         |  189 +++
> >   net/Kconfig                       |    1 +
> >   net/Makefile                      |    1 +
> >   net/quic/Kconfig                  |   34 +
> >   net/quic/Makefile                 |   20 +
> >   net/quic/cong.c                   |  229 ++++
> >   net/quic/cong.h                   |   84 ++
> >   net/quic/connection.c             |  172 +++
> >   net/quic/connection.h             |  117 ++
> >   net/quic/crypto.c                 |  979 ++++++++++++++++
> >   net/quic/crypto.h                 |  140 +++
> >   net/quic/frame.c                  | 1803 ++++++++++++++++++++++++++++
> >   net/quic/frame.h                  |  162 +++
> >   net/quic/hashtable.h              |  125 ++
> >   net/quic/input.c                  |  693 +++++++++++
> >   net/quic/input.h                  |  169 +++
> >   net/quic/number.h                 |  174 +++
> >   net/quic/output.c                 |  638 ++++++++++
> >   net/quic/output.h                 |  194 +++
> >   net/quic/packet.c                 | 1179 +++++++++++++++++++
> >   net/quic/packet.h                 |   99 ++
> >   net/quic/path.c                   |  434 +++++++
> >   net/quic/path.h                   |  131 +++
> >   net/quic/pnmap.c                  |  217 ++++
> >   net/quic/pnmap.h                  |  134 +++
> >   net/quic/protocol.c               |  711 +++++++++++
> >   net/quic/protocol.h               |   56 +
> >   net/quic/sample_test.c            |  339 ++++++
> >   net/quic/socket.c                 | 1823 ++++++++++++++++++++++++++++=
+
> >   net/quic/socket.h                 |  293 +++++
> >   net/quic/stream.c                 |  248 ++++
> >   net/quic/stream.h                 |  147 +++
> >   net/quic/timer.c                  |  241 ++++
> >   net/quic/timer.h                  |   29 +
> >   net/quic/unit_test.c              | 1024 ++++++++++++++++
> >   38 files changed, 13192 insertions(+)
> >   create mode 100644 Documentation/networking/quic.rst
> >   create mode 100644 include/uapi/linux/quic.h
> >   create mode 100644 net/quic/Kconfig
> >   create mode 100644 net/quic/Makefile
> >   create mode 100644 net/quic/cong.c
> >   create mode 100644 net/quic/cong.h
> >   create mode 100644 net/quic/connection.c
> >   create mode 100644 net/quic/connection.h
> >   create mode 100644 net/quic/crypto.c
> >   create mode 100644 net/quic/crypto.h
> >   create mode 100644 net/quic/frame.c
> >   create mode 100644 net/quic/frame.h
> >   create mode 100644 net/quic/hashtable.h
> >   create mode 100644 net/quic/input.c
> >   create mode 100644 net/quic/input.h
> >   create mode 100644 net/quic/number.h
> >   create mode 100644 net/quic/output.c
> >   create mode 100644 net/quic/output.h
> >   create mode 100644 net/quic/packet.c
> >   create mode 100644 net/quic/packet.h
> >   create mode 100644 net/quic/path.c
> >   create mode 100644 net/quic/path.h
> >   create mode 100644 net/quic/pnmap.c
> >   create mode 100644 net/quic/pnmap.h
> >   create mode 100644 net/quic/protocol.c
> >   create mode 100644 net/quic/protocol.h
> >   create mode 100644 net/quic/sample_test.c
> >   create mode 100644 net/quic/socket.c
> >   create mode 100644 net/quic/socket.h
> >   create mode 100644 net/quic/stream.c
> >   create mode 100644 net/quic/stream.h
> >   create mode 100644 net/quic/timer.c
> >   create mode 100644 net/quic/timer.h
> >   create mode 100644 net/quic/unit_test.c
> >

