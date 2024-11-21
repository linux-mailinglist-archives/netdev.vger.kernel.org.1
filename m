Return-Path: <netdev+bounces-146634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2DF9D4C4E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D70280E6B
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 11:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7471D2F43;
	Thu, 21 Nov 2024 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMD6ikVn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8581D0E06;
	Thu, 21 Nov 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189957; cv=none; b=hWNNkAMDOuDQX3On36bnjHZ1msy9MoZPqDzYJSWrUwj8D+ZrVdrHYGL2iuYf1OiNBEvwUIrun9Yr/vSirbXbvDgVFpmiC6CeFJbC2PcDuh+Njq5d1Av53kwVKqGfm19u4mJa72gXtN3YGB/tP28q79jcQzzPnhzNwiI6wqjAxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189957; c=relaxed/simple;
	bh=SPEfxz8D/7+FSyFZN6aXGlPZV776eeSKihhe8baRUdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnAfD1Bw2xqMPDR6q2seeSztA0sb5uk1sqI+n6+tJM5IXdLWfzHjNvbbjsUMKyFRFSv0Umn+zHQsssQNl0kuv4gOhUZN1svah0I3iO26b+4AyztjNf16FQc68Qa5OINmZBFuniPRcQsf53zCEpj7VmKwkZPyzYLRPEopJr49z6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMD6ikVn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43159469053so318195e9.2;
        Thu, 21 Nov 2024 03:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732189953; x=1732794753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HB4YPCa/bzCF4nZ0Gjx/f2iO7SMMcWEq9XBiY6VqTsI=;
        b=nMD6ikVnEwPi+Fp7TGE+fi66QXmReqEmFx7ZYWlYj2wYVHDdEngfzbjlsOZFauMHwd
         3IMbOlliXwrFPJBjIkcoekyJjkrXV7UZdnaeg3GsmWXPkVYOE3rPDi7NNiw49q+vXkih
         r2PHWFbJX7g9yhkRLZBBfNeSEEaAQAaEO2VN4dXF2msIR/es76DUTf+alUkmZsaVL4Kc
         YZsgFU8i9nxgfmuKXmOiECg4ZLJJO8AJqmvmbSU2cvsjUiUIn2SJcqU8ongWJSxk9sA6
         bdWUyESj4tMAX+N86zbAdePEwN3zVWUY539+OwZXqlWqKPnFgUNvydb2sOY5HNI4CqQ3
         zZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732189953; x=1732794753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HB4YPCa/bzCF4nZ0Gjx/f2iO7SMMcWEq9XBiY6VqTsI=;
        b=a65YHZ/gXBrUFNCmRGQ94P/RbkRdKiikaRtOIoYDb9KXeh6eTfDWhhHzJRqzMWzTrt
         DhwXvTN/C02WZhOC12mC8tDB/BaMvIxMrFqciUevE8l93MO6SoSqbU5gIBiPe8Dgw8uF
         YOTruuKS/Orkicg4t3A/C3Io9ZEZcozRvXKBxe1tP2QFSxzlUN2VdVbbRtRMEOKMXT3V
         rFKYITyuqQx+t8iGTLbeiur7XRdJmWoCPei6uQ+t/CIw4GYnt72zXdvBu2MkWx8Mvg8O
         kLDZlmRimobr08bxoEVeAp0qoS5yE5SiPdSFEyeN38xCDeS1+Lnovq4eX/N3wmwBqBKs
         zhEw==
X-Forwarded-Encrypted: i=1; AJvYcCUTs07cKwXS+gn05g5Bex3lndalt3BzRS9CiDo76obFG+657liuxsgJkcj6Iwm6ni/uQszvz46s@vger.kernel.org, AJvYcCW3vtb2fkc7cL4oSLf3X0TDPA7PZsYNehkyOBAY21Rz3fEKMwhJWtKWv5iXg40gOvh1fEWgO8+/0B1ZKuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9kEyeI/AquYxDEoK3GK/U/4Ua3MONm6YJXBRJGbObrXeCtHI
	5mlldeoypRe2OwwQtNLhn/PYlgy0MMfZxRH/0bxvAS2F+dLqLU/J
X-Gm-Gg: ASbGncsPocpS1FAEjtOHaaqBgnW7hhqGj8UsHxIJDGw5VNUrktpPR8Fig1dhKywt03O
	28+PrKEp3kDXw+jEAPQXktQhNyNNL/DK/WGsnS1IN/tb2/Fw7Sx0kvUWgNvnhKAZwFvTS7tTpnv
	BMDzPOqPVUkOwKnK7tsGJHziYTuybNdNOCTRDT5aHpfRIaoTZR7PBXxlQikyHBFAipGQtKEPTQY
	lquC0a4krC/MZ7fbQnGAucccqIWCQOx4FZjky8=
X-Google-Smtp-Source: AGHT+IE29phPPdabLhx0KY5cGqNlPJfGlCbVtxG3bDvpMZcxCR5E9rMrF9JeKqaYuEUa9pDZVoM/Ug==
X-Received: by 2002:a05:600c:4f82:b0:431:558c:d9e9 with SMTP id 5b1f17b1804b1-4334f01d8c0mr24154605e9.5.1732189953278;
        Thu, 21 Nov 2024 03:52:33 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490bfd6sm4781382f8f.25.2024.11.21.03.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 03:52:32 -0800 (PST)
Date: Thu, 21 Nov 2024 13:52:30 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Cong Yi <yicong.srfy@foxmail.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
Message-ID: <20241121115230.u6s3frtwg25afdbg@skbuf>
References: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
 <tencent_0F68091620B122436D14BEA497181B17C007@qq.com>
 <20241121105044.rbjp2deo5orce3me@skbuf>
 <Zz8Xve4kmHgPx-od@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zz8Xve4kmHgPx-od@shell.armlinux.org.uk>

On Thu, Nov 21, 2024 at 11:21:33AM +0000, Russell King (Oracle) wrote:
> On Thu, Nov 21, 2024 at 12:50:44PM +0200, Vladimir Oltean wrote:
> > On Wed, Nov 20, 2024 at 05:46:14PM +0800, Cong Yi wrote:
> > > Hi, Russell King:
> > > 
> > > Thank you for your reply!
> > > Yes, as you say, there is no problem with the definitions themselves
> > > being named. When I just read from Linux-5.4 to 6.6, I thought
> > > that PCS_STATE_ and PHYLINK_DISABLE- were associated in some way.
> > > After reading the code carefully, I found that there was no correlation。
> > > In order to avoid similar confusion, I sent this patch.
> > 
> > For the record, I agree that tying together unrelated constants inside
> > the same anonymous enum and resetting the counter is a confusing coding
> > pattern, to which I don't see the benefit. Separating them and giving
> > names to the enums also gives the opportunity for stronger typing, which
> > was done here. I think the patch (or at least its idea) is ok.
> 
> See include/linux/ata.h, and include/linux/libata.h.
> 
> We also have many enums that either don't use the enum counter, or set
> the counter to a specific value.
> 
> The typing argument is nonsense. This is a common misconception by C
> programmers. You don't get any extra typechecking with enums. If you
> define two enums, say fruit and colour, this produces no warning,
> even with -Wall -pedantic:
> 
> enum fruit { APPLE, ORANGE };
> enum colour { BLACK, WHITE };
> enum fruit get_fruit(void);
> enum colour test(void)
> {
> 	return get_fruit();
> }
> 
> What one gets is more compiler specific variability in the type -
> some compiler architectures may use storage sufficient to store the
> range of values defined in the enum (e.g. it may select char vs int
> vs long) which makes laying out structs with no holes harder.

Well, I mean...

$ cat test_enum.c
#include <stdio.h>

enum fruit { APPLE, ORANGE };
enum colour { BLACK, WHITE };

enum fruit get_fruit(void)
{
	return APPLE;
}

enum colour test(void)
{
	return get_fruit();
}

int main(void)
{
	test();
}
$ make CFLAGS="-Wall -Wextra" test_enum
cc -Wall -Wextra    test_enum.c   -o test_enum
test_enum.c: In function ‘test’:
test_enum.c:13:16: warning: implicit conversion from ‘enum fruit’ to ‘enum colour’ [-Wenum-conversion]
   13 |         return get_fruit();
      |                ^~~~~~~~~~~

I don't understand what's to defend about this, really.

