Return-Path: <netdev+bounces-63618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6FF82E88C
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 05:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A28D3B22A86
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 04:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3A179C3;
	Tue, 16 Jan 2024 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="newwSWd4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41180B
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336746c7b6dso8045219f8f.0
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 20:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705379589; x=1705984389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vtgprrcfAFK6l5edeCTfoEsmi7Zy8skLJoFnOXJNk0c=;
        b=newwSWd4EAASEDn5meaNtuGq5Mazq1OuCax/oq9N46evhZGLupiZeigiBd2iWW0Cs6
         QwCI/Uw7Ek7T1NHNhZhOhCe6NUV4+QLkYPNLYI2zsLBgLiM1+PMAcWar6OemDERXoaiU
         xaZIAu44YvY5lc3qKRM6fw1zv1p/udUGqroSwzJeopssTmc+xZbfVBzksS0wWWQPu3th
         JxxzUJ6SFiwv6MHfd8Njv2z9ui/xRsbe01jzUB/fFscBkDYqNd5vL+6qQODOlOcoNwjW
         vFWYuZ647aG/o8ZI6S2mMJWJC+7uQdOaIf64jjdCg+8Iqa4EslgFLIK3osQSIH74AYI/
         gpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705379589; x=1705984389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtgprrcfAFK6l5edeCTfoEsmi7Zy8skLJoFnOXJNk0c=;
        b=qjY5wwcb6MTCfv6d4bP8xslPssyqmfec+TYIWF3n6nZzZ878fXKesSSHIyO2FHqoLe
         3OCaSHX7QvHeqjMaP+d/2jxNKLRpi6nz1VIzePy/F0FV9IFYpK981k5sDo2Sc522C6Vj
         p92ZhngJoSWwxyIytFXaf9y6GH2WGWQV3dnZGAk4tumTp/5MY8YymU/2I6+lsSpXSjrm
         qXgdCjV+y4vTTVAHTwfsvTYzJwE7PNeLqO2qSEPt5mljGYiLwOEIJfDl1DbZvhqpH6dq
         Y5TJf0iktSJFsBUa6bZoiFe9GEBD6fbpJcLyNVoazpjQBMTD0EHpfKZgaWH8LaEWLaqg
         6+OA==
X-Gm-Message-State: AOJu0YyzeBf7fmw7M8+RM6bEdk1dMIurjLaB5dlzH0NJ5qiW21Dc2d9U
	WNxNVlJThgngbvJHdWgqpfaydJ1evZPTRe1UjI0=
X-Google-Smtp-Source: AGHT+IHhs88O5jWV62l1HZLwBnT7EioZ4fGXMjV+rt4MKr/gwFu8l0cL5hMUoa8ea2K9Lrb281d3Oyg4esbt3vmmxHk=
X-Received: by 2002:adf:fa4c:0:b0:337:bc90:2148 with SMTP id
 y12-20020adffa4c000000b00337bc902148mr58995wrr.129.1705379588819; Mon, 15 Jan
 2024 20:33:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABumfLzJmXDN_W-8Z=p9KyKUVi_HhS7o_poBkeKHS2BkAiyYpw@mail.gmail.com>
 <20240115181545.ixme3ao4z4gyn5qq@skbuf>
In-Reply-To: <20240115181545.ixme3ao4z4gyn5qq@skbuf>
From: Simon Waterer <simon.waterer@gmail.com>
Date: Tue, 16 Jan 2024 17:32:57 +1300
Message-ID: <CABumfLwA5xMiag2+2Rjj6r12uqvnsTjrNGfp4HDp+pZ7vw-HLg@mail.gmail.com>
Subject: Re: DSA switch: VLAN tag not added on packets directed to a
 PVID,untagged switchport
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Vladimir,

Thank you very much for your response. You have exactly solved my
issue (it was the vlan_filtering not being set at the time of the
bridge creation and not helped by the
ds->configure_vlan_while_not_filtering = false in the driver), details
further below.

On Tue, 16 Jan 2024 at 07:15, Vladimir Oltean <olteanv@gmail.com> wrote:
>
> Hello Simon,
>
> The title of your email is not a good summary of the problem. As phrased,
> the title does not even describe a problem. "VLAN tags not added towards
> an egress-untagged port" is "working as per the description". You seem
> to be looking at a different (set of) problems, which I will detail
> below.

My apologies, it was a poorly worded title.

> On Mon, Jan 15, 2024 at 05:37:21PM +1300, Simon Waterer wrote:
> > Hello,
> >
> > I'm using a DSA switch with vlan_filtering enabled.
> >
> > When tcpdumping on the DSA master interface, and looking at the
> > packets egressing the Linux host towards the CPU port of the switch,
> > I'm observing that 802.1q vlan tags are only being added on packets
> > directed towards a trunk port of the switch. VLAN tags are not being
> > added on packets directed to a PVID,untagged switchport. The VLAN tags
> > are seen when tcpdumping the br0 device, but are lost by the time they
> > reach the DSA master interface.
>
> This part is expected of the bridge driver when the TX path is not
> offloaded [1]. It is the same regardless of the bridge port driver
> (DSA, e1000e, etc). If the software bridge decides that a VLAN-tagged
> skb should egress a port and that VLAN is untagged on the port, the VLAN
> tag will be stripped, otherwise it would appear on the wire.

Ok, understood.

> > This is an issue as the switch hardware proceeds to tag the packet
> > with the default VLAN id 1 when the untagged packet ingresses the
> > switch via the CPU port.
> >
> > Is this behaviour expected of DSA switch integration with VLANs?
> > Please may anyone offer a suggestion on what further I may look into
> > to troubleshoot this issue?
>
> So DSA tagging protocol drivers (in this case lan937x_netdev_ops) are
> expected to transmit packets in a way that bypasses the switching layer
> (aka they are sent as "control packets" rather than "data plane packets").
> Meaning that they are force-injected into the port specified in the DSA
> tag, regardless of FDB lookups, no VLAN processing, STP state of that
> port, etc. These are all bridging layer functions, so they should all be
> bypassed by the normal xmit procedure. The switch strips the DSA tag,
> and the rest of the packet (what appears on the wire) should be
> identical with what the host has passed it.
>
> This means that the problem is not in the bridge driver, not in the DSA
> master driver, and not in the DSA framework. It is in the Microchip KSZ
> switch driver, user of the DSA framework.
> From your logs, it appears that packets injected by Linux don't
> (completely) bypass the switching layer. They get classified to VID 1,
> which apparently is the PVID of the CPU port (for which no net_device
> exists). In this case, it has to be studied what can be done to
> configure the switch/tagger pair to behave as closely as possible to
> the expectation.
>
> The problem, one might argue, is that the switch is configured (by whom?
> I don't know - maybe this is the hardware default, maybe the driver has
> some code which I haven't found) with PVID=1 on the CPU port. The DSA
> framework does not manage the PVID VLAN of the CPU port, it is the
> driver's private responsibility. The problem with VID=1 is that it is a
> user visible VLAN, so the behavior of untagged traffic can be modulated
> (involuntarily) by the user, when issuing 'bridge vlan add/del' commands
> on user ports. It's better to use a VLAN that is not user visible, like
> VID=4095, as the VLAN to which the CPU port classifies VLAN-untagged
> packets. All user ports should be members of this VLAN, and all with the
> "egress untagged" property, so that no one outside the system knows that
> VID=4095 was used.

I suspect it is the hardware default. More on this later below.

> As opposed to VID=4095, it is possible for the user to reinstall VID=1
> without the "egress untagged" flag, and what will happen is that packets
> which were untagged in software are now VLAN-tagged on the wire.
>
> This also seems to be what's happening in your case (VID=1 behaves as
> egress-tagged), but you haven't presented any command which alters VID=1
> below, so it is strange [2]. I think you may have become a little bit
> confused by all the moving parts and many bugs in this driver and the
> way in which they interact - and so have I.
>
> For example, I found this patch on ksz8:
>
> commit af01754f9e3c553a2ee63b4693c79a3956e230ab
> Author: Ben Hutchings <ben.hutchings@mind.be>
> Date:   Tue Aug 10 00:59:47 2021 +0200
>
>     net: dsa: microchip: ksz8795: Fix VLAN untagged flag change on deletion
>
>     When a VLAN is deleted from a port, the flags in struct
>     switchdev_obj_port_vlan are always 0.  ksz8_port_vlan_del() copies the
>     BRIDGE_VLAN_INFO_UNTAGGED flag to the port's Tag Removal flag, and
>     therefore always clears it.
>
>     In case there are multiple VLANs configured as untagged on this port -
>     which seems useless, but is allowed - deleting one of them changes the
>     remaining VLANs to be tagged.
>
>     It's only ever necessary to change this flag when a VLAN is added to
>     the port, so leave it unchanged in ksz8_port_vlan_del().
>
>     Fixes: e66f840c08a2 ("net: dsa: ksz: Add Microchip KSZ8795 DSA driver")
>     Signed-off-by: Ben Hutchings <ben.hutchings@mind.be>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>
> and the ksz9477_port_vlan_del() (also used by LAN937x) seems to have a
> similar issue as well: "vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED" is
> invalid on port_vlan_del(), and ought to be ignored, but is not. Sadly,
> I don't think it helps the explanation here, because it just means that
> this is dead code:
>
>         if (untagged)
>                 vlan_table[1] &= ~BIT(port);
>
> ...

So a similar fix to ksz9477.c would be as follows?

int ksz9477_port_vlan_del(struct ksz_device *dev, int port,
const struct switchdev_obj_port_vlan *vlan)
{
- bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
u32 vlan_table[3];
u16 pvid;

ksz_pread16(dev, port, REG_PORT_DEFAULT_VID, &pvid);
pvid = pvid & 0xFFF;

if (ksz9477_get_vlan_table(dev, vlan->vid, vlan_table)) {
dev_dbg(dev->dev, "Failed to get vlan table\n");
return -ETIMEDOUT;
}

vlan_table[2] &= ~BIT(port);

if (pvid == vlan->vid)
pvid = 1;

- if (untagged)
- vlan_table[1] &= ~BIT(port);
-
if (ksz9477_set_vlan_table(dev, vlan->vid, vlan_table)) {
dev_dbg(dev->dev, "Failed to set vlan table\n");
return -ETIMEDOUT;
}

ksz_pwrite16(dev, port, REG_PORT_DEFAULT_VID, pvid);

return 0;
}

I've applied this change to my version of the driver and will test to
see if any issues result.

> Separately, another bug in ksz9477_port_vlan_del() is this:
>
>         if (pvid == vlan->vid)
>                 pvid = 1;
>
> When deleting the PVID VLAN, the documented expected behavior of Linux
> is that the port should drop incoming untagged and priority-tagged
> traffic. But this driver changes the PVID to 1, and that's not ok.

What would the suggested fix be for this one? I expect it would be to
just not touch the PVID at all within ksz9477_port_vlan_del. As
follows (based on previous change already applied)?

int ksz9477_port_vlan_del(struct ksz_device *dev, int port,
const struct switchdev_obj_port_vlan *vlan)
{
u32 vlan_table[3];
- u16 pvid;
-
- ksz_pread16(dev, port, REG_PORT_DEFAULT_VID, &pvid);
- pvid = pvid & 0xFFF;

if (ksz9477_get_vlan_table(dev, vlan->vid, vlan_table)) {
dev_dbg(dev->dev, "Failed to get vlan table\n");
return -ETIMEDOUT;
}

vlan_table[2] &= ~BIT(port);

- if (pvid == vlan->vid)
- pvid = 1;
-
if (ksz9477_set_vlan_table(dev, vlan->vid, vlan_table)) {
dev_dbg(dev->dev, "Failed to set vlan table\n");
return -ETIMEDOUT;
}

- ksz_pwrite16(dev, port, REG_PORT_DEFAULT_VID, pvid);
-
return 0;
}

Again, I've applied this change to my version of the driver and will
test to see if any issues result, and happy to submit a patch with
those changes.

Further, the referenced ksz8_port_vlan_del has a block to 'Invalidate
the entry if no more members'. Perhaps the same logic should apply to
ksz9477_port_vlan_del? i.e.:

int ksz9477_port_vlan_del(struct ksz_device *dev, int port,
const struct switchdev_obj_port_vlan *vlan)
{
u32 vlan_table[3];

if (ksz9477_get_vlan_table(dev, vlan->vid, vlan_table)) {
dev_dbg(dev->dev, "Failed to get vlan table\n");
return -ETIMEDOUT;
}

vlan_table[2] &= ~BIT(port);

+ /* Invalidate the entry if no more member. */
+ if (!vlan_table[2]) {
+ vlan_table[0] &= ~VLAN_VALID;
+ }
+
if (ksz9477_set_vlan_table(dev, vlan->vid, vlan_table)) {
dev_dbg(dev->dev, "Failed to set vlan table\n");
return -ETIMEDOUT;
}

return 0;
}

> In ksz9477_port_vlan_add(), I should also mention that the BIT(dev->cpu_port)
> handling should not be there. The DSA framework manages VLANs on the shared
> (CPU and DSA) ports explicitly since commit 134ef2388e7f ("net: dsa: add
> explicit support for host bridge VLANs") from kernel 5.18, and is
> guaranteed to do so better than the driver. Its handling from vlan_table[2]
> (the port membership mask) should be removed and tested without it.
> The other use of dev->cpu_port is to control the "egress untagged" port
> mask from vlan_table[1], aka to always program the VLANs as
> egress-tagged towards the CPU. That is fine to keep, because the VLAN
> "flags" that DSA framework notifies the CPU port with are the flags of
> the VLAN added on the "br0" interface (with the 'self' flag). It is
> legal for drivers to override this. But, when doing this, the driver
> should set ds->untag_bridge_pvid = true, to remove the VLAN tags in
> the software RX path if not needed.

Ok, I've also made the below change to remove the handling of cpu_port
in vlan_table[2] and will test if it causes any issues.

int ksz9477_port_vlan_add(struct ksz_device *dev, int port,
const struct switchdev_obj_port_vlan *vlan,
struct netlink_ext_ack *extack)
{
u32 vlan_table[3];
bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
int err;

err = ksz9477_get_vlan_table(dev, vlan->vid, vlan_table);
if (err) {
NL_SET_ERR_MSG_MOD(extack, "Failed to get vlan table");
return err;
}

vlan_table[0] = VLAN_VALID | (vlan->vid & VLAN_FID_M);
if (untagged)
vlan_table[1] |= BIT(port);
else
vlan_table[1] &= ~BIT(port);
vlan_table[1] &= ~(BIT(dev->cpu_port) | BIT(dev->dsa_port));

- vlan_table[2] |= BIT(port) | BIT(dev->cpu_port);
+ vlan_table[2] |= BIT(port);

err = ksz9477_set_vlan_table(dev, vlan->vid, vlan_table);
if (err) {
NL_SET_ERR_MSG_MOD(extack, "Failed to set vlan table");
return err;
}

/* change PVID */
if (vlan->flags & BRIDGE_VLAN_INFO_PVID)
ksz_pwrite16(dev, port, REG_PORT_DEFAULT_VID, vlan->vid);

return 0;
}

>
> > More information:
> >
> > The DSA switch consists of 2 Microchip LAN9373 switches in cascade mode.
> > The system is iMX8 running Linux 6.1.36.
> > The master interface is eth1.
> > The user ports are labelled afe0, afe1, afe2, etc.
> >
> > Setup is as follows:
> >
> > ethtool -K eth1 rx-vlan-offload off # in order to see vlan tags on eth1 ingress traffic
> > ip link add br0 type bridge
> > ip link add link br0 name br0.10 type vlan id 10
> > ip addr add 192.168.10.1/24 dev br0.10
> > ip link add link br0 name br0.20 type vlan id 20
> > ip addr add 192.168.20.1/24 dev br0.20
> > ip link add link br0 name br0.30 type vlan id 30
> > ip addr add 192.168.30.1/24 dev br0.30
> > ip link set dev afe0 master br0
> > ip link set dev afe1 master br0
> > ip link set dev br0 type bridge vlan_filtering 1
>
> This right here, while a perfectly legal command, also makes evaluating
> what goes on all that more difficult.
>
> See, there is a difference between creating a bridge as VLAN-aware
> straight away (ip link add dev br0 type bridge vlan_filtering 1) and
> making it VLAN-unaware, telling the ports to join the bridge, and
> then making it VLAN-aware dynamically.

This is exactly it.

By making the bridge VLAN-aware at the time of creating the bridge, it
exactly solved the issue I was facing. So the command becomes as you
have written (ip link add dev br0 type bridge vlan_filtering 1). Now
the ARP reply packets are being received (at the device originating
the ping) as untagged exactly as I expect:

15:46:47.603761 00:e0:4c:68:0d:66 > ff:ff:ff:ff:ff:ff, ethertype ARP
(0x0806), length 42: Request who-has 192.168.30.1 tell 192.168.30.251,
length 28
15:46:47.605409 ea:38:5b:06:97:75 > 00:e0:4c:68:0d:66, ethertype ARP
(0x0806), length 60: Reply 192.168.30.1 is-at ea:38:5b:06:97:75,
length 46
15:46:47.605439 00:e0:4c:68:0d:66 > ea:38:5b:06:97:75, ethertype IPv4
(0x0800), length 98: 192.168.30.251 > 192.168.30.1: ICMP echo request,
id 28, seq 1, length 64
15:46:47.606538 ea:38:5b:06:97:75 > 00:e0:4c:68:0d:66, ethertype IPv4
(0x0800), length 98: 192.168.30.1 > 192.168.30.251: ICMP echo reply,
id 28, seq 1, length 64
...

This also solved the other issue I noted below that after running a
"bridge vlan del dev <device> vid 1" command, the entry for VID=1
never disappeared from the ouput of "bridge vlan show". Now (if bridge
is VLAN-aware at creation) it does remove the VID=1 when executing a
"bridge vlan del dev <device> vid 1" command.

> There was a bug in the DSA framework and API which got fixed, but it was
> not fully understood of what the impact upon drivers was, so their old
> behavior was kept intact, when those could not be tested. Nowadays, this
> is guarded by a flag unset in a minority of drivers like this:
>
>         ds->configure_vlan_while_not_filtering = false;
>
> which the ksz_common.c file executes exactly like so.
>
> When opting into this legacy and known-buggy behavior, what happens is
> that your afeN ports first join the VLAN-unaware bridge. The bridge
> notifies the default VLANs through switchdev (aka VID=1, as PVID +
> egress untagged), but ds->configure_vlan_while_not_filtering is set, and
> as the DSA core logic goes, "we are not VLAN-filtering, so we don't
> configure the VLANs". Why this logic is as such, is not very relevant or
> worth digging into. What is relevant is that with the logic enabled, DSA
> will not call .port_vlan_add() for VID=1, and will instead print a
> "skipping configuration of VLAN" warning extack message through netlink.

Yes, the "skipping configuration of VLAN" was being printed in my
original setup when the bridge was created as VLAN-unaware.

> If VID=1 is not actually programmed as egress-untagged by the driver
> because of the above bug, I can only suspect that the hardware comes
> pre-programmed with VID=1 as PVID and egress-tagged on all ports as the
> default, and no one overrides this? Thus, untagged packets received on
> the CPU port are later sent with VID=1 on the wire, whereas VLAN-tagged
> packets received on the CPU port are always classified to the VID from
> the 802.1Q header, and never to the CPU port PVID. To me it seems
> plausible that this is what's happening, with 2 bugs interacting with
> each other in this roundabout way. It doesn't make much sense otherwise.
> Or you may have run some more commands which you haven't shown, which
> have affected the state of the system.

No other commands were being run than what I had shown.

It is quite hard to tell what the hardware default is from the
documentation. The "Microchip AN4005 LAN937x Register Definitions"
document does state at "TABLE 136: GLOBAL VLAN TABLE ENTRY 2 REGISTER"
the default value of the "UNTAG" field is 0, which means all ports
have 0 in the bitfield, which is stated to mean: "0 = Do not untag".
Presumably this could be interpreted to mean that the hardware is
pre-programmed with egress-tagged for VID=1 for all ports.

As a test, I added code to the driver to query the VLAN table entry
for VID=1 on each port, immediately after the switch is reset in
ksz_setup() function in ksz_common.c. The output as below shows the
initial value in vlan_entry[1] is 0x00000000 for VID=1 for all ports.
I think this confirms that the hardware default is to program VID=1 as
PVID and egress-tagged on all ports.

ksz-switch spi1.0: port=0 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.0: port=1 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.0: port=2 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.0: port=3 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.0: port=4 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.0: port=5 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.0: port=6 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.0: port=7 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.1: port=0 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.1: port=1 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.1: port=2 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.1: port=3 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.1: port=4 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.1: port=5 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.1: port=6 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
ksz-switch spi1.1: port=7 vid=1 vlan_entry[0]=0x80000000
vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1

As you were originally talking about the
configure_vlan_while_not_filtering flag, as another test, I removed
the line of code in ksz_common.c that sets:

        ds->configure_vlan_while_not_filtering = false;

And using the original setup commands (where the bridge is first
created as VLAN-unaware, then the switchports are added, then the
bridge is made VLAN-aware): this also exactly solved my issue (and I
also did not see the "skipping configuration of VLAN" message,
confirming that the logic in DSA did not skip VLAN configuration on
the VLAN-unaware bridge as you described above).

So it would seem that the setting of
configure_vlan_while_not_filtering to false within the Microchip
LAN9373 driver is not a useful or helpful behaviour for my use case.

> I would absolutely appreciate patches to handle this condition correctly,
> so that we can get rid of the ds->configure_vlan_while_not_filtering
> flag. To handle it correctly would mean to do as instructed in the
> "Bridge VLAN filtering" section of Documentation/networking/switchdev.rst.

Unfortunately I do not have the expertise to assess if the LAN937X
driver would be in conformance with that documentation if the
ds->configure_vlan_while_not_filtering = false is removed from the
driver code. Simply removing that line of code from ksz_common.c seems
to have not have had any harmful side-effects in my use case.

> > bridge vlan add dev br0 vid 10 self
> > bridge vlan add dev br0 vid 20 self
> > bridge vlan add dev br0 vid 30 self
> > bridge vlan add vid 10 dev afe0
> > bridge vlan add vid 30 dev afe0
> > bridge vlan add vid 20 dev afe0
> > bridge vlan add vid 30 dev afe1 pvid untagged
> > ip link set dev br0 up
> > ip link set dev br0.10 up
> > ip link set dev br0.20 up
> > ip link set dev br0.30 up
> > ip link set dev afe0 up
> > ip link set dev afe1 up
> >
> >
> > Example showing expected behaviour:
> > -----------------------------------
> > When sending a ping to 192.168.30.1 from another device (IP:
> > 192.168.30.251) that is connected to the tagged port "afe0", behaviour
> > is as expected:
> >
> > tcpdump on device sending the ping:
> >    listening on enx00e04c3ff8c2, link-type EN10MB (Ethernet), capture size 262144 bytes
> >    13:23:37.412278 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP, Request who-has 192.168.30.1 tell 192.168.30.251, length 28
> >    13:23:37.414159 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 60: vlan 30, p 0, ethertype ARP, Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 42
> >    13:23:37.414170 00:e0:4c:3f:f8:c2 > ea:38:5b:06:97:75, ethertype 802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4, 192.168.30.251 > 192.168.30.1: ICMP echo request, id 48, seq 1, length      64
> >    13:23:37.415247 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4, 192.168.30.1 > 192.168.30.251: ICMP echo reply, id 48, seq 1, length 64
> >
> >    Here, the ping is successful with the device receiving the ARP
> > reply and ICMP echo reply with vlan id 30 (as expected).
> >
> > tcpdump on DSA master interface eth1:
> >    listening on eth1, link-type NULL (BSD loopback), snapshot length 262144 bytes
> >    13:27:46.917763 AF Unknown (4294967295), length 65:
> >        0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
> >        0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
> >        0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
> >        0x0030:  0000 0000 0000 0000 0000 0000 00         .............
> >    13:27:46.917905 AF Unknown (14699583), length 63:
> >        0x0000:  f8c2 ea38 5b06 9775 8100 001e 0806 0001  ...8[..u........
> >        0x0010:  0800 0604 0002 ea38 5b06 9775 c0a8 1e01  .......8[..u....
> >        0x0020:  00e0 4c3f f8c2 c0a8 1efb 0000 0000 0000  ..L?............
> >        0x0030:  0000 0000 0000 0000 2000 01              ...........
> >    13:27:46.918932 AF Unknown (3929561862), length 103:
> >        0x0000:  9775 00e0 4c3f f8c2 8100 001e 0800 4500  .u..L?........E.
> >        0x0010:  0054 022e 4000 4001 7a2e c0a8 1efb c0a8  .T..@.@.z.......
> >        0x0020:  1e01 0800 28d1 0030 0001 097b a465 0000  ....(..0...{.e..
> >        0x0030:  0000 5c4a 0600 0000 0000 1011 1213 1415  ..\J............
> >        0x0040:  1617 1819 1a1b 1c1d 1e1f 2021 2223 2425  ...........!"#$%
> >        0x0050:  2627 2829 2a2b 2c2d 2e2f 3031 3233 3435  &'()*+,-./012345
> >        0x0060:  3637 00                                  67.
> >    13:27:46.919035 AF Unknown (14699583), length 105:
> >        0x0000:  f8c2 ea38 5b06 9775 8100 001e 0800 4500  ...8[..u......E.
> >        0x0010:  0054 f562 0000 4001 c6f9 c0a8 1e01 c0a8  .T.b..@.........
> >        0x0020:  1efb 0000 30d1 0030 0001 097b a465 0000  ....0..0...{.e..
> >        0x0030:  0000 5c4a 0600 0000 0000 1011 1213 1415  ..\J............
> >        0x0040:  1617 1819 1a1b 1c1d 1e1f 2021 2223 2425  ...........!"#$%
> >        0x0050:  2627 2829 2a2b 2c2d 2e2f 3031 3233 3435  &'()*+,-./012345
> >        0x0060:  3637 2000 01                             67...
> >
> >    Here, the vlan tag (81 00 00 1e) is shown on both the ingress and
> > egress packets with expected vid 30 (0x1e).
>
> Ok, you are showing here that when we are targeting afe0 (egress-tagged
> in VID 30), both ingress and egress packets are tagged with VID=30.
> Not surprising.
>
> >    Here also, the tailtags from/to the switch hardware (tag_ksz) are observed:
> >    - ingress tailtags (the 00 octet at end of ingress packets).
> >    - egress tailtags (the 20 00 01 octets at end of egress packets)
> >
> > tcpdump on br0:
> >    listening on br0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> >    13:27:46.917815 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806), Request who-has 192.168.30.1 tell 192.168.30.251, length 46
> >    13:27:46.917869 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806), Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28
> >    13:27:46.918945 00:e0:4c:3f:f8:c2 > ea:38:5b:06:97:75, ethertype 802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4 (0x0800), 192.168.30.251 > 192.168.30.1: ICMP echo request, id 48, seq       1, length 64
> >    13:27:46.919016 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4 (0x0800), 192.168.30.1 > 192.168.30.251: ICMP echo reply, id 48, seq 1,      length 64
> >
> >    Here, vlan tag IDs have been decoded as the ingress packets passes
> > up to br0 and same vlan id 30 is shown on the reply packets.
>
> Yes, the br0 termination path sees packets tagged with VID=30, and you
> use the br0.30 VLAN upper to strip VID=30 and consume this traffic as
> untagged. Clear and as expected.
>
> > Example showing the erroneous behaviour:
> > ----------------------------------------
> > But, when connecting the other device to the PVID,untagged port
> > "afe1", the following is observed:
> >
> > tcpdump on device sending the ping:
> >    listening on enx00e04c3ff8c2, link-type EN10MB (Ethernet), capture size 262144 bytes
> >    13:31:23.862699 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.168.30.1 tell 192.168.30.251, length 28
> >    13:31:23.864551 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 64: vlan 1, p 0, ethertype ARP, Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 46
> >    13:31:24.890952 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.168.30.1 tell 192.168.30.251, length 28
> >    13:31:24.892810 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 64: vlan 1, p 0, ethertype ARP, Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 46
> >    13:31:25.910959 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.168.30.1 tell 192.168.30.251, length 28
> >    13:31:25.912828 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 64: vlan 1, p 0, ethertype ARP, Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 46
> >
> >    Here, the reply packet errorneously contains vlan tag for vlan id
> > 1, when it was expected to be untagged-on-egress from the switch, and
> > was expected to have vlan id 30.
>
> So "reply packet" (ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2) means actually
> what afe1 puts on the wire.
>
> I'm not sure why on the wire, it was expected to have VID=30 as you say,
> rather than be untagged? The ARP request (00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff)
> was VLAN-untagged.
>
> > tcpdump on DSA master interface eth1:
> >    listening on eth1, link-type NULL (BSD loopback), snapshot length
> > 262144 bytes
> >    13:35:33.363982 AF Unknown (4294967295), length 65:
> >        0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
> >        0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
> >        0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
> >        0x0030:  0000 0000 0000 0000 0000 0000 01         .............
> >    13:35:33.364186 AF Unknown (14699583), length 63:
> >        0x0000:  f8c2 ea38 5b06 9775 0806 0001 0800 0604  ...8[..u........
> >        0x0010:  0002 ea38 5b06 9775 c0a8 1e01 00e0 4c3f  ...8[..u......L?
> >        0x0020:  f8c2 c0a8 1efb 0000 0000 0000 0000 0000  ................
> >        0x0030:  0000 0000 0000 0000 2000 02              ...........
> >    13:35:34.392257 AF Unknown (4294967295), length 65:
> >        0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
> >        0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
> >        0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
> >        0x0030:  0000 0000 0000 0000 0000 0000 01         .............
> >    13:35:34.392385 AF Unknown (14699583), length 63:
> >        0x0000:  f8c2 ea38 5b06 9775 0806 0001 0800 0604  ...8[..u........
> >        0x0010:  0002 ea38 5b06 9775 c0a8 1e01 00e0 4c3f  ...8[..u......L?
> >        0x0020:  f8c2 c0a8 1efb 0000 0000 0000 0000 0000  ................
> >        0x0030:  0000 0000 0000 0000 2000 02              ...........
> >    13:35:35.412251 AF Unknown (4294967295), length 65:
> >        0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
> >        0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
> >        0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
> >        0x0030:  0000 0000 0000 0000 0000 0000 01         .............
> >    13:35:35.412384 AF Unknown (14699583), length 63:
> >        0x0000:  f8c2 ea38 5b06 9775 0806 0001 0800 0604  ...8[..u........
> >        0x0010:  0002 ea38 5b06 9775 c0a8 1e01 00e0 4c3f  ...8[..u......L?
> >        0x0020:  f8c2 c0a8 1efb 0000 0000 0000 0000 0000  ................
> >        0x0030:  0000 0000 0000 0000 2000 02              ...........
> >
> >    Here, the vlan tag (81 00 00 1e) is *ONLY* present on the *ingress*
> > packets (the ARP requests), and *ABSENT* from the *egress* packets
> > (the ARP replies).
>
> Yes, this is normal operation which can be reproduced with any other
> driver, this is not the problem. The problem is that the switch inserts
> VID=1 into untagged packets when it was not told to do that.

Yes, agreed.

> >    Here also, the tailtags from/to the switch hardware (tag_ksz) are
> > observed and are as expected, this time corresponding to switch-port
> > "afe1".
> >
> > tcpdump on br0:
> >    listening on br0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> >    13:35:33.364069 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806), Request who-has 192.168.30.1 tell 192.168.30.251, length 46
> >    13:35:33.364154 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806), Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28
> >    13:35:34.392307 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806), Request who-has 192.168.30.1 tell 192.168.30.251, length 46
> >    13:35:34.392356 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806), Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28
> >    13:35:35.412300 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806), Request who-has 192.168.30.1 tell 192.168.30.251, length 46
> >    13:35:35.412355 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806), Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28
> >
> >    Here, vlan tag IDs have been decoded as the packet passes up to
> > br0, and vlan id 30 is present on the replies, yet the vlan tag appear
> > to be dropped when the packet is sent down from br0 to eth1, as not
> > visible in the tcpdump of eth1 above.
> >
> > I have checked and confirmed that "tx-vlan-offload" is "off" for eth1.

> The "tx-vlan-offload" flag is not relevant for this.

Ok.

>
> > Other information:
> > ------------------
> > root@imx8qxp-var-som:~# route -n
> > Kernel IP routing table
> > Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
> > 10.10.1.0       0.0.0.0         255.255.255.0   U     0      0        0 eth0
> > 192.168.10.0    0.0.0.0         255.255.255.0   U     0      0        0 br0.10
> > 192.168.20.0    0.0.0.0         255.255.255.0   U     0      0        0 br0.20
> > 192.168.30.0    0.0.0.0         255.255.255.0   U     0      0        0 br0.30
> >
> > root@imx8qxp-var-som:~# bridge vlan
> > port              vlan-id
> > afe0              1 PVID Egress Untagged
> >                  10
> >                  20
> >                  30
> > afe1              1 Egress Untagged
> >                  30 PVID Egress Untagged
> > afe3              1 Egress Untagged
> >                  30 PVID Egress Untagged
> > afe4              1 Egress Untagged
> >                  20 PVID Egress Untagged
> > afe2              1 Egress Untagged
> >                  30 PVID Egress Untagged
> > afe5              1 Egress Untagged
> >                  30 PVID Egress Untagged
> > afe6              1 Egress Untagged
> >                  30 PVID Egress Untagged
> > afe8              1 Egress Untagged
> >                  30 PVID Egress Untagged
> > afe9              1 Egress Untagged
> >                  30 PVID Egress Untagged
> > afe7              1 Egress Untagged
> >                  30 PVID Egress Untagged
> > br0               1 PVID Egress Untagged
> >                  10
> >                  20
> >                  30
> >
> > Note: Another observation is that even after running "bridge vlan del
> > dev afe0 vid 1" or "bridge vlan del dev afe1 vid 1", the entry for
> > vlan-id 1 never disappears from the ouput of "bridge vlan show"
>
> How sure are you about this? It does not seem very plausible.
> Did the "bridge vlan del" command succeed?

Yes I am sure about this (reproducible). But making the bridge
VLAN-aware at time of creation fixes it, as described above.

> > root@imx8qxp-var-som:~# bridge fdb
> > 33:33:00:00:00:01 dev eth0 self permanent
> > 01:00:5e:00:00:01 dev eth0 self permanent
> > 33:33:00:00:00:01 dev eth1 self permanent
> > 01:00:5e:00:00:01 dev eth1 self permanent
> > f8:dc:7a:bb:54:a1 dev afe0 vlan 20 master br0 permanent
> > f8:dc:7a:bb:54:a1 dev afe0 vlan 30 master br0 permanent
> > f8:dc:7a:bb:54:a1 dev afe0 vlan 10 master br0 permanent
> > f8:dc:7a:bb:54:a1 dev afe0 vlan 1 master br0 permanent
> > f8:dc:7a:bb:54:a1 dev afe0 master br0 permanent
> > 00:e0:4c:3f:f8:c2 dev afe1 vlan 30 master br0
> > 00:e0:4c:3f:f8:c2 dev afe1 vlan 10 self
> > 00:e0:4c:3f:f8:c2 dev afe1 vlan 20 self
> > 00:e0:4c:3f:f8:c2 dev afe1 vlan 30 self
> > 33:33:00:00:00:01 dev br0 self permanent
> > 01:80:c2:00:00:21 dev br0 self permanent
> > 01:00:5e:00:00:6a dev br0 self permanent
> > 33:33:00:00:00:6a dev br0 self permanent
> > 01:00:5e:00:00:01 dev br0 self permanent
> > ea:38:5b:06:97:75 dev br0 vlan 30 master br0 permanent
> > ea:38:5b:06:97:75 dev br0 vlan 20 master br0 permanent
> > ea:38:5b:06:97:75 dev br0 vlan 10 master br0 permanent
> > ea:38:5b:06:97:75 dev br0 vlan 1 master br0 permanent
> > ea:38:5b:06:97:75 dev br0 master br0 permanent
> > 33:33:00:00:00:01 dev br0.10 self permanent
> > 01:00:5e:00:00:01 dev br0.10 self permanent
> > 33:33:00:00:00:01 dev br0.20 self permanent
> > 01:00:5e:00:00:01 dev br0.20 self permanent
> > 33:33:00:00:00:01 dev br0.30 self permanent
> > 01:00:5e:00:00:01 dev br0.30 self permanent
> >
> > root@imx8qxp-var-som:~# ip a
> > 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
> >    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> >    inet 127.0.0.1/8 scope host lo
> >       valid_lft forever preferred_lft forever
> > 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a0 brd ff:ff:ff:ff:ff:ff
> >    inet 10.10.1.4/24 brd 10.10.1.255 scope global eth0
> >       valid_lft forever preferred_lft forever
> > 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1507 qdisc mq state UP group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 4: afe0@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 5: afe1@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br0 state UP group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 6: afe3@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 7: afe4@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 8: afe2@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 9: afe5@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 10: afe6@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 11: afe8@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 12: lan1@eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 13: lan2@eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 14: afe9@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 15: afe7@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
> >    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> > 16: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
> >    link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
> > 17: br0.10@br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
> >    link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
> >    inet 192.168.10.1/24 scope global br0.10
> >       valid_lft forever preferred_lft forever
> > 18: br0.20@br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
> >    link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
> >    inet 192.168.20.1/24 scope global br0.20
> >       valid_lft forever preferred_lft forever
> > 19: br0.30@br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
> >    link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
> >    inet 192.168.30.1/24 scope global br0.30
> >       valid_lft forever preferred_lft forever
> >
> > Best Regards,
> > Simon
> >
>
> Sorry that this wasn't very straight or completely certain, but I hope
> you're looking a bit more in the right direction now. Depending on your
> level of hacking experience and interest in getting this fixed, you
> could make the patches yourself and submit for review (preferable
> because you have the hardware to test), or I could send to you untested
> patches and you could report back as to how they behave? The latter
> would be a bit more tedious.
>
> Vladimir
>
> [1] The TX path of the bridge can also be offloaded (see the "bool
> *tx_fwd_offload" argument of port_bridge_join() and the "Bridge layer"
> section of Documentation/networking/dsa/dsa.rst). When offloaded,
> packets will always be passed down by the bridge software as
> VLAN-tagged, and it is the responsibility of the driver to untag them
> [ in hardware ]. The asymmetry you are witnessing, with the RX path
> seeing VLAN tagged packets and TX seeing VLAN untagged, is due to the
> lack of offloading in the TX direction. Though it should have worked
> without the TX offload too.
>
> [2] Except "bridge vlan add vid 30 dev afe1 pvid untagged". Because
> there is only one PVID on a port at any given time, and VID=1 was the
> previous PVID, this operation implicitly changes the "pvid" flag of
> VID=1. But not the "untagged" flag, and as "pvid" is an ingress flag
> while "untagged" is an egress flag, this should not be relevant here.

Thank you, you have pointed me in exactly the right direction to help
me solve my issue.

I should point out that I have applied a series of vendor patches to
the Microchip LAN9373 driver on top of the mainline Linux 6.1.36
driver. The patches are found at:
https://github.com/microchip-ung/lan937x_linux/tree/main/src/Atmel_SOC_SAMA5D3/buildroot_external_lan937x/board/atmel/sama5d3_xplained_lan937x/patches/linux/6.0-rc4

In addition to those patches, I have made a few fixes of my own to the
LAN937X driver code where required.

Now that I understand a lot more about how this driver works (after a
few months of working with it now), I expect there is a certain
minimal set of changes that I can extract from the above patch series
in order to gain the functionality that I needed (the support for
cascaded switches and insertion of the 3-byte cascade tail tag,
essentially) and consider submitting them as patches for review

I'm also aware of the patch series at
https://lore.kernel.org/netdev/20230202125930.271740-2-rakesh.sankaranarayanan@microchip.com/
and I note the existing review comments against that patch series. In
my version of the driver I have had to force the selection of
DSA_TAG_PROTO_LAN937X_CASCADE_VALUE by ksz_get_tag_protocol() due to
the incorrect logic within that function.

On another note, I had tremendous trouble configuring the LAN9373 to
talk RGMII nicely with the iMX8 FEC. In the end it was two register
settings that needed to be set appropriately in order to allow the
RGMII to work. I do wonder if the LAN937X driver should provide
appropriate default behaviour, for the following:

- Disable In-Band-Status (IBS) on the RGMII port(s). This requirement
is not described in the datasheet for the hardware, however it is
documented at https://microchip.my.site.com/s/article/Ethernet-MAC-to-PHY-speed-matching-and-IBS-for-RGMII.
The ksz_set_xmii() in ksz_common.c does have code to disable RGMII
in-band status support for chip ids KSZ9893_CHIP_ID and
KSZ8563_CHIP_ID. I added code to a similar effect to set the
appropriate register for LAN937x, which has worked for me. I am not
certain if I should submit a patch for this, as it seems like
something that should be user-controllable, rather than hard-coded in
the driver, i.e. from a device tree property? Or perhaps it can be
inferred by the presence of a "fixed-link" for an RGMII port, then the
driver should disable IBS on that port. (Here is the patch originally
introducing it for KSZ9893:
https://lore.kernel.org/netdev/20200905140325.108846-4-pbarker@konsulko.com/).

- Disable the Virtual PHY function of the switch. Otherwise the RGMII
interface selects an incorrect link speed and/or duplex mode as the
hardware seems to expecting some software agent to instruct it via the
Virtual PHY. In this case I think it makes sense for the driver to
always disable Virtual PHY since DSA is the software agent controlling
the swtich I don't see any way that the hardware will work with DSA if
the Virtual PHY is left enabled?


And on a completely different note, I've also been having trouble to
get the LAN9373 SGMII ports to interface with a TI DP83TC812.
Whilst the driver does bringup the PHY:
[ 11.267701] ksz-switch spi1.1 lan1 (uninitialized): PHY
[5b040000.ethernet-1:0c] driver [TI DP83TC812CS2.0] (irq=POLL)

And ethtool reports that a link is detected at 100Mb/s (the only link
speed supported by that PHY):
root@imx8qxp-var-som:~# ethtool lan1
Settings for lan1:
Supported ports: [ TP MII ]
Supported link modes: 100baseT/Full
Supported pause frame use: No
Supports auto-negotiation: No
Supported FEC modes: Not reported
Advertised link modes: Not reported
Advertised pause frame use: No
Advertised auto-negotiation: No
Advertised FEC modes: Not reported
Speed: 100Mb/s
Duplex: Full
Auto-negotiation: off
Port: Twisted Pair
PHYAD: 12
Transceiver: external
MDI-X: Unknown
Supports Wake-on: d
Wake-on: d
Link detected: yes

But I'm seeing rx_crc_errors and rx_jabbers on the switchport's PHY statistics:
root@imx8qxp-var-som:~# ethtool -S lan1
NIC statistics:
tx_packets: 13
tx_bytes: 1230
rx_packets: 0
rx_bytes: 0
rx_hi: 0
rx_undersize: 0
rx_fragments: 0
rx_oversize: 0
rx_jabbers: 19
rx_symbol_err: 0
rx_crc_err: 110
rx_align_err: 0
rx_mac_ctrl: 0
rx_pause: 0
rx_bcast: 0
rx_mcast: 0
rx_ucast: 0
rx_64_or_less: 0
rx_65_127: 0
rx_128_255: 0
rx_256_511: 0
rx_512_1023: 110
rx_1024_1522: 0
rx_1523_2000: 0
rx_2001: 0
tx_hi: 0
tx_late_col: 0
tx_pause: 0
tx_bcast: 12
tx_mcast: 1
tx_ucast: 0
tx_deferred: 0
tx_total_col: 0
tx_exc_col: 0
tx_single_col: 0
tx_mult_col: 0
rx_total: 111921
tx_total: 1288
rx_discards: 0
tx_discards: 0

As well as align_errors on the device connected to the SGMII PHY:
$ ethtool -S enx00e04c680d66
NIC statistics:
tx_packets: 315
rx_packets: 0
tx_errors: 0
rx_errors: 0
rx_missed: 0
align_errors: 1
tx_single_collisions: 0
tx_multi_collisions: 0
rx_unicast: 0
rx_broadcast: 0
rx_multicast: 0
tx_aborted: 0
tx_underrun: 0
$ ethtool enx00e04c680d66
Settings for enx00e04c680d66:
Supported ports: [ TP MII ]
Supported link modes: 10baseT/Half 10baseT/Full
100baseT/Half 100baseT/Full
1000baseT/Half 1000baseT/Full
Supported pause frame use: No
Supports auto-negotiation: Yes
Supported FEC modes: Not reported
Advertised link modes: 10baseT/Half 10baseT/Full
100baseT/Half 100baseT/Full
1000baseT/Full
Advertised pause frame use: Symmetric Receive-only
Advertised auto-negotiation: Yes
Advertised FEC modes: Not reported
Link partner advertised link modes: 10baseT/Half 10baseT/Full
100baseT/Half 100baseT/Full
Link partner advertised pause frame use: No
Link partner advertised auto-negotiation: Yes
Link partner advertised FEC modes: Not reported
Speed: 100Mb/s
Duplex: Full
Port: MII
PHYAD: 32
Transceiver: internal
Auto-negotiation: on

I'm wondering if the LAN937X DSA driver is missing some support for
bringing up SGMII ports properly?


Simon

