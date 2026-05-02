Return-Path: <netdev+bounces-283339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOmSF39S9WmDKQIAu9opvQ
	(envelope-from <netdev+bounces-283339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 03:25:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAC14B0937
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 03:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1171302E0E8
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 01:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AEE2874E1;
	Sat,  2 May 2026 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRQmHrH9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E841E98FF
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777685086; cv=none; b=ZYzJ4ZNaafBhplwg/iMgGOVh45Cnc8iI8hcYx9xReq87vVqmzqv452pOuqD3f//UCwMOIxeNeG9Y4Fx9+c6vNWinx6glvvESc/e7n1RaxuYRcUDZ2tPc34MdwOUw3rsUYjbN5cX0ljO967d6V6TNhHJGmcmivBrW+mwudHjcKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777685086; c=relaxed/simple;
	bh=IFeLGt15QdddHrJsvE3HvXPhtFz5rcwT0S8R0UJdSFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2JZf3PPEwoLab0MnY/1VUmuO208J7oOznZMrLfKxTnx507yYpkxQfBxi0WBDfr+v3KD+ERSQ5z+YLxlNWQagWfXJ9iZAZIwnZEmv2gkvW+HDgLMTFPZkC8i66cHkAIojxTEUfiW9TOmnK6u3i6V0g+YiapVBSFHNoSnc4AReGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRQmHrH9; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12dfbcc0703so1447749c88.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 18:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777685085; x=1778289885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl2ZTF35NbwbP1Q+Ln2/raLrxAm4iCnVRc4K6GIJe4o=;
        b=DRQmHrH9ZX2zg9RetvHASKpUc6FTtq8i/O0hqghSzGqAiUkurjooYZ4WcO6RoMJ5yz
         9XNx4K2yoJ7Y3b80pTDUmjZKKWDCh9KZvQlI9/lTVLGR6svTIiDDSeapA+/Fkq1ySM1Y
         ZaHCPGLLA7dAgzLwiC5kAKGsky4EVCDRfI1/TVY7NVGzqFbm5Q8ejliFKgSNZkWGyB6U
         VnU5RJdgQEg8HSgUBJitekK4QxGZuFg1dFS0G8Iw4J+jYhdYK3TAxx0bNzbYASk7plHl
         xWrvOSLfKYuzLKyQakj/VOIijHMFHaC6VXrDnzdYlGnKQ21g7TMek6DEnKJYrDZ1K2Mb
         YqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777685085; x=1778289885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rl2ZTF35NbwbP1Q+Ln2/raLrxAm4iCnVRc4K6GIJe4o=;
        b=RmrlG63Rdd9HeTxvdi6aadpMvMYJwFMohW/TpNNfDgmte6oXFpE34CB2JTbozfyyh7
         MlQXBb2JclacBp3w2+34wmycqK+RhDPbleD3sAk8ScMcamLNsb+SnYV+jg4KI/rerJfV
         LOpXSk9Y1Y2YFgQaP4mkXBbHBYkAFwfll4mfKHJvRYB6VpPot5uz0sheS6Z52gUk+i5T
         MB/n+SZPFaEIJHU0KPFaLy5Gf+2qDfMbOMNy7PYHp3tlItvUGV+VI+38a4uuT+cIgZsi
         74IeMHxlSdk6GVUHRZes3VdQh+g/R0vBCaDXOJkLZ/qSnTx5sVU0Irmk/KnUvbQRuwyb
         SUlQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IjciLwSMPkDcxBJYHB7bApGVJahVCCgxLHHa3VrGlmeMgep+4xUAUykyXMUSbwVUfx86ZZbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZl+fUdE6f2Pv6UDm7bmcwI3SuV+5okCeMcA/ZTDhs3RpY1mT
	u5n2JBr2vA+INPJCjueCHV/KF+lXTiI8BV5F0BRlLOvvcfzPgNLRwKIm
X-Gm-Gg: AeBDiesVGjGFvXQpSZ1vJ5xhGiSzkWnZBmumj0gpIi9N/9gW5Ocq597lswtSiHqjn7m
	/voqEwp5lHFHQnwDF5l8rdAwIhVkKcMVWJ1cJJsTIH7MmDeu+PSTfgoFrDuZqULzFxujavAr/cM
	47C1JLe61UPUHSHXfJ/b7S3JeJJ0ujTfXOQ2Q4QzLuJq4x9yAgf522D1Jrj/bXq6H+f9BuGBmKQ
	rKyFBqQTa/P1VTvXgvs4+0d9C2wP8Xg3MvDhrR97YQMIQYCJM0EzrN4/enfqlmsVSFsxC1G99Iy
	FiKPfh1XGQ3B7LG6lYL32xyf0ugBtgGG29+F6Ujz58ecn5wWLOj0AZKelFyG9hBXrhIjjQPj0Xw
	mBi8Dngx67PBnJY1vUnT270YfRwza74sGvpQboN9x0aocNwLVM1M1SRZlGEHvNe3nfJm7DxD/Ae
	Ss9BBMn7GorTithsNvuI1LFPLmnduPi++ihszMZUQdZFjhSUzKczBD
X-Received: by 2002:a05:7022:660c:b0:12d:ce36:8930 with SMTP id a92af1059eb24-12dfd7a15d1mr854409c88.3.1777685084825;
        Fri, 01 May 2026 18:24:44 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df84252c0sm6663448c88.10.2026.05.01.18.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 18:24:44 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net v3] ipv6: validate extension header length before copying to cmsg
Date: Sat,  2 May 2026 09:24:38 +0800
Message-ID: <20260502012438.3685742-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d0cc3e95-f03d-4bed-b18f-0517f56b8f05@redhat.com>
References: <d0cc3e95-f03d-4bed-b18f-0517f56b8f05@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CCAC14B0937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283339-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026, Paolo Abeni <pabeni@redhat.com> wrote:
> > +static u16 ipv6_get_exthdr_len(const struct sk_buff *skb, const u8 *ptr)
> > +{
> > +	u16 len = (ptr[1] + 1) << 3;
>
> Sashiko notes that you should validate even this offset (1) before
> accessing it.

Good catch.  I will add a "ptr + 2 > skb_tail_pointer(skb)" check
before reading ptr[1], in both the helper and the inline AH path.

> You may also consider switching to pskb_may_pull().

I considered this but would prefer to keep skb_tail_pointer().
Two reasons:

1. ipv6_parse_hopopts() / dst_opts_rcv() / ipv6_rthdr_rcv() already
   pskb_may_pull() the full extension header during input parsing,
   so by the time ip6_datagram_recv_specific_ctl() runs the headers
   are guaranteed to be in the linear area; another pskb_may_pull()
   would be a no-op.

2. When pskb_may_pull() does have work to do, __pskb_pull_tail() can
   call pskb_expand_head() and reallocate skb->head, which would
   invalidate the caller's `ptr` (computed as nh + offset).

WDYT?  Happy to switch if I'm missing something.

Thanks,
Qi

