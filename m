Return-Path: <netdev+bounces-114372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E452F9424CB
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 05:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B931C214F2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3C17BB6;
	Wed, 31 Jul 2024 03:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJi8qm41"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FA2F22
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 03:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395600; cv=none; b=pVqKJ42qkmYxlXau/4yOnjzHldBOjV1S4bbb8bXk/y8OFnwbxxKfI488pcGN//tQKSxgEvzNB3BBsmYvtASLkEPdnosDszb9WtsNejSKvBTy5KK3vsWsvUos67mcyEmabPVns9QMIkYkgcPQ6PCMMP46ThF8egnlndfvmc3BsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395600; c=relaxed/simple;
	bh=2QXPLbv8fw3NvYw8Bln5EqfyJklqNgMg6tLmX+z8Ai4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVvRwgmkdeKIvewOiWtsZp/vLEMnNnOVz+ihf85qbS2NSzCZtpAtzC/k+ubv9elarxWERAKSi8yCBCij40uxTBFnioKbn+V9bCCIamdwiXJ7aLfmvw6zhR6WSUgk+iHJz5dJFRQ5LJWs/i9Dyiu9n9iN8g/YXhohF0oUHSJquMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJi8qm41; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722395597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QXPLbv8fw3NvYw8Bln5EqfyJklqNgMg6tLmX+z8Ai4=;
	b=jJi8qm41fiEaeN0xtno+cGvPp4rEdQBNeT+0VvZWtbmtaW3/sqnZvmxEXIyw1yBXLXGb6C
	YABNzuWRrNo9Z2LP7QA4Kio+FRu6l6a7AOoXzX3bOsP/nhd7gsy/j5YOzLoOCixBuukyjd
	k2GNkaQPqJP+yYPO7TWpmtF+2NIry8o=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-jbglU0qRPfScWfMorqkDVw-1; Tue, 30 Jul 2024 23:13:15 -0400
X-MC-Unique: jbglU0qRPfScWfMorqkDVw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7a242496897so3934800a12.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722395595; x=1723000395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QXPLbv8fw3NvYw8Bln5EqfyJklqNgMg6tLmX+z8Ai4=;
        b=uutSkdDSGV76GB+Ac0C9yKJ1AAoGlxa660CdcaBP2H9xqcT3rSNhoCptFaBJ5mmfJn
         6H/4yPnXUR48jG05BPjgxLz+ReWhqmUJYIGQJfAsgqK3GQZlehI9Xiw8NGl+H4BP1H3O
         PSp2TAViuVf/Lcz0YyCvw44PVPMrdBMIC2rU4716dJqevrMU387erCKXUV2uZjn2pTfX
         yzHvqPqZxk9kv2b3i1CkF/9hPV4Qed5cwYZ0BGcF2oIGaq5q/JHk+Q40ahFMcvjpz60Q
         AD5RAP2+lKfJvAAYdLWeaM6hoHzqodximjs8JAPyxyTLEMWFK+8/ec/FzwqggRftR0T0
         yG4g==
X-Forwarded-Encrypted: i=1; AJvYcCUdQWd1ChTcOo3GtoIAIjp+ffcTHSeLhAy4WWSwwm009Ow3YCRsmeahT5NArYsr4+FVl2bOe4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZpw0HK7ZzWcEwL4sqESVzzVe8/iuN6YgxFuLdcNSxdUiL5Dd
	E/rbjKplK/bJvZYMoxYquDMMlsAjzUyyL2y7r2TK0KdTJcr1P70sK9TWEhj/FBFw8JLyc/zC/PS
	aKXnJySNzWxdesF6NgjSl/2/3ovTk3+RIatVi1kN16F2zLKYdhJiouIOOyxDQSQdwJiA9/tVwY6
	EvhajxgHRAVugrEeAZHzGHaQE63KqM
X-Received: by 2002:a05:6a21:6daa:b0:1c4:8293:76db with SMTP id adf61e73a8af0-1c4a12f65eemr13100310637.29.1722395594833;
        Tue, 30 Jul 2024 20:13:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvWLIEukL31v5QVulnv3XiOgnyvuE+tF13uwsuSJxLKEt/9oZ3s6vbViz6RDp5OX0m0i/Kp92DHcVMBTzewS0=
X-Received: by 2002:a05:6a21:6daa:b0:1c4:8293:76db with SMTP id
 adf61e73a8af0-1c4a12f65eemr13100287637.29.1722395594365; Tue, 30 Jul 2024
 20:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729124755.35719-1-hengqi@linux.alibaba.com> <20240730182020.75639070@kernel.org>
In-Reply-To: <20240730182020.75639070@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:13:03 +0800
Message-ID: <CACGkMEuxvLVLuKCLNi2eBy5ipzNn+ZGM+RSRBXk-UA0bJCKgZg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 9:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 29 Jul 2024 20:47:55 +0800 Heng Qi wrote:
> > Subject: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescin=
g commands
>
> subject currently reads like this is an optimization, could you
> rephrase?

It might be "virtio-net: unbreak vq resizing when coalescing is not
negotiated" ?

Thanks


