Return-Path: <netdev+bounces-223799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66260B7C462
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B7417822E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292528682;
	Wed, 17 Sep 2025 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4M7aIHO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431533EC
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067800; cv=none; b=uHpt+h7jqTasauGi+QqtllHCf/PX9CAqctsjeOfE+mr4X5qW9u9DsioS3yIa0aevGUlV+o4XjqLrieTL+EJu8/98ahUHLuQclyUSYrLGTp8IjhPmg6IaludpQSfSpG+3kwwLiHuWZfLqOqp0Fl+vr3/y5BHzeAObGvyoPNqqcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067800; c=relaxed/simple;
	bh=7OHamNe80vMy1JfT5X5HsbgZ0A1AzwbxRhldJWA8UW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYjt5BqET/X/S9f8IVccoFPDHMkwUAuRszxdVY7FLNqO0Mv9CjJ+M4UhkQ1QpyNQ2YzYE6ZAbGlVbjPS7lCIsHP6cYbOoELBWDXp1pGMSqR5Z7g9VGAqBLepxL5xYIXHSw8ccEuKQCvYkVNtC7coKAlk5Ksz3XVm/mUwEVjmN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4M7aIHO; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea402199de1so533769276.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 17:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758067798; x=1758672598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIBNm5paeiAnQo3yS59NcdyWincUwPqnjjEngtvb/fE=;
        b=U4M7aIHOu6v9hCvJeykG5mWX3VbH8rL2fqb62Mrpj7wBPKt0EmQbx+umrGAjP4w3Hv
         tNnAi96LWvTxcx8R4T+vI5monlueFi3Su0H4icVja0O1P4nxabwiCk8W10+rcqVmDHGR
         IVTnUcPLydd5fEIwdFFU/dRSfNjL9xPqigDyKR3JiXD+377tvUJFLDrCKwkM2foQYI2u
         zWR3EpFZVFkn2uiw5QtsF0PNO20miypSVTk1heTTBuiOTOhKHCHzAhPChp1xnMszrbh3
         8fB7PA8O9xoGOej4g6PsgKRJ0YMlsQapERrm6QJ/5zW/ol7BYJUGQo+63hY+50wOVb+q
         4ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067798; x=1758672598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIBNm5paeiAnQo3yS59NcdyWincUwPqnjjEngtvb/fE=;
        b=KaAA41meLj/yiGlSMMHx/l1DIGeruwt7pkPWJdiLxTTHoiU/LtDn+QptBuydHtrC71
         ReauWjoF5mWyhoFjnTk3KL1GEY4VEYJqB7ZAaaBet0pAg4hu8SMsOdS85T8wtV2OZcN5
         HclTYsykHN5MTxE4GG0AOeRJnlcWwzq6gRaOYWszrE6d+gUX9KKasA09AGVJvshU0aJy
         EODPqQrpJMY0a9+EEawIDXrvCGvaeFv748bGTCfLpHPPeNE3EryfEZRGZQi5bYvEpvFV
         +4GyjiUzTCKv2/IzPVPYats1EttmaXWHMuVwM08f2rU7fZKnLLqZw+KYC/ZflUl1fvGC
         J5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVsXgvxw4Ubp/LWQV6ECdqn0C4XjwEHlATB9QXhSHBhf8dBysAnu8WIv4vgZTwtJCG3rqmcr+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9nsV5X2quDwCZ6SKLpn1w+jf2yREgUnZ9GUR5Po1nx8g46TPN
	3w0jaSPqM1/R/9pL3ozPHS8S5c9W1mVgNsu3m2wo1RMe8E41XJiDh7q0
X-Gm-Gg: ASbGncv2soVGB0+G2kmSc3nkqBUyn+6F+3QBKn35TybZ803WCcGmkTtNT5x+B0O+BKF
	h0e2WbkHKucv/5xx1mj1PqYpihuKEG+P4XK5X2Ys6FXTu6maj0PLugDtCNpVcYsoW2fTQBjw9St
	Ak3Kopo4t1bxllt5wZR8wbMRMfHA6Uc6U4DjcER7PQWtH2zwoZiRynCUjJuh6CP0I5qYZqYQCR0
	Zi1J3nCOJ7EkSHVW3JDWI1I7OImky/lWRkTSbFzeWVE67Y3CEZIbCx+MLDfjSmBhVmKutN/6e7M
	xM0EeMbGVhVK3UpH+gM6a2BdH+S0zUgax+BCA9yq5S9X0HofhULIgRdLU3NhLulhqhPXxcIbEZx
	DqlvGX541M5MNzn4ce/Q=
X-Google-Smtp-Source: AGHT+IFHSW15HKKwnaP7FBAOl3fSmn5N+zPE4yBCI7kUf31lIixFVjAtkQs9uTXvQ+fjwwxG0CIzYg==
X-Received: by 2002:a05:6902:400c:b0:ea3:bfe8:d03e with SMTP id 3f1490d57ef6-ea5c0d324f2mr158824276.20.1758067797559;
        Tue, 16 Sep 2025 17:09:57 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea576bb11absm1259108276.12.2025.09.16.17.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:09:56 -0700 (PDT)
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
Subject: [PATCH net-next v13 01/19] psp: add documentation
Date: Tue, 16 Sep 2025 17:09:28 -0700
Message-ID: <20250917000954.859376-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917000954.859376-1-daniel.zahka@gmail.com>
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
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


