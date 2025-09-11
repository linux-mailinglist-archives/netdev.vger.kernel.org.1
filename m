Return-Path: <netdev+bounces-221926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D404B525F4
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059811C83BA8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8FB19DF5F;
	Thu, 11 Sep 2025 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgO7ibLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163E1E47CA
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555261; cv=none; b=kZVG7ln+go0yljQwtMTfBKAa2JXTMeZg+2VWa+Mqjkg5awLRpg5GCIvuCp42My8qR88RyDcyVtmVtDFt18h6F0cMzCajdJqAee0/SEGPhLIUxA/cWbRirahl/IARZ2RePd9vAjoSa7YEisRPqh8wBkWdRwHNHu7WIn5XBu8kcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555261; c=relaxed/simple;
	bh=7OHamNe80vMy1JfT5X5HsbgZ0A1AzwbxRhldJWA8UW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1H63dcD08RJdceIkwloHPKTxJkbVnnABsYwkswlpIC8LW/FS+LyWLHWLoxRyoGStSlY0iXVUK62h+Az/EBWAvqqnZbshCK1NVIqlDx7uXdKkIMC85VoWsVjxFshk4iqUkk7MS0vExnqF0qyFLkp2v+Q11RpyldNPApZc+vjwMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgO7ibLh; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-723ad237d1eso2159337b3.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555259; x=1758160059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIBNm5paeiAnQo3yS59NcdyWincUwPqnjjEngtvb/fE=;
        b=CgO7ibLhsUIPMk1rx9Ghds47K+TpR92oputG8r6VsYo7P0SchkSKfEixfY52a8HIDr
         Ut7tYFCGJpPvbKAhUKbAY2uONdUDXkwPff4G+mCPpMwmTbcTwoT6YH/axNN1iAdAOTvM
         /kn8TfKSL3S5NohJEKHpI03Bwcgr1zUxF8ad58O8c89TCRtnOYJjFF+M+60bfdy+Mz3v
         QqtgXSM5XAoJoe9XJBb1XTEgC9kRJGXlTENSaTf1mThO+XUE8gSn+9Tv6YnNjlky+KL+
         YV/RlFdTJjI+VLvIsX3Gf3Sot4/zz0zhHbtcjEYPza3Cqf9Jihx6PpN+HtjuCBjiXBQK
         Go+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555259; x=1758160059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIBNm5paeiAnQo3yS59NcdyWincUwPqnjjEngtvb/fE=;
        b=iMJV3vkPzGlddPs2lomQ7yRVIY4OC5+ZrWkdc3VQg0J3h+RlHm7/7GsOcCWuWyGDlO
         0xzMDwLixCmqSeiqi1VXIEv6owDxrt4Sc4xKO63TNqZo4xnPwP0bmN0W/xVBRBwpYQbz
         98gklNzSGdyPCFanHLNM0mMGuce5v/8dQVaf4Gou9ED9OKwRi2yicg6/ALVmS4XzULXQ
         NajusRISKNPDwnRMEwDsHdh9PhGW3HbUPmwAKINs8jltuhX/II41r8l5UR+Z1UXh8uSx
         sAKmbeIx3kSyATbOho1vMWSkPcXj93cRmLJSu+fs9P+o4Qtmg/Nw7H5WuZLsyuLYKhxN
         gHIg==
X-Forwarded-Encrypted: i=1; AJvYcCUvrkJYFYY/8wTeCGBj5DL+uKAir6T1OX58zsHuGAbC3608uOxfAC2YSQqms4+We1CVuHtpq1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjLMOOy16a3tIpW2clENC9B4LU9knTn5m9KGtW14f906ctL4x
	k8O72CXpIRu+Nqu2pocOBMp0bFmj8mAZDDhmhNEiGxdHKuMaRbV4LcgC
X-Gm-Gg: ASbGncv5FtZ5DUxKKHmpZpV1ey37VR/zjxzz24HelnY5VjF1HIjx5xrAPfjh7iG5m66
	EmTDDEbM53ZOLfWAA+SFxvl1n1DUMVbxG36Hi9owrnNF8YGmYEBSF6YmP3CSF4kF+lqOX6fNaVR
	THCd4gfVwNHKQa4GO+etc8sjWbHc8lkHEaLurofCKkMZUJoTFbu0dK03mvLnniNjJ+HtuwhnvBE
	8fRxFXamIUweHygu8zIwwHXhTHSnkZMKFFoChr/mDvd9eTeTkuuHMZOnek8TIguuO18SYtqJwIZ
	GE2tGxIveWiSRUEExvDOWT8kcQnpIlL/m4mjVmt3sG1qw1pNYrd7TRpUQxD33WEnFPCnQs7sged
	c/hYN3nORL/6iKIsMQ0X6vETQK+MJfXs=
X-Google-Smtp-Source: AGHT+IFyhg30/kjMGC06Vh7pYRm6b7NJn/lN5XWI4K8PqtZsBxe0Ya/TGPcgGQ0BmK1rQQDg2f57BQ==
X-Received: by 2002:a05:690c:3347:b0:725:74c3:75eb with SMTP id 00721157ae682-727f5d45412mr162954987b3.54.1757555258690;
        Wed, 10 Sep 2025 18:47:38 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76929394sm376447b3.24.2025.09.10.18.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:38 -0700 (PDT)
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
Subject: [PATCH net-next v11 01/19] psp: add documentation
Date: Wed, 10 Sep 2025 18:47:09 -0700
Message-ID: <20250911014735.118695-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911014735.118695-1-daniel.zahka@gmail.com>
References: <20250911014735.118695-1-daniel.zahka@gmail.com>
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


