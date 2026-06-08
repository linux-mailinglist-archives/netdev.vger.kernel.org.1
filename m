Return-Path: <netdev+bounces-296747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gl5AIy4/J2q+twIAu9opvQ
	(envelope-from <netdev+bounces-296747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:16:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68865AEAC
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:16:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="m/j6uKom";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296747-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296747-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0FA2300EF41
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817603B14AD;
	Mon,  8 Jun 2026 22:16:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A13AFB09
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:16:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956969; cv=none; b=THEKTXQLoFOmAao7Q2phe/bH+igmgOGgCwSpptkoFASvn5qYK+bfThzKa3gQG15YvRCxKNgePG2c3ptGZQpWRVRb3yg3rVRC57y/aod/Rwmo7j51Z5zTofx4lP4n+zSXs/epCrja1WtilUwlQBbJHLRFq4lTCw/67yqUlq6sKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956969; c=relaxed/simple;
	bh=5S9+Cq5mB6r0CsPwnBf6Bi9EBEMbdFL9VF1fFs2tVh8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=G9jyvUq1/mBCBzTbIVjAVZc/zEAyxQhpprMJpc12hQNRIlJ40lS3GjaOM9ll8ZsEZmdeEaDfCDmdBRHkh1b3ekkNHva2LnrO/9APGmxGP0Ch1QmfH+Fup3IGlXHhwy2VInt88DiuJ3ty/zVuyul0sm/wcSV6WySHICksz0LVke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/j6uKom; arc=none smtp.client-ip=209.85.167.170
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-48670d35a87so3461504b6e.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780956967; x=1781561767; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S9+Cq5mB6r0CsPwnBf6Bi9EBEMbdFL9VF1fFs2tVh8=;
        b=m/j6uKomIznvp+t9zPkrFDexHFl1cwOn80Pf/8nQUwPCopgBZ7vGWIYsmLenqujMG6
         aEGvRIunsn5WeX5DaiC5O5pAfTSwoZyK27aKXKdaNu47GUZkec61FlUpWmMuAf0pavgu
         +OnJ6yTTQJRUc42ZZO4LpzoIzmMLUuftWtMky//J3gLjKXOElPsHMkcEQk5rgbk/3sJh
         MktBkO+qCF/1lPzqvCuLeQHd4reR2kvbUEt+h7AR8bp71Ogygs4448qeaX3qdupWis1k
         ebjZiBMNrh4HgWcfMd4WWL7Q8xhUVOz543bl1b5Hz81HPaq+LEjePjFOivpfzxEqhvKP
         dTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956967; x=1781561767;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5S9+Cq5mB6r0CsPwnBf6Bi9EBEMbdFL9VF1fFs2tVh8=;
        b=XYrkP9JSzQXLa/GlU/ONSw36QaRykaMBWKUJeB7oYbNB1ib3sKa4qAsmPL+7vcuB1F
         ZN9eKzJLD6+ASYOY4Da/dFA1AT1LlQzbXddw4qcZbG+BJLnz/Tn/zVw5+EP91nK4CwqB
         b9QqRY/KzmMwbXCn3EqPmrGv6ET+v09lOl8ascy87h1FeG6B8YklIJrEs5uGByJIIs82
         pbzoHiDVZdhGxji5rDuDgNa+UIx5tUYjYx2zbfdydd1GW/WMm4GtOSGCnoZLrnIWtQNK
         7PK+X4P1B16Z43kuzltXALDqiEO7A7uqhld/YxfimkGM2GNVKZ900vml2KxxHW1973Ge
         mmZQ==
X-Forwarded-Encrypted: i=1; AFNElJ82AWW3bzgHbCFAAxs5IdiqHMVbtolTIuEouCBYgQdqzg2oCfa0hSfD8NlhQvT2MWUuUBrwERw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOXWq8HTEpFm7tKuGEt3vjZSn4Vmvj0/bojxY/jORKm21AOnu
	wrHhJnBUt0H/BYQCz8uWjzxFFbAJLwpixgypY44NZ1hbtoIQCWcH4k11
X-Gm-Gg: Acq92OGtFS/8hwdbdK9Qcgfy5s4Uihknn0DRjKEKu6pZPZAztMjnQMltSwPnav9fQtX
	+sHXo6UX/vbNTPWmJhl8kTxAn+j1ZP1F8Ifbg81/jNKe5HM+9DpHfzqmhgAn/8f7ygXtUUXUPUm
	mji6GFYqhOYrLGS6YHIaTVMbUwcU9kNCBUToE1qCXuR28dFKU5jk+OqRPkZ/k1iBH3t90XEhMXK
	CICbo2pAoGNjyL+wycsjoje6nuSk188An7rKigX2PkFfdAS0OFnEQlsMU27DHK1QIyREx2UQiQQ
	ofBlof49CLLe6yUm52p8aRNf5TPokxiOanRUwycW1Q9HZv0XsH8azGMseSo45OmU61pwfOXZeaP
	ha9j0T9aXvbwlHYVQad5Vdb4UrccNCMNp29mSuCIo0I/CEeRVW0bNYDKDFR5OC6GmjCo7z5WhFt
	XJv+M5mjK1ECbo8RVu+5YWPXqtI4InfP5ZuyHzG9Gd4BgMcQwjRZiuQuaEpknxLDbJKyn1fS7I6
	9Qk37hhAIqWmQadqbLPzxc++flw
X-Received: by 2002:a05:6808:144a:b0:450:b249:71bb with SMTP id 5614622812f47-48692e390c3mr6568858b6e.19.1780956967107;
        Mon, 08 Jun 2026 15:16:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e79237a1sm13423994a34.19.2026.06.08.15.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 15:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 15:16:04 -0700
Message-Id: <DJ40JYME18U1.3RA3TUXB3MH3M@gmail.com>
Cc: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "bpf" <bpf@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>, "Joe Stringer" <joe@wand.net.nz>, "Network
 Development" <netdev@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock()
 for BPF-assigned sockets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>
X-Mailer: aerc
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev>
 <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com>
 <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
 <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
 <CAAVpQUCJH3iknHSfNwMqvHVc_V09zNDK-YbXbqa-=K159PTqiw@mail.gmail.com>
In-Reply-To: <CAAVpQUCJH3iknHSfNwMqvHVc_V09zNDK-YbXbqa-=K159PTqiw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296747-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kuniyu@google.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,iogearbox.net,wand.net.nz];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B68865AEAC

On Mon Jun 8, 2026 at 2:35 PM PDT, Kuniyuki Iwashima wrote:
>>
>> btw is earlier sashiko TOCTOU concern real?
>
> Yes, the selftest in patch 2 should reproduce null-ptr-deref.
> (I tested one in a prior version)
>
>
>> iph->protocol =3D IPPROTO_TCP;
>> bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
>> iph->protocol =3D IPPROTO_UDP;
>>
>> as far as I can tell past bpf_sk_assign_tcp_reqsk()
>> the networking stack only looks at skb->protocol,
>> so modifying iph->protocol will only mess up
>> things on the wire (if this packet goes out).
>
> ip_rcv_finish_core() uses iph->protocol for early demux
> and ip_local_deliver_finish() also uses it for demux.

ok. Another idea... we can keep the checks on bpf side and
teach the verifier to invalidate packet pointers at bpf_sk_assign_tcp_reqsk=
()
and introduce new concept of "readonly skb".
So after invalidation the reloaded sbk->data will be read only.
There is no such thing today. The verifier only understands PTR_TO_PACKET
as read/write. So it's not easy, but probably good thing to have
for this and other cases where bpf prog shouldn't touch the packet
once it called some kfunc/helper.


