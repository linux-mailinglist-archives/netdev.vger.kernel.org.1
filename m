Return-Path: <netdev+bounces-263602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFuVHwnSp2l7kAAAu9opvQ
	(envelope-from <netdev+bounces-263602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:32:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C71FB2EC
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3395F301701C
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 06:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E80366568;
	Wed,  4 Mar 2026 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="YYdNvKf9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD622CBF1
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772605946; cv=none; b=I8Yq4xKqgmhXqes1ew3RRGa8UHpKnu8Qyx9MYI++XcudBrsIej7F6WmQPyCbflPlj96u9X3MZfzr8ZE96LPzKFvQBKlZy/4eJfN+DujnGkFcfLpsngcZtOtKCBjjSdvmjHkOIarPnq+2XecnJUq+brsbeofjN1oEMatkdTZkdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772605946; c=relaxed/simple;
	bh=HVfQkiV51veq3wmq+a4sx0+wWXtsnnD6Z55dsxRBT04=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=F5Gkt9JTEzEL0u7rQOhTdo0k2CtqyCYUNaXAGgJAHLhsbDt9cUcTJfIWpvOmWuAWnX8JbhMixI3oMkyQiafbXYyiwH2H8vcUNXdMkr9kU+u65N8v7SHS2PTa7dfjEki6MJJeO9WAT/tFmeGOETICMqpCp3tIC6Wcf803v7KcHO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=YYdNvKf9; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:To:From:Subject:
	Content-Type; bh=+sZDNwyjcOjiVkOaFfTRGX4IQP/rCpWEkThWxU3UuS0=;
	b=YYdNvKf9+C/lHlwOGVeRC6TU5UZ107rfNqzHcloWOGRnVV6rwYR8hJe3iJ5kJt
	tqxYM4Qf6N/Df+WQ5wetrns/V4SamwIQucpgv9T7Q/vHG2PWR3Z9lqAEb09RAbzH
	L7DQ0fGCVBIDLODyGhnjjjM7oBS5YtK5VaP6biBxpfWz4=
Received: from [7.247.167.131] (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgDH7rDS0adpgjUDAg--.7725S2;
	Wed, 04 Mar 2026 14:31:47 +0800 (CST)
Message-ID: <b0355e40-814b-42dc-8158-3ff32b80f14f@yeah.net>
Date: Wed, 4 Mar 2026 14:31:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Cc: jramaseu@redhat.com, kuba@kernel.org
From: xietangxin <xietangxin@yeah.net>
Subject: [QUERY] net: gso: question about commit 864e3396976e affecting
 tunneled IPv6-in-IPv4 packets
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Ms8vCgDH7rDS0adpgjUDAg--.7725S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw18ur15try7ZFyxJF4ktFb_yoW8WFy5pa
	4kKFy8tw4DWF45Aw1UAr1Fv390yr4kGa13WrnavryUtws8WryF9FWSgrZIvFyDGa1fG3WY
	9ryjqryrA3Z8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxL08UUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiIRPsIWmn0dMBQgAA3w
X-Rspamd-Queue-Id: 610C71FB2EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[yeah.net:+];
	TAGGED_FROM(0.00)[bounces-263602-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[yeah.net];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

I'm writing regarding commit 864e3396976e ("net: gso: Forbid IPv6 TSO with
extensions on devices with only IPV6_CSUM"). The commit added a condition to
disable TSO6 for IPv6 packets with extension headers when the device only
supports NETIF_F_IPV6_CSUM.

In our environment with a hinic NIC (which supports TSO6 and IPV6_CSUM), we use
VXLAN tunnels where the outer header is IPv4 and the inner is IPv6 (TCP).
After this commit, large packets (>MTU) no longer use hardware TSO and fall back
to software segmentation.

After debugging, I found the condition:

	if (features & NETIF_F_IPV6_CSUM &&
	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
	    skb_transport_header_was_set(skb) &&
	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
	    !ipv6_has_hopopt_jumbo(skb))
		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);

In the VXLAN IPv6-in-IPv4 case, `skb_shinfo(skb)->gso_type` includes
`SKB_GSO_TCPV6` (inner is IPv6 TCP), but the network header points to the outer
IPv4 header. Thus `skb_network_header_len(skb)` returns the IPv4 header length
(usually 20), which is not equal to `sizeof(struct ipv6hdr)` (40). This causes
the condition to trigger and clears `NETIF_F_TSO6`, even though the inner IPv6
packet has no extension headers and the device is capable of handling TSO for
such packets.

I would like to ask:
- Is my case expected to have TSO disabled?
- If not, what is the proper fix?

Any feedback or guidance would be greatly appreciated.

Thanks,
tangxin xie


