Return-Path: <netdev+bounces-292431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IsNNPpCF2ov/AcAu9opvQ
	(envelope-from <netdev+bounces-292431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:16:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 759075E96DE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7C55303EA70
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5B134F474;
	Wed, 27 May 2026 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ValWSb2X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E2360EED
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909366; cv=none; b=dBiFAH2LxO/Qpc4SH8JI1SQ6rP7YqbDn08swPDImrSRvQ7vpdNqU0JkUJn2bd/QOIAxsE2Oi9PybQ/Z96TUcEwQ6ZckTyA2csU18Quj9PatpvSVsYCyEp2IMjoDKi/O3K0HFhrb+wvv/0QtGm3bdeijj7TESI0JKEytUByG0jpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909366; c=relaxed/simple;
	bh=W3T4QxdLFfHbdc/KmpcaHHy9IfSTsNZ4bf6F6ZMHiTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epYHrJ++iVSPfgl2aYUgd5kVILp6xFn0tPwRbKbbQxNFOa4yZG73bYs0hRKw/cqISwiQH7ypcUA7L2/tjBhJOeUzOL7K99NL9qr+2Pt8mAbEnBB3+l+8MnbxySRJr0DigXQtFxRJeRccaTQbykC0i18e+OfuthqeDA7LdrgT4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ValWSb2X; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so5513704b3a.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779909364; x=1780514164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jVdozbgHNmRboTjJqPe1n9RlPVUR0qDZvYcaF2yAV8s=;
        b=ValWSb2XLrdf3Bw6PhZo9e+CRjbSLnpGiuOU5m4gAa41n1wUh8H8bFDhf+XAJslB2h
         /448U7HWQ4FjK9XeYxEPgefvubM0bnISKWa4CRNt0kdZhJW9VR8eJ7A4/2z6Zm/BPAGf
         g6as7/kz4YuAY9lGEGPGfeXwks+Jj/7TSoPLrbW/RwJALfQtBo8XlwucBqaWKcOBQLM1
         2nYgOZYX6G9y4RbrYBZYfdvtIJGEs8VsQOZL0pzOdXDwcAwwdy3+n3B2fxv6xsZk+2vM
         EdM5rf0i0mq4LAgb3fqvp63PgK+3fNb1QQoxS1zJs6PpS2hYI52rHrKMfSfmjckYmd9Q
         b4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909364; x=1780514164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVdozbgHNmRboTjJqPe1n9RlPVUR0qDZvYcaF2yAV8s=;
        b=EeuTA6Rrko9hu9t7Mig74HUzOtMq+r9YJts3y/UGS0XtAp/ODSj5s2bc3ba04Kvaqg
         c+pUJVZgPMpyd+q+yyutE9GAhQwd5pHyZcR2QT+lSbOVCYWnp3T2NdPMr51uyE2Mna3M
         F2SLL2HlIiZRDA8wt0wMCFbn4MYocQ5lYPjCRiViyIkx/Cu3HgfFUoB51YRAYaDEFBmu
         ZvWMvCzQuQDD2GkJUQhLJT1ev8VBR66Yxo1JGFFcj00EuNK1nbiMx5cWmMY8RlthVmMI
         K5IdRzFHCrQSx35YmuFyreTDaUZlWSMzkko2HtCgo9R9Zqh90LxyKHdJqD0HKN67UKVI
         HKQw==
X-Forwarded-Encrypted: i=1; AFNElJ8TWX4K01Ddajpa2ZPlvIB1++ebRoHHrJfFsL+kh90nqxl6HT7L/iUaIuljpZwesC4EbpK5i64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPoPdhs+dtxHxLYlZgUysq2LsX4kyFOLVdyy/WPWfohRHnAUm
	Iy6GVNr4SyJwvyaATncjVe7+9VaT/zef1zVfSFO7Q0L9t/KRxxTTKSD+
X-Gm-Gg: Acq92OGhUryFKoE998cxiBJYQbkRqLFW5aW1fZ1vK56IkvYtTbojWInoOTqXDFxN88s
	n50D+i1WAWcwwufuAaGiN1M5g00jd1/PmplL71suh0Lrv/hIL8EgTAASEjs0cQzec9FGKmaYtti
	uJI5AmWiQSIKoBZTGMZE/cgCSEy+2iz50dWKQq8JusHQwy08hlu8pqN6XioeBml6BWqu7hi4cAi
	IwshdQE3/cScWNbW17joXZMxDI9btOHv/Xd4DDM7czVcn6tmdBz3ZFFgu56sWzky44febJfUWGB
	wQOuQOZmKQaOHT8sx/11DYRvOsMhJgavs9QPJOH7Q72Z628KhMJmqnLJgm1cu5PdDOmoX/1fiFO
	q4IRMc6vx1EEtorMZ25sQ1g7MZmWOiuVz1a4cuV5Y/z3VqvZ/e7CCdsQ1VI6JL2nvYcSX9iLsJB
	7Vor2DnyXzrr5OuDGgBmrcnT0D/JRKUsNo
X-Received: by 2002:a05:6a00:2384:b0:827:4bca:f1a2 with SMTP id d2e1a72fcca58-8415f0f02cbmr22578450b3a.10.1779909364354;
        Wed, 27 May 2026 12:16:04 -0700 (PDT)
Received: from john-p8 ([98.97.42.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bb18bsm3595235b3a.34.2026.05.27.12.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:16:03 -0700 (PDT)
Date: Wed, 27 May 2026 12:16:02 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Christopher Lusk <clusk@northecho.dev>, Sabrina Dubroca <sd@queasysnail.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
Message-ID: <ahdAboFpUAZ8aaWm@john-p8>
References: <20260526025154.60607-1-clusk@northecho.dev>
 <d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev>
 <20260526161101.691d4cb7@kernel.org>
 <4626d285-57ab-46c9-b75b-d56efe7417fc@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4626d285-57ab-46c9-b75b-d56efe7417fc@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292431-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 759075E96DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 01:09:44PM +0800, Jiayuan Chen wrote:
>
>On 5/27/26 7:11 AM, Jakub Kicinski wrote:
>>On Tue, 26 May 2026 14:44:24 +0800 Jiayuan Chen wrote:
>>>If async_capable is set to 1, the zerocopy path in tls_sw_sendmsg() is
>>>skipped.
>>>Unfortunately ktls with bpf_msg_pop_data() does not work correctly under
>>>this
>>>copy path.
>>>
>>>tls_clone_plaintext_msg() aliases msg_pl onto msg_en's plaintext area
>>>(in-place encryption).
>>>
>>>BPF runs bpf_msg_pop_data(msg, 0, 2). This shifts msg_pl's SG entry
>>>forward by 2 bytes.
>>>The two SGs now point to the same page at different offsets. Physical
>>>memory overlaps but the start of
>>>address differ.
>>Ugh, do you mean that the memcopy path is broken? There are other
>>conditions under which we may fall into it than just !async_capable :(
>>Small send with MSG_MORE is probably the easiest?
>>
>>So we need to fix that one way or the other.
>
>
>Yes, the memcopy path is broken, but only when combined with sockmap's 
>pop helper.
>
>
>msg_pl and msg_en share the underlying page:
>
>                       msg_pl           msg_pl end
>                         ^                     ^
>                  |------|------------------|-------|
>                  | hdr |   plaintext     |  tag  |
>                  |------|------------------|-------|
>                  ^                                      ^
>                  |                                       |
>              msg_en                         msg_en end
>
>Before encryption, sge->offset += prot->prepend_size is applied
>to msg_en so that the encryption's dst and src point to the same
>block of memory.
>
>But once pop has run — i.e. msg_pl's start advances — the encryption's 
>dst and src
>are no longer the same.
>
>crypto_ctr_crypt():
>When dst and src have the same address, crypto saves the encryption 
>result into a
>temporary buffer and then writes it back to dst.
>
>When dst and src have different addresses, the crypto module treats 
>them as two
>
>separate buffers and stops considering in-place mode.
>
>it's complicated to process pop/push + head/mid/tail...

For our use case (not deployed yet, but deployed in non-kTLS case)
all we do is observe data and possible drop the skb if it has
malicious HTTP headers for example.

All this push/pop/... in the middle of the kTLS stack is painful.

One option we start rejecting these helpers? That would resolve most
the pain I suspect. The original thought was we do have use cases
now for userspace proxy where we insert headers.

>
>>>I think selecting a sync provider via mask = CRYPTO_ALG_ASYNC is
>>>sufficient to
>>>remove the -EINPROGRESS return path.
>>>
>>>May be time to remove skmsg from ktls? (disable by default first,
>>>re-enable via a new ktls module_param?)
>>Yes, we asked John F off-list to get his attention and I think there's
>>only a vague plan to start using kTLS + sockmap, no current user
>>(sorry if I misread / misremembered).

I'm not against a cleaner solution here.

Another idea: We just add a simple sockops BPF hook with the sk_buff?
No updating sg lists, manipulating data packet sizes and so on.

That would solve the vast majority of any future use case if we have
a user that really started running kTLS and wanted the security stack
to keep working. Even openssl usage of kTLS has really ground to a
halt after it was initially added as far as I can tell.

Something like this already on the list for recv side of tcp.

  [PATCH v3 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook

>>
>>module params aren't a great API. If we want to deprecate it let's just
>>remove the integration in net-next. You have my vote..

