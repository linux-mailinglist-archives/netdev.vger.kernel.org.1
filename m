Return-Path: <netdev+bounces-173430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05AA58C6F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 08:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBF63A899B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8101D5AD9;
	Mon, 10 Mar 2025 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="QZRBYT7/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238E1D47C3
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590291; cv=none; b=O1ux5AcuokvXiyjlkDET1RBQKEIEIcJ7xM+V60Xm7ftd6cGZOjLqtlzrEOj2ZCdjeLoI3TdhY+iB7JvtDU9UX01vdk5FT7KK5PywggLK64DvOIfvHF6gz5bdjZ4SqChboD8/uCMV0WQm30ReSPIx9XWsAT+aMat2I5cgN3YC7jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590291; c=relaxed/simple;
	bh=eSw/Sz1ql/4UPcLEbJRVUH0uYPxF2xmC0A18fnAZuI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cphCv3Bp2hr3jc5G/KH6VNrkMQ/yi9TflgBCKgCnJyxyz39Cp4yvVI92Gz2AhnIOZ3yZloD/SV9EIs0PTlLYbzyDU5trWM0mNUaFLHR0UCcWTBSZbzbnixfoXoIP2Xd016BR+fQ+3JK5VJfVTlIyufoBldj4RtqRY+drdIYBtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=QZRBYT7/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223378e2b0dso53795815ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741590288; x=1742195088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4zUjmNxjokxBeO8EjZH90AMO+cgLdiVs95Lgo++StE=;
        b=QZRBYT7/pUx1N5WjjIh58q+/IinjLV3aq0UR9zGCTNxVna0gfBnE9gUO8W4GuVM9KA
         aXu0TGNLBTvShFK8ky5kFa+mBCVnbzcSPm6vG9pdeZNO3EyOZ4DBu0fksbpXqnIhuwNL
         xEsrLyqVKi+jnkBwXgx5FsdLc7LEKJkinZtQGEHh9kZd3bkFzQI+gKlwnuQEg5BQkvkX
         HxCDTgg0yUZJOLlF8ic1Bi2VoU4YMXRfO9wYbI5HdOdHcSk6mPFQ+UqIAtysplhtjrP8
         XVw77g1RD0BBt3zcQosaTS1XIvITQ01qguj0TkwT+IoPolx2Hr1pDl6gbOH9qtQMrkr2
         DbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741590288; x=1742195088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4zUjmNxjokxBeO8EjZH90AMO+cgLdiVs95Lgo++StE=;
        b=GGpSKTikimG+CS8Zaeq9vpGGIrad8e2zc7+uvgvcmH00//1234Gdhrl0km/C1z5WfV
         y/0y4SKecdQDvOpcbydtAJF2l+l+8Z6lpxadBZgyRCgh/HhyImbphdPGuZQK/BT5dlLO
         bhNXJwYEiAZsxJdLqlNbZSQno6P6Cv5oPReNrF+/GSCyXhlKP8DSTasUUTKzpB666Hbw
         N72naj0mQtBJFE66CEqTqd+XoamQm5WdPhPUa0FMkPPbn1JQER0A2D3s9R9z6ffXuHsU
         e/1pEUKiNCmQkoVZkbcuiumO87zXcSs0K+rGKO6YbtL38iqkw8in7ysJ7B8mtWQGv/3s
         7OpA==
X-Forwarded-Encrypted: i=1; AJvYcCWR1PCRP15Y0b7AsBWrZ9Sgivabm6dKULepxOgLCA1BtqghTucF4/r9vtzTUJ7HWyOPlBgkmsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAu95v2dUQH5/qQgQH/UoGERN2xNXaZjxWTTEZG5egLsiCaGbv
	k8jwwnVyai+Caoekg3tUBvewqDFgtYY4wiTWuAHpfOU18FS1m9A/iHVtn0B5IPM=
X-Gm-Gg: ASbGncvvy91FQiYHTlitxyV/yZNHa+SnevfFdLWlSEiXqWDV9vk9AHMXRNHjFGQ0pvM
	GVHe/ksbUB7R0G6mE8Xi7qgx0+x0pk80TsHesPwI1mEvBoZODpfomR1VOtbYj4PIbd/xMRXBxrr
	ez6q/S1U+R+wwX2rF5g6AWm0BqAMfnRM/1K3X0vq8op+qtEtrPA7ar3lYNj8wTkZrEwdl+kGXAD
	5KtI0j8gc4s/TWfr3QwUKeLB7xj2uc+cLRIXdkBqs3o70D2EcLa2VukUjSQwtC0i73M+/t2wpzk
	j0qyhghQKfd4oV/w5Mm+iGIWb2rW6CkAI4F/dEX9J8FeYwwCzZA1vfbemw==
X-Google-Smtp-Source: AGHT+IFkDjhIOqYcqagzT94jgytjjwhSIQTT2o6zqPzPIQtmCm+lioqyAyJhjHPUINzm2ba//BDswA==
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id d9443c01a7336-2242888681cmr196310675ad.2.1741590288383;
        Mon, 10 Mar 2025 00:04:48 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f93esm70081685ad.142.2025.03.10.00.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 00:04:48 -0700 (PDT)
Message-ID: <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com>
Date: Mon, 10 Mar 2025 16:04:43 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 6/6] vhost/net: Support
 VIRTIO_NET_F_HASH_REPORT
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
 <20250307-rss-v9-6-df76624025eb@daynix.com>
 <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/10 13:43, Jason Wang wrote:
> On Fri, Mar 7, 2025 at 7:02 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
>> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
>> hash values (i.e., the hash_report member is always set to
>> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
>> underlying socket will be reported.
>>
>> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Tested-by: Lei Yang <leiyang@redhat.com>
>> ---
>>   drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------------------
>>   1 file changed, 29 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302f3586ea6bb5e0d4289 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -73,6 +73,7 @@ enum {
>>          VHOST_NET_FEATURES = VHOST_FEATURES |
>>                           (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>>                           (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
>> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
>>                           (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>>                           (1ULL << VIRTIO_F_RING_RESET)
>>   };
>> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
>>                  .msg_controllen = 0,
>>                  .msg_flags = MSG_DONTWAIT,
>>          };
>> -       struct virtio_net_hdr hdr = {
>> -               .flags = 0,
>> -               .gso_type = VIRTIO_NET_HDR_GSO_NONE
>> +       struct virtio_net_hdr_v1_hash hdr = {
>> +               .hdr = {
>> +                       .flags = 0,
>> +                       .gso_type = VIRTIO_NET_HDR_GSO_NONE
>> +               }
>>          };
>>          size_t total_len = 0;
>>          int err, mergeable;
>> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
>>          bool set_num_buffers;
>>          struct socket *sock;
>>          struct iov_iter fixup;
>> -       __virtio16 num_buffers;
>>          int recv_pkts = 0;
>>
>>          mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
>> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
>>                          vhost_discard_vq_desc(vq, headcount);
>>                          continue;
>>                  }
>> +               hdr.hdr.num_buffers = cpu_to_vhost16(vq, headcount);
>>                  /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
>>                  if (unlikely(vhost_hlen)) {
>> -                       if (copy_to_iter(&hdr, sizeof(hdr),
>> -                                        &fixup) != sizeof(hdr)) {
>> +                       if (copy_to_iter(&hdr, vhost_hlen,
>> +                                        &fixup) != vhost_hlen) {
>>                                  vq_err(vq, "Unable to write vnet_hdr "
>>                                         "at addr %p\n", vq->iov->iov_base);
>>                                  goto out;
> 
> Is this an "issue" specific to RSS/HASH? If it's not, we need a separate patch.
> 
> Honestly, I'm not sure if it's too late to fix this.

There is nothing wrong with the current implementation. The current 
implementation fills the header with zero except num_buffers, which it 
fills some real value. This functionality is working fine with 
VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the header size.

Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report 
field, which also needs to be initialized with zero, so I'm making sure 
vhost_net will also initialize it.

Regards,
Akihiko Odaki

> 
> Others look fine.
> 
> Thanks
> 


