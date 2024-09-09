Return-Path: <netdev+bounces-126348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A99970C9E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 06:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A803F282882
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 04:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF7D18DF75;
	Mon,  9 Sep 2024 04:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0071ajW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022F3D69
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725854757; cv=none; b=qTrN23IXt8n5qesh/XG7NSHoPnBjzKVD6dildJUNUtP2wPUHQfmFW+xO5v58oBf82W1NYQFVmb7831uEyDPR7S3fVE5SgfAoXYzdiLYTUpp+cNbICieyffDBtfE2W3U23t6vrGNvyF+1tNy8UFSrxm4TLcluaJb+o4c7cP1nLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725854757; c=relaxed/simple;
	bh=7CambRdxJl72z45osL7W3fqqVzpgMRyRPNU6hNJpNIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJRqNBvjz0jEnDPHtA8w7pF4zGrRJOifUO7Jxi4OlqhnRT8AJYZCyrdtLMujQW1oVO99x78a0RyrTXDWJ9AS6pEgLHdwroNxgujxs6shDXRkqfzYtM1unTJu7A1dr0eiIeebKfSHEfaIEx9px8Td05N8NE4HThZ6O6A/ucv43nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0071ajW; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6db449f274fso26455447b3.2
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 21:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725854755; x=1726459555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y2XZicmIZualwCUhlDFNpSmFy2HjzR6Yh2gdcKw5gw=;
        b=N0071ajW9r2Xg21qH62Dw8FKVcyd4/lEhzkOWdXLqUVd5r73SFxpcN/uVpg21Vq6OB
         tSwVg98wSWtMtikq2PyUlS9UiiEAMMu7hXMtlhxMsylnhyJKIfZrvLqT6WvT5imrtvtH
         hEPy9JSX8IgjNzYjp3Nmv3IRMRPk+rracYbvJl/n90pjdaDzld5MkqflugkBSWGSbkpj
         QGktE+UTZPsqPNUvLJDM3aqSEp9KoPFz13vYGhAmAqXkQfFo8a1pCjI3pSbvxF8G+TzJ
         HrwEx+8EB8Qx/xv+hyKA7v9qGoGoRnJ9aek0AWZnyN1pVSoMlae1oD1T9s1dodyMt2Pk
         ZGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725854755; x=1726459555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Y2XZicmIZualwCUhlDFNpSmFy2HjzR6Yh2gdcKw5gw=;
        b=CgSTnvt+P+Ng7xokd5lHutOZetQQlwn12Afgs5ByigyDDhJBL5074VmahPtaNfhSFG
         69gp31fUrbsoXoBJBst74m3reBwkThcvM8hn4ZSt/WLC/irfJU7bq29EJaccSOya0SG9
         pl3F9pJUzJGLiB8tVzPpKBS3XTMcKnd2TVIyQi11AL70bVniVMtVbJMyapAKMGIwfEol
         Q25j6Pn94mcyza+kM6N3wNng7m8BzLJtexnEW4drnVltUND/Llqa6LaCeAw3jF8pmGBa
         msvCBgYrrI2z6iDw06odTVnAdm85x23BXdMLeDw398PvGaQwA4iNAb9MrjyfR7d3Izqx
         SYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3F4SOu9RNF6Fsg01clrtVojglARZYCNR15tUzanoWZZN9VZyEV8OfKwpggoPJqaoUA9VAZ1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5cn6K3/QnfPtK2HxiWFzQ1oc4/VL3Fu9eopedQOCGh3zmXSz
	Hly5vB6NX1cO+IFxIg0+6eVM3bdsoU27eapiV/Yqf54UO29boTJxHZJhepK2xTkbnM8huDq7OkR
	psN2z/QwKaDo9Q6/e9IyErc6UjAd4wQvF7kn5
X-Google-Smtp-Source: AGHT+IEaDecNSAZTuzUTKcjIfed8c+2zGuiy9Snz3OkvQ9Wfl/mmUdiCogvvHJc2dP7/xkD/6w5lUbKgCgjZaSjV9BU=
X-Received: by 2002:a05:690c:5203:b0:6be:2044:9367 with SMTP id
 00721157ae682-6db44dc6b5fmr77199477b3.15.1725854754798; Sun, 08 Sep 2024
 21:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89503333-86C5-4E1E-8CD8-3B882864334A@theune.cc> <2024090309-affair-smitten-1e62@gregkh>
In-Reply-To: <2024090309-affair-smitten-1e62@gregkh>
From: Willem de Bruijn <willemb@google.com>
Date: Mon, 9 Sep 2024 00:05:17 -0400
Message-ID: <CA+FuTSdqnNq1sPMOUZAtH+zZy+Fx-z3pL-DUBcVbhc0DZmRWGQ@mail.gmail.com>
Subject: Re: Follow-up to "net: drop bad gso csum_start and offset in
 virtio_net_hdr" - backport for 5.15 needed
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christian Theune <christian@theune.cc>, regressions@lists.linux.dev, 
	stable@vger.kernel.org, netdev@vger.kernel.org, mathieu.tortuyaux@gmail.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:03=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Sep 03, 2024 at 09:37:30AM +0200, Christian Theune wrote:
> > Hi,
> >
> > the issue was so far handled in https://lore.kernel.org/regressions/Zsy=
MzW-4ee_U8NoX@eldamar.lan/T/#m390d6ef7b733149949fb329ae1abffec5cefb99b and =
https://bugzilla.kernel.org/show_bug.cgi?id=3D219129
> >
> > I haven=E2=80=99t seen any communication whether a backport for 5.15 is=
 already in progress, so I thought I=E2=80=99d follow up here.
>
> Someone needs to send a working set of patches to apply.

The following stack of patches applies cleanly to 5.15.166
(original SHA1s, git log order, so inverse of order to apply):

89add40066f9e net: drop bad gso csum_start and offset in virtio_net_hdr
9840036786d9 gso: fix dodgy bit handling for GSO_UDP_L4
fc8b2a619469 net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation

All three are already present in 6.1.109

Please let me know if I should send that stack using git send-email,
or whether this is sufficient into to backport.

The third commit has one Fixes referencing them:

1382e3b6a350 net: change maximum number of UDP segments to 128

This simple -2/+2 line patch unfortunately cannot be backported
without conflicts without backporting non-stable feature changes.
There is a backport to 6.1.y, but that also won't apply cleanly to
5.15.166 without backporting a feature (e2a4392b61f6 "udp: introduce
udp->udp_flags"), which itself does not apply cleanly.

So simplest is probably to fix up this commit and send it using git
send-email. I can do that as part of the stack with the above 3
patches, or stand-alone if the above can be cherry-picked by SHA1.

Thanks,

    Willem

