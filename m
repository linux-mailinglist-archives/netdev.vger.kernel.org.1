Return-Path: <netdev+bounces-79122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0995877DA0
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 11:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2FD1C2146B
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02A0224C6;
	Mon, 11 Mar 2024 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiadTp4D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CF117578
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151732; cv=none; b=M5OirN/g/HmwN2VUc7NLYjncVBmJtF12iLiq8k2/+tYG430TfLIMkc/+9g5jKqjQaZRmGJnNQ4zQA7cmwCWJ4SZY5TAThRyIp4Wg+FVL6bK+DXgHSD3ZT8/i1IQTBHLAzv95ywu0gTgB08g1nZQ8+h9nCjmIwGVMsAvgmKMxvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151732; c=relaxed/simple;
	bh=Ovwo7VIeigpL78gG7b3Nu7lj9gtkOKBjriHGZXbmI+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stlZYA8B//3nz7CZsSXrCqD6AtbWXw7uXUdZ3wnzK5t+hRx0K6z5ejm4u0foQYPbUIXfHG5BfzbKJFxZWgLE+QZbYzzP5JGgA4K81YNXbWL2qTlZmkwpBufg0v2i+gvPAYgHCPxykKMbjP7mm14i4jJDfJOGLpfnHqSo/MTHcGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiadTp4D; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e68bab3e4cso845452b3a.0
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710151730; x=1710756530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONqgNhueVqdvnlu+KC8nyUL3u/R0fwalK8XigbbP72A=;
        b=CiadTp4Dmkd0iwJItBH81LV7Th93kXZhmz9idRh57MIeTZ4+JQaK3t+z7ymNYZq5vx
         ozjDiLJB9fhWwTrg1YhSRH/VQiLwbpYlCi1bc/VzE5Ghho3sdt6007En9S82STreN2V4
         XJr2rlsO8wzSEvxOsnFluTS27kQ1pGiYO+t62SdEYF/NFktSjV+uhrjnAZLkpuXV02AW
         fwhwtTxK+fmFp3baB7bQlm/diNxicNMMzMYviY5z4eJ5fjbF5MJY2vMiifnnq0/3GOlJ
         uACqHyhh4rm+TcMvEvWvfhOQvmD4doRxd+4h63xHSZnmvlbg4zvVl0QQIvJIYCWmVHM7
         vlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710151730; x=1710756530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONqgNhueVqdvnlu+KC8nyUL3u/R0fwalK8XigbbP72A=;
        b=i6M4b/lkMlvFfz6PGbVao3M67ie9lx/afozW7V5x8H+aBGWL7LNhZulrr68f57XG+N
         if2Ljbh9jqVCYUxFrfkeGalOVa2R1csnEu6OFwhE6oLzDJICrW1wqH1ehD7Y60P+TJ3p
         3LWIn67j+ftIEdImjfZBzIqPWHqv8Iel8768zRgqOKBZzahCcNPKB+lAQWnJgtV1UxRv
         87NLHP0QSWPiRIkbSoZQgdTO27JBbOBkfvGSXvqx3bDRgzCUrORM7gqPJdhBAe8hCY7p
         HhdCuGFmXA6QLiCNBxtcKiY+6CWCGI+wc3SgTqIlVMUFUuxGoNDTBgyPcH6SxriR/YIn
         vsEQ==
X-Gm-Message-State: AOJu0YzZg0yguKprivn+s3mc3/HNK5BbniRNEe/82sLzRVJCR977MDgr
	urZRue80Y7JjJ4hFH9yguwLmIC5u4SOkqpi3nOXvcTCRMqhb9Kbt1wOsruvKpjTjjg==
X-Google-Smtp-Source: AGHT+IE2ShIes1zcBOkgorVuvyqbCmurDEk8b5EcBjWFw8eypv8WFPabxzcuuxdVEQ/eETtZgSvp+A==
X-Received: by 2002:a05:6a20:da9d:b0:1a1:4624:bf28 with SMTP id iy29-20020a056a20da9d00b001a14624bf28mr7829728pzb.7.1710151730294;
        Mon, 11 Mar 2024 03:08:50 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78543000000b006e5a09708f8sm4150727pfn.174.2024.03.11.03.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 03:08:49 -0700 (PDT)
Date: Mon, 11 Mar 2024 18:08:45 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next] doc/netlink/specs: Add vlan attr in rt_link spec
Message-ID: <Ze7YLcBgbxJzKod3@Laptop-X1>
References: <20240308041518.3047900-1-liuhangbin@gmail.com>
 <m2sf10g9g6.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2sf10g9g6.fsf@gmail.com>

Hi Donald,
On Fri, Mar 08, 2024 at 01:05:45PM +0000, Donald Hunter wrote:
> > Not sure if there is a proper way to show the mask and protocol
> 
> Using display-hint, e.g. display-hint: hex, is intended to tell the ynl
> cli to render output in a human readable way. Unfortunately it currently
> only works for binary attributes.
> 
> It can be done like this:
> 
>       -
>         name: mask
>         type: binary
>         len: 4
>         display-hint: hex
> 
> ./tools/net/ynl/cli.py \
> --spec Documentation/netlink/specs/rt_link.yaml \
> --do getlink --json '{"ifname": "wlan0.8"}' --output-json | jq -C '.linkinfo'
> {
>   "kind": "vlan",
>   "data": {
>     "protocol": 33024,
>     "id": 8,
>     "flag": {
>       "flags": [
>         "reorder-hdr"
>       ],
>       "mask": "ff ff ff ff"
>     }
>   }
> }
> 
> But it seems wrong to change the struct definition for this. We should
> patch ynl to support hex rendering of integers.

I only processed the numbers with hex display hint

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 2d7fdd903d9e..d92b8ef287a1 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -787,7 +787,11 @@ class YnlFamily(SpecFamily):
                 if m.enum:
                     value = self._decode_enum(value, m)
                 elif m.display_hint:
-                    value = self._formatted_string(value, m.display_hint)
+                    if m.type in {'u8', 'u16', 'u32', 'u64', 's32', 's64',
+                                  'uint', 'sint'} and m.display_hint == 'hex':
+                        value = hex(value)
+                    else:
+                        value = self._formatted_string(value, m.display_hint)
                 attrs[m.name] = value
         return attrs

And the output looks like:

{
  "kind": "vlan",
  "data": {
    "protocol": "8021q",
    "id": 2,
    "flag": {
      "flags": [
        "reorder-hdr"
      ],
      "mask": "0xffffffff"
    }
  }
}

Do you think if it is enough?

> 
> For the protocol, you'd need to add an enum of ethernet protocol
> numbers, from the info in include/uapi/linux/if_ether.h

Thanks, I will add VLAN protocols first.

Hangbin

