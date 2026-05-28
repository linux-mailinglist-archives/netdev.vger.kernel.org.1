Return-Path: <netdev+bounces-292743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPn+OONgGGpEjggAu9opvQ
	(envelope-from <netdev+bounces-292743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:36:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE0D5F47FB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AEA53072079
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6062F7EF5;
	Thu, 28 May 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqIs+xPb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5Ntr6lY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC33F4DE5
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981439; cv=none; b=lGM9Avh7A8n+UuIEWn3xOMzG1w196HUtnPVLCHox2voCMpqZYc/wujIrfgv8FuKTSAuN1qERsfMEtlKuvGo4xFWaimJsHshA89dQBoT8yODemMNxZr2AhuTeImi8yMv/PpzDR05aITgM5iYntARvReEnKdxuXXQW/sHcSi1+OPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981439; c=relaxed/simple;
	bh=RxMAVPYvLm9d64Z46gYq8gZJC2i5VQst4Y/8fPuNN2A=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=tyFJKA/vZa7ulfcculd3Mj6eWAlwy/NJZb8QF+TM5JyGcBC+9oTuOPZgcs2TMQR0wcnP2A6USo+OXx83B48em86S1DGwjADpuSPLNiMUXOQV80/NfLJjd0iRvzrkYuwzDqtCQPZEkA4ii9D2K7hMSMEGuWFB+833zokQt0IKKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqIs+xPb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5Ntr6lY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779981437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+Xe8uR1i55aaj4N/KTZ7B1f4vHthtQ3hEmvwye2pZI=;
	b=TqIs+xPbDbE4d6BrPZFn0xKKkomvL4qnWzWKEDug0T8+QsNPQy5yKLvfqwmFFf1t7iO6Uv
	ulxLyEplktF193SD1ftBw5qwcJhzc4LVH9RbhKe7pde+/36cXev483zUMTGmFsu6X0c++o
	ZIB6iczl6jmU7l6Olm7taKei3OKbBtk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-rX6IR7ZVODuL4dYep31BLQ-1; Thu, 28 May 2026 11:17:15 -0400
X-MC-Unique: rX6IR7ZVODuL4dYep31BLQ-1
X-Mimecast-MFC-AGG-ID: rX6IR7ZVODuL4dYep31BLQ_1779981434
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45eec2badc4so385308f8f.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779981434; x=1780586234; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+Xe8uR1i55aaj4N/KTZ7B1f4vHthtQ3hEmvwye2pZI=;
        b=R5Ntr6lYdmTd2CihRplt7BMSa11sGeDD8GS5YdlUkqoXw/zA9pSQRBe83xJpkcdFxR
         1uT3ZDRBoo0w6GD2yBCr0nD+wEMNqSs0A/Y5j7e4yyrjYaSFyMw7mez2TyTtRvLOw1vo
         r6lAdgcGEW/Wj2gXoPeAAcb1imRj/ZvhiKAxxG0KJEdKuPmpGeDuE+HfZBOw4hqZpUS9
         PGKmEWd6fEM85APvc6kTS0SEmO0Edqz59vgV7SJNR+dp5wO4tUT7NZkzLscRBDPT2kUs
         Qf7a2/8hvg4uKqbrSJWOZvghzU/qfaSN6ik0nGNT4NmcWNpRf6WNG+xhUweFiFZosQXm
         hptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779981434; x=1780586234;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+Xe8uR1i55aaj4N/KTZ7B1f4vHthtQ3hEmvwye2pZI=;
        b=ipZKt04wbtClhivy5auDT3V+aKwK3IMwI/qBsLrCyBAIe0dWELD0Edyqw98K+1Msur
         jB5tGJAujTZ5ZVRS4LFnQt0O1kkE5bAYY/oCRV7l0AIHTUkthOLRmvHfU7S++ATHHdmm
         LhyU4Zs8z0WELelABLnDlcpPn9O5Hrm0fgEqDapKSmEM56fz/7e2QTJ3m8uHPQ4yZilf
         jTYkbk3u4g0ErLR/9eQXq5O9OXW2xg/rqp1ms9I5JlualSd1t/7y1zk0V4/REzK8wdLy
         eKCGD4WmpZnDr5RxBFLyFfcZw3/Tp0NIG01zOz2y3EO1mjUkkumEZaGuT8q0xwK4lY8x
         H7EQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KLotp0tYRZMVXshX3R/7tn+SpVGoZlCLpznIvZM04oh2oRps/XC38+cQFDtbq0vIrxcxeesY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoRd1M4gwtbs/0F9GGjRIjD37jr8CzjP3Z9vQjMiPC/q/Hjc8c
	1qz0rsTBQXBlVswTfYzJyexUJ5ZESojAgkcY58KruR5wOl7hcxOAc8XJIeWfNQ4jMWUUqJ/HZc6
	QIGodUJIPxwsj9wc3E1z8TazYhN0VJrlMsx+3NN1NkOJI7Qno2TSijcYa2Q==
X-Gm-Gg: Acq92OFKsaDK5bf2A+Gg64KXflRvOdrH+caYfHDSP9rzI+JjwkgKSYm6MT4SUK346q4
	9WR5RvkNmyZdfEf/ZmXvVuL3y4d1vqTx9txPPSSrbgfSbJut67TPrLR9s1nJXhWizRrK2xB2ib8
	GQ9WjBj63lKOseZyVK+FmVY2kBoW1SKRSCjojclKMLQ95OtWVPNSCuy5a8Z2bxwusEF31c7HcSf
	U4FMmh2eJdAO1QxnP9rAABJ70MkLdgvrQlxDVgyAwb6szUFcShqTfTI9ROM0R4Yt0WfQI0PimTz
	HfrpgNxvEB38EKIDyuEcBZuYgY3VLGu4tlfcqQP3gUsLmMqkIb3nY1z5p/xe7mp+iC+R83C/FO0
	OJypCx+msN2aJxZPHvTEeZsktdng/Sqp5mjTT4Ciwruw=
X-Received: by 2002:a5d:59c6:0:b0:44a:8c10:40d9 with SMTP id ffacd0b85a97d-45eb39e1ec3mr44591753f8f.23.1779981433845;
        Thu, 28 May 2026 08:17:13 -0700 (PDT)
X-Received: by 2002:a5d:59c6:0:b0:44a:8c10:40d9 with SMTP id ffacd0b85a97d-45eb39e1ec3mr44591674f8f.23.1779981433282;
        Thu, 28 May 2026 08:17:13 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5c1e59sm13069697f8f.33.2026.05.28.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:17:12 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Fernando Fernandez
 Mancera <fmancera@suse.de>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>, Ido Schimmel
 <idosch@idosch.org>, Justin Iurman <justin.iurman@gmail.com>, David Ahern
 <dsahern@kernel.org>, David Gibson <david@gibson.dropbear.id.au>,
 ihuguet@redhat.com, Linux kernel regressions list
 <regressions@lists.linux.dev>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260528171710.1a5f6b6b@elisabeth>
In-Reply-To: <178a1a95-65bd-475b-a035-c4ebdc5ec325@lunn.ch>
References: <20260527010641.GA21073@cmadams.net>
	<20260526183122.348e44e7@kernel.org>
	<20260527215135.GB16443@cmadams.net>
	<675083b4-e015-4ff3-836c-798e0a971194@suse.de>
	<20260528073849.759da84a@elisabeth>
	<baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
	<20260528131250.1352ab48@elisabeth>
	<b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
	<bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
	<20260528153202.14900687@elisabeth>
	<178a1a95-65bd-475b-a035-c4ebdc5ec325@lunn.ch>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 28 May 2026 17:17:11 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[leemhuis.info,suse.de,kernel.org,vger.kernel.org,redhat.com,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-292743-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Queue-Id: DEE0D5F47FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 16:34:02 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > Actually, an eventually fixed version of NetworkManager doesn't need to
> > know the behaviour of the kernel: it can just order addresses by
> > timestamps instead, as Fernando mentioned.  
> 
> Can pasta also use this scheme to order the addresses? Is there a way
> pasta can be independent of the order?

pasta itself doesn't even care, it just inserts (copies) addresses one
by one as returned. The kernel cares, because it preferentially picks
the first one, as stored, within a given scope.

The problem is that they are inserted in the opposite order than one
would expect (that is, opposite to what's used by the kernel to select
them, and opposite to what's done for IPv4).

This (with an older kernel version) is quite "funny" (pasta by default
copies everything it finds to the inner namespace):

---
$ pasta -6 -Ix --no-ra
# ip a a fd00::1 dev x
# ip a a fd43::1 dev x
# ip a a 2620::1 dev x
# ip link set dev x up
# ip a s x
2: x: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 86:de:6b:53:5c:05 brd ff:ff:ff:ff:ff:ff
    inet6 2620::1/128 scope global tentative 
       valid_lft forever preferred_lft forever
    inet6 fd43::1/128 scope global tentative 
       valid_lft forever preferred_lft forever
    inet6 fd00::1/128 scope global tentative 
       valid_lft forever preferred_lft forever
# pasta -6 --config-net --no-ra
# ip a s x scope global
2: x: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 65520 qdisc fq_codel state UNKNOWN group default qlen 1000
    link/ether 32:d4:5b:f0:fd:50 brd ff:ff:ff:ff:ff:ff
    inet6 fd00::1/128 scope global nodad 
       valid_lft forever preferred_lft forever
    inet6 fd43::1/128 scope global nodad 
       valid_lft forever preferred_lft forever
    inet6 2620::1/128 scope global nodad 
       valid_lft forever preferred_lft forever
# pasta -6 --config-net --no-ra
# ip a s x scope global
2: x: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 65520 qdisc fq_codel state UNKNOWN group default qlen 1000
    link/ether 1a:ed:4a:27:f6:9f brd ff:ff:ff:ff:ff:ff
    inet6 2620::1/128 scope global nodad 
       valid_lft forever preferred_lft forever
    inet6 fd43::1/128 scope global nodad 
       valid_lft forever preferred_lft forever
    inet6 fd00::1/128 scope global nodad 
       valid_lft forever preferred_lft forever
---

...at every level of namespacing, the order is swapped. Note that
iproute2 also reports them in the order they're sent over netlink.

> Maybe we should just make the order random, so equally breaking
> everybody, and pushing user space to not assume any order :-)

The thing is... the kernel assumes the order. :) But it also has to.

-- 
Stefano


