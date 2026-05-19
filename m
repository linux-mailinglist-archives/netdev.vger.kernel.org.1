Return-Path: <netdev+bounces-289578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FzEGD+pDGoIkgUAu9opvQ
	(envelope-from <netdev+bounces-289578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:17:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 047C9583874
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F00E303A4E0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A7366823;
	Tue, 19 May 2026 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YQcA+QlD"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8F535C1A9;
	Tue, 19 May 2026 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214653; cv=none; b=EwPW4WdzfH4JYSmRYUsF7Z+cn435UlRYhHDCuPYc566tN7cIbTOaS1fCSS4P9sMiwZkqnvti99CDD0w2yYuPjU+vBDeLIL0ezyNTCj5uhZNPs95Aw7e+yzNa28nSVsCqKmE5oHJbCjSbzPfeAPLIaGRYqbxZTWK0t9F9iwqIkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214653; c=relaxed/simple;
	bh=tzDMwVPvKGOjTE4ixRbRU/Ng8o6AM2WQTjKsIjZQFJk=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=DBu6zA7g8dmoJnCDO3ZSq1zxtu14BzeB13UNmZOAn8ipxsbDH2L9son/s8XZH4IxMtE+kcUr+fqchlVJ7/0ruWxnevwpAdThtKZxGZLVM/22zqFzIZF2mvLQTweN6U/Kxzt7m13qLNvNIFDH7WK+iau+MOJ+qnhRHcge5hansbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YQcA+QlD; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779214652; x=1810750652;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=OKxzwZZVaRVGRqfji1EVdehMm8SP7oMFaDJplS5Kw8w=;
  b=YQcA+QlDzLZFIdiq31qu91BbnunNTz8Y49RHkgsKXRqILR99Zr7hzyLg
   aJmMtuifLP5gFDIlXjWLzY/MhBhevRxlguH6amppeDLUGZWI45gBpObZP
   i/8jtZ+0ryePZThqN8yngVsRn/TGCYPqbWgNVCqBSnfXz+FO+ptFyZ6FF
   bLq5qu68ZiXok3s3reqdiWxINHqQnRMSSl8DWroUvLUHj8BJe+EyYqal1
   hGFAU4aT9fz9y57syp23spiG1oPAFnVYJ/RJ3IaTuU7qlSjN7t9totWo4
   DJskd47aIZLZg1LZj1MKm4jE+NPvqqB0EgZnqMUqu2GMfuExmuEbWEXS8
   g==;
X-CSE-ConnectionGUID: CyMblZmIQhOQgI+JAEjVLw==
X-CSE-MsgGUID: gKfVhmdiTAu2n/mSBGJGNA==
X-IronPort-AV: E=Sophos;i="6.23,243,1770595200"; 
   d="scan'208";a="19999748"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 18:17:28 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:16348]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.131:2525] with esmtp (Farcaster)
 id fbcd1353-b887-4d25-9afd-ce86c04d0305; Tue, 19 May 2026 18:17:28 +0000 (UTC)
X-Farcaster-Flow-ID: fbcd1353-b887-4d25-9afd-ce86c04d0305
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 19 May 2026 18:17:27 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 19 May 2026 18:17:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/7] ptp: Add PHC timestamp quality
 attributes
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, David Miller
	<davem@davemloft.net>, <netdev@vger.kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, "Yonatan
 Sarna" <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, "Alexander
 Matushevsky" <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt
 Wilson <msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>, Nafea Bshara
	<nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>, Netanel Belgazal
	<netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin Herrenschmidt
	<benh@amazon.com>, Noam Dagan <ndagan@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik
	<ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
	<vadim.fedorenko@linux.dev>
In-Reply-To: <20260518182646.2d1337d4@kernel.org>
References: <20260515164033.6403-1-akiyano@amazon.com>
 <20260518182646.2d1337d4@kernel.org>
Date: Tue, 19 May 2026 18:17:16 +0000
Message-ID: <177921463623.22936.15326822041328476600.b4-reply@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289578-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amazon.com,davemloft.net,vger.kernel.org,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,kernel.org,linux.dev];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 047C9583874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-18 18:26:46-07:00, Jakub Kicinski wrote:
> On Fri, 15 May 2026 16:40:20 +0000 Arthur Kiyanovski wrote:
> 
> > This series adds quality attributes to PTP Hardware Clock (PHC)
> > timestamps, allowing userspace to obtain error bound, clock status,
> > timescale, and raw counter values alongside timestamps in a single
> > call.
> 
> How does this proposal relate to:
> 
> https://lore.kernel.org/all/20260517220326.4625-9-dwmw2@infradead.org/
> 
> ?
The two series are independent and complementary. This patchset adds a
generic PTP subsystem interface for reporting quality attributes (error
bounds, clock status) alongside PHC timestamps — it's a userspace-facing
API extension. The RFC is about kernel-internal feed-forward clock
discipline, letting the timekeeping subsystem lock directly to a vmclock
reference.

Both touch ptp_vmclock.c but in different code paths: this series adds a
gettimexattrs64 callback for PTP chardev ioctls, the RFC adds
timekeeping_set_reference() for kernel-internal clock steering. No
functional dependency or overlap.


