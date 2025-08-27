Return-Path: <netdev+bounces-217348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15458B38709
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68C01B6203C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B018B2F7466;
	Wed, 27 Aug 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1lBN3JL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A892ED16D
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310025; cv=none; b=Boi/KwH+C8MjgGWZe2Xo23LdJkd3s3XhTP3y6BVCjK864IH/9YNRA/urv6Mxm/xD74oKMZkZ07B/yXMixYZxx8qeiOomR4rGLA9l6++8a0X9CcB3ORUF3rIT7Uw0wOwcn9/msMG4QR+XqHqOxWyi8gleYSjXg17ucH6zJY10Xgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310025; c=relaxed/simple;
	bh=7OHamNe80vMy1JfT5X5HsbgZ0A1AzwbxRhldJWA8UW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=df0b8T/eb8Q3xoMLtTm47klaPDLJ495ztGUwXq2Z5Hcv6t6yWJYgC5Sf5VCMEAD0q+vq2q/ED9WBX+juYOPdHO5K3H7dzGRBgt4clLwX+RFt2hAq7VXqdHjL8/nXDU7ZEUEztFDm4vi8XLWmnXPKCht3A4FWmKB1RTrkDiJfdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1lBN3JL; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e96e45e47daso1148688276.3
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310023; x=1756914823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIBNm5paeiAnQo3yS59NcdyWincUwPqnjjEngtvb/fE=;
        b=K1lBN3JLs13jpjxD/VVDoY/GlSklNQvGmycY34Liv1syQuWDncXTEhS/+/xPdc5QeC
         5w/bbsVHwRzxP1D/gcBB8YV6pD6e9j2ifflwrsbiFTedpBX7/KTVOtFHH3Fj4NzBAclP
         yGLZ04w67gD98MtIImBKYntg1SNi4jc/Phc2XD0flLhmpBsLH63cnpKPb/rtLN3ZxwER
         gFhelxMxVwHgE2BnE4PGmjHQqqn5rvmUM/xuCM7QaSkCFn1P+W4y7eydzYBChcUuiqVw
         Tjnze2iOy2P0BqhQL0vYTMyT32kzewywJVbV+/IIc2ZFHBphG1RFiikgO7pTph8zMxhV
         smrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310023; x=1756914823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIBNm5paeiAnQo3yS59NcdyWincUwPqnjjEngtvb/fE=;
        b=iC2fEPKzUfbabqKS/8o2vLdeeKRyJ60JSppYlWCsF5pwNVg/2wRF26pXW410uBbh25
         KeS0deLaGrXoTuw2PjSVQIxcvOxv/V+TYHjyvlOhfw1zFcVeqWq1cgp/e4tpbqU+F+xo
         dy9QGXLDJc1zSCjkvMvLXpxfmPGs2JjjpScAd6LrgDjbTNlC6/PoWle4spPGrSTFue0B
         Ue7eQ6NRclyuYfK/RBf5cCBFO1xGVa/dUjIATBzSw2baafDUYrAojRmyZPnSXKNBbRHd
         rDiP0vcctjwN2IsWd91LE2SfV0jB7FIpPv7oZo7mw8suL0GWHvc7h73ae+9/VvoNyaH3
         SSqA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0e0/Rnwbno8oqGUJTF8MGIcpcMsDbKvowBfIM4fc/MFmYHnEgAPY0gOVKCuVfQZIwE/25hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBDt332WhsDFn9UH9DLbEA/IMp/9LnrsxQCyw9jlyWVzYopkI
	BSyTxJBEoY8hQKOa+dSNQha5AvIPvdzl2nWHg3ASq16SUC+DpknSFnsG
X-Gm-Gg: ASbGncsy24kSwzwbh/HTsOE6MbZ/Qbmlcn3IdCHKb+emh6uvPp8FRg8KzNALAAmzgA9
	2T0EeWfh5UVVGJ3W1DGknG8u+qUTOMG+ZQQn1O1+iAHBu6LkoyZq1CpswQSNl6SSwqXAUbBggbL
	NA6D+Kcw6ijyHG4jR4u1n2gJHFkWZbhB/SD+AKluWyG3eFG4ejehHjYLkuXyxX8bX3nyyvL+oua
	cOimaKr/4/HAkDS/S3NayGAsSVQv3CZg8LEVGQowbKzIrkdIMGlg/lDIKyprrlS1dmG9SH1Gx8k
	rH/d17NGmguK673FLLv8s1+bT1hOlhcI2NsZV/22OrXUZoe0l/1YNE8rqlxGYBFBfJVo5XOCWI1
	8nWucPCDZYL3KZmaiY+8zv7ukRqcCVaQgiePECYRi4Q==
X-Google-Smtp-Source: AGHT+IGh3EkcpLFJBuRBpumf4zLPzF1xAqJOAbMAcqNa+Uwb3UMMTrs1lk4vzTBz/AeR4mFWkxhgiw==
X-Received: by 2002:a05:6902:154a:b0:e96:c551:9874 with SMTP id 3f1490d57ef6-e96c5519ad0mr11551432276.10.1756310022398;
        Wed, 27 Aug 2025 08:53:42 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5e::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c295b16sm4124422276.16.2025.08.27.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:53:41 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v9 01/19] psp: add documentation
Date: Wed, 27 Aug 2025 08:53:18 -0700
Message-ID: <20250827155340.2738246-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827155340.2738246-1-daniel.zahka@gmail.com>
References: <20250827155340.2738246-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add documentation of things which belong in the docs rather
than commit messages.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v3:
    - reword driver requirement about double rotating keys when the device
      supports requesting arbitrary spi key pairs.
    v2:
    - add note about MITM deletion attack, and expectation from userspace
    - add information about accepting clear text ACKs, RSTs, and FINs to
      `Securing Connections` section.
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-2-kuba@kernel.org/

 Documentation/networking/index.rst |   1 +
 Documentation/networking/psp.rst   | 183 +++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 Documentation/networking/psp.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index b7a4969e9bc9..c775cababc8c 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -101,6 +101,7 @@ Contents:
    ppp_generic
    proc_net_tcp
    pse-pd/index
+   psp
    radiotap-headers
    rds
    regulatory
diff --git a/Documentation/networking/psp.rst b/Documentation/networking/psp.rst
new file mode 100644
index 000000000000..4ac09e64e95a
--- /dev/null
+++ b/Documentation/networking/psp.rst
@@ -0,0 +1,183 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=====================
+PSP Security Protocol
+=====================
+
+Protocol
+========
+
+PSP Security Protocol (PSP) was defined at Google and published in:
+
+https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf
+
+This section briefly covers protocol aspects crucial for understanding
+the kernel API. Refer to the protocol specification for further details.
+
+Note that the kernel implementation and documentation uses the term
+"device key" in place of "master key", it is both less confusing
+to an average developer and is less likely to run afoul any naming
+guidelines.
+
+Derived Rx keys
+---------------
+
+PSP borrows some terms and mechanisms from IPsec. PSP was designed
+with HW offloads in mind. The key feature of PSP is that Rx keys for every
+connection do not have to be stored by the receiver but can be derived
+from device key and information present in packet headers.
+This makes it possible to implement receivers which require a constant
+amount of memory regardless of the number of connections (``O(1)`` scaling).
+
+Tx keys have to be stored like with any other protocol, but Tx is much
+less latency sensitive than Rx, and delays in fetching keys from slow
+memory is less likely to cause packet drops. Preferably, the Tx keys
+should be provided with the packet (e.g. as part of the descriptors).
+
+Key rotation
+------------
+
+The device key known only to the receiver is fundamental to the design.
+Per specification this state cannot be directly accessible (it must be
+impossible to read it out of the hardware of the receiver NIC).
+Moreover, it has to be "rotated" periodically (usually daily). Rotation
+means that new device key gets generated (by a random number generator
+of the device), and used for all new connections. To avoid disrupting
+old connections the old device key remains in the NIC. A phase bit
+carried in the packet headers indicates which generation of device key
+the packet has been encrypted with.
+
+User facing API
+===============
+
+PSP is designed primarily for hardware offloads. There is currently
+no software fallback for systems which do not have PSP capable NICs.
+There is also no standard (or otherwise defined) way of establishing
+a PSP-secured connection or exchanging the symmetric keys.
+
+The expectation is that higher layer protocols will take care of
+protocol and key negotiation. For example one may use TLS key exchange,
+announce the PSP capability, and switch to PSP if both endpoints
+are PSP-capable.
+
+All configuration of PSP is performed via the PSP netlink family.
+
+Device discovery
+----------------
+
+The PSP netlink family defines operations to retrieve information
+about the PSP devices available on the system, configure them and
+access PSP related statistics.
+
+Securing a connection
+---------------------
+
+PSP encryption is currently only supported for TCP connections.
+Rx and Tx keys are allocated separately. First the ``rx-assoc``
+Netlink command needs to be issued, specifying a target TCP socket.
+Kernel will allocate a new PSP Rx key from the NIC and associate it
+with given socket. At this stage socket will accept both PSP-secured
+and plain text TCP packets.
+
+Tx keys are installed using the ``tx-assoc`` Netlink command.
+Once the Tx keys are installed, all data read from the socket will
+be PSP-secured. In other words act of installing Tx keys has a secondary
+effect on the Rx direction.
+
+There is an intermediate period after ``tx-assoc`` successfully
+returns and before the TCP socket encounters it's first PSP
+authenticated packet, where the TCP stack will allow certain nondata
+packets, i.e. ACKs, FINs, and RSTs, to enter TCP receive processing
+even if not PSP authenticated. During the ``tx-assoc`` call, the TCP
+socket's ``rcv_nxt`` field is recorded. At this point, ACKs and RSTs
+will be accepted with any sequence number, while FINs will only be
+accepted at the latched value of ``rcv_nxt``. Once the TCP stack
+encounters the first TCP packet containing PSP authenticated data, the
+other end of the connection must have executed the ``tx-assoc``
+command, so any TCP packet, including those without data, will be
+dropped before receive processing if it is not successfully
+authenticated. This is summarized in the table below. The
+aforementioned state of rejecting all non-PSP packets is labeled "PSP
+Full".
+
++----------------+------------+------------+-------------+-------------+
+| Event          | Normal TCP | Rx PSP     | Tx PSP      | PSP Full    |
++================+============+============+=============+=============+
+| Rx plain       | accept     | accept     | drop        | drop        |
+| (data)         |            |            |             |             |
++----------------+------------+------------+-------------+-------------+
+| Rx plain       | accept     | accept     | accept      | drop        |
+| (ACK|FIN|RST)  |            |            |             |             |
++----------------+------------+------------+-------------+-------------+
+| Rx PSP (good)  | drop       | accept     | accept      | accept      |
++----------------+------------+------------+-------------+-------------+
+| Rx PSP (bad    | drop       | drop       | drop        | drop        |
+| crypt, !=SPI)  |            |            |             |             |
++----------------+------------+------------+-------------+-------------+
+| Tx             | plain text | plain text | encrypted   | encrypted   |
+|                |            |            | (excl. rtx) | (excl. rtx) |
++----------------+------------+------------+-------------+-------------+
+
+To ensure that any data read from the socket after the ``tx-assoc``
+call returns success has been authenticated, the kernel will scan the
+receive and ofo queues of the socket at ``tx-assoc`` time. If any
+enqueued packet was received in clear text, the Tx association will
+fail, and the application should retry installing the Tx key after
+draining the socket (this should not be necessary if both endpoints
+are well behaved).
+
+Because TCP sequence numbers are not integrity protected prior to
+upgrading to PSP, it is possible that a MITM could offset sequence
+numbers in a way that deletes a prefix of the PSP protected part of
+the TCP stream. If userspace cares to mitigate this type of attack, a
+special "start of PSP" message should be exchanged after ``tx-assoc``.
+
+Rotation notifications
+----------------------
+
+The rotations of device key happen asynchronously and are usually
+performed by management daemons, not under application control.
+The PSP netlink family will generate a notification whenever keys
+are rotated. The applications are expected to re-establish connections
+before keys are rotated again.
+
+Kernel implementation
+=====================
+
+Driver notes
+------------
+
+Drivers are expected to start with no PSP enabled (``psp-versions-ena``
+in ``dev-get`` set to ``0``) whenever possible. The user space should
+not depend on this behavior, as future extension may necessitate creation
+of devices with PSP already enabled, nonetheless drivers should not enable
+PSP by default. Enabling PSP should be the responsibility of the system
+component which also takes care of key rotation.
+
+Note that ``psp-versions-ena`` is expected to be used only for enabling
+receive processing. The device is not expected to reject transmit requests
+after ``psp-versions-ena`` has been disabled. User may also disable
+``psp-versions-ena`` while there are active associations, which will
+break all PSP Rx processing.
+
+Drivers are expected to ensure that a device key is usable and secure
+upon init, without explicit key rotation by the user space. It must be
+possible to allocate working keys, and that no duplicate keys must be
+generated. If the device allows the host to request the key for an
+arbitrary SPI - driver should discard both device keys (rotate the
+device key twice), to avoid potentially using a SPI+key which previous
+OS instance already had access to.
+
+Drivers must use ``psp_skb_get_assoc_rcu()`` to check if PSP Tx offload
+was requested for given skb. On Rx drivers should allocate and populate
+the ``SKB_EXT_PSP`` skb extension, and set the skb->decrypted bit to 1.
+
+Kernel implementation notes
+---------------------------
+
+PSP implementation follows the TLS offload more closely than the IPsec
+offload, with per-socket state, and the use of skb->decrypted to prevent
+clear text leaks.
+
+PSP device is separate from netdev, to make it possible to "delegate"
+PSP offload capabilities to software devices (e.g. ``veth``).
-- 
2.47.3


