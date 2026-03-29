Return-Path: <netdev+bounces-272952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCYZHy5jyWlXxwUAu9opvQ
	(envelope-from <netdev+bounces-272952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:36:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A63535E3
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0FA8301D695
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477D376BCC;
	Sun, 29 Mar 2026 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VbCXQ9Yl"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B81FCFEF
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774805577; cv=none; b=IvUDGy+aqbRk5MLnZ4ZB7Mdql1Y5L4Xc+DEJd12gObU90eQ4How5DCRfZ9W2jsLEMKmBvNFH6ETWve0sIyd/KRbkAqaI84uyzt1XJDcqHuyEJdpTkWzpDiynGiMP8AQ1P6VEjei+hkvfD9agJqEkrQxoR8UFiSlaU0ABxxbJHmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774805577; c=relaxed/simple;
	bh=oA29mYRiJnrGV9HvpNYSPtj7LuNZ+ewZ54L6Ihw8fbs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GnMJxZk2Lux0yOh119iJJCsV+xiexs6Tidook0TK7p1WuKbGmFvDkKRUquA/Nz6xgo7nR0r3EYyG5WAHT3ctWnJm+GuOxKcN3AdeF7hWEDyTnkSWGpVG23Rx1o4hQbxDBnydwEzDTAmDoGqZk63WGrNlKsngEwB7wie7XXZ8AjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VbCXQ9Yl; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774805572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oA29mYRiJnrGV9HvpNYSPtj7LuNZ+ewZ54L6Ihw8fbs=;
	b=VbCXQ9Yl0tBpSWIdpUHU/w59aFij01YS9H+wtN150uRCMAA6yTQfYaCDT//hXt7Oga7aaA
	DQNjo+Me4ftpfCNB6a9S/jq5nmc46XPbONSsVOLXo+On0K5tMzDiIEefpNx66qtegxz3rl
	PK9lQnMCzDghxSYjdBgSVN9RG3m7o7w=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 29 Mar 2026 19:32:31 +0200
Message-Id: <DHFG26KI6L23.1YCOVQ5SSYMO5@linux.dev>
Cc: <edumazet@google.com>, <pabeni@redhat.com>, <shannon.nelson@amd.com>,
 <horms@kernel.org>, <lukma@denx.de>, <kuba@kernel.org>
Subject: Re: [PATCH v3 net-next] net: hsr: sync hw addr of slave2 according
 to slave1 hw addr on PRP
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luka Gejak" <luka.gejak@linux.dev>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>, "Luka Gejak"
 <luka.gejak@linux.dev>, "Fernando Fernandez Mancera"
 <ffmancera@riseup.net>, <netdev@vger.kernel.org>
References: <20250409101911.3120-1-ffmancera@riseup.net>
 <DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev>
 <856eb43a-d4d0-4e1e-895f-75fca4eec51d@suse.de>
 <d3935fd1-b990-405b-8428-219730d68a89@suse.de>
In-Reply-To: <d3935fd1-b990-405b-8428-219730d68a89@suse.de>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riseup.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF3A63535E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun Mar 29, 2026 at 7:22 PM CEST, Fernando Fernandez Mancera wrote:
> On 3/29/26 6:58 PM, Fernando Fernandez Mancera wrote:
>> On 3/29/26 5:07 PM, Luka Gejak wrote:
>>> On Wed Apr 9, 2025 at 12:19 PM CEST, Fernando Fernandez Mancera wrote:
>>>> In order to work properly PRP requires slave1 and slave2 to share the
>>>> same MAC address. To ease the configuration process on userspace tools=
,
>>>> sync the slave2 MAC address with slave1. In addition, when deleting th=
e
>>>> port from the list, restore the original MAC address.
>>>>
>>>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
>>>> ---
>>>> v3: restore the original MAC address on slave removal.
>>>> ---
>>>> =C2=A0 net/hsr/hsr_device.c | 5 +++++
>>>> =C2=A0 net/hsr/hsr_main.c=C2=A0=C2=A0 | 9 +++++++++
>>>> =C2=A0 net/hsr/hsr_main.h=C2=A0=C2=A0 | 1 +
>>>> =C2=A0 net/hsr/hsr_slave.c=C2=A0 | 2 ++
>>>> =C2=A0 4 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
>>>> index 439cfb7ad5d1..e8922e8d9398 100644
>>>> --- a/net/hsr/hsr_device.c
>>>> +++ b/net/hsr/hsr_device.c
>>>> @@ -761,6 +761,11 @@ int hsr_dev_finalize(struct net_device *hsr_dev,=
=20
>>>> struct net_device *slave[2],
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (res)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_unregi=
ster;
>>>> +=C2=A0=C2=A0=C2=A0 if (protocol_version =3D=3D PRP_V1) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth_hw_addr_set(slave[1], =
slave[0]->dev_addr);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 call_netdevice_notifiers(N=
ETDEV_CHANGEADDR, slave[1]);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (interlink) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D hsr_add=
_port(hsr, interlink, HSR_PT_INTERLINK, extack);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (res)
>>>> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
>>>> index d7ae32473c41..192893c3f2ec 100644
>>>> --- a/net/hsr/hsr_main.c
>>>> +++ b/net/hsr/hsr_main.c
>>>> @@ -78,6 +78,15 @@ static int hsr_netdev_notify(struct notifier_block=
=20
>>>> *nb, unsigned long event,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 eth_hw_addr_set(master->dev, dev->dev_addr);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 call_netdevice_notifiers(NETDEV_CHANGEADDR,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 master->dev);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (hsr->prot_version =3D=3D PRP_V1) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 port =3D hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (port) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth_hw_addr_set(port->dev, de=
v->dev_addr);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 call_netdevice_notifiers(NETD=
EV_CHANGEADDR,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port->dev);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Make sure we=
 recognize frames from ourselves in=20
>>>> hsr_rcv() */
>>>> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
>>>> index 1bc47b17a296..135ec5fce019 100644
>>>> --- a/net/hsr/hsr_main.h
>>>> +++ b/net/hsr/hsr_main.h
>>>> @@ -155,6 +155,7 @@ struct hsr_port {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hsr_priv=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *hsr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum hsr_port_type=C2=A0=C2=A0=C2=A0 ty=
pe;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rcu_head=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rcu;
>>>> +=C2=A0=C2=A0=C2=A0 unsigned char=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 original_macaddress[ETH_ALEN];
>>>> =C2=A0 };
>>>> =C2=A0 struct hsr_frame_info;
>>>> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
>>>> index 2a802a5de2ac..b87b6a6fe070 100644
>>>> --- a/net/hsr/hsr_slave.c
>>>> +++ b/net/hsr/hsr_slave.c
>>>> @@ -196,6 +196,7 @@ int hsr_add_port(struct hsr_priv *hsr, struct=20
>>>> net_device *dev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port->hsr =3D hsr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port->dev =3D dev;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port->type =3D type;
>>>> +=C2=A0=C2=A0=C2=A0 ether_addr_copy(port->original_macaddress, dev->de=
v_addr);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (type !=3D HSR_PT_MASTER) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D hsr_por=
tdev_setup(hsr, dev, port, extack);
>>>> @@ -232,6 +233,7 @@ void hsr_del_port(struct hsr_port *port)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!port->hsr-=
>fwd_offloaded)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dev_set_promiscuity(port->dev, -1);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netdev_upper_de=
v_unlink(port->dev, master->dev);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth_hw_addr_set(port->dev,=
 port->original_macaddress);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree_rcu(port, rcu);
>>>
>>> Hi Fernando,
>>>
>>> Thanks for the patch. The logic to sync the slave2 MAC address with
>>> slave1 for PRP is sound, but there are a few implementation issues here
>>> that will cause hardware filtering problems and style violations.
>>>
>>> 1. Hardware MAC Filtering
>>> In your current implementation:
>>>
>>> =C2=A0=C2=A0 if (protocol_version =3D=3D PRP_V1) {
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth_hw_addr_set(slave[1], slave[0]=
->dev_addr);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 call_netdevice_notifiers(NETDEV_CH=
ANGEADDR, slave[1]);
>>>
>>> =C2=A0=C2=A0 }
>>>
>>> eth_hw_addr_set() is appropriate for virtual devices (like the hsr_dev
>>> itself), but slave[1] is a physical net_device. By using this helper,
>>> you are bypassing dev->netdev_ops->ndo_set_mac_address. This means the
>>> physical NIC's hardware MAC filter will not be programmed, and it will
>>> silently drop unicast traffic destined for the new PRP MAC address
>>> unless the interface happens to be in promiscuous mode. You should use
>>> dev_set_mac_address() here instead. Note that unlike eth_hw_addr_set(),
>>> dev_set_mac_address() can fail and returns an error code, so you will
>>> need to check its return value and handle the error path accordingly.
>>>
>>> 2. Teardown Notifiers
>>> In hsr_del_port():
>>>
>>> =C2=A0=C2=A0 netdev_upper_dev_unlink(port->dev, master->dev);
>>> =C2=A0=C2=A0 eth_hw_addr_set(port->dev, port->original_macaddress);
>>>
>>> You have the same issue with eth_hw_addr_set() here. Additionally,
>>> unlike the setup paths, this version omits call_netdevice_notifiers
>>> (NETDEV_CHANGEADDR, port->dev). Switching to dev_set_mac_address() for
>>> the restoration will handle both the hardware programming and the
>>> notifier chain automatically.
>>>
>>=20
>> These points makes sense. I guess I didn't notice the that=20
>> eth_hw_addr_set() due to my interface being set to promiscuous mode at=
=20
>> hsr_slave.c.
>>=20
>> Let me research a bit more about the impact here and will get back to=20
>> you either with a new patch or an reply here.
>>=20
>
> Does this actually makes sense? I am not an expert on how hardware is=20
> handling offloading here. But if I am not wrong, as the interface is set=
=20
> on promiscuous or offload enabled. For promiscuous this does not matter=
=20
> and for the offloaded scenario shouldn't the decision be handled by=20
> hardware and not depend on ndo_set_mac_address()?
>
> Let me know if I am missing something here.
>
>
> Anyway, the missing notification makes sense and should be fixed for=20
> SLAVE_B.
>
> Thanks,
> Fernando.

Hi Fernando,
You raise a fair point, and I should have looked more carefully at the=20
existing code paths.

You are correct that in the non-offloaded case, hsr_slave.c already=20
sets promiscuous mode via dev_set_promiscuity(dev, 1), so the hardware=20
MAC filter is bypassed and eth_hw_addr_set() is sufficient for frame=20
reception.

For the offloaded case, the comment in hsr_portdev_setup() notes that=20
"L2 frame forward happens at the offloaded hardware" =E2=80=94 so the hardw=
are=20
is configured through its own HSR/PRP offload mechanisms, not through=20
ndo_set_mac_address().

So the practical impact of my original concern is limited to edge cases=20
where promiscuous mode might be disabled or fail. The more important=20
issue, which you've already acknowledged, is the missing notifier in=20
hsr_del_port(). That should definitely be fixed for correctness.

One additional consideration: even though promiscuous mode handles the=20
receive path, dev->dev_addr is still used as the source MAC for=20
outgoing frames. Using dev_set_mac_address() would ensure the software=20
state (dev->dev_addr) and any driver-level state remain consistent. But=20
I agree this is less critical than I initially suggested. Thanks for=20
pushing back on this =E2=80=94 it's a good clarification.

Best regards,
Luka

