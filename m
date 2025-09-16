Return-Path: <netdev+bounces-223599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF505B59AA8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8ECE3B56F6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CFD3054C5;
	Tue, 16 Sep 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="y4MK9gcD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E712F6598
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033722; cv=none; b=MteaECsPDlFFrey/qU0Adw2tZrEaGZ4/kz3mgNUN4erXMMmIVJde6MTemc2wbpMEQE58w1zp1aQOHq2tdPwt/9CxzyLTHvuuBSYFFmgcIsW1Lw/FRkXvk63X8y9oUj524hWHjW+ZZlAqA/3huyOn6fuh3sWj9vghKoP5wu8FuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033722; c=relaxed/simple;
	bh=X+YYV6m315BJrq5g9Y6qrALYP7pmjMtRpYkpKDaxQjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nzzu5pjAfJSFE3scaNFvTu1hgG343vohH6F8wwBTpbsH99iqF/EwWjFynujhJCG4tVpg/POEC5ORWJls9DLkjo1vTeYBLmhkoCwFvx0+GgUQC4r7lcWQs0jstKTa9ygJvqgCopUZ0nnNNCiSI+jqUn2cSF1gAZ6NoO8TnsXe3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=y4MK9gcD; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-78defc1a2afso4218676d6.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758033719; x=1758638519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+pRG4uKKvAD1hAGCQi66sw0UlVJv0iD8922lD8ndJU=;
        b=y4MK9gcDb9czQSsfz2vVM73In+dZcB93tGoi87su/rw6h25NGJ8BBykwuzyMJsDW4a
         mpGBBcU5Kbn0W5qRHz85b+qykgT0osBOr1PA309IBv6+4nTM9Pk8Zzs/dtCG/Ty8xpRB
         EKNVOqq3wR6PTCHMD358fA75sxHN38JlzOeUhrYo1rUBm2RcVnpBmnias2wDzIpNOfAS
         XTpr+9m7pqUltycVaWgcVCYNpUMVfJXhO/FqfGibG11KSCHtPmdXKsY42K0XAj/KA1Z2
         1YL0ncS4IJF+aacn8PEU8vk/77kdBhbpTA7mUl8NSfzeTiCXq4mZt37ShWUsomPorZkB
         TlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033719; x=1758638519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+pRG4uKKvAD1hAGCQi66sw0UlVJv0iD8922lD8ndJU=;
        b=WIJAiQkwUJp3UPBwrn3dVZ4zLOtYdIyWA7gx5xcVUYcJaSaT7UNwzoYir9BJFdIitk
         XJYIUdixgkFy4UJxDwlxZqSkIfa81lz8okhmwWgt7RGMb+kHbx31WuaQ6EL7ptgMc9hf
         tEKfzi2L1h8yhkLsAQKeaNCLaE69VPWw6Cz/LdiliALIBmMQqDzI3me8nS/RVvZIR1Ds
         0uk5UlEWX0VLbxvOC+Jt9wnnh+y4HHQTNfdeq+gWQQmTvWP7X9DaNNJXImIFJKJVCQv0
         MgAbK9rH11dhJy0X+PQyvBX07jQAj8eWAFARqDN8s4nJ4WAr4ozYhj3FuFkzt/DT1T7R
         Zeww==
X-Forwarded-Encrypted: i=1; AJvYcCVzarpt+ShxQrR6hxn2PVUcnUIcFFLALCVpwDlYaUJqCmR0P9hrLf4fjCgj9lei3wJhXs0UCkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdSRL2wzT9yTw4ExiPWUllX5LEdp15OMnpNu3qOrhvpE6ut4L
	lpTbNruE6lPlrupHDaa78NVQGx0wLramZHIrLt4+qCg5TEMDcpzLOO7dVz+RxVM1ePg=
X-Gm-Gg: ASbGncvVwafELtxgwGJQbtEYIYY+45Kp1Exmw0eBzOFgGIZwdmVcNUeRBSuzVD/iy0r
	BbvutX3ytUvlbVYd4ZZG/JGC1c8YvRyRdPNKNS5oafg6n+H0ZkgBed1OJqTtQcC9euCxaSXOf8Y
	0eXa4r0anWUK/adq+6p9KY7vAvGBeOBJaNacG/jYO2FeSRHgstZKEEdag7l6gdYt2bKWi2B/2f7
	ElTEu1bRnmGNe7ntBgwxyA5rBVE1CW7Zv3IE9cz4Z6tRAsnd8otOX5yWOTkCTv2c8kWiVaJVgoO
	rorg+pEy+BnL6fZbtGEAaz9rGz/twzbeILc9yQUFSSAe1Wc7doJpQiSpzLsZNZzeZ2upjKLaLlQ
	yn7Jcr4RUxs54Q1FVQDiSo7gdkmRhuGZ0AAzdrJASgVimh0s8kULx6mzBKehgmfZcsfz3erAUvn
	gTEiKxE0+9qg==
X-Google-Smtp-Source: AGHT+IGU5qT6hTkVD3zlyzUVtmJ12JjDOu2eiegpz9xAgrxztoAs8qTwOTdY7X0Qwe8dLwzUevDPyw==
X-Received: by 2002:a05:6214:21a5:b0:78d:96e1:ac50 with SMTP id 6a1803df08f44-78d96e1adb0mr21339036d6.64.1758033718912;
        Tue, 16 Sep 2025 07:41:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-787f7ee380csm29356246d6.11.2025.09.16.07.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:41:58 -0700 (PDT)
Date: Tue, 16 Sep 2025 07:41:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH iproute2-next 1/2] scripts: Add uapi header import
 script
Message-ID: <20250916074155.48794eae@hermes.local>
In-Reply-To: <20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
References: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
	<20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Sep 2025 15:21:42 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Add a script to automate importing Linux UAPI headers from kernel source.
> The script handles dependency resolution and creates a commit with proper
> attribution, similar to the ethtool project approach.
> 
> Usage:
>     $ LINUX_GIT="$LINUX_PATH" iproute2-import-uapi [commit]
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

Script I use is much simpler.

#! /bin/bash
# script to copy sanitized kernel headers

if [ $# -ne 1 ]; then
   echo "Usage: $0 kernel-directory"
   exit 1
fi

SRC=$1
if [ ! -r $SRC/usr/include/linux/rtnetlink.h ]; then
   echo "$SRC is missing headers"
   exit 1
fi

if [ ! -r include/uapi/linux/rtnetlink.h ]; then
    echo "$PWD is not iproute2 source"
    exit 1
fi

for subdir in . rdma vdpa
do	   
    DST=$subdir/include/uapi
    echo Checking $DST

    (cd $DST; find . -type f) | \
	while read f
	do
	    from=$SRC/usr/include/$f
	    to=$DST/$f
	    if ! cmp -s $from $to
	    then
		echo Updating $f
		cp $from $to
	    fi
	done
done

