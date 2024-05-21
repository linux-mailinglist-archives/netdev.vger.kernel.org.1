Return-Path: <netdev+bounces-97299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A3E8CAA24
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFB01C215BD
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795816BB33;
	Tue, 21 May 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OW/zAMo1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F03DB89
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280543; cv=none; b=NdQXPTCrHzQrGM8y42INRn7uB+z93Gc79/hH71anROciMRsXoao6Eo8iGEm6NPGxnM8wLI9O6VePUxDxcvjEwEUKLUaSIxHWSZyPr1D8/rKQZDxSlbxSDKp/i3Xn3qjYTZc9aajeSN7/oX3wVa9jpYrQLTgR+nOkugYhGIV7At0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280543; c=relaxed/simple;
	bh=/nGdawp2NaYJ0qEGR3Cc8zC9byjD0t+r7RzRvUaR/TM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XTXCd8dNGtdR6q0KFjWWevkYpDE+7wGcdG+OXNLh/uZyMM0cl8YhgJAtAV6fIzNOdW+yZIKWy4P64N02QB33F38yJo1tt9mHecV9tK2+zWwItnwsSz1GRQ0rxjRC7SI/T6OpL0EBU5srQA1WXm87S8NdgvqbA/d4iAj6cGSCpro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OW/zAMo1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716280540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/nGdawp2NaYJ0qEGR3Cc8zC9byjD0t+r7RzRvUaR/TM=;
	b=OW/zAMo1gFHKbZukMgnkutM6ZpU58GJ4RewGArK4eMVA1AUa2pa/H4/ku0uI8Azso/FJ44
	CUMMBXEDbL1c+JDLpzrtDTuIQ8KIBpX9CREEsqVCn9l6MQnfIkxDQ084ExwFJbRWxUhGQ5
	VEbXX69HPloRjD5ZtOE7/xHWXqZWGwE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-FDakawQvMV2Pz8ZxY2uDFQ-1; Tue, 21 May 2024 04:35:38 -0400
X-MC-Unique: FDakawQvMV2Pz8ZxY2uDFQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354c3a7f77dso181440f8f.2
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 01:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280537; x=1716885337;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nGdawp2NaYJ0qEGR3Cc8zC9byjD0t+r7RzRvUaR/TM=;
        b=G//G1Se5fa2x6MrR8s1aaxU/GBzYQrXESCw013r0GaJzYWg6zJ5p9SuxNLJzNtxXbR
         L82k0oTwHYqKsNsNCLlq4rN/svZuY/y1MNlxcz4hUDZxSPOJBx0RblvW2F/GfRxra/5/
         rnRTjqJ87o6laYWXsGt9CKXSpNIkpqfY2IgtgqYTT8YeVp/9Bkeyg/23lV5XgpSNUgD3
         GX817B9hh3KmgMD41Bbv5mwhypMbjBpVvdadGWl6CxeBfHxS6COf5JmWc4AXE/L9WUv/
         U8N88ldNgmksGpQKT9chCt2I6ZwSyQHzeaOcvOzYkSdYWIosf8UIiSs48lg4Kq43OpeL
         EKhg==
X-Forwarded-Encrypted: i=1; AJvYcCU2Weh7Xt1OtnZiRZx0qxK0oNXoKpPeYtVrN7JOwyltmKXOrRCSmWjO3wh4ppXK0jB4DEcJPweFGXO/F6UjfssMQRTSFYga
X-Gm-Message-State: AOJu0YwtN1lYT8lJQ6YxY0VNQ+kc1W9/X/e8HiZyE8DA8RPN7iQ+7Qqa
	P1f7uhFN5w/1q50QN8fZ+KqyYc/XDnpqEBDS9VVAY8EDJtynpze9N2DBZrDgK5Id3XbnP3hPpeC
	4Tp+Oj3AjHGpTaYksShqSYgJc9YHVK2cfOGQ8+TRCFtf449+1WfVpeQ==
X-Received: by 2002:a05:600c:1c11:b0:41f:9c43:574f with SMTP id 5b1f17b1804b1-41feac59cffmr228440975e9.3.1716280536958;
        Tue, 21 May 2024 01:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpybhh/i3FLT5nkv4Urg3DzXLx9HVwc1fXQ0xMS+QznFaFgm5R/ZSrF8/c3HPL3ZwWVq5B0g==
X-Received: by 2002:a05:600c:1c11:b0:41f:9c43:574f with SMTP id 5b1f17b1804b1-41feac59cffmr228440805e9.3.1716280536578;
        Tue, 21 May 2024 01:35:36 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42010b1076dsm370769955e9.41.2024.05.21.01.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:35:36 -0700 (PDT)
Message-ID: <eaf33ba66cbdc639b0209b232f892ec8a52a1f21.camel@redhat.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without
 hardware offloading
From: Paolo Abeni <pabeni@redhat.com>
To: Chengen Du <chengen.du@canonical.com>, Willem de Bruijn
	 <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 May 2024 10:35:34 +0200
In-Reply-To: <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
References: <20240520070348.26725-1-chengen.du@canonical.com>
	 <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
	 <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 11:31 +0800, Chengen Du wrote:
> I would appreciate any suggestions you could offer, as I am not as
> familiar with this area as you are.
>=20
> I encountered an issue while capturing packets using tcpdump, which
> leverages the libpcap library for sniffing functionalities.
> Specifically, when I use "tcpdump -i any" to capture packets and
> hardware VLAN offloading is unavailable, some bogus packets appear.
> In this scenario, Linux uses cooked-mode capture (SLL) for the "any"
> device, reading from a PF_PACKET/SOCK_DGRAM socket instead of the
> usual PF_PACKET/SOCK_RAW socket.
>=20
> Using SOCK_DGRAM instead of SOCK_RAW means that the Linux socket code
> does not supply the packet's link-layer header.
> Based on the code in af_packet.c, SOCK_DGRAM strips L2 headers from
> the original packets and provides SLL for some L2 information.

> From the receiver's perspective, the VLAN information can only be
> parsed from SLL, which causes issues if the kernel stores VLAN
> information in the payload.
>=20
> As you mentioned, this modification affects existing PF_PACKET receivers.
> For example, libpcap needs to change how it parses VLAN packets with
> the PF_PACKET/SOCK_RAW socket.
> The lack of VLAN information in SLL may prevent the receiver from
> properly decoding the L3 frame in cooked mode.
>=20
> I am new to this area and would appreciate it if you could kindly
> correct any misunderstandings I might have about the mechanism.
> I would also be grateful for any insights you could share on this issue.
> Additionally, I am passionate about contributing to resolving this
> issue and am willing to work on patches based on your suggestions.

One possible way to address the above in a less invasive manner, could
be allocating a new TP_STATUS_VLAN_HEADER_IS_PRESENT bit, set it for
SLL when the vlan is not stripped by H/W and patch tcpdump to interpret
such info.

Side note: net-next is currently closed, and this patch should target
such tree (in the subj prefix).

The merge window for v6.10 has begun and we have already posted our
pull request. Therefore net-next is closed for new drivers, features,
code refactoring and optimizations. We are currently accepting bug
fixes only.

Please repost when net-next reopens after May 26th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle

Cheers,

Paolo


