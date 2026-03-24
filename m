Return-Path: <netdev+bounces-270839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMpdD07uwWkgYAQAu9opvQ
	(envelope-from <netdev+bounces-270839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:52:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1581300BAF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B17330B825B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64082377EDE;
	Tue, 24 Mar 2026 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQe2a/Pf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfWHNUP4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E08A5FDA7
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316874; cv=pass; b=EygTwX06j/IuPk3gqzy3kDjJjpJLlfa7wqAggi/7Eb7MeJj6p8U5n/qkTpA0RW8n8JPGA8zFtKeI9Mlfow2mMfEeZb1NkgSzY26RvXIxGhnEdcKwXV3H5zcr2OWeuupOtfLM97z3hNTHNkE4ecdwl3aAInuQi4H7U0Z0H+lAVvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316874; c=relaxed/simple;
	bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCWHE34z5HqK4yYptbqhAC8dXarUMXG55GFlPVl5LV08/oY2/qI9QtEve/Zru1Y07fyPhFPWZ14Gd5Vvxr1d9toZDhjVDyGNRbf0ojN+zpNrm956HNYKzIofScIGsgzaIeLzgzkh56Kyjcnthk3emSJVBue4k0uHkCwgBZMnz2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQe2a/Pf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfWHNUP4; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774316872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
	b=aQe2a/PfOnW+V7sV7pIE9fqAWjFo4Kdpqga+ZE9Cq50XatTzpnOs8n9nyQ8mpCJ+jenwGH
	iiNjUwhU2+UScy8vwNcfyEqLy/PUexbqYgrlx3HkXed2ApTh5wosKIipJKl36/mIViO7AL
	xgTLGrrgSnPP6wI8s5w3mNEGd/VB3EM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-7rzS8ijXOZqOd1sgLvKRQg-1; Mon, 23 Mar 2026 21:47:50 -0400
X-MC-Unique: 7rzS8ijXOZqOd1sgLvKRQg-1
X-Mimecast-MFC-AGG-ID: 7rzS8ijXOZqOd1sgLvKRQg_1774316869
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35a1e725a8fso24818388a91.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316869; cv=none;
        d=google.com; s=arc-20240605;
        b=GrQuF/FPwHGl90Mc+H+Q7lVYsZB1yMj6XkAWto5RtFpo/9YAVjrI0CYSW5H4sU9lIR
         rFBSIzf+CDzKe+u9Kr+2CJyNzu5JLvWUBCxNP7MRzDQh8YdJuwL7XHQltm7v+wv22L0N
         gpjH5a04mJV0FdnnlLDkh2iC+w7KFgu5uH2rGV6rybBiuDo+f95njKPogVbtWLcW4Z6x
         6tUhcZKLXCOarK72BvXig0qECarQlLci6wwykeTJSL3lAX6SgOrBiRGdsAg0Sc2TtUZX
         ZGOAfAL3DLIzlRIbYq/QuOpLszR4Ot8WJND9ATS7D2isToHj/vk9cbRHDQpRyGf/WD3b
         cisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
        fh=HMW7QZJPCQrEGa31yllY2gZl++LddUfxp1iEykhBGQg=;
        b=T5qhV1bADuhTJ2M81OIkkQJzaSHpUqnVV5tNzRCnmyywVjfuL99oG8gTYQJmFoKuln
         0FJGddu95O7o05OmZuCx7x9u8LpSsTa83XmzRjLRUW3ejeP4T43kzH/jhMew6IOk8mpD
         9kErQtcQ3fMFyqzxRsSM/VIlFyegKcyh1V0BJOR4V2yXOHDFvAmwfHOpvoDwKmyWvCO1
         8LtWmz+FVBs/CC6RKJ29ZZsPLLSK0erdNYe58XCSCQFlv4C0HjJYv9kG/gEMCJvDTA9W
         Ms6f4paxYDGqFAPnwkF3HcP1Uiu1V0TkMa1UOXYfzpbyvW/bR4OhH2kXXe0akePCbHqx
         SNrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774316869; x=1774921669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
        b=SfWHNUP4b1MMlckkVihIB+FChbQKRI4wqOk5tUwZfrJG8djvzXr3rbFUsBVq5SCSY5
         e432wso4yTbHHFy5DAQwc8/FM7gIBMjGJekHQy4mJ5vtNWyBT0h7HvsprHMYqg1CGBT8
         NFdbK4KBmqS4rqzgJRCavFrhTImcDICgsN9BY0m9q31D4N14rEST0ELqJddkymWthX+q
         DgwmWBjEg300y1v4kdA/idHeK+aO3UCo8gP0c3mYFJUHMPFiNYUyjtjNaL2SwuL7Gan/
         wnJJRjVxDct9p6flx+oz3o4wQawJEwHP5nta5QiCKuMEhRCSXNnNtnIQdO0OGws/NNIn
         tCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316869; x=1774921669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
        b=EC6uafwre921B/4SS4PI4qgFfW9QpfQ4Zp7805Jeve+4eHHrieUgkQ3UH6ELjQZmiL
         Y1ulHLwd3GFOKUDKMLFRVA+IIbY+Zt3qUCuO8ir4FWSK9EFbWCZ55rCPgyqQj07F5sxi
         iKa3no/r3zovTvt90AHbqXttpgBCbv9a+rQe1mZa4y48gQl24GgNW2Ak4aGIJD7jGJY5
         gxp8fOd+wdcPYhT+Nm23AqbKMKeCSigiHKCrwlIbmSoDKldA6SVBWKl6mUSpi4pfEN2W
         T0DSWdI6v9rfCk69bxpOO2HGj1UiPzxK0kU0VCX/qi8vWJmE4YMTFR5rPsH30IiltqnN
         nVPA==
X-Forwarded-Encrypted: i=1; AJvYcCVGPw1CVOF9GiM86CMxVk12LGR7b4GJqTaYBgIeMcTUaqeRJueGFct6v80gcdWEuGjyKrVJkzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDUXf1k9ddTMZgpgein9a/WVC+HbLps73nHpyY0vpDplb6qmN
	PZAeSLKyMhhHVvoVwmX4T+Kp5cR+tB3fABlHynMCqMyPwLp3s3shP6+FwNtIqBKrPv/W4Sdun/J
	62cv51yDuVUk7bif15crLhRnjdtbXD09JNjSj4pvFfK4CoKb1Pdjl9HHihVbVTywP+CY4mjIEhR
	x5r5K7VboUkfH7PcktmxKPOO+2VVcjruhs
X-Gm-Gg: ATEYQzzm9LKZY9ojVqGlbr9bZQNCbISKN8rCC7w+m5H+44s4A6ng9tNt0DlEXtVYIQy
	7+mxUsTkDrWNKFhOhZpkeLi5RSUbNcqJeg/8jN/Cbs18G68exA5izudLtF8pxpxdpdjSDoDPt9M
	xLqUVvCaLfMVsQ87WW1tF6lC7ZOLoqa4O5wD++vUrGsPrR1OZ+RlGftYOpI28CVhujI+ER2vGa2
	B8eL/8=
X-Received: by 2002:a17:90b:35d0:b0:343:7714:4ca8 with SMTP id 98e67ed59e1d1-35bd2c69ef3mr14096619a91.15.1774316869502;
        Mon, 23 Mar 2026 18:47:49 -0700 (PDT)
X-Received: by 2002:a17:90b:35d0:b0:343:7714:4ca8 with SMTP id
 98e67ed59e1d1-35bd2c69ef3mr14096600a91.15.1774316869084; Mon, 23 Mar 2026
 18:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de> <20260312130639.138988-2-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312130639.138988-2-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Mar 2026 09:47:37 +0800
X-Gm-Features: AaiRm53pbYbqwGT5VS_08JhQ1nrnThR4mTQx66_GOYMi6H_pXUhKS9fZsNHeN9o
Message-ID: <CACGkMEtYD8OL-4XyEFaa4hhBbki_zmcywkqa7Bd-1J2ZMB8RoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/4] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270839-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tu-dortmund.de:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B1581300BAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 9:07=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Introduce tun_ring_consume() that wraps ptr_ring_consume() and calls
> __tun_wake_queue(). The latter wakes the stopped netdev subqueue once
> half of the ring capacity has been consumed, tracked via the new
> cons_cnt field in tun_file. When the ring is empty the queue is also
> woken to handle potential races.
>
> Without the corresponding queue stopping (introduced in a subsequent
> commit), this patch alone causes no regression for a tap setup sending
> to a qemu VM: 1.151 Mpps to 1.153 Mpps.
>

Another call to squash this into next patch.

Thanks


