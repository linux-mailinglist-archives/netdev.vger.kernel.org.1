Return-Path: <netdev+bounces-246654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEEFCEFDB9
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 10:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 560C23009D7A
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025EE2D8382;
	Sat,  3 Jan 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlbnNEW1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B0165F1A
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767434165; cv=none; b=RpH60aXqHaWYkiYGqUbSiB3YVoNHzUXmA0q7tCg6Z+M7OvK8u7TZEPvA8UiYV/QPkqIqBMMRFeVC88x9kPYmM0lekp3WASYvtt5oe2TlULyoIIhHUs6bYfP4x2lo1fhQo4VqGR+jrVbn/ofVopzobXV+8qXvJHI/dqkDFr9ZFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767434165; c=relaxed/simple;
	bh=ShC3GxXrLBcpeGTpTRfElsYbQ+u3GXjCGgogr1r37MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByLD7zV5JLgIBs793vhIm6iMf9mkGghRc3+zOfjKIW3VJmIo0nYEe8f8Q7kQ5l1z0xVMIKwt+0Q0swXjcvBUqZg8ZuC45+AfmjL4GIQgImTWqphb3lhBeZ0AEQSvFpR+3qUg4/DyjdVfv6SUPU5g+4NCDX5OV+iC/KNbhWIS1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlbnNEW1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4f4a88e75a5so113800031cf.0
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 01:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767434160; x=1768038960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fm061Z7SI9Q/TlrS2qYJLNN4nEI0DGEwiWG6RvujUdM=;
        b=UlbnNEW1tzoALd4jhjaQDVUuFM+mcIYfBkpyCIKOOEh8hqIh4v5RxHxuHPNYvKej1P
         kTzwx3V61KNybgn3pxMTSkPq8ksc2dK71U9mWSYik0nkZ3Up5jXUjJ6eIMhw+ilzDlN8
         Kke9aPUBQBjVkYFcIsO/sND4uKSqgKajtMzNQy6QE5Qu8YntfH2MATIFYmKJAp4BIhI6
         1K3NDKYMjDyMIcoHbnx1+DXF8eHK95IRV/NRKEyWZsizZPT/rn7cij1zBywxbwc7kheY
         EQUxviYFVv+jTPZPSgkHLSFypPPYv2DQDaqW7ldK+y+van1NLET/F0HAdTybfT2bRxjc
         P9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767434160; x=1768038960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fm061Z7SI9Q/TlrS2qYJLNN4nEI0DGEwiWG6RvujUdM=;
        b=lS/Mi7ZVwXt7CBOJCfcv0R0GUTbMw21gwprzIKjzieUczbDEzvWYOM4usubGezwxIk
         UFosEG5/La1McYxVXxQBtxxiwaP7cfZws62dSORRS6c9LgUpl98ntO/tXzN82GjuQCsV
         vtbJfDaovncPtKqSBsrJUF7G07icvAuKocOBZbcNk0KATKE4vSRYgWJB5rgLmXxUT4KP
         KqZPUMbfpeSp5AWX8gtaL1HxtFKQ1TdyAoqJnYMwCt+6BqB5hEvXEDveSpGdr+EuDLOH
         KYoQuf7d3N+wY9UEu7/WtXzuE22g3S3BcLSc4X2ncIvr4Gq44PB//ry0ABG6snZifr/u
         vbDw==
X-Gm-Message-State: AOJu0YyPeG1gwUtaxmllo0+mX0fcYMfrl11TxUY8c3U/BlUe+CbpEFXV
	fJIznJS51OVidm+LDtOpzX0OWmdPszPAqocgWRvorruXxUzTwiGsd4A8UHBQdXJouG2JsWJQ5P3
	IQaxxghlX4188rn2gH5sDaHiGgJeI9i8I2Y4q2p90GCc62KHYW23CLRbT
X-Gm-Gg: AY/fxX55mcei6HdHUStSwAAjECR5gyRkD2nqM8zIDkerkluO3gvqRB08KsOzB0Xf8Zf
	PqGyqXjIwrQ6c1wVx4NI0se1qzQW7uwgNDqftM5B8mMNfTJmtxcd2GsBOL5iURsU7gSIkGKqdCt
	jFWXLlhV2Gg6Au9sv1obak6slXKN5uM3q/m/+/tVrM7oXaWw83vP3RoRCsRtNEI9XkEpWNhWk94
	HXWiEnUVMgji0XjHOMcctZr7ETmfB6HAeSsm8XkX5cRMcjU1UJ+SqyiTkmzLn3vAwE0hE/awwxg
	Wowiv+Y=
X-Google-Smtp-Source: AGHT+IGlN6v4jImOw8VuFeXaJvvelD1HrEFQmyhUgKkPksl8MOS2jcRp7M0gwDppnz5a32bbCEuQ3gc0yP9obJHyDvw=
X-Received: by 2002:a05:622a:4183:b0:4f1:e97b:2896 with SMTP id
 d75a77b69052e-4f4abd753bfmr742294521cf.46.1767434160277; Sat, 03 Jan 2026
 01:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102140030.32367-1-fw@strlen.de>
In-Reply-To: <20260102140030.32367-1-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 3 Jan 2026 10:55:49 +0100
X-Gm-Features: AQt7F2rHi1bAF3YUqqjonIpPtslEci8zmK1MX3J2tNqhmspO_TOG5tWFqeKUGc0
Message-ID: <CANn89iL-YVSkZyQ6OK4TqQ9w0EEQoCvNFWJbAaNreK3LLFBhcA@mail.gmail.com>
Subject: Re: [PATCH net] inet: frags: drop fraglist conntrack references
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, 
	syzbot+4393c47753b7808dac7d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 3:00=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Jakub added a warning in nf_conntrack_cleanup_net_list() to make debuggin=
g
> leaked skbs/conntrack references more obvious.
>
> syzbot reports this as triggering, and I can also reproduce this via
> ip_defrag.sh selftest:
>
>  conntrack cleanup blocked for 60s
>  WARNING: net/netfilter/nf_conntrack_core.c:2512
>  [..]
>
> conntrack clenups gets stuck because there are skbs with still hold nf_co=
nn
> references via their frag_list.
>
>    net.core.skb_defer_max=3D0 makes the hang disappear.
>
> Eric Dumazet points out that skb_release_head_state() doesn't follow the
> fraglist.
>
> ip_defrag.sh can only reproduce this problem since
> commit 6471658dc66c ("udp: use skb_attempt_defer_free()"), but AFAICS thi=
s
> problem could happen with TCP as well if pmtu discovery is off.
>
> The relevant problem path for udp is:
> 1. netns emits fragmented packets
> 2. nf_defrag_v6_hook reassembles them (in output hook)
> 3. reassembled skb is tracked (skb owns nf_conn reference)
> 4. ip6_output refragments
> 5. refragmented packets also own nf_conn reference (ip6_fragment
>    calls ip6_copy_metadata())
> 6. on input path, nf_defrag_v6_hook skips defragmentation: the
>    fragments already have skb->nf_conn attached
> 7. skbs are reassembled via ipv6_frag_rcv()
> 8. skb_consume_udp -> skb_attempt_defer_free() -> skb ends up
>    in pcpu freelist, but still has nf_conn reference.
>
> Possible solutions:
>  1 let defrag engine drop nf_conn entry, OR
>  2 export kick_defer_list_purge() and call it from the conntrack
>    netns exit callback, OR
>  3 add skb_has_frag_list() check to skb_attempt_defer_free()
>
> 2 & 3 also solve ip_defrag.sh hang but share same drawback:
>
> Such reassembled skbs, queued to socket, can prevent conntrack module
> removal until userspace has consumed the packet. While both tcp and udp
> stack do call nf_reset_ct() before placing skb on socket queue, that
> function doesn't iterate frag_list skbs.
>
> Therefore drop nf_conn entries when they are placed in defrag queue.
> Keep the nf_conn entry of the first (offset 0) skb so that reassembled
> skb retains nf_conn entry for sake of TX path.
>
> Note that fixes tag is incorrect; it points to the commit introducing the
> 'ip_defrag.sh reproducible problem': no need to backport this patch to
> every stable kernel.
>
> Reported-by: syzbot+4393c47753b7808dac7d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/693b0fa7.050a0220.4004e.040d.GAE@g=
oogle.com/
> Fixes: 6471658dc66c ("udp: use skb_attempt_defer_free()")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---

Thanks a lot Florian for taking care of this.

Reviewed-by: Eric Dumazet <edumazet@google.com>

