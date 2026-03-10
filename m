Return-Path: <netdev+bounces-266207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBaDF4I9sGmohQIAu9opvQ
	(envelope-from <netdev+bounces-266207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:49:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4D253F33
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 327D531A479F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA91D2ED16D;
	Tue, 10 Mar 2026 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHWsu8ph"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712632D7DD4
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154349; cv=none; b=lTDa8BA8/3UHMhh2r8Q7eKj5VS6k1rhPNYycnuH1nNaTAD8dM4pP3MdB9O/iKBeblgAeuhva22ID7WJaQm+3Ts2fQ8m/MU4J5KN3pUIl4Bu0ppK6A6yRRVT6aZA7VXmxTAAgkQDGufzYCrEkCznR1dZatoTcgs5le/L53k7joao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154349; c=relaxed/simple;
	bh=49n9GSYOhnZZtu5gNl2BH/2gjdOfAm+onAhmJ4jCh58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joSh6+wh7uK7HXoeiR9NJjoNGIhT6NYyp1aJTbDrNgWQvbhnFjwKAyE5EstpfJy7LEIZPF45rxY7+Ytb2ClxUg32G/T9aSD3mgupB6o9WgT4cgZuGD5zkdx4XN64sY1rWzZrCYJ11YNnYVggVF9Gw7oLVchvePIVcVd9q4rQsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHWsu8ph; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773154347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIxw8ifz/vx6UnFqbAoU5fFu1LJG7g45kyv4F9G6+b8=;
	b=SHWsu8phio0WY9Q/SguMHzb2aTr3y2sQi4yK47jcmjBWFGpz2rBy1C6QrpPkxqG13YCnV8
	hpbB5BuhTbG7gJmRV7UiqgERqae73WmPOZorhii+w3uYrdDwiZQ5tvlFZ+EwfBZxIP1XCD
	/YGLhuBKm+Iur24CSBDUR92pffstqvY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-aeIt4Q60NxWy3SkSzoovHg-1; Tue,
 10 Mar 2026 10:52:24 -0400
X-MC-Unique: aeIt4Q60NxWy3SkSzoovHg-1
X-Mimecast-MFC-AGG-ID: aeIt4Q60NxWy3SkSzoovHg_1773154343
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED2221800610;
	Tue, 10 Mar 2026 14:52:22 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.tpbc.csb (unknown [10.43.3.226])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DCBA1956095;
	Tue, 10 Mar 2026 14:52:20 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: aleksandr.loktionov@intel.com
Cc: anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	jramaseu@redhat.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	przemyslaw.korba@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: enable NETIF_F_HW_CSUM for GSO packets
Date: Tue, 10 Mar 2026 15:52:15 +0100
Message-ID: <20260310145215.1128416-1-jramaseu@redhat.com>
In-Reply-To: <IA3PR11MB8986B891354A9AEBB0289BEEE546A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB8986B891354A9AEBB0289BEEE546A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 87F4D253F33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jramaseu@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-266207-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Dear Aleksandr,

> Please update commit message with exact commands for reproduction if possible.
that is sure to be done in v2, for now try

for the side acting as iperf3 server:
```
#!/bin/bash
# tunnel creation
# IPv4 addr         192.168.42.11/24
# IPv6 addr         2011::11/64
# IPv4oIP6GRE addr  192.168.44.11/24
# IPv6oIP6GRE addr  2023::11/64

ip l a gre1 type ip6gre remote 2011::12 local 2011::11 dev enp65s0f0np0
ip l s ip6tnl0 up
ip l s ip6gre0 up
ip l s gre1 up


# gre tunnel addresses
ip a a 2001:db8:1::1/64 dev gre1
ip a a 2023::11/64 dev gre1
ip a a 192.168.44.11/24 dev gre1

# device addresses
ip a a 2011::11/64 dev enp65s0f0np0
ip a a 192.168.42.11/24 dev enp65s0f0np0

iperf3 -s
```

for the side acting as iperf3 client:
```
#!/bin/bash
# tunnel creation
# IPv4 addr         192.168.42.12/24
# IPv6 addr         2011::12/64
# IPv4oIP6GRE addr  192.168.44.12/24
# IPv6oIP6GRE addr  2023::12/64

ip l a gre1 type ip6gre remote 2011::11 local 2011::12 dev enp65s0f0np0
ip l s ip6tnl0 up
ip l s ip6gre0 up
ip l s gre1 up

# gre tunnel addresses
ip a a 2001:db8:1::2/64 dev gre1
ip a a 2023::12/64 dev gre1
ip a a 192.168.44.12/24 dev gre1

# device addresses
ip a a 2011::12/64 dev enp65s0f0np0
ip a a 192.168.42.12/24 dev enp65s0f0np0

# tests with single stream
# test gre throughput
iperf3 -c 192.168.44.11 -t 20 -P 1
iperf3 -c 2023::11 -t 20 -P 1
# test normal throughput
iperf3 -c 192.168.42.11 -t 20 -P 1
iperf3 -c 2011::11 -t 20 -P 1
```
I hope this is expected answer.

Best regards,
Jakub Ramaseuski


