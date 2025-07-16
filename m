Return-Path: <netdev+bounces-207485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60489B0786F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5E6168104
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816122424E;
	Wed, 16 Jul 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9FSnODK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C219CC27
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677157; cv=none; b=mBnMo2ZnIIleDkchkKSLV6TnQu64vraxiSirTrSdMHvaCnaBbinmftA3b8jNOJgBDzvfGSFfWKNfgGg9igpvlNVIONkBGCQ963VMn8RiDv/8qvLjeikP+mH3w1LR71XPhkC6joIXGl4Drzw+fsyUjCSg4zYLZCMqEDNyiwmgU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677157; c=relaxed/simple;
	bh=kumc1QD0fBDyBJr62JLiy4rvZUlJgiTUDYF6m0p5vJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUGGk6UP7OInuNk9giiJChJ84OuaYLkIxkzj1BtGCBvU1AcCU6tvCZEx4WeUB5Vm565YA8aZ9Fikqel4REoyfs/UXHtxRRRJ2Uo+DzBHjunqo1p3lNYvYagBI6c25+gPGuDDohGiXaqsNAPw6inO2HdvJXrwJvtlTBUN7k/zXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9FSnODK; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8bb626b20cso1974860276.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677154; x=1753281954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVT5CQOwzKVkDNZJFX3q/wEgxKZ/O4DUjFKQYrKV89s=;
        b=h9FSnODKV+umZPweJvDhJvc1kNsm8Z1iGA7qrCfNe5WrNG/Cmxot5Hx/UFnc/us9Ni
         6c1Fyv5Zq/wpoNcB4SsLxiDjDOtDmU7lw2Mb+6vFor5Xdty2DJHd3mvgZ2y4pHbKjj0D
         ZTOEfR3sK7vfVFl95JkZQb7LF1p97qCM54kHnEk4wcgKnAnqdtVuraP6kQwB1F0qXNW5
         hNrOoiJ1vRlP3biCJ5C1KSxFGeZhSSch2JZXMd7w93LAm4VoD3brRZSOkz4LlTqRNKPU
         g2gleprs0a6aCCinWaLLJqtdyLUBVfpApwQdbOXMJDeDXP1NGJXo7hbuNltYydzKWc2D
         UI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677154; x=1753281954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVT5CQOwzKVkDNZJFX3q/wEgxKZ/O4DUjFKQYrKV89s=;
        b=ouwkGbacnM7VOSMnEntuQub/drErCZxvFINaPAtTl46EWlQztncXpn1P6AdN4Au/n7
         6bRS6xUtCsky7sLfF6SZEd/QWDXumZcClmQjqqaFp0eT1+fEoN71Q6ZrkJOJ88lMlsmL
         f6Gm3nFPlGDHC4R4xOD8IW/OtzngDF6m4XUyxTJvVFz+h3QAw47e8HRjbARgQF2RzMCG
         Z8rcARr2Do23Stw3G6SesYQTtCcBq4PetXXLW8OpAN14qoSfgmAPwu8fM44XsCXcvLDt
         HEf20Nst/Z3+CzP3+wArzml+wyC90JtFblviHEt5D2ipnKCRGfJSIe1f8Fw/oq9dz3Os
         YgDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSDY7uMzv96qUrVphITlTAeDi3UX2wFknL5BLSy+jAsoq+ulYmZ+ykPjK7EPETHCTNA8p4XAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cgNsGK8/JCvY3tho/MMc5o2N1N68ixXd6IPPcWLBobrV/zqL
	CA+jgmBYH9+31uUO0WRd8GtZ9gOfwRG8r2PVM2n9OJGxuZj+1TmCLoPM
X-Gm-Gg: ASbGncsIUjdaRSd++MHDeVGGh48eajTPcjzG1T8tuI9d+FWXD01kz1BuxohLwzJP54b
	wKwnLMYTgEq0pOZcUe9EKhEMcqXsknMptj/dq3lS0JHQAxkFoSQsl9nZYaTYLQkQGCzex8x6FZS
	DiFWrYgO9+696CgkkCSoh9J3lvaCx5C5NEDwvWGN4G6e+edUgdcVQI0LkaXnfLCwkFCeMaA9SkO
	U9CByxh8eWDU/m/Rq0bfg2c+5m1Rzd8s6oghVbPbAhKzUVExbbLEuyKdHOVM2Q1i2msDSwni3gP
	7/O+N3jTz9p3IBli1/BWDegrm90rrq1WHqXPHDrsbjCHAzPiYsZuvWWErrlY+RpFXf2Ig90J6da
	jPTbM0k3jkZnDA5suWH/IJe4m1kRyXJY=
X-Google-Smtp-Source: AGHT+IHKVJx7DcxkrQWmSDZf0W3CzhUPsE7UAsEROZm67rhBneXVh/4I1rNXmKUm8dX/5vnC92A4wA==
X-Received: by 2002:a05:690c:490e:b0:710:f2a1:fa6 with SMTP id 00721157ae682-7183515a205mr49012697b3.29.1752677153888;
        Wed, 16 Jul 2025 07:45:53 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d792d1sm29509447b3.48.2025.07.16.07.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:45:53 -0700 (PDT)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 01/19] psp: add documentation
Date: Wed, 16 Jul 2025 07:45:22 -0700
Message-ID: <20250716144551.3646755-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716144551.3646755-1-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
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
index ac90b82f3ce9..23382ff52285 100644
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
2.47.1


