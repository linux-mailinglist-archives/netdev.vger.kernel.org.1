Return-Path: <netdev+bounces-194702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DD7ACBF94
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 07:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E088E3A32F9
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 05:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390961DF723;
	Tue,  3 Jun 2025 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="PNGtP1v9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE212C499
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748928693; cv=none; b=DL8YvmhaWQu8vINU9zDo7aCGxnkhImONSShkXgfSVdTYr8uoTH0/3vdqKPJVIdWgohSD6vrNOy03WnC1ajNhazz/YOjoO9Tcj8UF4uMdMuXZYloSFDNsMWgmrEAUtCiatiJR8+bJT1NkW2VHJoQedf1b2jzBxE4BcnFpjkJqwwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748928693; c=relaxed/simple;
	bh=ned500yeZ+fotJTle6hKqUkOI4+MtDNWmZ73eMxCpM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caUj1jNtLqU4rBqN5B01S39PYL3WVNXwLelBdFBzW3XGgCiZO/HB1s6ROXiQQwwsDWnRagohvT/QyTDWyblQS7CWPtss8hwXCk5MMojyLuNnx2iylrRNgMeIZZebhkqXckeqEkcWcSWh6sKB8T5OcUUGyDZzv1smY3y4TYS5yyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=PNGtP1v9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234bfe37cccso66196445ad.0
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 22:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748928690; x=1749533490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Th/HvjGvwZaAq8NqcJZl3dUrBp6q2rEKCyly2o0Sv+A=;
        b=PNGtP1v9hG5Crayx1GpMFQ5ZxHbTGVbIZc+9ZKUtOSCBz5Xk44A+ABS9e/m2nnOFU0
         nZSVCn1kPNkDgKhHYyKvSOAf75Al9fAhVlU/3jEcpSsLrsMn0CTDzGSlEIRV+rAsq1P2
         G8xoM+ArrsEpTbz2b+Hfhvf703+BOdFGMgs1rjPP+BVE8XWnf4nU+X/ZWUiZ71GCoNFL
         xXp5+5Lwgoc4+vxRpA/1mNvgljWRc/0TiI0jwfWA57emGdpJZgQc2QVPZ0RXiZb571JJ
         Nhe1pGOjPeMpHRMjjqdFhkZHdGYQnnU9Uc/3iqbnlMrHAfisHxno4YC9MVhUYGm5Wt88
         hHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748928690; x=1749533490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Th/HvjGvwZaAq8NqcJZl3dUrBp6q2rEKCyly2o0Sv+A=;
        b=HfNWO4frhmOdnSxH+92qLgbeyMlum8oLDaEpyCLzfXVuGXQWv3/Pie1M49d22DkO6t
         WalKLORsL0kFsvaJYmU383OFRsBub1uLLz1wWmzSfG71bY2REX4r4gQVnTtOrDqBECoq
         w+s2c9IZOd4XF/M3lEuRPS7QNU9ucIiTnR0g6yulWSFSWalMAWfkae+Ks5WCYtRHApPQ
         Ur9AwzLimUKst4XRvzaj3A2rHRo76nV1Slwu7JEtq7LTeLsRFFO8j6V0KgVXCrS1txdl
         yQ37dq41RLV87aDC0jZonpR0qhto87uEx8DpesNC4iomwsJbzeJeryxr2zmjMEZETABi
         mfXw==
X-Forwarded-Encrypted: i=1; AJvYcCXdmEn0Okt4E/j8HoqcLTwoesSkeqMTtDir9wSnPlLeLLHbhWOh6ZYZhKqZqqYerrGnpdR8Nvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfCau1/+ZlxJbSz39jJZrKeApIbGYT7s8/A+5leYL3+LNwV6gt
	yl8MhQjSZoTag8inaBFgPaBX3sy0V4VRvND+1dq0kI0Uh4naR/SMYrMuuUYB5tl2C/c=
X-Gm-Gg: ASbGnctqLBhsQMNAgXdofZsf3IcWVYPcEo0i598bw05KbkTLGw4Ff5UGs49o+NWIEXs
	WKaucfS74j6NQNN8OyzMm2psi9sVYL0pN+vNIEgaSXlLPE1c6qlMKbykJHYr0rpsdXJlzRywakn
	9WdCD8U1fLPJV9/h8zw2YSmYVU3E4nBiIKwKPWOih4DA8wDnuPQ2H32CqL/E4XjvKSNdgg0RCp3
	bZ+jgMy8oJRWr/JDgVDanhxvc/JP0vnv3mbF1UIEnNaebfUbtnrUVfn++jj9HiaPNTRpmvlmRv3
	hjk/QOzewb1w2yzIvuRQacnOr++4huvkTuN6c6Ggmb3+pmRvUqkarDQ73UjwOA==
X-Google-Smtp-Source: AGHT+IHQJUSAAIT0Fv7mF4IgGNvQJWS+3RmfojKIUZALdSibOD1WAD0IIfhREMwYdds3jC/NKwKN/Q==
X-Received: by 2002:a17:903:60b:b0:234:f580:9fe with SMTP id d9443c01a7336-23539647997mr154749915ad.49.1748928690493;
        Mon, 02 Jun 2025 22:31:30 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-235c99ea09esm5054615ad.226.2025.06.02.22.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 22:31:30 -0700 (PDT)
Message-ID: <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com>
Date: Tue, 3 Jun 2025 14:31:24 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
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
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
 <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/06/03 12:19, Jason Wang wrote:
> On Fri, May 30, 2025 at 12:50 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> They are useful to implement VIRTIO_NET_F_RSS and
>> VIRTIO_NET_F_HASH_REPORT.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Tested-by: Lei Yang <leiyang@redhat.com>
>> ---
>>   include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 188 insertions(+)
>>
>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>> index 02a9f4dc594d..426f33b4b824 100644
>> --- a/include/linux/virtio_net.h
>> +++ b/include/linux/virtio_net.h
>> @@ -9,6 +9,194 @@
>>   #include <uapi/linux/tcp.h>
>>   #include <uapi/linux/virtio_net.h>
>>
>> +struct virtio_net_hash {
>> +       u32 value;
>> +       u16 report;
>> +};
>> +
>> +struct virtio_net_toeplitz_state {
>> +       u32 hash;
>> +       const u32 *key;
>> +};
>> +
>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
>> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
>> +
>> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
>> +
>> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t len)
>> +{
>> +       while (len >= sizeof(*input)) {
>> +               *input = be32_to_cpu((__force __be32)*input);
>> +               input++;
>> +               len -= sizeof(*input);
>> +       }
>> +}
>> +
>> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
>> +                                           const __be32 *input, size_t len)
>> +{
>> +       while (len >= sizeof(*input)) {
>> +               for (u32 map = be32_to_cpu(*input); map; map &= (map - 1)) {
>> +                       u32 i = ffs(map);
>> +
>> +                       state->hash ^= state->key[0] << (32 - i) |
>> +                                      (u32)((u64)state->key[1] >> i);
>> +               }
>> +
>> +               state->key++;
>> +               input++;
>> +               len -= sizeof(*input);
>> +       }
>> +}
>> +
>> +static inline u8 virtio_net_hash_key_length(u32 types)
>> +{
>> +       size_t len = 0;
>> +
>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
>> +               len = max(len,
>> +                         sizeof(struct flow_dissector_key_ipv4_addrs));
>> +
>> +       if (types &
>> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
>> +               len = max(len,
>> +                         sizeof(struct flow_dissector_key_ipv4_addrs) +
>> +                         sizeof(struct flow_dissector_key_ports));
>> +
>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
>> +               len = max(len,
>> +                         sizeof(struct flow_dissector_key_ipv6_addrs));
>> +
>> +       if (types &
>> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
>> +               len = max(len,
>> +                         sizeof(struct flow_dissector_key_ipv6_addrs) +
>> +                         sizeof(struct flow_dissector_key_ports));
>> +
>> +       return len + sizeof(u32);
>> +}
>> +
>> +static inline u32 virtio_net_hash_report(u32 types,
>> +                                        const struct flow_keys_basic *keys)
>> +{
>> +       switch (keys->basic.n_proto) {
>> +       case cpu_to_be16(ETH_P_IP):
>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
>> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
>> +
>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
>> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
>> +               }
>> +
>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
>> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
>> +
>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>> +
>> +       case cpu_to_be16(ETH_P_IPV6):
>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
>> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
>> +
>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
>> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
>> +               }
>> +
>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
>> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
>> +
>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>> +
>> +       default:
>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>> +       }
>> +}
>> +
>> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
>> +                                      u32 types, const u32 *key,
>> +                                      struct virtio_net_hash *hash)
>> +{
>> +       struct virtio_net_toeplitz_state toeplitz_state = { .key = key };
>> +       struct flow_keys flow;
>> +       struct flow_keys_basic flow_basic;
>> +       u16 report;
>> +
>> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>> +               return;
>> +       }
>> +
>> +       flow_basic = (struct flow_keys_basic) {
>> +               .control = flow.control,
>> +               .basic = flow.basic
>> +       };
>> +
>> +       report = virtio_net_hash_report(types, &flow_basic);
>> +
>> +       switch (report) {
>> +       case VIRTIO_NET_HASH_REPORT_IPv4:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v4addrs,
>> +                                        sizeof(flow.addrs.v4addrs));
>> +               break;
>> +
>> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v4addrs,
>> +                                        sizeof(flow.addrs.v4addrs));
>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>> +                                        sizeof(flow.ports.ports));
>> +               break;
>> +
>> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v4addrs,
>> +                                        sizeof(flow.addrs.v4addrs));
>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>> +                                        sizeof(flow.ports.ports));
>> +               break;
>> +
>> +       case VIRTIO_NET_HASH_REPORT_IPv6:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v6addrs,
>> +                                        sizeof(flow.addrs.v6addrs));
>> +               break;
>> +
>> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v6addrs,
>> +                                        sizeof(flow.addrs.v6addrs));
>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>> +                                        sizeof(flow.ports.ports));
>> +               break;
>> +
>> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>> +                                        (__be32 *)&flow.addrs.v6addrs,
>> +                                        sizeof(flow.addrs.v6addrs));
>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>> +                                        sizeof(flow.ports.ports));
>> +               break;
>> +
>> +       default:
>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>> +               return;
> 
> So I still think we need a comment here to explain why this is not an
> issue if the device can report HASH_XXX_EX. Or we need to add the
> support, since this is the code from the driver side, I don't think we
> need to worry about the device implementation issues.

This is on the device side, and don't report HASH_TYPE_XXX_EX.

> 
> For the issue of the number of options, does the spec forbid fallback
> to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.

5.1.6.4.3.4 "IPv6 packets with extension header" says:
 > If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
 > header, the hash is calculated over the following fields:
 > - Home address from the home address option in the IPv6 destination
 >   options header. If the extension header is not present, use the
 >   Source IPv6 address.
 > - IPv6 address that is contained in the Routing-Header-Type-2 from the
 >   associated extension header. If the extension header is not present,
 >   use the Destination IPv6 address.
 > - Source TCP port
 > - Destination TCP port

Therefore, if VIRTIO_NET_HASH_TYPE_TCP_EX is set, the packet has a TCPv6 
and an home address option in the IPv6 destination options header is 
present, the hash is calculated over the home address. If the hash is 
not calculated over the home address in such a case, the device is 
contradicting with this section and violating the spec. The same goes 
for the other HASH_TYPE_XXX_EX types and Routing-Header-Type-2.

Regards,
Akihiko Odaki

