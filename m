Return-Path: <netdev+bounces-201996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8BFAEBE38
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 19:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB85F1899848
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 17:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FBD2EA743;
	Fri, 27 Jun 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Bgs+tf7e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD02E88A9
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751044068; cv=none; b=P9slAS5mzWOyjfQ2DRbK+y90l2MerZmbO+wHNVAKKO6A3WrypPWrH72UsV6+a4GZFR0L+wxF6z/gBIjjGBPYePcGK8reisaLMa7+uFUI3/xy680zEWDDY2+imThCUo/L22QUsv87MsVfli6kbAHuxmy8k57yn3xytnfZGqv43vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751044068; c=relaxed/simple;
	bh=9R4KX5LVzQeRCDAlhZSrpejItAz4c788fhDtn97W/Jk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V/oPrmLCyIFQmhfbcgSuJpmyJIKZu0l+9TQajISorrp2llrDeN1kxTZIyqTP3DVvrFeiWAtz9Z9oTrG/0P0+5G2hTgrjjwnB2WG1ULlVOPaTyn8AawiX2mdG5XAJaXoMmnrd6MRBrr0ZHFTAGUWNwgEVO5VvTumjkJLAgOgITtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Bgs+tf7e; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74af4af04fdso1447978b3a.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751044065; x=1751648865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DKFOh5pgpozqfr41pG09hBVywmt+Jc1GMULv0a7/G90=;
        b=Bgs+tf7ea2qxgqilFNS/K0ayKjFN8OGZZDqULQzdthDetTSHTar1KYGEwOHTnCPay4
         lgcnKEbyTHufgGjcN72V0Sd0oBvNI4dzX1tLvFOE0htHr+W3ElfLIn7N8/K0XNwL8i6L
         0TgkVqqLmu266FsqXvYbVfGVtRkB1hjieaQyBcfFot6WdHPNDcbNg4xNSliDTElpaWeL
         tUNZiY0NSy2QVwjSJetUyz+LVIF5ZfCJ2IWLUe97u1w63bwJAzG/whPERzFL8IPlEtsK
         Whpft4JXHAGQrjQBsn2HSvfQTfo0zfRfG1I5tUGmPLaBUKFZU0kAwDqJPfzQeWogoYJJ
         RWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751044065; x=1751648865;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKFOh5pgpozqfr41pG09hBVywmt+Jc1GMULv0a7/G90=;
        b=lLKCBwQHdoiuGTbXaYwT3DTDCKxv8xM/b4cDo2To1C2Z8cuD7ZQnaB+O5nH2q1Fuks
         BzeCxrficLIO8i5ZVFAsSDczanqIBq58WPp497bL68eMYYOc1wLTmHSdx6yMg+SXks0t
         SvO3vs46tZTgTHF81vj0wSFwqk86EhGq2GJLQT5FXKJPQVzAfS38xOMwGf9WpUbwNFkt
         h03O5LPmUkk5YB/cBtYw8w9dTEnjJz8lIrTCHnfJ5qcnbQwpdkLMjnzi+Jt/PVv56YQK
         nDnm1bBVFU9G6HCFppTd2jm4BdIcenbh093+gveydKINcANq43Nb3GOx67q9Jb2VHNtV
         ZG+Q==
X-Gm-Message-State: AOJu0YzoMPIw/43xbOdAUVEHq1nSC4LR7uYnrQbsbNQ97HvuE+boFMi/
	DkDT+pR/r93SX/ZTTN+MjLdbwhhT6IgPBHBIJX+zf9YTi8ki8rUzgNhdbFxk12CCZF9N9q0DduB
	/pidi
X-Gm-Gg: ASbGnctvt1EyZlOAJD28QTdfs4/UyMRdHZ58PxKjrPin2fJk1ZorWF+w0rkNBLMBrCr
	a35bMEDCVHWnlHvPyT34mbnIDyqJ8Z6IRMO5mGzrsnn4dfkDKUxAGyW6mMX1l0F9o3znrgdXShj
	gFE8k7uw9iVs4hjshBBNhWbATnU+HQdP65PLmbD68R7pcUxw6ZykG0T2xXPpDVeiCPFSE96AcYj
	STivDTCCnEP84Gc5noVCIwsJQnR+ed8tCunVdtmFG9h5+RPdIMSdyD/213OPdtbrsBcM+EfofEE
	4ALfp7j6EHz+yLGmQ5rp3t16k0/6Bt40NJfpYMCF1WH65HeRgzCBkgLPlw==
X-Google-Smtp-Source: AGHT+IET2xadnrSWzVc7LaA0b9mLXiuRsIEBEia6Q6+WKlU0qLyZik+nq6ExFBljf8KkZYW+Nvol5g==
X-Received: by 2002:a17:903:19cb:b0:231:c89f:4e94 with SMTP id d9443c01a7336-2390a54135bmr119273235ad.21.1751044065091;
        Fri, 27 Jun 2025 10:07:45 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14e2236sm2621251a91.26.2025.06.27.10.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 10:07:44 -0700 (PDT)
Message-ID: <a3e2d283-37cd-4c96-ab0b-dfd1c50aae61@kernel.dk>
Date: Fri, 27 Jun 2025 11:07:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v5 0/5] io_uring cmd for tx timestamps
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jason Xing
 <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
References: <cover.1750065793.git.asml.silence@gmail.com>
 <175069088204.49729.7974627770604664371.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <175069088204.49729.7974627770604664371.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 9:01 AM, Jens Axboe wrote:
> 
> On Mon, 16 Jun 2025 10:46:24 +0100, Pavel Begunkov wrote:
>> Vadim Fedorenko suggested to add an alternative API for receiving
>> tx timestamps through io_uring. The series introduces io_uring socket
>> cmd for fetching tx timestamps, which is a polled multishot request,
>> i.e. internally polling the socket for POLLERR and posts timestamps
>> when they're arrives. For the API description see Patch 5.
>>
>> It reuses existing timestamp infra and takes them from the socket's
>> error queue. For networking people the important parts are Patch 1,
>> and io_uring_cmd_timestamp() from Patch 5 walking the error queue.
>>
>> [...]
> 
> Applied, thanks!
> 
> [2/5] io_uring/poll: introduce io_arm_apoll()
>       commit: 162151889267089bb920609830c35f9272087c3f
> [3/5] io_uring/cmd: allow multishot polled commands
>       commit: b95575495948a81ac9b0110aa721ea061dd850d9
> [4/5] io_uring: add mshot helper for posting CQE32
>       commit: ac479eac22e81c0ff56c6bdb93fad787015149cc
> [5/5] io_uring/netcmd: add tx timestamping cmd support
>       commit: 9e4ed359b8efad0e8ad4510d8ad22bf0b060526a

Pavel, can you send in the liburing PR for these, please?

-- 
Jens Axboe

