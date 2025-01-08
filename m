Return-Path: <netdev+bounces-156257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0128DA05B9C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCD4165C07
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C071F9439;
	Wed,  8 Jan 2025 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpOUDf0w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717E1F8667
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339279; cv=none; b=E3T+VS1/eIJMPJ/Vd6Aexge9V0Wv3z5ks1qbRbKcgcMXYjsG7boMUmu3mbjnEGwdDeXTJwjU4ALYX+rI+ZuZ8f2fk0SVqHqhuvVIEsq8ASbEY2uLB7pQ1kgHK7Xl4E412Tbo1w9HqlX2vbdhrIECfG43hw1sN0cw302Y7+Yk6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339279; c=relaxed/simple;
	bh=XnLemeL4IHrhEImF6ctGxz/BFHYds4mn0cQmO+AnjTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWLyWXNGKICixZ8wca1l87ILpFKFLmJ1BSvy3YSOL5z8j5ies+osL1bIPi80Vs+RGtA4e8lviSVnh3f6Zcc+YcQLqs2v8/oBjOUzGGab4xzdARcdBRC9jrCpt18sFrpRGReiIRlXnC5R+SOh8QLQ7FXcBhB2nFqR90Jlypb3zak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpOUDf0w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736339276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CE+ieq2Nnj1SjMfQGTDo5V1UJ6zv6x6ViYgzrgENqg0=;
	b=dpOUDf0weDhWqHhyoIzZsqpSsrMU71Q4LyvD90jEJshrFb6O9TY+fmWghIBO40Wek3dggv
	3mouxbHkQtP3oxIZbB0ENuLmu77Jssqvnacifiy+5/PDGE3YQT9wwBtx0lm0/ava6YOKgw
	nod38Bq5JunEmbNPagDIbHLLSvFKyp0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-XKN9bYAcNV2YaV0JKRTCRg-1; Wed, 08 Jan 2025 07:27:55 -0500
X-MC-Unique: XKN9bYAcNV2YaV0JKRTCRg-1
X-Mimecast-MFC-AGG-ID: XKN9bYAcNV2YaV0JKRTCRg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso112989445e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 04:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736339274; x=1736944074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CE+ieq2Nnj1SjMfQGTDo5V1UJ6zv6x6ViYgzrgENqg0=;
        b=VILZO/w53NcNjmovXK9lWpl6YEEDiIM3Uq42LV8YEintwlFKIg5M9QHkODPC2p4VS1
         pf1mXXFN+j6mjtNIs+rJcyqj4qrUwZ2g+PB0+FHnKPMiQ0jFLY8ff7tMM+PmVb9schtX
         hzib0jS9U0vJe4ADeY4+rXfD2ecTv3Op4iO8/HrIWaayp7AMR/hLeLdpD2UvG4XR82+3
         cuEzPngoOiM4lDQMYXUp3atK90hshufltwniU09jYCy6RVhPGF0qHR3BB8WcjB35VBRK
         TIj8foaWGVXPH2BvPF5iziv6o6a5cY7a7GRoDCYfEMV+ner8wfIVV5gqh8T1lYZFGsaw
         fYAA==
X-Forwarded-Encrypted: i=1; AJvYcCVc0dmU4pCm+Y6wR/c1S+Yri9fMmBlT6tPAjdYiiJx9H4F78XrG5oSdRUOENwRlQIfMe2T6u0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6SGv2jMwODS/8zLf8CYeFXFoRniYZuH3hRKgSFKQX5W2V+xP
	ingWZj3RZ0pZS/XjiJleVmePnlsTtd0imWuHmwHnGBLiq1HGDChJfrxp5Nh5VOM2oxdUt829c5S
	bKr3GtaGJcUpyNkKWr8aL8SbkcQvN8UEc2U7k5GblT8kH0OroyqIK6Q==
X-Gm-Gg: ASbGnctGS6JPiVDb91ynf4V3w4sIe3f7U7YMbv247E74m1tTEDeEFSOj7slRjyyquG9
	fJGXr9RHn89j38N6CyrxpsQIzbr5tlfXiVzc+LuUqRdkfDlqF4RkLal51CmcOvoNwQLbtqzBJ9B
	qTd80wm+DJeinXjwQwV+C7ALJJvivAV6jJ7ccZVIfaiCHjeYCPwSLEyXIAzBLr+o9uAu19NSC45
	uxkSI0yOJeqhD2BWd/KpMkVGNOKpcjN+VwnUwBHbgg8Vuf+1Uk=
X-Received: by 2002:a05:600c:511f:b0:436:1b96:7072 with SMTP id 5b1f17b1804b1-436e26867f6mr21830925e9.5.1736339274303;
        Wed, 08 Jan 2025 04:27:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENxKhGDHesgYkFwNwBJXCiFFCpFk4h9OPIuCpP1RPQAdqKF9uWZeo5HUnJYIpAberSrBMGeQ==
X-Received: by 2002:a05:600c:511f:b0:436:1b96:7072 with SMTP id 5b1f17b1804b1-436e26867f6mr21830685e9.5.1736339273849;
        Wed, 08 Jan 2025 04:27:53 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89dfesm19211805e9.32.2025.01.08.04.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:27:53 -0800 (PST)
Date: Wed, 8 Jan 2025 07:27:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dsahern@gmail.com" <dsahern@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"horms@kernel.org" <horms@kernel.org>,
	"pablo@netfilter.org" <pablo@netfilter.org>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>,
	"salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	"shaojijie@huawei.com" <shaojijie@huawei.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>,
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
	"g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: Re: [PATCH v6 net-next 11/14] virtio_net: Accurate ECN flag in
 virtio_net_hdr
Message-ID: <20250108072548-mutt-send-email-mst@kernel.org>
References: <20241227191211.12485-1-chia-yu.chang@nokia-bell-labs.com>
 <20241227191211.12485-12-chia-yu.chang@nokia-bell-labs.com>
 <CACGkMEu990O+2Sedj+ASv0P5TnZR9THiOdHmx=L0hOxQRXPcsg@mail.gmail.com>
 <PAXPR07MB79849952690901A50688EFEDA3092@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR07MB79849952690901A50688EFEDA3092@PAXPR07MB7984.eurprd07.prod.outlook.com>

On Mon, Dec 30, 2024 at 09:50:59AM +0000, Chia-Yu Chang (Nokia) wrote:
> >From: Jason Wang <jasowang@redhat.com> 
> >Sent: Monday, December 30, 2024 8:52 AM
> >To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> >Cc: netdev@vger.kernel.org; dsahern@gmail.com; davem@davemloft.net; edumazet@google.com; dsahern@kernel.org; pabeni@redhat.com; joel.granados@kernel.org; kuba@kernel.org; andrew+netdev@lunn.ch; horms@kernel.org; pablo@netfilter.org; kadlec@netfilter.org; netfilter-devel@vger.kernel.org; coreteam@netfilter.org; shenjian15@huawei.com; salil.mehta@huawei.com; shaojijie@huawei.com; saeedm@nvidia.com; tariqt@nvidia.com; mst@redhat.com; xuanzhuo@linux.alibaba.com; eperezma@redhat.com; virtualization@lists.linux.dev; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
> >Subject: Re: [PATCH v6 net-next 11/14] virtio_net: Accurate ECN flag in virtio_net_hdr
> >
> >[You don't often get email from jasowang@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> >CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
> >
> >
> >
> >On Sat, Dec 28, 2024 at 3:13 AM <chia-yu.chang@nokia-bell-labs.com> wrote:
> >>
> >> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >>
> >> Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the ACE 
> >> field to count new packets with CE mark; however, it will be corrupted 
> >> by the RFC 3168 ECN-aware TSO. Therefore, fallback shall be applied by 
> >> seting NETIF_F_GSO_ACCECN to ensure that the CWR flag should not be 
> >> changed within a super-skb.
> >>
> >> To apply the aforementieond new AccECN GSO for virtio, new featue bits 
> >> for host and guest are added for feature negotiation between driver 
> >> and device. And the translation of Accurate ECN GSO flag between 
> >> virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is also added to 
> >> avoid CWR flag corruption due to RFC3168 ECN TSO.
> >>
> >> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >> ---
> >>  drivers/net/virtio_net.c        | 14 +++++++++++---
> >>  drivers/vdpa/pds/debugfs.c      |  6 ++++++
> >>  include/linux/virtio_net.h      | 16 ++++++++++------
> >>  include/uapi/linux/virtio_net.h |  5 +++++
> >>  4 files changed, 32 insertions(+), 9 deletions(-)
> >
> >Is there a link to the spec patch? It needs to be accepted first.
> >
> >Thanks
> 
> Hi Jason,
> 
> Thanks for the feedback, I found the virtio-spec in github: https://github.com/oasis-tcs/virtio-spec but not able to find the procedure to propose.
> Could you help to share the procedure to propose spec patch? Thanks.


You post it on virtio-comment for discussion. Github issues are then used
for voting and to track acceptance.
https://github.com/oasis-tcs/virtio-spec/blob/master/README.md#use-of-github-issues


> --
> Chia-Yu


