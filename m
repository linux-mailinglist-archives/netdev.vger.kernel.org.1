Return-Path: <netdev+bounces-53705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F9C804399
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8D21C20BC7
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 00:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D92A5A;
	Tue,  5 Dec 2023 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="eAn+bSuv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A79A4
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 16:51:23 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b8b80cec8fso1622154b6e.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701737482; x=1702342282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+9GsEhOpbTTb6XL+EDYNtPvCtJN4Mrpxax1pkJQ/PI=;
        b=eAn+bSuvfWLSVOT9bc7p2/IMd/lDmX3PzH9SQJavbHl1au79gwWUN2x7Vpf0P1vP1s
         nBWXyB+aR78otwMHznKHktxrNpavG5Cf9cPOBj/cUidxpR/lrp1meUgKSm6V0/xdeg2W
         8W/TvLseq1KadFsN8gRlIb1VLb9wAw0PnHnOsWKR033ZRV4lARpc95mP/3CKvFnZidTC
         yOGyi5PHs/UdMoHcZCZ1rjXtCZYH9cuJf+VYHAnGj/IGB5YRlenZWYCKW5ooV6USsK/c
         lC1lIsqC9vNjjD4Lt7bZU/dAbXfMkvch+zIQc10pqYvzCQPvlYEYaMc6aMs4FZMVPuZK
         2TNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701737482; x=1702342282;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+9GsEhOpbTTb6XL+EDYNtPvCtJN4Mrpxax1pkJQ/PI=;
        b=MZkQ0CA0slTdQODq4AdVa21WGGK391wnwhvD8Z7WjhiItLAbxgCW/oGzBfdNAZViIM
         wkK6FdOqNCpbJRoFXn8RK/SzPi8yVhhYwltKeEnXRkW/qoen812z4qcB4xn5gR2PXHJp
         +ejBPQ/pzaqR6cQdBLoFm8SyaDdnhK8g1EGjongqe6dYVw7E9b2nrR/4P4JryD0Qk6kh
         L3u9JVoROEUPpo+me3Dni1XDQeXlpQ3w0+EY6MNEoogxRcHws5AjPy2esLQSCP///1iS
         2M6ne2k8jmqUTPAP5ox66MCQrub2OvpJ0PKnA29AqEPRPqBWcBGGJDwmbH4Y3OiZJabD
         8kcw==
X-Gm-Message-State: AOJu0Yx3M5VESbxO0G8Bkovlt2BC2yab7ETA7SN9d+C0S0PlHu4MB1mi
	ImsBG3ShG6RxkROfHH0zm3A4FnvW7hz1lZx9oLw=
X-Google-Smtp-Source: AGHT+IH7nzHN0EMtweNSkRk31Mz1J6GbsNPFtSAkhtB3jWLHnn+ZqAa7bTp6MHUkll+0GWyv+8fZ2g==
X-Received: by 2002:a05:6808:144b:b0:3b8:5e09:8c40 with SMTP id x11-20020a056808144b00b003b85e098c40mr6185511oiv.2.1701737482336;
        Mon, 04 Dec 2023 16:51:22 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id bm16-20020a056a00321000b006ce202eb58csm4863804pfb.132.2023.12.04.16.51.03
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:51:11 -0800 (PST)
Date: Mon, 4 Dec 2023 16:50:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: veth0 weirdness
Message-ID: <20231204165059.089f743c@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Discovered an anomoly while exploring using veth for some testing scenarios.

The following will always fail with EEXIST:
# ip li add dev veth0 type veth
RTNETLINK answers: File exists

The reason is that name for the peer is always created first via:
"veth%d" and that will return "veth0". Then when the requested device
is created it will conflict with itself.

Not a big problem, but may confuse users. Fixing it would involve some more
complex transactional logic to create the primary device first then
create the peer which could get messy and likely buggy on first versions
for all the cases.

