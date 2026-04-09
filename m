Return-Path: <netdev+bounces-276907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMR3BEB212nTOAgAu9opvQ
	(envelope-from <netdev+bounces-276907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:49:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BD33C8B19
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B80F301452A
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE513A63F3;
	Thu,  9 Apr 2026 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="KtDVdA8U"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4043AA4EA;
	Thu,  9 Apr 2026 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728187; cv=none; b=bdpER/KPCuWqCZGWNJHKAjGXOelIemJJ+TPgSX5oXLb8The0u8CSLGLzy0dahUUyb1lRfppj06QsugSStpPt0A1UCM/RGvZLA6cCzQYx249ksJwvIHJKqxU0RChAxmZTMOUVvvNLOgdQKKfCqR6gbBKoSUP+dd61Gik/ZkmRiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728187; c=relaxed/simple;
	bh=8af16isPdI3rAIM7qJg6k4rQmEMWbBkTGu5WWkko3aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCAzEIW/BEvzCDZBTO6o1zu6xL7xSGUzp7OMxUho90zqTgtdDxsFgCY/LiF75Hs5zbigxrVHjJ7Prs4Ze0wlL70W0gXI5Wdz0wEWhw/lnEJkfYAavhMgPym3OGtgw/oEgap+u8k3p8sAjSx+K/i9+7aGbKvDgskvVk1291nSnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=KtDVdA8U; arc=none smtp.client-ip=195.10.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4frw4b2x6XzDsC9;
	Thu,  9 Apr 2026 11:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1775727855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=St8VQPMpTIC5o98HlkQhwyUZfsPPSwA6fcpQjfQwTCA=;
	b=KtDVdA8Ua8dufaJQp7sbCd5TLs+P2l9B9D7TGtdcIoRkIjiSdKASxEeXiRrAGQo/AG6GwN
	HDAFj2NBO6wO1f4VBGhOz/Re5CZOt9Lr8/JCH4lrzVywUPnYsv3EBOMqw0/BxSksa+FzGT
	WcTrMRGc+jNrXqJiWdZHGnKykVaKNkIzvEy0prSIARXnBKDCX6xpi6l/3NYzhVUClXgojf
	BdFMHCCbVXS511beTQjPjqnP1dAVLmrUNv3GU00ok92SVbAx1Y012NKxkmGJIzitFvCdbU
	8j/npK4AT/51TY79sZ0yvhXkdOpG48zFTxs5V+1S1Jp1VHOow9u7ppNO9IsBjw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
Message-ID: <e24c97aa-d802-44bd-a8fc-73e37cbe4aed@mandelbit.com>
Date: Thu, 9 Apr 2026 11:44:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next 05/15] ipxlat: add IPv6 packet validation path
To: Xavier HSINYUAN <xavierhsinyuan@outlook.com>
Cc: andrew+netdev@lunn.ch, antonio@mandelbit.com, davem@davemloft.net,
 dxld@darkboxed.org, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
References: <20260319151230.655687-6-ralf@mandelbit.com>
 <TYRPR01MB12666C2C108C1D23202C5B79ACA582@TYRPR01MB12666.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Ralf Lici <ralf@mandelbit.com>
In-Reply-To: <TYRPR01MB12666C2C108C1D23202C5B79ACA582@TYRPR01MB12666.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276907-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	FREEMAIL_TO(0.00)[outlook.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83BD33C8B19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 04:18, Xavier HSINYUAN wrote:
> Hi Ralf,
> 
>> +static int ipxlat_v6_validate_icmp_csum(const struct sk_buff *skb)
>> +{
>> +	struct ipv6hdr *iph6;
>> +	unsigned int len;
>> +	__sum16 csum;
>> +
>> +	if (skb->ip_summed != CHECKSUM_NONE)
>> +		return 0;
>> +
>> +	iph6 = ipv6_hdr(skb);
>> +	len = ipxlat_skb_datagram_len(skb);
>> +	csum = csum_ipv6_magic(&iph6->saddr, &iph6->daddr, len, NEXTHDR_ICMP,
>> +			       skb_checksum(skb, skb_transport_offset(skb), len,
>> +					    0));
>> +
>> +	return unlikely(csum) ? -EINVAL : 0;
>> +}
> We should include net/ip6_checksum.h to make x86_64 with KMSAN/KASAN and
> other architectures with optional _HAVE_ARCH_IPV6_CSUM happy.

Hi Xavier,

Yep, this showed up in patchwork build failures as well.
I'll add the required header where needed (packet.c and icmp_{46,64}.c)
in the next revision.

Thanks!

> 
> Best regards,
> Xavier
> 

-- 
Ralf Lici
Mandelbit Srl


