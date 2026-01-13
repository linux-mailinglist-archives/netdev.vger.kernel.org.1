Return-Path: <netdev+bounces-249466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55032D19795
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 982673038282
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F9429E0F7;
	Tue, 13 Jan 2026 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bromVzgr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkGAVH8A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98B29AB15
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314609; cv=none; b=WdpvygbnbmMnXSb0NsZoYMTPgXuFjIQhclrDJlHZOOhsfNOXBGgwf0JIA8pYTPUfvzqFICy2NbcKjJdbdRA+EmkHL0C9cHuFzXs9EKmu09ypIxE1IA+oAjg64kIuY/bW9RR9aczJOuHsMD5/PVBgFUb4vrdKauAsuurQ8tYbdd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314609; c=relaxed/simple;
	bh=lHu6MXmC881GNys4A4x9dwsGJnuct71yJhITMvkSNBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1NVNVU8wKfZtZcdD/pBuOHegAq5lEl6j9hvMKZ+LWZdCGSRMQczAPdChzfJVIkUf4xy8ME1jkX5/fL9ARnhB6ruLRVfdjIsMCHu5mXWMe9QlZ7hzbYaKV3ohZycFeOPm8cFTXinZe+9RwdtgXYG5/W30G1z95uUpw6I7+kK1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bromVzgr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkGAVH8A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768314606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsGMLadexo/nCzuVTGjgLCJkB33PukmvAkeDyomNP3Y=;
	b=bromVzgrBJurf6ULQmtIlScUDtIY1Pv68F1sIuDGnLPmYnT03ugRa/YEMygbX2a4kBcz5Y
	ONP5Slyy9UA7q/eG4Z3wkwHx0RLhCVUObbG9SqPH+ePueEzQ9Z2a4S5RBpvOqj92ixY0ym
	wnvOqd4az+yHrISLx36hc571cDtcXzQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-vSETYqBKP6-d23Cd3tn8UA-1; Tue, 13 Jan 2026 09:30:04 -0500
X-MC-Unique: vSETYqBKP6-d23Cd3tn8UA-1
X-Mimecast-MFC-AGG-ID: vSETYqBKP6-d23Cd3tn8UA_1768314603
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fcf10287so6219566f8f.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768314603; x=1768919403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsGMLadexo/nCzuVTGjgLCJkB33PukmvAkeDyomNP3Y=;
        b=AkGAVH8AAq7YbxYn2HohM+WvuYm26hHNeYCJ9GMukCkw3vgLzKZzWtgDZj1sYqEz5G
         GQRnn9dT2I2UD37mPsM10Jl5VaRIRAKaj0gfl00kov7vXBEC2/nPa7k8VmMW6GApgJjX
         momVrU+4Edk+Fg4PpowsqTdf9LzaDhb002ZlK/rPlaCF13SFddR8OZD1LEU2gy7Mj/su
         yUUW7QeIPaHdU/cyObfavcHW3UnF8joQLmjpPu292FiA+iSBUGnJVCn4nnXIb9rh6ZzL
         uIKbsYgYNnaESReoejdSLhkcrtLCGPSrG7xzd759PRs1IdAYuHH5M8i0f0wkk2wfGf7b
         +XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314603; x=1768919403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsGMLadexo/nCzuVTGjgLCJkB33PukmvAkeDyomNP3Y=;
        b=PzslaPmueANM0WKGhBFQm3vBEsjI8wYwxUd60iCr8cnbj0GrL2IvHhfnNeknTHJTh1
         z94k0rFjThiCwWCC7lq9HUvpMzNoNYUt22NTW9N9EdjXTn13KH7jbDMEBwpYOyivIYH1
         MhFwrRqLR4lGDq6bcCYlofn/SDU4ZMYOd7VwSPxHMoua56Lebzms7lVdZRWB3xuW76lJ
         cKOyFyszjxDYx/H5aOFZmBp267OHDz3vKBBycb5UheaUL/f5SaHKA1mRvuJjm8FuLj9C
         WVB7upUKzXAgIFsjkxN98Ug/ipda4clqARq9WKQasBuWsmCwsDzeIuJI39NgLZs/sTT+
         dIpQ==
X-Gm-Message-State: AOJu0YyBKM7MNtCw+0AP6/4QG3iTHelB0LXZ2wq+y5CJd3kp338DZSRx
	5Orfh+0q7wWAS72524eGlzt9BV8rYzcJrTk5yc/RJsrEkapgPJMaevm5PSv4brwvKREa2BtZd6K
	CQPFmjDYyfn4i9wukO/OOBQ4DODiFsvoEECL4koF1M8/WZJ32M6K1GLyE6Q==
X-Gm-Gg: AY/fxX7aheEa1AJsTxGslGBGh+0ml3g5OoKkt+faMfZpx7PE7QdBvef8b5eIjlsYRmH
	3xU+EtFO4joNfEd/OKVgSO/NgCmpc/rIIZgDlstqEt/Bst0ka2ZAfokDimByjDeRRFiFOXMRFpd
	VRuuzj4Hs0O6hfu7Rvm9n4a3G5PZnkcNwnQU9tRYjAR+BiJIE8I828rtgKVkzSmheD1Rj9D0oc4
	C+5x8F9VByjCf/ync7wnkQ9Xyzqwdxd487FA3JuKJ4X56HCNEReBlGlG8z/QJUweTCLDQFoT1I2
	Ug9Z25qqSSL8j6reNAsWwmH4dpiNtitiAKX6fHBa1A0T1uvROnK8InwZJhUXLzonHdSTKfZYJgs
	ouCnogrIPCzI/
X-Received: by 2002:a05:6000:2411:b0:431:c2:c632 with SMTP id ffacd0b85a97d-432c38d22f0mr26992648f8f.57.1768314603278;
        Tue, 13 Jan 2026 06:30:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/QAVAjAHGrbVqsroQVjucumpuberxPHjIK5D6+36lcnv98Jxe8Pu+ntURZqANmPNOZ6UFhw==
X-Received: by 2002:a05:6000:2411:b0:431:c2:c632 with SMTP id ffacd0b85a97d-432c38d22f0mr26992605f8f.57.1768314602838;
        Tue, 13 Jan 2026 06:30:02 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9afsm47097191f8f.24.2026.01.13.06.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 06:30:02 -0800 (PST)
Message-ID: <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
Date: Tue, 13 Jan 2026 15:30:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aWIItWq5dV9XTTCJ@kspp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
> Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> along with the following warning:
> 
> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it (in this case
> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> overlays the trailing members (rss_hash_key_data) onto the FAM
> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> The static_assert() ensures this alignment remains.
> 
> Notice that due to tail padding in flexible `struct
> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> offset 84 in struct virtnet_info) are misaligned by one byte. See
> below:
> 
> struct virtio_net_rss_config_trailer {
>         __le16                     max_tx_vq;            /*     0     2 */
>         __u8                       hash_key_length;      /*     2     1 */
>         __u8                       hash_key_data[];      /*     3     0 */
> 
>         /* size: 4, cachelines: 1, members: 3 */
>         /* padding: 1 */
>         /* last cacheline: 4 bytes */
> };
> 
> struct virtnet_info {
> ...
>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> 
>         /* XXX last struct has 1 byte of padding */
> 
>         u8                         rss_hash_key_data[40]; /*    84    40 */
> ...
>         /* size: 832, cachelines: 13, members: 48 */
>         /* sum members: 801, holes: 8, sum holes: 31 */
>         /* paddings: 2, sum paddings: 5 */
> };
> 
> After changes, those members are correctly aligned at offset 795:
> 
> struct virtnet_info {
> ...
>         union {
>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
>                 struct {
>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
>                         u8         rss_hash_key_data[40]; /*   795    40 */
>                 };                                       /*   792    43 */
>         };                                               /*   792    44 */
> ...
>         /* size: 840, cachelines: 14, members: 47 */
>         /* sum members: 801, holes: 8, sum holes: 35 */
>         /* padding: 4 */
>         /* paddings: 1, sum paddings: 4 */
>         /* last cacheline: 8 bytes */
> };
> 
> As a result, the RSS key passed to the device is shifted by 1
> byte: the last byte is cut off, and instead a (possibly
> uninitialized) byte is added at the beginning.
> 
> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> moved to the end, since it seems those three members should stick
> around together. :)
> 
> Cc: stable@vger.kernel.org
> Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Update subject and changelog text (include feedback from Simon and
>    Michael --thanks folks)
>  - Add Fixes tag and CC -stable.

@Michael, @Jason: This is still apparently targeting 'net-next', but I
think it should land in the 'net' tree, right?

/P


