Return-Path: <netdev+bounces-153404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642CC9F7D9C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DD618875D0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE62225A4C;
	Thu, 19 Dec 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir/HvO2I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B81225799
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620760; cv=none; b=ZIj5Po0HaQ9bwk3RN5BH/FtebWCZgrML1sj3zhisfA66vkWV60ah8Vk7PcE4tTbrlBI9OlnMyf9MY3tROeJLV0vhvXyg80oKDUP7Jguvcl/yeB4kYW7Txc/zGgULi1MWcpjSBjTOd1EN+2IOl379y91rOWltJwKVSjjoLhiAm60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620760; c=relaxed/simple;
	bh=FVPm6Hv/TdlLqrKyWYNr8r1+ghMZiEwG5LrElSks5fk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PGGwcYOVRp0nElrnzWKk7aVLn3V1AtkxHtir98G+RuyVt0Mcd/5uNgcxxQpBZzm5WiWvDX7OJDe5xs7ZMUYIY6Kya8m+h/szY85fj8mrA3W9BFkbPTzxf7mv1Z50fBDdH1CYV5F2FpaObYSR2I4g2XSD+jKVeogDwUCVRF8NsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ir/HvO2I; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b15467f383so66030485a.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734620757; x=1735225557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFAFaT7H3vJsEqUqZgMndld6HXM2bslGfmNYfbEwjWs=;
        b=ir/HvO2IxVhufNC+GnDOhzCBUNXRALn88d4zLnLZ21SM1D1UmkUVMDGfZsqBOE0vet
         7yQ3rENILg4Fxq6doyiJ4IzMsxJaEBX/nNKM08uv8eXZTHu+fm51VxK7UHiiHoX2k7+O
         Skgi9pHCXLjXdaWvDCkQ2LMIhF6/a4x1haHX5eQeR5jt4muQwXFouEFEKzau4ak6ie/l
         1KkhsSdx9PMbJrGiU+CPv+t1JxzLpl3RjVsDjMDyxqLCsZxH1gcwe6fKot4ei46gRzIu
         b4Ofdrm3UOsudJN7zSA4USNVoxodPaAfTHjhT7fCT7nEl9b8GrC4HHWBin3yKQkK1Qqj
         CXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620757; x=1735225557;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MFAFaT7H3vJsEqUqZgMndld6HXM2bslGfmNYfbEwjWs=;
        b=Kx4jGCig3oZ8x5cR6S9qzuXiZ/pGJZUiCS5qTkLyT9/d5JXGWAuGvAYP9LGGhQHOq2
         RKMhphES7wumGavaKU915OpcJskAUdLijjw6RwjpOMNiIo+yrvVUApU9+stUJ6WOsFDT
         3g+20C9sxH3Ree1iQAsmymQipcsG4kZ8BxijFvFAwrhbDOctvqURmiC8xtPhjL5SEc9G
         q46sCRYEc1NsZvEeNPp3LZD+1U+5OPilE/5ebElmj9NJPyH1FOzVx5oMxxAQIKDukm6/
         xQb0bO7k2x9iRrMJ7mVgHe9EaNn3RZrH+/gfkFs9Y5Fe9ewVLSi7u4dGCuzPcBbX+LCm
         z9PQ==
X-Gm-Message-State: AOJu0YxwTDGIQJ6QlElBn+2/0nbCxTXRiuHDyjk9Gl7OBPksdjH4pSQm
	p1IrIjrudjfZ9qStW16ZkodOov2MAo6yan5IYtfY2WztGETL43qS
X-Gm-Gg: ASbGncsMMVvSYNXxb5yCxNMcPcnpYm9JjsvHq1zH1PAVWOQT9rd/Fb/yLYCeVtrthGv
	m0GOIOeA9KixRbGOosO+ddiV/ZmiSbwooH2GtCEUr/WMmpZ3r0FSrjLHPhhB/DjApojBBNZEKYD
	lyOsP0kHohpSszersQFPna96jbqv+4Rn5RELWC0oqU/3CmuyU3wrzgZ7FT64kBu0nAmLInXhRUD
	VG2VSma8VPqeVB60iJ26TdCUmirrp72VGNkakCo09cdygl2sFhwLsQWkjNlNIT2eEJmnEEby9yO
	V1luFnhnZTBmHf7wiFifnYOgTl6Y206c5Q==
X-Google-Smtp-Source: AGHT+IHxVSLVfe2pwOKsdi9/cnNsKhfPDaez/0PMOVLhzZTX1detS7jXcy82ffFhZjts2wBxEf0dkg==
X-Received: by 2002:a05:620a:4453:b0:7b7:106a:19a0 with SMTP id af79cd13be357-7b863720701mr1166403885a.24.1734620757491;
        Thu, 19 Dec 2024 07:05:57 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2f8fe6sm55109285a.51.2024.12.19.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 07:05:56 -0800 (PST)
Date: Thu, 19 Dec 2024 10:05:56 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Message-ID: <67643654983ec_1d0f5c29421@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241219094411.110082-8-milena.olech@intel.com>
References: <20241219094411.110082-1-milena.olech@intel.com>
 <20241219094411.110082-8-milena.olech@intel.com>
Subject: Re: [PATCH v3 iwl-next 07/10] idpf: add Tx timestamp capabilities
 negotiation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> Tx timestamp capabilities are negotiated for the uplink Vport.
> Driver receives information about the number of available Tx timestamp
> latches, the size of Tx timestamp value and the set of indexes used
> for Tx timestamping.
> 
> Add function to get the Tx timestamp capabilities and parse the uplink
> vport flag.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Co-developed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

