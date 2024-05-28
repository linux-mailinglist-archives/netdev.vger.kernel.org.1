Return-Path: <netdev+bounces-98695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329548D21C3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D60B2414F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6DA16D4FF;
	Tue, 28 May 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2vVLlGU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2AA170821
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914322; cv=none; b=f/0nn3c+2+bWrs0qAqYgwWbHHD5bj2gnHz3Sn16A6nJFr1KldsCTfb3CIY3ME98gbUJoq9wGtPwtAozgPc/Xw2vEGcAX9n4zYe+Zt1TgmFNHkAbOvjwcZbyzo1BnwyunIIdZzBJL/sNn5q8Cl7BhM3iOHpfWonMT5lLTxxgDkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914322; c=relaxed/simple;
	bh=vLN2BaDwrlAwuwEYjaJlHgtpy0dmxixTxudu2ogMhPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHvU5iO9vc2m+1vAQS8kl+FjTeDJmGD+V23635/P1wy8SIs3xRuOG5atzEMme0RH6qdfmjPyTYmtnRD6kW3zQk6jelt+5qa7tPwihfWLOnI7KoFSeJfJpojybVOoOzzr8MdfywMKmPCH8XLawxPeZb/F0L7JHLuA0WCxwLF2+Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2vVLlGU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716914319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLN2BaDwrlAwuwEYjaJlHgtpy0dmxixTxudu2ogMhPg=;
	b=S2vVLlGUBcUvPxAcmmGYJn5rZdg1Z4Fg/TJhu+bsoIz0N8G3B//JAZZ8IgJsYH/ioRM68z
	YwdJrXBj2ENOl6BPnVoLZeqQzNP4iYekpybjcrrAzkLRxvyIw7uTlGBgA5MnIde8cWCP9A
	qV672IizqfCYpS45m4zHmXOquY/4K70=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-bqPmeFAFMRiti5hu7jRhjw-1; Tue, 28 May 2024 12:38:38 -0400
X-MC-Unique: bqPmeFAFMRiti5hu7jRhjw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-354fc05816dso635502f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716914317; x=1717519117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLN2BaDwrlAwuwEYjaJlHgtpy0dmxixTxudu2ogMhPg=;
        b=gbAZsRIMR3cDM/hDp3EcZD/CkP4tV5pMYThI+GrPb6+6aABo+ejpIIRyvSywCxnAMy
         Xs8VvzSRH5qcmOAbgqK4F1IvTEAw5zEMPZvEDRyDaOyJyw+nXeMYkdALYjOsa8vM0AeS
         v0KvINOXauFeF8rQH7SZTJTdvOdCmZXjWOEgguGRvUUXmhW7JZCNMyjDMaGrOPe7lNaB
         a8TM87dYq1UVPQqAI3KFx+Md70vUxtT0sOT/AIpVp5hihjqJuUlo7eyGrsve/gCdmGXX
         CFa2py5rCvFqY9ZOg76xDoaj5TjNKVfgFQrz1WprmzbGFBsndUxb5DeE/3pmoEM6ydFU
         ORpw==
X-Forwarded-Encrypted: i=1; AJvYcCWu2eOJc0WMYXPwiobzSmVwLqr/KwHJlL/txaYLE85FwyDeYAEKnJVBPd99fGmWPR/H1i7xhuXAENHgCj8qFpN5OaRZo2H0
X-Gm-Message-State: AOJu0YzI0nxsrbWQbmTrhlRzng3d5hbNIbs0xh+sn++zWkYG2gMlZpn0
	D5VropD25yrwvXUBHhGdGskR9SfFCrjVPS93p1ZsxH2lr3/F3tEBIzmbZviEUggVbOjGzAp/0p8
	LVe1cYiVpaOKFYRQjUOs+yNQECJ+atTm8mtqjfbb8NjAA2Kufa4JAMlPFCPLUDHjWBKKX+VUFG3
	tblo0tQgOYpoiwIqqW5DmBJhuT44aR
X-Received: by 2002:a5d:4485:0:b0:357:7ae3:2de4 with SMTP id ffacd0b85a97d-3577ae3329dmr6214041f8f.26.1716914317210;
        Tue, 28 May 2024 09:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk5arn3m/7l032st6t5757/0oqsN6ZwCY+wuS7zQHVrYlAnd9RQ4SAOuKxztBIeXVlao5+naAjeWSM6dN+80M=
X-Received: by 2002:a5d:4485:0:b0:357:7ae3:2de4 with SMTP id
 ffacd0b85a97d-3577ae3329dmr6214023f8f.26.1716914316802; Tue, 28 May 2024
 09:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFfO_h7xsn7Gsy7tFZU2UKcg_LCHY3M26iTuSyhFG-k-24h6_g@mail.gmail.com>
 <4i525r6irzjgibqqtrs3qzofqfifws2k3fmzotg37pyurs5wkd@js54ugamyyin>
 <CAFfO_h7iNYc3jrDvnAxTyaGWMxM9YK29DAGYux9s1ve32tuEBw@mail.gmail.com>
 <3a62a9d1-5864-4f00-bcf0-2c64552ee90c@csgraf.de> <6wn6ikteeanqmds2i7ar4wvhgj42pxpo2ejwbzz5t2i5cw3kov@omiadvu6dv6n>
 <5b3b1b08-1dc2-4110-98d4-c3bb5f090437@amazon.com> <554ae947-f06e-4b69-b274-47e8a78ae962@amazon.com>
 <14e68dd8-b2fa-496f-8dfc-a883ad8434f5@redhat.com> <c5wziphzhyoqb2mwzd2rstpotjqr3zky6hrgysohwsum4wvgi7@qmboatooyddd>
 <CABgObfasyA7U5Fg5r0gGoFAw73nwGJnWBYmG8vqf0hC2E8SPFw@mail.gmail.com> <sejux5gvpakaopre6mk3fyudi2f56hiuxuevfzay3oohg773kd@5odm3x3fryuq>
In-Reply-To: <sejux5gvpakaopre6mk3fyudi2f56hiuxuevfzay3oohg773kd@5odm3x3fryuq>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 May 2024 18:38:24 +0200
Message-ID: <CABgObfb-KrmJzr4YBtuN3+_HLm3S1hmjO7uEy0+AxSDeWE3uWg@mail.gmail.com>
Subject: Re: How to implement message forwarding from one CID to another in
 vhost driver
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Alexander Graf <agraf@csgraf.de>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 5:53=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Tue, May 28, 2024 at 05:49:32PM GMT, Paolo Bonzini wrote:
> >On Tue, May 28, 2024 at 5:41=E2=80=AFPM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> >> >I think it's either that or implementing virtio-vsock in userspace
> >> >(https://lore.kernel.org/qemu-devel/30baeb56-64d2-4ea3-8e53-6a5c50999=
979@redhat.com/,
> >> >search for "To connect host<->guest").
> >>
> >> For in this case AF_VSOCK can't be used in the host, right?
> >> So it's similar to vhost-user-vsock.
> >
> >Not sure if I understand but in this case QEMU knows which CIDs are
> >forwarded to the host (either listen on vsock and connect to the host,
> >or vice versa), so there is no kernel and no VMADDR_FLAG_TO_HOST
> >involved.
>
> I meant that the application in the host that wants to connect to the
> guest cannot use AF_VSOCK in the host, but must use the one where QEMU
> is listening (e.g. AF_INET, AF_UNIX), right?
>
> I think one of Alex's requirements was that the application in the host
> continue to use AF_VSOCK as in their environment.

Can the host use VMADDR_CID_LOCAL for host-to-host communication? If
so, the proposed "-object vsock-forward" syntax can connect to it and
it should work as long as the application on the host does not assume
that it is on CID 3.

Paolo


