Return-Path: <netdev+bounces-143107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E509C12DF
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC7CB21FF2
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379F5634;
	Fri,  8 Nov 2024 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbtkVgEk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706C18D;
	Fri,  8 Nov 2024 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731024210; cv=none; b=eVhabuDOt/Yw0r45Xg1avM8fbZ+vTa1Z1OrFuUmRmFeaPdKOGdSQPAIa2C1JykdxMeWNmwoy2UW8znfwQUtaBTLRNDI5uoOeteE2fluW7d3lpF0KzDl3CrFrPklu3By34ZE6PoJYk8azeSdVhHPI/LQtbE/9Ou4Kjr4wveItpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731024210; c=relaxed/simple;
	bh=n9bWDeW5vZpYKa1EWIO6Aaxmb2lgJzghzNdFgh4Z7+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUeO5z/6xAvJsxo5eT8ezTdZQ/NXIIlHaU1/7vDZU29nudV0QVKwIQNihe7QkMpw33bjy3aSzPdyyvsuZVxVj/ZLCRXMJr/EQWEjtLihXfg/wTwTMYWtvosWHlIPtPVd4XcG2eqS76tmOfZpNrnANV4eZ3to4fojpXZs/D8C+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbtkVgEk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so1002197f8f.3;
        Thu, 07 Nov 2024 16:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731024207; x=1731629007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdaZGYxYC8m9pENuixeMqMxZND/oeqSPxSuhosWpX2k=;
        b=jbtkVgEkBkJPZPA6wyN28WTQ5ZvpF2Xs8VrWqoMftCwA+ZzRHGVAxxqiGCOG5GhqsD
         l+rHdkuxEeSuEX0Im4SVa1KV5/YVIBjD0CUN2WtmjxSTJ889AX96o5zRdkqRZkWmjoYI
         oN96CAMmA8udxMq5+ZW1rTy2expptIyO7R0MZUE11fAQMl/+TcliBqePLnagid6+z9Fb
         jriw+CqsO8Lqx+vFdRaEeZfcAQ5gmH/bqZtvwPtVYaGxiD8CUDaBJlZ8wFe5gKA5o8ds
         mMdw5CrDlxrPte5m2nEAjCSdmG8LTgqk996/pIGhH6/pWcdRCIcYiXzXxmEXLFtuTIsL
         aVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731024207; x=1731629007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdaZGYxYC8m9pENuixeMqMxZND/oeqSPxSuhosWpX2k=;
        b=ctBiK/YYKulZ1DIpfAw07l6qWPRgBxVnwZM63HqcVJxao0z0c53bWhlssIEwo3NOJk
         HGs4alQSLXirAoPvh2VjmBeTVHCREfzv7wv6YNK7Far9DIdGQv790wsj+z4enfXQNO6Y
         A4g1AgynohVbZnkGf3HH5Ikn1/brVID4N0hf1a09ULFMvy+pDaAzXrXQTFUQ/Gnih1Dd
         7r7PCuUXRsxmS/nKBYr1RX6mFSKpSY8fZWSVem159cs2CjKe8fD+QECpL7HNLxpL98za
         SZTSqGqBo/nt+QEdas3aegx+Nb25S7anNLSjLQ7hrI6Oug+4rOfqKmJchXAysIbqkGRp
         dYUw==
X-Forwarded-Encrypted: i=1; AJvYcCVxQplGQ4LiX2pQHjxndrK86NYXpU+A2CrDn51htgK7x9x0AITiIdl9kymdunv0NahBqw5Cv4sP@vger.kernel.org, AJvYcCXIaEkMu3D0K9xjz4hyYY7h7ujymorNxRG5SfPKosJv7B7siODIZusLybBUwV0txcZD2nc+/MXBWj/hWWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2r+6fe+dff0V+GpNzS58XaoI15Yfke7I/0kBIhuBGxLrvKR5/
	g5kJqkWlD34YPf9R04VZZ+2Uwbzq8kvY9qdBzz340NzfCDuQvrN/BiQlV7nha0RkbcqoOuaYuSb
	YJv39jwHU5WwDIzLQKQHwwXayjDM=
X-Google-Smtp-Source: AGHT+IFEc7NyO+GcVgqLLO/1fbGHErFDqjJjgF8qfnwp/xC7aJs0p7mZIadI7elzBknQIAHI8i2bjvnrbFTjDw1Pyew=
X-Received: by 2002:a05:6000:71b:b0:374:c911:7756 with SMTP id
 ffacd0b85a97d-381f183f66cmr698772f8f.38.1731024206645; Thu, 07 Nov 2024
 16:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028115343.3405838-1-linyunsheng@huawei.com> <20241105155728.6f69e923@kernel.org>
In-Reply-To: <20241105155728.6f69e923@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 7 Nov 2024 16:02:50 -0800
Message-ID: <CAKgT0Ud7XrzqAe2rb_MeXEZwRLJxJ_Z2P3=OD+rfRmVOuuLVfA@mail.gmail.com>
Subject: Re: [PATCH net-next v23 0/7] Replace page_frag with page_frag_cache (Part-1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, 
	Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 28 Oct 2024 19:53:35 +0800 Yunsheng Lin wrote:
> > This is part 1 of "Replace page_frag with page_frag_cache",
> > which mainly contain refactoring and optimization for the
> > implementation of page_frag API before the replacing.
>
> Looks like Alex is happy with all of these patches. Since
> page_frag_cache is primarily used in networking I think it's
> okay for us to apply it but I wanted to ask if anyone:
>  - thinks this shouldn't go in;
>  - needs more time to review;
>  - prefers to take it via their own tree.

Yeah. I was happy with the set. Just curious about the numbers as they
hadn't been updated, but I am satisfied with the numbers provided
after I pointed that out.

- Alex

