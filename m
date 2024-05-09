Return-Path: <netdev+bounces-95094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0615F8C1687
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8371F21614
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E337D13C8EF;
	Thu,  9 May 2024 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNgFNOvU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB013C8FD
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284946; cv=none; b=Hd2d6bsM6zfDkp6M8cVTstO+6dOTjJdav9SR5uBGzqHEUTtQfvnGNQaTMZA+8JdKbJQUD026FaKQ1CdK4fSAurhDtTgqEX/kKZ0z3RQoNq98Vj5UHduCyGjKImUrOzzbt+DfkXYEa7HHxdFWx9cQvYDcdlcqAyzzSl2fFd0UxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284946; c=relaxed/simple;
	bh=XzM7bW4mUcL+MdWLSgy4pPFCyz7AUX0/rTFVbZz4Cks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q8xJ8k2Wsrm3tOxCiqKyNGyNpfNO0CufpzGLs2YkyCMFAZfqilTuWVbl1Tupe25kRWvDIC9cHoy0lAiAMulwlbU8Y08A/4NtgNvmyeRMO/HDa0BTE+ynWNKXZ/Ki2wYtOWh+oufveoILHaqChCI++6XpYC5ctfMLcqpfSI/5mHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNgFNOvU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee2f06e652so12189125ad.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284944; x=1715889744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibFWC41ZV4jKFs0EDjRGi9eb9rYUWbe9LL5jTVHUEjs=;
        b=TNgFNOvUDwSzSzaJ4tw+i7vOl78bZqwx798H7mD/omiE83Av15InytXJwanizgjzCC
         wSNIkuKBojsiBJJ7Y9S68oOPfkmfC3QTjdo91uUzXY8RFQdVfTpfAv0qxTBqCTtNQuko
         AwYJi5ORP7CeEXT6S53WXagQQElrKDNGlSg4L2Wh5oYtKIAbenVD1k8u6ga/9MYJpgcu
         zrGPLPVj+GNImrdIbQUCa5OFe0IXRUZaf/aX7dHnONufx2CXNfV0EJUWKQRslIVuOMPO
         zes7Aj6ZDCaP+3r6bVriUXvwfq0qQXqSPfO6WmhBwFUXgaqb5k/UXZJgptuflN9+y2me
         eklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284944; x=1715889744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibFWC41ZV4jKFs0EDjRGi9eb9rYUWbe9LL5jTVHUEjs=;
        b=VnDC4TU5KULjQecE8zq2141T6z9KKm2Ma7pj74PneexY/P1XT5ES/n6hE1+yyjF6DK
         khGqhiUfywf4uSJHikbnZYNREBskM6x0aDNC/ohAvuLFiIpH9MKXtjpejYMQFP9hLZmu
         0HhTJPNP/6ZGqb2+Q3TStIcFoICaJtBYH80MIx1i0D16jYqYhfg7/7onTJqgWYJ2CYYG
         kkLATE1Y4dFrROn5Cf4m1mDhnt5w7LDz+gBDx2cPZMzkDhlQqAFYuYFcKu6n3BWDmWTW
         8XSYYTdGD/AOU7CnDjeaSbs9lVecgsq3lCEAVnmMufyn0h/9PnHP7MOd5jN7HBXIh8MO
         wUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr/zRAVb+GbN8s+nVjH/hUk6QwtGnKif/7dNn6XEoIKN9ms3WnroZ3JkR7PlAloBVK6waF/OiZ3X4td1NHS2Xs9Admxo1e
X-Gm-Message-State: AOJu0Yw2uEy+V3S2yx1GGhIB8Xjf9DqfINhQbmCcC2ChvRbtov1YIRDK
	azK//aWuMtOw3d+DENlpx+vggqtMqhwhGIjR5XtoeaFGfNatcGn1O6L4fxEuJRikrAaLHmu1LXS
	FSw==
X-Google-Smtp-Source: AGHT+IEPkGuNPe4HIZuj85oVFOfPMLkPB6Cm4SK3VLdEwwtMiQwP0MRi57NnzjjqYrYIB2JiEx+9LJND0hk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e549:b0:1e5:e676:4b0d with SMTP id
 d9443c01a7336-1ef43f4b57cmr17425ad.9.1715284944391; Thu, 09 May 2024 13:02:24
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:26 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-35-edliaw@google.com>
Subject: [PATCH v3 34/68] selftests/mount_setattr: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Seth Forshee <sforshee@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index c6a8c732b802..d894417134b6 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


