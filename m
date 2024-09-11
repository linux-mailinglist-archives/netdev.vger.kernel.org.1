Return-Path: <netdev+bounces-127288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CCC974E39
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A7E282E0A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A3015FA92;
	Wed, 11 Sep 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUQ3qsRZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D317E01A
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045961; cv=none; b=MB6mUyLlGgVbqYMJrBSrLEmjCK6OYd+uqFcdYUGZ5aDatYeZ9nSndBAn1XhFXlJZJjIYN627jV0w2+QdSR27MUBhiWqjdhWNScvRk3VZSHKgWvxG/qTTNabIx6FXlOoRRaE4DtAr5wX60ozaZ2+1wUbUfvBzYEnObupF7d3NfYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045961; c=relaxed/simple;
	bh=vbUWD4st5YJACw89LRnLBpQGYy6V7Oeo/NpfG48VMs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ1+eP7xUqXZA4JY8WSJ61Phd3ieeXccwjN5HXsPMrEjQYQ59Ehf1KhClvPMpaj58KR3LRFxxWfppAHtMRLKP36tBm5Thj0dYz3ljwoz5mh0FpHXPLZEDpbK8kKVp7uhzmy5R5BVDWXBy8LvzTJciLoa3EduCIU+FPCPb2GIDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CUQ3qsRZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c26b5f1ea6so8236356a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 02:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726045958; x=1726650758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbUWD4st5YJACw89LRnLBpQGYy6V7Oeo/NpfG48VMs0=;
        b=CUQ3qsRZq2UXVci/02H0PkTqQfuW9S00kAC46O6XaE+KLkv4JURf9/QQilXXatj1hW
         L5L5VIckgO43psOiY8OZAp30AS1pZfjSem/01p9E6R75y943cI81spjBUoIyDZvq+5fc
         G4eM+c50LYlZW6Vq9NPenREc6k1M0BNY8DrLNZE4s8zT83oZF5lc+ee0CZ18tZNLlqU7
         nJdRLI2jexlNvsOUeiGJII7C4cz9tq0nCQM1eOOv5tKwFh2llDFNqMcdk+4GsFxdhv+c
         FaP6gPIswwbc8DYf9+4NgCZjtivHfudHQeovHE1kmoRru8Xs3eomgymVz065z7OBFiSE
         ge7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726045958; x=1726650758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbUWD4st5YJACw89LRnLBpQGYy6V7Oeo/NpfG48VMs0=;
        b=rKK1+TMmEdeBpkwZ76lNVx2wZWiMa+Poz2LsMdMaBUH02VEUmyTZ+vnvXwSvnZGMeP
         DgA4holMbAs9tbfospInMPh/XfK1pfNjSNM3Cry7nLvpwUGsNvoiiqcdmzML2ccqPCNV
         uaaTl/X+4RO0oimJ3eNPuykjvE2zmySK6jh9e7EhGS6v/36W6iP0/ySJidomxT5sokGO
         duyXJK7Rwr/G8MpSggjmzT/bbBjNpl5+NKKbqqD7fdLA8vfcudGHmp9avIK7GSCdZ/+h
         1uoSg94X84c6iiOv6p8AESgvAL0ByC0aGEuoOmMwMors8uq2xDsO+V0IMvJSYMPOjctA
         JNMw==
X-Forwarded-Encrypted: i=1; AJvYcCVqFQv6Fh8bHK76pr7a0BPL6Rf7o7K9psxlrlbS6C9LVlD89H/iy+CUZGDhNCEljbSmLr37p1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyazGN7ViCH+dDons17OVYKzEaI2HFkF0POE6D7U12vWbK0owJ7
	q5QEY9kH7/nUQKeqnurkqmObp9p0Rr38lie/M7vnbxZHyiky5CY7VXhEzZzeyiTXHf8VHwUGSAD
	CumhMEF2BuMl8AfP+53nAsnbavAp0jrpeRBve
X-Google-Smtp-Source: AGHT+IFTOe7wINzq4zhj3zcJRL3zZsKN9eN9L1F6J2ydGaat1CgRGk6c4e3IwLEldhlg+/NBYzt39to5OiJNJbJiSQE=
X-Received: by 2002:a17:907:d16:b0:a8d:510b:4f48 with SMTP id
 a640c23a62f3a-a8ffaadafc4mr362683966b.22.1726045957356; Wed, 11 Sep 2024
 02:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911050435.53156-1-qianqiang.liu@163.com> <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
In-Reply-To: <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 11:12:24 +0200
Message-ID: <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: xiyou.wangcong@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 10:23=E2=80=AFAM Qianqiang Liu <qianqiang.liu@163.c=
om> wrote:
>
> > I do not think it matters, because the copy is performed later, with
> > all the needed checks.
>
> No, there is no checks at all.
>

Please elaborate ?
Why should maintainers have to spend time to provide evidence to
support your claims ?
Have you thought about the (compat) case ?

There are plenty of checks. They were there before Stanislav commit.

Each getsockopt() handler must perform the same actions.

For instance, look at do_ipv6_getsockopt()

If you find one getsockopt() method failing to perform the checks,
please report to us.

