Return-Path: <netdev+bounces-18021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A510F7542F5
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 21:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304D52822A0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1A15AFB;
	Fri, 14 Jul 2023 19:01:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B33D13715
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 19:01:36 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C3130FC;
	Fri, 14 Jul 2023 12:01:34 -0700 (PDT)
Date: Fri, 14 Jul 2023 19:01:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1689361292; x=1689620492;
	bh=yZQo0MuHqDNzAW9h8sDYmp2IN6XPjC4GWuy1oTAEskE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=krZTEOW65mCeDzOdqP7m6Lq5BQbbF88xOb90mdtTVNmR0OZ1ZXDnzHdLj+A2yqgff
	 qzP64OXkVknXBMedB2SVRMe2JaSYjuoFkpnS+Qm1mMA+PHfHGfXGdwWWmC6HoBkgC8
	 k6U2UaQExtANoXoo7yIkFWy3WLUU/2TCKfWb7pI+RbBuuf4sfBV364wMbapNe0/RdB
	 Kiviv6bh2VI5OXQKTTREKvY4AwEepf0pGmdcp0BL20Dqa0bHPvrxIemaZibFZyktvc
	 EKWeH78zvt7873Tjlpp9r//xX47nSGulllKOy6Md/E/8wILxI42tGIUd9UZG12K6wk
	 5Tf+DNagDY5lw==
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, andrew@lunn.ch, aliceryhl@google.com, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/5] rust: add methods for configure net_device
Message-ID: <zkyndoXSg5QT0cWHTUkVMke-xxt9EJkT6kORiLdZKklWgWHhz_FWW1zoBImxsRg6Wg7eolhE5enkj32BKIr-rSE-6UOnEoz7jwNHTZ9w3XE=@proton.me>
In-Reply-To: <20230710073703.147351-4-fujita.tomonori@gmail.com>
References: <20230710073703.147351-1-fujita.tomonori@gmail.com> <20230710073703.147351-4-fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> adds methods to net::Device for the basic configurations of
> net_device.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers.c         |   7 ++
>  rust/kernel/net/dev.rs | 185 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 191 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 70d50767ff4e..6c51deb18dc1 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -22,6 +22,7 @@
>  #include <linux/build_bug.h>
>  #include <linux/err.h>
>  #include <linux/errname.h>
> +#include <linux/etherdevice.h>
>  #include <linux/refcount.h>
>  #include <linux/mutex.h>
>  #include <linux/netdevice.h>
> @@ -31,6 +32,12 @@
>  #include <linux/wait.h>
>=20
>  #ifdef CONFIG_NET
> +void rust_helper_eth_hw_addr_random(struct net_device *dev)
> +{
> +=09eth_hw_addr_random(dev);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_eth_hw_addr_random);
> +
>  void *rust_helper_netdev_priv(const struct net_device *dev)
>  {
>  =09return netdev_priv(dev);
> diff --git a/rust/kernel/net/dev.rs b/rust/kernel/net/dev.rs
> index ff00616e4fef..e4d8d8260c10 100644
> --- a/rust/kernel/net/dev.rs
> +++ b/rust/kernel/net/dev.rs
> @@ -8,9 +8,116 @@
>  //! [`include/linux/skbuff.h`](../../../../include/linux/skbuff.h),
>  //! [`include/uapi/linux/if_link.h`](../../../../include/uapi/linux/if_l=
ink.h).
>=20
> -use crate::{bindings, build_error, error::*, prelude::vtable, types::For=
eignOwnable};
> +use crate::{bindings, build_error, error::*, prelude::vtable, str::CStr,=
 types::ForeignOwnable};
>  use {core::ffi::c_void, core::marker::PhantomData};
>=20
> +/// Flags associated with a [`Device`].
> +pub mod flags {
> +    /// Interface is up.
> +    pub const IFF_UP: u32 =3D bindings::net_device_flags_IFF_UP;
> +    /// Broadcast address valid.
> +    pub const IFF_BROADCAST: u32 =3D bindings::net_device_flags_IFF_BROA=
DCAST;
> +    /// Device on debugging.
> +    pub const IFF_DEBUG: u32 =3D bindings::net_device_flags_IFF_DEBUG;
> +    /// Loopback device.
> +    pub const IFF_LOOPBACK: u32 =3D bindings::net_device_flags_IFF_LOOPB=
ACK;
> +    /// Has p-p link.
> +    pub const IFF_POINTOPOINT: u32 =3D bindings::net_device_flags_IFF_PO=
INTOPOINT;
> +    /// Avoids use of trailers.
> +    pub const IFF_NOTRAILERS: u32 =3D bindings::net_device_flags_IFF_NOT=
RAILERS;
> +    /// Interface RFC2863 OPER_UP.
> +    pub const IFF_RUNNING: u32 =3D bindings::net_device_flags_IFF_RUNNIN=
G;
> +    /// No ARP protocol.
> +    pub const IFF_NOARP: u32 =3D bindings::net_device_flags_IFF_NOARP;
> +    /// Receives all packets.
> +    pub const IFF_PROMISC: u32 =3D bindings::net_device_flags_IFF_PROMIS=
C;
> +    /// Receive all multicast packets.
> +    pub const IFF_ALLMULTI: u32 =3D bindings::net_device_flags_IFF_ALLMU=
LTI;
> +    /// Master of a load balancer.
> +    pub const IFF_MASTER: u32 =3D bindings::net_device_flags_IFF_MASTER;
> +    /// Slave of a load balancer.
> +    pub const IFF_SLAVE: u32 =3D bindings::net_device_flags_IFF_SLAVE;
> +    /// Supports multicast.
> +    pub const IFF_MULTICAST: u32 =3D bindings::net_device_flags_IFF_MULT=
ICAST;
> +    /// Capable of setting media type.
> +    pub const IFF_PORTSEL: u32 =3D bindings::net_device_flags_IFF_PORTSE=
L;
> +    /// Auto media select active.
> +    pub const IFF_AUTOMEDIA: u32 =3D bindings::net_device_flags_IFF_AUTO=
MEDIA;
> +    /// Dialup device with changing addresses.
> +    pub const IFF_DYNAMIC: u32 =3D bindings::net_device_flags_IFF_DYNAMI=
C;
> +}
> +
> +/// Private flags associated with a [`Device`].
> +pub mod priv_flags {
> +    /// 802.1Q VLAN device.
> +    pub const IFF_802_1Q_VLAN: u64 =3D bindings::netdev_priv_flags_IFF_8=
02_1Q_VLAN;
> +    /// Ethernet bridging device.
> +    pub const IFF_EBRIDGE: u64 =3D bindings::netdev_priv_flags_IFF_EBRID=
GE;
> +    /// Bonding master or slave device.
> +    pub const IFF_BONDING: u64 =3D bindings::netdev_priv_flags_IFF_BONDI=
NG;
> +    /// ISATAP interface (RFC4214).
> +    pub const IFF_ISATAP: u64 =3D bindings::netdev_priv_flags_IFF_ISATAP=
;
> +    /// WAN HDLC device.
> +    pub const IFF_WAN_HDLC: u64 =3D bindings::netdev_priv_flags_IFF_WAN_=
HDLC;
> +    /// dev_hard_start_xmit() is allowed to release skb->dst.
> +    pub const IFF_XMIT_DST_RELEASE: u64 =3D bindings::netdev_priv_flags_=
IFF_XMIT_DST_RELEASE;
> +    /// Disallows bridging this ether device.
> +    pub const IFF_DONT_BRIDGE: u64 =3D bindings::netdev_priv_flags_IFF_D=
ONT_BRIDGE;
> +    /// Disables netpoll at run-time.
> +    pub const IFF_DISABLE_NETPOLL: u64 =3D bindings::netdev_priv_flags_I=
FF_DISABLE_NETPOLL;
> +    /// Device used as macvlan port.
> +    pub const IFF_MACVLAN_PORT: u64 =3D bindings::netdev_priv_flags_IFF_=
MACVLAN_PORT;
> +    /// Device used as bridge port.
> +    pub const IFF_BRIDGE_PORT: u64 =3D bindings::netdev_priv_flags_IFF_B=
RIDGE_PORT;
> +    /// Device used as Open vSwitch datapath port.
> +    pub const IFF_OVS_DATAPATH: u64 =3D bindings::netdev_priv_flags_IFF_=
OVS_DATAPATH;
> +    /// The interface supports sharing skbs on transmit.
> +    pub const IFF_TX_SKB_SHARING: u64 =3D bindings::netdev_priv_flags_IF=
F_TX_SKB_SHARING;
> +    /// Supports unicast filtering.
> +    pub const IFF_UNICAST_FLT: u64 =3D bindings::netdev_priv_flags_IFF_U=
NICAST_FLT;
> +    /// Device used as team port.
> +    pub const IFF_TEAM_PORT: u64 =3D bindings::netdev_priv_flags_IFF_TEA=
M_PORT;
> +    /// Device supports sending custom FCS.
> +    pub const IFF_SUPP_NOFCS: u64 =3D bindings::netdev_priv_flags_IFF_SU=
PP_NOFCS;
> +    /// Device supports hardware address change when it's running.
> +    pub const IFF_LIVE_ADDR_CHANGE: u64 =3D bindings::netdev_priv_flags_=
IFF_LIVE_ADDR_CHANGE;
> +    /// Macvlan device.
> +    pub const IFF_MACVLAN: u64 =3D bindings::netdev_priv_flags_IFF_MACVL=
AN;
> +    /// IFF_XMIT_DST_RELEASE not taking into account underlying stacked =
devices.
> +    pub const IFF_XMIT_DST_RELEASE_PERM: u64 =3D
> +        bindings::netdev_priv_flags_IFF_XMIT_DST_RELEASE_PERM;
> +    /// L3 master device.
> +    pub const IFF_L3MDEV_MASTER: u64 =3D bindings::netdev_priv_flags_IFF=
_L3MDEV_MASTER;
> +    /// Device can run without qdisc attached.
> +    pub const IFF_NO_QUEUE: u64 =3D bindings::netdev_priv_flags_IFF_NO_Q=
UEUE;
> +    /// Device is a Open vSwitch master.
> +    pub const IFF_OPENVSWITCH: u64 =3D bindings::netdev_priv_flags_IFF_O=
PENVSWITCH;
> +    /// Device is enslaved to an L3 master.
> +    pub const IFF_L3MDEV_SLAVE: u64 =3D bindings::netdev_priv_flags_IFF_=
L3MDEV_SLAVE;
> +    /// Team device.
> +    pub const IFF_TEAM: u64 =3D bindings::netdev_priv_flags_IFF_TEAM;
> +    /// Device has had Rx Flow indirection table configured.
> +    pub const IFF_RXFH_CONFIGURED: u64 =3D bindings::netdev_priv_flags_I=
FF_RXFH_CONFIGURED;
> +    /// The headroom value is controlled by an external entity.
> +    pub const IFF_PHONY_HEADROOM: u64 =3D bindings::netdev_priv_flags_IF=
F_PHONY_HEADROOM;
> +    /// MACsec device.
> +    pub const IFF_MACSEC: u64 =3D bindings::netdev_priv_flags_IFF_MACSEC=
;
> +    /// Device doesn't support the rx_handler hook.
> +    pub const IFF_NO_RX_HANDLER: u64 =3D bindings::netdev_priv_flags_IFF=
_NO_RX_HANDLER;
> +    /// Failover master device.
> +    pub const IFF_FAILOVER: u64 =3D bindings::netdev_priv_flags_IFF_FAIL=
OVER;
> +    /// Lower device of a failover master device.
> +    pub const IFF_FAILOVER_SLAVE: u64 =3D bindings::netdev_priv_flags_IF=
F_FAILOVER_SLAVE;
> +    /// Only invokes the rx handler of L3 master device.
> +    pub const IFF_L3MDEV_RX_HANDLER: u64 =3D bindings::netdev_priv_flags=
_IFF_L3MDEV_RX_HANDLER;
> +    /// Prevents ipv6 addrconf.
> +    pub const IFF_NO_ADDRCONF: u64 =3D bindings::netdev_priv_flags_IFF_N=
O_ADDRCONF;
> +    /// Capable of xmitting frames with skb_headlen(skb) =3D=3D 0.
> +    pub const IFF_TX_SKB_NO_LINEAR: u64 =3D bindings::netdev_priv_flags_=
IFF_TX_SKB_NO_LINEAR;
> +    /// Supports setting carrier via IFLA_PROTO_DOWN.
> +    pub const IFF_CHANGE_PROTO_DOWN: u64 =3D bindings::netdev_priv_flags=
_IFF_CHANGE_PROTO_DOWN;
> +}
> +
>  /// Corresponds to the kernel's `struct net_device`.
>  ///
>  /// # Invariants
> @@ -49,6 +156,82 @@ pub fn drv_priv_data(&self) -> D::Borrowed<'_> {
>              ))
>          }
>      }
> +
> +    /// Sets the name of a device.
> +    pub fn set_name(&mut self, name: &CStr) -> Result {
> +        // SAFETY: The type invariants guarantee that `self.ptr` is vali=
d.
> +        unsafe {
> +            if name.len() > (*self.ptr).name.len() {
> +                return Err(code::EINVAL);
> +            }
> +            (*self.ptr)
> +                .name
> +                .as_mut_ptr()
> +                .copy_from_nonoverlapping(name.as_char_ptr(), name.len()=
);
> +        }

Just to make sure, the `name` field in `net_device` does not need to
be nul-terminated, right?

--
Cheers,
Benno

> +        Ok(())
> +    }
> +
> +    /// Sets carrier.
> +    pub fn netif_carrier_on(&mut self) {
> +        // SAFETY: The type invariants guarantee that `self.ptr` is vali=
d.
> +        unsafe { bindings::netif_carrier_on(self.ptr) }
> +    }
> +
> +    /// Clears carrier.
> +    pub fn netif_carrier_off(&mut self) {
> +        // SAFETY: The type invariants guarantee that `self.ptr` is vali=
d.
> +        unsafe { bindings::netif_carrier_off(self.ptr) }
> +    }
> +
> +    /// Sets the max mtu of the device.
> +    pub fn set_max_mtu(&mut self, max_mtu: u32) {
> +        // SAFETY: The type invariants guarantee that `self.ptr` is vali=
d.
> +        unsafe {
> +            (*self.ptr).max_mtu =3D max_mtu;
> +        }
> +    }
> +
> +    /// Sets the minimum mtu of the device.
> +    pub fn set_min_mtu(&mut self, min_mtu: u32) {
> +        // SAFETY: The type invariants guarantee that `self.ptr` is vali=
d.
> +        unsafe {
> +            (*self.ptr).min_mtu =3D min_mtu;
> +        }
> +    }
> +
> +    /// Returns the flags of the device.
> +    pub fn get_flags(&self) -> u32 {
> +        // SAFETY: The type invariants guarantee that `self.ptr` is vali=
d.
> +        unsafe { (*self.ptr).flags }
> +    }
> +
> +    /// Sets the flags of the device.
> +    pub fn set_flags(&mut self, flags: u32) {
> +        // SAFETY: The type invariants guarantee that `self.ptr` is vali=
d.
> +        unsafe {
> +            (*self.ptr).flags =3D flags;
> +        }
> +    }
> +
> +    /// Returns the priv_flags of the device.
> +    pub fn get_priv_flags(&self) -> u64 {
> +        // SAFETY: The type invariants guarantee that `self.ptr` is vali=
d.
> +        unsafe { (*self.ptr).priv_flags }
> +    }
> +
> +    /// Sets the priv_flags of the device.
> +    pub fn set_priv_flags(&mut self, flags: u64) {
> +        // SAFETY: The type invariants guarantee that `self.ptr` is vali=
d.
> +        unsafe { (*self.ptr).priv_flags =3D flags }
> +    }
> +
> +    /// Generate a random Ethernet address (MAC) to be used by a net dev=
ice
> +    /// and set addr_assign_type.
> +    pub fn set_random_eth_hw_addr(&mut self) {
> +        // SAFETY: The type invariants guarantee that `self.ptr` is vali=
d.
> +        unsafe { bindings::eth_hw_addr_random(self.ptr) }
> +    }
>  }
>=20
>  // SAFETY: `Device` is just a wrapper for the kernel`s `struct net_devic=
e`, which can be used
> --
> 2.34.1
>=20


