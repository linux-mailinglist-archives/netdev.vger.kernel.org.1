Return-Path: <netdev+bounces-206482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF699B03443
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 03:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F88189980A
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 01:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67CF1ADC69;
	Mon, 14 Jul 2025 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBlBQdA8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F21B433B3;
	Mon, 14 Jul 2025 01:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752458255; cv=none; b=MPGHby8Nz1NK3JpE/3Hm9BXwKcCWrXYPlYvyQLVlaoCgShg447Jbbfwu2yE+6jwH9mHFIhqDSJS2sy1G/FZRNYrDx87uBCcdx6LPJySN9fuoam5FwZ6aSrP/Y4wtCfyz3VIwj7au4HtXHfAOfpsM2nhf+kSDpwasAaS9aUjtZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752458255; c=relaxed/simple;
	bh=nshxwRS/+UyxHkQOYE9Fk36v0JMlpdCU+qxIFnNJs3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qiCyb1KSOhQitWSHJbt7EjdV0GbH08kxK3HI7q6IRBervopGY+Jj3wRu6EUJj70Bknx8HKv/XmweD0bO2rUwN/NLCflqB1AN3eA31w7oGDw26TR0tQzh5MhNHW1H9IVT/KkqKFJX9UWf0xa+BQxeMZHoVdxacXozx+qUh0v9DqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBlBQdA8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so674848866b.1;
        Sun, 13 Jul 2025 18:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752458252; x=1753063052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G8LBFqVjLhKB/rrOkLWdjE91pXMr5HHe2wnD4KcukNE=;
        b=eBlBQdA8THQI+K7fjDWB1JUhqSP2HjA5WrQ/Vyb8ok/UoDsLLnLbUVFDtpBlBIh5s9
         IXkpjzqcZKN+k3FTDKOOOYCE/YaD9n0jC+azzHSnDXnjSAt63bnB+g5i9Zl80lnInIN8
         S1eYTDCkJOvYZkPBzu2qoZTAhonqoCT04sUGupVTTttqwGh3xCE9hUNXt1nQl9SPz2wO
         NEurytqfCrLxADf0bUZrYYbcm2QWn23Xo7gVHwJhAvMT51INmYuLk9EgNOBHiIh6K4hp
         IAXb8zbgSJ9d8/uC6ahkjwlCD3qNO6r13AS6lpsKXuhSq5G+CTjNFqmdQZ86OKcKL6gL
         ehAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752458252; x=1753063052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8LBFqVjLhKB/rrOkLWdjE91pXMr5HHe2wnD4KcukNE=;
        b=mMr1GRaTlkG5OaK37MREJOUofsgFXLY8IXCA3jaH9b9by+vTZ38rr+i/xwroPvoZ9w
         CZ8OQICWks4UKeHre6jGcTPVyTm5zD9BiRKjlhfGecWbgV0a+8UOlhWB3Flz8CTqqbGj
         f/JZpQaAVBTZuJc3V0nGaa77fMa3bUKSuzfxwx9Onu4U/GiN+dVOdynSzETKVCmfw9yj
         /9Xr8YqX25MT4OHXdyEm9eVlTbz4HL6em4O3h2FnqdswjT0vpzMGkSEnrtV0GiXPNRiN
         1/+FxE8xS01VbvJydcI8oX0hT9xv2iGLFC4bghEZ5XS6lf2w4fFhGdFz/tE29A7L0glt
         NsOw==
X-Forwarded-Encrypted: i=1; AJvYcCWGfFtWSE0cmmi2zsKkkFmTUbKDUXYD53WG2r1p4+gAMNjC0gBnPY60VBgU2AWNi4x3n8bxkY3o/MM=@vger.kernel.org, AJvYcCXetskaZOu0cq9o4PDoUAoQc6+4E8ZQH/Y3uLqUaHia0r3sh0M4l6yRwRG6VpSnoNUUukPgdZ8i@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVJCpWAagnod4pkgTkEmSWvlE1Dk12htTFov0A4HvzYXws+hY
	Odg1T6aOj1P0Au+knmi6jj7XczwpDyCGfyqdenGnbSUrzcekrMA/klQ3
X-Gm-Gg: ASbGncse+XtDt1K6bZ937w6Tf4o6ztFKE3alZ4bVnX79cEEH2x/mYEFCQtzAHwK+EPY
	lwpioyKpP6uo86lFxeuoMX/oKU39XzfXF+/kQougZtKt90gQBFSIklxhNe+RCChbAUwSs90mzzi
	KNJKa+HuOgojWGB73ULK3JxS5APtM9J1adsepsIN3a+W8icgPtnwtZq041wFuB4WjxqNNVEyJME
	EVmzFKuucBE37AHjuI0M3fTT/dnZhNd0YhvmPjVOc5OkrK1ZDYYtlazdU9aRKcLjk6NIW22N7Mf
	VrCYWOt93W6GXnrlu8hjmgS4h30o62OPxQIJTEUg/gZWKx23UrIbc+/x7HsCSmNzzI0TE/Gg2Bn
	uKnYutRtZgN+C7OnPkwMuR8NF7RoTn02B
X-Google-Smtp-Source: AGHT+IGmgIuCRL7RTUjPKjOceujeeWJzHq3mfEJ8vB+TPCTqr1FpZH6XatXdtf3E0P66B3n4E72FoQ==
X-Received: by 2002:a17:907:f1cb:b0:ae3:a71d:1984 with SMTP id a640c23a62f3a-ae6fc200bc2mr1213901466b.57.1752458252215;
        Sun, 13 Jul 2025 18:57:32 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eeae5fsm741704266b.64.2025.07.13.18.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 18:57:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 26369420A817; Mon, 14 Jul 2025 08:57:25 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>
Subject: [PATCH v2 0/3] ioctl numbers list cleanup for papr-physical-attestation.h
Date: Mon, 14 Jul 2025 08:57:07 +0700
Message-ID: <20250714015711.14525-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=bagasdotme@gmail.com; h=from:subject; bh=nshxwRS/+UyxHkQOYE9Fk36v0JMlpdCU+qxIFnNJs3k=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBklSenbP7s6TY77w/Zxcfnc8LP7VJes4kp6vF0q88g27 d0bNG8HdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiNvcZ/imW9x55t+FFW8yN UDfZ/t8xE2e9vrBgT9TpyTkNPX/Nvu9h+O9ssn1pdt7N/elHOB+aaz52Xjdxn1pm2e8DZ9Sktjn k3+QFAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

This is the cleanup series following up from 03c9d1a5a30d93 ("Documentation:
Fix description format for powerpc RTAS ioctls"). It is based on docs-next
tree. The end result should be the same as my previous fixup patch [1].

Enjoy!

Changes since v1 (RESEND) [2]:

  * Add Fixes: and Reviewed-by: trailers (Haren)
  * Expand tabs for uapi/misc/amd-apml.h to match other entries

Jon: Would you like to apply this series on docs-next or should powerpc
folks handle it?

[1]: https://lore.kernel.org/linuxppc-dev/20250429130524.33587-2-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/lkml/20250708004334.15861-1-bagasdotme@gmail.com/

Bagas Sanjaya (3):
  Documentation: ioctl-number: Fix linuxppc-dev mailto link
  Documentation: ioctl-number: Extend "Include File" column width
  Documentation: ioctl-number: Correct full path to
    papr-physical-attestation.h

 .../userspace-api/ioctl/ioctl-number.rst      | 516 +++++++++---------
 1 file changed, 258 insertions(+), 258 deletions(-)


base-commit: f55b3ca3cf1d1652c4b3481b671940461331d69f
-- 
An old man doll... just what I always wanted! - Clara


