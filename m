Return-Path: <netdev+bounces-30551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2959E787FE5
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C65D1C20F3B
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5617E8;
	Fri, 25 Aug 2023 06:29:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7C17EA
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FD4C433C9;
	Fri, 25 Aug 2023 06:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692944995;
	bh=51DPxVF8MRcZ375Iqg+MC+4CEgxa6WXUU+3lrhv1E68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXXzXR8cQKoq4x8Nd7yrmOyj+rsYruMLwIUIhl3BMHKV8Pt9/BidLuWxaWhj/xo+B
	 VzRA1sj1urvnAgER2XXS9K0pRgSClQjDlhkFH+SErtwb8T79l8k+gVLPSJFMUzJJuf
	 zzf9yYkGHOhiNc7/7p2odQA/iH7vUvbI8Cmd1xPNVExAawXtB/We4htXIlC0IMCs3C
	 nkmKQIPz2StXdI5p7qqeAMw8FDZeHbpzSTo0acNO9kYiQW9ymUcC7V/2EDMJUHDLjo
	 AqfmhbTM3SXhyTF95/NqFoPTGvuenqfq9CCf51PYNRypMjP+pZOpOjZ1EwTnDGrvWM
	 Gq2EiB+1eO6pA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dima Chumak <dchumak@nvidia.com>
Subject: [PATCH net-next V4 1/8] devlink: Expose port function commands to control IPsec crypto offloads
Date: Thu, 24 Aug 2023 23:28:29 -0700
Message-ID: <20230825062836.103744-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825062836.103744-1-saeed@kernel.org>
References: <20230825062836.103744-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dima Chumak <dchumak@nvidia.com>

Expose port function commands to enable / disable IPsec crypto offloads,
this is used to control the port IPsec capabilities.

When IPsec crypto is disabled for a function of the port (default),
function cannot offload any IPsec crypto operations (Encrypt/Decrypt and
XFRM state offloading). When enabled, IPsec crypto operations can be
offloaded by the function of the port.

Example of a PCI VF port which supports IPsec crypto offloads:

$ devlink port show pci/0000:06:00.0/1
    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
        function:
        hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto disable

$ devlink port function set pci/0000:06:00.0/1 ipsec_crypto enable

$ devlink port show pci/0000:06:00.0/1
    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
        function:
        hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto enable

Signed-off-by: Dima Chumak <dchumak@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../networking/devlink/devlink-port.rst       | 27 ++++++++++
 include/net/devlink.h                         | 15 ++++++
 include/uapi/linux/devlink.h                  |  2 +
 net/devlink/leftover.c                        | 52 +++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 3da590953ce8..6983b11559cb 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -128,6 +128,9 @@ Users may also set the RoCE capability of the function using
 Users may also set the function as migratable using
 'devlink port function set migratable' command.
 
+Users may also set the IPsec crypto capability of the function using
+`devlink port function set ipsec_crypto` command.
+
 Function attributes
 ===================
 
@@ -240,6 +243,30 @@ Attach VF to the VM.
 Start the VM.
 Perform live migration.
 
+IPsec crypto capability setup
+-----------------------------
+When user enables IPsec crypto capability for a VF, user application can offload
+XFRM state crypto operation (Encrypt/Decrypt) to this VF.
+
+When IPsec crypto capability is disabled (default) for a VF, the XFRM state is
+processed in software by the kernel.
+
+- Get IPsec crypto capability of the VF device::
+
+    $ devlink port show pci/0000:06:00.0/2
+    pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
+        function:
+            hw_addr 00:00:00:00:00:00 ipsec_crypto disabled
+
+- Set IPsec crypto capability of the VF device::
+
+    $ devlink port function set pci/0000:06:00.0/2 ipsec_crypto enable
+
+    $ devlink port show pci/0000:06:00.0/2
+    pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
+        function:
+            hw_addr 00:00:00:00:00:00 ipsec_crypto enabled
+
 Subfunction
 ============
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index f7fec0791acc..1cf07a820a0e 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1583,6 +1583,15 @@ void devlink_free(struct devlink *devlink);
  *		       Should be used by device drivers set
  *		       the admin state of a function managed
  *		       by the devlink port.
+ * @port_fn_ipsec_crypto_get: Callback used to get port function's ipsec_crypto
+ *			      capability. Should be used by device drivers
+ *			      to report the current state of ipsec_crypto
+ *			      capability of a function managed by the devlink
+ *			      port.
+ * @port_fn_ipsec_crypto_set: Callback used to set port function's ipsec_crypto
+ *			      capability. Should be used by device drivers to
+ *			      enable/disable ipsec_crypto capability of a
+ *			      function managed by the devlink port.
  *
  * Note: Driver should return -EOPNOTSUPP if it doesn't support
  * port function (@port_fn_*) handling for a particular port.
@@ -1620,6 +1629,12 @@ struct devlink_port_ops {
 	int (*port_fn_state_set)(struct devlink_port *port,
 				 enum devlink_port_fn_state state,
 				 struct netlink_ext_ack *extack);
+	int (*port_fn_ipsec_crypto_get)(struct devlink_port *devlink_port,
+					bool *is_enable,
+					struct netlink_ext_ack *extack);
+	int (*port_fn_ipsec_crypto_set)(struct devlink_port *devlink_port,
+					bool enable,
+					struct netlink_ext_ack *extack);
 };
 
 void devlink_port_init(struct devlink *devlink,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 3782d4219ac9..f9ae9a058ad2 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -661,6 +661,7 @@ enum devlink_resource_unit {
 enum devlink_port_fn_attr_cap {
 	DEVLINK_PORT_FN_ATTR_CAP_ROCE_BIT,
 	DEVLINK_PORT_FN_ATTR_CAP_MIGRATABLE_BIT,
+	DEVLINK_PORT_FN_ATTR_CAP_IPSEC_CRYPTO_BIT,
 
 	/* Add new caps above */
 	__DEVLINK_PORT_FN_ATTR_CAPS_MAX,
@@ -669,6 +670,7 @@ enum devlink_port_fn_attr_cap {
 #define DEVLINK_PORT_FN_CAP_ROCE _BITUL(DEVLINK_PORT_FN_ATTR_CAP_ROCE_BIT)
 #define DEVLINK_PORT_FN_CAP_MIGRATABLE \
 	_BITUL(DEVLINK_PORT_FN_ATTR_CAP_MIGRATABLE_BIT)
+#define DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO _BITUL(DEVLINK_PORT_FN_ATTR_CAP_IPSEC_CRYPTO_BIT)
 
 enum devlink_port_function_attr {
 	DEVLINK_PORT_FUNCTION_ATTR_UNSPEC,
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index e2cd13958cc2..fcc1a06cae48 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -492,6 +492,28 @@ static int devlink_port_fn_migratable_fill(struct devlink_port *devlink_port,
 	return 0;
 }
 
+static int devlink_port_fn_ipsec_crypto_fill(struct devlink_port *devlink_port,
+					     struct nla_bitfield32 *caps,
+					     struct netlink_ext_ack *extack)
+{
+	bool is_enable;
+	int err;
+
+	if (!devlink_port->ops->port_fn_ipsec_crypto_get ||
+	    devlink_port->attrs.flavour != DEVLINK_PORT_FLAVOUR_PCI_VF)
+		return 0;
+
+	err = devlink_port->ops->port_fn_ipsec_crypto_get(devlink_port, &is_enable, extack);
+	if (err) {
+		if (err == -EOPNOTSUPP)
+			return 0;
+		return err;
+	}
+
+	devlink_port_fn_cap_fill(caps, DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO, is_enable);
+	return 0;
+}
+
 static int devlink_port_fn_caps_fill(struct devlink_port *devlink_port,
 				     struct sk_buff *msg,
 				     struct netlink_ext_ack *extack,
@@ -508,6 +530,10 @@ static int devlink_port_fn_caps_fill(struct devlink_port *devlink_port,
 	if (err)
 		return err;
 
+	err = devlink_port_fn_ipsec_crypto_fill(devlink_port, &caps, extack);
+	if (err)
+		return err;
+
 	if (!caps.selector)
 		return 0;
 	err = nla_put_bitfield32(msg, DEVLINK_PORT_FN_ATTR_CAPS, caps.value,
@@ -838,6 +864,13 @@ devlink_port_fn_roce_set(struct devlink_port *devlink_port, bool enable,
 						   extack);
 }
 
+static int
+devlink_port_fn_ipsec_crypto_set(struct devlink_port *devlink_port, bool enable,
+				 struct netlink_ext_ack *extack)
+{
+	return devlink_port->ops->port_fn_ipsec_crypto_set(devlink_port, enable, extack);
+}
+
 static int devlink_port_fn_caps_set(struct devlink_port *devlink_port,
 				    const struct nlattr *attr,
 				    struct netlink_ext_ack *extack)
@@ -862,6 +895,13 @@ static int devlink_port_fn_caps_set(struct devlink_port *devlink_port,
 		if (err)
 			return err;
 	}
+	if (caps.selector & DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO) {
+		err = devlink_port_fn_ipsec_crypto_set(devlink_port, caps_value &
+						       DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO,
+						       extack);
+		if (err)
+			return err;
+	}
 	return 0;
 }
 
@@ -1226,6 +1266,18 @@ static int devlink_port_function_validate(struct devlink_port *devlink_port,
 				return -EOPNOTSUPP;
 			}
 		}
+		if (caps.selector & DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO) {
+			if (!ops->port_fn_ipsec_crypto_set) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Port doesn't support ipsec_crypto function attribute");
+				return -EOPNOTSUPP;
+			}
+			if (devlink_port->attrs.flavour != DEVLINK_PORT_FLAVOUR_PCI_VF) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "ipsec_crypto function attribute supported for VFs only");
+				return -EOPNOTSUPP;
+			}
+		}
 	}
 	return 0;
 }
-- 
2.41.0


