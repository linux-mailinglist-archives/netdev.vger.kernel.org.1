Return-Path: <netdev+bounces-195119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B4ACE1D8
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FF41755FB
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C61DED66;
	Wed,  4 Jun 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqFWrL40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5861DE3DC;
	Wed,  4 Jun 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749052801; cv=none; b=cBy+V9+8RJ2CYmtqljsb0zU/fuKS8bKo5rJd4cowWOkx6j7UoBiaDmep9+/VhPPOiA2n7TmVU5CHG8qnrPRLpJ+EiFx3U2MdWgnQcw0IFUtv34pvpTuzW8sfqlhUWDWlyjdRtdqiSl62gxuyeOM7ttMtu0H1MZ/UAM59rsB0DLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749052801; c=relaxed/simple;
	bh=bqf3JTaTlwq87CZNwJUGZ70q+VLsYUsOZiPWGW5E7GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTRJq/ixFA367cA2So1+7MtpVM+oieby9M4MWdsIYMzUWZ/D/dSS9IyU3rFXp5ByAzRg9/Zqyv81d4qNIJXeIUZm4WIHg3AO7uX4EOaqPePuRkGmJPgR/gk43HdphBZ19Cdjz9oPSaSFQ9uOuEtE/l6TgI2u/qXeLquNjA/Zmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqFWrL40; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so4422202a12.1;
        Wed, 04 Jun 2025 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749052799; x=1749657599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dM1lCBJJXDO4DiBRlM6aBDf7G8E0w98nPK/tgohLyHU=;
        b=AqFWrL40JV/6NNaO8AC64Rli/cRnDvfRZzaJcH+1ndiLLDps7eXZltvkultb7RmiyV
         8+FtAWKRBnsPM0dHFy4iQVUgaw+Q7sFgPpgBI/XdwKlcPQcG0IlV4Nmw/PNct4nKSOpi
         NzNPIlPpGyCRqmf0blp1pQw0PzdgZlXkKLQJNrBx/imvzhJD+khqwHRddeA2Ww4bqyjG
         aeDJ7nKdDGiXvF1G6xPuFGwKotsUTsv2Sm2UjkHQKzjtysDYOSPfC1ss2fZ5sHy5wfZw
         gavhfknJRfZc0cIofxKV+JXrh8grtC79ogqFigmvkJ75rDp8fKntCcSbm1zyG5MMh9qg
         MhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749052799; x=1749657599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dM1lCBJJXDO4DiBRlM6aBDf7G8E0w98nPK/tgohLyHU=;
        b=QIlUnP6KymozZj/9b5Kxd7kFV0XaWf6R7VM7YY2JOq3s9+AoyuCJMpyIj5OIK4VCsI
         2zkUZYgE4IovTYajk6KON4dP6aBzryidP8biSoqm5iY+Gg8hekPUiJpqZ+qNV+rJQMBc
         hmURfpdhtIHFmlMyD8Qhmxa0gegrUY+8Xu8u5qMhKHzBsQd1MzicpKxg1JlHQ/9xmJ07
         BhAkuNMx5K+sqVgAUzHszeQjw4raN18lpqjah6T7nYw/2+0Ms1PsCPF+2Mla7FS9rP+G
         OZn81A5c/zlqZKmDTZS3hpXHaUwRbRcJSBdPYur6LkDLWRp7ajLbh/X9/uUcikz6x4oP
         dLiw==
X-Forwarded-Encrypted: i=1; AJvYcCVKvSKb4z2O2PbimuEGDJbQduX0uMfYSxPb/ObwBjr1hd21sjmjbWDhRi8lpoB+D25w4qrmpTrc@vger.kernel.org, AJvYcCXWkvgNSmriW1RSZ7shGLrBjN4IJZzCrmBan7eHSzxyi0PAqNFoeGWwI66RLnHFLNpNylKfVb71511wf0hYkZt6dGq0c84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4qlkARD4oDH/g8jHL7zxsXrBsb/AvuijVSHgSloQ6tjbzME6j
	+FOxUjq1vGsA0QUaXYhHMC2CKR7jTM2hr12pUsPbEfcxOIEKN7mZD2Y=
X-Gm-Gg: ASbGncuCCBWFrHURA9AGSBBmnr0xA1TJ2Wq9W1cPSt1IJ2riRGNyM7Wek2CVytpiOwN
	LYtAO5duWV+0u9kO3wA9idigVema5eToACTHhuKfshTskqZs/A7BS54ACxhU3M57DGrAOwCXQhm
	yID2DK9V+jyvXsw7fblp2gE1QD/wq9TMZhC9UHIcETOlbk5zaKHASr1RHYdOJ/OCselgsTmzkxm
	oTIdCI1KSv/fs4nzNxcBqdD6wl6aIxULuK7rcVMfg/mTH/SqlyutL+CiF3An9c+HorynWDdkEc0
	PyFOyXYxHZPlnW+nIzu8ghkBb1me
X-Google-Smtp-Source: AGHT+IFlF+KS5R7xKjKcaBr8zU6NOf6aoIeRrfm4hUlAWuFFQitR6VwxqboaKUiCoWBpvgMdoBn5ig==
X-Received: by 2002:a05:6a20:12c3:b0:1f5:7280:1cf2 with SMTP id adf61e73a8af0-21d22ab3d49mr4922513637.12.1749052799499;
        Wed, 04 Jun 2025 08:59:59 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb396f6sm7753648a12.42.2025.06.04.08.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 08:59:58 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	eric.dumazet@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	paul@paul-moore.com,
	syzkaller@googlegroups.com
Subject: Re: [PATCH net] calipso: unlock rcu before returning -EAFNOSUPPORT
Date: Wed,  4 Jun 2025 08:59:42 -0700
Message-ID: <20250604155957.45116-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604133826.1667664-1-edumazet@google.com>
References: <20250604133826.1667664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  4 Jun 2025 13:38:26 +0000
> syzbot reported that a recent patch forgot to unlock rcu
> in the error path.
> 
> Adopt the convention that netlbl_conn_setattr() is already using.
> 
> Fixes: 6e9f2df1c550 ("calipso: Don't call calipso functions for AF_INET sk.")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org

Thanks for cathcing this!

Reviewed-by Kuniyuki Iwashima <kuni1840@gmail.com>

