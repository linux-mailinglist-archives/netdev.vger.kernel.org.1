Return-Path: <netdev+bounces-253083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODnhFhrmdGkC+wAAu9opvQ
	(envelope-from <netdev+bounces-253083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 16:32:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B93C57E096
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 16:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B8CC3007CB0
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01412192E4;
	Sat, 24 Jan 2026 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdsHI7QX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661901AB6F1
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769268759; cv=none; b=lhcvIOe0Tyt61ck3uFSlDORm2Mzr/p5poZfa2esTPHLWQ6hM6rarUAWVlzXYJoQCQk2BB/x9NTWWcLAYz0uMbzLwa5t8jPyKyawH98VruR2GFCuwoz8jFLeH9Q1R/v8Evg3QwICS0bn2zZvJE3ZHh4GdQwGiepEmjB8CPIbNyaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769268759; c=relaxed/simple;
	bh=13WOJfXyNz9vDYI4mzZxcRaUPoKhQnqYRhWZca4AYQI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PArM3CsQJGOn73nFxyUaYXdYBZfRJ2XyiHz7oKVm0tImJK5V4NWdHrazIrAoSedMFZiJLOwr+MAnWAR86zLg8eGz80anjlexcsX/knTnSEZTQLDejTIc+7t9XXfwCnSTILM6NPJq091SWFPqq/BRIDi7UB7Q74hU+Bi+nHCThNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdsHI7QX; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79456d5ebf9so776187b3.2
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 07:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769268757; x=1769873557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qteqiCkxMf8z0LRZMrRtpUktIGtWi2uAVPr5t2CCFw=;
        b=FdsHI7QXEHL1+O5AveoNqEyZh6FKG+ocymb0POdhZE8nmUfV1iYIW6vxwdaLqyUedA
         WZ9YDGwBV4ZWEzVaKxwNRFlq9bkOh16IHt/A1v122eUt2rArmY2/99FVbADf75japGZ8
         2BbUCkuYtb8xuV780XBDEh6CGHmOv8HBpGyll0AbFhY3LB+0rB9owQj8yQ70b2bkMJDQ
         +zmj9bllMxFwG3rSsdgSB9tSHfZkL+lYZFBGt1hwbU+IYwDNEYCYryvhi2PWqjvuomdq
         utx6QPt4UGE1OcckLIfO2YggDTAGj5kdfxMIHoQFFEBIBnjkAiA09vKnekKIWz7tpx64
         ADrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769268757; x=1769873557;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qteqiCkxMf8z0LRZMrRtpUktIGtWi2uAVPr5t2CCFw=;
        b=Wf6jG+qi7UI6eQ5wAFflNO+JcmMlI9rjTf72DhI4nt3Pi2ii/UdfayGZdRzrudY4EC
         htLXeH2Te+gwKfPbzup2gMHuY4cNilKPahyGeLfOtMr4f29Wpvcg6HFoXHXHQjDLkbkf
         yRG9AUiyknZ9p8oCEMcTlg26X0bBFXjbPWlnhwbCJ2cWipkPo7SxbgvhEMpAUJfYDaIG
         pYjJuSHrHnmCo7mcnHqg73gzzqwCeI5T3fz8YslzqfLaKN0NJouiLX9MxKsS5M6r26cS
         w7KWWPw1a1lzdANKtu8rVtOn3qwD+YzD/9SHx7cMhft2DbPnTY+sWwug5Okkx9XO7hVj
         5krA==
X-Gm-Message-State: AOJu0YxLDj8nDqtuvXj0eQZyhDJwk35FYyG3PN94v6r/BKlh7rH+LUqP
	kABRM6zTS7DcV1bbMoTSgHq6t0aaPCNbkT2S7+o9SR5mNIZ53nSpV0rQ
X-Gm-Gg: AZuq6aLSNMNX75h4ZkKougbfgnaU5GalWVbi1nrf4rnhTKlEQbgOA9sVjAjXfTrb/bT
	hmtIkc3O/EZuzmswPXk+o8NyB6wX/D4izoAPb9FraJGpN8zfgR4bKiMa4t/pHhlZP5tkpxxNc2G
	i38PGD796k9IJuPLyPL7dlE3XIthLukayXfanvfV3zIc37GHMvuXxCEClFIWQS9qWfchBHdqWKb
	tlLoStY5S+iSOM+KOI546bd5OnQpl1Z4wo9PyzlSXRBPSU5Fj49F61V7CahHr11y/4rwBqfJxGc
	suSEg5vggvq4CIATQtXj5oSbxcj4yxpTDlu7kRtjhqtPTGUqOEahSLDdnyhcOeqlth+mUIDcKxo
	7YUdZ8mh1W/LmHG4g9TwfV4niWzCKoE4fErnzI4hZAftIIKSIlcYDvyC3UEy1qxiHJAc4nDKLUc
	Zc8aWI7+/PE8d0d3S68lPu6IIHF5ajzdpBoVGk0dZGZofuJs/A4nYeUdZxnlE=
X-Received: by 2002:a05:690c:6f0d:b0:786:58c4:7a21 with SMTP id 00721157ae682-79439a954admr55423407b3.69.1769268756649;
        Sat, 24 Jan 2026 07:32:36 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943b1155c0sm25407807b3.14.2026.01.24.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 07:32:35 -0800 (PST)
Date: Sat, 24 Jan 2026 10:32:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 kshitiz.bartariya@zohomail.in
Message-ID: <willemdebruijn.kernel.17f36003699cb@gmail.com>
In-Reply-To: <CA+KdSGNvJ3np3gitnSmztxD9n=WuNcRHGsvKsJUE+FDJM6Zmjw@mail.gmail.com>
References: <20260122185357.50922-1-mahdifrmx@gmail.com>
 <willemdebruijn.kernel.1682586fd684e@gmail.com>
 <CA+KdSGNvJ3np3gitnSmztxD9n=WuNcRHGsvKsJUE+FDJM6Zmjw@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253083-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B93C57E096
X-Rspamd-Action: no action

Mahdi Faramarzpour wrote:
> On Fri, Jan 23, 2026 at 12:56=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Mahdi Faramarzpour wrote:
> > > This commit adds SNMP drop count increment for the packets in
> > > per NUMA queues which were introduced in commit b650bf0977d3
> > > ("udp: remove busylock and add per NUMA queues"). note that SNMP
> > > counters are incremented currently by the caller for skb. And
> > > that these skbs on the intermediate queue cannot be counted
> > > there so need similar logic in their error path.
> > >
> > > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > > ---
> > > v5:
> > >   - check if drop counts are non-zero before increasing countrers
> > > v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx=
@gmail.com/
> > >   - move all changes to unlikely(to_drop) branch
> > > v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrm=
x@gmail.com/
> > >   - remove the unreachable UDP_MIB_RCVBUFERRORS code
> > > v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx=
@gmail.com/
> > >   - change ENOMEM to ENOBUFS
> > > v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrm=
x@gmail.com/
> > > ---
> > >  net/ipv4/udp.c | 19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index ffe074cb5..41cf8f7ab 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -1793,14 +1793,31 @@ int __udp_enqueue_schedule_skb(struct sock =
*sk, struct sk_buff *skb)
> > >       }
> > >
> > >       if (unlikely(to_drop)) {
> > > +             int err_ipv4 =3D 0;
> > > +             int err_ipv6 =3D 0;
> >
> > nit: whitespace between variable definition and code block
> >
> > >               for (nb =3D 0; to_drop !=3D NULL; nb++) {
> > >                       skb =3D to_drop;
> > > +                     if (skb->protocol =3D=3D htons(ETH_P_IP))
> > > +                             err_ipv4++;
> > > +                     else
> > > +                             err_ipv6++;
> >
> > No need for separate counters.
> >
> > All counters will either update IPv4 or IPv6 stats. Similar to how
> > the caller of _udp_enqueue_schedule_sk is either __udp_queue_rcv_skb
> > or __udpv6_queue_rcv_skb and chooses the SNMP stat based on that.
> >
> > Can check sk_family =3D=3D PF_INET6 once.
> I doubt this. How does this work in case of a dual-stack socket?

I see your point. The question is whether the stats represent socket
family or individual datagrams arriving on that socket. There is
something to be said for the latter.

But given that __udpv6_queue_rcv_skb unconditionally increments UDP6
stats on drop in __udp_enqueue_schedule_skb, the established behavior
seems to be to follow the socket family.=

