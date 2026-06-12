Return-Path: <netdev+bounces-298446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /BS2AMF5K2of+QMAu9opvQ
	(envelope-from <netdev+bounces-298446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:15:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 952B467666F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:15:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="I/S1rx1Z";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298446-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298446-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 076623022FED
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341263905EA;
	Fri, 12 Jun 2026 03:15:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE01372B57
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 03:15:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781234110; cv=none; b=ED9VLAarx/lgWhyFAQAITkDJiuIBYLtYWaRBHcwZcNaxwKjroTJNTmQyMySecWp2OB4fdcvXPKXjr+kUXlYOM0Y65TJX897Opxa2hNof2lVPdtB/oByD7+i1cYsLzBCnHlaieEyqjibgTWJtYWoOIP0kvTXZ5vS7f3+pgnkfyBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781234110; c=relaxed/simple;
	bh=V05AsWAa1UWGRukEpGKz9sh81+TnR8w8ANVgPsPOj6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xiw46iH4z0nannblJANQZnboOwRtwZdb+0+no060H0xwKtAA6fybehZdLwuyFpCHpKa4yPo7nk03X257xwjg/31/6IiZ681DQy8IPS0khHlNQNkWNogbxgHSjRVQ1CJ/q3IepBTidKbbkLIdVRnG1qR5FtX3aFDi2HGlK2X+NNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/S1rx1Z; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c40397e3caso2609275ad.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781234108; x=1781838908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V05AsWAa1UWGRukEpGKz9sh81+TnR8w8ANVgPsPOj6c=;
        b=I/S1rx1ZV07niCbP1Y8v/ASVKVilCUyueX8+bRakpf1i89eT2FkQth4bQb3ToSq/CP
         +TqRkahRLV4rj9bWQhu4FDMPex6x6G3ISAOF8X1OUtrn1kxVsFwUBR/rIHDC0fPeQz+S
         4LcjaSdEz8Of97ZtVhTYk3+sGIyOxdncxVZiCm0l4K6mrfRur06NrhJsDYDsbDNbXuhk
         6RjhH3aWNqP9IFUWG3I1pWx0aM4e5Izof5p6P6KoguYSCa7pOeCKcKzRcpAPS5rc5X7A
         5qSBm534NlExkHhxL3snmJjtYu2jWMH3pSJwVcNLJDbSL6mS4zKODsvSdwxZiEUj7KqQ
         PLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781234108; x=1781838908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V05AsWAa1UWGRukEpGKz9sh81+TnR8w8ANVgPsPOj6c=;
        b=KWqklKsyYAHId6PowCzQPiB5oTe1pdIu7A9Seqb4nYMWdfTpqIeK6yutk6lTx1TjqZ
         /gf8KxbvDQgRZHH1ZUjEKpArPhai55hVk2vFdYg8uhAGTitP8Spxy/Kis2BEKmygwAkY
         ZYs9vc926UqZN+lA08KNTfnyQo1smLsWxPzrzvoaCBTRhjFJSgqP9xA1zz/yIq79xPFe
         TgxkiWYk5xz3Z1nrom87vBNONnfiI1JEUt6iWFAI8FPflHHo8aMkfkmaI+bxHgw+8Jm4
         71OTayd54xdmf5rxXxyeLxJq7/kqzeDj8ABFlhx3D47UFD8qa+vp2ESHH1/8kZH8GP+Q
         TWNw==
X-Forwarded-Encrypted: i=1; AFNElJ94+jWQR1vU0PKXSWj0VqTMra3QIbes0cGoxfMEeWxElBnIYW8TL4j1Gfm2My7mIidP1bDdqAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBoQp1AHoayoB5KV9eqNQ8tem2Qcf2XLeNYFCftxU0YEIRsphS
	D7uFlh6ltaM5ZeuR+Ws2qXpg4iPdotlb7uYy9dPQXhsARcnES4kmJcXu
X-Gm-Gg: Acq92OG2Agm5GA+7tVwgz4fm9oOJSGwAnhffsvXlyj6njUpvcddKvVbZ06vfhd/I+4b
	lQVVZgZy2WtVNOkcm2Tx+th+0hFHs/h8JGrxVWI717imWb4VzKAqmB8RRU5+Ursx9+42+RHrCYu
	1qBpEMLpoBbQsGtN83NmXBjA079wEPfT2enEHP7Fk8v8Nb60/onBwOAOCL6x2sppENQeZfJ0cOq
	nYPlIo3CvQCwcjtLuHYHjU0FaC4Xht/qIPGvOQbRZ+0Gka8R9iWs+6h9O5EkudIWapK/HQnjfH4
	P10SiTWyrbhsrl1IoBu/Nu5BY2NgmqNNzYvLjBhv5B9peSZo2n761rfy72CBs6fxHWtWsS4O++4
	lcbwWK/2ksYQMXfL+2j4CsNC+yEB0p8AGTmsYeihvzb1F0ihExLDFPoxmjs8x/HoqvaV793soWp
	GbfkBAz8SMYe33OEkL
X-Received: by 2002:a17:902:e812:b0:2c1:b8af:18ab with SMTP id d9443c01a7336-2c411d7a10bmr14275715ad.19.1781234107996;
        Thu, 11 Jun 2026 20:15:07 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327acab5sm3637705ad.40.2026.06.11.20.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:15:07 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Google-Original-From: Yuya Kusakabe <y-kusakabe@bbsakura.net>
To: andrea@common-net.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
	andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	shuah@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	stefano.salsano@uniroma2.it,
	ahabdels@cisco.com
Subject: Re: [PATCH v2 3/7] seg6: add End.M.GTP6.E behavior
Date: Fri, 12 Jun 2026 12:14:56 +0900
Message-ID: <20260612031456.4164970-1-y-kusakabe@bbsakura.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260605032001.2f46e6a55f69896d29da69df@common-net.org>
References: <20260605032001.2f46e6a55f69896d29da69df@common-net.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-298446-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea@common-net.org,m:yuya.kusakabe@gmail.com,m:andrea.mayer@uniroma2.it,m:davem@davemloft.net,m:edumazet@google.com,m:dsahern@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:justin.iurman@gmail.com,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:stefano.salsano@uniroma2.it,m:ahabdels@cisco.com,m:yuyakusakabe@gmail.com,m:justiniurman@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,uniroma2.it,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,cisco.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 952B467666F

From: Yuya Kusakabe <yuya.kusakabe@gmail.com>

Hi Andrea,

Thank you for the review. The points shared with patch 2 (NF_HOOK
split removal, drop reasons via your prep series, reverse christmas
tree, the missing frag_off check, BAD_INNER scoping, the repeated
size-selection ternary, iptunnel_handle_offloads(), the fixed source
port, and the RFC 6040 wording) will be addressed as described in my
patch 2 reply and apply here the same way. Below are the
End.M.GTP6.E-specific points.

> SEG6_LOCAL_MOBILE_SRC_ADDR (the "src" attribute) is copied verbatim into
> the outer IPv6 source address. In patch 2 (End.M.GTP4.E) the same
> attribute is used as a template from which bits are extracted to form
> the IPv4 source address, and may be entirely unused depending on
> v4_mask_len.
> This UAPI overload needs revision.

Agreed. With v4_mask_len gone, End.M.GTP4.E will not take src at all
(the IPv4 SA will be recovered purely from the inbound IPv6 SA, see
the patch 2 reply), which removes the verbatim-vs-template overload.
In the new SEG6_MOBILE_* namespace I plan to give SEG6_MOBILE_SRC_ADDR
a single meaning for the IPv6-emitting behaviors
(End.M.GTP6.E/D/D.Di): the outer IPv6 source address, used verbatim.
The one remaining non-verbatim consumer would be H.M.GTP4.D, where the
configured address acts as the RFC 9433 Figure 12 "Source UPF Prefix"
template with exactly the 32 IPv4 SA bits overlaid at
v6_src_prefix_len. H.M.GTP4.D posts last in the per-behavior order, so
if you prefer the two semantics not to share one attribute name, I can
give the template a distinctly named attribute in that series.

> udp6_set_csum() already handles the CHECKSUM_PARTIAL + pseudo-header seed
> setup and also covers the GSO case. Using it would avoid open-coding this
> sequence.

Will switch to udp6_set_csum(), thanks. It is also more correct than
the open-coded sequence: for a non-GSO inner that arrives
CHECKSUM_PARTIAL it resolves the inner checksum via local checksum
offload instead of clobbering csum_start.

> seg6_lookup_any_nexthop() already calls skb_dst_drop() internally. The
> explicit call above is redundant.

Will remove.

> Nit: fc_dst_len is int in struct fib6_config (IPv6 prefix length, range
> 0..128); the (unsigned int) cast is not needed.

This check will move into the attribute parser of the new explicit
locator-length attribute (see the patch 2 reply), so the fib6_config
peek and the cast both go away.

Thanks,
Yuya

