Return-Path: <netdev+bounces-126615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0897210B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB9C1C2306F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901E117D896;
	Mon,  9 Sep 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbPmw/Jp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2891D178399
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902946; cv=none; b=pg4qWxTu2O9xpwsMoyI/Up79aj8C22e33CDbC7O/iMFDl/EoK1QDc6wDbqvSQMJSzJeV/wVMISj0zi/8fWdtcFgmg6s9O9TMedi4oU/XADLd6PVX4OxnqhSOTeJcTc6eOR/wO7B28dDLoB3w8tADXssUADWUqcnxRzAOW4CooU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902946; c=relaxed/simple;
	bh=04f/NG7uG8xJCYrjo8eeFixG+3G6Lz5sLV0VFuL28jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kxvzmrx7LEWIC/2yIKcQxFZBHKuxndgHGiwCsUg4GGh0sAlHlX2HKkhla25+hRAfbxzGcHwg76otqqpNS71zmHEX27Xy3DFxPxJB5y2DBdKolBfMbF9gVzAph/pLd3QBF/kBMUYhapJkqtXnXKX6hsP6VZPrp0qBhOy4lk9z1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MbPmw/Jp; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4581cec6079so20471cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725902943; x=1726507743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04f/NG7uG8xJCYrjo8eeFixG+3G6Lz5sLV0VFuL28jA=;
        b=MbPmw/JpVKUFwXLmfyJ4Nh07KD7KT6CtaXUcyZfs5ZmWjMZdwn984Mv361WxQQK+G9
         FVWYADMPRfzzvUVquWl1O9Jp3iezSQvgs4jQpiOfBo61Oc2nXRIlPqKnY+8v/U47tmmB
         OZ/AbNs3ZNkKilj01Qsrzs4skJeSUEINu1wHsJnRrLuJpjVI/yDpQkwDfcIuVe7Xaavs
         JTfkhJ78CEGL67LbsszismNs1ZFdLmjk9apQpQv/I4raTrUdHCBhBK4K9fHOm9WShpKm
         MtGxgUP2xAfHFc6tuQ+uz1m628avK8ubDR7Z90EgrzoA/NR8sjVR1cjaicWVQ1wdazpK
         2Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902943; x=1726507743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04f/NG7uG8xJCYrjo8eeFixG+3G6Lz5sLV0VFuL28jA=;
        b=Zhpi603WCvgcImE+J1wZlONawHP0HGb+L+vNyxEmPj+TsG6QIufGA4TD/6FmojfeXr
         ImjW+pEi/xeObAEzFc1fdAen0l4Bu4iWxliEqWJROUsxkxgP0CEigW50Ma6asQfYxZqO
         R4HDdkMMB1HV9ZeM1WMpWucH3a0TMbqfzifdsPGCEVslhflF9AJy0WbhIrvxWck6V3e2
         XIjgbJRIFJyzYuxAmZ+u6u08qwjkdZO16Vo21X/+JfLOLpwtoOaZlXfrG/o1+wfgFiIZ
         Bp++d3XeCUJtJ1Jr8qKnWPAkMgcRYrkKNBFAoB7jvPlHpOIiyJD6Jzws6Ejeij9fIyHF
         LdHg==
X-Forwarded-Encrypted: i=1; AJvYcCWxOrpDUJYn8UxpC2fFiOaiSEmB2GeyiMy8uVURJF3LcLeTnm6sHeXJezYlm+mIfCWDMQMGEAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymcyAypPPq7D8t/DU6+N45cDLMMUQ7t8UGU3h2Uq0EckFspSK3
	gashdJRVYBmUPFSJwcDg4EGcGtE7MOsAPjnN+sgvsZ2tllUeUOkpR2jcN20Dg4x0uR8kvGIgabM
	Ek5W/MwrYBs353Ruvky/WVvVqJ9dwia/+I7f5
X-Google-Smtp-Source: AGHT+IFnxYeNUTaiJzioMhpfJmPbKwXRc8/Ury8YtqFEElFUIOmLINaQJV62PuA8eYbmnaR2d40uOsCUMUEG9M7B2Yc=
X-Received: by 2002:ac8:5910:0:b0:456:7d9f:2af8 with SMTP id
 d75a77b69052e-4582147f7a7mr5005451cf.7.1725902942736; Mon, 09 Sep 2024
 10:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909091913.987826-1-linyunsheng@huawei.com>
In-Reply-To: <20240909091913.987826-1-linyunsheng@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 9 Sep 2024 10:28:48 -0700
Message-ID: <CAHS8izNfLYQFgZYkRPJFonq8LH6SnV70B4pfC_cQ5gyz780cZA@mail.gmail.com>
Subject: Re: [PATCH net-next] page_pool: add a test module for page_pool
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 2:25=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> The testing is done by ensuring that the page allocated from
> the page_pool instance is pushed into a ptr_ring instance in
> a kthread/napi binded to a specified cpu, and a kthread/napi
> binded to a specified cpu will pop the page from the ptr_ring
> and free it back to the page_pool.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

It seems this test is has a correctness part and a performance part.
For the performance test, Jesper has out of tree tests for the
page_pool:
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/ben=
ch_page_pool_simple.c

I have these rebased on top of net-next and use them to verify devmem
& memory-provider performance:
https://github.com/mina/linux/commit/07fd1c04591395d15d83c07298b4d37f6b5615=
7f

My preference here (for the performance part) is to upstream the
out-of-tree tests that Jesper (and probably others) are using, rather
than adding a new performance test that is not as battle-hardened.

--
Thanks,
Mina

