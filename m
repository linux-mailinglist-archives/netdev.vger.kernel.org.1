Return-Path: <netdev+bounces-225674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EB3B96B9E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0FF67B70F0
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44A42E1749;
	Tue, 23 Sep 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2CLwhMfY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68385266B56
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643569; cv=none; b=hAtZhXyQAgSvisExZRTj/cYStQBNWinSOgSTjAjgEOUPIoFU4BhQ+pMKevgSrw+L4hsqvIp5Z2p6mmcyVRwlZvwV8rcBOOZtFQiT7jBUjYzqVJ8PKeRJbk7Be4tymwNkZaFZjOULKlOxHHxzO9q0jCSMDQpGX5zK9I0bTKW1n8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643569; c=relaxed/simple;
	bh=+elWHMdwyucxJxnLVF5sZ33MtWaAF5TQMhPS+5nZJfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4msH0Bf7qAgm2Tnvvb1BZgxI5IKkypShlxNHXeIua27u4D5HSU8YKK2hEcYsNG4LOteBc1nsOiVVZY+zgBeruTvfmdHwVC0iU37rOoKWLrcZQQOWWsVy4rD1QghA5SXY2O6R5wC9WiWcAeZBhH5BD+h6q1HX0XVQMrnFj017mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=2CLwhMfY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so3838548a91.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643567; x=1759248367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x71NaeNBIF0XIXPAkDvf+aw7re0CQhVMKd4/I/OtWro=;
        b=2CLwhMfYBZ6hyY4q3Q2GPS5AA9G/f71+sOinbNjirq+SOFDkDYGL+MZ68reC5/nFYH
         1KEbUQzIsoBnXqYi6dkJGKAynXH4Mxx5IztxL8gQe+ErafXuXuXCCaGtKv4PXXvjjg8Z
         yAdQgM2Kb9e+0ECq/joGoiijSj3Y0Vd3B9k8rgn7AuTrCOwceK/HU53wiWKaV5RVBwkv
         QTUnWVOc5a8l5N1P8Rfnlq+aw2PaJYMtSk5AnsIUQQ35VHuN0UuNTYbt7H6g5xfiVBMi
         PtifPfZFC1kCBgmPDXtyfqqOvdOg8138yhZLF0xR52eMQvr1RN74kpf89uHT+6K3KTqJ
         2VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643567; x=1759248367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x71NaeNBIF0XIXPAkDvf+aw7re0CQhVMKd4/I/OtWro=;
        b=vyBdI13ivsOMca6T/tmgvgnr2BFf0T+Z/PRA6py0Axn+0FI8LrR7PIQP4kfEtRQ1YU
         B4KjuEM7MGKpryyGDSZQaSFpyBUq2SqrrHQ5U0frfiIS/tm9FjAtS3D7Vjg/LfLoUvtF
         4a1y5XlxrC1xMzxyzu33aSJh+S80VquaXweUKbK2Dly6S+g7BmbPBhgVSDSaI56xBnYk
         chfBX+gBnYeDhF+qQa4kwqk0zhxObsPHAtJADCybLIirhTr/du/JmfNRr7IZgIeyt6DL
         QyvNz9gSVx03//wkjOhd3zuPJmDV2rz8TUkFTCkF7h0GytK4W03H88Vu0Q10R+q35Jgd
         rPKQ==
X-Gm-Message-State: AOJu0Yxfz0guwN5lVejBYm/86i60ry5mfkgvJGweeu8g3PhbwKxgPIeb
	euqb0E3IASqb0eBE5Qj3AGtmgfkH/9Q64kv4EOcuqcGFitDnKNNAg4FSVlSzHcnfll0=
X-Gm-Gg: ASbGncvGFnonGODtwD63sSUPK8yFTPBdBx0DPdttbtXFJJvh0sm2MmxBqOTOcZk6b8O
	WLuBGJC4c1g/q7ArjVCe4O+DcerQir42qB0C6JYrB3Ar6jT+keER6ehZp31sXogZxeyORkrMBAS
	Hz64lvauQJCCza9SEpi9HhLjjTpYRX8Gv1kBK2e7OT+kdXUBy4CGiijnhlpk3IzWMnb0EyfzVtB
	xUdGwKUVv7h0afUv3UgBxxxBYieG9C9vrzhBtMayMrKcVKzD1Q794EXo3RciObfGNM6PW+9eJEq
	vFyoiWBb/jPfSWVszTx1YubctwvNFVwE5Q3RVD0k44axU4nM4GXw3oAT5Iz9Rw8x+hp1om9WWXs
	1+HSXe0FbTgh2K029mIbnlseLWHyqxboWhH+xt+GJ9okL/KpjE7I1ofsN+/08PCgx
X-Google-Smtp-Source: AGHT+IGxbjHUkRogA/ixnfg9Umf6TlNL5FnLHgd4GBDTZCkGeyMIVUqswwXPZSfcq5ph4sQe8I4t0w==
X-Received: by 2002:a17:90b:4a06:b0:32e:a59e:21c9 with SMTP id 98e67ed59e1d1-332a990a97emr3752881a91.26.1758643566472;
        Tue, 23 Sep 2025 09:06:06 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-332a970646fsm1313303a91.4.2025.09.23.09.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:06:06 -0700 (PDT)
Message-ID: <dc23879e-1c63-4158-b002-c291548055cb@davidwei.uk>
Date: Tue, 23 Sep 2025 09:06:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/20] net: Add ndo_{peer,unpeer}_queues callback
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-5-daniel@iogearbox.net>
 <20250922182350.4a585fff@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922182350.4a585fff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:23, Jakub Kicinski wrote:
> On Fri, 19 Sep 2025 23:31:37 +0200 Daniel Borkmann wrote:
>> Add ndo_{peer,unpeer}_queues() callback which can be used by virtual drivers
>> that implement rxq mapping to a real rxq to update their internal state or
>> exposed capability flags from the set of rxq mappings.
> 
> Why is this something that virtual drivers implement?
> I'd think that queue forwarding can be almost entirely implemented
> in the core.

I believe Daniel needs it for AF_XDP.

