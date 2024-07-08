Return-Path: <netdev+bounces-110039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511B092ABBA
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 00:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817E91C20D63
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC3D14F122;
	Mon,  8 Jul 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilgjsNW6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F311146D40
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476238; cv=none; b=ZQDEifTf1bvsQvEE4ttYVyxJh4tQB54DBaMAZ8hwBM1rme68WElh/TW6lpSg6Wo0wvy8qOpyLHZg/FwqsfkBOATd4zLb19QqW1DAoDd+gjecReOvtKkP73XHfjg14j4DvBP4vzBxtqeAPUxJOU/3WAH7YtDBNVZwrkUc0WgCmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476238; c=relaxed/simple;
	bh=S1BipUZzvectQzzhDSDsB16IKTC1oZPF95hjxcSyRP8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aZqwof4pFBeC+TDosDXouWiw5B2IXfHbcvNtXVkBygfP4rP9Pv3PHMnrgKV95JlK1nSXOzF8E3beh+YiSsa9tgNQVX+B6SIBj2z63fx3jRwVLyrpHfSsRt+GN/Ask6jh5YSj6XYLHaFIACJpEJcDKHOF2DhfAwqyHH20EtYslCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilgjsNW6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f02fe11ccso136812685a.0
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720476236; x=1721081036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Dm/KlVU9isLR77tei9W6FyCZ27TWY3JKbyTRpHh3iA=;
        b=ilgjsNW6TWLqZNjOrGB5sNHR1TAmxxaVXT8kqRguN12QrMkotdom+2ymbYaKsSVQMo
         fnQQf160g3JczIRt3MmyO1TKLfAAMFW3yMqnA4/EFD/z7zoohVz0amPPpuf4tOIBLO5Q
         T1sEuhBDMOHBjVrKgTecwsrdxtUlu+DOvjUYLOzqs0w4zWjRx7kvjY7l721lvyHFo/yT
         lcsKJJAHy/0Exrpsxjg6U3HHQYjD8EU42DnMhG8fvEaOZQt8n9cFrZF7rM6gGB8cJsTA
         Qn+C0A0GAdtdMSQfEbatQQ5rlC5Au9cAaXZ+U/5YqHfT8k9xx7O+z5Cg+j3/Mjgs8Gcn
         JSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720476236; x=1721081036;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Dm/KlVU9isLR77tei9W6FyCZ27TWY3JKbyTRpHh3iA=;
        b=PqgfDIh7mw77u2l0083GesVQ/ntxVWq8CGnTm0mdOWF1LBdOSKZwZ5cc9hJ1PQQ11Z
         CU6T+CpCK3RUd/ueKElmpKExoGj57UGEauKLL0irBF4GPgjTlz9fmmAl2Y6laa5mL8rc
         4HM3Ky85dvnOIOI6pif6sFk3mfI+QFV1H1TzZ4B5U/T470ntuEd5qq7xXapg1QFfaGeh
         0dwUgHymKQ8v7zcJ+iZ6KSwRDNQY+aVY5jEpBSEc0tT/H3Yir5De5hGDLEeRqT9rrYYb
         s463gJctXMOhAdoVvL8KDJDQD7r366HRoCU1iGFZcZpXU2d1PZgvNszYfOghaT59rY9H
         2IGQ==
X-Gm-Message-State: AOJu0Yy0IlpPud2xF0zU2IS28IgSvuW/QII3D7oPm/RiwylHKR4aKboD
	1vShSHg5YLDdeeQ9G6wX/oMe6KbX0/JyFXFhNjEOGFVGr3kltBhk
X-Google-Smtp-Source: AGHT+IHDqodKCPEfBiZ1tSgGez2csGdgnsAK76btYZhdrtQz13ZRcPKym1azm9O4N5GG6CWUBrf/QQ==
X-Received: by 2002:a05:620a:3cd:b0:79f:12fa:4c5a with SMTP id af79cd13be357-79f19bf95a1mr78130485a.73.1720476235728;
        Mon, 08 Jul 2024 15:03:55 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b6bf2sm31782385a.135.2024.07.08.15.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 15:03:55 -0700 (PDT)
Date: Mon, 08 Jul 2024 18:03:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 petrm@nvidia.com, 
 przemyslaw.kitszel@intel.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <668c624b16652_1a050729475@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240708213627.226025-1-kuba@kernel.org>
References: <20240708213627.226025-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 0/5] selftests: drv-net: rss_ctx: more tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Add a few more tests for RSS.
> 
> v2:
>  - update the commit messages
>  - add a comment in patch 2
> v1: https://lore.kernel.org/all/20240705015725.680275-1-kuba@kernel.org/
> 
> Jakub Kicinski (5):
>   selftests: drv-net: rss_ctx: fix cleanup in the basic test
>   selftests: drv-net: rss_ctx: factor out send traffic and check
>   selftests: drv-net: rss_ctx: test queue changes vs user RSS config
>   selftests: drv-net: rss_ctx: check behavior of indirection table
>     resizing
>   selftests: drv-net: rss_ctx: test flow rehashing without impacting
>     traffic
> 

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

Minor typo in 3/5: "most driver[s] today"


