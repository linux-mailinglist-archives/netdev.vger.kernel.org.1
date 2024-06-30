Return-Path: <netdev+bounces-107939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DC591D1BC
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 15:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAC51F2165E
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 13:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46B312CDBF;
	Sun, 30 Jun 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ5uiHrm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5A22071
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719753354; cv=none; b=ElTuzA6c678/uv4remHTTx+krftgzbsOmPocGQYtG5aexI25Azp+q9BAXlUYnynEUOsbp5RfB0UgcYumQLtPNURnZpsrDjOa5piWehVToFH7WIh/Bufvzxebc+xIxo2EYwH2ZKXcbyTUNzPnwY9pBhT4+YFGZri5Jp3kiQRl9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719753354; c=relaxed/simple;
	bh=t8TGO5AaUC7NwYDFGDbeAwihmxgswoTF55AjuUuE+sg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uq0D0BghG297Fcrqd+8o3C1nv446isH4t3n7ogP1+Y0+iHQ1Z9FCTsiGLJqa7hi4ekJeydV7bqEunZet1k3D8Up6O7wBoJ8MuVe2I2cnwxkuNhy4maTPpGbDzQ+MkCGFvzEOrw6gRW9cSWlCHpi23gaQ1EIWdbAzM9M2cjp83JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ5uiHrm; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-80f6525a0c2so632141241.1
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719753352; x=1720358152; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VUZNLQsODg2hfMaeYbnGgiy+9W/6ZP2VfcaweTuT9A8=;
        b=MZ5uiHrmDe0y7CMG3VWdwgTKB8a9IUJ0grh+Wl+RecrUmIel9AgCjS1I0D3ZWDW8eH
         UbKtrncs3Jpboa9eqn7Tl5dPKKa4WvvnnjAx7t9CBXb3Bo+/WCqvQsSXUsek+zVHhTLv
         4kklbHExI2xl5Q3UsUzBAMRuFsEFTFfKCoyibx/piUtEpwDliA2cJk3XtIQt9PJNq9pA
         1tJ+Sbm3+EDFJzBWVVB7Skx+FUgcagTaGv5OVGdqIl8NLQzRJlt3vshHzHJ/lAQde6c2
         iMRfzQgKHPN+SoU4PsvWDbEQ8LM8YyqPXpn9FNMUH1pG8AHCz48X0dn7KIUXV16yG9b/
         W2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719753352; x=1720358152;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUZNLQsODg2hfMaeYbnGgiy+9W/6ZP2VfcaweTuT9A8=;
        b=n6GZcMJ5ZXY6++ddYfBWbU7PimqwgAXrXuO99iVih5TQOJ9tkrrgrxp06iWUUjwhvq
         d51Ij8Y+OdUQsH0aSn5MNykJb/cRVhcMuiFX0i/mof41+eNAShMbMOE6GAogMyM8dfIl
         aEA8n1cOaaopdO/MjQc/NkFN8yavftmT7CA7aqWqeC1/n5XXfvnei8zVGf733bU0POka
         6KEC5HKwr99ZgKkeLm0mBcI7Iz2GM5bxy1G1h/gpUh9wC9ZPBmfQG+CCl1nECM0sI6wR
         glCgvd/ueBBDh3wLrmPqscbFRHQGZSHA6kxeiQoGMaUehYSzGoRYk6JmakW+Jzif52fp
         WM3A==
X-Gm-Message-State: AOJu0YyuO+i4TSniB4314Y0Kii5AT59mYTTKgjPHu/g9w9I/QUdsv1yB
	wdyeISYqhGRtl6moOVL2BFIFMwu7ccU1Y3EfQbUcYXnRdRB+rvR52dJ2LvYlRLg5BEc3vzCuB79
	R90aTloNL75UEMPfocthh32s6lOXLlAHsT8c=
X-Google-Smtp-Source: AGHT+IEkxSWBCLbRWvgXfgnNRMGUIWFCKojgdVkEmLfZRXtlWoUsD5P3LydrW4X/K0mbhnUfDZjctqkHyejoHtqdLYg=
X-Received: by 2002:a05:6122:2687:b0:4ef:5b2c:df41 with SMTP id
 71dfb90a1353d-4f2a56adf11mr3218060e0c.9.1719753351797; Sun, 30 Jun 2024
 06:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Sun, 30 Jun 2024 15:15:40 +0200
Message-ID: <CAA85sZtL46PU=MbhaVHHXNeoYLGKAqcTNzsX-WqizceqVMym2Q@mail.gmail.com>
Subject: 
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi again,

Still trying to understand things..

But in ip_frag_queue we have (net/ipv4/ip_fragment.c:307):
        /* Determine the position of this fragment. */
        end = offset + skb->len - skb_network_offset(skb) - ihl;

While the fragments total length is calculated with skb->len + ihl

So "skb->len - skb_network_offset(skb) - ihl" is actually the same as skb->len
at least in all my tests, please let me know if i'm missing something.

and i really doubt that the compiler simplifies:
skb->len - ((skb->head + skb->network_header) - skb->data) - ihl to skb->len

So the question is, is there some corner case that skb->len doesn't
handle in this case?

