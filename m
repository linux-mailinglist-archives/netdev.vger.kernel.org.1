Return-Path: <netdev+bounces-165029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52824A301CB
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF81188B2F6
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D241D54C2;
	Tue, 11 Feb 2025 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si9CrZRp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092AC1D5147
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242590; cv=none; b=MvtjM9aN+jqN9Z8a9tiQXAtPZsAzmBYe5Xfprgs3ovVtyVY4BWvYgozTOa4FqyevSS4KFQnBbriRfZF5Za4Yoxc6moDz5K026ULaqJVvT+7M80h25s9rXanrqwemVo1JPBh4UzDpCc6doqYYybQOYia+rAhRniMLEN/0z4p0vco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242590; c=relaxed/simple;
	bh=6Gc+7orx8UnOqA+ypi5w0+tMqd2/ona3RdlLOJWQLq8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ej7XR4WGGtv1QezMBga297L8+xXaFoASU1/NK8aQBrAZLtoRRUJPDWZaexvXluxfo3iw0rUiKOm80cw3ecWtCG3xB0qRtUQQQh1iSQnIM2eBNe5ROylVnv9QmvrRTL5ILNdMPjmww0UQB9ien1LJRWBIYIKD4YOT3cLBjDriRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si9CrZRp; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e4487fce51so18175836d6.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739242588; x=1739847388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOHZzwCQ/myqo+gwDEkJjemBLVd+Edrvrd4ft8eKgPg=;
        b=Si9CrZRpfqc9M/KOUqbThb51zU8FgybA0CnaDbKPW8xKmeuAa6HR6U9pYx9Fh3NP7Q
         gIHkpenVa3WArh7hZ3oqPYejNWbyLDZ7W/0SLlxQmVoJaX7xQYwWz9Xizw7HD/W92FsR
         X0UaCBaNmj5Pqt+VIoGb1YRaZAYxFJKhLR1J5wrGZIczZuViof4++LtYUHy/SVveHwRD
         bt/PHO+imVdiRgjB/Y1t0SjohEITwIH9DBFQ9UokbpOXYaKNZ2/oeGiVS4W2Ui3rFPc1
         K5ynOiRN6gRYooY7EJi2vPKDGCJZbyY2bB8qG6kpkafTKAqnR/vXJRQ16oiQwFoO8BNO
         iLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739242588; x=1739847388;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cOHZzwCQ/myqo+gwDEkJjemBLVd+Edrvrd4ft8eKgPg=;
        b=Qs1G68t4cwVZo6iZ+RpaC34Y35Skm4/UakmV7Nzv3muzvFcKVZA5q7ZeYlLiiyLYpS
         MW3/l5jUKQUT3QyKo4AShP3h1GR6JigwQlMJm/roQHrhzetbBUSYsoWyLjW+Mu3OTzLO
         X0lNDKRgtittFxpdxC6iwqUrqoqAOwevV5QI/2sYg0/llOX+67jSa70ghGmLtVNyQDkj
         6M2/UrjlFaCa+d9Mry7ROl5mdcBOgOu49cgYE9Qyeq81VWWhflyLCvJnSE/vNblnzbxY
         F04p7jKtiMNkr90evXP2MUwOKLxIRMnnW/bPvjROIAJQ8NJw630gG4Lj3y5HYhFt9dGz
         Dedg==
X-Gm-Message-State: AOJu0Yy30xNv4731z5pRNP4mSYCLHnT0GwLHvVq1TeK4Ov7TSznq8X97
	5RwYygFo9mI4a8Y08mTeIZaZYKbg+POzFGA/r7RB1FsgxTGWHcyn
X-Gm-Gg: ASbGncsPIdNdqaLfGCW8WqGW7E0+8eIfBN49lGTlRCkxkAU/z+3AMyY31naEC8/pj2o
	oFixgRiTcO5vZHu6KPik77gK+v7dXBY7HTub0nr81g5qgXMmgA4Q6tT2+fvP5ie0absZa8Nrg3r
	05BpN302rdKcjUVC2+ti0NZQZsu4hVAKgaAZYHCn6tUJlsCRdtWpMcgm/oGOpG05rpTa69vyDB4
	BtMVifBjBHAYCU4Sap8hgrNaBhT1MtWx+qsp2QVJU61DAELRzlZiMwMmdrZmF3cS+r14d+IWhg6
	i5KSnibpv3WWrM2ru4nMev79ML4e6UMZq8yw18CrPxxtyl7JEN/IJ30+u0fOerk=
X-Google-Smtp-Source: AGHT+IESMBcBeOj2ptVeubtv1U9WxTJ5iyTHkEf8LqhB9DJYfg5GCLAsP6spv5aFZx/9CCXnyHvYAA==
X-Received: by 2002:ad4:5f89:0:b0:6e4:3faf:3647 with SMTP id 6a1803df08f44-6e4455e96b9mr210226676d6.15.1739242587896;
        Mon, 10 Feb 2025 18:56:27 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e444eaa762sm47126386d6.90.2025.02.10.18.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 18:56:27 -0800 (PST)
Date: Mon, 10 Feb 2025 21:56:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <67aabc5aea2eb_881f329441@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250210082805.465241-5-edumazet@google.com>
References: <20250210082805.465241-1-edumazet@google.com>
 <20250210082805.465241-5-edumazet@google.com>
Subject: Re: [PATCH net-next 4/4] udp: use EXPORT_IPV6_MOD[_GPL]()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
> to be exported unless CONFIG_IPV6=m
> 
> udp_table is no longer used from any modules, and does not
> need to be exported anyway.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Should udp_disconnect be included?

And perhaps udp_encap_needed_key. The only real user is static inline
udp_unexpected_gso, itself only used in core udp code. But not sure if
it would cause build errors.

With those minor asides

Acked-by: Willem de Bruijn <willemb@google.com>

