Return-Path: <netdev+bounces-181422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24892A84E5A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0488D1BA521A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 20:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE36290BC6;
	Thu, 10 Apr 2025 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="KO5Ss/md"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B2290BBF
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317861; cv=none; b=PkENvGbjPlt8+JNsjKCgi1ax7V6iIZJg33hAx3xXbMnYJpQgBLxPYRfl2d+fTdUhrxC+XIdK6aplw6UnAHTGA3VFywsOcI3kAVEgUPNrkpgokpBnTNYSYQnThxvLuEyJVZjLAWrWHcB8cOIF2tV4XQUL39Fqk8CVjbdp80OxtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317861; c=relaxed/simple;
	bh=eHC1faK3iTUl+b2A5WGBl1DRRBfjpZOZbUAJBEWKYE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfOPZYraNiz8p9um/YjBxCT/n7IrNEQ50Xa3P2SE3NxWUq2aQ60p0Uwob5G1H4s9qMcTTaOet7azTZ8hkrv97jH2OAzgEu22ot3odu+/4D6nhJXEGHkTwbjZ25q2d2wGFJk7ds4z2JQU/DVaKSOt0YjPGRzHh1Vr2Qyc7bK42gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=KO5Ss/md; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f43676b7so1065196d6.1
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 13:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744317858; x=1744922658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eHC1faK3iTUl+b2A5WGBl1DRRBfjpZOZbUAJBEWKYE8=;
        b=KO5Ss/mdvQFQ13WijcVvU2rWqmzFlTVFmaYSyG6+SwIhziWGrvllvcIIFzOJMPvhac
         wfOCI4a7tI0XI6p6SGBdXzwOztPHGgmVlIhqQ9C5qI7bidJmPMaEo6fACCztb0zyTsbE
         s+uwqweveHd3btyluAvsZEx/XXL4HBbaF2SDE2v14nwkD9ULwsK2J0mil9CIFaN0PSaN
         QhKKnVV0N2pVWFjiBqJwiEYxki8PXjsxlCfqoXj8xyAkFi2RRFNASRIKi98O/YqTK0n3
         VO+hZTay+T9rUwAxqc1OGlkhiKnKYWAewHwg/dS40pEXxbocZZCHPiCDI65bvukVHi9P
         WeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744317858; x=1744922658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHC1faK3iTUl+b2A5WGBl1DRRBfjpZOZbUAJBEWKYE8=;
        b=ORZ5q0bRZJWrT4mLv8buEZFkxXxDaD2NSq4iNluXXJVGqV1djr7lkvdj41YHdlU+7m
         +8N3hsXZEaFKrguRTkeX3MkdaLUkMTwliBdPtVrNrUdImTV6rIeCMP3Yl0QseX1uQ9CR
         Sk8PXho9rKY8z/V9pRItLBLSBGgoQWb+KBKP/e6r3ZYXiRERXCl+R5pKrHM4qfMPmVl7
         GM/HIqx4cjeGidLVDiHgtKJVjMnqJvpCn7dCYC48D2Ra9U50IIfBibu7ktK/O2ZHEull
         pNa8Q2PRXsW9QbfrZG1Wc1jz5Hh6EB48n1YZvU+z+iPrN7P92SiQpiHNgiAJLrWcuklD
         phJw==
X-Forwarded-Encrypted: i=1; AJvYcCWhxw3Di7hT3Uzz3JC6ETh0q/GgvQzNkqUCr1dZzKNd188V2Vqy7LO+Gm0CMCa3XeRFwty41Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBb/pTgdiOWLgZiVxC1EnIwhAf5gBHJd6+RvUP3V6KpCR+gryY
	gUm0zFi/2ln0ohMZO23oXM/kyUgqTz4vp8MhvTPuLkxVHKfAOcku+zJc3sIcmkjyfKulZPROlOu
	5uNKhqeoPTkLD+sDJdN7/iQyN3IUivGawNFGHow==
X-Gm-Gg: ASbGncsjRhKgeLKQi1HyF7u3Hj0UIAdgmmGp9F/StE1Nei4WnBQPDI7jgl/eJGizJM8
	MUtWXbh/VBWQuiEHP8HkD9k5BESmaSbVGhttyOloYAlL9uo1hkRYztGK8zOlMODD3bip7ud+t/x
	FDTBjeS3XLgt6Yj9UEFfWGCbS40wtBWc7r8NhL3YF9OfXfKiOrii8VP5KDkkuutMwySw==
X-Google-Smtp-Source: AGHT+IFT4D9Lld34BEDFxmLdtNq1CHAu40ARUKhcOLKQAoF4EDsymse58Avjrn831AVyK4m+U2iFlJMN8Oshu7UviJs=
X-Received: by 2002:a05:6214:212f:b0:6d8:99b2:63c7 with SMTP id
 6a1803df08f44-6f23f1679e4mr1613206d6.9.1744317858243; Thu, 10 Apr 2025
 13:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409182237.441532-4-jordan@jrife.io> <20250410202718.7676-1-kuniyu@amazon.com>
In-Reply-To: <20250410202718.7676-1-kuniyu@amazon.com>
From: Jordan Rife <jordan@jrife.io>
Date: Thu, 10 Apr 2025 13:44:07 -0700
X-Gm-Features: ATxdqUFNiqUBXgVBqQ2y3QLdJIa8_JNiNyA_2ihZ5IBO64_T2Fm80tjuTC8LWrg
Message-ID: <CABi4-oiM=4an0Lvrb6uQYp+D7zwon2Viz7uezNQ-q8g7WQv3bw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/5] bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aditi.ghag@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

> I felt this patch is patch 2 but have no strong preference.

Funnily enough, I originally had this as patch 2 but moved it after
much indecision :). I will reorder this in v2.

-Jordan

