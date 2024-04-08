Return-Path: <netdev+bounces-85808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08A89C65B
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C4F1F21252
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DC981730;
	Mon,  8 Apr 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="hvQnfiw8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13081729
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585269; cv=none; b=ddeK4Cj2nYuogxXJwaaOSN+7QukCFS5Cs4P6PXCQqQApYgemNpgN+pEq1iQsO8KLxQ7bTwiZpsAvShU7CWQWP0Unma7oKV7MEZoCmX8WayZNIbRwNPQto9mdAuH+Zuj/EsB2/IYREVZyvD20Gb2V6HV+JZiqYpCyupnyWq+6/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585269; c=relaxed/simple;
	bh=KQgKA4IA2y9NstDTYYAT3JbdMu934MR93qnS7RafDwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEf7f3Z7fw5p3ae9AATlnWWnRoz7P0fsX/22AIb470pGNY8W3CAHXhto8EHUMjAeaimfOi1wOlSb6MiilTUYTdmxQgLt0bRsBnK/LWeDKhzE+cGPIcDy6Mc2v1H55VeBe6sEZfPY9ScYvNCG7SKB2oz6kQiegMfbu9VVEaUr+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=hvQnfiw8; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.17.1.24/8.17.1.24) with ESMTP id 438E1Lsn011458;
	Mon, 8 Apr 2024 15:07:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	jan2016.eng; bh=ijRPso6owsfy9LxQoVowv8zjmjxT3IbJiOBLWQx+gCI=; b=
	hvQnfiw8kz5OUP1VOQjC33lk3o2mFDruiUfOANLFAEpjzPHStQL9e/iVGcT5VPI5
	/z1aGeBfDZIGYFm3LSfJKUgiIGkwr8mxxiOvF1u/VBsaKqtYHeDQiWhKV7X44Cz2
	0WZkqxKb4VIlWcatkyKPAgI9UOMfeOH+HsD5a8l48WwELwMpjZioHd1+OpsfLoL8
	/J1IX0RzoNlHyTwcgSnxEIGpFaOBojaBVLfrtXGoSPdtV4daY9SVEEM/bk1VVXxH
	ZhbaBTfD8h4XSsuohRnzPR698wYkAGCb6ub1k22mr+GfE7rUJWCv/1oQmG4w/Wfi
	G4oPFw64W3ZnE0Uce/m2gg==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 3xchys00uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 15:07:26 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 438Cf5mn014748;
	Mon, 8 Apr 2024 10:07:25 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 3xb1qxn3j6-1;
	Mon, 08 Apr 2024 10:07:25 -0400
Received: from [172.19.45.83] (bos-lpa4700a.bos01.corp.akamai.com [172.19.45.83])
	by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 3BC3D64BCE;
	Mon,  8 Apr 2024 14:07:25 +0000 (GMT)
Message-ID: <c6378168-387a-4ccc-9dcf-44e0452e6fd9@akamai.com>
Date: Mon, 8 Apr 2024 10:07:24 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 0/5] net: In-kernel QUIC implementation with
 Userspace handshake
Content-Language: en-US
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Steve French <smfrench@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Chuck Lever III
 <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
        Tyler Fanelli <tfanelli@redhat.com>, Pengtao He <hepengtao@xiaomi.com>
References: <cover.1710173427.git.lucien.xin@gmail.com>
From: Jason Baron <jbaron@akamai.com>
In-Reply-To: <cover.1710173427.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_12,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080108
X-Proofpoint-ORIG-GUID: NbDkt3_WyYb1oJNAyWJoq-bgNlSYEfK5
X-Proofpoint-GUID: NbDkt3_WyYb1oJNAyWJoq-bgNlSYEfK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_12,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 mlxscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404080108

Hi,

This series looks very interesting- I was just wondering if you had done 
any performance testing of this vs. a userspace QUIC implementation?

Thanks,

-Jason

On 3/11/24 12:10 PM, Xin Long wrote:
> Introduction
> ============
> 
> This is an implementation of the QUIC protocol as defined in RFC9000. QUIC
> is an UDP-Based Multiplexed and Secure Transport protocol, and it provides
> applications with flow-controlled streams for structured communication,
> low-latency connection establishment, and network path migration. QUIC
> includes security measures that ensure confidentiality, integrity, and
> availability in a range of deployment circumstances.
> 
> This implementation of QUIC in the kernel space enables users to utilize
> the QUIC protocol through common socket APIs in user space. Additionally,
> kernel subsystems like SMB and NFS can seamlessly operate over the QUIC
> protocol after handshake using net/handshake APIs.
> 
> Note that In-Kernel QUIC implementation does NOT target Crypto Offload
> support for existing Userland QUICs, and Crypto Offload intended for
> Userland QUICs can NOT be utilized for Kernel consumers, such as SMB.
> Therefore, there is no conflict between In-Kernel QUIC and Crypto
> Offload for Userland QUICs.
> 
> This implementation offers fundamental support for the following RFCs:
> 
> - RFC9000 - QUIC: A UDP-Based Multiplexed and Secure Transport
> - RFC9001 - Using TLS to Secure QUIC
> - RFC9002 - QUIC Loss Detection and Congestion Control
> - RFC9221 - An Unreliable Datagram Extension to QUIC
> - RFC9287 - Greasing the QUIC Bit
> - RFC9368 - Compatible Version Negotiation for QUIC
> - RFC9369 - QUIC Version 2
> - Handshake APIs for tlshd Use - SMB/NFS over QUIC
> 
> Implementation
> ==============
> 
> The central idea is to implement QUIC within the kernel, incorporating an
> userspace handshake approach.
> 
> Only the processing and creation of raw TLS Handshake Messages, facilitated
> by a tls library like gnutls, take place in userspace. These messages are
> exchanged through sendmsg/recvmsg() mechanisms, with cryptographic details
> carried in the control message (cmsg).
> 
> The entirety of QUIC protocol, excluding TLS Handshake Messages processing
> and creation, resides in the kernel. Instead of utilizing a User Level
> Protocol (ULP) layer, it establishes a socket of IPPROTO_QUIC type (similar
> to IPPROTO_MPTCP) operating over UDP tunnels.
> 
> Kernel consumers can initiate a handshake request from kernel to userspace
> via the existing net/handshake netlink. The userspace component, tlshd from
> ktls-utils, manages the QUIC handshake request processing.
> 
> - Handshake Architecture:
> 
>        +------+  +------+
>        | APP1 |  | APP2 | ...
>        +------+  +------+
>        +-------------------------------------------------+
>        |                libquic (ktls-utils)             |<--------------+
>        |      {quic_handshake_server/client/param()}     |               |
>        +-------------------------------------------------+      +---------------------+
>          {send/recvmsg()}         {set/getsockopt()}            | tlshd (ktls-utils)  |
>          [CMSG handshake_info]    [SOCKOPT_CRYPTO_SECRET]       +---------------------+
>                                   [SOCKOPT_TRANSPORT_PARAM_EXT]
>                | ^                            | ^                        | ^
>    Userspace   | |                            | |                        | |
>    ------------|-|----------------------------|-|------------------------|-|--------------
>    Kernel      | |                            | |                        | |
>                v |                            v |                        v |
>        +--------------------------------------------------+         +-------------+
>        |  socket (IPPRTOTO_QUIC)  |       protocol        |<----+   | handshake   |
>        +--------------------------------------------------+     |   | netlink APIs|
>        | inqueue | outqueue | cong | path | connection_id |     |   +-------------+
>        +--------------------------------------------------+     |      |      |
>        |   packet   |   frame   |   crypto   |   pnmap    |     |   +-----+ +-----+
>        +--------------------------------------------------+     |   |     | |     |
>        |         input           |       output           |     |---| SMB | | NFS | ...
>        +--------------------------------------------------+     |   |     | |     |
>        |                   UDP tunnels                    |     |   +-----+ +--+--+
>        +--------------------------------------------------+     +--------------|
> 
> - Post Handshake Architecture:
> 
>        +------+  +------+
>        | APP1 |  | APP2 | ...
>        +------+  +------+
>          {send/recvmsg()}         {set/getsockopt()}
>          [CMSG stream_info]       [SOCKOPT_KEY_UPDATE]
>                                   [SOCKOPT_CONNECTION_MIGRATION]
>                                   [SOCKOPT_STREAM_OPEN/RESET/STOP_SENDING]
>                                   [...]
>                | ^                            | ^
>    Userspace   | |                            | |
>    ------------|-|----------------------------|-|----------------
>    Kernel      | |                            | |
>                v |                            v |
>        +--------------------------------------------------+
>        |  socket (IPPRTOTO_QUIC)  |       protocol        |<----+ {kernel_send/recvmsg()}
>        +--------------------------------------------------+     | {kernel_set/getsockopt()}
>        | inqueue | outqueue | cong | path | connection_id |     |
>        +--------------------------------------------------+     |
>        |   packet   |   frame   |   crypto   |   pnmap    |     |   +-----+ +-----+
>        +--------------------------------------------------+     |   |     | |     |
>        |         input           |       output           |     |---| SMB | | NFS | ...
>        +--------------------------------------------------+     |   |     | |     |
>        |                   UDP tunnels                    |     |   +-----+ +--+--+
>        +--------------------------------------------------+     +--------------|
> 
> Usage
> =====
> 
> This implementation supports a mapping of QUIC into sockets APIs. Similar
> to TCP and SCTP, a typical Server and Client use the following system call
> sequence to communicate:
> 
>         Client                    Server
>      ------------------------------------------------------------------
>      sockfd = socket(IPPROTO_QUIC)      listenfd = socket(IPPROTO_QUIC)
>      bind(sockfd)                       bind(listenfd)
>                                         listen(listenfd)
>      connect(sockfd)
>      quic_client_handshake(sockfd)
>                                         sockfd = accecpt(listenfd)
>                                         quic_server_handshake(sockfd, cert)
> 
>      sendmsg(sockfd)                    recvmsg(sockfd)
>      close(sockfd)                      close(sockfd)
>                                         close(listenfd)
> 
> Please note that quic_client_handshake() and quic_server_handshake() functions
> are currently sourced from libquic in the github lxin/quic repository, and might
> be integrated into ktls-utils in the future. These functions are responsible for
> receiving and processing the raw TLS handshake messages until the completion of
> the handshake process.
> 
> For utilization by kernel consumers, it is essential to have the tlshd service
> (from ktls-utils) installed and running in userspace. This service receives
> and manages kernel handshake requests for kernel sockets. In kernel, the APIs
> closely resemble those used in userspace:
> 
>         Client                    Server
>      ------------------------------------------------------------------------
>      __sock_create(IPPROTO_QUIC, &sock)  __sock_create(IPPROTO_QUIC, &sock)
>      kernel_bind(sock)                   kernel_bind(sock)
>                                          kernel_listen(sock)
>      kernel_connect(sock)
>      tls_client_hello_x509(args:{sock})
>                                          kernel_accept(sock, &newsock)
>                                          tls_server_hello_x509(args:{newsock})
> 
>      kernel_sendmsg(sock)                kernel_recvmsg(newsock)
>      sock_release(sock)                  sock_release(newsock)
>                                          sock_release(sock)
> 
> Please be aware that tls_client_hello_x509() and tls_server_hello_x509() are
> APIs from net/handshake/. They are employed to dispatch the handshake request
> to the userspace tlshd service and subsequently block until the handshake
> process is completed.
> 
> For advanced usage,
> see man doc: https://urldefense.com/v3/__https://github.com/lxin/quic/wiki/man__;!!GjvTz_vk!UsLPnlAN5OZvmKIETR2k4xtGO49kJw5h_my6mmoYzVfohMrtGl2Be1zG9WOV3L7scd5SspyzNzYcUkjf$
> and examples: https://urldefense.com/v3/__https://github.com/lxin/quic/tree/main/tests__;!!GjvTz_vk!UsLPnlAN5OZvmKIETR2k4xtGO49kJw5h_my6mmoYzVfohMrtGl2Be1zG9WOV3L7scd5SspyzNy4xr52Q$
> 
> The QUIC module is currently labeled as "EXPERIMENTAL".
> 
> Xin Long (5):
>    net: define IPPROTO_QUIC and SOL_QUIC constants for QUIC protocol
>    net: include quic.h in include/uapi/linux for QUIC protocol
>    net: implement QUIC protocol code in net/quic directory
>    net: integrate QUIC build configuration into Kconfig and Makefile
>    Documentation: introduce quic.rst to provide description of QUIC
>      protocol
> 
>   Documentation/networking/quic.rst |  160 +++
>   include/linux/socket.h            |    1 +
>   include/uapi/linux/in.h           |    2 +
>   include/uapi/linux/quic.h         |  189 +++
>   net/Kconfig                       |    1 +
>   net/Makefile                      |    1 +
>   net/quic/Kconfig                  |   34 +
>   net/quic/Makefile                 |   20 +
>   net/quic/cong.c                   |  229 ++++
>   net/quic/cong.h                   |   84 ++
>   net/quic/connection.c             |  172 +++
>   net/quic/connection.h             |  117 ++
>   net/quic/crypto.c                 |  979 ++++++++++++++++
>   net/quic/crypto.h                 |  140 +++
>   net/quic/frame.c                  | 1803 ++++++++++++++++++++++++++++
>   net/quic/frame.h                  |  162 +++
>   net/quic/hashtable.h              |  125 ++
>   net/quic/input.c                  |  693 +++++++++++
>   net/quic/input.h                  |  169 +++
>   net/quic/number.h                 |  174 +++
>   net/quic/output.c                 |  638 ++++++++++
>   net/quic/output.h                 |  194 +++
>   net/quic/packet.c                 | 1179 +++++++++++++++++++
>   net/quic/packet.h                 |   99 ++
>   net/quic/path.c                   |  434 +++++++
>   net/quic/path.h                   |  131 +++
>   net/quic/pnmap.c                  |  217 ++++
>   net/quic/pnmap.h                  |  134 +++
>   net/quic/protocol.c               |  711 +++++++++++
>   net/quic/protocol.h               |   56 +
>   net/quic/sample_test.c            |  339 ++++++
>   net/quic/socket.c                 | 1823 +++++++++++++++++++++++++++++
>   net/quic/socket.h                 |  293 +++++
>   net/quic/stream.c                 |  248 ++++
>   net/quic/stream.h                 |  147 +++
>   net/quic/timer.c                  |  241 ++++
>   net/quic/timer.h                  |   29 +
>   net/quic/unit_test.c              | 1024 ++++++++++++++++
>   38 files changed, 13192 insertions(+)
>   create mode 100644 Documentation/networking/quic.rst
>   create mode 100644 include/uapi/linux/quic.h
>   create mode 100644 net/quic/Kconfig
>   create mode 100644 net/quic/Makefile
>   create mode 100644 net/quic/cong.c
>   create mode 100644 net/quic/cong.h
>   create mode 100644 net/quic/connection.c
>   create mode 100644 net/quic/connection.h
>   create mode 100644 net/quic/crypto.c
>   create mode 100644 net/quic/crypto.h
>   create mode 100644 net/quic/frame.c
>   create mode 100644 net/quic/frame.h
>   create mode 100644 net/quic/hashtable.h
>   create mode 100644 net/quic/input.c
>   create mode 100644 net/quic/input.h
>   create mode 100644 net/quic/number.h
>   create mode 100644 net/quic/output.c
>   create mode 100644 net/quic/output.h
>   create mode 100644 net/quic/packet.c
>   create mode 100644 net/quic/packet.h
>   create mode 100644 net/quic/path.c
>   create mode 100644 net/quic/path.h
>   create mode 100644 net/quic/pnmap.c
>   create mode 100644 net/quic/pnmap.h
>   create mode 100644 net/quic/protocol.c
>   create mode 100644 net/quic/protocol.h
>   create mode 100644 net/quic/sample_test.c
>   create mode 100644 net/quic/socket.c
>   create mode 100644 net/quic/socket.h
>   create mode 100644 net/quic/stream.c
>   create mode 100644 net/quic/stream.h
>   create mode 100644 net/quic/timer.c
>   create mode 100644 net/quic/timer.h
>   create mode 100644 net/quic/unit_test.c
> 

