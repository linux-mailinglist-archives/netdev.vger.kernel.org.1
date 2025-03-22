Return-Path: <netdev+bounces-176918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C691A6CAFD
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D9B487228
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DA6235361;
	Sat, 22 Mar 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="c2NvqFmZ"
X-Original-To: netdev@vger.kernel.org
Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79F233715;
	Sat, 22 Mar 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654726; cv=none; b=rUt1pfVGbgsqYrYmTsTeSSsCUhRGezedegNyJzBAHKQl6OWsbfBUrpPAfHp7u+yb2u0R1jmQ7Zo53SDvuLo0ccReBb21wHUxy1HV/x1HXiHYh8WdMg5adEQdlbX8zy+/41C6/r+Bk1e1LofFENpCdsTG8Kej517x5pGKabf7cro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654726; c=relaxed/simple;
	bh=NFiW2O3AqEfXF7WeXdrNW2iABNaI3CJJXzXnz0dNEBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PnJFlTUMZJ2mImoirhMcpug1oGaW5rA1KfNoR8ahwrjv0YCEdoXCfn28WF1JW1VCb+iJHEVU862k1Kj75XZCgonKuA/NkdGICf3Z5mtedywJHOUDmDwlIopqNz7466oWkz9HN29enpdKqDWMnDeK/n/jYCy3XuDNSc+4ZWDReUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=c2NvqFmZ; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id 45916657DA;
	Sat, 22 Mar 2025 17:38:02 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:c14:0:640:86a6:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 115A8609AF;
	Sat, 22 Mar 2025 17:37:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id fbNvZmULda60-IX8uf5Bq;
	Sat, 22 Mar 2025 17:37:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654273; bh=lW5lj2cYhFasVRYyAjyRld2ENgI28R6mznj5zuHkdsY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=c2NvqFmZIVj0feM4fHby4SqBcrDSx0FUDlaH/YbA09REhmzRQtO1Kfr1R2ADEE8Kz
	 ix4ET0CfnhiIVvuSk1OGkjccdGp8jTP9Tl0h1Eyu3O3cjJWcbjwR+JxhREwa1X0Wo3
	 m+TBTweoZpBPpanGgX7VK6KaNSYjkrlsw+a/d6jc=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 00/51] Kill rtnl_lock using fine-grained nd_lock
Date: Sat, 22 Mar 2025 17:37:41 +0300
Message-ID: <174265415457.356712.10472727127735290090.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

this patchset shows the way to completely remove rtnl lock and that
this process can be done iteratively without any shocks. It implements
the architecture of new fine-grained locking to use instead of rtnl,
and iteratively converts many drivers to use it.

I mostly write this mostly a few years ago, more or less recently
I rebased the patches on kernel around 6.11 (there should not
be many conflicts on that version). Currenly I have no plans
to complete this.

If anyone wants to continue, this person can take this patchset
and done the work.

Kirill Tkhai

-----------------------------------------------------------------------

The stages and what is done.

0)Introduce nd_lock. lock_netdev(), double_lock_netdev(), ordering,
  nd_lock_transfer_devices()

1)The target of this stage is to attach nd_lock to every registering
  device and to keep it locked during netdevice registration.

  The significant thing is that we want to have two or more netdevices
  sharing the same nd_lock in case of they are configured or modified
  together during their lifetime. E.g., bridge and all their port must
  share the same nd_lock. Bond and bound devices mush share the same
  nd_lock. Both peer of veth are also. Upper and lower, master and slave
  devices too.

  [This is recursive rule. E.g., if veth is a port of bridge, then
   the both veth peers, all bridge ports and bridge itself must relate
   to the same nd_lock].
  
  Net devices in kernel are registered via register_netdev() and register_netdevices()
  functions.

  a)register_netdev() can't be called nested in a configuration actions
    (since it's called with rtnl_mutex unlocked), and usually it is used
    to register a standalone device (say, driver for physical device.
    There are exceptions, and we'll talk about them). So, this primitive
    is not very interesting for us.

  b)register_netdevice() may be called nested, e.g. from netdevice notifier,
    or two devices may be registered at once (e.g., from .newlink or
    .changelink). Later these two devices usually modified at the same time
    together. Users of this primitive want modifications to make devices
    requiring to share nd_lock really relate to same nd_lock.

  To make this, we introduce a new variation __register_netdevice().
  The difference between __register_netdevice() and register_netdevice()
  is in that register_netdevice() allocates and attaches a new nd_lock
  to device, while __register_netdevice() should be used in the cases,
  when nd_lock is inherited from bound device (say, the second veth peer
  inherits nd_lock from the first peer).

  Important thing to say is that despite in general register_netdev()
  is used to register a standalone device, there are some (mentioned)
  exceptions, where several devices may used together in netdevice
  notifiers (one of examples is mlx5 drivers family). To handle such
  cases and to make their modifications not vital, we connect such
  devices to a special fallback_nd_lock. Connected to this fallback_nd_lock,
  such devices will share the same nd_lock like we want.
  Note, that register_netdev() are changed to use fallback_nd_lock
  for every registering device to minimize number of patches for now.
  For the most drivers, register_netdev() should be replaced with
  register_netdevice() under new nd_lock is locked like it's done
  in the patch for loopback. See that patch for the example.

2)The target of this stage is to modify .newlink and .changelink
  to make registering and attaching devices sharing the same nd_lock.
  
  Currently, rtnl_newlink() and rtnl_setlink() stacks look like:

  rtnl_setlink()
    dev1 = __dev_get_by_index(index1)
    dev2 = rtnl_create_link()
    ops->newlink() or ops->changelink()
      dev3 = __dev_get_by_index(index3)
      netdev_upper_dev_link(dev2, dev3)
    do_set_master()
      dev4 = __dev_get_by_index(index4)

  These dev1, dev2, dev3 and dev4 have to relate the same nd_lock.
  Transfering between two nd_locks requires to own both of them
  (see nd_lock_transfer_devices()). But it's impossible in the above
  stack since a nested taking of nd_lock requires to follow ordering
  rules.

  To make nested locking possible, we transform the stack in the below:

  rtnl_setlink()
    dev1 = __dev_get_by_index(index1)
    dev4 = __dev_get_by_index(index4)
    dev3 = __dev_get_by_index(index3)

    double_lock_netdev(dev1, &nd_lockA, dev4, &nd_lockB)
    nd_lock_transfer_devices(&nd_lockA, &nd_lockB)        // Now dev1 and dev4 relate
    double_unlock_netdev(nd_lockA, nd_lockB)              // to same nd_lock

    double_lock_netdev(dev1, &nd_lockA, dev3, &nd_lockB)
    nd_lock_transfer_devices(&nd_lockA, &nd_lockB)        // Now dev1 and dev3 relate
    double_unlock_netdev(nd_lockA, nd_lockB)              // to same nd_lock (and dev4)

    lock_netdev(dev1, &nd_lockA)
    
    dev2 = rtnl_create_link()
    attach_nd_lock(dev2, nd_lockA) // Now all four devices share the same nd lock

    ops->newlink() or ops->changelink()
      dev3 = __dev_get_by_index(index3)
      netdev_upper_dev_link(dev2, dev3)

    do_set_master(dev4)

    unlock_netdev(nd_lockA)

  It's important to see that in this example rtnl_setlink() knows that ops->newlink
  will dereference device with index3. To make this possible, struct rtnl_link_ops
  was extended by two deps members: .newlink_deps and .changelink_deps. Instead of
  describing them formally, I'll show them on two examples:

    struct link_deps bond_changelink_deps = {
      .optional.data = { IFLA_BOND_ACTIVE_SLAVE, IFLA_BOND_PRIMARY, },
    };

    static struct link_deps hsr_newlink_deps = {
      .mandatory.data = { IFLA_HSR_SLAVE1, IFLA_HSR_SLAVE2, },
      .optional.data = { IFLA_HSR_INTERLINK, },
    };

    struct link_deps generic_newlink_deps = {
      .mandatory.tb = { IFLA_LINK, }
    };


  These ids are that bond_changelink(), hsr_newlink() and most of other
  drivers dereference. They may be mandatory and optional in dependence
  of the way .newlink/.changelink react on devices with such indexes
  exist or not. The rest .data and .tb is related to the array used
  by .newlink and .changelink to get device id:

  int                     (*newlink)(struct net *src_net,
                                     struct net_device *dev,
                                     struct nlattr *tb[],     <---
                                     struct nlattr *data[],   <---
                                     struct netlink_ext_ack *extack);


  After we introduces .newlink_deps and .changelink_deps and we simply
  use corrent nd_lock to attach nested device in .newlink and .changelink.

3)The target of this stage is to make the rest of drivers using register_netdevice()
  to share the same nd_lock by bound devices. Examples: dsa, cfg80211, etc.
  Here are just non-invasive refactoring.

  Now we have all drivers changed to share nd_lock in correct way.

4)At this stage we make all netdev_master_upper_dev_link() called under nd_lock.

  Now all connecting to master is protected by nd_lock (unlink is not).

5)At this stage we make all dev_change_net_namespace() called under nd_lock.

6)Next is to make NETDEV_REGISTER event notifier be called under nd_lock.

  After previous stage it's not difficult.
  See comments about netdevice events in its chapter below.

The patchset ends at this stage.

What is next?

1)More and more netdev parameters should be placed under locked
  nd_lock like it's done in this patchset. Netdevice events, rtnl
  callbacks, ioctls, etc.

  The target is to place a taking nd_lock of device upper in stack
  and to bring everything

  from:
    ioctl()
      rtnl_lock()
      dev = __dev_get_by_index(index)
        func1()
          change dev parameter1
          func2()
            lock_netdev(dev)          <-- attention here
            netdev_master_upper_dev_link()
            change dev parameter2

  to:
    ioctl()
      rtnl_lock()
      dev = __dev_get_by_index(index)
      lock_netdev(dev)                <-- attention here
        func1()
          change dev parameter1
          func2()
            netdev_master_upper_dev_link()
            change dev parameter2

  After we complete this, all device parametes will be protected
  by nd_lock.

  Keep in mind, that despite we introduced nd_lock and begun
  to use it, there is no concurrency during access to device
  parameters yet until rtnl_mutex is taken first. Everything
  is still protected by rtnl_mutex. So, our responsibility
  is not to prevent races connected with introduction nd_lock.
  Our responcibility is tracing nested functions calls and
  to prevent taking nd_lock when we already own it.

2)The next stage is we change rtnl_mutex and nd_lock order.
  We dereference devices from RCU lists.

    ioctl(index)
      dev = netdev_get_by_index_locked(index, &nd_lock) <-- attention to _locked suffix
      rtnl_lock()                                       <-- and here
        func1()
          change dev parameter1
          func2()
            netdev_master_upper_dev_link()
            change dev parameter2
      ...
      rtnl_unlock()
      unlock_netdev(nd_lock)

  A new function netdev_get_by_index_locked() from the above:

  struct net_device *netdev_get_by_index_locked(index, nd_lock_ptr)
  {
  again:
      dev = netdev_get_by_index(index, tracker);
      if (!dev)
        return NULL;

      if (!lock_netdev(dev, nd_lock_ptr)) {   /* device was unregistered in parallel */
         netdev_put(dev, tracker);
         goto again;
      }
      netdev_put(dev, tracker);

      if (dev->ifindex != index) {
        unlock_netdev(*nd_lock_ptr);
        goto again;
      }

      return dev;
  }

  The same way will look a new function taking two locks of two devices.

3)Now rtnl_lock() will go down in stack and this way will be fast:

  ioctl(index)
      dev = netdev_get_by_index_locked(index, &nd_lock)
        func1()
          change dev parameter1
          func2()
            netdev_master_upper_dev_link()
            rtnl_lock();                    <--- now it is here
            change dev parameter2
            rtnl_unlock()
      ...
      unlock_netdev(nd_lock)

  We will move more parameters out of rtnl_lock and one day nothing
  will be protected using it. But we may leave it to protect something
  unrelated to net devices by historical reasons.

***)Netdevice events

int register_netdevice_notifier(struct notifier_block *nb)

int register_netdevice_notifier_net(struct net *net, struct notifier_block *nb)


int register_netdevice_notifier_dev_net(struct net_device *dev,
                                        struct notifier_block *nb,
                                        struct netdev_net_notifier *nn)

  This may be converted into register_nd_lock_group_notifier()
---

Kirill Tkhai (51):
      net: Move some checks from __rtnl_newlink() to caller
      net: Add nlaattr check to rtnl_link_get_net_capable()
      net: do_setlink() refactoring: move target_net acquiring to callers
      net: Extract some code from __rtnl_newlink() to separate func
      net: Move dereference of tb[IFLA_MASTER] up
      net: Use unregister_netdevice_many() for both error cases in rtnl_newlink_create()
      net: Introduce nd_lock and primitives to work with it
      net: Initially attaching and detaching nd_lock
      net: Use register_netdevice() in loopback()
      net: Underline newlink and changelink dependencies
      net: Make master and slaves (any dependent devices) share the same nd_lock in .setlink etc
      net: Use __register_netdevice in trivial .newlink cases
      infiniband_ipoib: Use __register_netdevice in .newlink
      vxcan: Use __register_netdevice in .newlink
      iavf: Use __register_netdevice()
      geneve: Use __register_netdevice in .newlink
      netkit: Use __register_netdevice in .newlink
      qmi_wwan: Use __register_netdevice in .newlink
      bpqether: Provide determined context in __register_netdevice()
      ppp: Use __register_netdevice in .newlink
      veth: Use __register_netdevice in .newlink
      vxlan: Use __register_netdevice in .newlink
      hdlc_fr: Use __register_netdevice
      lapbeth: Provide determined context in __register_netdevice()
      wwan: Use __register_netdevice in .newlink
      6lowpan: Use __register_netdevice in .newlink
      vlan: Use __register_netdevice in .newlink
      dsa: Use __register_netdevice()
      ip6gre: Use __register_netdevice() in .changelink
      ip6_tunnel: Use __register_netdevice() in .newlink and .changelink
      ip6_vti: Use __register_netdevice() in .newlink and .changelink
      ip6_sit: Use __register_netdevice() in .newlink and .changelink
      net: Now check nobody calls register_netdevice() with nd_lock attached
      dsa: Make all switch tree ports relate to same nd_lock
      cfg80211: Use fallback_nd_lock for registered devices
      ieee802154: Use fallback_nd_lock for registered devices
      net: Introduce delayed event work
      failover: Link master and slave under nd_lock
      netvsc: Make joined device to share master's nd_lock
      openvswitch: Make ports share nd_lock of master device
      bridge: Make port to have the same nd_lock as bridge
      bond: Make master and slave relate to the same nd_lock
      net: Now check nobody calls netdev_master_upper_dev_link() without nd_lock attached
      net: Call dellink with nd_lock is held
      t7xx: Use __unregister_netdevice()
      6lowpan: Use __unregister_netdevice()
      netvsc: Call dev_change_net_namespace() under nd_lock
      default_device: Call dev_change_net_namespace() under nd_lock
      ieee802154: Call dev_change_net_namespace() under nd_lock
      cfg80211: Call dev_change_net_namespace() under nd_lock
      net: Make all NETDEV_REGISTER events to be called under nd_lock


 drivers/infiniband/ulp/ipoib/ipoib_netlink.c       |    3 
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c          |   12 
 drivers/net/amt.c                                  |    9 
 drivers/net/bareudp.c                              |    2 
 drivers/net/bonding/bond_main.c                    |    4 
 drivers/net/bonding/bond_netlink.c                 |    7 
 drivers/net/bonding/bond_options.c                 |    4 
 drivers/net/can/vxcan.c                            |    8 
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   59 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |    3 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c    |    2 
 drivers/net/geneve.c                               |   12 
 drivers/net/gtp.c                                  |    2 
 drivers/net/hamradio/bpqether.c                    |   33 +
 drivers/net/hyperv/netvsc_drv.c                    |   28 +
 drivers/net/ipvlan/ipvlan_main.c                   |    5 
 drivers/net/ipvlan/ipvtap.c                        |    1 
 drivers/net/loopback.c                             |    6 
 drivers/net/macsec.c                               |    5 
 drivers/net/macvlan.c                              |    5 
 drivers/net/macvtap.c                              |    1 
 drivers/net/netkit.c                               |    8 
 drivers/net/pfcp.c                                 |    2 
 drivers/net/ppp/ppp_generic.c                      |   13 
 drivers/net/team/team_core.c                       |    2 
 drivers/net/usb/qmi_wwan.c                         |   14 
 drivers/net/veth.c                                 |   11 
 drivers/net/vrf.c                                  |    6 
 drivers/net/vxlan/vxlan_core.c                     |   42 +
 drivers/net/wan/hdlc_fr.c                          |   18 -
 drivers/net/wan/lapbether.c                        |   28 +
 drivers/net/wireguard/device.c                     |    2 
 drivers/net/wireless/ath/ath6kl/core.c             |    2 
 drivers/net/wireless/ath/wil6210/netdev.c          |    2 
 drivers/net/wireless/marvell/mwifiex/main.c        |    5 
 drivers/net/wireless/quantenna/qtnfmac/core.c      |    2 
 drivers/net/wireless/virtual/virt_wifi.c           |    5 
 drivers/net/wwan/iosm/iosm_ipc_wwan.c              |    2 
 drivers/net/wwan/mhi_wwan_mbim.c                   |    2 
 drivers/net/wwan/t7xx/t7xx_netdev.c                |    4 
 drivers/net/wwan/wwan_core.c                       |   13 
 include/linux/netdevice.h                          |   38 +
 include/net/rtnetlink.h                            |   16 +
 net/6lowpan/core.c                                 |   16 -
 net/8021q/vlan.c                                   |   11 
 net/8021q/vlan_netlink.c                           |    1 
 net/batman-adv/soft-interface.c                    |    2 
 net/bridge/br_ioctl.c                              |    8 
 net/bridge/br_netlink.c                            |    2 
 net/caif/chnl_net.c                                |    2 
 net/core/dev.c                                     |  576 +++++++++++++++++++-
 net/core/dev_ioctl.c                               |    1 
 net/core/failover.c                                |   24 +
 net/core/rtnetlink.c                               |  478 ++++++++++++-----
 net/dsa/dsa.c                                      |   14 
 net/dsa/netlink.c                                  |    5 
 net/dsa/user.c                                     |   25 +
 net/hsr/hsr_device.c                               |    4 
 net/hsr/hsr_netlink.c                              |    6 
 net/ieee802154/6lowpan/core.c                      |    1 
 net/ieee802154/core.c                              |    2 
 net/ieee802154/nl802154.c                          |    8 
 net/ipv4/ip_tunnel.c                               |    4 
 net/ipv6/ip6_gre.c                                 |   28 +
 net/ipv6/ip6_tunnel.c                              |   37 +
 net/ipv6/ip6_vti.c                                 |   36 +
 net/ipv6/sit.c                                     |   45 +-
 net/mac80211/main.c                                |    2 
 net/mac802154/cfg.c                                |    2 
 net/mac802154/iface.c                              |   10 
 net/mac802154/main.c                               |    2 
 net/openvswitch/vport-netdev.c                     |    6 
 net/wireless/core.c                                |   12 
 net/wireless/nl80211.c                             |   15 +
 net/xfrm/xfrm_interface_core.c                     |    2 
 75 files changed, 1532 insertions(+), 303 deletions(-)

--
Signed-off-by: Kirill Tkhai <tkhai@ya.ru>

