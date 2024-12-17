Return-Path: <netdev+bounces-152508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EB29F45C4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D96D7A32EE
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC31DB377;
	Tue, 17 Dec 2024 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z658jMX4"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40631DACBB;
	Tue, 17 Dec 2024 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423163; cv=none; b=cbc03Dz9v6V7tktKLwZVSVF5kPRCjCzecFqIYgbVkustyTCy/dr5qRd8k/aI+/KWfTLb1QrHDLO1xbWKv1uqyVY9w7LeD8dCa8ZghpdeXIqP3bQcKz65QrUEWdQyJKS9YCdowdRVaeGWmHIXLeqIqUMFjL+eHZWWbr6+UtfEIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423163; c=relaxed/simple;
	bh=xbVzhQl80dmOXJeG9YIgEJequ2/eKnb37OKZNQlyCsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ow6/0DdnPEgYrNewup296V8HZlAgZOrBJGeblVPdz6yyAuxSFTAHCo/dCzpWdAHssBa3U1xAP0Fcj5Ll8MWruaElWZciru56qw66/Z+zQje2mh/UTmnbncBQ39PPhNhaMGG1njRLKAaGT3iusBpfouJU+K8utbJy4GGwn83YEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z658jMX4; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xnNw9
	z3AG/FsbDigMUs/0VbAT1ydCrcKkY1WBUINQw0=; b=Z658jMX4Fir1HebDTu1nZ
	irxs4Zr8Siw5Ls08hfmDkbNAcu3RIx1aBA3tibzMjPSdAHGwqT3a0fqBBDVG2I2F
	9HERYcfuLPcqrcjW4qHksRjDPUmTYz9YoKGtfZMs3+P5bcUK68Z5AtqDY/GIDa2h
	OU+3z4D/s0/K4M+2r6Jdzw=
Received: from hello.company.local (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3d8rIMWFnCouYBA--.63668S2;
	Tue, 17 Dec 2024 16:09:45 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: erdnetdev@gmail.com
Cc: andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	buaajxlj@163.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	liangjie@lixiang.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] net: Refine key_len calculations in rhashtable_params
Date: Tue, 17 Dec 2024 16:09:44 +0800
Message-Id: <20241217080944.3971820-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHTyZGwAit_FSHJDSPn4QpCfim321aB478YDuC=uUhvBgPfKGA@mail.gmail.com>
References: <CAHTyZGwAit_FSHJDSPn4QpCfim321aB478YDuC=uUhvBgPfKGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d8rIMWFnCouYBA--.63668S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF45Jw4DZFyDuw1DWw4UArb_yoW8KF15pF
	1DK3WkKr4DJryjkr4xuws3ur18tan3GFW7trnYg3ySy3Z0qFn5ZFs7Kry5CayvyF4vkry2
	v34jga43Zr1DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUtPEhUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbiNhe4IGdhL2RHswAAsA

On Tue, 17 Dec 2024 08:33:57 +0100, ericnetdev dumazet wrote:

>>
>> From: Liang Jie <liangjie@lixiang.com>
>>
>> This patch improves the calculation of key_len in the rhashtable_params
>> structures across the net driver modules by replacing hardcoded sizes
>> and previous calculations with appropriate macros like sizeof_field()
>> and offsetofend().
>>
>> Previously, key_len was set using hardcoded sizes like sizeof(u32) or
>> sizeof(unsigned long), or using offsetof() calculations. This patch
>> replaces these with sizeof_field() and correct use of offsetofend(),
>> making the code more robust, maintainable, and improving readability.
>>
>> Using sizeof_field() and offsetofend() provides several advantages:
>> - They explicitly specify the size of the field or the end offset of a
>>   member being used as a key.
>> - They ensure that the key_len is accurate even if the structs change in
>>   the future.
>> - They improve code readability by clearly indicating which fields are used
>>   and how their sizes are determined, making the code easier to understand
>>   and maintain.
>>
>> For example, instead of:
>>     .key_len    = sizeof(u32),
>> we now use:
>>     .key_len    = sizeof_field(struct mae_mport_desc, mport_id),
>>
>> And instead of:
>>     .key_len    = offsetof(struct efx_tc_encap_match, linkage),
>> we now use:
>>     .key_len    = offsetofend(struct efx_tc_encap_match, ip_tos_mask),
>>
>> These changes eliminate the risk of including unintended padding or extra
>> data in the key, ensuring the rhashtable functions correctly.
>
>I do not see how this patch can eliminate padding.
>
>If keys include holes or padding, something still needs to clear the
>holes/padding in objects and lookup keys.
>
>struct key {
>   u8 first_component;
>   u32 second_component;
>};

You are right, this patch can not eliminate padding in the case you mentioned.

This patch addresses the following cases present in the current code:

struct efx_tc_encap_match {
	__be32 src_ip, dst_ip;
	struct in6_addr src_ip6, dst_ip6;
	__be16 udp_dport;
	__be16 udp_sport, udp_sport_mask;
	u8 ip_tos, ip_tos_mask;

        <there may be padding gap here>

	struct rhash_head linkage;
        ......
};


Instead of:
     .key_len    = offsetof(struct efx_tc_encap_match, linkage),
now use:
     .key_len    = offsetofend(struct efx_tc_encap_match, ip_tos_mask),



