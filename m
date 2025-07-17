Return-Path: <netdev+bounces-207860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A42B08D11
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0B1188A210
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558972C324F;
	Thu, 17 Jul 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSVqWnuN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515182BD005
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755789; cv=none; b=Ik5luHastG6awSkarHsAS1I2sXiXqDP8kmxD4ru6UMORCJ3QqpDv12OLvxyRRW5tMqZynqLZZVpaqghzHGQ42KD35BBwdXxreHPuqGwop29CV6/RZJpxuwyUMFubbtKyxV8NS5tNyuLv0GuqTzMGQuoqO5yedm9JwrIKq3xkzxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755789; c=relaxed/simple;
	bh=Wtc/lxX5coOhUl/u4HrUWPOM3H90E0+70wFaxMF7Z0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOU1k4hDhj6JqFIP1OFwkxx5xvPQI7iCUzU14tKMKr/fE495K4w2tlEpp4hJu86B8pX59TYzoK7tZM0Hh12ElXB4VhQ0CTxWVTP90j96cCjhnW3fdDyUTFAPLduqWWQGvDsUbpKnR0sOq6+vH9wxCHP3yCy5cFpcyxky9y982sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSVqWnuN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752755785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjmlDzzaGZ9rTLi5Kx9j22e46U0IOmOFefScvfSSAnA=;
	b=FSVqWnuNcPvNnKnY3N8jMHbCsdEEo/ACy3UY6IH2IkX8F4nq597oJiM+PojXsuZtNNLSC+
	9Aoo1/IQ/tjIu+PBwxvTMzPkzXUQ+PDkkVAAh5KpoXxaI0p0R40ToneBb0xGSpodmMZWNb
	YvqFoFBAVNHRyj+niGv8Pk8JJW0bOIo=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-UgCVLfW_Pw-gZ8didrbTCQ-1; Thu, 17 Jul 2025 08:36:24 -0400
X-MC-Unique: UgCVLfW_Pw-gZ8didrbTCQ-1
X-Mimecast-MFC-AGG-ID: UgCVLfW_Pw-gZ8didrbTCQ_1752755784
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e8bb64e2bd6so1252172276.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 05:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755784; x=1753360584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjmlDzzaGZ9rTLi5Kx9j22e46U0IOmOFefScvfSSAnA=;
        b=V6sTzJUXOQ2F1GGShSqNnxuCmtesykAlu3Z7R9oVTh+PQGjfgAGR4D1RtAvXI5S89p
         AWFYTX9KjxsCW34Oky9K+5LeblBfISFSRDmT/+ypifDEYidr8/erjEeRNcfmEysqYiIW
         ssQYUck/eZWZ+0yHYHL74ZwGzWBK86bGCGixopi4byPupWyibZ1PMfEzCdvra86s9CZW
         VfMmDo3Lt+5A5yijK1TQRCBRAS0CaXtl1Zq61CEhfDfeEQBTeG97qTzfdBtsrb7rZIax
         9U7RmaTB0BOra8vzwOhe1U9vrre87vosmsIm9ePP2pKaqE32pYZ9S5XdbMwvtUMUALFE
         jWog==
X-Forwarded-Encrypted: i=1; AJvYcCXit1bh8h5Ch9CTTzrAAtf4dK/AHuPGu0LkaNZRhgM0vvlC2m1nqpyoSH3IYXE3PoPKyY9BeKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj6Agn2BeWqu4QleLM2d3ytBk+h/Teke49Jepxg8nLJVeVQzlA
	k8szqBXHkKOvp+wOsnhak9uxlfMiJ5huBxuExkRUrcK4eUd+J0HhdVv5jx7DkYTxoCnyR40SxdK
	q3rB2Efu7kuuuZnm8zZ1C1T/hqbFYptAuZdcBAw/BPpaa+ewZU//gcnpU0km2XDvgTBacqYgVl6
	9oTpkzOH7hD5LdzzHSFtbAIBPPt5KQ2lC4
X-Gm-Gg: ASbGnct7HySuo9lpSV8SvwRyHLEVo8AJHGwejGsHNpS8VMr4dWb/J4P96AxFDclKKFX
	yEqGlDyWu5cmKkm9GRtDgVU4eCqUnRKSg1hIOZEuEPWufzw0u9UvVX9Xt2pQZmICyRn2CWIc2hZ
	WwcbGolKwsFy6nbiI/S15c
X-Received: by 2002:a05:6902:248c:b0:e8b:bd51:f499 with SMTP id 3f1490d57ef6-e8c56d62b9bmr2917311276.15.1752755783740;
        Thu, 17 Jul 2025 05:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmzgzsBFJaqPrJKGrgO7xxomhF5mMyGas/UFwKiQJ4GPBsQUpF11VlQotlrI8QAyk5b0oSkOjaa9152R8A3Zc=
X-Received: by 2002:a05:6902:248c:b0:e8b:bd51:f499 with SMTP id
 3f1490d57ef6-e8c56d62b9bmr2917267276.15.1752755783217; Thu, 17 Jul 2025
 05:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717090116.11987-1-will@kernel.org> <20250717082741-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250717082741-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Jul 2025 14:36:12 +0200
X-Gm-Features: Ac12FXzyUippo4ZuOkqcubjMy-uJlrmKG3BS-ASFjib8nJb-gGmmbC75MdR5_BE
Message-ID: <CAGxU2F6Jt0zT==4KfqCnC2nhptypZaEjOYt7ufeYDWdm-c3uJA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] vsock/virtio: SKB allocation improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Keir Fraser <keirf@google.com>, Steven Moreland <smoreland@google.com>, 
	Frederick Mayle <fmayle@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Jul 2025 at 14:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 17, 2025 at 10:01:07AM +0100, Will Deacon wrote:
> > Hi all,
> >
> > Here is version four of the patches I previously posted here:
> >
> >   v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
> >   v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
> >   v3: https://lore.kernel.org/r/20250714152103.6949-1-will@kernel.org
> >
> > There are only two minor changes since v3:
> >
> >   * Use unlikely() in payload length check on the virtio rx path
> >
> >   * Add R-b tags from Stefano
> >
> > Cheers,
> >
> > Will
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> Who's applying them, me?

It's pretty much only about virtio/vhost, so I think yours is the right tree.

I completely reviewed it, so it can go for me.

Thanks,
Stefano


