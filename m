Return-Path: <netdev+bounces-241558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D229CC85DD0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D813B41CF
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532792264CD;
	Tue, 25 Nov 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKJm/w5h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB520A5F3
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086699; cv=none; b=h2tYxaLWdUeKgQboMYd8dZj6P4d9CJaOm29oh7PLsJfUEU8J91k58Ld+SlyW4fdGRpIfNuWeG2+odnuzzJcoArpf3J/0m2k3++WuZoCyZgwDPSFR2vE1uPOD3HVeriAkqHkUBPlogCrFP8RBDPIMRRREtJYsklmRbMEQXLHHmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086699; c=relaxed/simple;
	bh=UyyByTuY+3Pmfua0Po9WTijBQVKNAcXITMdPGJvxnzo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NJVmmCiYY9demjdbT8qWB7bmlpyY/E4DndMCgW+SdFnUhW9Rd79wluajXCXv+9V06roso0eM6j804kGXn+u12TYQ5aLC4pGG1GMwHYZL2YRMG1NHLZOTrFguO9mlw4LbH34Gziot/GM9L9ORf446RNSTk6CmICOBOIchiW3c87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKJm/w5h; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-640f88b8613so4386134d50.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764086695; x=1764691495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufovA9njBrcJJicKUMIOkwxg5WNvQhR6uFRYNHpjveE=;
        b=gKJm/w5h8yNPbxByrDZvgfL6xjepOPMj/BlbvNPP4E/bWLms3gJvF+2EARCsHcjpfp
         mDPqeeeiO/VJS3ZU5WUx9/nMwznv0d/9pNdjNE3EOrFPONpjEBPSiXXLCeS+hUc4ujCi
         AvxjDbfYI+H4LUf5jKvpHhzaYZsjW0OXL3dRSWn9YoaKWKRYih0+UsWMDdhAQq4BcY0r
         +XNj59OkYcNYMcNfO3sPpmZMWJ8hUsqJ9HV6r7HSoWFcUD0/JmWvRIpvhDBg9UJR19Ai
         gqjLvd47/NbKWRGbW6Mvk4MXQ0ldOcEcPeGbVMZMvt/uslp/3vyL4oJq4uRhg7DkjQ9V
         ZtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764086695; x=1764691495;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufovA9njBrcJJicKUMIOkwxg5WNvQhR6uFRYNHpjveE=;
        b=pJcpbZPuSv5a8Yy8x0FurqQHTIrmX+NlTDTa6tnkUUDauOfj3wngBKVtcuKFCSlmEz
         X6Dreh8kysCgznMQTewn9nMTadADhHbL8ti0ozqi8rJUcduz72xr6MrocNcb2aoJ4mmG
         TwW/yG6BZRolteCWDwfKNLvXFyZKq8L+l/QT8HlNFkH9+/nVdkMBclB0kGUSHcS+KvEF
         RJs1t01Qsqgga14blIFBW4TBpdq4KuK99o8cNuBibH6dDzbTo+iXyExsbxkAS3mtZowg
         PnTZF8sqEgYiCQhJX4mjHKjES9eZUC9h/qmEV+xSFekI3DkwC6vTSLs644juhURNhEqB
         5dFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNPC0t5HNjAZsAcUF7FDxO3075sSRqdrz9BrjjGtyftvyWQfF3MrpgDFAoM8ffPvqAEVRyCUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSVKkIazz1sq0RJvQ/+UPsPoGHdhRMV8LTMQMj8fMUqCTOxcY
	QX9V1amUcRldkSgVshQJ8j4u0/B5DbloqG1JjJALac/Zwa9Rz5qvSpZ5
X-Gm-Gg: ASbGncvSyZxk9L0wExj9sCpEwGuee9hqUSJtAd1LA290YqAizYBBfqRc6CcveteO1ac
	BcpS3rlayp8wrzS4vLJWGL7Z87DHtGeADkSsWglGg+Glw45JSu8UI+qj0cQ0TbNUiPvCIMXhxyn
	viSsSlXUGvTB3vW5mi0cNcQN3PpvsCQJmzCXTMPeLtZtR7uH0Bn2V/UeckYY8IjWflNYd9wVqQK
	Vf2FGWuD7emipkrv3eLPO1V0otXEuTia84Axq90EQ8m6An6NKmn5x7IgFqE36q3WI79LpIcTQph
	+MsBxid4oQCKdfqlbtUDpfpkdIWUa/eW/xTkjj+j7NcifLtxFu6SRioxYUdBtJ5x8t/UbExm4uk
	sveDljLKox2z8w1xFzfBgEQ1D7CPT1CDkWERbwHz0DGvPFoljHMRKGQajxIhWNVNDeAt27SUmqi
	RUv01yqvhIXdQ8jotFb1mVEOzeYSQnSCoxgopHd7XqQQ8EtaHRF6SEZHYVx5NhyXI/rgs=
X-Google-Smtp-Source: AGHT+IFMsVqQio40MqwigTpnntui9rbl+ng5ZfDUQwZJ043z1MBQaQ5WaAyam/USMadKLWIPTN7vBA==
X-Received: by 2002:a05:690e:214c:b0:63f:a06e:9a7d with SMTP id 956f58d0204a3-64302ad9f66mr8502542d50.64.1764086695379;
        Tue, 25 Nov 2025 08:04:55 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a798a77d0sm56497707b3.22.2025.11.25.08.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:04:54 -0800 (PST)
Date: Tue, 25 Nov 2025 11:04:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Xing <kernelxing@tencent.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.10c7edf4c3dd1@gmail.com>
In-Reply-To: <aSUxhmqXmIPSdbHm@fedora>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
 <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
 <aSSdH58ozNT-zWLM@fedora>
 <willemdebruijn.kernel.1e69bae6de428@gmail.com>
 <aSUxhmqXmIPSdbHm@fedora>
Subject: Re: [PATCH] selftests/net: initialize char variable to null
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ankit Khushwaha wrote:
> On Mon, Nov 24, 2025 at 01:15:33PM -0500, Willem de Bruijn wrote:
> > This does not reproduce for me.
> > 
> > Can you share the full clang command that V=1 outputs, as well as the
> > output oof clang --version.
> 
> Hi Willem,
> I have added clang output in 
> https://gist.github.com/ankitkhushwaha/8e93e3d37917b3571a7ce0e9c9806f18
> 
> Thanks,
> Ankit

I see. This is with clang-21. It did not trigger for me with clang-19.

I was able to reproduce with Ubuntu 25.10.

Okay, good to suppress these false positives with normal builds.

Reviewed-by: Willem de Bruijn <willemb@google.com>


