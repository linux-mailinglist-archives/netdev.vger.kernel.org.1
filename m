Return-Path: <netdev+bounces-191098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2388ABA0CB
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37FB3A8758
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9543D7261B;
	Fri, 16 May 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpqiDBDf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C2A14012
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413041; cv=none; b=FGgIRW9Fs/IBVNhWx/TJTtb36IseNeIOyFvZ+kXfMgJaNEwap28T/Hkw2wsAFYbocBf/9NIUjQtDdl8Z9Z0H/m/jvWWgM70LV7dtsrKw2CzLS/SB9eFT62OUlBQ+x25t2joK/0XmO5GJi1iOZ25t/8WcQAdbSEeVALIO38Boeek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413041; c=relaxed/simple;
	bh=x56io7Q/iT3Gv9aCZ9URSDe3dWmWXLR55D1PsKMe1pk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mBSrC9E/z9RPY0DFynScuhN5DWGZM411sMhq0fjMVnmpcsHlVMMIhFzglkAIaGrPyAjZGzttFl/TkTeE9kfc43PyRt7s5npbCQpgUVcekF/udF+E3JYU0VYcsNZNtjaQEwDYLhWFZJjXN/+TzB26US78gPTjGNv8g3KrLavSx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpqiDBDf; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f6e398767eso44473156d6.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747413039; x=1748017839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYuEpCIituVTxZ7fNBKOFTwWea8b2SYzKTBuPUO8XBM=;
        b=DpqiDBDfHW0Ei5jferWNe0DL3harURQVevUp18iBEHenjkzpaJlG1wMVLFEVAuS349
         qhChB257GW3/1fhHyQzbEtD6AUyEuZAjtLCF1t2tL9iDNHYiItRExD5+ab7dF9CV2GQe
         Jd4dRpyS6Flaw/0VUe72gti3mhX8/b08ZBIzBqb9n077/o/U8hEWMIpNG8Hs5VFaGOaG
         d23uh4N+eyimfdJdC22EvRxOv9f+HbTDsGQTmpGeEwKlgmKRzX3m7HLt71TsvRSnEOAA
         4I1RKsef58qKi/QuE+1tQ/ApNrgRStf0vU6uaC0JA0KkfATTphskRJR1HYmf/M9PjZEE
         SKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747413039; x=1748017839;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GYuEpCIituVTxZ7fNBKOFTwWea8b2SYzKTBuPUO8XBM=;
        b=LIAX8VFTLUtboHlYinLCTdG8my56t91KrW98NWtZrP0UAdR6DZNdgTirZfE1txNyAh
         LbXgzYF+sy7qayRtKU79VWEcpCMa83LlVcMrzHrrebU/RWb+ruLbzFNL1Uo6NJB2BAUv
         jxvaL93dS4tm8+E+HtomP00FxmphFMFtcEn5ZtJ5oI0VXVWRceQ+HAD5QcoGrzPbBl1C
         migLNjAjADkC6LKrFOhEK2CI2pxwAafgbWC6V/gV4EG9QCf462CaMF3wMnDWllmhkYSc
         BCTv3WwkXX5WH8Xxhx/wCwrzNwzEP87NLXdL+kfrYjCopdE6kfSzdli0vOODQ50ojQ8u
         AYjg==
X-Forwarded-Encrypted: i=1; AJvYcCXZkQO/SL6QaKaK+5/1FZs9IDtM3Ryb1Fu1UYbHeLVUABRE+8bvWyFy3FgQWRZfAPS8rGCyjO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXiMmfWPpeo4Sf6DXj+RI1vhIg73xbf/APEAiCm5VZ2sH0s5US
	8sCklkmK8ITMo14jwCv0t+KAjywE50Myy2aNnUP7jj3+bPqZT3r/stD1
X-Gm-Gg: ASbGncvCwA2tkoZnNFvNWHFFnxlKqOBmkB7cBUOf62FRoaUVWthqOcJDC81NWs6u22e
	7Lm5hYjTgrQmrAV/m+dUjp2dzqZfMReMQ218sfrkl8YWTKpKRSHE80+ONH4wlrP0adHOV3Dsj5i
	bSiSarMUGhkdD0Eff4PeYxw35EpkE/Oz1GYChcwOjovPifBXp5e01HDkO700Hk21CqZE+CQO0sE
	SrVjBhPlq51JELzQFsXfRGLm5XDUVZ4nwRrex2LM2kheTWdlSp/76TMAKEYeeq8kv4VjzffZYOp
	3odVHqV4dwdDZ3dUmiX1hvqRzNPrX/WuiU07im0vvRgS4CDVAs7mZG+yC1Yx8UbTalVSuptym97
	FD2anVtZMJepP8yI3vChQ6XQ=
X-Google-Smtp-Source: AGHT+IFAxxHnfzaT/dz3fggfd3uHSO53lo1O8dg22Sazc6vunyVdDzlwqDbkEMfI8Ce/wYhPGoxBPA==
X-Received: by 2002:a05:6214:1cc2:b0:6e2:3761:71b0 with SMTP id 6a1803df08f44-6f8b123c03cmr65064496d6.5.1747413038567;
        Fri, 16 May 2025 09:30:38 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0883ee1sm13925116d6.9.2025.05.16.09.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 09:30:37 -0700 (PDT)
Date: Fri, 16 May 2025 12:30:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <6827682d3d615_2af52b294fc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250515224946.6931-10-kuniyu@amazon.com>
References: <20250515224946.6931-1-kuniyu@amazon.com>
 <20250515224946.6931-10-kuniyu@amazon.com>
Subject: Re: [PATCH v4 net-next 9/9] selftest: af_unix: Test SO_PASSRIGHTS.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> scm_rights.c has various patterns of tests to exercise GC.
> 
> Let's add cases where SO_PASSRIGHTS is disabled.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

