Return-Path: <netdev+bounces-84540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD92897342
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA311F21474
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35EA149C77;
	Wed,  3 Apr 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yi4Y6cDW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9D59B67
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156406; cv=none; b=KcdCpNRMQghbeQnT5Wx+NmrIzqPv8f4/VCOg4+jRoESHL6Yd/AhlmAt8NrsN6PbnjIZmW+3HiMUOmD9s9KgskZpNsKrqRMnjeXFsA2rAYYCCMCzgHCdXsyqIJZT6CDZvuSJkcDs3V6DbNhkbXsW5iAPAkhCrJa/Kwl5UGtjkB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156406; c=relaxed/simple;
	bh=ndCkxQo5uX3TQotVcTv4BC4YZaml5s4aoF3Ej4w+FUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erQ3FmeHKJlxl7G5I3Te1U6vh8on1jCrFh4YTVBXIat0rilL1KoevbtS7KsAlL3ZCspFhNxzczVA2pn+ubzyBDb/OuHEVFwQzREOBGPjU6lOn3Oybilg8VABBuUrPeEZFkvHIosHxGaqHpOi5T6KppSSWnl/1B3dlsKE+ESqotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yi4Y6cDW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so14816a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712156403; x=1712761203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndCkxQo5uX3TQotVcTv4BC4YZaml5s4aoF3Ej4w+FUE=;
        b=yi4Y6cDWQG/yZnIc0+LVq5woEAJCnJMKM3X4EdPhqv0chAM6ccxrcL1zOnHIBKnnz3
         Hv0NBPckexp3BKEab1dIJIygV9Zv1VKf/w8WJT/urJ0YjQTXE2ymhbS6eoQpqN+yUNwT
         eQnfPSOCTREHLhzHGevwRo1wAC841QMsiNDIQ0vItHi+WLHSZVzUMcTmextkd65iDMD9
         eiW1eTYwq+g6RgxeOFkpXvzV5g4Q2LZ/xW8LMV6q+Drg889FqxpFI7xCIzi4fdweijQC
         93qGwm5G6hvPwj/qE44SaEQyd2f63bcz4iI4DjtpR2TWHMf1zuF7ElEd/g51MfNhH2Jr
         VxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156403; x=1712761203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndCkxQo5uX3TQotVcTv4BC4YZaml5s4aoF3Ej4w+FUE=;
        b=xSxrJk8Vl26+8W2/RO8WlIUPGmavTiD2KiSZGeX48wnqEBk1M27z7emtxmLK6GACB+
         aN5AxlQ8di/ZP4TxZr8BSYrnvepRAsoogljCGD43di0sAa7NifFAqyazqBGA9sHzlJzk
         gvLWUkyRXLiuM4cFZylOHxWJudkfdOT8ZGLE00qleGnHmfipgAsGLtmvxKkJL0ZM9iJH
         kUExLGrPKq00NaoSU0sEPqIhZKJ1x4mN3Ju0S/qigET4fRD4/3FPiR+R/vSeuv9Rq0Nf
         Rn5fnFaGT9+mrAlBQ+cva3T5LwQvaKYBejdNDG+dNbGWLY42HX/w/G+NukCgas2/40rW
         TAgA==
X-Forwarded-Encrypted: i=1; AJvYcCWWoLqFO8Q/2PE0b23daidR7hYfJHaecWAL+5FbPpQqQU05K4rPK7De869TgneUN0+nXrwf12MykSZK2wQiA7gvWgj68dJY
X-Gm-Message-State: AOJu0YwsKw7pvMFD4ULBKu24PWFn3fBjrzept3wQUFutcH+Vw3bP+Ik2
	q5HrHVrJzJ/8iKhOxYt0k5aNa7rb/jg3tKWvjrW0nEW7x2Xk3HXu3Pxe9QjMLxIrkwxeE0d7Rwr
	FWiEe0G8duQLnBoJbt9I73I8y+GPUmD5tyYcB
X-Google-Smtp-Source: AGHT+IHPTZDcMATyH2zQNSMP/QAmL6iKMFrQgG+/h4o9L03bpFV2cWUzzq0dJnHRfc9AHioUPSz6YvGx8UjJKRQHyJo=
X-Received: by 2002:a05:6402:5c7:b0:56e:ac4:e1f3 with SMTP id
 n7-20020a05640205c700b0056e0ac4e1f3mr110506edx.7.1712156403298; Wed, 03 Apr
 2024 08:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403113853.3877116-1-edumazet@google.com> <Zg1l9L2BNoZWZDZG@hog>
 <CANn89iL72ia+aCaRxPvBBaOcbKU_VTLZSPBjiUAQ14dhpSJrfw@mail.gmail.com> <Zg1t8LFGiShcEWeX@hog>
In-Reply-To: <Zg1t8LFGiShcEWeX@hog>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Apr 2024 16:59:52 +0200
Message-ID: <CANn89i+EFGdrFUt+JpOPQUfOa7_aHv=G-ChRwHCt18zoJQFEVQ@mail.gmail.com>
Subject: Re: [PATCH net] geneve: fix header validation in geneve[6]_xmit_skb
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com, 
	Phillip Potter <phil@philpotter.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:55=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net>=
 wrote:
>
> 2024-04-03, 16:25:47 +0200, Eric Dumazet wrote:
> > On Wed, Apr 3, 2024 at 4:21=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.=
net> wrote:
> > >
> > > 2024-04-03, 11:38:53 +0000, Eric Dumazet wrote:
> > > > syzbot is able to trigger an uninit-value in geneve_xmit() [1]
> > > >
> > > > Problem : While most ip tunnel helpers (like ip_tunnel_get_dsfield(=
))
> > > > uses skb_protocol(skb, true), pskb_inet_may_pull() is only using
> > > > skb->protocol.
> > > >
> > > > If anything else than ETH_P_IPV6 or ETH_P_IP is found in skb->proto=
col,
> > > > pskb_inet_may_pull() does nothing at all.
> > > >
> > > > If a vlan tag was provided by the caller (af_packet in the syzbot c=
ase),
> > > > the network header might not point to the correct location, and skb
> > > > linear part could be smaller than expected.
> > > >
> > > > Add skb_vlan_inet_prepare() to perform a complete validation and pu=
ll.
> > > > If no IPv4/IPv6 header is found, it returns 0.
> > >
> > > And then geneve_xmit_skb/geneve6_xmit_skb drops the packet, which
> > > breaks ARP over a geneve tunnel, and other valid things like macsec.
> >
> > geneve_xmit_skb() uses ip_hdr() blindly.
>
> Do those actually end up getting used? They get passed to
> {ip_tunnel_ecn_encap,ip_tunnel_get_ttl,ip_tunnel_get_dsfield}, and
> those helpers only look at their iph argument when skb_protocol(skb,
> true) is ETH_P_IP or ETH_P_IPV6. So, definitely not pretty, but I
> don't see a bug there. Am I missing something?

Please read my changelog, I explained that skb_protocol(skb, true) is
parsing the Ethernet header up to the non vlan proto.

syzbot buillt a vlan packet with final proto being IPv4.

So the helpers who are using skb_protocol() do not understand the IP
header has not been pulled.

>
> From a quick look, most users of those helpers seem to pass
> ip_hdr(skb) (except for ip_tunnel_ecn_encap called from
> ip_md_tunnel_xmit and ip_tunnel_xmit -- vxlan_xmit_one uses a cached
> version but I don't think it's needed). Would it be less confusing if
> we removed that argument and let the helper fetch ip_hdr?

If you look at the syzbot report, the ip header is definitely dereferenced.

