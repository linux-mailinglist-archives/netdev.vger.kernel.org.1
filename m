Return-Path: <netdev+bounces-294775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GHA1LLA8IGouzAAAu9opvQ
	(envelope-from <netdev+bounces-294775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:39:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B39E2638B0A
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:39:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="PhfJDSK/";
	dkim=pass header.d=redhat.com header.s=google header.b=iT56JXR1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294775-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294775-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BFAF3068BDB
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4238E339853;
	Wed,  3 Jun 2026 14:31:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FEE335BB4
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 14:31:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497064; cv=none; b=Ni3v7yzOuGyVzinJKtcObGbBOnwv9XluOWkFgmN+T89hp4tQziB7QkEF2VAuCMlqo7SOdMu3a2+KXdShI4lxhuKOKVddKbJFuiQQr6oqKlW1XtujuQmvvmJ4zh/444o+wCYzH8QTDt1hb74YolGAkcVND3JA4VSqWUneC3fisP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497064; c=relaxed/simple;
	bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kYP/JmH2xsRFUxLv2qSbNERPXtUzmFDyz4OmHjYr1lALTfaO7bOf7Syf3ymKRONgks1ydZnWLYlZW1fwXrzFqx3WTUplD95CIiBO1zhH1RqTBiaUy/yZS0yz0FWcbWRJULMDKiS0pSFrg7+ylVi3pnZ4lLPKMzYnetbqoUUYGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhfJDSK/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iT56JXR1; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780497055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
	b=PhfJDSK/q0zY8j3N0aiRXfcUBTM29Oc1YHz1xbNgWZO2EoWlplBmsRFz29K14P0s7sLMwt
	JvO1z1M+jaK72KWsXIFrzpoVTrhrnLsQlmUyoePKUlHdLwO12LdCsQNLJq4ia4+4ik0jfp
	xf5/45nQVZJdDbVD6Yraoa8P9LqHSsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-N5u0GjQNMx-BxhLmk9cTgw-1; Wed, 03 Jun 2026 10:30:33 -0400
X-MC-Unique: N5u0GjQNMx-BxhLmk9cTgw-1
X-Mimecast-MFC-AGG-ID: N5u0GjQNMx-BxhLmk9cTgw_1780497027
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b4d3d3e6so8928345e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780497027; x=1781101827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
        b=iT56JXR1fVB6SWdXj9UxGk6uFJRkNrv7dnClHjY+u3mj5xYNevXwpv8fh0xEu/g+VQ
         oTIYZpCpPt5nQRI7heCmasrST8Vb7jJ4rKYsgMnrQlq61wVrpkax8JuPbJIDJ2hyMLBs
         tj8m3LavazNKNusl1WQJOd9d+W/HmRrbxewqT0xwgaNGjwPX6NjqLjIiszKerQXOP17J
         Kf8/Hw79nocsl+HHb/ZwvKjLk8+CCmyMMQqB8Qc26UbcXmtR3tYe5ZVfesQkxi3qCLs2
         B9nh+rCdUHQn5Ju1L8mCkvU93D652ifGRbK4vuDaTlCRbNmiRv8hitTjHLipZyiFBXwH
         cIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497027; x=1781101827;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
        b=bkfARxivgeUgnJ5mcK2N2UImn1xTEixNYjVLfUjO4uwaHI293ufR/h4GJpnbxaki4g
         /OiAfzCAV14BthXiI/Rn/9QUpcTuerZv284MjG8k8/YsoD2VxjcivYe76Kr5wVVVWK8C
         TCKRF5yYd6LDHsaGZw9gEkN2J+DhiUmtM562BI+6H2Q/vaEJU457lbWzoWtxtbU8lziL
         Cyt4NfZEjgz1jaLKuINZFzNzRINnvo/xj59xuD8B3Q8WDaZFCZpEbqdB4s6wbIO3SaQe
         K1oawbXwoS88yV51h3dnQx98asEK65XrhcNvuxY0uK3c3uH7MzVozdsOxscv8LYutnx7
         Wb/w==
X-Forwarded-Encrypted: i=1; AFNElJ9Sw09mnlRlKvBNygoFaQzanVcTDztRzC47X1RIdibRglZVbj0wRpGU2HxDGzEaVC74aZfzZIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOe08BOGxl2KUI+dUhmvw6RBqjOY1eEURNDWwehFS6kRcP4L69
	GPrJ3xrTTsWl2gQEQ27jizfhoBxjx+0R3iCePBhTlkLsa0IjQbXsiMO0iLaw3Wg53GaIvkYQVrF
	QUAoJvQ//rAlIDGJmBZkEE83tWWHDq3F5JCxrLDiGX62zVc5MGIwpFah41g==
X-Gm-Gg: Acq92OG4pW1hDH+/cViK1+Q4kWuOhfXE/klhKZhQOeB8ZU/NDxUSNkwR39b/4+h2kX7
	dGn/o5LVbExdYOciOmr95853t3A+Se6uWpsNljw5KlFR8QYUjSQYLNP4q9zxKVrI4pAKYBF+uw1
	MucyZAbLcPXlhbpogqIQHYwhx38tg62/fMzgN8kw/zTUBKhZru/bxjAFsEELn7XzNZj+qyKcbDg
	lxJ3Wdb9OkwJmz5MKxPVT1kyszK0jKZNxYgD1OP2dp8wCDCa2LrOOP6XGmhVbv+wVVvKzIbNoyj
	3Bet7rpLFFRtWLryncPKbmgSAw2uCH54BPQrdh5gDF2+P7fOu74JoV3FNMtucAbkCxziYY7BlMX
	e/H/hvhiC8JmhknLjwjcSYxObdbFR1xLPuKc0TF4gvJ2Dbyz0aTkJDrhR
X-Received: by 2002:a05:600c:4fc6:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490b5e950admr58335085e9.10.1780497026994;
        Wed, 03 Jun 2026 07:30:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc6:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490b5e950admr58333875e9.10.1780497026156;
        Wed, 03 Jun 2026 07:30:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b60f6d5asm68311455e9.0.2026.06.03.07.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:30:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E15C57BAEB7; Wed, 03 Jun 2026 16:30:23 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, liuhangbin@gmail.com,
 yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn,
 zzhan461@ucr.edu, n05ec@lzu.edu.cn
Subject: Re: [PATCH bpf v2] bpf: devmap: reject fragmented frames in
 clone-based broadcasts
In-Reply-To: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
References: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 03 Jun 2026 16:30:23 +0200
Message-ID: <87v7bzbssg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.07 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294775-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:liuhangbin@gmail.com,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:zzhan461@ucr.edu,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,lzu.edu.cn,ucr.edu];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ucr.edu:email,toke.dk:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lzu.edu.cn:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B39E2638B0A

Ren Wei <n05ec@lzu.edu.cn> writes:

> From: Zhao Zhang <zzhan461@ucr.edu>
>
> Devmap broadcast redirects clone the packet for all but the last
> destination.
>
> For native XDP, that clone path copies only the linear xdp_frame data,
> while fragmented frames keep skb_shared_info in tailroom outside the
> linear area. Cloning such a frame leaves XDP_FLAGS_HAS_FRAGS set but
> without valid frag metadata, and the later free path can interpret
> uninitialized tail data as skb_shared_info, leading to an out-of-bounds
> access during frame return.
>
> Reject fragmented native XDP frames in dev_map_enqueue_clone().
>
> Add the same restriction to the generic XDP clone path in
> dev_map_redirect_clone(). Generic XDP represents fragmented packets as
> nonlinear skbs, and rejecting them here keeps clone-based broadcast
> support aligned between native and generic XDP.
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support=
")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


