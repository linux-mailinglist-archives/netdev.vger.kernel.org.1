Return-Path: <netdev+bounces-175135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C61BA63683
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 17:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE705188E0D7
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711501C84B1;
	Sun, 16 Mar 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzFmAlsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B14A06;
	Sun, 16 Mar 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742144070; cv=none; b=KI/wisVYO4EWm0k0+f4cjyZwopCExzaU7Ysf4jH2O31mR8PybvdAngxxa+7soRZrpV+tUFzvy5VlmOoq/7u4jmfh/YGjZWsXB+578rTt07iLQS5Zhi6mzn49zY12wxbEQfvwt6sqFQFvl56WyPaAKbW1KBjg+azYYACU6uI8umQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742144070; c=relaxed/simple;
	bh=JlASOQO15Ulr4Y5cQITauMXKzdFZOa3S7PjaBPCjIpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ+pp/EHtXh/5ZfRQAKfO5aGhkRc0DPMcm3OzYlTGZieIlOQdY61o7Y026HONlpbNdg4v28eSgFsowkxDtMMUTnzTw7EGA/W/U1TEmp+l7bFHtKzQsXyYLIT1rGWyBVTUgGg4d0EQEG+kVy8Mzv4P7iHm5GLKqa9CxSsOuLsZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzFmAlsK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22349bb8605so74012925ad.0;
        Sun, 16 Mar 2025 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742144068; x=1742748868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zmB4pBX+mqAyrHQpY1rR5NkKyc/9Lvpj/pi06A1TjWc=;
        b=RzFmAlsKczCowCTzEM/HxgvpouM8IFlxHLo6+fPip+NDqzPpPY6OHdqE4NXv0KeDeX
         TQNFH/q5RESbNbR6yQU7mfNRnGEx/mNJv1rtFswUXSaanf7uEd6hKcfJdxIdyi7y20/U
         Fq0K1I4huYYgU+AVDZxFpJGuaM4dqnEhFTk8XNldBRcjWd6o5A6PLnAa4/YzDXOBUcOa
         3CMsLoXqZKLd/hddDJpJMNKfgO4miLaWUnp6MFpF2l7s3NmiifBcPOK9qlo4Z/48IyQl
         3lSM4WIBNppHxWLpdTaOto7vi4HUOAwablxjRUyBHup3Fu1Szc6qQ12Df5JYrQkkr7D4
         C04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742144068; x=1742748868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmB4pBX+mqAyrHQpY1rR5NkKyc/9Lvpj/pi06A1TjWc=;
        b=mZJz35e2Axgw6Vqf01R+vq8a03u8EB6jhAFkbpZeKLfM+im2mRUd/JtdWwCa5xOGEx
         IwbjnX5qpz07/C9RujurgazFK4pNLWPnnTpZOCAAM4ombbu6uI1EpKdcoLcrCV4HL2Yo
         Sq41ozD4n/eUxzqQ5lEguLQhcfkgqJ6HP0+rkC1eYQW+nqEpFjbZjiArWaQWg2CvMpj9
         +OtodJfixRK0/I3FzXy1WgE5ygpBml4FWKpwx6tvlgB114SuPNzrcbjvHQh0ohP861td
         YJR49bOexnkyoMb9kaK148YdAmPxsHCNBefLqyrD3G+/gsm+kZuq9rjuslUNGVUtrKhs
         zSag==
X-Forwarded-Encrypted: i=1; AJvYcCUnsI3cMPA6SS2vuwE0jiLz5hDTEGejksuY59bCJax9BVlFLfbnV5mjFA2iuqvjweTrg9ac1DRlMQJ3WCE=@vger.kernel.org, AJvYcCX6bPZovqAuXwuJ0IzizetCIqM6TIii/Y8Wh1mwW0zzBQHwYFGwPctPkB25Y924RKq2gp4ujrYV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5s3LW+LhT5ExWy7yfs5rtPLdsbsA4PolGrwKvVn9AZUw2cgVo
	Kzu2W9UGgptkGH54toRpNL84o3M0U6AHKOsuQN2Myj9dOKPCvSY=
X-Gm-Gg: ASbGncsrlbu33iSDtAWeRVdihoIgpzpHIL6Lzk02Tyb460/94VA5VggzslwYG+Q37C0
	z+FkuMGnFN1vYAkUsV4IN0dpxBds4AZ8w+isCrMCHdPYA8mRV6PS01mYNE9cXR9hoiLoMnL/VF+
	jLl8EJj+B8CmVSRzPGrDBc/hK77Bmoi8WYv9cKLL89G3LT1rdl4u/aOGNuNIjfH6sfBn/9AXPo9
	ffDYNyFOyefVEfJtBSZtrzHeLSuyn0sqM+HzmTFpLuXIoJq3OpFsrE0vPRBQjSS5jaBQNk7BpkB
	DY2XP5a1AdIz2HzRrwF/BfhPPsniVExZWvDaRFYtcnoa
X-Google-Smtp-Source: AGHT+IGX8C0nPVF0W8WqK0u22KEPUn24VYYthBMVkO42IK9gD5SG+C9xofe1+9ak6aE0gcQqWG6TYA==
X-Received: by 2002:a17:902:e5cb:b0:223:569d:9a8b with SMTP id d9443c01a7336-225e0a64a03mr118181805ad.18.1742144068194;
        Sun, 16 Mar 2025 09:54:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737116944f5sm5970967b3a.124.2025.03.16.09.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 09:54:27 -0700 (PDT)
Date: Sun, 16 Mar 2025 09:54:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: ffhgfv <xnxc22xnxc22@qq.com>
Cc: davem <davem@davemloft.net>, edumazet <edumazet@google.com>,
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>,
	horms <horms@kernel.org>, kuniyu <kuniyu@amazon.com>,
	bigeasy <bigeasy@linutronix.de>, jdamato <jdamato@fastly.com>,
	"aleksander.lobakin" <aleksander.lobakin@intel.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux6.14-rc5:  INFO: task hung in
 register_netdevice_notifier_net
Message-ID: <Z9cCQ1huViMjZkvS@mini-arch>
References: <tencent_A3FB41E607B2126D163C5D4C87DC196E0707@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_A3FB41E607B2126D163C5D4C87DC196E0707@qq.com>

On 03/16, ffhgfv wrote:
> Hello, I found a bug titled "   INFO: task hung in register_netdevice_notifier_net  " with modified syzkaller in the Linux6.14-rc5.
> If you fix this issue, please add the following tag to the commit:  Reported-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@gmail.com>, Zhizhuo Tang <strforexctzzchange@foxmail.com>

Haven't looked that deep, but it seems to involve a tunneling device,
so I wonder whether it's gonna be fixed by:
- https://patchwork.kernel.org/project/netdevbpf/patch/20250312190513.1252045-2-sdf@fomichev.me/
- https://patchwork.kernel.org/project/netdevbpf/patch/20250312190513.1252045-3-sdf@fomichev.me/

Do you have a repro? Can you rerun with the above fixes and enable
lockdep?

