Return-Path: <netdev+bounces-173980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42798A5CC12
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088EA189ECC1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D332620D1;
	Tue, 11 Mar 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X58NCqyR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4C255E20
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713885; cv=none; b=YzJ8VvFUDJYVW6Bf0hlj//MJdC+fl7ErJO9oZ/AxUD/qXC9Rqq+kuyCLZnpLvfQvY5yV1CtXWGf3on+qseAp22DBo6aw171Fwag43S2YP5RnrWMjBYPmYy49iIZsnLXMeruug5z5uJurawzfHr1BwEW11ixJCmZ0eDAnCbCiRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713885; c=relaxed/simple;
	bh=23WEmA1xwXqrixvmth+8vfD9pcHhrPxRBsbz9uo6l6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWkBd+xxgHOiTZ6EYxt2FAnFAOnS9w+nyyDlADw3nw26+kfQy41xxPISYi79wwVSR8gLU0g/b9NOeA7Qlm665aO+pnnvYJecVpL4ngQ47iEY6pt2BwD8fXOJLSM5hGe4u3BPch9DI93QAgvfAOTpt3RmcmprYx5pCPphxpykszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X58NCqyR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741713882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaabvf2fNLL0Tl+sswB36fJriGPMxd/mLSx8KRQGe84=;
	b=X58NCqyRJjxX0Cki928+mqTqbc91tysNAgJ6ItHKhdU4nCTNxfSoWn6IMT/AXslql54aIU
	jzu63hSoABOd8KgyKmQuj7pQF1BBfE0TKl8BoQMDK0JHbCI9dA9T+nc29WRYEh/Z6ENThD
	4iJBy6GVeTUdANRMaaIfKP3tD8OhPtU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-mwMhB0-BNGayAOd-Jp9OZQ-1; Tue, 11 Mar 2025 13:24:39 -0400
X-MC-Unique: mwMhB0-BNGayAOd-Jp9OZQ-1
X-Mimecast-MFC-AGG-ID: mwMhB0-BNGayAOd-Jp9OZQ_1741713878
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cfd9b833bso218305e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 10:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741713878; x=1742318678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaabvf2fNLL0Tl+sswB36fJriGPMxd/mLSx8KRQGe84=;
        b=OpLNzQPDgawDibxylpk/7nK/WMTCGsl1qen5atuBcJhnQ9LkZYetZ1j2o2MhbQylaL
         VZAd3qV1bXi10X/l430TWxxqJBTH34/PR/vFvSi+DB1sFzv9pBAB0zT8+lVTNPu1PYvN
         d8k6Ip0wpnL/jffVDNsVj5ya8VB0l/pzG1kP+iTHXvyVmckIkSMTdMDDOizl0rzWcHoh
         GxxPIS46FomDl271lG9xFN+f+KdHySzF/XY2hqFVplnrz/P2R8aClI2vpbWCGyCjMoeO
         +AOf+13l+0oheKGdZg3GqiqZ6bJGgWPw8qx+gdAsJzwJ+2M8/+M4LV08CYpfE8Cg/dDr
         Et4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9xXIp8FIBZoxVVTrVoTxsWZtK0HqovC6Cq2n+oCLRvFctjTLtaFGWaZVRITZu95VR5DJFwOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhtPjQ4VJfTkWDpg3uPzrwKH+lk8q76dd+OP3+pgqDRSuAuyw
	8LsD95cNtAkbeYdy0m4j2FtOZ+l2LbtUQrBqscOGLjasnv/mRQqpvv1vaba5SxIrOuBM9QlNUMY
	dHPHclSTX8qtjZjnSgMcRehU6dBJPID5Lk74yUBqIzF3aOjE1Ck2bqg==
X-Gm-Gg: ASbGncsv4Rtnj20ZuM9qc0FAnpwdDlKqUv+gO3U8cjXqSWyXFVHPKS+0H7auwHObVCf
	eWRou58XlVML8DXOY36NipWyy8lQdQ1NO/FwmOxr+65BTi6ySvTQdQmqRo07OauFTkOdVtxdTdb
	CGE+7Lc8SI7onCgYZUAo+3CcX8y5Vrg7WTOTSHIkhSbBnOTzDQTG7eDh4ffNEqNKq8yWsjHWVHT
	n5umJtM7b2HQRwTuzqSVeqyDovQQjcCupS2LzzJm0LuL66yYNRsQd/N+TVDFLxPe5nqE9qg5PvE
	MEZ0YokJmE+B94mAAMTz2/bBEZaKlbIzephXkCD1qhqmMw==
X-Received: by 2002:a05:6000:1fa6:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-3926cb664eamr5689838f8f.16.1741713878316;
        Tue, 11 Mar 2025 10:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9zr+MhJdPizgyC+JWDbVtJG8HIRVBlyI+/PeF2RPWWFVW8cUrzQbTniKDYW1+SZoRmQMgvg==
X-Received: by 2002:a05:6000:1fa6:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-3926cb664eamr5689822f8f.16.1741713877988;
        Tue, 11 Mar 2025 10:24:37 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103f57sm18734500f8f.91.2025.03.11.10.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:24:37 -0700 (PDT)
Message-ID: <8a47efb6-ee87-4287-b61b-eff37421609f@redhat.com>
Date: Tue, 11 Mar 2025 18:24:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/2] udp_tunnel: use static call for GRO hooks
 when possible
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 kuniyu@amazon.com
References: <cover.1741632298.git.pabeni@redhat.com>
 <b65c13770225f4a655657373f5ad90bcef3f57c9.1741632298.git.pabeni@redhat.com>
 <67cfa5236c212_28a0b329453@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67cfa5236c212_28a0b329453@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 3:51 AM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
[...]
>> +void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
>> +{
>> +	struct udp_tunnel_type_entry *cur = NULL, *avail = NULL;
>> +	struct udp_sock *up = udp_sk(sk);
>> +	int i, old_gro_type_nr;
>> +
>> +	if (!up->gro_receive)
>> +		return;
>> +
>> +	mutex_lock(&udp_tunnel_gro_type_lock);
>> +	for (i = 0; i < UDP_MAX_TUNNEL_TYPES; i++) {
>> +		if (!refcount_read(&udp_tunnel_gro_types[i].count))
> 
> Optionally: && !avail, to fill the list from the front. And on delete
> avoid gaps. For instance, like __fanout_link/__fanout_unlink.
> 
> Can stop sooner then. And list length is then implicit as i once found
> the first [i].count == zero.
> 
> Then again, this list is always short. I can imagine you prefer to
> leave as is.

I avoided optimizations for this slow path, to keep the code simpler.
Thinking again about it, avoiding gaps will simplify/cleanup the code a
bit (no need to lookup the enabled tunnel on deletion and to use `avail`
on addition), so I'll do it.

Note that I'll still need to explicitly track the number of enabled
tunnel types, as an easy way to disable the static call in the unlikely
udp_tunnel_gro_type_nr == UDP_MAX_TUNNEL_TYPES event.

[...]
>> +	if (udp_tunnel_gro_type_nr == 1) {
>> +		for (i = 0; i < UDP_MAX_TUNNEL_TYPES; i++) {
>> +			cur = &udp_tunnel_gro_types[i];
>> +			if (refcount_read(&cur->count)) {
>> +				static_call_update(udp_tunnel_gro_rcv,
>> +						   cur->gro_receive);
>> +				static_branch_enable(&udp_tunnel_static_call);
>> +			}
>> +		}
>> +	} else if (old_gro_type_nr == 1) {
>> +		static_branch_disable(&udp_tunnel_static_call);
>> +		static_call_update(udp_tunnel_gro_rcv, dummy_gro_rcv);
> 
> These operations must not be reorderd, or dummy_gro_rcv might get hit.
> 
> If static calls are not configured, the last call is just a
> WRITE_ONCE. Similar for static_branch_disable if !CONFIG_JUMP_LABEL.

When both construct are disabled, I think a wmb/rmb pair would be needed
to ensure no reordering, and that in turn looks overkill. I think it
would be better just drop the WARN_ONCE in dummy_gro_rcv().

/P


