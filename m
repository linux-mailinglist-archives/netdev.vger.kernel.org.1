Return-Path: <netdev+bounces-207893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A954B08E88
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01F4586727
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159852F5C55;
	Thu, 17 Jul 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BikB02IV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD392F5493
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760355; cv=none; b=WWpX2AaUr5T4tFn85bUVoVW5hu9BVxWmZTsb4MvMn9Z46QDJ3BatvmzMjI7nMZ/azKE9hnhca1syErlFAegGvyuDrrsbJ6ynu3Q+ynDbzvVDXOzdr88mhpoBuH2CqyfEQ/vrt3xGIjye+P4aCqyRQc247ZQsQP+dobqYal+56Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760355; c=relaxed/simple;
	bh=FOknZPaa0ET0wOU5En/aokMYWIKU8p4UDlNpWqYvkSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+vanwEW6JoBcQuKtvGG1RtSqdLsT86qBxXWwDDC/tmI/L59M7SEm6wcYHpqWl9yFUQ6ZkTX2srGxVIVnkbJtQD9qrEqah272dY3FUY/Dj3IWqOkM10nc0VtPuJNUG7UzmcQ6lrf/BIdRpqDYLVoOy01nhtsF4z7vWTuFrFgZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BikB02IV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752760351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGvAbY32RFgpjRdN6+3XL6T/YF5F5zsdWuL3mzQK87Y=;
	b=BikB02IVkH7pDFky2gShbhPIpl7SqYrXEHEefajzhE9c9FwOjalJOUnclFygZNwUR94yZj
	tSpUeTZvcLh9UTpLy3eY35w/ffeZxvZ4TR24MNNfb2BodqA52UmgWE7rYZDp4YD6gABevq
	od1MmglGpc50WvNGVW0WgXu0i/WjLcI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-SLbqKCVGMPe_n5ZJpV6Pzg-1; Thu, 17 Jul 2025 09:52:30 -0400
X-MC-Unique: SLbqKCVGMPe_n5ZJpV6Pzg-1
X-Mimecast-MFC-AGG-ID: SLbqKCVGMPe_n5ZJpV6Pzg_1752760349
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b604541741so700263f8f.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 06:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760349; x=1753365149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGvAbY32RFgpjRdN6+3XL6T/YF5F5zsdWuL3mzQK87Y=;
        b=jOOKhOIHwx4KIVXN97FBAsPqvDpnVMJw5h+FZlmq7M6hGbDZa5FBTGpdyzkK0ZE87n
         EX7wSX/S0OfleG2mjlRdWdNeDRyTWnLiG05Xy69tKnk4HeKUNkRFuDZGd35HdwpBGJpY
         4hjyQV8JypGY704akOTnKwNuA/1+IY339juokwmYRMDqG6//q1J+yPKJ+7OLHk3ojkhb
         6lpjCajs9Q3nsVW7I4fvs9MI28UnP457ofl97I8p58B0tGdhq+HZV13gaGBM5Jtqwqiv
         B4+QE65m4NQg1csdFQkbq2MaxYWfFc29JEALwpLa6IgU5ijCl/z/Fs/ZpTTGjaMd4+gS
         wrug==
X-Forwarded-Encrypted: i=1; AJvYcCWNZpXv8YXz7MjFa510g3BrlzXDLACSyu6Z0orOWMsbOdBs6eTXAOqXi3jplYzeOOswTDotCVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NvFjB7swSbK6Qehvi3PCTJpswVuq7hzBNAUnusVcvapbB35t
	jaRCSqypY7gzCbw+ynmDfgHi0t8fmY3fcoxVh+zbTfYUMllZ1XbmaowEyM19Qokv4Q8267ClTeK
	Z2gfWqRnu1YwXu/CrJCI4f3UIq2NaTYCW0x3ry7WWYvQ1Z4zxtl8jba/yPQ==
X-Gm-Gg: ASbGnctm2SJh9y2vU+JEXEDqdOHjAjxW7d37RITFtHwAQIO9Svtid4ulu9aLaFQ4imc
	DNtWR5sVvkQeKWJCwgAO4TiFfD6CPrunHjzeS6LohrP8HSaY1TdsIofQEmaWgl5JjJMtv3AZUmE
	7aGDemSrrnnZoMuHt7klxhF/8jddHfnWQ12gUoWTt7OubTwFXhMRrIQpdHXxjiIjGrVq0fG8JVI
	d9XAQoAfPByXyeVWpS9Rs4FbiSQd/VJXtOMI/1tkPdptPKEbsKbvzm3ACQy3b1keIZFduXSSbCP
	3P9WKI+QbZnhZx6wgzxr6O+xc18XVqNtiZJJK/ev/LeIx4HijaXNYK6EthTnuCHPCL8YbaI6bJY
	87u/CofN+oy8=
X-Received: by 2002:a05:6000:2006:b0:3b3:9c94:eff8 with SMTP id ffacd0b85a97d-3b60e51c895mr5115039f8f.27.1752760348631;
        Thu, 17 Jul 2025 06:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe2UZsHx0A1qd64C0wPihrY+x7o7vx2ATqKIuSJI84BF2RqSh+4TT6WPjrhFeuw06hYTdARg==
X-Received: by 2002:a05:6000:2006:b0:3b3:9c94:eff8 with SMTP id ffacd0b85a97d-3b60e51c895mr5115019f8f.27.1752760348124;
        Thu, 17 Jul 2025 06:52:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d4b5sm21113467f8f.53.2025.07.17.06.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 06:52:27 -0700 (PDT)
Message-ID: <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
Date: Thu, 17 Jul 2025 15:52:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
References: <20250714084755.11921-1-jasowang@redhat.com>
 <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
 <20250717015341-mutt-send-email-mst@kernel.org>
 <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/17/25 8:01 AM, Jason Wang wrote:
> On Thu, Jul 17, 2025 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
>>> On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>
>>>> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
>>>>> This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
>>>>> feature is designed to improve the performance of the virtio ring by
>>>>> optimizing descriptor processing.
>>>>>
>>>>> Benchmarks show a notable improvement. Please see patch 3 for details.
>>>>
>>>> You tagged these as net-next but just to be clear -- these don't apply
>>>> for us in the current form.
>>>>
>>>
>>> Will rebase and send a new version.
>>>
>>> Thanks
>>
>> Indeed these look as if they are for my tree (so I put them in
>> linux-next, without noticing the tag).
> 
> I think that's also fine.
> 
> Do you prefer all vhost/vhost-net patches to go via your tree in the future?
> 
> (Note that the reason for the conflict is because net-next gets UDP
> GSO feature merged).

FTR, I thought that such patches should have been pulled into the vhost
tree, too. Did I miss something?

Thanks,

Paolo


