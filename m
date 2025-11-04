Return-Path: <netdev+bounces-235566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D6C32721
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81D51885ADC
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34980337BA4;
	Tue,  4 Nov 2025 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1ua3S4l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91F335566
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278714; cv=none; b=PzCGW4P1IKerOpde5hF6ZoINP+LwRoMFqaw7pTrnkymBhUaB+tlqYcWWzca3UgBUk2AwdyTEsDnIyZTmIfeBnu2YaX80m1OraLrPzjInbZDclEBhLHdgfdrFpFuKdPkKkIA9poqeHi9HdKdXwB/oJm44JYEydcdcPEvqNqQOxG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278714; c=relaxed/simple;
	bh=SignVXJt7EjJO0CGxgB0F2elFSeRJzencESXLVk36es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUCrUbgXuqrGCXmpNoLdRp8MtKsRVZcOFZVo0Obktui3yGmQGStnd7aeqJ3pD8d1MId+EJoGkkIzeRgzmwhgJytDBiiI9ivKjIJQA3DXQTDfogW7AWmEmPOhE5wQgGPp/ufgdSTBCinJ6oxRswzp4ViMY4+Kt5uVob6mDU0ZbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1ua3S4l; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so25366076d6.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278711; x=1762883511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SignVXJt7EjJO0CGxgB0F2elFSeRJzencESXLVk36es=;
        b=S1ua3S4lWh2XRLl0O/KcT/FooxdnSNNlgbyn5sfsGmPSAn7p10fns89+rW3ZfXsDO5
         Z0rHR18vqc9Fwusw4+qvA6PpmE4BdEZX50z+8V+F6gFPiBCUnwP7K5Cdsv4Iwb4/J/Am
         zkxuTEeEoz0K3gS6BuXyOcUbpfZ355w1jvPCrIh8SPhWjTfZ72UAkHlD+qFzCDzurs41
         tNlaE8NP12gSnUA7YtbZ8F/PwCqN4MS6LiudBdI27pKkd/3Xj11Okpk+CWVOzIP6YgPl
         88BefRV+i6PEdISGKQGMDqsEfa81DLiLsmhc1AfnjtPNKVGSEGbg1Hrd/5i8Y0wVE2hK
         KQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278711; x=1762883511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SignVXJt7EjJO0CGxgB0F2elFSeRJzencESXLVk36es=;
        b=SJavU/+QTIjHBB/3/DCAiXdZU0KZXLYRfcj75aVaxGJufQYu5mu1qsMQEazpP7B5Hh
         ZecquiRjgkB6rEPt2jPUNXhHziTiFv5uRs9OyjkZxqD+FzHJP8ykTqnLFhi2Rvl9cSYF
         mWWQp8li5oBxDTc6JrOkmIKRBqhCkpiTc+eRqU+i32Xv5n+CuICzmuQDBElgH6BkGsik
         v34cGQ8iUN1/4gJ6NOydObcyBY783ihR30eNMkayVjXkbFjltBs4JHR2K+ywygAwnB6f
         nzK1/Dc1tBanNgpKnf9ri0UuJ5l7J9IlCFPCGBAL6frwlS/NESywlwplLsycJeBKWYjX
         gssg==
X-Gm-Message-State: AOJu0YwY40PotzdAKe4GTdQ2ZUVycPRDLX+t8QV99n+ALQ9TRhE0UgN3
	fi4FIbWnX9/gT1Z38ohn/fLS1lx5RSTtsHkz0uKEVquS5IduhX3i9yXhwxKljyReqC2OgsykS6e
	DCpIdZns8x2PTYpTpcwK2PBTjEKnVuhTs+GKVnE/X
X-Gm-Gg: ASbGncu0uA4Ju420ydNTZ2C5sJ1mWh32rsX7bQkm8vZh5WRN/x6KPp2rp6N3HiliVRX
	j4XsAU1i9F/MLPB4xWV4+OktnpcIxqsmrnHnYyElZr9IF0+tznGK3EQQ0Rh235WhccKpZn8CYdh
	1qH8h7To59r0/0TWKvl79ylijHCD5wch6orWD7B5uiRyPN0+F2ge4zTtWDgIBXe69XlQavNRRiI
	drNjpBQ0W1biZHV1WdQYpojL1OCPgyyMBDRF7YEzwiW/bnqrbrvy6ma7RY2KINeqO6stn/T9VXn
	QC8etH6KecOBLOga
X-Google-Smtp-Source: AGHT+IGJ6DXrKz2yvLnEgP9UUMbLfdcv7gr66ikLdbN29Ive6p1/HWCS/tm0wxxDWfNNDt13q1sLooWR2r+YpuNeOr4=
X-Received: by 2002:a05:6214:d4d:b0:880:48c6:ad02 with SMTP id
 6a1803df08f44-880711cbe29mr4775436d6.52.1762278711116; Tue, 04 Nov 2025
 09:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104144824.19648-1-equinox@diac24.net> <20251104144824.19648-5-equinox@diac24.net>
In-Reply-To: <20251104144824.19648-5-equinox@diac24.net>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Tue, 4 Nov 2025 12:51:39 -0500
X-Gm-Features: AWmQ_blcFWW-A8DairYvvWDiQ5hbWzgNr6wtOzfuu9L8xkfi6m7QTKOeN17III8
Message-ID: <CAKD1Yr0UbY5+f5nnNn3-GsPi0wNRwVHOGZeFmujNJKY0VpJ3eQ@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next v2 4/4] net/ipv6: drop ip6_route_get_saddr
To: David Lamparter <equinox@diac24.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Patrick Rohr <prohr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:49=E2=80=AFAM David Lamparter <equinox@diac24.net>=
 wrote:
> It's no longer used anywhere.

Reviewed-By: Lorenzo Colitti <lorenzo@google.com>

