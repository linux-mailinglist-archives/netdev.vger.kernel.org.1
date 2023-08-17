Return-Path: <netdev+bounces-28362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7198C77F2E2
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E1D1C21331
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42865125DC;
	Thu, 17 Aug 2023 09:12:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4F12B6E
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5B4C43395;
	Thu, 17 Aug 2023 09:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692263552;
	bh=NTNUBA9isK4mC+Ufi3ef3enJDYm+8CnKLjibOUJhxxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNOXKlKc6jprI2YoOiLADV/wxyFTsxObKyp/oohWpsoC5L7dzi3f9GCEMjxCyAjnS
	 HeSBX648f40LVYn/YDqBb4kPVp/oKXMQjpq53gDrr5Ih+eBJCNT1PV+2MuHUDUxhzn
	 mskv3x4EdoHFW2i3y9GUxd5J9IsBwBnjgrY3+7AM1PsS3RWIwe5cYzxwzrE647AynM
	 gGK3UlXVK/uyC6EA/WLMuHu0rAtHXTI83aLOckCjnIP7m+8lP4hTGUFjFhdSUNx3Oi
	 Ujv42UzwPZXM8It5JPsPDVtrpKF2jTv69asTJKVZj6zBCPcy7a+1++mdtKL0S4wfw2
	 pAkkp8I0atv4w==
From: Leon Romanovsky <leon@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dima Chumak <dchumak@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v3 2/8] devlink: Expose port function commands to control IPsec packet offloads
Date: Thu, 17 Aug 2023 12:11:24 +0300
Message-ID: <a9da504e3e4034bf85c765de53ca4cd6074b3a9e.1692262560.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692262560.git.leonro@nvidia.com>
References: <cover.1692262560.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dima Chumak <dchumak@nvidia.com>

Expose port function commands to enable / disable IPsec packet offloads,
this is used to control the port IPsec capabilities.

When IPsec packet is disabled for a function of the port (default),
function cannot offload IPsec packet operations (encapsulation and XFRM
policy offload). When enabled, IPsec packet operations can be offloaded
by the function of the port, which includes crypto operation
(Encrypt/Decrypt), IPsec encapsulation and XFRM state and policy
offload.

Example of a PCI VF port which supports IPsec packet offloads:

$ devlink port show pci/0000:06:00.0/1
    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
        function:
        hw_addr 00:00:00:00:00:00 roce enable ipsec_packet disable

$ devlink port function set pci/0000:06:00.0/1 ipsec_packet enable

$ devlink port show pci/0000:06:00.0/1
    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
        function:
        hw_addr 00:00:00:00:00:00 roce enable ipsec_packet enable

Signed-off-by: Dima Chumak <dchumak@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../networking/devlink/devlink-port.rst       | 28 ++++++++++
 include/net/devlink.h                         | 15 ++++++
 include/uapi/linux/devlink.h                  |  2 +
 net/devlink/leftover.c                        | 52 +++++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 6983b11559cb..f5adb910427a 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -131,6 +131,9 @@ Users may also set the function as migratable using
 Users may also set the IPsec crypto capability of the function using
 `devlink port function set ipsec_crypto` command.
 
+Users may also set the IPsec packet capability of the function using
+`devlink port function set ipsec_packet` command.
+
 Function attributes
 ===================
 
@@ -267,6 +270,31 @@ processed in software by the kernel.
         function:
             hw_addr 00:00:00:00:00:00 ipsec_crypto enabled
 
+IPsec packet capability setup
+-----------------------------
+When user enables IPsec packet capability for a VF, user application can offload
+XFRM state and policy crypto operation (Encrypt/Decrypt) to this VF, as well as
+IPsec encapsulation.
+
+When IPsec packet capability is disabled (default) for a VF, the XFRM state and
+policy is processed in software by the kernel.
+
+- Get IPsec packet capability of the VF device::
+
+    $ devlink port show pci/0000:06:00.0/2
+    pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
+        function:
+            hw_addr 00:00:00:00:00:00 ipsec_packet disabled
+
+- Set IPsec packet capability of the VF device::
+
+    $ devlink port function set pci/0000:06:00.0/2 ipsec_packet enable
+
+    $ devlink port show pci/0000:06:00.0/2
+    pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
+        function:
+            hw_addr 00:00:00:00:00:00 ipsec_packet enabled
+
 Subfunction
 ============
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 1cf07a820a0e..29fd1b4ee654 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1592,6 +1592,15 @@ void devlink_free(struct devlink *devlink);
  *			      capability. Should be used by device drivers to
  *			      enable/disable ipsec_crypto capability of a
  *			      function managed by the devlink port.
+ * @port_fn_ipsec_packet_get: Callback used to get port function's ipsec_packet
+ *			      capability. Should be used by device drivers
+ *			      to report the current state of ipsec_packet
+ *			      capability of a function managed by the devlink
+ *			      port.
+ * @port_fn_ipsec_packet_set: Callback used to set port function's ipsec_packet
+ *			      capability. Should be used by device drivers to
+ *			      enable/disable ipsec_packet capability of a
+ *			      function managed by the devlink port.
  *
  * Note: Driver should return -EOPNOTSUPP if it doesn't support
  * port function (@port_fn_*) handling for a particular port.
@@ -1635,6 +1644,12 @@ struct devlink_port_ops {
 	int (*port_fn_ipsec_crypto_set)(struct devlink_port *devlink_port,
 					bool enable,
 					struct netlink_ext_ack *extack);
+	int (*port_fn_ipsec_packet_get)(struct devlink_port *devlink_port,
+					bool *is_enable,
+					struct netlink_ext_ack *extack);
+	int (*port_fn_ipsec_packet_set)(struct devlink_port *devlink_port,
+					bool enable,
+					struct netlink_ext_ack *extack);
 };
 
 void devlink_port_init(struct devlink *devlink,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index f9ae9a058ad2..03875e078be8 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -662,6 +662,7 @@ enum devlink_port_fn_attr_cap {
 	DEVLINK_PORT_FN_ATTR_CAP_ROCE_BIT,
 	DEVLINK_PORT_FN_ATTR_CAP_MIGRATABLE_BIT,
 	DEVLINK_PORT_FN_ATTR_CAP_IPSEC_CRYPTO_BIT,
+	DEVLINK_PORT_FN_ATTR_CAP_IPSEC_PACKET_BIT,
 
 	/* Add new caps above */
 	__DEVLINK_PORT_FN_ATTR_CAPS_MAX,
@@ -671,6 +672,7 @@ enum devlink_port_fn_attr_cap {
 #define DEVLINK_PORT_FN_CAP_MIGRATABLE \
 	_BITUL(DEVLINK_PORT_FN_ATTR_CAP_MIGRATABLE_BIT)
 #define DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO _BITUL(DEVLINK_PORT_FN_ATTR_CAP_IPSEC_CRYPTO_BIT)
+#define DEVLINK_PORT_FN_CAP_IPSEC_PACKET _BITUL(DEVLINK_PORT_FN_ATTR_CAP_IPSEC_PACKET_BIT)
 
 enum devlink_port_function_attr {
 	DEVLINK_PORT_FUNCTION_ATTR_UNSPEC,
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index ba7248c99864..fec15f17764a 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -514,6 +514,28 @@ static int devlink_port_fn_ipsec_crypto_fill(struct devlink_port *devlink_port,
 	return 0;
 }
 
+static int devlink_port_fn_ipsec_packet_fill(struct devlink_port *devlink_port,
+					     struct nla_bitfield32 *caps,
+					     struct netlink_ext_ack *extack)
+{
+	bool is_enable;
+	int err;
+
+	if (!devlink_port->ops->port_fn_ipsec_packet_get ||
+	    devlink_port->attrs.flavour != DEVLINK_PORT_FLAVOUR_PCI_VF)
+		return 0;
+
+	err = devlink_port->ops->port_fn_ipsec_packet_get(devlink_port, &is_enable, extack);
+	if (err) {
+		if (err == -EOPNOTSUPP)
+			return 0;
+		return err;
+	}
+
+	devlink_port_fn_cap_fill(caps, DEVLINK_PORT_FN_CAP_IPSEC_PACKET, is_enable);
+	return 0;
+}
+
 static int devlink_port_fn_caps_fill(struct devlink_port *devlink_port,
 				     struct sk_buff *msg,
 				     struct netlink_ext_ack *extack,
@@ -534,6 +556,10 @@ static int devlink_port_fn_caps_fill(struct devlink_port *devlink_port,
 	if (err)
 		return err;
 
+	err = devlink_port_fn_ipsec_packet_fill(devlink_port, &caps, extack);
+	if (err)
+		return err;
+
 	if (!caps.selector)
 		return 0;
 	err = nla_put_bitfield32(msg, DEVLINK_PORT_FN_ATTR_CAPS, caps.value,
@@ -871,6 +897,13 @@ devlink_port_fn_ipsec_crypto_set(struct devlink_port *devlink_port, bool enable,
 	return devlink_port->ops->port_fn_ipsec_crypto_set(devlink_port, enable, extack);
 }
 
+static int
+devlink_port_fn_ipsec_packet_set(struct devlink_port *devlink_port, bool enable,
+				 struct netlink_ext_ack *extack)
+{
+	return devlink_port->ops->port_fn_ipsec_packet_set(devlink_port, enable, extack);
+}
+
 static int devlink_port_fn_caps_set(struct devlink_port *devlink_port,
 				    const struct nlattr *attr,
 				    struct netlink_ext_ack *extack)
@@ -902,6 +935,13 @@ static int devlink_port_fn_caps_set(struct devlink_port *devlink_port,
 		if (err)
 			return err;
 	}
+	if (caps.selector & DEVLINK_PORT_FN_CAP_IPSEC_PACKET) {
+		err = devlink_port_fn_ipsec_packet_set(devlink_port, caps_value &
+						       DEVLINK_PORT_FN_CAP_IPSEC_PACKET,
+						       extack);
+		if (err)
+			return err;
+	}
 	return 0;
 }
 
@@ -1278,6 +1318,18 @@ static int devlink_port_function_validate(struct devlink_port *devlink_port,
 				return -EOPNOTSUPP;
 			}
 		}
+		if (caps.selector & DEVLINK_PORT_FN_CAP_IPSEC_PACKET) {
+			if (!ops->port_fn_ipsec_packet_set) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Port doesn't support ipsec_packet function attribute");
+				return -EOPNOTSUPP;
+			}
+			if (devlink_port->attrs.flavour != DEVLINK_PORT_FLAVOUR_PCI_VF) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "ipsec_packet function attribute supported for VFs only");
+				return -EOPNOTSUPP;
+			}
+		}
 	}
 	return 0;
 }
-- 
2.41.0


