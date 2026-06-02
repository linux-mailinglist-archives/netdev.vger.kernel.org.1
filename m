Return-Path: <netdev+bounces-293994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MgHMidMHmrmiQkAu9opvQ
	(envelope-from <netdev+bounces-293994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:21:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47921627AF4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1D09309CBD0
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 03:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537C7374185;
	Tue,  2 Jun 2026 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Bcf3oh79"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22FD373C0E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780370256; cv=pass; b=S2RG41wTQhYpwJngpNSQnxJowDo/b8LY30j0FGIJDhXEKXZZjWK1L9zHxO6C7N41TykTgACqTUBoufpvtw0Fg1wAH2VgKlEuMnxfrhUHUyDZ5B91UBIMBA984N0vaajJRkUwFe/wEj/wBfg7XAekJ6MBFBNoH/4zzGAKv1K5T/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780370256; c=relaxed/simple;
	bh=NrNtds7Xu9hVrX2Bnojh/FQca01+7oLkxZWeAGFo1N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIO2+Vv+KKKD4a6XHubHUyDCl2b9d1mizkIgEej5ot6DLXsK152rXIcobhXM07MEhTG6j+nZje+UM1+D77GN6nBQsy2huF5cxTYNZSeLObl9XX67Vj4zFpScb/PLbCzZ2C0dQmf/5uTAaILmBSBDJra1vixpykXFzxUqvzkSgTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Bcf3oh79; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0a5354da1so18409015ad.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 20:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780370254; cv=none;
        d=google.com; s=arc-20240605;
        b=HXydhpSSkruKQww2UBDcpJjc1d427Ct1rMLBQcr14OCdN6trdNU4IfyJrOTQI4XlVk
         3X1x/wNGQeWKskFIwpCX/4lLhUoBj/U1MmQ6STahpnn6jOwsP5bGe1z7sObcvtIBm1fH
         8+2+VfVU0tGFEVo/5LV3F1XfqfkU2+9kYFmjRv0Y9bGGrSzijAp3ZBLvdC21v6xBXrNU
         JK7MZmXQC5fDR20nbv+rbbHbu0Rsy++hQsKKGGVQ4M5SSJZHA82jrgK8QYBswzbVYj3d
         pdAeadRviDcjP7UAGQPZk9vGPFeLd1z7gxbJQ3U8ip+4WMuneZq/SkNO3vlkFmR1KDU/
         DBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yRbGrDPr8/1rgB/5c9BpqqyHTaNQfsdpMIViVvNKLvo=;
        fh=6pd8mXS/wom7g36fP9lZsveDojeYEEozfNkZBQLKor8=;
        b=FKudmwWP9juIVT0s1mjTyScMjKntnQ+tmKfOyLYLyYLXbQ5YxWgvu+bj8k5kvl3noT
         GxFFtG0JtFgko6M4w6GmQjPzbOKfEWUPgaQ1RY7buDn9F3S2o9pBxxSlPr0hIeimFa+O
         Ks97O3FrbO+V0yFSxxl1ruUx+J1bdHztqfm3Rn8E+u1dAjJK3J0LUhKypvlE5n/DDdrB
         7+hkI2e0T4KPX1B2rb29K0Krwaxk2b/BRB7QUfD/YnndndG/o2NXdoe8wKvn9/HKsAsx
         CzuySz3ADRsYDLrEcH45/PPDa+pAI4phptSGqIpsCx/89z1TROfIAhY3QLHeGgAZQCnn
         XHJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780370254; x=1780975054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRbGrDPr8/1rgB/5c9BpqqyHTaNQfsdpMIViVvNKLvo=;
        b=Bcf3oh79gvB1y1h6vk6ljHru9+bI24G7Wt0cxnV3x2oqt4H+GGZ4DFS9ILOrcW4dP6
         V0p3wzXsBwZszoOzXJhS+v7nMMJIGcjNFtDp9hwFrp90GciKOsTBjMWlmb6QFTBE3kpK
         ylYebVEOBN9LgI50lyAo2D5aUQv64AsXOr6jnbF3lbFZ3PmYla5HfXVUlQp0N/JGBWGT
         iKbrbYNcVvp2TZIpzqvNgzxL0S/6nPrzo+BrNRwScJtbnMJRFnnMm3J9JDtUFrpmCKpT
         UrxKsuk06jXGm9Bs9FINYcVXGGmlp/VBOseRSLqWXEJQK6kEaXUYFVN1Y2Lgs1a1da6Z
         9TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370254; x=1780975054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRbGrDPr8/1rgB/5c9BpqqyHTaNQfsdpMIViVvNKLvo=;
        b=C4UGMGeVefLCY4FVolLQVJsQT6suvZJAjz427Rh12g+SfR+6KsCLK2wkcFVIH46KHZ
         HSDE7/yB7krWutNAoUNv9rqm+0RTweSlDD8UA9cUa0rDhfMJWd8vu+O5ko+Nh89e1PrR
         dEMtkxGnCMVTgL11w5JwFYmmRjFOEjpAQ2DufohjbDwSu8kd5ZHgt7a0wPH+Co0vN46/
         r7WXg1p3TZuukQwhozyZeiKcY+bwIROJNblq60UoOgDVP5b6qyok4NfecG6/T/LBt04n
         PKQcezudvBQgetpsnhC+oldqgqo/8izyZANonye/lAtsTSK0Gg3JRAfP3u1px6rkPpas
         9W2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/rX4LYt0gTnZApo8nMh5dGJb17VXIufovBT+bYn3HLWEkVsOImGQmxocRwsggnW4Hp17hOZzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUuc8DW9tXppihMIcQ9iBenpXBOyfZB4Avyza9pVgbJlQV3hiA
	Gwo7cTAzy4mFOkqHWTmp1QHar/B50xs5Lsq0euEoMaM4AM+3OUAUbj9oYdBBRbQ2yVuInDiFqUi
	UImsgxVDyD7TGo6jz6N/p0Lp6uV0Z8naxr4y9fIXi
X-Gm-Gg: Acq92OGl/F2EvYtUWCKL9LlHOXtnX9899ix0nvPNYLkBOomFcMlX6OTz9jL/nCQUZgI
	1BTCkcvD/vBrfeEwvj/Wg54Vchp5Lcdlp+MwPRe7kCA/+dSwjFb+UUk+wbnYpgEizdIty1K2jLh
	eHt3196TyrAq5lTMnRqhi0+ypd6F6D9vEowiJcUosDNYl64z3zZBpACFEhf6whZGpdclffA0NlD
	FVB3Opfh906z4LwcztNRLvjR0egYMVekgelh4Y/X7/ILpUoxN51DN46WENjucpi3cLXW96kKy11
	KfJ8X14OQErEWt+t0w==
X-Received: by 2002:a17:902:fc8d:b0:2bd:9b0e:b43a with SMTP id
 d9443c01a7336-2c10cc48783mr20042485ad.7.1780370253972; Mon, 01 Jun 2026
 20:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524041442.2432071-1-tpluszz77@gmail.com> <20260524041442.2432071-5-tpluszz77@gmail.com>
In-Reply-To: <20260524041442.2432071-5-tpluszz77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 23:17:22 -0400
X-Gm-Features: AVHnY4I4W9V-dv4I-l2LKCn8EXbQx2RA0Mt-m8Ql8JMgxlHNkMBkt_pweVb2PlI
Message-ID: <CAHC9VhQikjqG_CZfXy3vJP3Os0xNw9jjGoMdLmWiy5epU3gxcA@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] netlabel: validate CIPSO option against skb
 tail in netlbl_skbuff_getattr
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, fw@strlen.de, lyutoon@gmail.com, 
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293994-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,strlen.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,paul-moore.com:url,paul-moore.com:dkim]
X-Rspamd-Queue-Id: 47921627AF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 12:15=E2=80=AFAM Qi Tang <tpluszz77@gmail.com> wrot=
e:
>
> netlbl_skbuff_getattr() locates the CIPSO option in the IPv4 IP header
> via cipso_v4_optptr() and hands the bare pointer to cipso_v4_getattr().
> The consumer re-reads cipso[1] (option length), cipso[6] (tag type),
> and then cipso_v4_parsetag_*() re-reads further bytes from the skb.
>
> __ip_options_compile() validates these bytes only at parse time.  An
> nftables LOCAL_IN payload write reachable from an unprivileged user
> namespace can rewrite them after parse and before the SELinux/Smack
> peer-label consume path (selinux_sock_rcv_skb_compat ->
> selinux_netlbl_sock_rcv_skb -> netlbl_skbuff_getattr).  This is the
> IPv4 analogue of the CALIPSO IPv6 trust-after-modification fixed in
> the previous patch: the tag parsers walk the option using attacker-
> controlled length bytes, producing slab-out-of-bounds reads whose
> contents feed into the MLS access decision.
>
> Validate the option fits within skb_tail_pointer(skb) before invoking
> cipso_v4_getattr().  The pre-tag-walk guard "ptr + 8 > tail" covers
> the CIPSO option header (type + length + DOI =3D 6 bytes) plus the
> first tag header (type + length =3D 2 bytes), which are the bytes
> cipso_v4_getattr() reads to dispatch on the tag.  When the bounds
> check fails the packet has been mutated after parse, so return
> -EINVAL rather than fall through to the unlabeled path.
>
> Runtime confirmation (Smack peer-label policy + nft LOCAL_IN
> mutation of tag_len): UdpInDatagrams increments to 1 and recvfrom
> returns the payload, showing netlbl_skbuff_getattr ->
> cipso_v4_getattr -> cipso_v4_parsetag_rbm -> netlbl_bitmap_walk runs
> end-to-end past the option's true bound; with this patch the
> consume path returns -EINVAL at the bounds check and the counter
> stays 0.
>
> Cc: stable@vger.kernel.org
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 04f81f0154e4 ("cipso: don't use IPCB() to locate the CIPSO IP opti=
on")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/netlabel/netlabel_kapi.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index d0d6220b8d59d..c2d3ea751f4e1 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1393,11 +1393,24 @@ int netlbl_skbuff_getattr(const struct sk_buff *s=
kb,
>         unsigned char *ptr;
>
>         switch (family) {
> -       case AF_INET:
> +       case AF_INET: {
> +               const unsigned char *tail =3D skb_tail_pointer(skb);
> +               u8 opt_len, tag_len;
> +
>                 ptr =3D cipso_v4_optptr(skb);
> -               if (ptr && cipso_v4_getattr(ptr, secattr) =3D=3D 0)
> +               if (!ptr)
> +                       break;
> +               /* CIPSO header (type+len+DOI =3D 6) + first tag header (=
type+len =3D 2) */
> +               if (ptr + 8 > tail)
> +                       return -EINVAL;
> +               opt_len =3D ptr[1];       /* total CIPSO option length */
> +               tag_len =3D ptr[7];       /* first tag length */
> +               if (ptr + opt_len > tail || ptr + 6 + tag_len > tail)
> +                       return -EINVAL;
> +               if (cipso_v4_getattr(ptr, secattr) =3D=3D 0)
>                         return 0;

I'd strongly prefer if you moved the tag length check into
cipso_v4_getattr().  As you've already validated the CIPSO option
length field it should be a fairly easy check, no need to test it
against the skb's tail pointer, just ensure the tag length doesn't go
past the end of the CIPSO option.

>                 break;
> +       }
>  #if IS_ENABLED(CONFIG_IPV6)
>         case AF_INET6: {
>                 const unsigned char *tail =3D skb_tail_pointer(skb);
> --
> 2.47.3

--=20
paul-moore.com

