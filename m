Return-Path: <netdev+bounces-254873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGE8LvKYe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:29:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38921B2E79
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 112443019828
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109D34CFDC;
	Thu, 29 Jan 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyP7M79M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88634BA2E
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707711; cv=pass; b=eYUFN1XVrSw3k9lkXFN3NrE45WMWeEFy5mXF5Llzsw8hwfnzU61Ai+tJKcXqIJ+60HCpfAokEpULgCtKJedi85kOyfvyFbRbjag8EGo8hVvxSSK8CMtryn81MQdn7lBW4QwHFyULRgI/yneZStjw4ea/R6L4sXlVC0u38VsU1IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707711; c=relaxed/simple;
	bh=WAXGGgfoNH2wYmvcahTrKOBjipuZ78ZveCgg1/MRkUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgCsu2rjwtT/QWHtXGvWLVTCiDwsBjsKUkY/GY/8+232cq8/6PC9oh82lzJpD81UhXx4Nl10iBiHsAoRvOpWHYJOQwR4NoH8n9eFeo8xatAH/YSRax22aVFKcQJ56CmVLCVpq2lPRbkUGu++AzYEWLSpCBweTr8rCPugcWK+iD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyP7M79M; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5028fb9d03bso10334881cf.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 09:28:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769707709; cv=none;
        d=google.com; s=arc-20240605;
        b=MkEV9VCjSHPfSD7Xhnhd0CZTtBvDdwzbWSd8AXwHttFha31V3m4iEkWA2NtTPWH/Ow
         2XneeUXYzSPW6Sul0t8h4a41kp2MFIVOYkxTdh78yL2ITn+vFR6m6pHB8QO06fKKfynd
         AfU5icIQe5Lj6wGoAfusQZyg62nw60ukonpa2mMKxCKE3BBWGvhsfAYfJ4o/eB0iC4vI
         yZ47hX+Up+/OnnW6gExxmyCh34EavIAZxmel6vGUOdePUy/K9DemUVqvQ3vnCPpH4XUf
         hLTqlp6eDkJ71SJH9vEuVtOPQAI5ktKYoKSt/lBFnakSpBXpvK4lGJz2Ag1j0u7/cCdK
         A/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WAXGGgfoNH2wYmvcahTrKOBjipuZ78ZveCgg1/MRkUo=;
        fh=mk8pMWFgWO0kbUEWYlgAYR8jg3wNjNJiS2/jcFTDq4U=;
        b=cjsK8O9+VIFKDWEBcyUQaNuLGeAUJeR2F10HXgF8FlaOi7hKMBauuUjfr1gjdxpNf6
         8QHKqyPi4kajqKduIVZUHW3zsrXPgaKGER6GnWvuAAUb59yoapz4Zx2dd8qPBUCBYb2r
         r5LhYSPPI8G3VsgTyEIKyxdCseoMFToybhJXmAYAcvd9hVWJo8O8lLYVEesO3C2A0LbF
         yUhhwECzY64rHRX3HYAmL4aHXOSEM5+8yKyR+CPzU4O7/8DPnaXBUoTxy87eWlht29yM
         WdjACrQqIG+E2dj4oURRECdIJne5S58BtmyKd9/3X/vm+8tAUxz1dnH4Jj9HJpuNXPeR
         G3Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769707709; x=1770312509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAXGGgfoNH2wYmvcahTrKOBjipuZ78ZveCgg1/MRkUo=;
        b=lyP7M79MYJfiI5V1MmRkFf1OZHccB9cMJlAADYYd/rxnDZF8JiM73jsdPBn6gCtWUR
         cTkSNf22DZ3nuyyVbkWyl8zBkrV4IpN+bnmIO8xB1y7U8KCuZ7UmCnix7pmOtNIr23Un
         EsxBNnmo6TESbug7yYMvkS1VOroIpKomB4n/XkCdnW+NIT/T3i1v2cf3ebmxk8nYzDzV
         +4WF4+EojusHc7fE1c+ekTwfRcoe6t0a5dUOgrL2dmoQueeLftZPWSMvEpL87eknmF79
         H+Uzsqg0r51+PdYD+Ux3xDdx72kHipwRFddsP14v+mfDdlJf0YsWEl0mm3+NGuUN0ZDd
         Nr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769707709; x=1770312509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WAXGGgfoNH2wYmvcahTrKOBjipuZ78ZveCgg1/MRkUo=;
        b=rYwL5VK91raBlULtZYFVVPnM/Gdw1C8O3L4C8MMmHIuCPWCk/vxSZup41Je7MAe+xX
         7Mn29lwekn6NhsHqRfi3YwPv5f077zLT7h9PBbxHv3o3CCtT4KHjWwCVVHzhNptB+7Nx
         QYTMPbTtV7ar4I+9K9Dl5fZEp6AqaTAhc/a+Wq5EVTs/23j4Bx2iVnmW0D71nttY5ofe
         Sx/g+/sjH4SsDvBtoHDNQHgriccrXbqz40eIC96RowSC47pTaFGKkALXZjT0zIh+dU8Y
         lYzmZscvcleytY2npYITIlMwS625nkdYoTIPQBYvsU5Yn/o9pQq7QdjVHJTuWe61z7l1
         1hsg==
X-Forwarded-Encrypted: i=1; AJvYcCWBgXAFlWtVGtx3KVRxpo0V2t6PPtjsg+5Uah3gZ7FCDK5Ma8nb6plO3Tv9XBsEocexIebiEIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB5CJtW5TT3lhGAVH4y79ebdd7J4tdWlv+SglXbstKBsFccN1K
	n4cDZrN+dE7sz8qZvdiFb0IKmvAH67fgwBZZC52tbZTTtxBkTxdIsvQ2f4VGrySfvykXqc1sMdT
	PZ8Am4qFWWPL/FFRit3rulMjsN8PaCI9PRExx7iDz
X-Gm-Gg: AZuq6aLoQ0Ne35CVu2Nv8srcSuCKFe+2QW8dLQgQNR9xG8eWRXRQgQsMldyQ04Mfl04
	tdEkP60TOoI81x+jXAWwlHcZ3GftH6y65WW+aTvpw+rk+qdBpU0cEO5md/up+fQHwysuOfZe3bl
	dB1yocJXd9gXK9KbsVUBpq8ZqhxgCR3AYUsKhKhFMqGo734u2pr8QRJo5GLx56U5GQO1Wl0IVqB
	4ZM48kdlLe6RQISu+e/w154uuXy5ru8/0Ras3maNZvPESscvIr7kviKnSz/De1Da2DGJxRQ
X-Received: by 2002:ac8:7fcc:0:b0:502:f81b:9961 with SMTP id
 d75a77b69052e-505d2191537mr2863481cf.19.1769707708337; Thu, 29 Jan 2026
 09:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129083806.204752-1-mahdifrmx@gmail.com> <willemdebruijn.kernel.1622279a11643@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1622279a11643@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Jan 2026 18:28:15 +0100
X-Gm-Features: AZwV_Qi6YHwqNaAJpk5o-rx7Hejn9nptNrcazNuQbTil0h17nK82AhZ9hQ0nvkY
Message-ID: <CANn89iLBpw=yEUODcwdhJA+HEUWhO7YC36q1BqyRc7e7mvJxPg@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Mahdi Faramarzpour <mahdifrmx@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, kshitiz.bartariya@zohomail.in
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254873-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,zohomail.in];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38921B2E79
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 6:17=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Mahdi Faramarzpour wrote:
> > This commit adds SNMP drop count increment for the packets in
> > per NUMA queues which were introduced in commit b650bf0977d3
> > ("udp: remove busylock and add per NUMA queues"). note that SNMP
> > counters are incremented currently by the caller for skb. And
> > that these skbs on the intermediate queue cannot be counted
> > there so need similar logic in their error path.
> >
> > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks

