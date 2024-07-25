Return-Path: <netdev+bounces-112982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41E793C1BE
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604E6286976
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE0419D081;
	Thu, 25 Jul 2024 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjEZWket"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ECF19D88B
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909846; cv=none; b=RYRbO6XpzZgOcEiPWOqyV0icwaTlG6wGrdMacpjwNHciRcJsMZJsYAXEDA6DYCeN1j6ZL1iBoTQQzEyrq6KhDrtCv+ZQmmoN00qi4DXFH1CHpzbti4o9+7awQ6aqPLKUQxjxgKvgnXtKrbqEvsYE7eykNG/2SCnui+kHvlnfcFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909846; c=relaxed/simple;
	bh=HVM0mVlaCtLos7f5wbrHV96ayPcblkpUKWT9CLfBrMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONhvcnNUsycKbn1FkeCnASfghcLEvK7Ci9qVsEjlrjkBTcRJ1YcbS9Vb8y0c9LqUYiGYgmQkes23xzvxZk8M0Ke7uLYWLx/sw/K2L07gi9VKpMPaaXQdeOEQsG+BeorVr49XaEkyDeFR1AblAWc+5qa/SiugDd/pEJPjc2a4UhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjEZWket; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721909844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S3UGu/KRztNRY0Bp3FrBUk5j7TGUvdGU0FLKSCgJsvw=;
	b=WjEZWketa0yiquvy94lDLg026dn26dZaGXbJFOBtXYzJQiVIx9Wgmvgq2DFHs+trJRPPCh
	b70sWYVIFo98Y07furRnuFanzQiRpyKOdst3T+LHpXYTNrSlEEt062/HWxJWpADjYEyTOq
	bMtYM0pxBNAU4+uktjbtd8mlEf5UmuY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-Z8dhbTZiOEC7B9nGISYtaA-1; Thu, 25 Jul 2024 08:17:22 -0400
X-MC-Unique: Z8dhbTZiOEC7B9nGISYtaA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36871eb0a8eso500566f8f.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 05:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909841; x=1722514641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3UGu/KRztNRY0Bp3FrBUk5j7TGUvdGU0FLKSCgJsvw=;
        b=S/LaBGKaZcEUIkOFLThBnQpBDJC1knhIHluvkCCTfFxaIOVN/UAGROi2ffpBxhyf74
         H7aiN2nlZZLNlHa+J9UkfmQW/lwZiABAbxjncJ9fpfmDbGbjVBOHrgdCIyAxgBLvkjR3
         5ctDmSBv0vpGOVa3YwT3faHrVOwQxfZk8F9pW/rT4Sg/zfRvP6cX+t9ARIX6T6mOQ/Bz
         bLa+CwKCAw/k1dgxlL83honWXvL6NKLHRRuSBintwJVUWlM+UC2AUfSnVn/SwL9UrQ6x
         33gyiGGUlhHpDMXbw4O0hc4YOBRZPOoO6H3zg6i32ACnYm+wkeK3ZBDrR0S2VTgNU0WT
         8CoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgCxuz/FAFsrmq5wfl8P7BjJOGvPQ89YVkHsmeB3GAT37TIFHcZ6CB+PdVgEHgErhcmuKLED0VL4+1/+FfXxWtHIydJ7Th
X-Gm-Message-State: AOJu0YxU74uMY9/syN364TiROf/mlgBMKNKODgXrMatDtZuHJsukqOLY
	83aSZFVFr23U1vGE3NjTCABh69c4tR+Q7rKuv+CcSVhwpQS3BwhqLFsbo21vXjr0L3DGtLZcOWe
	7AgLVrFC9E13otkN0xkI1Lw3iHV9jrOtRo7WlseijQv64/1Wxklmtyw==
X-Received: by 2002:a05:6000:10c4:b0:367:f281:260e with SMTP id ffacd0b85a97d-36b31ac7126mr1799109f8f.3.1721909841502;
        Thu, 25 Jul 2024 05:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEKfa12+yv+9oCURpazLfKX3NylqFM0NYsmdlmyULxdYJys5id/PrGbgGHwZdmlDCg2IQWng==
X-Received: by 2002:a05:6000:10c4:b0:367:f281:260e with SMTP id ffacd0b85a97d-36b31ac7126mr1799053f8f.3.1721909840718;
        Thu, 25 Jul 2024 05:17:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f8:1b05:4ed8:7577:e2b:7ae3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm1983920f8f.109.2024.07.25.05.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:17:20 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:17:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
	"Luu, Ryan" <rluu@amazon.com>,
	"Chashper, David" <chashper@amazon.com>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"Christopher S . Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240725081502-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>

On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:
> > Do you want to just help complete virtio-rtc then? Would be easier than
> > trying to keep two specs in sync.
> 
> The ACPI version is much more lightweight and doesn't take up a
> valuable PCI slot#. (I know, you can do virtio without PCI but that's
> complex in other ways).
> 

Hmm, should we support virtio over ACPI? Just asking.

-- 
MST


