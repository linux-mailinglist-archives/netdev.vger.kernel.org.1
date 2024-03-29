Return-Path: <netdev+bounces-83237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A2F8916F7
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B5AB246F4
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1256D69DE4;
	Fri, 29 Mar 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRrx67IV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792C657B9
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708813; cv=none; b=IvKQ2gGLtzb2TmmYV4jcDIeahI7SIN2bIH3YhVt0phoOcX/e+8bxvJtK6yLwJIEihHoowMLOz4jY0VQATCVHMw64+NlZgkAcMXt2liYisSpB8bY7RDXW5gBs2lVGpGDs80uwoHVWMqupiwH06XjdT4Z10bBk/uUV4Ga4RrJI54I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708813; c=relaxed/simple;
	bh=aWlw1knI6iA9pHb6F2hZMi+1qAncr3KP7cFanst0N6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrMNFDMbHe+LZBblLP3HwWx38fqJB5yTmqLZxCQR8nRU0rxfN2H+jBmJ5nO7z4zIhnbcul3+6iETJK1QrBJDhg33+ICTa1VIfZQfdb2vkJGYOYU/FlqjtxbyyKbVeAGFc2BD0+tryaf+jZGc2zc76e/u2I2U65Hmf+sqi2NxLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRrx67IV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711708810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWlw1knI6iA9pHb6F2hZMi+1qAncr3KP7cFanst0N6Q=;
	b=SRrx67IVrGohXtUl+FNcC0shaTpowqDlzwMhNW+OXBcRwyQ/S1N/RwVVH/C7gapXiZHjiq
	WhN3zjUZpuFOZKUOb6az7PtDBDTWZ3LVqSebUtoIsW0LUeGvNoAqb2mamO2/BX5ydx3nKu
	y8XARQFh0hYcSnN7VDxOi3q/PNDAuC8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-Ca6k6mKcPje80dlvQLI7Gg-1; Fri, 29 Mar 2024 06:40:08 -0400
X-MC-Unique: Ca6k6mKcPje80dlvQLI7Gg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29df9eab3d4so1649287a91.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 03:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708807; x=1712313607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWlw1knI6iA9pHb6F2hZMi+1qAncr3KP7cFanst0N6Q=;
        b=iaKFGKeywC0IF8vzT7scQXa7LFjXNmercm+t9aCWu44DYrF99/T/Blv1W/R00mH8lX
         cIq68NrsYECfCpSPoXRc/pHMIX0cCi47BIua5hjGeghWg+07vJyrhWHyE71ffcQ58fkB
         3857jGxxh87H/Vm5k6kN0mWCpXl6Wkh7aKpPD8eXeT7il2n4O8ippnX//rlgECUJYlMs
         fVD3+Fuu1M5pjBjCXCHUTFT1/nKwvzaPsbGNScu2iI/eUum7AwknP9QbY/ZU3kgfQsO8
         F5BV5yo0nM0ahjurHXCbzo3MBhCcAknotL04rOvJz8qF2zA9daEsdBnRJeVfimp86zY1
         Thiw==
X-Forwarded-Encrypted: i=1; AJvYcCVJW3JWBeEtQ+fZieMMvFJKtiFyIHomgWhuiBGA4S9rvzTJYcTfLx5a4IpOdQwsnA3jOeT4D7C7ugYhqXJubivVTXBmP1tK
X-Gm-Message-State: AOJu0YySbVErwMjVANLmef8Fa9oELdKFCX+LXA+N2V++5OaVmN6TjZ+u
	HvRx82TtTTtnP5k3J3XwasxBzMi8iMs8kuXZDP3Dx6BkfibumEepEaipqe5wOeMm8vaoG3wIkcy
	hGVLvwNvuXfWBwW4NeRTYARN+oWXDsEafuW9JuFNpCshgOlBlAJ1jhlgtGUJ4xk0fWfKiCnE8Ll
	AlRMpto/TjAg2SrPDrlwqKD9UB9ghq
X-Received: by 2002:a17:90b:8c6:b0:2a2:9f6:759e with SMTP id ds6-20020a17090b08c600b002a209f6759emr1875598pjb.20.1711708807069;
        Fri, 29 Mar 2024 03:40:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb2wOAwuZXQWgzWL66EpG6vLDeyAJyD0oneTmmJW/T8q+bGhu652fGejrNwbcPHG3zyYzfHXasccYzy+nbzx0=
X-Received: by 2002:a17:90b:8c6:b0:2a2:9f6:759e with SMTP id
 ds6-20020a17090b08c600b002a209f6759emr1875582pjb.20.1711708806789; Fri, 29
 Mar 2024 03:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101912.28210-1-w_angrong@163.com> <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
 <CACGkMEuM9bdvgH7_v6F=HT-x10+0tCzG56iuU05guwqNN1+qKQ@mail.gmail.com> <20240329051334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240329051334-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 18:39:54 +0800
Message-ID: <CACGkMEvdw4Yf2B1QGed0W7wLhOHU9+Vo_Z3h=4Yr9ReBfvuh=g@mail.gmail.com>
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Rong <w_angrong@163.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Mar 29, 2024 at 11:55:50AM +0800, Jason Wang wrote:
> > On Wed, Mar 27, 2024 at 5:08=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Mar 21, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > > > From: Rong Wang <w_angrong@163.com>
> > > > >
> > > > > Once enable iommu domain for one device, the MSI
> > > > > translation tables have to be there for software-managed MSI.
> > > > > Otherwise, platform with software-managed MSI without an
> > > > > irq bypass function, can not get a correct memory write event
> > > > > from pcie, will not get irqs.
> > > > > The solution is to obtain the MSI phy base address from
> > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > then translation tables will be created while request irq.
> > > > >
> > > > > Change log
> > > > > ----------
> > > > >
> > > > > v1->v2:
> > > > > - add resv iotlb to avoid overlap mapping.
> > > > > v2->v3:
> > > > > - there is no need to export the iommu symbol anymore.
> > > > >
> > > > > Signed-off-by: Rong Wang <w_angrong@163.com>
> > > >
> > > > There's in interest to keep extending vhost iotlb -
> > > > we should just switch over to iommufd which supports
> > > > this already.
> > >
> > > IOMMUFD is good but VFIO supports this before IOMMUFD. This patch
> > > makes vDPA run without a backporting of full IOMMUFD in the productio=
n
> > > environment. I think it's worth.
> > >
> > > If you worry about the extension, we can just use the vhost iotlb
> > > existing facility to do this.
> > >
> > > Thanks
> >
> > Btw, Wang Rong,
> >
> > It looks that Cindy does have the bandwidth in working for IOMMUFD supp=
ort.
>
> I think you mean she does not.

Yes, you are right.

Thanks

>
> > Do you have the will to do that?
> >
> > Thanks
>


