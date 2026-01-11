Return-Path: <netdev+bounces-248793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D093FD0E86E
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 772EE300C0D5
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF2729B8C7;
	Sun, 11 Jan 2026 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK/wePWJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702AC23A566
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768125331; cv=none; b=NVjbv28yNL36Puh7XqdKopd/2gTXBdu52zyZAqT92AHZqx9qX+3tDzCUoED4i4GSnzsCChEJ21rVIVx4ueYrTn/7JkkOaXSHQT+vMForBKUEivXA1297OUWCPjgC29TbaHipogHxGT2O8Dnj+e2qNCrsY0vZvSfoFnMz1udxWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768125331; c=relaxed/simple;
	bh=4xQ0lnjokZ5wRygVgiXgY6zXC7YvZ8Ydj/VybC0WWqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD28TfOLeOdjCi6Aj/gNT1HIVGDuSCsBs+aaGdcz9fpdZu/XMbA6qOrG+OzKMaHqh0mf5XEV86qkhWjBouNhCO56RUgeoSuLisu5B/0hjfWr1AvNOq5JKlNgPTF5z0Ouw6nt1TtMYA+vtauaohjopPyyOIcFI2Pd6AxRFHSdB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK/wePWJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso4680168a12.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 01:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768125329; x=1768730129; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JNNRCHxw8bB1O+m631Xy6zHUnRxJ+RErwtykBDh5nVQ=;
        b=mK/wePWJbO8PjUITSyr5dTfaAriWBmqJ5gZcwS1kpfP4psQcu6CfJ0Pv1kXJHnZbkm
         vM3RPgnSxJl9Rd0tUe1jYSAHlILb8hUmBgeEMiyjyUt/hIYnOezSZ9FYKHSEQUShvZ5g
         cBga6X/yfJdDUZrU29mWtd0KvLt1BOFI/ltYyvJ4zVEys028+SEnVRSlOFS+4HilKFk8
         fcdIs8Dp+ugyy4d2feej0/45uuUdk2Xme5sHXuwZh9DuahWBkuRIZxiM4Txcu6tQpNHW
         3io2Yv9a2GGXYJckD4bw68VNUu0inbcD+5V01iUsh2+HChHL/G80WyuP8WlamZGKCgob
         NBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768125329; x=1768730129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNNRCHxw8bB1O+m631Xy6zHUnRxJ+RErwtykBDh5nVQ=;
        b=BrMgqWEM/EpKN6i161H6yD5N/hJ7oVvmMr3lVEyvk3XiMlOoPoYW+3hA/MPTaeB9Gb
         qnx0vOvuIPlpJEDY8BiQrmS2qW8QRm3AP1t4bXP6m8edMMCibpvcjkHeTUKHoe2jndHS
         fKTyTgWHade7QNfAMEnGMgz33Z1TL/vgnTRaIwiVdHyEGgPmNYF16hYdcwfKNVEzAYFi
         1ja0e9ZmM66vBsR7UixGg2SWxMCqtE9NgIA+4brSw+0NPGUpM2OeS+hwPB3OeN3h1saX
         oNaIAr3Dsse2eMiwXjdpeee66HfC4spfxka91pxNSYHO5KXIRb57XAEL73g0X1ttrLNI
         Ws/g==
X-Forwarded-Encrypted: i=1; AJvYcCWOlLaxPeYQXmNlXvKYb2blVzGYyCxoW+YUJrCbwg5B+lAUH+rCwOwk/PN3MEkULCU5k58iJDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3jcvHNhbSiZN2lYuzCUuDsC0FKmlBRnDXRHaX6N1H55i+XZOV
	YjrO5saYfar3mk/CAZiitrS5oRr/iOn1utw6Z5FDPJLmtkAAIvEnnff9
X-Gm-Gg: AY/fxX4Q8YwRwDba8cZLQCxP1PvjS5G/Gxh9YhoWpHXyz1Ss9bgusIUqOwzuHhpcjVC
	hWsygyRU5FnM3Le0zHKR3j4eS0PiDdaTsTUtKNKBJSQKdvf9NNLy37w0ZIEpyVDvzWqo1rIxSVv
	oyY+/LAwHmXTFPi+paNBPnuoEbeV3OSHZH3XTfDWuJwM1QTzVkEak2xI9AQYLfThYO9llGXnpMv
	qN58G4fKQdMwxeACUgCdkWVcsbsoi3fcKKJpnR+QWMBvMNZnKxptz3hyPzIyiIijC6JfS5WDtLy
	ueCRdNiVq1riF1QVVYm1S5URkMA9ApchcaQcz3aW/pzqsvCOkG3r4tDnR0hWT8B32pQwUk9APs3
	AVYPawO+0jDB1wsXRbF8/bLDh+UdvEu2tQ/CvpjmWI9W0ruPDPXuk8s3Zn8eCXLa9cQMRSb01Yn
	UoQXGsUG0oRPBv8XEU4pJdN37Xvvqxb7WlUO7CHnish8qld5A=
X-Google-Smtp-Source: AGHT+IGM7yd5cjTyha4hJaTtSl4mFUs+hOacf34SkiHiyNc3aYb8M/WwDZo69tUNyYuSNWCv1vjW9g==
X-Received: by 2002:a05:6402:1d52:b0:64b:5851:5e7b with SMTP id 4fb4d7f45d1cf-65097c2b44bmr15026819a12.14.1768125328756;
        Sun, 11 Jan 2026 01:55:28 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4ed5sm14356431a12.11.2026.01.11.01.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 01:55:28 -0800 (PST)
Date: Sun, 11 Jan 2026 10:55:27 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
Message-ID: <20260111.ac6689582f41@gnoack.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260110143300.71048-4-gnoack3000@gmail.com>
 <4bc22faa-2927-4ef9-b5dc-67a7575177e9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bc22faa-2927-4ef9-b5dc-67a7575177e9@gmail.com>

On Sat, Jan 10, 2026 at 11:45:03AM -0500, Justin Suess wrote:
> Just for awareness,
> 
> I'm considering renaming this hook to unix_socket_path_lookup, since as Günther
> pointed out this hook is not just hit on connect, but also on sendmsg.

+1 I would be in favor of this.

(In doubt, Paul Moore has the last word on LSM hook naming.  I believe
that both "lookup" and "resolve" are being used exchangeably to refer
to path lookups. (e.g. see the path_resolution(7) man page [1]))

–Günther

[1] https://man7.org/linux/man-pages/man7/path_resolution.7.html

