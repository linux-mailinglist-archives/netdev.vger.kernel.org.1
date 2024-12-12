Return-Path: <netdev+bounces-151448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE919EF350
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADE128A223
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E292253F8;
	Thu, 12 Dec 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj8wYVyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544B2253E7
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022279; cv=none; b=feRE65lmOCrclQs7Qq7WY0NnPjxUz0ehtr8bC0+erKrvfDXhvUMfilbnp2s3fcv5yUBDGGO65ZfJXenKgynMTzcoQGkI1S7IOcMBqtt5RodF6HUM7eG2Od0zHMtx8Rv67KDJGp0hTvcZrmbJyex16syIHeYnGzT3fF8EIJ+4sYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022279; c=relaxed/simple;
	bh=Rm5qshMBIdaGEkKo4pdO9BEKXlkkUBjpRl7Ck6bJd64=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KklkOxO7C+byrcVAPIyEwhUd7eSOYqJPXmX/7qBqv0bjI3c4F1y8ISfeG2UI9m5yQttl0mPzxOtIbKoqccpe2hPD3oXqAv6d5wrecmdHOMeXrM2SOmg0EThRnVYq8zsx9j4xGQj3cky+41q9VvpF72LH+Kn31I6lXUZ1xBJGh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj8wYVyi; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b678da9310so83220385a.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734022276; x=1734627076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQWmrx8tAOzsorx9OeyNCFs/99CEWF84FZQRDBke8YM=;
        b=Cj8wYVyiFKPrs19tq98HBs7G2WNTsds6FPW3dpvwGi2URlBnYZ8SSkbUDM/nJ8ZWzI
         dqZVQ4GCFrYvAHXfvdFvQBtNXwSud2uvIRMhF6RJz6YrdF41luBG/ANeO7Y3RPus2+Ak
         fxAXax66gJy7oNfgzUaCCps3kGPF7EnGIFeegPHLJvRec40iiwfZvhoyO8WUsAeKSKAj
         DNt7M/tM/3AghhAg3A+poxgS28nYPkNI9GiMieV9k7Y/s/J7vMmAjCFZwQ0Xae/X9eyC
         Z1nfyWzL5S9+e6bfNFinYhnoxb//hMhx+NtHXgn1/+ZrCB2NMeH60hgmRLFIwuZGp2rZ
         hhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734022276; x=1734627076;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UQWmrx8tAOzsorx9OeyNCFs/99CEWF84FZQRDBke8YM=;
        b=bSn9psQKJDVAYYzqXujL5YjZg0UAhnYVElifFjs5bBdm57NZRPrBp2Nl/Zx4Z0dO9N
         f/ogkjwDDxDHHQpAGQo227pHEmMpsLs/wFRPoiC6AMqXR3rh4LiR8T7EbKFH24PQcJfD
         pEj00GtSXvgYGHd6dcnajWSxfLW8dZjTyobgyJx5TtOiNlDKcz6i+w2yObQwT4ndJiCq
         7ejMTMl6yH92bx2Iol4fM7rFH8kvdRLJOefLqwqW59pxjlwc75dFW4DZxUpRZdnTXIWb
         q+w/S7RJ+KSsIMwy/swRA1emuDO7Jla4jFu0DQltAdUXFNojZkNkUX2ItjMjzv4cex3/
         RHvg==
X-Gm-Message-State: AOJu0YzKKkUOBgYw+TXxsgGktHU3EOeTfc5E4b5jzsSWZfc5p4ld9GnV
	FEzcMlv4AWzW3p34doN+E5VBhwZXV4T07Us18qWsM9JZIPNhBbib2F3QwA==
X-Gm-Gg: ASbGnctKM6y43cPSZtAMbMR9fYSRP/yZaRsvgjgE8qDRZI0INv/Z/quMhcHfQCimgpE
	2QJzQ9U0fQU3rg+3W6az1W46X3KtxipkP926zCVVHjAhjXxKrrPf2r0SQbDBdeLaFR5jrpfG3Yo
	Q9/x/ugDCOr9YAtZ4EtbjTMKAa8DyMl6K1gWSMhvG8dKEWUrmmthAjrkA+x/d16YSIQi3KffRqQ
	SucVYTGWd7xb5IU8CDTxD6cmHV8Qu9kpcaQsLD0TO0c+oDx/ZsndCX0GG/dZuAQnwWJtX4GQABa
	YmsdTt3Uypdng/ogZyjPZJp7szfo
X-Google-Smtp-Source: AGHT+IEqslSCSS5fXaPqkNiI7xHrk5xrAeHTCNP+oa8KnW3FGLrFRxSGin/xQqaAe11F/lVzd8+SxA==
X-Received: by 2002:a05:622a:1817:b0:467:614a:b6d with SMTP id d75a77b69052e-467a1680104mr15018821cf.45.1734022276640;
        Thu, 12 Dec 2024 08:51:16 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46782386ef2sm28049831cf.26.2024.12.12.08.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:51:16 -0800 (PST)
Date: Thu, 12 Dec 2024 11:51:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Nyiri <annaemesenyiri@gmail.com>, 
 Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, 
 fejes@inf.elte.hu, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com
Message-ID: <675b1483aa913_d785729467@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAKm6_RtLzq7MW6Ut0ok_2rOyGqOgVDWr9mbaE-4Ts4Hup_454w@mail.gmail.com>
References: <20241210191309.8681-1-annaemesenyiri@gmail.com>
 <20241210191309.8681-4-annaemesenyiri@gmail.com>
 <Z1ljFkEk3jZHRGl3@shredder>
 <CAKm6_RtLzq7MW6Ut0ok_2rOyGqOgVDWr9mbaE-4Ts4Hup_454w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] selftests: net: test SO_PRIORITY
 ancillary data with cmsg_sender
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Nyiri wrote:
> What is the current maximum allowed line length? Because the
> checkpatch script permits up to 100 characters for max_line_length.
> But I received warning on patchwork.kernel.org site:
> 
> WARNING: line length of 86 exceeds 80 columns
> #64: FILE: tools/testing/selftests/net/cmsg_sender.c:121:
> + while ((o = getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H:Q:")) != -1) {

You can ignore that in cases where exceeding it makes sense, as it
does here. Up to 100 chars IIRC.

Btw, also please no top posting in kernel mailing lists.

