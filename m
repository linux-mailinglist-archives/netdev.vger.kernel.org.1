Return-Path: <netdev+bounces-293482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XSuSDDW5HGozRwkAu9opvQ
	(envelope-from <netdev+bounces-293482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 00:41:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92798618239
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 00:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE13E300AEED
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23741359A6D;
	Sun, 31 May 2026 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWHS0PuR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="asuJOGG5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500F1D54FA
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780267312; cv=pass; b=gPpCh5Fze+QAbHizn71g0vlQydwSK+gKeJgjMMQZhFMPwDx42hv814MXz4fM+cRghgUM1Ryhcu26rAJc713YUFMphQUNKDfek+21NETC6hVpC3hP9a0PfVKFTHS6nVoyIC+Rye0QNzXl5lGyjLjXwh7CaUZ0pTLhnBxTRm4mmFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780267312; c=relaxed/simple;
	bh=DwqmmYGhzLJZcKctFbT7fQlI57XOCuUvJS2TlMvi4UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/fCy8nQJC7laEyg7DHmwt9ryIs+GfsQ7GopADBlAxN8aw8roODJvTgeHCaS04F7YtlhcYchJkpXO+huoCY3rz9qJZm2bsfLGKKa2Uk0L6oWgvJpydE9mnNAtHsbY9NCmYScRRwpr7y2rzUAnqHfRxjOWqZSn1WbuM5oec4wxIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWHS0PuR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=asuJOGG5; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780267309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
	b=iWHS0PuRQMVKWsQHW0nujbf2mH5MmuBfxMsb+u+3db+FSSS6HsrPqnndrvXrw3sZmp9JO+
	qps48KQDmb2xHGXUMBYHDcOzDkKI+z2ENMDmEn0A7FHLH8So6udDdbLwvvFF0cASHtqMS2
	M69V2G8jc0+mnkOKD2we3HJQ9sl7t5o=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-wTkrT8xPO7aWB2D3P8mTbQ-1; Sun, 31 May 2026 18:41:47 -0400
X-MC-Unique: wTkrT8xPO7aWB2D3P8mTbQ-1
X-Mimecast-MFC-AGG-ID: wTkrT8xPO7aWB2D3P8mTbQ_1780267306
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5aa607bbfe2so1130123e87.3
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 15:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780267306; cv=none;
        d=google.com; s=arc-20240605;
        b=aPSAvNyMAnfxn0rYSGH8TwGivenpGEg5Vdtag+MSxPBKIJ2xickmN+Omq4OhJ1Vi0h
         clAprY1dojzFjdwJUoa2+M8HF9q3c+ewT7p+pjrtUG68UElHQaqOWaDI+M3t+wz6GWjm
         hPbPGmFcTTJxYuHZw3YDcOTObrz/K3Fk/7/UfBrAU75Sr6847gENf35hcJmhvHNuWt5w
         kFeuIGY/3Y3IjNiw8TfBvo5ciyP+9rIVHShkkNncq+xjE14RdQJiyV9EmnGgvM+ADglO
         fQEimMAiKujYMpDSmblSISj7hOw+uvTsXuSbrLc+3Sy2cNXogMUD490ajuaWwiqp9m9P
         Xzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
        fh=j2iDKinEfAxpM/n3Goqps1qcvL8w44GF5COiw2I/BVA=;
        b=Uf+IGxJ6PM7wGEuuRPHMIbeasvVkdZbX4tu/0dNJh3iubKJxAovw9TbEhrWZOJ6kQ8
         fhJArj34gR1Qx3xAiLT64Eq8QJ9JOoexVfWw9GoG18YnLkGa6FYQGrkFYi2ALbmQR5BX
         FGjKGAIxyviKr/NI90TJlpelP7H71Hn/C7I3gCLhPxIJD1CCZPt3+mWPJzSVSkn/6md7
         FkIf1Bz7gl+iZ63/6A9l9cwDyblu+J4AqMyiMiSYIwDoMhYsb/WpLFqPOSC/2n9VQM4o
         hkcVglRGd6eb2fdv8ycM5vFhcwHuY0hPxZGU+LyuuQj+tXwOqCsvvYp7p2/yLT06RshC
         lqAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780267306; x=1780872106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
        b=asuJOGG5Ik+X70IysGdueIpobpCYSEe/esN26gT3Z0vJVThLoj7gKsee82cG2EpCi5
         A1yBepsAKfxLZNWa3OcXzDGQu8whGgdXzi2BAPrN6BDPVp6a2WjpaHtXI1VuIswdImMA
         OS5ZEoCdRxD4ikZ9XRP84KspwOXo7viFs7FATe3Jj+NOP8PJbQx0HVrkcWkNVoLfJjOv
         dVNa8xjhTwV91vNSk9pJ8JRyz0nnaVGjjKhdngPrBhQJAhW0bvqstscXfn9ann70rbBn
         TNR+q08Oy0ZvwRQl02NxZWQUKYa+5qTkSfQTkSauD/DVwdcf+ZIDCKa3wJmSpZMUmCGP
         V33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780267306; x=1780872106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
        b=Z5rQRtd5vj7OG9fMcCXO7hAHb/sMI8i+cA5wKvLCyOpfUiEr2bXRGxo1nyBA4t2Fac
         3sxy8s6iKOH559kGGUTxGjVXUR1vPC7Xge1OJ+UuDnEBTfVykFaETliLI40Eq0qMflX1
         TxHS9GUn30ZajJGr1tgZVraAtrxs387n5lqXoOtiNrB5N0+6WWsg7Hs5Rm9ANsY4P0bj
         KxMCtFaNXveid1X1PV5Fw9nahUvoS522BOJOU2Hv4UACKwfK5ax9yQRDeHOLiO6faGtN
         1GShDFXOFgcIBrphKa/3MHsnTgfntWd572Fjr3es+rRAr1WEan659xWAXKALGUZZUVVq
         BnAA==
X-Gm-Message-State: AOJu0YwnezZv75r0Aw2xCkSqBWKwPMNSVJnVYgLZkcfY2TqAjtn3Wx5f
	Ug2OStuTsYxKL3ncl4Dui8PPOVWfr/tecY6agw/W+Ul/Q35VotbrmB4SYui98No3ZF++LxT0mje
	wm1sV2vQzbA0stl8Dan31OOrdG4MCDHMy9uGZDhXCvqeTJc5yr42e7jsVHlt6bMf8Bqjq8MCuyG
	1eYWdOJsfqq8XJgcrs9N+rvZrz75wN8TZR
X-Gm-Gg: Acq92OGMRSUHDqaBYWZMthK1RTSRyUzHUUm5of7FXzG3KNgLlqNFoh6qbov1f99E6r9
	Zo1WGvbKfTQ9x6MoPq+pq4grf9vzC9kTq3HiQYuKg0NqhExsrqdg+4txkEa1Yk6s8yr29sLsh5t
	rgaNz7Yoi8h0g02Ii0d+87eE/ylLAJMbyzGQuBAJ954yW56iCcQji7oxfyuWQUMAHl3jNO6gl4D
	73f68hCLBCzi3vSDi3QzpMHc1ubl/IT72+msp2PihO2JEXdPQ==
X-Received: by 2002:a05:651c:23c4:20b0:394:642:c648 with SMTP id 38308e7fff4ca-39664eaa587mr13988591fa.7.1780267305630;
        Sun, 31 May 2026 15:41:45 -0700 (PDT)
X-Received: by 2002:a05:651c:23c4:20b0:394:642:c648 with SMTP id
 38308e7fff4ca-39664eaa587mr13988491fa.7.1780267305279; Sun, 31 May 2026
 15:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 31 May 2026 18:41:34 -0400
X-Gm-Features: AVHnY4LJsPgo1bw4BMrZmqSj2uYEh9dzW3bfFOpiMMU9XPGtTORtUTQD6jb1c5c
Message-ID: <CAK-6q+i6JsNA0twRp29P_wotODGr98rxo_CcE0n_BAhH_ofUsQ@mail.gmail.com>
Subject: Re: [PATCH net] 6lowpan: fix off-by-one in multicast context address compression
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293482-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aahringo@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 92798618239
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Wed, May 27, 2026 at 4:19=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> The second memcpy in lowpan_iphc_mcast_ctx_addr_compress() uses
> &data[1] as destination and &ipaddr->s6_addr[11] as source, but
> both should be offset by one: &data[2] and &ipaddr->s6_addr[12]
> respectively.
>
> This off-by-one has two consequences:
> 1. data[1] is overwritten with s6_addr[11], corrupting the RIID
>    field in the compressed multicast address
> 2. data[5] is never written, so uninitialized kernel stack memory
>    is transmitted over the network via lowpan_push_hc_data(),
>    leaking kernel stack contents
>
> The correct inline data layout must match what the decompression
> function lowpan_uncompress_multicast_ctx_daddr() expects:
>   data[0..1] =3D s6_addr[1..2]  (flags/scope + RIID)
>   data[2..5] =3D s6_addr[12..15] (group ID)
>
> Also zero-initialize the data array as a defensive measure against
> similar bugs in the future.
>
> Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compression=
")
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index e116d30..37eaff3 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -1086,12 +1086,12 @@ static u8 lowpan_iphc_mcast_ctx_addr_compress(u8 =
**hc_ptr,
>                                               const struct lowpan_iphc_ct=
x *ctx,
>                                               const struct in6_addr *ipad=
dr)
>  {
> -       u8 data[6];
> +       u8 data[6] =3D {};
>
>         /* flags/scope, reserved (RIID) */
>         memcpy(data, &ipaddr->s6_addr[1], 2);
>         /* group ID */
> -       memcpy(&data[1], &ipaddr->s6_addr[11], 4);
> +       memcpy(&data[2], &ipaddr->s6_addr[12], 4);
>         lowpan_push_hc_data(hc_ptr, data, 6);
>
>         return LOWPAN_IPHC_DAM_00;

Looks good to me.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex


