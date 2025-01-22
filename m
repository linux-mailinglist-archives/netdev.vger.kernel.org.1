Return-Path: <netdev+bounces-160205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074AFA18D20
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 08:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D827C188B07B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A171C3029;
	Wed, 22 Jan 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUTSDdnj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8D1A8F98
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737532410; cv=none; b=R4rVOUDu45eZGaxQqcBFmSt1EjhwNaCUsPDwexpGWbWhDL90HhqgGPC7VrfdYvuyejrYiitECSbmEs9lj2jqj+TJQDcra9WVqdeIxr84p5i2U+Nln4Zaq9ce3SNs9lcUrHDUy7Q22jhrG4OpDCd/7wGbuylViAuAi6fJdaQHg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737532410; c=relaxed/simple;
	bh=NWi/X4EepEORBpF1EdWBM8ejrh0TAtd7EwBf34ua8eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2MEdph/TGZCdEGPhwjdpfWLNqmlzMt89yr1+Kt7lbb6f+CEkCS+nkEZcg8ssUxuYRUYAD9+iUAz0cc3hO5kjef1dtkq3FsqsPzLBV3kV+B/PYvzHn7/gek3kCc7+JrbehRincyriZbmu8AktAtP3s2+IG51jI738DbZ5yLvZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUTSDdnj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737532407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWi/X4EepEORBpF1EdWBM8ejrh0TAtd7EwBf34ua8eY=;
	b=PUTSDdnjkloKXgA18+GXtyUBrm66W2ME4ediBGNjs3Zm4DPUNKSweh0pyuQsNK51TUcFdK
	UKszEkidVhjBjHAoLjeLU1PEPZhu/Pw3rrEBEaQi3TiGfxHGbtgTEXviW+gsFJe/nAe5Xo
	7CbhZjtWlNoKg0zpvpyrRXSfPOssQQg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-UPxFfgc_P6G716LZ6lXO1g-1; Wed, 22 Jan 2025 02:53:25 -0500
X-MC-Unique: UPxFfgc_P6G716LZ6lXO1g-1
X-Mimecast-MFC-AGG-ID: UPxFfgc_P6G716LZ6lXO1g
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab341e14e27so760419566b.3
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 23:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737532404; x=1738137204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWi/X4EepEORBpF1EdWBM8ejrh0TAtd7EwBf34ua8eY=;
        b=lDD4k0C4HnfzJpjfKUMaR+h4yZhiwkGOJB13YB3ns56XRa9mBzyehEZnXhW+fZ+vVW
         qx4feqsGtD0truK5pA1KXbdBSgKymAPlFsme2q2yybVwMR8c0de+R+Y1fjR9OeW8/kGj
         6m6E5+OlsUXkKF/oayZ2kcDrkCNmpoLFQ/gE/q55ug+59KgCnkqHx2wDZ5rSZTOtpPVh
         6fmV2CEFgs1V2/WjGhFr6B3/JFnxfVht/cek3si7vCa8yj5qtFLMLJP2hHECMpC5zFc4
         Xq3RqschkImCSKatkV854F56kHy+efCMuRLTJM9RYgZixUNZ7/LzhfLnqgRPnxL+17yA
         HEAA==
X-Forwarded-Encrypted: i=1; AJvYcCVNbCO7Kyp01xyddgXQwrnNpfoPCLROK9ko2FhEOdbfHvpQPRoE3WgmjzUDRjVQA478X6mAqm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmBJl7DFBRPeM0DPEHeyCDiwoGtT+JjxS/gDzRQ4BfXMNv+mek
	6jFk6OA5j/zaVZw1r72Ql8ji6oOtITe8adRzsbt00Awp2366jCerdLVwb3YedVqem//oHqrSbJc
	D0WfpodPcb9SC1PtZcedV/P8loOrWIc8g7KDXa71i+mHq7MdHW7OihvXvH2HX3oFk9h530n6L+m
	Q3c23eMy3ITnrg3DiJi1LgHQ/CbRIS
X-Gm-Gg: ASbGncsZ+WxTSnt+5HlIGZ2I7TbYYQRbsMqextbt6Y1USjJQKxrl1MdO/Oaxbyv95uT
	r1MN5PE887KFQDMOrNPs3F2K10plVF8SgVK/MRXKXe7KWynI4JpGm
X-Received: by 2002:a17:907:3f23:b0:ab3:f88:b54e with SMTP id a640c23a62f3a-ab38b2e71e0mr1780354966b.31.1737532404273;
        Tue, 21 Jan 2025 23:53:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSBrnnYOS19m7TjOcd8x/cUksXSdlCsHJSmkD+58MAUdLUpHDe1Ee9rZmzT4ECq7IA1QGLbTFKXzGcQJZeEsE=
X-Received: by 2002:a17:907:3f23:b0:ab3:f88:b54e with SMTP id
 a640c23a62f3a-ab38b2e71e0mr1780353566b.31.1737532403990; Tue, 21 Jan 2025
 23:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-8-lulu@redhat.com>
 <20250108071107-mutt-send-email-mst@kernel.org> <CACLfguUffb-kTZgUoBnJAJxhpxh-xq8xBM-Hv5CZeWzDoha6tA@mail.gmail.com>
 <CACGkMEsDjFgyFFxz9Gdi2dFbk+JHP6cr7e1xGnLYuPBce-aLHw@mail.gmail.com>
 <CACLfguVoJP-yruzy-6UVb2SBD_hv-4aF-kBU0oLAooi8X56E7Q@mail.gmail.com> <20250122021720-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250122021720-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 22 Jan 2025 15:52:44 +0800
X-Gm-Features: AbW1kvacW-HF7AuwY6uOBpM1Y_iEZw5oTKBTTe0PcrH7DGqKdHy2_T74XYD0FOA
Message-ID: <CACLfguXoPMfvvio92Yq696bdm9nQKXDeBqbh4DDNXDjkK8hhbA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 3:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jan 22, 2025 at 10:07:19AM +0800, Cindy Lu wrote:
> > Ping for review, Hi MST and Jason, do you have any comments on this?
> > Thanks
> > Cindy
>
>
> I see there are unaddressed comments by Jason and Stefano.
>
sure, thanks, Mst. I will submit a new version.
Thanks
Cindy


