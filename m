Return-Path: <netdev+bounces-225678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCFAB96C37
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11051172790
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3962E092A;
	Tue, 23 Sep 2025 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="lE9XVShV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4B258CD9
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643688; cv=none; b=F4gKLilt4TsWVwZAI8hzCurDtektr/DpIp1EFyq+lpLlMR4/PWFzS1LjMiynBe6hNf7ZehNp2I4Mw4QzcL9Obw+84s1CKTnSyuT6Xpbc4pr90oA6y/zqD2bntGCaOlGF8LFwoQwYaXfv2hp8zRpftVH1ggGvtu2QRMHeaoZCiTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643688; c=relaxed/simple;
	bh=p8/sU2tNQ6ZVFyaeHTs5DVYywGuz924qBYYmz835ZQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKITE4kDdCHsXAvYaCceeTJormX2kGmY6kq2BjEhFjaHsjgcfqCh8M3sgKp1gd050/+TivcephYetHCJhHro/VoWwr8t1Qs4IEOIrJBew5JUdEIamj55I1ibGf8nhQpR+VaT80Cx9hSHwAvqdxQeslyQ4X4j+y5o8dalWV813e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=lE9XVShV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so5828910b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643686; x=1759248486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zu1L3h7cbarGsKN8oBuSeczv4OXYLgkrbzeyl4MK5lo=;
        b=lE9XVShVJseVEVwvKOOIYBgNMy2vEUM12dDSymQGJTyw2Er6CoAYIsUJHaYm4eIQKr
         X7Ns2G9kljeIYudUNKbM69TbhQ+92h5ntFU+u87QwpOcXyQHOIN11dHH13x3PHZkLPKq
         LS9gcKQNi3zPhlwWqrxKZNf1CyJTWG7/2hx/4E4DaMZILpNGRLeTlpfSz0sdyd2zclWR
         6fqfJpi/zmEWd7STP9mNGcjzPRjYzHjwEDHrI8t184GcqrYfFf1LWRu0YlyJ1dce4MNS
         sZ+1qW3TOFVVcUWeBI6xzztGscjSXXnLJp/NFJFCnjrEHIOi3tkT5q65gr1hv7zC03Ui
         bbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643686; x=1759248486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu1L3h7cbarGsKN8oBuSeczv4OXYLgkrbzeyl4MK5lo=;
        b=mUTlcU7999xfTr8MANkcZvs9P218auCzvr3qEYE28JIglql49jZEIKRP5J2pmCDRQ+
         UPB9tKpLgFsJj+2dlVZYwdZ3G+4HLUNOrZVb+JpptAhr8BjJ2oPsfWUmQwEHWktSNxvR
         62AFDBUm4MSXLXZIK3C+X8JMFimWvATm6RuDFKJbhHdq8sKGZUjjvQEe6oOkuPK1CQL7
         o7DmOpw223B7aRHXO0KEaiKzo7qr5kSHIGvKOSJrS6afzBZq+8JxI39ewKVBA4qcH9dq
         Y3395x+GvLo4vm4c2zW2NRmbUFtiEhQWdpWbzmCvUQwQzcRt5K5y9wLcY18G07l5SE+0
         y16Q==
X-Gm-Message-State: AOJu0Yzqr+XtIAoWO8w+q89BcVAYYJh4dDlFZXr9KFBXYBWbP9L2if0u
	OIcHdXhaWY10sjkeQAstaQUKgCkcPeqHqFILXFCeq/AQ9mz1csUfqsKrBTR6jhmKMc8=
X-Gm-Gg: ASbGncvzDtIiXBdqrSf4nKrlY8eKHo/oFBbGSDEMTb6zQgOxxRmlghDfeAD/vPJMNyU
	sUXEkvXQCGukc/0Zx8ujGrXr/gskU2hNXP2hWGTTGt/v/yJBeGbqtbZypA4+sTlVtAk78gfRyN8
	tKp1fJv56WSM8d/WIS34VUFCF9q+K4R2ugbbUvlHVW34nQgpVbCisor6bIF0suvdan7JxZbSG8S
	vsICHIJgxEOBC8cLRekf6D/Brqn2xy0ANdMrjP7zZh1hp59gv67Rk8//ZX/iAKBEaJFy3twKyZi
	plcFj4sX+rQJ7A02VBNxwv5zD57a9uu582AnQ8B3U8PTf1XHljHIeY9whU5tXI+YCHqVmsGps7Y
	hyJFGLPfbdkfHIUygAAWGCJ+yrz6fa9fDnpM0Xmgm2vo+N5IABWzTUTzWlG78hLCS
X-Google-Smtp-Source: AGHT+IH8WL+N13QtR323irJ+BhiHiyPSqzdWQXcpIgZXUPY9M+dQxu5Dzl7g7Rct6z/RVkCp5rSebw==
X-Received: by 2002:a05:6a00:cc4:b0:771:ef50:346 with SMTP id d2e1a72fcca58-77f53a2c4ebmr3640447b3a.15.1758643686042;
        Tue, 23 Sep 2025 09:08:06 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1ef87dd8sm9608991b3a.75.2025.09.23.09.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:08:05 -0700 (PDT)
Message-ID: <d5933562-b6d7-472f-97a7-3d72da3ff51f@davidwei.uk>
Date: Tue, 23 Sep 2025 09:08:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/20] net, ynl: Add peer info to queue-get
 response
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-7-daniel@iogearbox.net>
 <20250922183254.5990893d@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922183254.5990893d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:32, Jakub Kicinski wrote:
> On Fri, 19 Sep 2025 23:31:39 +0200 Daniel Borkmann wrote:
>> +    name: peer-info
>> +    attributes:
>> +      -
>> +        name: id
>> +        doc: Queue index of the netdevice to which the peer queue belongs.
>> +        type: u32
>> +      -
>> +        name: ifindex
>> +        doc: ifindex of the netdevice to which the peer queue belongs.
>> +        type: u32
> 
> Oh, we have an ifindex in the local netns. So the API is to bind a
> queue to one side of a netkit and then the other side of the netkit
> actually gets to use it? Should we not be "binding" to the device that
> is of interest rather than its peer?

We are binding from a netkit queue to a physical netdev queue of
interest.

Sorry, the terminology in this patchset is not consistent and confusing
clearly. Will address in v2.

