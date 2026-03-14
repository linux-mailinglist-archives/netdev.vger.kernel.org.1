Return-Path: <netdev+bounces-267666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBV7KArOtGl0tAAAu9opvQ
	(envelope-from <netdev+bounces-267666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 03:55:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC828B73E
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 03:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F4430AAAA7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 02:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066531A5B84;
	Sat, 14 Mar 2026 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Wcn28fAd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F249A42AA6
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773456879; cv=none; b=CnyU4Dh0dRoeX8Wj5djiK1GCU/QV1UVJHXig09wqtQXjoYgjiMSxEDu9hix5okZc1/6xRNCJPYc62FWfOD8PAK1oNgJVN40nICgNtoeUe4N4TU1YLerpuajPT2+6ieWvu6lyRKSW/lKbWKo3SwWS+kSos8d/ktVBhT32Yj0paEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773456879; c=relaxed/simple;
	bh=lc0L3PqVsMGj+CKhpD60GprlcNXDTRmuNwxYTrraDe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImOxiQDxGHrUfaCyWZ+AnMbW3tW9e7tqiXZbc5y6oKINYYOFj0knecqqaL2XEySXEMHegHVyf8CF805KwBeY6gnnqp19mwKv0j0kI09rfsmvL4lVNWZDsevceeG/851Dou21+OEa6FM1dnndajN4yg/onfe+LOG+b48hIkyb61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Wcn28fAd; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773456873;
	bh=7mJDuZD6DNTgpx7GUw0fps0k4eVhgUOIyL6tqJr0/+s=;
	h=From:Subject:Date:Message-ID;
	b=Wcn28fAdWVYHxReZdmS98iluzVIoI6ZoG6peVg4rMeIOy62GeUoyTKnSAMvaYmePO
	 8fWQeQafRB0abIZKOk6ggnMNm/Cif8mDH6di/B+rE0zX3bTEcwnHs5WYGEkzCHnkqF
	 a3lO5TlJJ1cmzJGJQS5TEkiLTuoc8HPnYB3b7QdQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 69B4CDDD00001578; Sat, 14 Mar 2026 10:54:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7582996292267
X-SMAIL-UIID: 9442E63AEDAC44BC83CE360171043AD0-20260314-105422-1
From: Hillf Danton <hdanton@sina.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: edumazet@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] atm: lec: fix use-after-free in sock_def_readable()
Date: Sat, 14 Mar 2026 10:53:50 +0800
Message-ID: <20260314025418.958-1-hdanton@sina.com>
In-Reply-To: <CADhLXY7LcCFzJEcxoVG44AvpcV3x-o36xOxTdQhktihDVeXyAg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267666-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[sina.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 09DC828B73E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 06:33:53 +0530 Deepanshu Kartikey wrote:
> On Tue, Mar 10, 2026 at 8:48 AM Hillf Danton <hdanton@sina.com> wrote:
> >
> > At this point priv->lecd is no longer used, so why not make lecd valid
> > throughout the lifespan of priv and free it after stopping dev queue,
> > instead of the tedious rcu trick?
> >
> 
> Thank you for the suggestion.
> 
> I investigated this approach. While netif_stop_queue() stops
> the TX path and cancel_delayed_work_sync() in lec_arp_destroy()
> stops lec_arp_work, the bug is actually triggered from
> mld_ifc_work (IPv6 multicast workqueue) which calls:
> 
> mld_ifc_work -> mld_sendpack -> ip6_output
>     -> lec_start_xmit -> lec_arp_resolve -> send_to_lecd
> 
> This workqueue belongs to the IPv6 multicast subsystem and
> is completely outside ATM/LEC control. Neither
> netif_stop_queue() nor lec_arp_destroy() can stop it, so
> simply reordering the calls in lec_atm_close() would not
> fix the race.
> 
> The RCU approach with synchronize_rcu() ensures ALL callers
> including mld_ifc_work have finished before priv->lecd is
> cleared.
>
After another look the uaf [1] is due to the race

	vcc_release()		mld_sendpack()
	---			---
				ip6_output()
				__dev_queue_xmit()
				  rcu_read_lock_bh();  // rcu section
				  __dev_xmit_skb()
				  netdev_start_xmit()
				  lec_start_xmit()
				    if (!priv->lecd) {  // check lecd
					kfree_skb(skb);
					return NETDEV_TX_OK;
				    }

	vcc_destroy_socket()
	vcc->dev->ops->close(vcc);
	lec_atm_close()
	  priv->lecd = NULL;	// clear lecd
	  netif_stop_queue(dev);
	sock_put() // free sock

				  lec_arp_resolve()
				  send_to_lecd()
				  sock_def_readable() // uaf

and syncing rcu after clearing lecd is the correct fix because lecd is checked
with rcu lock held.

[1] Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in sock_def_readable (2)
https://lore.kernel.org/all/69ad7ccb.a00a0220.b130.0003.GAE@google.com/

