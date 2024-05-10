Return-Path: <netdev+bounces-95232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABF78C1B5F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2974B216F5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477013D880;
	Fri, 10 May 2024 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2O/3TEDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB2813D618
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299902; cv=none; b=YzwNdEVhvFjep3CX7L4Tb/0pQNoOrE4SoZE0ZVlhiZ0q+jz8WtmwzpEwjwt/JdUGN2wJ9BVnwoddB4VJbYvbhuUhfVo7ejDfGWp7JokpLpFCgJpER56ISujTjcH4ID8wvJXLpxfj1DZoTngOWrWZF5kDs/n3TmSuHoVwjKqH/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299902; c=relaxed/simple;
	bh=o1RhdjMiUDI1d5/m2/oPrCmWUS9LNz8Vqul/ZnNfbV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvOv7FP8HkNSMVXl3jRYeXs7HF/wFuWd/decYwPRM2Vu/7i0R8VREIqfLAqG331ftk+01zxWHtmsgBQRbeix7IJHhbDNqxYLMeiowwlemEQVO9tevFCt0Mnea5K6wXNqo682YFdwFJWc7OItgwU0Gs89LaiWsJ51PRXKVD2dUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2O/3TEDZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b33cce8cfaso1345990a91.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299901; x=1715904701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEXQmokrWI+eGSugaFt5D0Texu6UPbeRbKfQ1EoEEI0=;
        b=2O/3TEDZ9DYWlZbwvbsdj+3zg0fxR4wwSLvSsmbiKBsdTnH+B0KQb78wlyDa7xfeQz
         92B3WyvYou+wprDpPy2tvn3OMG9+9LUQH1K0RAvGS0suXuHtJTE2O4ExJD5YUfQ9u/Wk
         YnQFq9y97pplpzlAJmop8vH7lYhYQz/Z+rOkhNL7hkzrCxQKmcxxLoeuCJALfc/U4afR
         fNZ6AYX3MZc3zCBxQtyb2fwMq1a5VKsNDhPcLHB1GvigQ2rGKMlzmHUi2F947Mcdl6w/
         kx+OqJbiZPXChDZmKuuVe75henekjvWnHK30LXY1BUra6+OywRhz6VgG3sz0wx2hdd/k
         j3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299901; x=1715904701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEXQmokrWI+eGSugaFt5D0Texu6UPbeRbKfQ1EoEEI0=;
        b=e/84bPtoDQHwWcPtDIFPZ47AL+lHscWHOjZ0J0kJPo/pW/TLyeEv33hFL7oxXOCnhB
         ML3ExQwOg3MWp2nT4iCsUlI9N06vgDPfghkQmoVDn7Ald8QVsnd0o9CZjh5MQlzFTxkZ
         L1dOt7/tXfOnAMadcAXX9Ai8mJluQ19xaHTFonrgMIstM1goDoFnm42a+OED/V4Ix3yX
         63grlo8gTrjhbd+YGBsWLFKTvxtxw+7bMaSRGfgsx7vbpXogzUzz2zaYv4kV0L40z9vB
         fBEXXlQ+8CZf40QJe02Bdx3APNdc+kJ+lHhnfBIzgJ/m2U/WEMfrzeorPZ+3le2Iw+87
         hM4g==
X-Forwarded-Encrypted: i=1; AJvYcCUmU8+73NY/+cQgMQAhE5hgzmVyyTGZKjN0iVmwXV/FFkxa2n3DCetl34I+IDWheNdviGCtkKX78K0Gpx2HZKCOiQv0Vd1V
X-Gm-Message-State: AOJu0Yx6GQ9myJoeGDaSdslQUb9MytkvhWbvlhQJ2O/fwHR4I0g/ckBA
	O5fQF/4JF87vzuwCYf3JCaKJf5q0NGs4rT3/r7Nq/vYtDUcPSpOZKICk7DyWmVe2GwpCD+K24Xm
	W4A==
X-Google-Smtp-Source: AGHT+IGihj7M2pUQip2rg4KZarz+rgG5Vi5HqpEnSpOrKP8ghunMKLfzsoaIXqf3xJNXm0bE3pdliozrz4I=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:3597:b0:29b:f937:cc00 with SMTP id
 98e67ed59e1d1-2b6ccc73d48mr2761a91.7.1715299900699; Thu, 09 May 2024 17:11:40
 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:11 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-55-edliaw@google.com>
Subject: [PATCH v4 54/66] selftests/sched: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 62fba7356af2..abf907f243b6 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -18,8 +18,6 @@
  * You should have received a copy of the GNU Lesser General Public License
  * along with this library; if not, see <http://www.gnu.org/licenses>.
  */
-
-#define _GNU_SOURCE
 #include <sys/eventfd.h>
 #include <sys/wait.h>
 #include <sys/types.h>
-- 
2.45.0.118.g7fe29c98d7-goog


