Return-Path: <netdev+bounces-277962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LDgEaSG3GmgSQkAu9opvQ
	(envelope-from <netdev+bounces-277962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:01:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D293E79CC
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EECE300F78B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 06:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0805389DF3;
	Mon, 13 Apr 2026 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0m5pEYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9181A3166
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776060061; cv=none; b=tzEBM61u9xwTsuuFa5DdU/8zSYaz403PMD3XzDJT4V4X+BwrZfUonMG3ScTd82MDgruFOAk2MpLafmJ5rrqssexwyRwkLnAqDBpoF4QLMm1bT6zM92KWPnydfBUy6CaywnFTQ2Y0rYDRN3CFrxX9RrQVLiQ+sjK4Q4FlH4lehmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776060061; c=relaxed/simple;
	bh=Ln6IAvgOhcWwoR9rKuHTj2ywlYDUSlR7scx3Ax8/FyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7pWFbGYhT7cRwt1DMq1LKHEXqbmVBqAbsXpl3P9u69WN1tdvmIc9Cuga1rRtLBnsfgzdhbidDgwOr428277B7kwmvmS0uhHMWYXITzKvEvfw4UXnIvuJqp9Hb0KOA42CIW3qXC7d+583untlYYxqGHUcNjhriUStNTR7uk/FG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0m5pEYr; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4b77adso11663492c88.1
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 23:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776060059; x=1776664859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VTVqe+ecIb6U9ywp6WWs2k9bOAQmGwTcDgM9/aAoBc=;
        b=q0m5pEYrrT1E/gBozmLVOkrUTFr8yfP5tu93BrUIlvjMvEdJCqps7BunMY5IbZbyGa
         cLIO9pMIkeGD+iwjPexsNzn7jK02GLuygsjENVIep+dcMhRd6eAC5lZyHOn9bvHxAb6i
         0OVzpLJNlxJe4ugXs5NQQSaf0O+ZxlS416RMw0V4mzFLXVHqiLne/A0HSnXZngs6bLki
         NoaUjGIodP9Owm2TgJ7Z/juVsD/0R6KtCEeb+jFu0TPSJ6NlrU/WBugGXMFfctVhHQ0O
         LNjX/NGgybhc3fJOQN4Pw3/HoIgAkoK3QNe3ldrDEDGWDyPCfcSeusYzIqTewfB0AJ3u
         AJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776060059; x=1776664859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VTVqe+ecIb6U9ywp6WWs2k9bOAQmGwTcDgM9/aAoBc=;
        b=tD3YdrqTmQbvhtczeXILXvl2qjIubTGnaCkYWttcIgYr0AkVIUau+NcStbENLJNySM
         j6XH9YzgVZotP/OFNVnICu13wBIVIPtDMo0Pz/RPa/xnQC5M49jgBcclzs9bGAZSDi01
         x3wdOet3W+fafrzg8Huu7XbWgXH07UM/VA8stQXqsuYdo9WpYfeH06rfktp5KteDac1z
         KjlET2nfkA5KLNNT4Kh0zAm1GM9r6EovdxUfYNNGBCHNsVajyNl32D+z2MQGHU5MNCDy
         mUB0C+3wnzaP9rNhGu+L83gTQwzaxGnYNwNjQYNS2KZ5WOFYgNbXlVztpvyjgLqC3tOM
         bA3g==
X-Forwarded-Encrypted: i=1; AFNElJ83iGFU0+YW7y/3P4G+jWuFLB7K3BWhDrEu9iXJhnN9GTzIV5opeetqwf3e2zR+MMQy8dUGOsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ol8T+FVJjuE4n+HXLH92YzB9d0/5Ea115nm5pONRHuJUK7Y1
	s++DNiAyvgOIqGwVI4XcsE/UyS3AByu/VHd6xsmYRwTtwZZtKA5hFTuY
X-Gm-Gg: AeBDieu1yIvnH4rbR8qbrg5SNdpA8CEgWL5wnpgehjb58rn1vbjJ0w6Qp/6hoJv9zV3
	UjbqPy1RQ3ovKgzBFIafNeAxEy0rv5ArygmtopGeqPGyi2YnG+gsMQ7lFhu6PwzWeCGCmHC9I5n
	bEvfdkAaF1Z2a/Pig9syor8eyRZq3dDAtCfp9hevCxzNMR6EvK7gOPNum1hHFINujal/iXkuSWb
	U+Be58ublPS5qhXtel2VcmLUQUa/B7gJ72al87VvzCqA1KSFp0Vhh4F3XEgzlRegF3Lujy5j2ZX
	fnEMveLm7CZGfj8VAofRdqFGVEDb/mRoKYh51nrbs4i7a+F4jmrDcGFq7JegfhxgLq6P+zdN9GV
	sIX/MYb93rf5Ulp0qG59hUs0vtNshQtNs7Oa9YiN76Psgf9niZ3HYW6jOhPZZpIPnLCSwlEroYI
	fZYWXIjGYgx5WbpAI1fkLfPDxjL+wjVIPknLhzhQ==
X-Received: by 2002:a05:7022:6614:b0:12c:43:839b with SMTP id a92af1059eb24-12c34f07cc9mr6433916c88.35.1776060058876;
        Sun, 12 Apr 2026 23:00:58 -0700 (PDT)
Received: from [10.0.0.3] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345b6208sm14051624c88.8.2026.04.12.23.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 23:00:57 -0700 (PDT)
Message-ID: <7369ab71-e3bc-48ac-8165-439ad8595fc0@gmail.com>
Date: Sun, 12 Apr 2026 23:01:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>, Ren Wei <n05ec@lzu.edu.cn>
Cc: "jmaloy@redhat.com" <jmaloy@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "yifanwucs@gmail.com" <yifanwucs@gmail.com>,
 "tomapufckgml@gmail.com" <tomapufckgml@gmail.com>,
 "yuantan098@gmail.com" <yuantan098@gmail.com>,
 "bird@lzu.edu.cn" <bird@lzu.edu.cn>,
 "enjou1224z@gmail.com" <enjou1224z@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <cover.1775809726.git.caoruide123@gmail.com>
 <1316452e465e9a96fce44ec15130a14f3872149f.1775809727.git.caoruide123@gmail.com>
 <GV1P189MB1988963A155568005A37BF7FC6242@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Ruide Cao <caoruide123@gmail.com>
In-Reply-To: <GV1P189MB1988963A155568005A37BF7FC6242@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,gmail.com,lzu.edu.cn,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-277962-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[caoruide123@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4D293E79CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/12/2026 8:06 PM, Tung Quang Nguyen wrote:
>> Subject: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
>>
>> From: Ruide Cao <caoruide123@gmail.com>
>>
>> tipc_get_gap_ack_blks() reads len, ugack_cnt and bgack_cnt directly from
>> msg_data(hdr) before verifying that a STATE message actually contains the
>> fixed Gap ACK block header in its logical data area.
>>
>> A peer that negotiates TIPC_GAP_ACK_BLOCK can send a short STATE message
>> with a declared TIPC payload shorter than struct tipc_gap_ack_blks and still
>> append a few physical bytes after the header. The helper then trusts those
>> bytes as Gap ACK metadata, and the forged bgack_cnt/len values can drive the
>> broadcast receive path into kmemdup() beyond the skb boundary.
> Can you explain how that peer can alter the STATE message ? If it can, what concrete values are used  and on what fields of the STATE messages ?

Thanks for the review.

To clarify, the peer is not "altering" an already received STATE
message; it is actively sending a malformed LINK_PROTOCOL/STATE_MSG
after the link has already negotiated the TIPC_GAP_ACK_BLOCK capability.

Concretely, the crafted STATE message is sent with a modified msg_size
so that msg_data_sz(hdr) is 0, but the actual UDP payload still carries
extra physical bytes after the 40-byte TIPC header. Those bytes are then
interpreted as the fixed Gap ACK header. For example:
  len       = 0x07fc
  ugack_cnt = 0xff
  bgack_cnt = 0xff

These values are specifically chosen so that the existing sanity check
remains internally consistent:
  struct_size(p, gacks, 0xff + 0xff) == 0x07fc

Therefore, the existing sanity check does not reject this case. It only
checks the self-consistency of the attacker-controlled Gap ACK fields;
it completely fails to check if the declared Gap ACK record actually
fits inside the enclosing STATE message's logical payload length.

>> Fix this by rejecting Gap ACK parsing unless the logical STATE payload is large
>> enough to cover the fixed header, and by rejecting declared Gap ACK lengths
>> that are smaller than the fixed header or larger than the logical payload.
>> Return 0 for invalid lengths so malformed Gap ACK data is not treated as a
>> valid payload offset, and drop unicast STATE messages that advertise Gap ACK
>> support but still yield an invalid Gap ACK length. This keeps malformed Gap
>> ACK data ignored without misaligning monitor payload parsing.
>>
>> Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
>> Cc: stable@kernel.org
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>> Suggested-by: Xin Liu <bird@lzu.edu.cn>
>> Tested-by: Ren Wei <enjou1224z@gmail.com>
>> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>> ---
>> net/tipc/link.c | 16 ++++++++++++++--
>> 1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/tipc/link.c b/net/tipc/link.c index 49dfc098d89b..44678d98939a
>> 100644
>> --- a/net/tipc/link.c
>> +++ b/net/tipc/link.c
>> @@ -1415,12 +1415,22 @@ u16 tipc_get_gap_ack_blks(struct
>> tipc_gap_ack_blks **ga, struct tipc_link *l,
>> 			  struct tipc_msg *hdr, bool uc)
>> {
>> 	struct tipc_gap_ack_blks *p;
>> -	u16 sz = 0;
>> +	u16 sz = 0, dlen = msg_data_sz(hdr);
>>
>> 	/* Does peer support the Gap ACK blocks feature? */
>> 	if (l->peer_caps & TIPC_GAP_ACK_BLOCK) {
>> +		u16 min_sz = struct_size(p, gacks, 0);
>> +
>> +		if (dlen < min_sz)
>> +			goto ignore;
> This checking is redundant because with existing sanity checking, the invalid gap ACK blocks will not be used to release acked messages in transmit queue.

The `dlen < min_sz` check is required because the existing sanity check
already dereferences `p->len`, `p->ugack_cnt`, and `p->bgack_cnt`.
Without this new check, an Out-of-Bounds (OOB) read occurs before the
old sanity check even has a chance to run.

>> +
>> 		p = (struct tipc_gap_ack_blks *)msg_data(hdr);
>> 		sz = ntohs(p->len);
>> +		if (sz < min_sz || sz > dlen) {
>> +			sz = 0;
>> +			goto ignore;
>> +		}
> This checking is redundant. Existing sanity checking is good enough.

The `sz < min_sz || sz > dlen` check is not redundant because the old
sanity check completely fails to verify if the declared Gap ACK length
(`sz`) actually fits inside the enclosing STATE message's logical
payload length (`dlen`).

Without checking against `dlen`, an internally consistent spoofed packet
will pass the old check and cause OOB reads during the subsequent block
parsing.

>> +
>> 		/* Sanity check */
>> 		if (sz == struct_size(p, gacks, size_add(p->ugack_cnt, p-
>>> bgack_cnt))) {
>> 			/* Good, check if the desired type exists */ @@ -
>> 1434,6 +1444,8 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga,
>> struct tipc_link *l,
>> 			}
>> 		}
>> 	}
>> +
>> +ignore:
>> 	/* Other cases: ignore! */
>> 	p = NULL;
>>
>> @@ -2270,7 +2282,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct
>> sk_buff *skb,
>> 	case STATE_MSG:
>> 		/* Validate Gap ACK blocks, drop if invalid */
>> 		glen = tipc_get_gap_ack_blks(&ga, l, hdr, true);
>> -		if (glen > dlen)
>> +		if (glen > dlen || ((l->peer_caps & TIPC_GAP_ACK_BLOCK) &&
>> !glen))
> This checking is redundant. Existing sanity checking is good enough.

The unicast caller-side drop `((l->peer_caps & TIPC_GAP_ACK_BLOCK) &&
!glen)` is also necessary. Once the capability is negotiated, a valid
Gap ACK record MUST have at least the fixed 4-byte header. If `glen ==
0` from such a peer, it indicates a malformed payload. 

The STATE message must be dropped here so it is not passed on to
`tipc_mon_rcv()` as if monitor data started at `data + 0`, which would
misalign the monitor payload parsing.

>> 			break;
>>
>> 		l->rcv_nxt_state = msg_seqno(hdr) + 1;
>> --
>> 2.34.1
>>

