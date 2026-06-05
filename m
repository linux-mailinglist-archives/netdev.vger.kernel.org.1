Return-Path: <netdev+bounces-295962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rb3WFhcpI2pWjgEAu9opvQ
	(envelope-from <netdev+bounces-295962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:52:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD11C64B0D9
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:52:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=M12yxGjd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295962-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295962-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1653301AD0F
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145BD43E4BA;
	Fri,  5 Jun 2026 19:46:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065171A683A
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 19:46:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688809; cv=none; b=TYw0vVV9C5rrs9VUO/HvdtjV4TRxUG/avk2iveUTgC5PnAA/FtSeKPIOnp5sy17gcq4qKPnx5ZNo7tr8oR4A3bOfNRfCWbEPp3G2aMpwdvBsUalg6XPe/G/q952d4bDjdKB4vhYDUWYNU8z1xMc5MJwpFTxHdbHYeduFkAkZuYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688809; c=relaxed/simple;
	bh=I4BJujHHZUZqw6n+betSBc0+olYlvmBlXUXmbzBrl7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGseR1C5kf1O18kkt6Uv6GuZN3w+750MqgYNn1LbIhQ6jNDuCCGBPfBQqrndBW/DTPbS3Ows8+p7H4UT5GGhgxL5g/ixnNwpUBDFUz+L+wdqvQJxcHvjgjxohBVHB5DHiyq7+PBehqbWYjvdn/tvZdl1qjC5d7ouWSpQ7SHR7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=M12yxGjd; arc=none smtp.client-ip=209.85.222.180
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-91587626a3eso284694885a.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780688806; x=1781293606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QkwkhyiQDGQIbGWw1Mr8x2MZmKdl2kRdID6GKjvxF4g=;
        b=M12yxGjdAAiqiImH6CCOvssnZPHBETqmfKAkhCG22fwVZpVLtO1+UhZH6zXzpvy8Mb
         fm8ltSIss++FusPrYZ+XRyjjbMHzswlGRTsjF5VN7f9oEKnszuD3P1dPW/Tt8jsoasll
         vz81iWDFUyIJMmqCRDUhZ10qtYN3WJAXhCCA+mHpQ8Ln/d2Pd4cZFm40l1gLkCpeDIXM
         NCe6LgQhvaXR/qK66zSjzX08PWIo/Ldp2J3vDhgeb8czpga8EqkKM6INA/n359RpOIvJ
         eIFnRL+n6/pChM+u0mPI89c8dWo2fFcbHVmq58auQBS5mIuVxMt4jcIuiqBNWdllTYtB
         35jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780688806; x=1781293606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkwkhyiQDGQIbGWw1Mr8x2MZmKdl2kRdID6GKjvxF4g=;
        b=KEBOC6e+mCWhYcHjiqjyDwynr4/N5+iHLh1+c0tNMbv3wZSSfe8WNzrY6ZF+rxymJf
         xl+QcmpaRlSAmoDgHuLxW0xrXEpYRGisXbCvQG2N7e+eDrsRlrVPLJlcRbVmuJ5LfmO9
         eWLD1sNK/9xD4l3smNv4j4XSh07BFlEaqziGeY6Qv3iUwct1EsS0KbQLnBmryBGbhSnu
         kkLkv0vX0KnQQGo7RM0qJOEFtOpRx9ZNIKXaA32Df5QObqM8UP76VldAQdyneSdDVdgj
         IU9TVAE7odYsmn4vn0pJ7m/CE0wHr1ZDmlWR0EcIeNRwyXnYc1Iyuy3O4FSWShGJS0th
         zmOA==
X-Forwarded-Encrypted: i=1; AFNElJ/6sqqS9lyd8t3aijFQsWmmfb/TIFrIqgz+xhzQPs2Jfd1UUgjjsl4U4/IRnXxoTUZATymXrNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Be3AlXoY6cffepZtMZh94TPXoCZggq6pqUbfyQ2L3AdL70uK
	jpVRFUGlX9nAAB/i9JgA/ouMHBAprjXwO5hc5XWkeuh8IFxodUDHsG5tZK+0a5Fef6s=
X-Gm-Gg: Acq92OHRC7UUvmYBk2zHrfEVSeBny7bA4IzCT/2RfZ7Uu8yWcdFn+RAdbTZE6x1XFkD
	+Tv60bmmqXtJI/9kdMgH+lY9n75VwLbA+Eg4WqPcxpywm1LG4+9fifAHsju1n5RlxYO9x6w/7Ko
	OS1m3NO3FETYXNGyuemXUEmPKo6PC+q6U2MLun9bysZbdBKhkzE+/mK/AfU7MtEONOa6SruCfdv
	1eKhzK+ICSzIz/og6/sXuer616I/oobBZSDXcWUtmzN3cDU2hpq1/pMSfGrkVOgtC7r7iyJKVgn
	/2yvl/A8Ozzk4U/ZQx0sUEmYwYWuoJjK//8O2fjsT+CMRkMUzrcyvDi00VQM4ilun9Wy1BZKGx9
	UjIYW7ci9rw1B0uDe8EvERuMrhWTESm4Id3V8El3+q/EGGW+Fnh8lgr6YO/wE1mYo3Eb1pQmYly
	S+fffaC2MTGLDUpjAcd7lBToabrDXVeOH/gG2/GgqCSZ+0XD/W
X-Received: by 2002:a05:620a:25c6:b0:912:671b:d098 with SMTP id af79cd13be357-915a9dee09dmr926759785a.51.1780688805905;
        Fri, 05 Jun 2026 12:46:45 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a37bcd6sm996117285a.25.2026.06.05.12.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 12:46:45 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: act_pedit: require matching IPv4 L4 protocol
Date: Fri,  5 Jun 2026 19:46:39 +0000
Message-ID: <20260605194640.2645386-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295962-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD11C64B0D9

The extended IPv4 L4 header mode in act_pedit can select TCP or UDP
header fields without confirming that the IPv4 protocol field matches
the selected transport header.

That lets a rule written for TCP or UDP modify unrelated payload bytes
in a packet carrying a different protocol.

Verify the IPv4 protocol before applying TCP or UDP extended header
edits.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/act_pedit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bc20f08a2789..9a4590451f7e 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -341,6 +341,8 @@ static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, const int head
 
 		if (!iph)
 			goto out;
+		if (iph->ihl < 5 || iph->protocol != header_type)
+			goto out;
 		*hoffset = noff + iph->ihl * 4;
 		ret = 0;
 		break;
-- 
2.43.0


