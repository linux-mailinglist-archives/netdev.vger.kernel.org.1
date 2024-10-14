Return-Path: <netdev+bounces-135117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E89699C5D7
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8181F214AE
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBB015539F;
	Mon, 14 Oct 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW1U9i9H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C517154C0C
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898525; cv=none; b=CEZF0TXy62upPZkG1fIVchpYCUsIax6HkxH7t5GosfQSyPtH0OUDct6T/eGeYjpeB+BgisCw9Wcnyh2kQr7UYJraBjk5Yx8cOtW7bQJ+o6XsXMVnA3/Jj86FD1domOcDE2NepUEExMMyojWUsRpG8KvRfd9AQ2RH+cBTuN7JEEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898525; c=relaxed/simple;
	bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=pqSPgyAlCmdQhPRJS1Sz3A/f5qDbCpDu8BP/+AYBkQE9qyd5dHQKIXl5mJ2OvrvQ1SD6Cj6SW+Vx+ebl2i8HNvdwpzExMunWVp/UO2GCLdCpekjNpiVYJb9NwxThUyjxrgbtwA3bYZWyRViYCIhJSa+e3TGCroLlEP21pMaWw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW1U9i9H; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71e4fa3ea7cso1418976b3a.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728898523; x=1729503323; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
        b=hW1U9i9Hhco61iB5w7RhuNQWQ0klVl87YtGzfcWyerQ18/Z4Aft0mTsQCuGGjO6NES
         PcE6RvPi/pJDDcTjLAO0YKWDKMA5qbNxSdlLO/HwA3FfpqYsyKVlMBF/NTLTg36QLoZR
         w+RAIN8erxilLDcwGXZ38VwbmFfJ9RkdvtZtg0rBNXOeZ37RXdKc75FWuJkzwc1eMADT
         2DFASsC2Rr1eCKevuC8+9wQvgH/poU86THtaC3+87hUwvgYRawbTtzsm919G3cIM1of9
         reK1tydFyJNIsTrP7D0bAsk6RCrO7ab/UGM5bLpqYdrBjYIKXTZnfTeA24RWefDHGQZb
         y8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898523; x=1729503323;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
        b=lwtdCeebnznZol9J/6mBArxopLnGslthSeQ/xIKgmwANQbJglftvm2SYlVSz89PMlu
         cZgYQ0fLYlxhWB+oolY0teNDM/As+0tX0mXIM9Zew5OOfwhlS/v/jlNG00YSLSsvgQnf
         JjR/5GHozXkGjK89wJHFfQX0ZYYPHI+nZ/QED204htqlJNv7xDL+h0JTwhC8p4RXLrit
         CILQP9wBme6Jq9WYQlDhIc2vS95pklGGzSvPO3sYvMht9U16Z1tLwbN7IHZJPSzS0Cts
         W36ym3zs8mcZuRaXZz+3CXjM9W49VFVG6Rcpny+JUlPwlg4Wvi5CBRufrFNmAWuVq+Qc
         7pdg==
X-Gm-Message-State: AOJu0YxdXvX6byu90cOcnOH2341bIms+kxgOS1YrnEGpus/pebh4uIgC
	0r+MrKZlREh0Zku/qtFgf09iRtqnHnc+/5BLoE4wxmdjyyWhkdtSz6GThUku
X-Google-Smtp-Source: AGHT+IEiEWjMnoTnDYxx+kSA2FF0FV5fLKC6nKIYGWgQW09Nxif3PfoCgRKHo02Z/IdJstJpAyyHXQ==
X-Received: by 2002:a05:6a00:2401:b0:71d:fe19:83ee with SMTP id d2e1a72fcca58-71e4c151a6emr11757829b3a.10.1728898523280;
        Mon, 14 Oct 2024 02:35:23 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e5e2840ebsm2472726b3a.130.2024.10.14.02.35.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 02:35:22 -0700 (PDT)
From: Debbie Magoffin <celalkara2001@gmail.com>
X-Google-Original-From: Debbie Magoffin <dmagoffin@outlook.com>
Message-ID: <1ac98cfacfc5c04748440ddd48fabf0e88ac59a2e28b8037fd359fcbe6da38dd@mx.google.com>
Reply-To: dmagoffin@outlook.com
To: netdev@vger.kernel.org
Subject: Yamaha Piano 10/14
Date: Mon, 14 Oct 2024 05:35:19 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I am offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please do not hesitate to contact me.

Warm regards,
Debbie

