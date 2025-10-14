Return-Path: <netdev+bounces-229346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EA2BDAD3C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8149E5472E7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F6F303CBD;
	Tue, 14 Oct 2025 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMsWY1d4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19D280025
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760463715; cv=none; b=g7niXuXGDeQr1qZkR188wAG336WAEbysj8xn7Ebx7IO47TfLfFiAt1hdXLvX1pIz9TecE+HzWAKfi+6HPj+gzykU7AR8fcsqUtTkE7JFxcMrs50n9cyFM5odrRQ3WN2nO1sFiHCdOQYGACTAkJv4tUuDG2uFfVKtuuAOCAur1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760463715; c=relaxed/simple;
	bh=ysJlwn1bhZbQ2AYbkAbB/8TrOkpj9VeHVxGS1FK8BB0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=As0QSDhcPorBkEUoAhhgZloEybqvwuXcPnfBnu6iqWuNq5XvsXM7upJpNWJ99qIOTjZ6nYi3eClcx3bLPSc5MbF+JoObrYre/k/47IvaMUK/t1aN7K4BtGkkY0+fFz94ZTsCnhN/QhWEn7rIBfMLE4d5G/DvrTNbez/hamJqLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMsWY1d4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760463712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ntELQJJe1nZivJzh3MBgIkdsTnzNcFMJbYzgYdL1PHI=;
	b=eMsWY1d4OtWvSONKIsOZkONBAHbFlxODMO6whTeK1ud8PUJJQbNMg3Z8wHKcnrZovQ59+Q
	J/D3fP8BC9pCzqKe3iw8cTxpX7rtIRVMI/LAHT6ihinnffzP1Db7Q32DGOjFrRXpaMjW6O
	RNuI/TRJL87GYP2NFw81cPUksoFXuv4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-HeV6gXWTOwm0Ugh19xy3cg-1; Tue, 14 Oct 2025 13:41:50 -0400
X-MC-Unique: HeV6gXWTOwm0Ugh19xy3cg-1
X-Mimecast-MFC-AGG-ID: HeV6gXWTOwm0Ugh19xy3cg_1760463709
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-401dbafbcfaso4516985f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760463708; x=1761068508;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ntELQJJe1nZivJzh3MBgIkdsTnzNcFMJbYzgYdL1PHI=;
        b=wooWCX3tzX5RIBYQw+C7Oo6W62ApY3PLY/EWnvfJ/mrIAeqdPZykzSWJeclbciU/O5
         Eh8poubvVAGlODtD6nUym7rkom7orAUBupAk15Ov6dxA2htrYFGeOC5q4RKD5CDUGyEL
         Bg9ckr3y6tPacagOvxAP55JoIdAyrL8pakjSCNy7bLCkz2WiYdNuc4eD5XR3cRSpbkUF
         r8mwC6fj+DVX1DFk0tSiSD0+uZ6SpNZQcKwm79hU4p9r0dJ2lXTVlIv/eyk5n7blJ+OX
         bdY6MfIWGhrdvT128172HnXHw4cksysst6+7eSH7en2lTFctRospQaTg2d85NWhU7pkO
         h+Fg==
X-Gm-Message-State: AOJu0YwCMcQTijlW1R77em84tDCY5fLvr93QI0x7BuU150VlCdKA1Ye5
	yAmfmVOwZjXcwRDkRYRWno9SviH08iLVp2Wu/qcWq3AFoIe35ite5ma8PfrhmZhFapea3yf+XEI
	YQMFWyw+/mbV5QFXNbtKRHHhRIwLNLvivANvA/r/eNXl/ippSc0B9A3IsBghSFKjuxe49nfMhIZ
	8svCVtt1OX7mYxBFd/qZQPaNxa3kn6PQqFqYKZob0=
X-Gm-Gg: ASbGncvpco3ZoGLaecRZzpDjiEIRA7EZmNL2NQX/9hZObQRf4lKC/NqKoqXwtAQvde6
	okY5HIcUxRc72y0S5GpBWr1r/FK0boC+KWLSBfdxg0U4uv+pzZRWq2lIofaTbuLSXjw7+27OzP4
	cWabTk8TEkTQbp9XFojL+dEZUTBnXHt8CMzSTXvDljd235qgfn55n4hHjPuEDA+J66GVwof+ebp
	SNL0NZXbPRRyn06pRJoWC9wKL4K2hvKo45RO/k1R8+Ko4KIQhcEI2ePr6Pdj0pRgJDYMs1M3cg0
	Ic5ZFKuSEgN7A4pX8ajrX1tU62rhDqBbf6VK0lzQhYX0uB85DKQgK7/cl4yWeXCSkTtRZZBPslK
	1CwoLPbZ61Vsw
X-Received: by 2002:a05:6000:2305:b0:425:7e45:aaa8 with SMTP id ffacd0b85a97d-42667178050mr16744620f8f.19.1760463708402;
        Tue, 14 Oct 2025 10:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs04L6/L15jHhnNCIP3053aw/lyTLPFsW98OHpHxwmj88bk2BpcTxmOvkwJIAwAJW/Kl0dfg==
X-Received: by 2002:a05:6000:2305:b0:425:7e45:aaa8 with SMTP id ffacd0b85a97d-42667178050mr16744594f8f.19.1760463707935;
        Tue, 14 Oct 2025 10:41:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d015esm25469777f8f.33.2025.10.14.10.41.47
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 10:41:47 -0700 (PDT)
Message-ID: <d47902dc-28e0-41f7-a972-83deea2c4efd@redhat.com>
Date: Tue, 14 Oct 2025 19:41:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
Subject: [ANN] Reminder: deadline for LPC 2025 submission approaching
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

The deadline for submissions to LPC is almost upon us (October 17th).

Quoting from the LPC CFP:

  Proposals can cover a wide range of advanced topics related to Linux
  networking spanning from proposals for kernel changes, through user
  space tooling, to presenting interesting use cases, new protocols or
  new, interesting problems waiting for a solution.

LPC CFP:
https://lore.kernel.org/netdev/537d0492-c2ad-4189-bb87-5d2d4b47bc29@redhat.com/

Note that we have some speaker tickets to provide to those who haven't
registered for LPC, yet.



