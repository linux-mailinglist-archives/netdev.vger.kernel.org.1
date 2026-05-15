Return-Path: <netdev+bounces-288157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BEJDFSDBmqdkQIAu9opvQ
	(envelope-from <netdev+bounces-288157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:22:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6EA548B53
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73AD830A2BC3
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517F5311942;
	Fri, 15 May 2026 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G992P9eW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F43AEF54
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778811522; cv=pass; b=CUSZHTyqQx6zJGDbkeeWpbXkq2flkDMdvDGV/AK5rY8krHiS7TTOYUFRg873oXCkKpf+ZIUSlsSOb2rX8spxdMlNFwb+MvP92icrkQvF346BYdG1aiF7hw+cDGpFnN1uGvxKkWNJnlQes+n4doqgy1Rn/pdcJP9FZnbNtH+Kezs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778811522; c=relaxed/simple;
	bh=LZfwwb8fx/as6YLcdeGq22qzkOPv2+qLbXYDfiS6RJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXvGG053j7SAPw3YIcmBaGlqqdYpo9Ln8g2qxiype4esock34RaFZNXp+nIjhFvDgaQIy5e+xT6Q4SRkBh96MppdpplGHyj1lYvTKiay3DWxoaGDRa1LLV5uEpHZFgMJBwUTYZpTjPchcUfnVnjQK/IQWTziXGWvW0TtFu4JFco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G992P9eW; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso336216a91.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 19:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778811519; cv=none;
        d=google.com; s=arc-20240605;
        b=MN6/9VXpuPFtaZDICH94+BUppL8iZfAdfhW6oqDW6ghvBAdTI3fR5JGjMvEgUzUSv2
         uYhpHMQ2eZbU2r9g9tScd5+HALBhiCo2Pn+MttADFIglk6IoRlynswTHZ9/8BnJVogrT
         zra2XuDE52Y3L2v4ghJGR3fFl3LrlZY3Jm9xFYVJo+dSjKmrkTAh6zvH7wTCH/3Xdun9
         PxKBHcL9JYBed9FIseJVSaJsfh+o6n/dOnDJuQXFYXhOzb1tV4ucbz+Lz1BqejcyFqha
         wPMrGmc/y0HCO581WU8E8huTviEeEleGCD1htegaWP0JxQdr8Bfe7YADF7sEa4uUtcEB
         WTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gvHOVXemYQt1A6NQq0O+fwP9L6CAi8/q7rHtcivop/k=;
        fh=q6+4wJTikvhoFEFYGARsyaNbbPihqoNP9FxkDr6AA3I=;
        b=MYt9i1P8jUEGhAa4YviO2l7MDQCeFBd2Aazjej8MKFVgUdpP6CBZv6TBySrnV7znBV
         w8Yg36WWMm+X19T6wwm3iK5yc4KEeRTLuJ7hnjhVZVLJDQ8iKIHmrOoentDcrEhCfwu9
         I93LmDQck12g2Oowne+MTKkcx8cqh0I3sLowmmFkoBSrpwygJ8tc/LCUPmSrL5aiLsEm
         FMf/e3pSnahU+XgbKymG8MKyxyrIONBAGs3EIdMBu3FRPFWaqkQe7NMR7DBNmPy5tu24
         twih/FxvfpAaWjh2rcRlHIRir+cTepdKEo6g/O5EWA8sthsEVTDrbglCgBA+h388yAJh
         Dh2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778811519; x=1779416319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvHOVXemYQt1A6NQq0O+fwP9L6CAi8/q7rHtcivop/k=;
        b=G992P9eWdXzOST1NPfVhWUChW/fW9OY9YgWHA1f4orvFCJ/XqpJs8olPposAGISlu4
         hSLbvRA6506FtLco1NvZ8rJOpafcPaIlXKSgn4XwrqkA3LIcdG2p4j2FnoknJQDsio7J
         WRzE7j2vBlVES+U/BcL8Cw7oGRpF/iRAqkXswNSE3xbvft2FvJ5Nk+7ZeRyGF5P9zsfo
         BXs2z+lH/x3wq1+XoSMq4dhVJ+tpRxJ7OPNrFuz3G6wL64jCO4p0AlbGgkWI3ZCMQHIS
         NcOQh6MPfYZClsIRsb8GXP1RiLp4JQH6LVCrrqUt10PKkqW+uXj4OpD6Ane2GLVN8aTk
         pOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778811519; x=1779416319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gvHOVXemYQt1A6NQq0O+fwP9L6CAi8/q7rHtcivop/k=;
        b=KgZx7ga4cfBl8rd1EN/3YPxEjXkuhsri1F2drykCfe3ZNrf4L3wEcKYaWXoU+jzSfw
         jsreKLiSdp8YbgxSiSR4FjUJdORCSkPcqnshkP1uWIQGmlLal+1BqGUKE9wme+6NV6rO
         gk+sUt+xPN73brLFCcPHdNN6T+dliklG3reS/vYLWII711ZQS1Il9ROe+dKwDMy1ZmaQ
         cx0sMhNF44hJ+Q+tM1lhDwFQSNruaj+6/KQ/hervPW5Cy229IM4Xa3nrS1/X8Qxrrd0h
         MPbGvUJuFxKXVzkobx+siPWDF/BvbjP41+G1LmaWI2SIS5HszbkLyweUmTwmQQJUIiXL
         OGVA==
X-Forwarded-Encrypted: i=1; AFNElJ/Z6PQd4GAMCxvJXPlts5wZ3nxxb2WoHMmmpnNV/w4sUgA+wSwfM8jVNIkc3vpHYrYuX2yMDfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoI7K7SkSfyiildXVaK7c7lPhK8oEn7yUcEL3a5zJ7McwBnlfB
	wrISQTT86LbRZb+LzigHDIdooUT/obguroNFUcPiXNChGYPutHZipyTYFLgO7hid2OaTY4Z9/I4
	a6F5trlF0iK7mJ5pETTqAOYTeYGkfeeUVHEbx4bVz
X-Gm-Gg: Acq92OHGMY4rVgHhHJMFe5F7N6QsoGIOJ0/1bFWlxfDj5kx5zj8PntubGEJDpUdaf2r
	In+FRKbTLU4bcyUcCq63jpDeIIALN5bwvhOgSXCZn15yNYT0KE312tnUmFgqWsanKrpeHRCYHGn
	YnH4UWi9+8odYxHzAmjMqHsqui4UO4b7LCTXkNUT3fk8tcdK2beiQ3z36E6MIaTC0SwRF759uub
	PAgUwhjgwNcdfEIfNQNEJB3nhIG8lqdI4QVLZlCQ7KloikevMNFrZp6k1sYtPh4opu8fVLoRgYi
	7bJ7MX8=
X-Received: by 2002:a17:90b:4b8f:b0:366:5283:cddf with SMTP id
 98e67ed59e1d1-3695149a001mr1414760a91.9.1778811519322; Thu, 14 May 2026
 19:18:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514165139.436961-5-tpluszz77@gmail.com>
In-Reply-To: <20260514165139.436961-5-tpluszz77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 22:18:25 -0400
X-Gm-Features: AVHnY4KwcYaSMM6ME_zDmyreBOKsbOgGqvR0byjCKHroUrtDuoM0Rdy3xLGdKoc
Message-ID: <CAHC9VhS63xq5Pja2iA4DEkRU5sqpQ8ozXzgLBaE6Ck4PDCKpMQ@mail.gmail.com>
Subject: Re: [PATCH net 4/4] netlabel: validate CIPSO option against skb tail
 in netlbl_skbuff_getattr
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, lyutoon@gmail.com, 
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8C6EA548B53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288157-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:url,paul-moore.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 12:52=E2=80=AFPM Qi Tang <tpluszz77@gmail.com> wrot=
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
> cipso_v4_getattr().
>
> Runtime confirmation (Smack peer-label policy + nft LOCAL_IN
> mutation of tag_len): UdpInDatagrams increments to 1 and recvfrom
> returns the payload, showing netlbl_skbuff_getattr ->
> cipso_v4_getattr -> cipso_v4_parsetag_rbm -> netlbl_bitmap_walk runs
> end-to-end past the option's true bound; with this patch the
> consume path short-circuits at the bounds check and the counter
> stays 0.
>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 04f81f0154e4 ("cipso: don't use IPCB() to locate the CIPSO IP opti=
on")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/netlabel/netlabel_kapi.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 4af8ab76964e0..ace561a2904a4 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1393,11 +1393,21 @@ int netlbl_skbuff_getattr(const struct sk_buff *s=
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
> +               if (!ptr || ptr + 8 > tail)
> +                       break;

Similar to my CALIPSO comments, I suspect we would want to return an
error here, yes?

Also, how did you arrive at the magic number of '8' above?

> +               opt_len =3D ptr[1];       /* total CIPSO option length */
> +               tag_len =3D ptr[7];       /* first tag length */
> +               if (ptr + opt_len > tail || ptr + 6 + tag_len > tail)
> +                       break;
> +               if (cipso_v4_getattr(ptr, secattr) =3D=3D 0)
>                         return 0;
>                 break;
> +       }
>  #if IS_ENABLED(CONFIG_IPV6)
>         case AF_INET6: {
>                 const unsigned char *tail =3D skb_tail_pointer(skb);
> --
> 2.47.3

--=20
paul-moore.com

