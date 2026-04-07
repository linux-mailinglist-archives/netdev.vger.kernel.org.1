Return-Path: <netdev+bounces-276085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4fFFJ/8z1WnY2gcAu9opvQ
	(envelope-from <netdev+bounces-276085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:42:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E65333B1F14
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B2BF3009CEB
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B9D3B776E;
	Tue,  7 Apr 2026 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a3zlLbaU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gItCeme0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a3zlLbaU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gItCeme0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9783E3126AD
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579949; cv=none; b=pRukvCpOUAPtHrdpAIbrLTv1UcJ7Yu6DzmnhBwAAfV556OBww0mcWYgVYDKhq6wPbSGlT7lwvbBYZBV+lfSHcmKRUomHEcuIFjHm5VZHLrOpTkPykEIvGtYQ7Al+X8ksTbdYzqlx6ygtUWzjq67ScBEfdJXGOijDD+h2w9O/3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579949; c=relaxed/simple;
	bh=rm3zuZ4LooG//y/keO+bZgOIvFN4YQCBPQGBTTpUYN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YmvSnLRJcMhR9+CWMvsBLZH/0A3pOFccZ8NJndh4VcX3cMXl3T6gvrFAwLKgmMACHuZU2i6eWNAWkSglm/sbZYJV3BcQreHRHbWma7ehjXZgw8xZ5tsS0A+Ah2EF287vDlrKFn8rYjPq/Tgjqbe+8i9XzU0FO/RPYDRlaML5aVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a3zlLbaU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gItCeme0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a3zlLbaU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gItCeme0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA0105BE21;
	Tue,  7 Apr 2026 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775579945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNf+Nxfi//M4pyZXyd5SUl2NN44Qo5FMIDu2VAn1zY4=;
	b=a3zlLbaUMg6BE02qaHpuVg9QCS/ai8yOs+1KNNTDPFvxwA/rQ/js4XKWugEathS2isgJig
	74dx9tTSCsweB97Ga76BJvUUlDejdwnKqhdd8ZQmsyT6rVZVmwPk7A3oMTXDbfIpWD1pa1
	YSeEOUr2FRN18R21ELeMXv2CPxOx1xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775579945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNf+Nxfi//M4pyZXyd5SUl2NN44Qo5FMIDu2VAn1zY4=;
	b=gItCeme0wAgqx4LVwNb2xRUAcoMKZwhs4VTwtiQ1FXMfEEkkD1/C2Z60031luavrv5yaTi
	t4RxYHCnuWVlSRAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a3zlLbaU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gItCeme0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775579945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNf+Nxfi//M4pyZXyd5SUl2NN44Qo5FMIDu2VAn1zY4=;
	b=a3zlLbaUMg6BE02qaHpuVg9QCS/ai8yOs+1KNNTDPFvxwA/rQ/js4XKWugEathS2isgJig
	74dx9tTSCsweB97Ga76BJvUUlDejdwnKqhdd8ZQmsyT6rVZVmwPk7A3oMTXDbfIpWD1pa1
	YSeEOUr2FRN18R21ELeMXv2CPxOx1xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775579945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNf+Nxfi//M4pyZXyd5SUl2NN44Qo5FMIDu2VAn1zY4=;
	b=gItCeme0wAgqx4LVwNb2xRUAcoMKZwhs4VTwtiQ1FXMfEEkkD1/C2Z60031luavrv5yaTi
	t4RxYHCnuWVlSRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B7E94A0B0;
	Tue,  7 Apr 2026 16:39:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0VOeGikz1WnxFAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 07 Apr 2026 16:39:05 +0000
Message-ID: <507ccd57-b164-40ab-95e9-2fcc185a1f7d@suse.de>
Date: Tue, 7 Apr 2026 18:38:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] net/sched: skb leak with HTB + fq_codel on packet drops
To: Damilola Bello <damilola@aterlo.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAPgFtOLaedBMU0f_BxV2bXftTJSmJr018Q5uozOo5vVo6b9tjw@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAPgFtOLaedBMU0f_BxV2bXftTJSmJr018Q5uozOo5vVo6b9tjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276085-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: E65333B1F14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 4:29 PM, Damilola Bello wrote:
> Description:
> 
> Using fq_codel as a child qdisc under HTB results in continuous growth
> of skbuff_head_cache objects when packet drops occur. Memory is not
> freed even after traffic stops, and the system can eventually run out
> of memory.
> 
> Regression:
> 
> - Works on: 6.18.16
> 
> - Fails on: 6.19.x (tested on 6.19.10-200.fc43)
> 
> Environment:
> 
> - Kernel: 6.19.10-200.fc43
> 
> - Distro: Fedora 43
> 
> - NICs: ens2f0np0, ens2f1np1
> 
> - GRO/GSO/TSO: disabled
> 
> Reproduction:
> 
> #!/bin/sh
> DEVS="ens2f0np0 ens2f1np1"
> for DEV in $DEVS; do
> tc qdisc del dev $DEV root 2>/dev/null
> tc qdisc add dev $DEV root handle 1: htb default 10
> tc class add dev $DEV parent 1: classid 1:10 htb rate 100mbit
> tc qdisc add dev $DEV parent 1:10 handle 10: fq_codel
> tc filter add dev $DEV parent 1: matchall flowid 1:10
> done
> 
> Generate traffic exceeding 100mbit (e.g., iperf3) to force drops.
>

Hi,

I managed to reproduce this and did a bisect. This commit introduces the 
issue:

commit a6efc273ab8245722eee2150fa12cf75781dc410
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Nov 21 08:32:56 2025 +0000

     net_sched: use qdisc_dequeue_drop() in cake, codel, fq_codel

     cake, codel and fq_codel can drop many packets from dequeue().

     Use qdisc_dequeue_drop() so that the freeing can happen
     outside of the qdisc spinlock scope.

     Add TCQ_F_DEQUEUE_DROPS to sch->flags.

     Signed-off-by: Eric Dumazet <edumazet@google.com>
     Link: 
https://patch.msgid.link/20251121083256.674562-15-edumazet@google.com
     Signed-off-by: Paolo Abeni <pabeni@redhat.com>


I tested this solution a bit and seems to be fine. We could probably 
just drop directly if the qdisc isn't the root.. but I believe this is 
cleaner and more future-proof.

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c3d657359a3d..61ba54e909f2 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1170,12 +1170,18 @@ static inline void tcf_kfree_skb_list(struct 
sk_buff *skb)
  static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff 
*skb,
  				      enum skb_drop_reason reason)
  {
+	struct Qdisc *root = qdisc_root_sleeping(q);
+
  	DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
  	DEBUG_NET_WARN_ON_ONCE(q->flags & TCQ_F_NOLOCK);

-	tcf_set_drop_reason(skb, reason);
-	skb->next = q->to_free;
-	q->to_free = skb;
+	if (root->flags & TCQ_F_DEQUEUE_DROPS) {
+		tcf_set_drop_reason(skb, reason);
+		skb->next = q->to_free;
+		q->to_free = skb;
+	} else {
+		kfree_skb_reason(skb, reason);
+	}
  }

  /* Instead of calling kfree_skb() while root qdisc lock is held,

Of course, in this situation if the root qdisc does not support 
TCQ_F_DEQUEUE_DROPS flag then, the child won't use the optimization. If 
I am not wrong all the qdiscs that can be parent currently do not 
support TCQ_F_DEQUEUE_DROPS. Anyway, this generic fix is in my opinion 
cleaner than handling every caller.

I am sending this as patch for net tree.

Thanks,
Fernando.

