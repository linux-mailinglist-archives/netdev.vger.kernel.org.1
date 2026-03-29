Return-Path: <netdev+bounces-272956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6fPqHZdlyWmqxwUAu9opvQ
	(envelope-from <netdev+bounces-272956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:47:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E58C0353690
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE0F83004612
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3D71CEADB;
	Sun, 29 Mar 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RTTnruue";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="86Xm6sA9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RTTnruue";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="86Xm6sA9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F93B1A680A
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774806419; cv=none; b=sK2nZPX1pBzVm5Y9dse7wkAOYheBWXe8RbCu2W4BdrfDWuj6HUXqn+MBdgW03DyzHir1dM2C7J2pCl2JGqOljkUXQ1L9X+iab4ZO/OOIFRIaQWP0VpMtiJJqP7ZkKXdqgGdR4m0FlflYuzybDZuwGwag8Rp7BMQFmFkkpoYFNPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774806419; c=relaxed/simple;
	bh=O5c1hOr/ZhaAUF7C9C7wD9mAYFUmloz6/dOGfZiYxjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKSpY++JECetYEjrGIIUvooigRci1yviXbd6c6obbH7vBzt55i86hiqiELihjbG80RhuVOf04vNqoFAp/8IoZTiPOM9QXJImxOzF3XPv8Q8GsUC14fpZxvnoAl8s7nz/G/b0OcskZzu67gRZ1UOczexkIBTUrK+BxhV9FlDU9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RTTnruue; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=86Xm6sA9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RTTnruue; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=86Xm6sA9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4251B4D508;
	Sun, 29 Mar 2026 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774806416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSpaGEHg1L+6axQNsxrAhMU85BCJESoBkft2n4sESH0=;
	b=RTTnruueeHFPWoYyCJjX12sKUvf6U41yaWcnqKjY6dLcKFez3SbZP5D87P6WCvJfIFRweY
	IpUNEfuOS8wjenHsdAp4TBPREVTwoEvKhwWS8G1wrxr5DSZ7Agov85DlTNmF3XLHBoTu57
	VFhxTJdMEvtEMVrRct9pxLMD1VGhAeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774806416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSpaGEHg1L+6axQNsxrAhMU85BCJESoBkft2n4sESH0=;
	b=86Xm6sA9dIFrQdCyvcw1v0iO6Lwk6mlpIKBiAn25fX2+lkwVfOnM7aYfOqvPGKcBGoTU1J
	Bd3nzwmk4aG3fpCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774806416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSpaGEHg1L+6axQNsxrAhMU85BCJESoBkft2n4sESH0=;
	b=RTTnruueeHFPWoYyCJjX12sKUvf6U41yaWcnqKjY6dLcKFez3SbZP5D87P6WCvJfIFRweY
	IpUNEfuOS8wjenHsdAp4TBPREVTwoEvKhwWS8G1wrxr5DSZ7Agov85DlTNmF3XLHBoTu57
	VFhxTJdMEvtEMVrRct9pxLMD1VGhAeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774806416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSpaGEHg1L+6axQNsxrAhMU85BCJESoBkft2n4sESH0=;
	b=86Xm6sA9dIFrQdCyvcw1v0iO6Lwk6mlpIKBiAn25fX2+lkwVfOnM7aYfOqvPGKcBGoTU1J
	Bd3nzwmk4aG3fpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7B964A0A2;
	Sun, 29 Mar 2026 17:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YvE8JY9lyWlPBAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 29 Mar 2026 17:46:55 +0000
Message-ID: <63d4f8f6-5cc4-4d16-9095-c6c58cd1af34@suse.de>
Date: Sun, 29 Mar 2026 19:46:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net: hsr: sync hw addr of slave2 according to
 slave1 hw addr on PRP
To: Luka Gejak <luka.gejak@linux.dev>,
 Fernando Fernandez Mancera <ffmancera@riseup.net>, netdev@vger.kernel.org
Cc: edumazet@google.com, pabeni@redhat.com, shannon.nelson@amd.com,
 horms@kernel.org, lukma@denx.de, kuba@kernel.org
References: <20250409101911.3120-1-ffmancera@riseup.net>
 <DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev>
 <856eb43a-d4d0-4e1e-895f-75fca4eec51d@suse.de>
 <d3935fd1-b990-405b-8428-219730d68a89@suse.de>
 <DHFG26KI6L23.1YCOVQ5SSYMO5@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <DHFG26KI6L23.1YCOVQ5SSYMO5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272956-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E58C0353690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/29/26 7:32 PM, Luka Gejak wrote:
> On Sun Mar 29, 2026 at 7:22 PM CEST, Fernando Fernandez Mancera wrote:
>> On 3/29/26 6:58 PM, Fernando Fernandez Mancera wrote:
>>> On 3/29/26 5:07 PM, Luka Gejak wrote:
>>>> On Wed Apr 9, 2025 at 12:19 PM CEST, Fernando Fernandez Mancera wrote:
>>>>> In order to work properly PRP requires slave1 and slave2 to share the
>>>>> same MAC address. To ease the configuration process on userspace tools,
>>>>> sync the slave2 MAC address with slave1. In addition, when deleting the
>>>>> port from the list, restore the original MAC address.
>>>>>
>>>>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
>>>>> ---
>>>>> v3: restore the original MAC address on slave removal.
>>>>> ---
>>>>>    net/hsr/hsr_device.c | 5 +++++
>>>>>    net/hsr/hsr_main.c   | 9 +++++++++
>>>>>    net/hsr/hsr_main.h   | 1 +
>>>>>    net/hsr/hsr_slave.c  | 2 ++
>>>>>    4 files changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
>>>>> index 439cfb7ad5d1..e8922e8d9398 100644
>>>>> --- a/net/hsr/hsr_device.c
>>>>> +++ b/net/hsr/hsr_device.c
>>>>> @@ -761,6 +761,11 @@ int hsr_dev_finalize(struct net_device *hsr_dev,
>>>>> struct net_device *slave[2],
>>>>>        if (res)
>>>>>            goto err_unregister;
>>>>> +    if (protocol_version == PRP_V1) {
>>>>> +        eth_hw_addr_set(slave[1], slave[0]->dev_addr);
>>>>> +        call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
>>>>> +    }
>>>>> +
>>>>>        if (interlink) {
>>>>>            res = hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
>>>>>            if (res)
>>>>> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
>>>>> index d7ae32473c41..192893c3f2ec 100644
>>>>> --- a/net/hsr/hsr_main.c
>>>>> +++ b/net/hsr/hsr_main.c
>>>>> @@ -78,6 +78,15 @@ static int hsr_netdev_notify(struct notifier_block
>>>>> *nb, unsigned long event,
>>>>>                eth_hw_addr_set(master->dev, dev->dev_addr);
>>>>>                call_netdevice_notifiers(NETDEV_CHANGEADDR,
>>>>>                             master->dev);
>>>>> +
>>>>> +            if (hsr->prot_version == PRP_V1) {
>>>>> +                port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
>>>>> +                if (port) {
>>>>> +                    eth_hw_addr_set(port->dev, dev->dev_addr);
>>>>> +                    call_netdevice_notifiers(NETDEV_CHANGEADDR,
>>>>> +                                 port->dev);
>>>>> +                }
>>>>> +            }
>>>>>            }
>>>>>            /* Make sure we recognize frames from ourselves in
>>>>> hsr_rcv() */
>>>>> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
>>>>> index 1bc47b17a296..135ec5fce019 100644
>>>>> --- a/net/hsr/hsr_main.h
>>>>> +++ b/net/hsr/hsr_main.h
>>>>> @@ -155,6 +155,7 @@ struct hsr_port {
>>>>>        struct hsr_priv        *hsr;
>>>>>        enum hsr_port_type    type;
>>>>>        struct rcu_head        rcu;
>>>>> +    unsigned char        original_macaddress[ETH_ALEN];
>>>>>    };
>>>>>    struct hsr_frame_info;
>>>>> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
>>>>> index 2a802a5de2ac..b87b6a6fe070 100644
>>>>> --- a/net/hsr/hsr_slave.c
>>>>> +++ b/net/hsr/hsr_slave.c
>>>>> @@ -196,6 +196,7 @@ int hsr_add_port(struct hsr_priv *hsr, struct
>>>>> net_device *dev,
>>>>>        port->hsr = hsr;
>>>>>        port->dev = dev;
>>>>>        port->type = type;
>>>>> +    ether_addr_copy(port->original_macaddress, dev->dev_addr);
>>>>>        if (type != HSR_PT_MASTER) {
>>>>>            res = hsr_portdev_setup(hsr, dev, port, extack);
>>>>> @@ -232,6 +233,7 @@ void hsr_del_port(struct hsr_port *port)
>>>>>            if (!port->hsr->fwd_offloaded)
>>>>>                dev_set_promiscuity(port->dev, -1);
>>>>>            netdev_upper_dev_unlink(port->dev, master->dev);
>>>>> +        eth_hw_addr_set(port->dev, port->original_macaddress);
>>>>>        }
>>>>>        kfree_rcu(port, rcu);
>>>>
>>>> Hi Fernando,
>>>>
>>>> Thanks for the patch. The logic to sync the slave2 MAC address with
>>>> slave1 for PRP is sound, but there are a few implementation issues here
>>>> that will cause hardware filtering problems and style violations.
>>>>
>>>> 1. Hardware MAC Filtering
>>>> In your current implementation:
>>>>
>>>>     if (protocol_version == PRP_V1) {
>>>>
>>>>         eth_hw_addr_set(slave[1], slave[0]->dev_addr);
>>>>
>>>>         call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
>>>>
>>>>     }
>>>>
>>>> eth_hw_addr_set() is appropriate for virtual devices (like the hsr_dev
>>>> itself), but slave[1] is a physical net_device. By using this helper,
>>>> you are bypassing dev->netdev_ops->ndo_set_mac_address. This means the
>>>> physical NIC's hardware MAC filter will not be programmed, and it will
>>>> silently drop unicast traffic destined for the new PRP MAC address
>>>> unless the interface happens to be in promiscuous mode. You should use
>>>> dev_set_mac_address() here instead. Note that unlike eth_hw_addr_set(),
>>>> dev_set_mac_address() can fail and returns an error code, so you will
>>>> need to check its return value and handle the error path accordingly.
>>>>
>>>> 2. Teardown Notifiers
>>>> In hsr_del_port():
>>>>
>>>>     netdev_upper_dev_unlink(port->dev, master->dev);
>>>>     eth_hw_addr_set(port->dev, port->original_macaddress);
>>>>
>>>> You have the same issue with eth_hw_addr_set() here. Additionally,
>>>> unlike the setup paths, this version omits call_netdevice_notifiers
>>>> (NETDEV_CHANGEADDR, port->dev). Switching to dev_set_mac_address() for
>>>> the restoration will handle both the hardware programming and the
>>>> notifier chain automatically.
>>>>
>>>
>>> These points makes sense. I guess I didn't notice the that
>>> eth_hw_addr_set() due to my interface being set to promiscuous mode at
>>> hsr_slave.c.
>>>
>>> Let me research a bit more about the impact here and will get back to
>>> you either with a new patch or an reply here.
>>>
>>
>> Does this actually makes sense? I am not an expert on how hardware is
>> handling offloading here. But if I am not wrong, as the interface is set
>> on promiscuous or offload enabled. For promiscuous this does not matter
>> and for the offloaded scenario shouldn't the decision be handled by
>> hardware and not depend on ndo_set_mac_address()?
>>
>> Let me know if I am missing something here.
>>
>>
>> Anyway, the missing notification makes sense and should be fixed for
>> SLAVE_B.
>>
>> Thanks,
>> Fernando.
> 
> Hi Fernando,
> You raise a fair point, and I should have looked more carefully at the
> existing code paths.
> 
> You are correct that in the non-offloaded case, hsr_slave.c already
> sets promiscuous mode via dev_set_promiscuity(dev, 1), so the hardware
> MAC filter is bypassed and eth_hw_addr_set() is sufficient for frame
> reception.
> 
> For the offloaded case, the comment in hsr_portdev_setup() notes that
> "L2 frame forward happens at the offloaded hardware" — so the hardware
> is configured through its own HSR/PRP offload mechanisms, not through
> ndo_set_mac_address().
> 
> So the practical impact of my original concern is limited to edge cases
> where promiscuous mode might be disabled or fail. The more important
> issue, which you've already acknowledged, is the missing notifier in
> hsr_del_port(). That should definitely be fixed for correctness.
> 
> One additional consideration: even though promiscuous mode handles the
> receive path, dev->dev_addr is still used as the source MAC for
> outgoing frames. Using dev_set_mac_address() would ensure the software
> state (dev->dev_addr)

I am sorry I do not follow here. eth_hw_addr_set() path ends up calling 
dev_addr_mod() which modifies dev->dev_addr indeed.

Thanks,
Fernando.

  and any driver-level state remain consistent. But
> I agree this is less critical than I initially suggested. Thanks for
> pushing back on this — it's a good clarification.
> 
> Best regards,
> Luka
> 


