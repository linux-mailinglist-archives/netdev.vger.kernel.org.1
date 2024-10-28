Return-Path: <netdev+bounces-139459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08FF9B2AAC
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 09:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B601C21527
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C27E18C93D;
	Mon, 28 Oct 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfxzluS6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598B155C97
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730105225; cv=none; b=ZELh4K/TB6MWXCLuohyLc7pwiQ7abyuMyUVhWw87l8icv5a2SlyIXJr5f+sWSdPfAlLdUvwsjwbRRjawCcGSkZekrJzUSr5MrZTmZGcD576C9QUFqcVx9b7P8q3McXGNQ/TZXi5n5xiNh11d601kdiBPeiZ7lbC2EZNc8BaqNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730105225; c=relaxed/simple;
	bh=4nRAWe+LcBpoQrseJOmGEbRr7lYlXgBzzy8YRDK1QGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8AC2DX2vaqcGJG4u8/0CUUKVEjFs7kQMkkKuHHbcvi6LrsmOty8ZTcnjLD3F9C/sAhrhEB54T2Iabga+9RG4AZccHeRtlC0HC658B/fLa6SrZoXdcnOPGJyMpayCq9MM98ommpOoQtcs3DUlbwPA2nAA79MIgPRiVhWcGNelwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfxzluS6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730105221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vks5kZts7JNWEw0mNABwk3ZLtuSYwtzKOtikg663IG8=;
	b=DfxzluS64dyILk6o1YAOCJhQ1113j3xQxf4kJNo2QIb6weSLAMBkKiIjHKtzew5nSaMqpI
	+Fry6qvoHjBsoPI/vaPszKiCm4Xi8xTvW+f0j8yYpAG7RuVX8/q+CgDS1vI5L/S6ztk7nH
	wPkWNycMOOhIHFeXvbrV7wVHZuMFg2k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-WyzEK07KNtS52J5l8b3SfA-1; Mon, 28 Oct 2024 04:47:00 -0400
X-MC-Unique: WyzEK07KNtS52J5l8b3SfA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539fe4e75c4so3828349e87.0
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 01:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730105218; x=1730710018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vks5kZts7JNWEw0mNABwk3ZLtuSYwtzKOtikg663IG8=;
        b=SmIkBUFuChVjqt9HEtdZUyLVDFqW8OPUkN3tVBvWtlluRMTlvGJ9f6CsCc6tl11S9h
         HVIJGMeklly8UYuJ+62VMk0Bn2KI4Vrw7O0xl6zVaPQmzJO9QfcxAJx78bXfBOAf6Taq
         NA4f8M4OPvP7S5o3VYYGvLNpd8Iq1qI3ixY69pjNiElfE3ePJlTpgxOMK+i472F7nSP4
         Ahuw12Jwsh86ucj0iXrd0Uvxi20CZ7SjK647zNnCs2wlXM45bYLuoK/qNJk1hjFRTp00
         eKdeUvjjhlz6RcpCSkyPf2Kr/FcmK3iJDfh87TWjxdup2H5K2msI7k6olW17NVgdRqFg
         3h6A==
X-Forwarded-Encrypted: i=1; AJvYcCXEfZEWk8DIqz7N+yAb/GK6RrIPEAWBb6dYs0s/Zx90TPKIQcdr42jifa7nFmj1mzR63eEkNxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDs/0rAZjR6ZFYl4nksscoSzerLbF7rA6XKbhg+o7OdpmMixY/
	ghuS5keAg3JOmgRNYKXLZz/xnd2N3GRjAiqwVgZEsFkI2dVdkvfX3fPVtpRBLuzs0zes47BZzME
	vaok4BfSsMWAw4AhJ0z93iLjC5N0la0NoouzoByl1AXe4XPPXi2GMY53tI07h337qD8VcKD9aTT
	V7YM2bWD9QL3IY8ewiZEU9/YlzY9Y5
X-Received: by 2002:a05:6512:31d3:b0:539:8fbd:5218 with SMTP id 2adb3069b0e04-53b34a3515fmr5697931e87.56.1730105218575;
        Mon, 28 Oct 2024 01:46:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUZevRl73AFu2hY50TNiS66U8N5RTGQrWzGRIL1+d3l5/jdA+CvCeMgdKrkJ2z+Mtn8DYeQ8tMX+h4cXTMm1A=
X-Received: by 2002:a05:6512:31d3:b0:539:8fbd:5218 with SMTP id
 2adb3069b0e04-53b34a3515fmr5697915e87.56.1730105218171; Mon, 28 Oct 2024
 01:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731071406.1054655-1-lulu@redhat.com> <469ea3da-04d5-45fe-86a4-cf21de07b78e@gmail.com>
 <CACLfguXqdBDXy7C=1JLJkvABHSF+vJwfZf6LTHaC6PZTReaGUg@mail.gmail.com>
 <CACLfguVZg7AAShfqH=HWsWwSU6p6t3UUyTD+EaA4z5Hi9JG=RQ@mail.gmail.com> <ee6202b0-bfab-4b2f-87db-14b66476982a@gmail.com>
In-Reply-To: <ee6202b0-bfab-4b2f-87db-14b66476982a@gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 28 Oct 2024 16:46:20 +0800
Message-ID: <CACLfguVcPnxAnjP-mZ084vTnrBemraBuwDkUcT2RsBsnVLPxTQ@mail.gmail.com>
Subject: Re: [PATCH v3] vdpa: Add support for setting the MAC address and MTU
 in vDPA tool.
To: David Ahern <dsahern@gmail.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Oct 2024 at 00:54, David Ahern <dsahern@gmail.com> wrote:
>
> On 10/22/24 1:01 AM, Cindy Lu wrote:
> > Hi All
> > ping for this patch
> > The kernel part of this tool was merged upstream in following commit
> > commit 0181f8c809d6116a8347d8beb25a8c35ed22f7d7
> > Merge: 11a299a7933e efcd71af38be
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Thu Sep 26 08:43:17 2024 -0700
> >
> > Would you help review this patch?
> > Thanks,
> > Cindy
> >
>
> patch no longer applies. Please re-base and re-send.
>
Sure, I will send a new version
Thanks
cindy


