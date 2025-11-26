Return-Path: <netdev+bounces-242078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7919C8C16D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50D7B34F778
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2200131A051;
	Wed, 26 Nov 2025 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y45h0uaa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA02FBE03
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193652; cv=none; b=B4XTi/8ILvftreWKT9rJWyBD9H9Sz3d/lCXTE7uO52o74dUCUsZojFav6G8FElwQfh2UBTuQ+urNfeuq7+wN/PK5I8leersqgCoGEz+2GSi5bI4YjUpc4xolSKlTCHJr2nX///XEg3MXiro2l47iaE/i2oQVReSe03VO9yFfmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193652; c=relaxed/simple;
	bh=aTRu8ehaR8C9IbfGge+yugDPQ0JoxwO1iOpUQZjfELk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S6wG1MYocAY/TQo3HaUNKeU7E3OhWS3rEwzkG8IyJICHliX1+Jh/eJLcxq2/8EPkG30oOgdsGEzi6O/s0zmqmpXxJabfBqN7nArfbC0i8XbAHAhGeJK1gB4GTAlRNTuECV4MaweBBnj+R6O0W6pE+9ajNIxPUInlad/+cDX1mVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y45h0uaa; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4336f8e97c3so1550725ab.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764193649; x=1764798449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRMSFdD3voxfx4MbjoadlpHFmNXjrJGlXbs9DFjlHxk=;
        b=y45h0uaayayIodmP6XzRwDvWGICm9tHbcwq6P00vz6+UVM3lhRR8uOSQAVL49K2eTz
         EE3ahRieaFpHay6tIR07nUe8DJ2aSIWJoNlTwZVC+D4jkWyd5nBz7lcbXETwBnXNVvH/
         qON2/OOOjcJr9KH/mgkYlfDcihooJ+12G8G0VlTkmx7MQhL1C/aWTqHpw++Qwp8PgsY2
         eB6Rx6gOBfr9UXMJKqhnA+q4E+WtyxmfQjhbQtaHadoBK5/sUptUhDFl86601z0USdSB
         IunOqIczN8TuGFdvXuEnUZjg1cp0GrJI/VlPjtz27EgJTzKSS2CJDMnkw6Qz5qdna9dA
         EF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764193649; x=1764798449;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tRMSFdD3voxfx4MbjoadlpHFmNXjrJGlXbs9DFjlHxk=;
        b=gWVOGl2Sg73uOGAZu89nw1kX0d9yi5V2PvL9hMM3ZAbzHRdyRGsHCAc5IO+gkb3veH
         kYKtGqiWOra1KXImj5RQLy/cH6whAxA9R30RVv6nE+IaH87Axgo7PDnF1eflEyNGG+NN
         pmavcsNb45F65m4WqUNf+63GJD3pMvw4Cp8mCy4mEEkc3ngfAqVOqsMD+kz9h5mYAvrq
         +9dJJIT7eldTmBDN3uD0fje1ShlB+rxFLQXd063KJHd91SVJpBC6whyU9qT/PvBzdJ0r
         SgCVkuQkvOewDYuRkI8RZzNDDSfUY4wQ98ojWKesj8ImGCGAARKKgXK+JgjyaJGzZedc
         cN0g==
X-Gm-Message-State: AOJu0Yw21MtymeX1npPFPEb2NAcY572fXDW2qsazLzup1LoUGcK+4s7J
	N/dbI2gVEe3FPHjmNyOSYapyN2dxa7k99Mg+UJbDmUwunvWWypMXRtnb6o04TlnrZW4=
X-Gm-Gg: ASbGnct3jWxWj86PoioqRetBt/DJ9QNHoNT7+tKLi9CC3TXMtm7SdMDUnHqtpki68DO
	wgJh+SlTw3+Ym5pd4DJXTCqxhsTklmNREs1G44UFZAT44YiN5K9s9+cdAFwJw7rIAkAhAUIIZxK
	9gAuKLVCIiOOaiD7JKLM8QQsjJQgbD+7ZOA8T3ZfpCgF3shq4yG/CPyb6KqXg6X42cWAvqVNS4O
	X9o0NFs7lZs3QhHApTssa1Kgvg0+aCCatH2hyqdthXnZp8hNuMaqtUu6w5Tdb5tucMwv4bfmAcJ
	/ZXsFKLy/HpcuA/AeuzGBTthv1sE8vG6TtA0k/zJjMtJK0PDCbYVKd2jNuJITOesFQRqBbdFTNH
	x4AIHpEi09vAPrUujz1Eg6hPgGI7YyIxa/o95nLNn5x9UN/mWnGUMo6TVneD8dTOxtStd1c93V6
	g0Vw==
X-Google-Smtp-Source: AGHT+IGU47APB8HREWIKQ7LHtSHQtH0WfWDt2UiFu0qyvc104A79dIZQ3hb8dByyuC7xO0VIA6MWyA==
X-Received: by 2002:a05:6e02:178f:b0:433:7e2f:83c5 with SMTP id e9e14a558f8ab-435b8bf921fmr185781495ab.3.1764193648863;
        Wed, 26 Nov 2025 13:47:28 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a90dd80fsm88697115ab.29.2025.11.26.13.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:47:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: netdev@vger.kernel.org, io-uring@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>
In-Reply-To: <20251125211806.2673912-1-krisman@suse.de>
References: <20251125211806.2673912-1-krisman@suse.de>
Subject: Re: [PATCH v4 0/3] Introduce getsockname io_uring_cmd
Message-Id: <176419364754.144810.11021762259652723492.b4-ty@kernel.dk>
Date: Wed, 26 Nov 2025 14:47:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 25 Nov 2025 16:17:58 -0500, Gabriel Krisman Bertazi wrote:
> Since V3:
>   - Fix passing of 'peer' in io_uring side.
> Since V2:
>   - Move sockaddr_storage to do_sockname
> Since V1:
>   - minor style fixes
>   - Resend with (more) maintainers cc'ed
>   - rebased to axboe/for-next.
> --
> 
> [...]

Applied, thanks!

[1/3] socket: Unify getsockname and getpeername implementation
      commit: 4677e78800bbde62a9edce0eb3b40c775ec55e0d
[2/3] socket: Split out a getsockname helper for io_uring
      commit: d73c1677087391379441c0bb444c7fb4238fc6e7
[3/3] io_uring: Introduce getsockname io_uring cmd
      commit: 5d24321e4c159088604512d7a5c5cf634d23e01a

Best regards,
-- 
Jens Axboe




