Return-Path: <netdev+bounces-277464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCTcH4Ih2WlRmggAu9opvQ
	(envelope-from <netdev+bounces-277464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:12:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 862DD3DA2BD
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F24D3031F1A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7C433F38A;
	Fri, 10 Apr 2026 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9/f5HtB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tGOV9S38"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22029E0FD
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835593; cv=pass; b=CwNV1N+LjNSJMrsPs4xrEQqy0jS669WlMW4hGoKPHhQu47f8Ppe0XwQMlYYLF49/dLcc1VwlzVROGSkOgtovVbQx8GRuP2FOD5tuk/xwDcRr8/eTU6dbrtZOsxcPDPZJW5Ki05NxNizPKo8FgKea02yAyQq/JLwXMXSLJf9IXwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835593; c=relaxed/simple;
	bh=DRDrS5BtebjLrZvKyYg9CtDSHneZfFIZ0LuXNF7vq94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+1Fu4dUxLaEBU+6CplV4Q9Fq/uOpiXbUnyTYv8foXxcmRJUSWFXboaOFoKx6c+Vc3tRN+ppVem1/dbkyXK5paWe/H0JVmpKGcF/VlhrWLrOwc7djE/t3H3+jZ4DJggYuBNEnssgMnbrK7gwATm5fe7baj5PdMV5OyFMl/Dz5co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9/f5HtB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tGOV9S38; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775835591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rw4ClkJoKu7XLdQ0/ZAr5GODLCC8+pa3jHNrQEQFMAk=;
	b=D9/f5HtBzWGyr0t9Ls9CLFTIYcPEYp5xfquEWLmEVqnaJxEqo83AjoJ1hnGq5rK9z43LkK
	ANYwx1so/LmhDDZzFwkLUnYv+tU1otSIyGF1FfQnWXC7QxzCsoM6Ev92ekP7hxbSNrCOE3
	H8JN9uQyOit5tf+iGnlnl78YQdRezBA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-aXJjpntwMreEK-jTsFuyrg-1; Fri, 10 Apr 2026 11:39:50 -0400
X-MC-Unique: aXJjpntwMreEK-jTsFuyrg-1
X-Mimecast-MFC-AGG-ID: aXJjpntwMreEK-jTsFuyrg_1775835589
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35c1107da15so2708613a91.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 08:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775835589; cv=none;
        d=google.com; s=arc-20240605;
        b=he7W95J6QnaoSafLVvDzi7/bxtlF/zONAsA2zqCvWA+GhfnKNhj6zUpmWxLY7eEfJQ
         3+/fP35A51jExjQ2ZY5ZzqzLG40aR9ENbgJPJ9Lq6kzl1eM0gmTotOwsQnfgIrzeQ5v3
         iyF6wCnDfg5yGY6A0AyvQAzOs2K9USQUWj+FTqE2jxtLF8/Ml0JIV5faTuZs/DvTlml6
         XB6I086rG5Nc03CEejLkgdmYjfv7nJ5RvGRAqc2b6eL/zBZ1IF2lmYvJOo3of2OdYWJT
         wZCdG4YORzPz25kq9D2Hb7Z/dONDtiNaHnzL37piAorb8pKWn9+NuuWYCT8ZkrdtQLyj
         8DFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rw4ClkJoKu7XLdQ0/ZAr5GODLCC8+pa3jHNrQEQFMAk=;
        fh=H0GBWGDu2oUe2WM4opdQUvWuXjt8LjYGbLiJpVP8ak4=;
        b=GiZ+w/Sp28jeCt3NYe/wb5JyzbTXoFVLq4b52Ca218l6fp+mAB6m5mm88zIWCApIYd
         RVKDrnhHsg3C34r0hJGKUBPUpb0f58j8iK9F1DDUXp+XlhvG0MgVlI8y/lLToEgI1Pbe
         knmjmdeIBnMiDF8rpCZA7t/7q4+jfHl7j6rA0z6he0n7svqNjnU42DOapcVMMNW/REA4
         KU04bhI3pH3bv7LOVtcSPnwg0APUkk0xqG/EFmjWEJtv/Hac0VHqUut5GwRKKRYKF8QU
         VUnU8qWbWQETQ3fBXkDfl1ZZfYRWaNWAGxq2AOgCorwdTjsixJeoGhUhmQ6NX4WpVZtY
         ccDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775835589; x=1776440389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw4ClkJoKu7XLdQ0/ZAr5GODLCC8+pa3jHNrQEQFMAk=;
        b=tGOV9S38NwApj8X3kbJOz83683hIjMz+lExDTocqffkFfcOfUmcNr3zj13KGFFtFgA
         6vGAvjSCTi5v/A5mfK68MA+nFeLyvFYQSCxEsWXRB7lDy4nSBjdVqQZpm+VVCIUqGIpq
         KHckAyfjXDD0uSR9swTT1SGMtxuup9pg5+UhfHfGVBs8mnomD2xTbPZK31+/BYG7s5/p
         QGdghtrubBmNkxfsn4S5s1G3aQLn2UdJilUl1uYBnc1lCpvyTV+vASVHGxXA4BXmRXG7
         2xiDNNN+Gupui4sQZ3NEQIEzEZ7JrOAnpzVKlpa9mkYdK4NyB1I5rLjKloMQOkajd8W/
         drlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835589; x=1776440389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rw4ClkJoKu7XLdQ0/ZAr5GODLCC8+pa3jHNrQEQFMAk=;
        b=J+UgV2wkipwKiYUWRRaHHz6h+W/YBjRy4MyE0X6WurePvmWzpka8dxlyxq/UP9J7yz
         EpuCgmM8A2NspG4Dxiuvo2/1xke8SfV4/4vP1q7d5xWioyhF9BB9UTAbpi4YhgvBH/Kj
         apuA3Z4eXo5wTP9mCkm0E3FfCNUXBNJyiXXaB+o4gYYzlemFbnc64gLFYwaH7l2n4v9R
         1Y13P0RlFSwRdvSND97oKSslf25DkR3NTLUiYt7PUlzY1rY8uDBR1GT7vLxhgrUzPwxw
         vPiHRFmTSNz7CY/sDJlmmxgI5p+18ZvEp3hyYPpHuFlQmemhdTrjKN1MhiJnP8jVvlJ+
         vw3A==
X-Forwarded-Encrypted: i=1; AJvYcCUJAw+71Yx47C8pC53zKz2V+P5u37qURYtNNVpkNJdfiVEpzk9yMgms1imnvr3zOXNfWOxD7OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNkw+FnPCk1KntBa9tUCQACfAIkwOcJoWYCLfWY3wc+XIy0w+j
	NoMc0guW4bVzzMh/d8xClPTVJmpbRB7+8fFvvjOlBUDpndzSbnaamns+ErhPfobjBUbHbf35MnU
	Avqps2kJqtwMTJzGLuy+MQ5Luj6lsGaNVF6pz3FPqep+W5tKZs7PZ4QMpB67Iv4GR+c0wWO6yJS
	xU9LEqRllelfoc1jCKrBdoh5nLfhEKGWQs7l7ghOo5xyE=
X-Gm-Gg: AeBDieuOE365eQh1Pfph1X2QyEZiDAawCu/ohuhcO+rMzDEEkHOZCT2GV7jJ/cAOlCN
	+HNAM8HqGaNDwVzLBSq5c8s6jpeLBEn6Fv6goi3NlvJnNlEhKj54HYD0sMFNuTAeAqvHBOCmFWe
	CXo+Gmai+4MkQub6DQxdEnZdlUtjsjkL/a7S1zMW8/Rf7laGJ5mtu5x/Tg+U76xsBubQSwjrAD7
	gyJiQY9SIteMeVS6WEZbhQH8oJaah6bmzrjeQ==
X-Received: by 2002:a17:90b:2b4e:b0:35d:a6eb:197f with SMTP id 98e67ed59e1d1-35e4241b186mr3732043a91.0.1775835588559;
        Fri, 10 Apr 2026 08:39:48 -0700 (PDT)
X-Received: by 2002:a17:90b:2b4e:b0:35d:a6eb:197f with SMTP id
 98e67ed59e1d1-35e4241b186mr3732017a91.0.1775835588010; Fri, 10 Apr 2026
 08:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410150943.993350-1-alice.kernel@fastmail.im> <20260410150943.993350-2-alice.kernel@fastmail.im>
In-Reply-To: <20260410150943.993350-2-alice.kernel@fastmail.im>
From: Davide Caratti <dcaratti@redhat.com>
Date: Fri, 10 Apr 2026 17:39:36 +0200
X-Gm-Features: AQROBzDtQyqB3LMZX5oorEB39jVhp9Xr8A7jZnQghpz53dK0Dog-7B--ytVSytI
Message-ID: <CAKa-r6vk3oXiVR_a967KhHybW-Vo4M2p3B4R4ZfU4zOhVfkZ4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/12] net/sched: act_csum: don't mangle UDP
 tunnel GSO packets
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xin Long <lucien.xin@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	Alice Mikityanska <alice@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277464-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[fastmail.im];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,isovalent.com:email]
X-Rspamd-Queue-Id: 862DD3DA2BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 5:15=E2=80=AFPM Alice Mikityanska
<alice.kernel@fastmail.im> wrote:
>
> From: Alice Mikityanska <alice@isovalent.com>
>
> Similar to commit add641e7dee3 ("sched: act_csum: don't mangle TCP and
> UDP GSO packets"), UDP tunnel GSO packets going through act_csum
> shouldn't have their checksum calculated at this point, because it will
> be done after segmentation. Setting the checksum in act_csum modifies
> skb->ip_summed and prevents inner IP csum offload from kicking in,
> resulting in a packet with a bad checksum.
>
> Add UDP tunnel GSO packets to the exceptions, and also add UDP GSO
> (SKB_GSO_UDP_L4), as the same logic as in the commit mentioned above
> applies to UDP GSO too.
>
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> ---
>  net/sched/act_csum.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

Thanks!
--=20
davide


