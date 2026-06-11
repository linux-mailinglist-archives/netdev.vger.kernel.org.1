Return-Path: <netdev+bounces-298007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fCacJ0ByKmrgpQMAu9opvQ
	(envelope-from <netdev+bounces-298007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:30:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 137FA66FE01
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:30:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ctDdKLeH;
	dkim=pass header.d=redhat.com header.s=google header.b=XFevLNkb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298007-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298007-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C39943014C67
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D060B298CAF;
	Thu, 11 Jun 2026 08:30:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9321D00A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:30:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166641; cv=none; b=QFTEvvRPLtkjtfAzxYOiO3PJXZW2bRtT/qr/mTKQF5dZAy+sTnytBg814inDMaiDEsHePIQGbEELEZW1qfk5VwM8kRTWsJpDNt/4WwkWV5PRt+G4CY/tBeyZzs1sEoUtklnaIdzpQiv66D2xnMkmsbbHjRLNqiJMnY47+4Eybkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166641; c=relaxed/simple;
	bh=XR0V+4h+8MJh9uy6euPn7a63rvq06PZMS77yDeSWSwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E0adKvCXPBAdgZY7en/Z+ax5E9WC7A9wXA/fwjAGZQOW0DS5Eavuj3+xBsZted33DXpeAV/vCNmCg+fX6AZMSpkJ4IAj+FHrfYz3Rq3pI7IH0GYEvY1NiFFdEO8p2YT77w+vrOsPgNY2Tn5+VitOwsoPZzf9wyOPahgsnHh+HTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctDdKLeH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFevLNkb; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781166639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0b7sev+YXar1BdsAXXs6+O/y7RGvS4oVWMa4UAvNR4=;
	b=ctDdKLeHJRLv5m4ouOEffdB3b8dMB1SYIaqvPfmg7+M+zZsNIwwCSEJbHGFhN5mdB1EbKp
	ckjha26x5ELzzLHrCMciBPGgESKot7uOIhfVmVYBR6qDKztklov2TKgRA+9hTYYBgv8SeF
	aOyX6yOsFDjV9gF/L7PtRMPzSLzqDMU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-M9tt5_5BNOa7LUCsipnhaQ-1; Thu, 11 Jun 2026 04:30:38 -0400
X-MC-Unique: M9tt5_5BNOa7LUCsipnhaQ-1
X-Mimecast-MFC-AGG-ID: M9tt5_5BNOa7LUCsipnhaQ_1781166637
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a060eb84so48952065e9.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781166637; x=1781771437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0b7sev+YXar1BdsAXXs6+O/y7RGvS4oVWMa4UAvNR4=;
        b=XFevLNkbb2tPXCzcxti/MwmkwoZL1FVCyYfFqjRoidx3forL6ayFkISRluyeI3VOL4
         nZ4MC3HZ4+5nwOTxeBihImXnsk4JOeR6dYziKuL0nyz7guzIWcathuGv4rqNf+jCbkrY
         WDgSOc9CUsSLWEqPD8EbYMQw7u6xdsThNWiFfLeXMDhCui5po1XTqRFt8XSDTBvpUBuE
         DAGcyesZ3jcAeqpjVfTBm90uBo/QreH+10Ct2WlOzdk1l9dxQw8DDKZWGBCJtDTBi78a
         BtzOclt9zyK/DM+MW9S03kH8Nd8o92gPlLSZs+i9yk+YMniYe8UK9RS24Zifbmn7lBC5
         5N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166637; x=1781771437;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K0b7sev+YXar1BdsAXXs6+O/y7RGvS4oVWMa4UAvNR4=;
        b=YrFgpohqKuGJzF4e/7Yyp18fZId8AstGtrxlosBDVggDNZoAkFR69SHY9PZxGWGWJu
         DOLQ3xUIrRCTKWZ1ooKqeMF3dl9VB2GDFSX4pd1UI7beHBE+shJ80bhDVIYFCqMH8ZCY
         R9dOgGOplgPY7MxnRFUSiAepMIGcYgjQ1drl8hMdKSypuxr87Cemh3vXIKzE4BO3yicC
         XYKbMz5iQN4X6k48xsTqzHitKnMehnxPod0K7iMX3x5IpUJLJzwL4vOf7oYnCX3aA5vM
         V+6IrcGWBrYgKSTHRKK/Tlm3Y4jZRiBQwuxCCmG7tB+QWgQ31YRCdWnpGXOkaAVEYEKh
         ls2A==
X-Gm-Message-State: AOJu0Yw3eaAgRI+2+kf1k9KG6+geHthChsUyPOOxG9dyQLAJroSgkPHr
	I5/tESOw4C95fUOZ56xQmdbY1pZguGR2OIc4fB8yJqTBab+atDPLpHA//9WTPulkDhoQl/zn/lR
	Ad9pjs8VHKGme+7McuN7ZEoz9od6oH1tuH6JAv1MWcc356gPhN36M4uX3aw==
X-Gm-Gg: Acq92OHAew/nFBt4qBAiBddE8eb5uwMXk/rLBKYZ395/XK788vqPBsm9iJGtHUIH8Xu
	IFIPIV71uBO7p9T+LlWmJlV3ZhVAaA1kYH+q8g+NBwcGvOB5DVP0DTi3dSByMIkDiY46ROrcRba
	FSp1btEpfvf3nuBmstlc5pk9vNXJbwaoxrIsSFuo0RFL1DSHof6AK0UQfzdIYFP0SCqfgK7Nqy/
	XkTXq/+VEulu461DSIZhL2QTELg36X+01WS+LAerE8q1NhTF/cda8kF6GnYYpFW4IjMwEct/Wpr
	EXTcUo/Wjjy4tQ3bXfhjbi6GEa0Dn/bV/fkLZ1gGw5NB/x9S491DMCE9B/l1hmGLOAtgWw80Hnf
	R5236RVqljA3jMJzTxgDaGmQk3cGNkk5tjxHb7zjiJW4w/rDWo632mfPl
X-Received: by 2002:a05:600c:4444:b0:490:bcf6:469f with SMTP id 5b1f17b1804b1-490e534d301mr20585775e9.0.1781166636983;
        Thu, 11 Jun 2026 01:30:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4444:b0:490:bcf6:469f with SMTP id 5b1f17b1804b1-490e534d301mr20585325e9.0.1781166636452;
        Thu, 11 Jun 2026 01:30:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c9057bsm55175325e9.5.2026.06.11.01.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:30:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0F0E17BCC96; Thu, 11 Jun 2026 10:30:35 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sun Jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, shuah@kernel.org, jiayuan.chen@linux.dev,
 menglong.dong@linux.dev, emil@etsalapatis.com, Sun Jian
 <sun.jian.kdev@gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Run generic devmap egress prog on
 private skb
In-Reply-To: <20260611080850.536996-2-sun.jian.kdev@gmail.com>
References: <20260611080850.536996-1-sun.jian.kdev@gmail.com>
 <20260611080850.536996-2-sun.jian.kdev@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 11 Jun 2026 10:30:35 +0200
Message-ID: <87se6t8ono.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.13 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298007-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me,etsalapatis.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 137FA66FE01

Sun Jian <sun.jian.kdev@gmail.com> writes:

> Generic XDP devmap multi redirect uses skb_clone() for intermediate
> destinations and sends the last destination with the original skb. This
> can leave multiple destinations sharing the same packet data.
>
> This becomes visible after generic devmap egress-program support was
> added: a devmap egress program may mutate packet data, and another
> destination sharing the same data can observe that mutation.
>
> Native XDP broadcast redirect does not have this issue because
> xdpf_clone() copies the frame data for each destination. Generic XDP
> should provide the same per-destination isolation before running a
> devmap egress program.
>
> Fix this by making cloned skbs private before running the generic devmap
> egress program. Use skb_copy() instead of skb_unshare() so allocation
> failure does not consume the skb and the existing caller error paths keep
> their ownership semantics.
>
> Fixes: 2ea5eabaf04a ("bpf: devmap: Implement devmap prog execution for ge=
neric XDP")
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  kernel/bpf/devmap.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b..a3d6c60dbddb 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -512,35 +512,52 @@ static inline int __xdp_enqueue(struct net_device *=
dev, struct xdp_frame *xdpf,
>  	return 0;
>  }
>=20=20
> -static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab=
_netdev *dst)
> +static int dev_map_bpf_prog_run_skb(struct sk_buff **pskb,
> +				    struct bpf_dtab_netdev *dst,
> +				    u32 *act)
>  {
> +	struct sk_buff *skb =3D *pskb;
>  	struct xdp_txq_info txq =3D { .dev =3D dst->dev };
>  	struct xdp_buff xdp;
> -	u32 act;
>=20=20
> -	if (!dst->xdp_prog)
> -		return XDP_PASS;
> +	if (!dst->xdp_prog) {
> +		*act =3D XDP_PASS;
> +		return 0;
> +	}
> +
> +	if (skb_cloned(skb)) {
> +		struct sk_buff *nskb;
> +
> +		nskb =3D skb_copy(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		nskb->mac_len =3D skb->mac_len;
> +		consume_skb(skb);
> +		skb =3D nskb;
> +		*pskb =3D nskb;
> +	}

So with all this pointer soup and back and forth, the version you had in
v2 (with the check and skb_copy() in dev_map_generic_redirect()) was
much cleaner :/

-Toke


