Return-Path: <netdev+bounces-210840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55934B150EB
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABDD3BD327
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970FF298CD0;
	Tue, 29 Jul 2025 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ZMJwmr8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537A296163
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805307; cv=none; b=prJEaDNNo6pn/fo7La7yY9EdzAU9Suheo0elFjQvvmb/8WHSjV2/oK/TQREstf926xpD4wI6+NPxZ5HQYrNufmUu3sAWs2IQs+S/bzcMcnG0UdW0mwROKuX8XNUXAEs7vMpL/spzzXjl8q2SgXyYDeFg8fRjliBuY11SUDIR4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805307; c=relaxed/simple;
	bh=jWhsVhI/kIUcTiaKNB51zhD0HFWoZiB/Z43Nfx7mIFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHXLeIYB/vmZPCtTbVo3pd9ZvUNdyCuvYQPS+TY3wPyTARvyiRi/xtFpXBPzqbdYxI7WYqYZ42T2f7QXfNJwL+AabW+/gS7s1jH1zdCPMrTQ33YgMQselx2kuT8cmNDFG3L4r4EZANrHyrKe73H7topQpNqicldkKGcyqd+mLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ZMJwmr8W; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso60234301fa.0
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1753805304; x=1754410104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWhsVhI/kIUcTiaKNB51zhD0HFWoZiB/Z43Nfx7mIFA=;
        b=ZMJwmr8WfuGaAHqd7QbcWLZVBmhPV2k9owTaWeA62BBN/46QDdmpc53VwQDjcOZiZe
         AnAI7lNAyVoOIAQsOK09NvFoO6pSKguqS/NM4BN4yanFpD8nXhODXZcpRAnykDkwwb0x
         HYRVDQjePpkzxsKGHbSuKy2zxQmzZyjhvNs9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753805304; x=1754410104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWhsVhI/kIUcTiaKNB51zhD0HFWoZiB/Z43Nfx7mIFA=;
        b=u4PvOjdEAVXx51wBiv5KmykOY5oL8vkzjXGKo7UfE55gjtnRRCTBMnjXlwjm/HxZw5
         jslLI4+hpXomDN496R1rHOWcr+aqvx3CS1Fuj1+7LHdw4ies4BEESgeV7nbcW6qHhCgt
         qEDPdvkiKPTErJrGSY/x8fHPgkQLSB0xbv4HwM1dRyBt0UjK7JPzY7nfXR3HjER5f6PN
         ZWFIOS2NRmYkpG9FMa0+O01nsnnAXwW7xmMXOXYzGCCuqSSBkO3m5G5CjyqIPnYp5/6k
         cEccTKMn7XA4dq96Fuac59pddFpKfOPbyOHCr/CWVfvS6PyQoq2MHB7xwPu8n7/jvCZ1
         b2ww==
X-Forwarded-Encrypted: i=1; AJvYcCU2tVJ/D8nHzzN8M5dfpVBhOPTiLA+EUt4NPcbKVpH12PhcWcGYx/bxUZ5dHIbF1OBPlqE1WwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/fDhWX9Awix/XUs7R3QtXQ78l5tKar/hELw5K5P7dLesA80UH
	Ttk6E6pp0gUPYE7BFKzCpTHJjgT8o6/Shi5qHbvjt/EeMFKkoqy0JNwtPgxjJu/ykoYYln/23+1
	rYPiag8BtfczxpjTWhmdKPepBdz0k3gCi51ZVtj6tXg==
X-Gm-Gg: ASbGnctvLmr/O+Zf1GR1mVWWThTu5p5HE27ISUnDNFJwESuVVmKycVi4H5mRL69zqeu
	54c70ddogYqeujvBkV0fVlZSQssPyQ3QTYxYnNEGlP6hGBVlj3Bv/WAS2P/PbihdGyZbfi8tQKf
	rZStXjNR8M1pFIz0/v2mbOUPfxHOOseqta3Md2k1lx1kT0txq2JAg4ur1okt4yWDpybKmPd8kU+
	tJ+3ticO9UcHnvGvQ==
X-Google-Smtp-Source: AGHT+IHvhEcBhtKVE05nESYn7oyTCfm5DRlyJvc7SFnlN+wRMWImG+RvgCIqXF12EjXml2WEKjc3u4XZxdc0LIb1VSg=
X-Received: by 2002:a05:651c:2226:b0:332:129d:b6e5 with SMTP id
 38308e7fff4ca-332129db89amr20417581fa.23.1753805303872; Tue, 29 Jul 2025
 09:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
 <6583783f-f0fb-4fb1-a415-feec8155bc69@nvidia.com> <CADg4-L9osR02Aey319fMVAyAYXxOfaKqWcQ2AsfQCrdFKA5vsQ@mail.gmail.com>
 <CADg4-L_SNAKy3mBn7ssq7uw0_+wZ_=zyqrQ23yVTOo5J7z7Q=g@mail.gmail.com> <6d3fdda2-e0dc-484e-8f29-3010b8b5da78@nvidia.com>
In-Reply-To: <6d3fdda2-e0dc-484e-8f29-3010b8b5da78@nvidia.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 29 Jul 2025 09:08:12 -0700
X-Gm-Features: Ac12FXwA7FP_RYGIEZX6HpN20ml0iBBFFWFA0rvyfmeSLfNroEd5q_4LlEoMNPM
Message-ID: <CADg4-L8B0i0Nz0tPyQX3qX4TWJ1rKD7KXvo2qHQKo_yFP-=1Fw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/mlx5: Correctly set gso_size when LRO is used
To: Gal Pressman <gal@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 7:03=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote=
:
>
> On 29/07/2025 4:01, Christoph Paasch wrote:
> > The below fixes it. The problem is that because gso_segs is not set,
> > NAPI_GRO_CB()->count is 0 when processing the packets.
> > So, if we have a non-LRO'ed packet followed by an LRO'ed packet being
> > processed, the first one will have NAPI_GRO_CB()->count set to 1 the
> > next one to 0 (in dev_gro_receive()).
>
> I was also suspecting something in this area, but LRO packets shouldn't
> really aggregate with other GRO skbs as they use different checksum
> offloads (UNNECESSARY vs. COMPLETE), so tcp_gro_receive() should flush GR=
O.

AFAICS, that's only for when NAPI_GRO_CB(p)->is_flist is set (meaning
for forwarded traffic).
skb_gro_checksum_validate() will make sure the checksum is ok when
entering tcp4_gro_receive().


Christoph

> > This means we end up in gro_complete() with count =3D=3D 1 and thus don=
't
> > call inet_gro_complete().
> >
> > I'm still unclear why this only fails much later then when checking
> > the checksum, but I'm sure the below diff fixes it (and also gets rid
> > of all packet-loss, so throughput goes up)
> >
> > Will submit a proper patch tomorrow.
>
> Thank you for the quick fix!

