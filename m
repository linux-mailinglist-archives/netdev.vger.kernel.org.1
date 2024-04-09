Return-Path: <netdev+bounces-86029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E289D4DA
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 10:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EAAAB2167F
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845253BBD8;
	Tue,  9 Apr 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjDomvVD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994471B3D;
	Tue,  9 Apr 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652550; cv=none; b=jK25bTzRtKpQF4JKVjWqRq8+UsOoa6DVoCaCW55tu1BZr3YWHQdJ3ubt3h1acIiX/lw3NmpLgQ8OTq/2bApOIpmxvCOEL2Fzmu9/9un6rKzIzjVfAUDrKOrTWIBreGxC2JKBd9BczYLCqwEmPfAXXV8brCvdcPqon5gNlhxcG+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652550; c=relaxed/simple;
	bh=55Gz1d6PE5+BPGxNtnl+MkRLLOAz1Ds2T1BDn+XXDqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0cdqkKaen6Ci+LcBTstTeI6NHnUGJigtxASY/XGyY1V9FyDS1boSr0d1lyAExAVj7DUE/Jk2nQLGlKeAJa3o8yXzXXDHJ3dZEkmsBh4hTOpGcZ1Dj2ZJTkBCHoXQkUmikItyV0KtiCkxiAx8xJW/GqFi4j7LPIx1gAVVOFi3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjDomvVD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecf406551aso3719117b3a.2;
        Tue, 09 Apr 2024 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712652548; x=1713257348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSahVrthKJCcloY4FNb4IZqh/ztA0JPEzoI52B7gCJI=;
        b=ZjDomvVDh1ZKY0++IxJsBL6QzlcUuEU3cpZRF221sO41TlriBsLhoMh9SvlQnXR4K/
         PCd6DcGxxCbo1AYAxHbPOC5kjQcfotZEH2Wf3ed+oSSeVWwugIqsrtyWGKBiS84u9hEm
         OpD9LqxD7EI80DrCn9TuXP2SlHmQJ5ebNwxWj4eL3K2stG6mddZ5jSqJ1Pqla6EOfI/g
         MgQkV2stI9Lmzw7NWSxoFmr03VjzU/0n8WGTuJeIEgdGTK9kO5Ttc7Ed7Bgax+NFtokC
         q33o7QVj80s6tkMqKhINqbuFWngaM5p721ZQGUiNb07l2SqwowuJr05RsV5dPwlvc84Y
         bPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712652548; x=1713257348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSahVrthKJCcloY4FNb4IZqh/ztA0JPEzoI52B7gCJI=;
        b=ckbVIur+oxC6CDdoSJ5/Ww5WocBqfWaJ5qUxkCQQnLSek1cHe/zAGviVLYmLN6EYKy
         j6MuqFsiDXcLvgQzY/WJEbmLtKyCUB6Jwu+77oSSLQ/Khis9a6EKdzcWX4pRu3Q+y7qh
         SkkSs3HWeMSYF91kvfexjnq7eXbDAf9OkQC05tm4J2iTez0GlDdKA4jliSL/CJzM8LXh
         hxVrbY6ISYCV7eozJI+IODGNyWcTVbEnGRPrZlY59RehY159M25hNr584XaJM1bF8x8E
         1rUgAdW3Rn/hMpo1i74nVmx+3myRabeyP+6Q3NlrC/AuF4LlUs+4i28DFLmFwCUQKolz
         eAQg==
X-Forwarded-Encrypted: i=1; AJvYcCUn4LiQR3ilkGKymAwbQzMJG6iTrHA8RkKEINzHJG7qe6fRUg0aGG76dYTESMpWpe4d+2vq957fth77ZscCMg7kJIv24SUB+YDkERmXaYd9yo95zax4n96eklncMB26duqg
X-Gm-Message-State: AOJu0YzfpQPCHIbWrqbV+rY87EJOUini04PrJLMdJrlIlJAx+NYpXziP
	N0v79Drm+d8LEUkQjnkmGOeEytUkc/8YGFKBgNFEcu2ji4LosUgC
X-Google-Smtp-Source: AGHT+IGTmZe0nkoHN61+lsrsltYIyFugRNF31SDOecEVC/CeFyxDEeetE0uaozVJ/1v/7lkm1K31Lw==
X-Received: by 2002:a05:6a21:9996:b0:1a3:55d2:1489 with SMTP id ve22-20020a056a21999600b001a355d21489mr12488169pzb.7.1712652547512;
        Tue, 09 Apr 2024 01:49:07 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001e3c77db2aesm7800300plf.88.2024.04.09.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:49:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A4B5618479A0F; Tue, 09 Apr 2024 15:49:04 +0700 (WIB)
Date: Tue, 9 Apr 2024 15:49:04 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de,
	kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com,
	davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
	smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
	borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
	linux-doc@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	corbet@lwn.net
Subject: Re: [PATCH v24 09/20] Documentation: add ULP DDP offload
 documentation
Message-ID: <ZhUBAAoqLtqysnRW@archie.me>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-10-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qvJ5B+QzDH4Cl5d1"
Content-Disposition: inline
In-Reply-To: <20240404123717.11857-10-aaptel@nvidia.com>


--qvJ5B+QzDH4Cl5d1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 12:37:06PM +0000, Aurelien Aptel wrote:
> diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation=
/networking/ulp-ddp-offload.rst
> new file mode 100644
> index 000000000000..4133e5094ff5
> --- /dev/null
> +++ b/Documentation/networking/ulp-ddp-offload.rst
> @@ -0,0 +1,372 @@
> +.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ULP direct data placement offload
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Linux kernel ULP direct data placement (DDP) offload infrastructure
> +provides tagged request-response protocols, such as NVMe-TCP, the abilit=
y to
> +place response data directly in pre-registered buffers according to head=
er
> +tags. DDP is particularly useful for data-intensive pipelined protocols =
whose
> +responses may be reordered.
> +
> +For example, in NVMe-TCP numerous read requests are sent together and ea=
ch
> +request is tagged using the PDU header CID field. Receiving servers proc=
ess
> +requests as fast as possible and sometimes responses for smaller requests
> +bypasses responses to larger requests, e.g., 4KB reads bypass 1GB reads.
> +Thereafter, clients correlate responses to requests using PDU header CID=
 tags.
> +The processing of each response requires copying data from SKBs to read
> +request destination buffers; The offload avoids this copy. The offload is
> +oblivious to destination buffers which can reside either in userspace
> +(O_DIRECT) or in kernel pagecache.
> +
> +Request TCP byte-stream:
> +
> +.. parsed-literal::
> +
> + +---------------+-------+---------------+-------+---------------+------=
-+
> + | PDU hdr CID=3D1 | Req 1 | PDU hdr CID=3D2 | Req 2 | PDU hdr CID=3D3 |=
 Req 3 |
> + +---------------+-------+---------------+-------+---------------+------=
-+
> +
> +Response TCP byte-stream:
> +
> +.. parsed-literal::
> +
> + +---------------+--------+---------------+--------+---------------+----=
----+
> + | PDU hdr CID=3D2 | Resp 2 | PDU hdr CID=3D3 | Resp 3 | PDU hdr CID=3D1=
 | Resp 1 |
> + +---------------+--------+---------------+--------+---------------+----=
----+
> +
> +The driver builds SKB page fragments that point to destination buffers.
> +Consequently, SKBs represent the original data on the wire, which enables
> +*transparent* inter-operation with the network stack. To avoid copies be=
tween
> +SKBs and destination buffers, the layer-5 protocol (L5P) will check
> +``if (src =3D=3D dst)`` for SKB page fragments, success indicates that d=
ata is
> +already placed there by NIC hardware and copy should be skipped.
> +
> +In addition, L5P might have DDGST which ensures data integrity over
> +the network.  If not offloaded, ULP DDP might not be efficient as L5P
> +will need to go over the data and calculate it by itself, cancelling
> +out the benefits of the DDP copy skip.  ULP DDP has support for Rx/Tx
> +DDGST offload. On the received side the NIC will verify DDGST for
> +received PDUs and update SKB->ulp_ddp and SKB->ulp_crc bits.  If all the=
 SKBs
> +making up a L5P PDU have crc on, L5P will skip on calculating and
> +verifying the DDGST for the corresponding PDU. On the Tx side, the NIC
> +will be responsible for calculating and filling the DDGST fields in
> +the sent PDUs.
> +
> +Offloading does require NIC hardware to track L5P protocol framing, simi=
larly
> +to RX TLS offload (see Documentation/networking/tls-offload.rst).  NIC h=
ardware
> +will parse PDU headers, extract fields such as operation type, length, t=
ag
> +identifier, etc. and only offload segments that correspond to tags regis=
tered
> +with the NIC, see the :ref:`buf_reg` section.
> +
> +Device configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +During driver initialization the driver sets the ULP DDP operations
> +for the :c:type:`struct net_device <net_device>` via
> +`netdev->netdev_ops->ulp_ddp_ops`.
> +
> +The :c:member:`get_caps` operation returns the ULP DDP capabilities
> +enabled and/or supported by the device to the caller. The current list
> +of capabilities is represented as a bitset:
> +
> +.. code-block:: c
> +
> +  enum ulp_ddp_cap {
> +	ULP_DDP_CAP_NVME_TCP,
> +	ULP_DDP_CAP_NVME_TCP_DDGST,
> +  };
> +
> +The enablement of capabilities can be controlled via the
> +:c:member:`set_caps` operation. This operation is exposed to userspace
> +via netlink. See Documentation/netlink/specs/ulp_ddp.yaml for more
> +details.
> +
> +Later, after the L5P completes its handshake, the L5P queries the
> +driver for its runtime limitations via the :c:member:`limits` operation:
> +
> +.. code-block:: c
> +
> + int (*limits)(struct net_device *netdev,
> +	       struct ulp_ddp_limits *lim);
> +
> +
> +All L5P share a common set of limits and parameters (:c:type:`struct ulp=
_ddp_limits <ulp_ddp_limits>`):
> +
> +.. code-block:: c
> +
> + /**
> +  * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
> +  * protocol limits.
> +  * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, et=
c.).
> +  *
> +  * @type:		type of this limits struct
> +  * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
> +  * @io_threshold:	minimum payload size required to offload
> +  * @tls:		support for ULP over TLS
> +  * @nvmeotcp:		NVMe-TCP specific limits
> +  */
> + struct ulp_ddp_limits {
> +	enum ulp_ddp_type	type;
> +	int			max_ddp_sgl_len;
> +	int			io_threshold;
> +	bool			tls:1;
> +	union {
> +		/* ... protocol-specific limits ... */
> +		struct nvme_tcp_ddp_limits nvmeotcp;
> +	};
> + };
> +
> +But each L5P can also add protocol-specific limits e.g.:
> +
> +.. code-block:: c
> +
> + /**
> +  * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
> +  *
> +  * @full_ccid_range:	true if the driver supports the full CID range
> +  */
> + struct nvme_tcp_ddp_limits {
> +	bool			full_ccid_range;
> + };
> +
> +Once the L5P has made sure the device is supported the offload
> +operations are installed on the socket.
> +
> +If offload installation fails, then the connection is handled by softwar=
e as if
> +offload was not attempted.
> +
> +To request offload for a socket `sk`, the L5P calls :c:member:`sk_add`:
> +
> +.. code-block:: c
> +
> + int (*sk_add)(struct net_device *netdev,
> +	       struct sock *sk,
> +	       struct ulp_ddp_config *config);
> +
> +The function return 0 for success. In case of failure, L5P software shou=
ld
> +fallback to normal non-offloaded operations.  The `config` parameter ind=
icates
> +the L5P type and any metadata relevant for that protocol. For example, in
> +NVMe-TCP the following config is used:
> +
> +.. code-block:: c
> +
> + /**
> +  * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO qu=
eue
> +  *
> +  * @pfv:        pdu version (e.g., NVME_TCP_PFV_1_0)
> +  * @cpda:       controller pdu data alignment (dwords, 0's based)
> +  * @dgst:       digest types enabled.
> +  *              The netdev will offload crc if L5P data digest is suppo=
rted.
> +  * @queue_size: number of nvme-tcp IO queue elements
> +  */
> + struct nvme_tcp_ddp_config {
> +	u16			pfv;
> +	u8			cpda;
> +	u8			dgst;
> +	int			queue_size;
> + };
> +
> +When offload is not needed anymore, e.g. when the socket is being releas=
ed, the L5P
> +calls :c:member:`sk_del` to release device contexts:
> +
> +.. code-block:: c
> +
> + void (*sk_del)(struct net_device *netdev,
> +	        struct sock *sk);
> +
> +Normal operation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +At the very least, the device maintains the following state for each con=
nection:
> +
> + * 5-tuple
> + * expected TCP sequence number
> + * mapping between tags and corresponding buffers
> + * current offset within PDU, PDU length, current PDU tag
> +
> +NICs should not assume any correlation between PDUs and TCP packets.
> +If TCP packets arrive in-order, offload will place PDU payloads
> +directly inside corresponding registered buffers. NIC offload should
> +not delay packets. If offload is not possible, than the packet is
> +passed as-is to software. To perform offload on incoming packets
> +without buffering packets in the NIC, the NIC stores some inter-packet
> +state, such as partial PDU headers.
> +
> +RX data-path
> +------------
> +
> +After the device validates TCP checksums, it can perform DDP offload.  T=
he
> +packet is steered to the DDP offload context according to the 5-tuple.
> +Thereafter, the expected TCP sequence number is checked against the pack=
et
> +TCP sequence number. If there is a match, offload is performed: the PDU =
payload
> +is DMA written to the corresponding destination buffer according to the =
PDU header
> +tag.  The data should be DMAed only once, and the NIC receive ring will =
only
> +store the remaining TCP and PDU headers.
> +
> +We remark that a single TCP packet may have numerous PDUs embedded insid=
e. NICs
> +can choose to offload one or more of these PDUs according to various
> +trade-offs. Possibly, offloading such small PDUs is of little value, and=
 it is
> +better to leave it to software.
> +
> +Upon receiving a DDP offloaded packet, the driver reconstructs the origi=
nal SKB
> +using page frags, while pointing to the destination buffers whenever pos=
sible.
> +This method enables seamless integration with the network stack, which c=
an
> +inspect and modify packet fields transparently to the offload.
> +
> +.. _buf_reg:
> +
> +Destination buffer registration
> +-------------------------------
> +
> +To register the mapping between tags and destination buffers for a socket
> +`sk`, the L5P calls :c:member:`setup` of :c:type:`struct ulp_ddp_dev_ops
> +<ulp_ddp_dev_ops>`:
> +
> +.. code-block:: c
> +
> + int (*setup)(struct net_device *netdev,
> +	      struct sock *sk,
> +	      struct ulp_ddp_io *io);
> +
> +
> +The `io` provides the buffer via scatter-gather list (`sg_table`) and
> +corresponding tag (`command_id`):
> +
> +.. code-block:: c
> +
> + /**
> +  * struct ulp_ddp_io - tcp ddp configuration for an IO request.
> +  *
> +  * @command_id:  identifier on the wire associated with these buffers
> +  * @nents:       number of entries in the sg_table
> +  * @sg_table:    describing the buffers for this IO request
> +  * @first_sgl:   first SGL in sg_table
> +  */
> + struct ulp_ddp_io {
> +	u32			command_id;
> +	int			nents;
> +	struct sg_table		sg_table;
> +	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
> + };
> +
> +After the buffers have been consumed by the L5P, to release the NIC mapp=
ing of
> +buffers the L5P calls :c:member:`teardown` of :c:type:`struct
> +ulp_ddp_dev_ops <ulp_ddp_dev_ops>`:
> +
> +.. code-block:: c
> +
> + void (*teardown)(struct net_device *netdev,
> +		  struct sock *sk,
> +		  struct ulp_ddp_io *io,
> +		  void *ddp_ctx);
> +
> +`teardown` receives the same `io` context and an additional opaque
> +`ddp_ctx` that is used for asynchronous teardown, see the :ref:`async_re=
lease`
> +section.
> +
> +.. _async_release:
> +
> +Asynchronous teardown
> +---------------------
> +
> +To teardown the association between tags and buffers and allow tag reuse=
 NIC HW
> +is called by the NIC driver during `teardown`. This operation may be
> +performed either synchronously or asynchronously. In asynchronous teardo=
wn,
> +`teardown` returns immediately without unmapping NIC HW buffers. Later,
> +when the unmapping completes by NIC HW, the NIC driver will call up to L=
5P
> +using :c:member:`ddp_teardown_done` of :c:type:`struct ulp_ddp_ulp_ops <=
ulp_ddp_ulp_ops>`:
> +
> +.. code-block:: c
> +
> + void (*ddp_teardown_done)(void *ddp_ctx);
> +
> +The `ddp_ctx` parameter passed in `ddp_teardown_done` is the same on pro=
vided
> +in `teardown` and it is used to carry some context about the buffers
> +and tags that are released.
> +
> +Resync handling
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +RX
> +--
> +In presence of packet drops or network packet reordering, the device may=
 lose
> +synchronization between the TCP stream and the L5P framing, and require a
> +resync with the kernel's TCP stack. When the device is out of sync, no o=
ffload
> +takes place, and packets are passed as-is to software. Resync is very si=
milar
> +to TLS offload (see documentation at Documentation/networking/tls-offloa=
d.rst)
> +
> +If only packets with L5P data are lost or reordered, then resynchronizat=
ion may
> +be avoided by NIC HW that keeps tracking PDU headers. If, however, PDU h=
eaders
> +are reordered, then resynchronization is necessary.
> +
> +To resynchronize hardware during traffic, we use a handshake between har=
dware
> +and software. The NIC HW searches for a sequence of bytes that identifie=
s L5P
> +headers (i.e., magic pattern).  For example, in NVMe-TCP, the PDU operat=
ion
> +type can be used for this purpose.  Using the PDU header length field, t=
he NIC
> +HW will continue to find and match magic patterns in subsequent PDU head=
ers. If
> +the pattern is missing in an expected position, then searching for the p=
attern
> +starts anew.
> +
> +The NIC will not resume offload when the magic pattern is first identifi=
ed.
> +Instead, it will request L5P software to confirm that indeed this is a P=
DU
> +header. To request confirmation the NIC driver calls up to L5P using
> +:c:member:`resync_request` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_u=
lp_ops>`:
> +
> +.. code-block:: c
> +
> +  bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
> +
> +The `seq` parameter contains the TCP sequence of the last byte in the PD=
U header.
> +The `flags` parameter contains a flag (`ULP_DDP_RESYNC_PENDING`) indicat=
ing whether
> +a request is pending or not.
> +L5P software will respond to this request after observing the packet con=
taining
> +TCP sequence `seq` in-order. If the PDU header is indeed there, then L5P
> +software calls the NIC driver using the :c:member:`resync` function of
> +the :c:type:`struct ulp_ddp_dev_ops <ulp_ddp_ops>` inside the :c:type:`s=
truct
> +net_device <net_device>` while passing the same `seq` to confirm it is a=
 PDU
> +header.
> +
> +.. code-block:: c
> +
> + void (*resync)(struct net_device *netdev,
> +		struct sock *sk, u32 seq);
> +
> +Statistics
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Per L5P protocol, the NIC driver must report statistics for the above
> +netdevice operations and packets processed by offload.
> +These statistics are per-device and can be retrieved from userspace
> +via netlink (see Documentation/netlink/specs/ulp_ddp.yaml).
> +
> +For example, NVMe-TCP offload reports:
> +
> + * ``rx_nvme_tcp_sk_add`` - number of NVMe-TCP Rx offload contexts creat=
ed.
> + * ``rx_nvme_tcp_sk_add_fail`` - number of NVMe-TCP Rx offload context c=
reation
> +   failures.
> + * ``rx_nvme_tcp_sk_del`` - number of NVMe-TCP Rx offload contexts destr=
oyed.
> + * ``rx_nvme_tcp_setup`` - number of DDP buffers mapped.
> + * ``rx_nvme_tcp_setup_fail`` - number of DDP buffers mapping that faile=
d.
> + * ``rx_nvme_tcp_teardown`` - number of DDP buffers unmapped.
> + * ``rx_nvme_tcp_drop`` - number of packets dropped in the driver due to=
 fatal
> +   errors.
> + * ``rx_nvme_tcp_resync`` - number of packets with resync requests.
> + * ``rx_nvme_tcp_packets`` - number of packets that used offload.
> + * ``rx_nvme_tcp_bytes`` - number of bytes placed in DDP buffers.
> +
> +NIC requirements
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NIC hardware should meet the following requirements to provide this offl=
oad:
> +
> + * Offload must never buffer TCP packets.
> + * Offload must never modify TCP packet headers.
> + * Offload must never reorder TCP packets within a flow.
> + * Offload must never drop TCP packets.
> + * Offload must not depend on any TCP fields beyond the
> +   5-tuple and TCP sequence number.

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--qvJ5B+QzDH4Cl5d1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZhUA/AAKCRD2uYlJVVFO
o8SaAQDkZixppJ5xPLyPQ9vJEYm2RPo/3Kzr1CH8Zcz8P9uYRwD/QBhCaNYvto0+
opxX3hMXPT2SKJTmykUredp05b5r7Qs=
=xqEv
-----END PGP SIGNATURE-----

--qvJ5B+QzDH4Cl5d1--

