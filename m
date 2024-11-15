Return-Path: <netdev+bounces-145398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64069CF638
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733462815AD
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525DC1DDC0B;
	Fri, 15 Nov 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF3P6xWl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2F1DA23;
	Fri, 15 Nov 2024 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703140; cv=none; b=AKg9dj5NS7OmyOD9wR3ehh4ZiKdMa7JJfRs0aRS1esULImmfIt/TZiU4Wepb4pmxmM8PlBxgF3zRzzDNWzaFTH2laAdZ/2sX9qWs1vPkYN2oPyyjwMdjmDzk4AyeeBeWwbGLCulKt2NaqI3uKh60xBMTSCpvvIIFXB2hS8dFll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703140; c=relaxed/simple;
	bh=HmEnM+iG5llMTrozjs2jeXTA5qHKx/9EjVtnDhmpmF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZK6TCybTGPn0QkaUAVguvexgu+iVlqvV/0aYEXC4P+a/ofmSroT3m9Ykg4V1PhBrusyCwbPj9dMJg3WUt8TKTb6EmCHauu8pR3fhxWf8Z3bfoKFalu7UcFWr+1qv0CbUGbOn0KRgi3d3uZajiq5qaTq+BwzePMkfEAWw67B3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF3P6xWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DF2C4CECF;
	Fri, 15 Nov 2024 20:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731703138;
	bh=HmEnM+iG5llMTrozjs2jeXTA5qHKx/9EjVtnDhmpmF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MF3P6xWlLctWVYwhRcJK1gQEkGa6GA27rk6D8DLQqoU71lsoJzsgEeTa22ePavaDJ
	 gZj5YYcS8xeJ5kHftOhvjFkDZgyOEnbj3eAUGyVNJ7NBhY/5/1ThLjcuX41pngs4ZI
	 O5+wxn69e2O781qFGyLaITU8KOmUfu+kmbPjMaJy5EhBavUOg5JMsyNvsEljIeIWqD
	 JCX65/jnCFc8d2ipsdSTcX1CBWxwWT29XTAUf1ITxYCJCZ6mpPWMYIoA09qqlhTBhT
	 yCHsQT1Xo3/KNWH1Rgo6WQcRXTfDgz2XnXCF4WJXwbn4EXkZWnLEwaR/95EE+y8XCe
	 fu3EfzW2Vcrsg==
Date: Fri, 15 Nov 2024 12:38:55 -0800
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2][next] UAPI: ethtool: Use __struct_group() in
 struct ethtool_link_settings
Message-ID: <202411151215.B56D49E36@keescook>
References: <cover.1730238285.git.gustavoars@kernel.org>
 <9e9fb0bd72e5ba1e916acbb4995b1e358b86a689.1730238285.git.gustavoars@kernel.org>
 <20241109100213.262a2fa0@kernel.org>
 <d4f0830f-d384-487a-8442-ca0c603d502b@embeddedor.com>
 <55d62419-3a0c-4f26-a260-06cf2dc44ec1@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55d62419-3a0c-4f26-a260-06cf2dc44ec1@embeddedor.com>

On Tue, Nov 12, 2024 at 07:08:32PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 11/11/24 16:22, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 09/11/24 12:02, Jakub Kicinski wrote:
> > > On Tue, 29 Oct 2024 15:55:35 -0600 Gustavo A. R. Silva wrote:
> > > > Use the `__struct_group()` helper to create a new tagged
> > > > `struct ethtool_link_settings_hdr`. This structure groups together
> > > > all the members of the flexible `struct ethtool_link_settings`
> > > > except the flexible array. As a result, the array is effectively
> > > > separated from the rest of the members without modifying the memory
> > > > layout of the flexible structure.
> > > > 
> > > > This new tagged struct will be used to fix problematic declarations
> > > > of middle-flex-arrays in composite structs[1].
> > > 
> > > Possibly a very noob question, but I'm updating a C++ library with
> > > new headers and I think this makes it no longer compile.
> > > 
> > > $ cat > /tmp/t.cpp<<EOF
> > > extern "C" {
> > > #include "include/uapi/linux/ethtool.h"
> > > }
> > > int func() { return 0; }
> > > EOF
> > > 
> > > $ g++ /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2
> > > In file included from /usr/include/linux/posix_types.h:5,
> > >                   from /usr/include/linux/types.h:9,
> > >                   from ../linux/include/uapi/linux/ethtool.h:18,
> > >                   from /tmp/t.cpp:2:
> > > ../linux/include/uapi/linux/ethtool.h:2515:24: error: ‘struct
> > > ethtool_link_settings::<unnamed union>::ethtool_link_settings_hdr’
> > > invalid; an anonymous union may only have public non-static data
> > > members [-fpermissive]
> > >   2515 |         __struct_group(ethtool_link_settings_hdr, hdr, /* no attrs */,
> > >        |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > 
> 
> This seems to work with Clang:
> 
> $ clang++-18 -fms-extensions /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2
> 
> However, `-fms-extensions` doesn't seem to work for this case with GCC:
> 
> https://godbolt.org/z/1shsPhz3s

Hm, we can't break UAPI even for C++, so even if we had compiler options
that would make it work, it's really unfriendly to userspace to make all
the projects there suddenly start needing to use it.

I think this means we just can't use tagged struct groups in UAPI. :(

I have what I think is a much simpler solution. Sending it now...

-Kees

-- 
Kees Cook

