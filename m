Return-Path: <netdev+bounces-117907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5BA94FC3B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 05:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0C51C22359
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D9C18EAB;
	Tue, 13 Aug 2024 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glxx9OHx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2791B947
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519770; cv=none; b=hu6lfVjrT2NAM2iooirQ8MPaUfsOM3CdXxXZg9BUxD6FEFhdruf2e1qZ0edf4+44gkwloFDXkJDjbpyDOTNKJIYRnEcnvGzVJrKqChMHiVMCsJbSMct9Tciivrxe2nGyrCex2uqAb10hpO0rZ632lv34aOQLinVEbmRknS4nYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519770; c=relaxed/simple;
	bh=JrdbtrspZTalHGuAB0DxzGh0dcRufsjtYfN47erY+Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QMmW64lRnPCnwl1JUJBwf13bI/Ui3DrQ1Fw+xcQu1CW4ypIyqfU3/lCa1qaSa/YCru7GAiLwi8ZOMhjagKS50Dakz0hJuRawIG8RukGL379FqMyiSNQJYV1ckUBIrmhjYJEA0S+fQlINlHim+P1JswCZ4T6dZ8rNCwwsx1H8A2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glxx9OHx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb53da06a9so3381152a91.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 20:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723519768; x=1724124568; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdPXI7bccawW41LB33P09eCaW8FdJxb31h1nPHLvL50=;
        b=glxx9OHxBHLZdzXGbbwXOgwW34t2snDsB/QL+qVxux4qa+mzvuIJiDT40TNsQKvFhR
         oKggo/aJByC5PH+n1QHnT+HwhXphObNxSFG1TgUtvZu8TFLT7N1Loy0GQihVEiFytTaR
         oibY9LgQqZMTnfrAbLUI1lfOqNt00d4HES9TcKKad4grKoBEYct4w5Z+aA97SvTD+8xH
         Ciwub+5oZhgHdFkSPYChsqpYsbR2NsP+LvY3Sfse6VxA0zP8CmWSFbg1HcyJmWmculGO
         CFzR3l8Vqo8AF8wvAcqtXPQRQEpRhQr4aviO1FP9jlRnuVwN62Jw6P0DTphckhndFrLP
         FRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723519768; x=1724124568;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdPXI7bccawW41LB33P09eCaW8FdJxb31h1nPHLvL50=;
        b=qSbSAR+AsCGeQeKCANeW1grLFqLNfWcvbduRSMZR/TM5YYtDacwDiU8hnlbUAf5piX
         Iha3DwWoBtgl/Ra/gaSPsw2j9t0aRy+KzxexABey6CIVOQDkDpN22IJcA4/i4tNA5E/E
         rQ6mFtsiR6Zi3RoVDwUx4cJ/zCfabLce7P9CfygR2bTbKPt5D4DSE3Pk/w8CBHm/GiyW
         klOfqqeqHzb7zt62qekrFYZREYAntxJdp0cbZsMO3L4ikCHfg16U5ZXWlA0MtaGPUFTZ
         ut3HKYOymgkyDjrWmHiZhqWRLlb9KwdcfTupG2WbI3r2sqrZu/M92dL0eLMJyP/26y3r
         QPNQ==
X-Gm-Message-State: AOJu0Ywv76toZSqYZ3HUvxNdRGoPdmHkcexKVJZX5xku4HzQBtHqtmE5
	FM5S7pl+ag6lqlR2XlNmwjiKBI8Ig22lUWoLCux1/gWK6Cl/vwEkKVJ5t7L8qHw=
X-Google-Smtp-Source: AGHT+IG7NDEOYRZUE+hBrBz3z7l3uS3rDJNytyOArb1crGkcC8NF78/V9j336NkJQDjVZrq+1CRedA==
X-Received: by 2002:a17:90b:3911:b0:2c9:75a7:5c25 with SMTP id 98e67ed59e1d1-2d3942ed069mr2527311a91.15.1723519768428;
        Mon, 12 Aug 2024 20:29:28 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9db3be9sm9179558a91.40.2024.08.12.20.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 20:29:28 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:29:24 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Subject: [selftest] udpgro test report fail but passed
Message-ID: <ZrrTFI4QBZvXoXP6@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paolo,

In our recently internal testing, the udpgro.sh test reports failed but it
still return 0 as passed. e.g.

```
ipv6
 no GRO                                  ok
 no GRO chk cmsg                         ok
 GRO                                     ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

failed
 GRO chk cmsg                            ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

failed
 GRO with custom segment size            ./udpgso_bench_rx: recv: bad packet len, got 500, expected 14520

failed
 GRO with custom segment size cmsg       ./udpgso_bench_rx: recv: bad packet len, got 500, expected 14520

failed
 bad GRO lookup                          ok
 multiple GRO socks                      ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520

failed
```

For run_one_2sock testing, I saw

```
        ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} -p 12345 &
        ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} && \
                echo "ok" || \
                echo "failed" &
        ...
        ./udpgso_bench_tx ${tx_args}
        ret=$?
        wait $(jobs -p)
        return $ret
```

So what's the effect if it echo "failed" while ret == 0?

Thanks
Hangbin

