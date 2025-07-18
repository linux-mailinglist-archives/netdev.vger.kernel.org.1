Return-Path: <netdev+bounces-208113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCA6B09F1F
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDE456486C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946D21FF29;
	Fri, 18 Jul 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbMJwHnl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC77F296168
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830374; cv=none; b=bH5l4fnXfPg5R5mHEjaFVWdYeOB1SnkvrjO0F3tDufcNTSLO8SnwvE/ifZVGG9Ut4W05Z4RXsz5mVWG0AZJG15TyRCCNvlvak+C0awiwNbAJdD0y8pHowg6NSu4AV1a/suB4Qix5cBsRBfEOu+etoKEaaw+ybIVdDX2TPDlqRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830374; c=relaxed/simple;
	bh=9OGXC+HPAx7wjOFmvBxnXdWUJNWtIqbDCCH7mHqqr6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/uqsmHv/upSacZFYjtRjWV6sX4qG7z3MyuoAdo9zNi65vvqTgLDAQzdNxbOMEfJk3t0/HZSiV9eZ1aw3wExpFR9io0GzYmw67g95ellgX315eD0ErB/UP5jl1Hm3gMwJC7qfQm5co0rRJTUjHi0S/YBD2JOwpUzOL81A4na2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbMJwHnl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rz7VEdzguNgZR75iuoM9tSMqqnHJY/Hj/MLHh0vHLZM=;
	b=CbMJwHnlkstLQpf5jyc/1JXPdwrjWhd7Jesbu8p1dseqEZ+ga49ps3iZja5hNVQ+N2pcRD
	3VSaQuT41QPkmkxi2kB2bDEmFZQfkc4zH1JuuNxxt+sac3SIi6VmKFGvTW/ZWcYauWMh+A
	mV3uq+21LPx44mpNLbBYreKXn+aZ0uI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-XRHycbhRM1C2nmnIjDcDXw-1; Fri, 18 Jul 2025 05:19:30 -0400
X-MC-Unique: XRHycbhRM1C2nmnIjDcDXw-1
X-Mimecast-MFC-AGG-ID: XRHycbhRM1C2nmnIjDcDXw_1752830369
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so17010695e9.2
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 02:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830369; x=1753435169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz7VEdzguNgZR75iuoM9tSMqqnHJY/Hj/MLHh0vHLZM=;
        b=ccq09H+5/ghaaLVkYDkcFZzCw1LDsInYbQ/sSbHGd+WnaFM0y/1j1kN8CtiCVRN36X
         P+b62/vmFvn80/2gx6FIAn0xVYF6bcrwg6HVP9WoLIzL704FSg7MGBgPyiRsXCiC0TQ8
         MjB/92ydJqHf1f79pVe/rqqOC/jCJIzKxw1ZcriRViEvTIZGaEeST5w10IV1ixSRa+eC
         TR+fStGWHNx5575ll4tY83u6PCYMv+FNY4GFS58Bc6Wa/IxC5wMMwzz+cIEZVJASDRMw
         w34CWd7a95WyGERlKmt0M3sDYg+YjK2JaLlHttf4bQ1uqt393RYtljCepBkJcPyXEimW
         0hzg==
X-Forwarded-Encrypted: i=1; AJvYcCV5w4N8fxZfWCrOEyb6ia+eW1QL4Px8hIx5kopOUfJviwo71zfmBQ/wWGWJbl3hntw3MS/DPCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgieJ3ci8SpCAoeAsSy2NU5r5eAk6Alo4fj/i722rehVIScg+8
	AzgnDP7tYSf8X71brePtFTUh3nZCnJAbTC8p2B3XfWtRNE9JEpPdcNE0YoVA+xlovGNiziwuiaI
	EOOUKSjmYsZRCBpbIPMEkwxCOPn9VyJcngMsZjvrXTN3R+wW5cn8BFKqlFA==
X-Gm-Gg: ASbGncvp84dbpR+00pQBthBvdaZLUhjGCc+K1K9iJvZcUaZdz/Ar2Kl1C/9jx745DpY
	/x/W6yVD1Zt9nUaHrXxUYFqDDF5+IK2HPLyydumFD8m3MKCKHHTN9PbFLJnmsqOZ2sf41rwo+Jq
	MkjzY1gSAyakyrfzYkqsd4dCl+sBqGW9Xxrrh3MnVGMxyUmkBxkNqT/reBPVnZZrOj42APz7koB
	l9FcnLkL+SErOg98WO3YstfJ2t5GmmO/x1twUlE1nIoMUjeMSwbnCgU9ruF4IvtWZwYLLib123c
	B1sXU1H22+DZYlzXeJDEcgl0fiDMc7AnfoNsH9v71Alp7TkvBpjJzj0oSNvqKgf5U6H/rLLiyl3
	+EoXOsP4vi64=
X-Received: by 2002:a05:6000:440e:b0:3a5:1222:ac64 with SMTP id ffacd0b85a97d-3b60dd7b02dmr5390086f8f.38.1752830368955;
        Fri, 18 Jul 2025 02:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTjhEq8p44r045oEYKw5E0umkCtE+yHNEk65pXbCxLQ3y2DbvrtoknVhu/Al+Bpx9xmKqa4Q==
X-Received: by 2002:a05:6000:440e:b0:3a5:1222:ac64 with SMTP id ffacd0b85a97d-3b60dd7b02dmr5390060f8f.38.1752830368389;
        Fri, 18 Jul 2025 02:19:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2dfe0sm1288433f8f.36.2025.07.18.02.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:19:27 -0700 (PDT)
Message-ID: <7aeff791-f26c-4ae3-adaa-c25f3b98ba56@redhat.com>
Date: Fri, 18 Jul 2025 11:19:26 +0200
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
 <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
 <CACGkMEv3gZLPgimK6=f0Zrt_SSux8ssA5-UeEv+DHPoeSrNBQQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEv3gZLPgimK6=f0Zrt_SSux8ssA5-UeEv+DHPoeSrNBQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/25 4:04 AM, Jason Wang wrote:
> On Thu, Jul 17, 2025 at 9:52 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 7/17/25 8:01 AM, Jason Wang wrote:
>>> On Thu, Jul 17, 2025 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>> On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
>>>>> On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
>>>>>>> This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
>>>>>>> feature is designed to improve the performance of the virtio ring by
>>>>>>> optimizing descriptor processing.
>>>>>>>
>>>>>>> Benchmarks show a notable improvement. Please see patch 3 for details.
>>>>>>
>>>>>> You tagged these as net-next but just to be clear -- these don't apply
>>>>>> for us in the current form.
>>>>>>
>>>>>
>>>>> Will rebase and send a new version.
>>>>>
>>>>> Thanks
>>>>
>>>> Indeed these look as if they are for my tree (so I put them in
>>>> linux-next, without noticing the tag).
>>>
>>> I think that's also fine.
>>>
>>> Do you prefer all vhost/vhost-net patches to go via your tree in the future?
>>>
>>> (Note that the reason for the conflict is because net-next gets UDP
>>> GSO feature merged).
>>
>> FTR, I thought that such patches should have been pulled into the vhost
>> tree, too. Did I miss something?
> 
> See: https://www.spinics.net/lists/netdev/msg1108896.html

I'm sorry I likely was not clear in my previous message. My question is:
any special reason to not pull the UDP tunnel GSO series into the vhost
tree, too?

Thanks,

Paolo


