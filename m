Return-Path: <netdev+bounces-158191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB5EA10E30
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A399167676
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA01F9EDC;
	Tue, 14 Jan 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhX6FkA3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F551D63E2
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877057; cv=none; b=tkV8wkQ3VFq277tWdROc3C/xwtiUFqIRXFh9EiuhNfolYWfLw9LJyUUOztQNpS9Ls2smm1CGG/xxyWhrWOYW54ZpYWGealxj3Fjt+lNlCwjGgpl42LqKhi4BKzqZkCv2w9BB8mWSvBLy5Gt6chNsYPd7ghUxL3sGpKA/jLmvmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877057; c=relaxed/simple;
	bh=OaXX0W5DrHEQvO4ZkupayrWaF3+CIfa1/uAHLaTct60=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=B3gu3jPYaHQr3YTH1g7x3Ox00Xw6/us8FOd5fAt5trcXTFTI5981ny4bpD3OKyLxxPqfgMx4jEHLoEBB5f5hrp/tiPhT5OkiC0/aIfGlpJ4Tzgn0yaSw7GBUL9aSHJuqVDcMkVp/dYht+CE8K8f8XiDsa1gAtKQmEKcz8MKPfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhX6FkA3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43634b570c1so41963795e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 09:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736877054; x=1737481854; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fu9mfr6xwnIV6h+Qdb4hjJHIRt987Ie42GyFSXjkQ3s=;
        b=YhX6FkA3Zuj6uEAwfAKgUedkimEx+CujOtYdhx0I+P6r5WAK8xbBda+IjzP3Vx/6/o
         XwGDEjmntcc+QkelnwQdNwWIi8NyrbJjaSVGTXQAuDE5oTF1/rISS41ryXciMubI5iFh
         rO8OmH48uN1zBcB8PrejT3oxk9dSQmvFBPy8vnN/T/63P7G8aStNQIP9pOhesNU0o2I+
         EAnxb9W1w58KQjensRHstZUxVKLqDafSuwcBklj/DrMJdImTjOCg5Ju8zLHiJ7grvc4i
         InBzNgtGrgd9yhwe+Z5wP4AaloE8gbxm9tBEAHU/Kq59uj5CekM37bAKCOjQSQNE7KT0
         r2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736877054; x=1737481854;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fu9mfr6xwnIV6h+Qdb4hjJHIRt987Ie42GyFSXjkQ3s=;
        b=foQnDyXDhpc6UVcxbRBj23Wb9anjJV75HVWsvtdiuCxZZEQhqyC98/i2vWRSVcXzWX
         fmVe6cGud+JZ0M/FZuF83nz9+J9B92lVbiXyuC4WLxwdU+itpiSamLPyQ0lfQQ0ks1MV
         U4rCrDXC4oFFbO5JADz/69f87u97gQC5JT/6EKVQqnyymvy78919sPHLqUu2AguwlqFT
         CvHO48Mxkf8TZZA5dFEOlKlq7BWR3+myi4dk+IRmRMJ0Bzk7SxspUM6JBlQdxj330Kys
         nB442nXnc1/Dw38KPd0pYriX6gKDSd/lZ12bayNfnB5Ept7UhiZR5u2px+Uuo8vfzYpb
         lL3w==
X-Gm-Message-State: AOJu0Yx8ochTSWjAFtTXKr/7Nu9ezr/W03jfg3qUmB2Yb4cJFcxdVdTJ
	PsCVCkbjPeMpeTFhI1OwDBS5vMzu8lPoPVP+3cW8dijisB1iSNCHHYRW/NknU7wb7pLHLrHFUJM
	ayPk1hLKqiLj+H5RcHTylx0zMPbtgxQrc
X-Gm-Gg: ASbGncvtjo5/Xm76iNC0R9BjefTfIpYXLofErfhoXfn26nTi6IVGzgjrjzqAcUeji+A
	kkKieeFcfrbcOkANoNMxU8oVm/jP9ehAFQW1ZXHE=
X-Google-Smtp-Source: AGHT+IFWjCmNPWhXJgpxhuN+3PJtzVTcT7MP7G+W+oZi2uk9Ct+laLuUe4SPKAj7jiAhpMolaePJ+OxXs+mdvhhd1Y0=
X-Received: by 2002:a7b:ca4f:0:b0:436:faf1:9da with SMTP id
 5b1f17b1804b1-436faf10c2bmr84613945e9.2.1736877053958; Tue, 14 Jan 2025
 09:50:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dheeraj Kandula <dkandula@gmail.com>
Date: Tue, 14 Jan 2025 09:50:42 -0800
X-Gm-Features: AbW1kvZJXdzHuXRWaAHuWlf02lCwx3Q4mqovFSO8txfiofgd_bNrKMyGGI1I86Q
Message-ID: <CA+qNgxQqNWSo3TGYO7q+y5R1OQE9wAsWj8GN3d4+JHZ0totKHQ@mail.gmail.com>
Subject: net.ipv6.conf.*.unreachables
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,
            I remember seeing unreachables in earlier Linux releases
if I am not wrong. However I don't see it in Linux 5.15. Has this been
removed?

My understanding is that it is for enabling or disabling sending of
ICMPv6 Destination unreachable messages. How do we configure the same
if it has been changed?

Dheeraj

