Return-Path: <netdev+bounces-152882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134FF9F63C9
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB5F16171F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCCA18CC0B;
	Wed, 18 Dec 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="02tMkbRN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80A0184556
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519001; cv=none; b=aTZ1qJoT+IeLuRR4acbjPD9QyYQJXKzyNsvGnJxtNIFPri3ZlDkcroXnFekxSTVdWzYR7ibFjyxqXJGLjIiqEPZ4KPMA3OEm7BAaUavJd4U7McHhFG8fm7bW95wdiP8JgiKMD8Ud5aJCZ2esT4UpO/8lt0YKfaPxeXuPZEc3K44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519001; c=relaxed/simple;
	bh=VIz2tOCZ/SofDivwCE/InDc7Knu6CQ3dI71FAwdHwas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EM0D2MKDNFpzMHeQQq48v17B4EVEXBb6nQUe3NztojcYKbreBxqiYvbrHqaCgM7vjEaI1KAgAf+zNEx+5IFfukRnZbnldiKL6XZNxXvzKnmegphRZJckaIMUaLSFd4KTL4KHs3lQuwhUnJIGBcFEkRkcT4XRqR4mVKQ4v/pFouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=02tMkbRN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso1166705a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734518998; x=1735123798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIz2tOCZ/SofDivwCE/InDc7Knu6CQ3dI71FAwdHwas=;
        b=02tMkbRN7yIU4HfT5jxDNp2pljPwJ+6yGri+Tsc9IC9pipM12DV4rS8wXmf/6ngUS4
         yVO12XAVtvVxKG2LQPfNp5yk3XnaWjSCyT/0OXw2hjsIjxRCnFbJkmC4GWuIrnoAkqHu
         52z2DymlCH5EoKSWoo481dDogFM35Z1ldMwqq+2WNjzLXBHvISv/S0byTcRAU31WYEu2
         nnQiYMgCI+vjyOw4/Xc8KefLwZKKYoR/H6WUw0J9+lrE4FYzUzwBUKo5p2hJalDHCPIa
         c1bBx1JanPRrAxGybT2crA9+XTn9hO6o3NDGLYY53J2EUmUg1kbYGc9D06msZRdhpGaJ
         6vhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734518998; x=1735123798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIz2tOCZ/SofDivwCE/InDc7Knu6CQ3dI71FAwdHwas=;
        b=eW4AyNf9m6qelV16N+DQnL/OnkJFrQLOeT/O06nGYJcEwtTCdaQyHn4pNIK8+4w4pk
         zzvGFyQgsKriwjh5CcTr4QLjDLEn5rOhCjgvN07QDGwWuUxs/CW9IIhg9Vd7I7xBc0Tf
         LCOswIiZYKPWQxh2wsTKoghUkvev3zrv1Nnqs6hy4RQsSV3JrwsrPqlzUxGBkHg8Zssx
         UD7LYx35Bnqr7b0DGo/sdWWoUwqMaUBgHIgoBGFwlI7fai7vJJBJ5Gds3MBu3muBqmAL
         YA6N8lPh3hdSw7+rkNJYOfEOMxOhD1c7ZjP8ItJJHFpYcE+ZLpNTWwcrlnANNyN7rJ0E
         aGsw==
X-Forwarded-Encrypted: i=1; AJvYcCVc4dEEKKSyRc0N5sGnh4+FfGlU89vgfUjrxtjIrGa7Z+PwSE/JjMukMP4G/fmtc8oAIOTg4Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvG1kb/HrxpMqYNNa0Hbgcn8Ay1gXiT3C/0fCvEzpzpX72TttZ
	LUYbMF+SBCqiRyIXVCbnUtjSpNKPRXY11kr3oo1Mb7tjCW12u82heneyMUTKPDrMVuC135mzrz0
	5oAZPVkU08sZOPXk7eA3kH7MYxeTS0MXpdEGR
X-Gm-Gg: ASbGnct0IN0DsYV2MSRw8sZbQX++MjgwKpT4N3GZtnUz0yQ+EH+A3JbJtxmo3w8YJAb
	sTtOAknL1A+NkbUvZRUQ9TUu66Qy/ySsxnrNqc+TT3uFJFXi66JPwrXrw40d75QOyrEcv0G8=
X-Google-Smtp-Source: AGHT+IHPCsvtMPRl80dbEmElcp3DQ3NaI0xufsz+L8k+KHXUo2iGRc7bYdX2L1k4DGwSAAnb2xq9psSdFQE9vGpxNxc=
X-Received: by 2002:a05:6402:3715:b0:5d0:e461:68e6 with SMTP id
 4fb4d7f45d1cf-5d7d56348edmr6554850a12.17.1734518998105; Wed, 18 Dec 2024
 02:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218022508.815344-1-kuba@kernel.org>
In-Reply-To: <20241218022508.815344-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Dec 2024 11:49:47 +0100
Message-ID: <CANn89i+oW5tu0JkOREsh0CEFwaWsWsfP-PpMTouQ7HZDDunFJg@mail.gmail.com>
Subject: Re: [PATCH net] netdev-genl: avoid empty messages in queue dump
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com, jdamato@fastly.com, 
	almasrymina@google.com, sridhar.samudrala@intel.com, 
	amritha.nambiar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 3:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Empty netlink responses from do() are not correct (as opposed to
> dump() where not dumping anything is perfectly fine).
> We should return an error if the target object does not exist,
> in this case if the netdev is down it has no queues.
>
> Fixes: 6b6171db7fc8 ("netdev-genl: Add netlink framework functions for qu=
eue")
> Reported-by: syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

