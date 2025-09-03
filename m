Return-Path: <netdev+bounces-219426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1A3B41351
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 06:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6960E7C01E4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 04:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C35273810;
	Wed,  3 Sep 2025 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmJSZHwR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006AC1E3DDB
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872057; cv=none; b=SzPUw0rA8VUnHBjm6H9nhFxK8lUSLb4Dlf0VFhElI4ythQl6TDvDZQZ6/dELY1jWkJX+KfMUmoG+i0AGY2JQSB8QnmEZacnon3UNXBslPQ/noMYvpGua5Dskh6/7d0SA06uI+V1RQgwqBuZ9SEjEpI4KbJ6HjARXSyXhRXapMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872057; c=relaxed/simple;
	bh=U0jjFOIRPE2pVoUMIlyB9h7+kH8XE4j8UQpdjONzyjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZyeSn9DApWxFOuwgo28PN1ZQagE7vqU2Sgrmjqyp+gBdINbh6Sn4v4qpIDOOsUVWWfAEOM1W/AUaY5cO/cxwND+4B29TF+1xG8Ve8OvXF+y25/6fSx1lUWwTsKVQewbCo5DxE6AHM8wsvqjoeJK57x279QYPfTizxvxVRgrZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmJSZHwR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756872054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0jjFOIRPE2pVoUMIlyB9h7+kH8XE4j8UQpdjONzyjE=;
	b=UmJSZHwR5CYaLmI4vKNd5wAVcPl1OysAUtPK/DffvAYAVhrSc14imCYyZ0FUsNMLrvOoJ4
	M6+XKgTtAUVjiHs43oetMbCA8lWHJvwvwpn5PP5PWow0b2dF32pDsIPJMqTfi2LiOiWLpC
	Me9XItxhqIW7shlfzGSYJy/uT5JES9s=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-3Wx_u8QoN_Gk96XHc_e0gg-1; Wed, 03 Sep 2025 00:00:53 -0400
X-MC-Unique: 3Wx_u8QoN_Gk96XHc_e0gg-1
X-Mimecast-MFC-AGG-ID: 3Wx_u8QoN_Gk96XHc_e0gg_1756872052
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24aa3cf81a8so43638665ad.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 21:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872052; x=1757476852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0jjFOIRPE2pVoUMIlyB9h7+kH8XE4j8UQpdjONzyjE=;
        b=aNPw+8LgGP+xyieO4Knm7iaQYw+sQvcTuiZztt/8qa/2ddMawz8t+Nzx1FHpgXg916
         lv7ve8Xhw2jtBLzKrjxwY3e+thD9UO1E/Omb1vysdA668rOaSFsUlBTjgBVsPTxyAj39
         wgYiLaBhXCVNIjbHzS46+vN2ShgrLXz4xnjtv9o2V74LHCqCPVhayBSvs5mVEHcOaIEA
         XV7W/FmMfE8oOcNoXkAz15sOM7hatFgmy5YM3mJdMpyN6Ow/Wjpi7jQxghB2q1dK5ByN
         vDefu8bQQlxGZpWtSQ01LhvdIGdiM9pUBYs/nE2n6E01OX3NqrvpNXKvbcXulOftanHy
         /jaw==
X-Forwarded-Encrypted: i=1; AJvYcCVZYi3YieVlVrGZWtelVBFBWHEFdJ1FWtS0/jHSPTWFv9gyi5wyebMafgwvjrc+2Cl3IgI2XfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTeP0EQd81LQRrXHA5okQPqM2e0H6w+MUiiuXqHq2/LEx/6Kpi
	lDZtStG7OWiAjoR2vbS8HgQLCvJgQLq9nCLaz5PEoQntZpW+RoCSvzhIye1tSH6/4952I0EwiYJ
	SAyMFqDl4+tuBVZqsEWJIJB5y0UVBIaisW+a5iYZp1G+zF6iXh7+DsyU+LSq0MLVMRQRsjmtpZe
	lJXuYQiPx9Nbg/CZPnPGjGUHSluIdvloYW
X-Gm-Gg: ASbGncseib2tzNwM/NhmMqTraCsYEmjGsLKX1oJJTCeHITIjPmpgr19hEaQWh7vGT8U
	Ri6jJNVH8aPPlODDeyPz1Slstx2VP2sgHU6URwRh1KElBuWAAQ5O9GuXg2PJdJ3VsXGRcP7ZQxF
	vLvQAgHhlOdZq+hyqOxBAklA==
X-Received: by 2002:a17:903:1ab0:b0:246:76ed:e25d with SMTP id d9443c01a7336-24944b15b8cmr169377705ad.50.1756872052069;
        Tue, 02 Sep 2025 21:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5aB6Qqxj9qWYTbp0SCLMQoviI6dY5kYYbJnZhA2Hm84dGyl7OdRCsvBI+vTe21NUsYwxF2ONdt98uJqVn0hA=
X-Received: by 2002:a17:903:1ab0:b0:246:76ed:e25d with SMTP id
 d9443c01a7336-24944b15b8cmr169377215ad.50.1756872051574; Tue, 02 Sep 2025
 21:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 12:00:40 +0800
X-Gm-Features: Ac12FXzvemknOpwKY7V_bPmSMDz5x5JOaUgCJhdjwkkYam90CI_kt2z3omxI2R8
Message-ID: <CACGkMEviyLXU46YE=FmON-VomyWUtmjevE8FOFq=wwvjsmVoQQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, mst@redhat.com, eperezma@redhat.com, 
	stephen@networkplumber.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:10=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This patch series deals with TUN/TAP and vhost_net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> patch series, the associated netdev queue is stopped before this happens.
> This allows the connected qdisc to function correctly as reported by [1]
> and improves application-layer performance, see benchmarks.
>
> This patch series includes TUN, TAP, and vhost_net because they share
> logic. Adjusting only one of them would break the others. Therefore, the
> patch series is structured as follows:
> 1. New ptr_ring_spare helper to check if the ptr_ring has spare capacity
> 2. Netdev queue flow control for TUN: Logic for stopping the queue upon
> full ptr_ring and waking the queue if ptr_ring has spare capacity
> 3. Additions for TAP: Similar logic for waking the queue
> 4. Additions for vhost_net: Calling TUN/TAP methods for waking the queue
>
> Benchmarks ([2] & [3]):
> - TUN: TCP throughput over real-world 120ms RTT OpenVPN connection
> improved by 36% (117Mbit/s vs 185 Mbit/s)
> - TAP: TCP throughput to local qemu VM stays the same (2.2Gbit/s), an
> improvement by factor 2 at emulated 120ms RTT (98Mbit/s vs 198Mbit/s)
> - TAP+vhost_net: TCP throughput to local qemu VM approx. the same
> (23.4Gbit/s vs 23.9Gbit/s), same performance at emulated 120ms RTT
> (200Mbit/s)
> - TUN/TAP/TAP+vhost_net: Reduction of ptr_ring size to ~10 packets
> possible without losing performance
>
> Possible future work:
> - Introduction of Byte Queue Limits as suggested by Stephen Hemminger
> - Adaption of the netdev queue flow control for ipvtap & macvtap

Could you please run pktgen on TUN as well to see the difference?

Thanks


