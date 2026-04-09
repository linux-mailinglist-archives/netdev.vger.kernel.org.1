Return-Path: <netdev+bounces-277165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zYG3Dlot2GmwZQgAu9opvQ
	(envelope-from <netdev+bounces-277165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:51:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B915F3D0604
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7CC43012201
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 22:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1A2395DBF;
	Thu,  9 Apr 2026 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2U1hd/Pu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+0l6Pcim";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BcQsimcN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hypLwHmZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF128689B
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775775063; cv=none; b=njlVskaXzBYA1ghjDzzUKveWQHxfz25yPFcyxpzEmRKsijbbNMxEkw9Gw+Cpo0+uSrq+EqVM/YVMR+E4CdqGMTPvS07ysUYwMyZGVlvdV0Me3PQbVlXnPer1dSiZQY98ZjtYi0R8B4ycsJ5MJh94Y9XJmbsExE7zxsFGQkuEsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775775063; c=relaxed/simple;
	bh=a9nqqF3cbT99XNXj3eld8jCUHw47zPb1gSym/lslr2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UkUX9k5BmbCYEFEYghR3D3S9P8PDOC434mIe3uZljybRpCjdbByZPLCnv/ohisPuszftGbVqHNsmQkwAvQWpHES1AUAXizQEti1LFCDZO1IiTkDtuKa/F1L/cbLaRFQ7QMfYhvMyPGu/5jVaBG+gQ7/ofHmqZuZB+B7DxwyyLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2U1hd/Pu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+0l6Pcim; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BcQsimcN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hypLwHmZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4C385BCEF;
	Thu,  9 Apr 2026 22:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775775060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZIvNUgCDmRlFAZnyamiK0OY31cYxHzsJq9pG9ZWk6g=;
	b=2U1hd/Pu5xWHVcmSXv9z0TiD+cCA5E1CKtWZQQXjELoWQXq9fVh2ML40GvHeddsgsY79yI
	Cqg8lJIaHxLp8YH5SOZ+EE94RGDN2scR3VtQu+cDDGvkAEDbTjQmlT8PDRDGuXQK4YZCoE
	QCP+e1e86vIpZPG4J41X4d+8dZlQVUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775775060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZIvNUgCDmRlFAZnyamiK0OY31cYxHzsJq9pG9ZWk6g=;
	b=+0l6Pcimh3pJvEXBzAHH7XNfuXGzhfJ8JxE9cn7cvlIzjw7IGXfYUDTV8Fe/hsb4EpiEl1
	PwZuimTvXs4k1HDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BcQsimcN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hypLwHmZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775775059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZIvNUgCDmRlFAZnyamiK0OY31cYxHzsJq9pG9ZWk6g=;
	b=BcQsimcN5nrBhrO8B/inHezMDCSu5xYHVGYgTxMs6iWbfxo/WiehpX0956za+SheUMYOC1
	C/m+q7l6Na/MlIk5LZfJ+pPHJu0lH65DpncyD+bHbF3bMGplwz70Agca4TqMlnm3QUQorf
	rfkBd9XHXMpgmP/K/kTze3ZNmreL3Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775775059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZIvNUgCDmRlFAZnyamiK0OY31cYxHzsJq9pG9ZWk6g=;
	b=hypLwHmZtqdHShpazzBoy8gENVL/ewqXe8okFqpTKSg2MQbAedRZHjezJN9mqul+Qo8bFr
	DqREBoIGIGfoFJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 949F64A0B3;
	Thu,  9 Apr 2026 22:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /F6kGFMt2GkIXgAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 09 Apr 2026 22:50:59 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Dumazet <edumazet@google.com>
Cc: willemdebruijn.kernel@gmail.com,  davem@davemloft.net,
  dsahern@kernel.org,  kuba@kernel.org,  pabeni@redhat.com,
  kuniyu@google.com,  horms@kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH] udp: Force compute_score to always inline
In-Reply-To: <CANn89iKQhLOdtn-_viyDN8ytjJtR-4p0gteXL6gGSHoUYZp5Hw@mail.gmail.com>
	(Eric Dumazet's message of "Thu, 9 Apr 2026 15:36:15 -0700")
Organization: SUSE
References: <20260409221532.69090-1-krisman@suse.de>
	<CANn89iKQhLOdtn-_viyDN8ytjJtR-4p0gteXL6gGSHoUYZp5Hw@mail.gmail.com>
Date: Thu, 09 Apr 2026 18:50:53 -0400
Message-ID: <87v7dzoiia.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277165-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krisman@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmlinux.new:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailhost.krisman.be:mid]
X-Rspamd-Queue-Id: B915F3D0604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Eric Dumazet <edumazet@google.com> writes:

> On Thu, Apr 9, 2026 at 3:16=E2=80=AFPM Gabriel Krisman Bertazi <krisman@s=
use.de> wrote:
>
>>
>> Back in 2024 I reported a 7-12% regression on an iperf3 UDP loopback
>> thoughput test that we traced to the extra overhead of calling
>> compute_score on two places, introduced by commit f0ea27e7bfe1 ("udp:
>> re-score reuseport groups when connected sockets are present").  At the
>> time, I pointed out the overhead was caused by the multiple calls,
>> associated with cpu-specific mitigations, and merged commit
>> 50aee97d1511 ("udp: Avoid call to compute_score on multiple sites") to
>> jump back explicitly, to force the rescore call in a single place.
>>
>> Recently though, we got another regression report against a newer distro
>> version, which a team colleague traced back to the same root-cause.
>> Turns out that once we updated to gcc-13, the compiler got smart enough
>> to unroll the loop, undoing my previous mitigation.  Let's bite the
>> bullet and __always_inline compute_score on both ipv4 and ipv6 to
>> prevent gcc from de-optimizing it again in the future.  These functions
>> are only called in two places each, udpX_lib_lookup1 and
>> udpX_lib_lookup2, so the extra size shouldn't be a problem and it is hot
>> enough to be very visible in profilings.  In fact, with gcc13, forcing
>> the inline will prevent gcc from unrolling the fix from commit
>> 50aee97d1511, so we don't end up increasing udpX_lib_lookup2 at all.
>>
>> I haven't recollected the results myself, as I don't have access to the
>> machine at the moment.  But the same colleague reported 4.67%
>> inprovement with this patch in the loopback benchmark, solving the
>> regression report within noise margins.
>
> You could include scripts/bloat-o-meter results, so that we can sense
> the cost of such a change.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/2 grow/shrink: 6/1 up/down: 622/-410 (212)
> Function                                     old     new   delta
> __udp6_lib_lookup                            797    1007    +210
> __udp4_lib_lookup                            838     984    +146
> udp6_lib_lookup2                             404     536    +132
> udp4_lib_lookup2                             396     498    +102
> udpv6_rcv                                   3018    3034     +16
> udp_init_sock                                244     260     +16
> bpf_iter_udp_batch                           953     937     -16
> __pfx_compute_score                           32       -     -32
> compute_score                                362       -    -362
> Total: Before=3D30269687, After=3D30269899, chg +0.00%
>
> No change for clang.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Apologies, I wasn't aware of that tool. I did some calculations by hand
and found something like 200 bytes extra in udp6_lib_lookup2.

For gcc-13:

scripts/bloat-o-meter vmlinux vmlinux-inline
add/remove: 0/2 grow/shrink: 4/0 up/down: 616/-416 (200)
Function                                     old     new   delta
udp6_lib_lookup2                             762     949    +187
__udp6_lib_lookup                            810     975    +165
udp4_lib_lookup2                             757     906    +149
__udp4_lib_lookup                            871     986    +115
__pfx_compute_score                           32       -     -32
compute_score                                384       -    -384
Total: Before=3D35011784, After=3D35011984, chg +0.00%



--=20
Gabriel Krisman Bertazi

