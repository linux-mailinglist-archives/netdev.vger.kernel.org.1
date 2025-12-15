Return-Path: <netdev+bounces-244727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E55CBDB69
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 450193014AD4
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624A228466F;
	Mon, 15 Dec 2025 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8TcCayM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2M6fEfs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC713B8D5E
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799938; cv=none; b=WfzLA2YRYgQkELKNnXN4YqZKSuXgVNQ2I95U0Yy8Oke4b55JW5/1kTmtv3qWvy+KGb7+KiXPpqY4Dv21b2qOeFB+bpXWqFiFtt3cntcI54PXUFfNVW1M9QnHla0spble+21ri9ezDOhS4IxYHCSGl23Dsu46UMXRBbVZIIVtSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799938; c=relaxed/simple;
	bh=guotCy0194cLzC70pHj5EuMDYpRWlC8/rT+WImZoKt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KLApkIB+OQ68sBrt0YF/XUqxEf/dwA3d5tMX9i3tZo1rgDZZqM0e2vE6luVsvr14CdK4KlhVzPr3EA7nH1xkpjS+vq7RK3Bq9r8DjR8Th3hxSj6I5xJqxGa0AvU00KcSDhZPBLO1lZRmH31xAPvp0l7mOqBLaNLSi9pjNzOpjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8TcCayM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2M6fEfs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765799935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guotCy0194cLzC70pHj5EuMDYpRWlC8/rT+WImZoKt4=;
	b=X8TcCayM/jhtaZDsK9a0u3cZLcN9Rg19V8VlrEFRL4mrEcM82s1QvgvLxuSwMDlY3p36nE
	XiMg6LBOx3hsd/89tO/pbxmLjdEo0rpuUByvOswtDCWPBSCflumw94gTSpsQAlv4zNHxHW
	a3njRaoMMfhE+q1J2DyS5zU8oEZ1Szc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-JveFYLQ-NCmDDpenvqaFyw-1; Mon, 15 Dec 2025 06:58:53 -0500
X-MC-Unique: JveFYLQ-NCmDDpenvqaFyw-1
X-Mimecast-MFC-AGG-ID: JveFYLQ-NCmDDpenvqaFyw_1765799932
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b73586b1195so465491466b.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 03:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765799932; x=1766404732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guotCy0194cLzC70pHj5EuMDYpRWlC8/rT+WImZoKt4=;
        b=h2M6fEfsQSXlOK6MOUk8YhhTLkB1Ck2QOL+XIYPXuZ/qeSP+VBSplbFbn2S44d9xkQ
         qF2CAJxOyPcNnIeFB9NQpd9KKK6YR5bZAso0gzRbhvB9vJovgFUJniUJtla0IVlRDt/q
         Z5Et/HgDoTg8a+S2Scv4bSdA8c9uYpcswTEICojyJksmHA4r5L4AGEr1AB4rJcIRqfsX
         E1kn5P5XHgGDNEqhKPUDFj8r+VtAxNp/Fd0rWqiRMHejs3UmvohHhnvNo5brM70DXRnk
         DzcQCn7c4sMvGOw7A06S81OCmGaaqpz1c6NQhA/yXgcz7SS4PYtAUX7aUZU3BNodtELj
         Y2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765799932; x=1766404732;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=guotCy0194cLzC70pHj5EuMDYpRWlC8/rT+WImZoKt4=;
        b=sZ9IEy3ICYNrUYGgUI7mGL7fBHyo2+K3/9Bt6rVbekb6YmRKI4A6QtMPfYmLU3Mdv1
         H0ibCNkYOFzYMk148P6xPFzcuLT3C4c12ARGQNzOT92ujAfEbPy8fd33bBqlv4blZpcl
         2+ImFbTegZAF2IpJAQ8DlDj0kcQHWfFs5xX9XpWgT7uyBXAmrVptr69HuZaHpXkxA8yi
         vj8O8avOW+XJeW3e/Vhi/6aQYI5Yp9MNuXxC8bIbQZesN8CZPJNAon5JckmGMA4cyurk
         EEf7PyYKroTxVCXIaHV3XTeDu/o48SwIgZUQlqfGGR7Tbuik69qtpl6bd+loC6w/8ygH
         cU4w==
X-Forwarded-Encrypted: i=1; AJvYcCXUjalm5/2RGazTkoe1PUE9Z20z6RCBochUSqIJJL9VNpVm0BKzADV8rP1DxzZmhO7HCK55X7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD9yaHoBiiwh79XUYw1DXq4MbL9tMF/XgbbW6J+XXKza+2E9Th
	vbQFzGSVsOkOSW+7PIcXoK4HgPJ8q0nZdiYscbuSPi2LphzyjI3EdsPky1lJyiwByjYXJLqljrZ
	iErtS++dZbkKiSmez6pH+1GB1R+WgMf4dqbmqmsWvBsQY3tb8HIpkc5U7Lg==
X-Gm-Gg: AY/fxX6Qqcnmm/MOME4Bxn28f4bP0c2eqmNccFfJEqFZK5dvTeow5c/KWJRW9wDsPRq
	SBp73kNGkPOwxoTcuyPSlIt/+uu0KFtsR8mBZT7M2B6BjiQav3cUFWSdoKvRya1iuFcj4ezVOpf
	TbXTEGsISnLGtGzRUXA2ZGxkmh0Yjp7qYhuzRAohkJ1T8HKwM1sg2mOxxb4R+0b12ajQaXJXmMa
	XCql9tyy/UM3cV2b1e/oDG4S/s+WrxiVPqvWkKq2SQP6j3WVFNmaBX3uhoMQD22Mh0j1IGi6+us
	XZXVm01KvCGFaaNnjW12rQei31sj485KgA5qWRX5wc//BYcEvtr5uY/3BLHWhS8tiLTFcFxz7qI
	veUIFQAAyLQhepUxrw7RhnJqX7VGkXS3Ipg==
X-Received: by 2002:a17:907:7f27:b0:b79:c879:fe71 with SMTP id a640c23a62f3a-b7d23a47753mr1053692866b.19.1765799931613;
        Mon, 15 Dec 2025 03:58:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGfQdnmh2NiKRa5TKiNNlZrL3SrpWa6AGxFoFl+9Jh1AR1ollmR886h8HGExPdpWLO/HacCg==
X-Received: by 2002:a17:907:7f27:b0:b79:c879:fe71 with SMTP id a640c23a62f3a-b7d23a47753mr1053686466b.19.1765799930356;
        Mon, 15 Dec 2025 03:58:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa5d0b20sm1403931766b.64.2025.12.15.03.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:58:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D53143CFA67; Mon, 15 Dec 2025 12:58:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eelco Chaudron <echaudro@redhat.com>, Adrian Moreno <amorenoz@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Alexei Starovoitov <ast@kernel.org>, Jesse Gross <jesse@nicira.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH v2] net: openvswitch: Avoid needlessly taking the RTNL
 on vport destroy
In-Reply-To: <198C2570-F384-4385-8A6B-84DCC38BB5F5@redhat.com>
References: <20251211115006.228876-1-toke@redhat.com>
 <198C2570-F384-4385-8A6B-84DCC38BB5F5@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 15 Dec 2025 12:58:48 +0100
Message-ID: <87qzswklc7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eelco Chaudron <echaudro@redhat.com> writes:

> On 11 Dec 2025, at 12:50, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>> The openvswitch teardown code will immediately call
>> ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notification.
>> It will then start the dp_notify_work workqueue, which will later end up
>> calling the vport destroy() callback. This callback takes the RTNL to do
>> another ovs_netdev_detach_port(), which in this case is unnecessary.
>> This causes extra pressure on the RTNL, in some cases leading to
>> "unregister_netdevice: waiting for XX to become free" warnings on
>> teardown.
>>
>> We can straight-forwardly avoid the extra RTNL lock acquisition by
>> checking the device flags before taking the lock, and skip the locking
>> altogether if the IFF_OVS_DATAPATH flag has already been unset.
>>
>> Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
>> Tested-by: Adrian Moreno <amorenoz@redhat.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Guess the change looks good, but I=E2=80=99m waiting for some feedback fr=
om
> Adrian to see if this change makes sense.

OK.

> Any luck reproducing the issue it=E2=80=99s supposed to fix?

We got a report from the customer that originally reported it (who had
their own reproducer) that this patch fixes their issue to the point
where they can now delete ~2000 pods/node without triggering the
unregister_netdevice warning at all (where before it triggered at around
~500 pod deletions). So that's encouraging :)

-Toke


