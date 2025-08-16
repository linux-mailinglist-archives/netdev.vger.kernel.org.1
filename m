Return-Path: <netdev+bounces-214351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C965B290E4
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 00:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C209DAA1B2A
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 22:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4C23AB9F;
	Sat, 16 Aug 2025 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="b6BEApY6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F3B665
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755384920; cv=none; b=Ojz2wE7+PSTFMXYPZHJEuRlGj9G1R/UCHa/ijuO6x4emD+u+ehgInQxHmCRbysbQx2EMBfimoh2jNm364QEXbEmuX2LQ1wN4KqJjF5Q/Olk/wYt50g3ToLN4T2OTVkdjRJY3WC7MCEz2vQYWCcCib4MTXixlD89aWS7ulFeKRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755384920; c=relaxed/simple;
	bh=AEvArloZ3BWQ3DbluhoyjmSpGJPdsLE1mLjBLyUM0Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HhGxZ0iaR91+5daPISNvcZg33hgqFxQCQVEZSBxujP9nTG/WaquGxwwSgZMb0V/uK7fUxlDbjc/MnqhHuqsVaTybfrr5Wf9JMGEhWS2ODqwdNYLOHWlKO5CnTjNcde7ixP2QwvztGtW6Gd3czaDkSr/aiITXieJOhbRbw9qmCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=b6BEApY6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so14742555e9.1
        for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755384916; x=1755989716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6jZYgmAx5vVpg2HivJa8kFhxccGVwjRj+V6kKt3MVY=;
        b=b6BEApY6s3zWT/Zh/arG9D81JcV89jaquVP+yhPeZdMEL8B2YEiOehaSu62TDESDy9
         DQsttAFFTGKX4ZcjBbbin/D0kKXcy5UXuG5sgiBy86wmvnoF0L4v0807YyoVtKNvHWVA
         YG88TXpqstx3Nf0xsAWRwLSHiaKNoMZ30KUnBOyP9BmFdq/SykCej/qRMXq3aOlFYRXq
         +RMBKRTA6QC6RXGVaY3LKaH5ieu9D5M9t/JQUfHeVb/7Dv908O/fAGjyfTYmfUbz2Ow8
         RUBEm98SEJL6DAEHeXxbEadJ+CUW8TRQcG+YwfjvDBjRr+li7fFy1CbbMxKiMFfUVyQD
         mEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755384916; x=1755989716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6jZYgmAx5vVpg2HivJa8kFhxccGVwjRj+V6kKt3MVY=;
        b=BbvAyXsKee+FQRJplqNxCaepjZaG78Pgg1VbiGqwTARrBpBEd5EAbXBXCO8Wj6OEQL
         54m+EQMWGOQqlvCL3qw3HvXG514P4erDGPOVwNcF4ISyBn6ljqOMTv47VV2S07G1TVuq
         +/SJRYGDUVdnC5tf9lepN/3SAR3TDSkEqztRKlQ6W/Z3/h2i3TObKsg7JHy5rtp3BGal
         GrrfcpsgTQWdIepXcu76yk14VwP2sPjU0xfUApK4hX77qWNSqr3DijcenaXsR/gbsllE
         VW+HjjS+uNf1A+0GqyOMUz28WhnQ3nbR2JXy/ntTuMniHD3uDR62+7skNcQTMn8Aew8N
         khSg==
X-Forwarded-Encrypted: i=1; AJvYcCXurd8iBYEK99lGsj0MwL+0IOzqKWi6OtR9nm+NHlVPLwHn9X1yRlqmriaOdTZG2KxEac9yh1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQr00DJjENDukhbA8E2a7rBTylSxkGnHz4zTNSvRkf/NjwElL
	eXJlEUf2lXzKmlQDEwUGM9bd1oDiUIJzoWgKAS5kTzKNJlcL9EdSzoFLhI1BuX3rBqo=
X-Gm-Gg: ASbGncszsqn/aW4bU5JeMRh9ZbI4agLXRpf1iLhxroC+eGiQCcg7VKMHaLOyA/wm2wW
	Ozq9ulz/Dveay/W/ScPwsTzyks8mC5ioaTsjXeoJPwfKcx6Nh/bcRS2e2vO3ONxuGHUqx+QYvyC
	2NcvOZiEawDBRDAevdK9D9ANpsgH6DgRATK20ysq2H0IiZ5VV2xtfSikaFOH13X8imj4CVzOan4
	yQ7smWfEiRopRUnm8FjijmkVi17d7Mjr+4JCaLSSYi1ioDmAcIcyroxL/hZI7Un7WRr/Qu1IOWL
	+IFnAL86qLHpqtsjelggYJRtpGTKOPRPAUsovRsCVjdJi5YWiz8MVI+daFmirQCZMzBPvCdpEnE
	ZZRd6ZmWSWv49W+A6OABJHITUdDGVRZDhhEL2w2FYCgllM6y2v8R2PYrdZEp4Aylf+roUWCOM63
	c=
X-Google-Smtp-Source: AGHT+IGOK9rykLY3ElA5o/IPjdijpt22g3T3wrZwjOOi9aihPLySB+WQrwbRKb96vkb4y1g5vqDYtA==
X-Received: by 2002:a05:600c:198e:b0:456:1904:27f3 with SMTP id 5b1f17b1804b1-45a2183d444mr50373885e9.18.1755384915798;
        Sat, 16 Aug 2025 15:55:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6be103sm114839615e9.2.2025.08.16.15.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 15:55:15 -0700 (PDT)
Date: Sat, 16 Aug 2025 15:55:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: dsahern@gmail.com, netdev@vger.kernel.org, haiyangz@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
 dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250816155510.03a99223@hermes.local>
In-Reply-To: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 00:05:02 -0700
Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:

> Add support for the netshaper Generic Netlink
> family to iproute2. Introduce a new subcommand to `ip link` for
> configuring netshaper parameters directly from userspace.
> 
> This interface allows users to set shaping attributes (such as speed)
> which are passed to the kernel to perform the corresponding netshaper
> operation.
> 
> Example usage:
> $ip link netshaper { set | get | delete } dev DEVNAME \
>                    handle scope SCOPE id ID \
>                    [ speed SPEED ]


The choice of ip link is awkward and doesn't match other options.
I can think of some better other choices:

  1. netshaper could be a property of the device. But the choice of using genetlink
     instead of regular ip netlink attributes makes this hard.
  2. netshaper could be part of devlink. Since it is more targeted at hardware
     device attributes.
  3. netshaper could be a standalone command like bridge, dcb, devlink, rdma, tipc and vdpa.

What ever choice the command line options need to follow similar syntax to other iproute commands.

