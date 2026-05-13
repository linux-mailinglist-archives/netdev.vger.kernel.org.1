Return-Path: <netdev+bounces-287527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGGQBAZZBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:57:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D0531B75
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D73730EA5B1
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234DD3876C0;
	Wed, 13 May 2026 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ST8R+vyG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYGV7CGi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD2F3A901C
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669686; cv=pass; b=jxNRs11n9Vm9ZHQx1LrkNEL0iKzWI4AxIOb0qa75H/sL/deU4YT+4h0pju8NeSiI71d9Z/gYH0FFx39TAPJS+zq4DizUTpMvjIU9QQuKMHi3KGKICz4EHah/+td9zi+pc2KhFGV4q6DNmGMpntGAs5iFpNTpdzUAnocAsMUMb1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669686; c=relaxed/simple;
	bh=GZje+ZiJxEz+btEIsphrsooQ2+zudAVcHjAlRLVbV3E=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6xW5P3r4ChtxPhVqtx3WaFl5x1fYCJxHOuCK8lDE1Klsf0tEGiAI6d9Cghx0KJNCMlZpVNvPcZYFiKI6ngvShilvpqPSNJjO+YAXg2jw0eQALy1CRLdsk/+GAX9kAmb/GFu2g8lRliNyqOrmLd4QIAPHWXN3E0TTgoewYpbvrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ST8R+vyG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYGV7CGi; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYiwWqyFlKD+jAWNT5p5f9rsEzCB//mqrevcTuUaauA=;
	b=ST8R+vyGEeXvwKGJtDgzxg+aoNOpZa1ANeiND15zwRGwMty2l5d+vN49piBlpp8PLXleuN
	ZW+iSKvJ9xNf6MrvqjCzPzzgg0shyadRIsJHaT4gzWPtONFA0deU5Z/h/d1Mnq6iGnJMyN
	MSFStYxPE6fEXimvkaJMXXYG8iufkmE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-8RofgT6SND2pRBL9SF6hUg-1; Wed, 13 May 2026 06:54:41 -0400
X-MC-Unique: 8RofgT6SND2pRBL9SF6hUg-1
X-Mimecast-MFC-AGG-ID: 8RofgT6SND2pRBL9SF6hUg_1778669680
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b940da8ec09so714592166b.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778669680; cv=none;
        d=google.com; s=arc-20240605;
        b=JUbgPVE6SLT7C9ECG2a6UF+sUjAjEeZpvNKULmmhbyTg6p8yYPXhgsuYwUT7sVGdOJ
         nDIwIHUe7bf++B6yVb/LkK1LcaKrbPuwl7qvr2vfwGCORQMDjPfrMTjskujaUQTZhxgp
         2zBfE6ssYWqFabue/Sim+hbZt/sNNeXgUhw3byQqeddDxa8OcSktHzS5TtOOcZ+b9TAQ
         HwzbONLOySkq1/PuMl4+H24f8h4HMY5VsiulTrRQoIvWPC1QmENPGel9SA0OEf/sRs3e
         6sfif74lJ7ImgQzm/FzSSu8nJYflyeGTErOFRp2p2q8XWPKSRucnj2TFCm2TXb9/Hyj1
         nKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:dkim-signature;
        bh=AYiwWqyFlKD+jAWNT5p5f9rsEzCB//mqrevcTuUaauA=;
        fh=SEl3QrYt9FxlMjNhkGedl3N+5uswiyqL3T5s1xcDWcw=;
        b=XcJRQudnShsMF9plKHtXdxC3RUZMWacyOKG8Ug60kh4Gw2NhHFT6qWFKpvG6WHNpRk
         XqPKexC8UyybXAAiU7OIuhLRRMv+nOQ1DyTXaRU2P3kg1V0X5o8E6tpKUXZRkq0gVAB8
         jaBPASxmKxIFt5B6Mqaa3N7XR1vSIjFCdR330L9VuwT5PKcuICkdgihdiPwxPNczM4dK
         oHe6T0n2IMzxWfIAP0D4dhghwHVITBrPOqcxm/N99o+kunB9aRk4/0DFchHLMhFfr70y
         lwOmC35Cd73OiYlSp1xnA8nGb4XeFxli0JeVSCWRqw9cZh/0Md3wPNsvbLZlkYlRrvh4
         4UGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778669680; x=1779274480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYiwWqyFlKD+jAWNT5p5f9rsEzCB//mqrevcTuUaauA=;
        b=PYGV7CGiQr8vKueN+vm92504QVoSrbR246YS8es4USb9gx9D9Pl8HVfIpG7v+FAEs5
         LLJ28JFLlALLgsG3qS9pOzYZfYhPmb+UHtiHUyzgDg6rj7+wmk3z4nza7eZ3rX1IaJKu
         yKIwpz+m4hx/rboRcIBV9y14RuxZnnmdDyYcwX6J764S9eLbYPhYWtIZS7Yia1jK7arO
         9E39WUcgHD7TGSSS/fpMRqs9N/uGeMyMLF/aO04bc+Wkge1CwteUZ42SzIfFopzNkAH1
         tTyf/8ZJnzfY+EmTq6wxTq+LyPCin16u/s2R5d4peeG8vVPumoNm443Mk04VtUY5xI4H
         9G/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669680; x=1779274480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYiwWqyFlKD+jAWNT5p5f9rsEzCB//mqrevcTuUaauA=;
        b=VuhW5IizPH1xFclnjHfSq50tkAyIT3KdGCTPagFMQzW93+H4d32A7j95Nd486PWkxt
         HI4MuBbGwKk1xBRSlZWYAiAfFEDT4msGyO+JMqlv12Bz2kG64ffQQ2OArrmi7Avy3aA2
         ImYv0s3R7vJaBZJ28s6rCDlzUYZ0Qt5KvkddqVPwqFDz2tZdqMKnwGy6dKeV52210b/C
         iQSuEQeTyrFZTVZ6GwEOl5InYvTRh2h4JhiNvvj2SYd8FC9EGn6suUS6wqR6sYou0Sy/
         mKPc6CENaPMa0mNov74LOI+7Ih3Yl/mLF5PN1cYLlXIXS8Ohsw4QqJrOYoTFdFSuuzyd
         sQmA==
X-Forwarded-Encrypted: i=1; AFNElJ88TOamgeuSf0h9pUzVYtrf0fZYt+qEzgbnqYt5HWUVg1hJgAuiBwLEpsLX3mpVk1BfXgLWT10=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKqLkUauq+IDOL78Q4gft4rz2ZmcW5oFV+Iu24A6hO02C5EKR
	sq1Y++SIlYT69jhvWSzmy3WZ145iw9LkQET63uZlKSOcYJdQqVHFeLa32r2TjMnrAT+q6232yAT
	8YMnzA0AjuqClivgvFcXaI4Y5eMPb/1lsI1D8WUm6z9F0ZTTuAdAfa8ufh4vu4OmsS5XGOvwN/D
	y7HN7NgTLsjCYdHZinvh12sl4O92KDjSt+
X-Gm-Gg: Acq92OEoBNrbERi08rc4g/+uwMExYCPdTYX6ejTMOE6IPSnyo7meDuU8dwqvrQOXDoq
	KKjWp7WVACinyowQ++/6zffQzbgsHCnnigv3UWlpS/7KoXdt3Fe13R6ht5n7ADjyaKyP0wolMrz
	dYAsr9b5+bQIFcY8B/njF+kO9+NG8ffqc40CXkUuZPxc7tlOvgn3cdxrD+Rmys/nw1ohCIdpoWd
	dQJj1IN
X-Received: by 2002:a17:907:1c1e:b0:bc1:36dd:c6c9 with SMTP id a640c23a62f3a-bd3e27eeed2mr141806466b.33.1778669679805;
        Wed, 13 May 2026 03:54:39 -0700 (PDT)
X-Received: by 2002:a17:907:1c1e:b0:bc1:36dd:c6c9 with SMTP id
 a640c23a62f3a-bd3e27eeed2mr141804766b.33.1778669679460; Wed, 13 May 2026
 03:54:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 May 2026 10:54:36 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 May 2026 10:54:36 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20260505084253.998548-1-amorenoz@redhat.com> <20260505084253.998548-3-amorenoz@redhat.com>
 <b1820863-fd30-45b5-b03e-28225ea80780@redhat.com> <20260507153754.346d7274@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260507153754.346d7274@pumpkin>
Date: Wed, 13 May 2026 10:54:36 +0000
X-Gm-Features: AVHnY4JcnFzQ0kKE2BXfGxgp79Ls7S1QO2S08TGJYGRAG1cTLUhx2hLl4S2Wztw
Message-ID: <CAG=2xmMBX2ZT_wC=j9rzGoxLnJ7-dYzKG1Z8zP8oup7dewuQLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: openvswitch: decouple flow_table
 from ovs_mutex
To: David Laight <david.laight.linux@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, aconole@redhat.com, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"open list:OPENVSWITCH" <dev@openvswitch.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5F0D0531B75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287527-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:37:54PM +0100, David Laight wrote:
> On Thu, 7 May 2026 13:31:24 +0200
> Paolo Abeni <pabeni@redhat.com> wrote:
>
> > On 5/5/26 10:42 AM, Adrian Moreno wrote:
> ..
> > > +/* Must be called with flow_table->lock held. */
> > >  int ovs_flow_tbl_flush(struct flow_table *flow_table)
> > >  {
> > >  	struct table_instance *old_ti, *new_ti;
> > >  	struct table_instance *old_ufid_ti, *new_ufid_ti;
> > >
> > > +	ASSERT_OVS_TBL(flow_table);
> >
> > Minor nit: adding the assert and the comment is redundant. I think the
> > assert alone would be better. There are other similar later occurrences=
.
>

Yeah, this file (and datapath.c) seem to rely heavily on comments to
clarify locking requirements. I can add a follow-up patch converting all
comments to these kind of warnings.

> There is no point adding an ASSERT() for a pointer being NULL.
> The NULL pointer dereference does the same job and can be easier to
> debug because all the registers are still live.
>

This asserts for the mutex being held:
    #define ASSERT_OVS_TBL(tbl)   WARN_ON(!lockdep_ovs_tbl_is_held(tbl))

maybe the macro should be renamed to make this clearer?

Adri=C3=A1n

> -- David
>
> >
> > /P
> >
> >
>


