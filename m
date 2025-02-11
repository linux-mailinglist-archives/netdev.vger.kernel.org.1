Return-Path: <netdev+bounces-165052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCFAA3039D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C8A1887678
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04271E5B8D;
	Tue, 11 Feb 2025 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuntCRbk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F45E433BE;
	Tue, 11 Feb 2025 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255658; cv=none; b=BdoQkZTLPYE6XqBs5a9mZFBhdtvfjuLHHDi6lsuhmMyixUkSyfBAXFWISB+vBvih+gnWH2tkUzSu18Kzemc65r7Fu9jHtZlI0lcyfR7G3ZAiCbd2HINwWLDNc0xIsGnHekCYb6k4Ak7UABBP9/8RZpgySVXKiiof557udQthSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255658; c=relaxed/simple;
	bh=QqIJgxc7kP4DGdcRTRXjOY2ixoPBdtuBUtKxDAx3kRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfDa0AGfXh+DPHttais2+PkgUlR2BgYYsKZKsA38D4fdzc8VeRydYDjMbtB82UKP8wi5RWWr5bLq89e8+6t5jxJxg6VNrtygX8JUUAJl0jj4aEO65yKENNCFYVC/LMZwnBIpRnhzVTmHLc1eubBEtAHxfK6yNvVhBEie8BY0n3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuntCRbk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso6130167a12.3;
        Mon, 10 Feb 2025 22:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739255655; x=1739860455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+ec3c5EsUPRIuG3vrRHYCCwoZpP0ewaD+gHvqCUVv0=;
        b=DuntCRbkCHUNbOHBPSp7cDGyWewbURhx/5el+x2jGKe9o32OOvhDC4e2H37f8hP7oC
         GOh8se8Qk4WtZIHGgihWA2Dr0L2SdDsWInuChuA4Oe7EfjhmUAmaTUgQervjUKdoU+Dy
         DPvVzOuDsRnJt8pCnr/j0XyTri3ROmISNIdrCHR3BxYmvkhjKXEABRfw0CDTknLxTRsf
         1LpAZAZUZNdbjb9JsKraWRpNzeqJxclHHCjv6VHcgVLWcFXlRCvYEXvKdqM4CqqTCzt6
         l01/2Plii2ejh6pshGU0pjsLFvlxKA+UxESTgxIjpyV0wmpEaadd9BXQBe0qruNxYLnf
         oP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739255655; x=1739860455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+ec3c5EsUPRIuG3vrRHYCCwoZpP0ewaD+gHvqCUVv0=;
        b=lGhz5S5OrLBtHoV+Z0qQCWWK1DJZPSsYTpyzWmAUjKVGgu73TAx8mtZ0BxoOKEzVKN
         JUNymYPC+OF81yaajAU8jELKgCu8JEuOGhZMMnnChCWtZ+Eg7YOI6FlbpHqkEOgOT/wZ
         efMvJ+sbp0Tz3w0vK0ucJ1DuP9YkeAYPfWGm7rqEy6JEpeyQIoR0j5+VIoh1x5W8LzZu
         TRFB0NJT3pi/FIhV/8ppIhB5lipTsjfk81UhsxzQ4jAbQoX3dr4dIFCKDwSUyFHrMOY5
         LTyxaCQteMmN3JrfzZL7Dg+qqkgaUU+mlM0YbKedLK88iTjfqTXOuLmUl1h/OXsn1SlS
         oeMw==
X-Forwarded-Encrypted: i=1; AJvYcCVyZ/nHkUfEZufZBhsGoNFF4SjJqYT5nrUkywuphIqhAzlsxjdLuEX0GUvmVmSds5MZVDirfUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQT/xXwKilaLvnFx7BLnJ1hU7Ywx4MlXEFczIWApZW6t9uV28u
	cIxjhBXECDhUdS01KvFwv32A0IArD7Fl7UJq2IUhhA0muqvRg7OMmXJt6W6JAEh1zw==
X-Gm-Gg: ASbGnctrL1WuLZY8TieHncsI2E720in0j4MIGU0VOEe8tn9EYNPxoP6HrSTlvTOQf4Q
	vybXNXEtpCF6/eGb9mZ6Lts55EB4SFPE8EZDZyO6QxINFxAsJKxiksbqdRuAXqKKPV2PwGzCe3x
	yOWSO7czsuzNocXY1iuhawsmGwKFc7NPbgtwaPMV9xkcq/NcQuO4gPRwKVJTr9qqCpUbGhCXjDW
	W9pyn/+Mj3zL4OBDKNPpVXq7dU+YYlIoM0H1aiIKU41iiK1MZZ/XhFwpQepCkvHohYobnzfGY0g
	CeZIXwBqDRygzsNZ+EPuV16+w7ky4qUiiYKTPdG7nhM+6DaPkLWup0ahVNeXTjKjvF4caGIMSX2
	Tf9TgwF4CuFsiQTM=
X-Google-Smtp-Source: AGHT+IEcBbGWng53L53nwV8mRpg1jvru+K1+qfu2crjxWjtWQRgH6JO3CBOfaA8uy08JpU93QL+/Uw==
X-Received: by 2002:a17:907:3f27:b0:ab6:f06b:4a26 with SMTP id a640c23a62f3a-ab789aef91amr1673775366b.34.1739255655211;
        Mon, 10 Feb 2025 22:34:15 -0800 (PST)
Received: from legolas.fritz.box (p200300d0af0cd200603313d7beea72d6.dip0.t-ipconnect.de. [2003:d0:af0c:d200:6033:13d7:beea:72d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7c62c464dsm300440466b.28.2025.02.10.22.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 22:34:14 -0800 (PST)
From: Markus Theil <theil.markus@gmail.com>
To: linux-kernel@vger.kernel.org,
	andi.shyti@linux.intel.com
Cc: intel-gfx@lists.freedesktop.org,
	netdev@vger.kernel.org,
	Jason@zx2c4.com,
	tytso@mit.edu,
	Markus Theil <theil.markus@gmail.com>
Subject: [PATCH v2 0/3] prandom: remove next_pseudo_random32
Date: Tue, 11 Feb 2025 07:33:29 +0100
Message-ID: <20250211063332.16542-1-theil.markus@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
References: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

next_pseudo_random32 implements a LCG with known bad statistical
properties and is only used in two pieces of testing code. Remove and
convert the remaining two users to the single PRNG interface in
prandom.h

This removes another option of using an insecure PRNG.

Markus Theil (3):
  drm/i915/selftests: use prandom in selftest
  media: vivid: use prandom
  prandom: remove next_pseudo_random32

 drivers/gpu/drm/i915/selftests/i915_gem.c        | 7 ++++---
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 4 +++-
 include/linux/prandom.h                          | 6 ------
 3 files changed, 7 insertions(+), 10 deletions(-)

-- 
2.47.2


