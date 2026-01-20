Return-Path: <netdev+bounces-251611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAVyEFX0b2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:32:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C694C4CE
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 225668E894A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4073366552;
	Tue, 20 Jan 2026 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+D0chws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0036D4EC
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939286; cv=none; b=Xs5NDSjhOXci7037YKxYlATCQFcUTxV1tgBPiAJ+oZL7ezm+2Fw0glg8c4rvXH+o/aQZz6xH4AKtw3jmmz6fM5qXJJHeH2u/fPlce+XJyEpfy+qS8MOHtnx2DsaAizpVN/SwJC+KgTqo7j5DbjP9L7zIYRWltLFCq840TRkm3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939286; c=relaxed/simple;
	bh=w+jvg0Di6mA6zuCyIs28mJL77sSN0uhuGe6tKOyIN3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP09/3ZHwn7T/hUPptfhlhj53ImJeX0QWohvLRk9nfv6S2ZSqTEyVnd8PCyciXQMq5Bey5JTO6F/skmwS3aZ5LHgK2gGMl7qOupnN9ou2iTECAksEtRPrpR2hmhbpB5Jt70ZCkH68toCbN3njpclTbIOK7ild39gR4W/010TGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+D0chws; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b704f08e73so117872eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939284; x=1769544084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZNOvVS5LQAVWicHVfzx9BZNVkxmXpPJEekz1ir7T0g=;
        b=P+D0chwsdsi/IplUzYPm0TJkUnfmVjZ/Jl66d32/qjF4rXtJz6ktivwTw6GxW0JwnE
         voKDIMIOp4dW+VTu14BIBgu0FOt/GX1J8bZ2Eno/Kdw2Ejei8SWCSlCDWC9vXaDAafCD
         FzfGcDkenJriTXlwEhCfp0EWLPJEgYKpTxXkQ7auzTm0ztfFUScszd0M8wz5TMKXArBi
         HIgG7rNN69Sd4MhECqRlvItFVQTsxL2ehOWj8o3PqA/k/jBh5EBxYU4pIIFddPPgn+1y
         SEI7flDfL6mbEnAq1Rn22DX3BGj+zhxqU0wozSIljeIdiIJPXEGw/CNLyXX3A6MbfY0u
         PsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939284; x=1769544084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZNOvVS5LQAVWicHVfzx9BZNVkxmXpPJEekz1ir7T0g=;
        b=kaQmsXOY4fepjnHFa35d8JLKJA01vV/P1DgKnWdE5syfJtIeRtwE33QmcG3VfeDztm
         eZzl4eXVbFB5gfiIJ7nlp4zX3CCsLa79RrfB2JWnVvuERk8V6zOW/ERZk3U0fDqtEb4b
         PTJbrpt4Q47nrk+Y+O1rKjHzmSWrP1QuAkCBQ4jmRdg6LUUucjGmQGOIzVVf6ffE0PIj
         3+fpJUxTxtR5DWsJV/gFMIP4G7JJssQ/fOXGT0yNrNuKYEONvpGRWv+Ji+ycfoJVCKsh
         +fJeWuKOGrlXFkoVSwV7O7wcVTeLCF34W+kE0ABHTfy6eTURgUsO3uJ2HnrRFYAbferP
         /VIw==
X-Forwarded-Encrypted: i=1; AJvYcCXZxF5eSsZnG4eUYtvHjz2pCcl3ni/uygFIhORu4eDuDfKHwo13+cnt8dZl2WkCzmOj/G3o0sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15YsbKVkJWGh0XjPvzpiQVrB4MpaupqXNw/ETx95nVP5p7wRK
	G0rHq6h8yRoQK9VyBJv35uoNZiIqh/jR3BWDUkz+KetQia+nZ4as6zc=
X-Gm-Gg: AZuq6aKC0WMGVHxmTKapTppi/XeIGWhrvDADtHfeIOBh+ukOOmMpIOReBwEwBs1yi2P
	/myMksXbtSHWnqKrPZWi+jE/ccrBihE1m3jIxc7GTGDiNz8KTejB8jrAODSWnqdy3NeyGMuGvzP
	ClVmKOJHerTbCW+RnBg2kXepsu6Iy8XHJvUEQB+F3HjGjH9NA7+EgTK28Gr1buAlCoMp1MDKJV6
	vq3ju3B/ijQTCxIcCcHsaxoh9jITowWIAQ+0PSK3nQDEPw2hB3BzjWmo2pDYDKM3KBepI1Umbck
	Na4pcHEUPOufiYjZP0Hz0Slyieaf1759iV8ixxAlAnhTVTFWp8parH7R5gBqSDtpI3sKMaMwIyU
	w99Zv00PyTgwKVuChfU+EAHODc6cbBfqkxQx2TCZY9DTN+eWY6HdQmzPmPllr2RPuP5RwCHNQ7a
	iPpUCOIIwi0LIpfK6gHmIx7qnSXYnrG3gWMPNE3rS03RurBor//GbTv9QrUvs5QZ2P2IjsmPVVv
	tB+Hg==
X-Received: by 2002:a05:693c:631c:b0:2b6:c35e:1ca3 with SMTP id 5a478bee46e88-2b6c35e218cmr7023181eec.14.1768939282727;
        Tue, 20 Jan 2026 12:01:22 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11dasm20504916eec.2.2026.01.20.12.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:01:22 -0800 (PST)
Date: Tue, 20 Jan 2026 12:01:20 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+c46409299c70a221415e@syzkaller.appspotmail.com,
	Matteo Croce <mcroce@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net] bonding: provide a net pointer to
 __skb_flow_dissect()
Message-ID: <aW_fEILfgvum4B1c@mini-arch>
References: <20260120161744.1893263-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120161744.1893263-1-edumazet@google.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-251611-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,c46409299c70a221415e];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Queue-Id: F3C694C4CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01/20, Eric Dumazet wrote:
> After 3cbf4ffba5ee ("net: plumb network namespace into __skb_flow_dissect")
> we have to provide a net pointer to __skb_flow_dissect(),
> either via skb->dev, skb->sk, or a user provided pointer.
> 
> In the following case, syzbot was able to cook a bare skb.
> 
> WARNING: net/core/flow_dissector.c:1131 at __skb_flow_dissect+0xb57/0x68b0 net/core/flow_dissector.c:1131, CPU#1: syz.2.1418/11053
> Call Trace:
>  <TASK>
>   bond_flow_dissect drivers/net/bonding/bond_main.c:4093 [inline]
>   __bond_xmit_hash+0x2d7/0xba0 drivers/net/bonding/bond_main.c:4157
>   bond_xmit_hash_xdp drivers/net/bonding/bond_main.c:4208 [inline]
>   bond_xdp_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5139 [inline]
>   bond_xdp_get_xmit_slave+0x1fd/0x710 drivers/net/bonding/bond_main.c:5515
>   xdp_master_redirect+0x13f/0x2c0 net/core/filter.c:4388
>   bpf_prog_run_xdp include/net/xdp.h:700 [inline]
>   bpf_test_run+0x6b2/0x7d0 net/bpf/test_run.c:421
>   bpf_prog_test_run_xdp+0x795/0x10e0 net/bpf/test_run.c:1390
>   bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4703
>   __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6182
>   __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
> 
> Fixes: 58deb77cc52d ("bonding: balance ICMP echoes in layer3+4 mode")
> Reported-by: syzbot+c46409299c70a221415e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/696faa23.050a0220.4cb9c.001f.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Matteo Croce <mcroce@redhat.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

