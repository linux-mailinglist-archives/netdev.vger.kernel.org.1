Return-Path: <netdev+bounces-120927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7098095B385
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35811C20BEC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCF717E46E;
	Thu, 22 Aug 2024 11:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570E15CD78;
	Thu, 22 Aug 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325064; cv=none; b=S1fS/OB752XNusCfPi59q5l2L4x/p0aAIITlpaFZn1i2r7fkqrM2U8RaCGflSJQIQjftTztCwkkjE5aqKKMKIeU+ReO/xcj1YFL3CukwFzUBuRxRoh4csw8pqr7moPWXK5Py7v5SgXmEER6exhBUPWPaPMTrJaZvk9ApYf08gsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325064; c=relaxed/simple;
	bh=AKtWnTDVY9qmaJzvSXEd4YFramVIRzTBxQ3m7REBQEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fjS255REx2z0PRmHeJC8piR3qc4Ldm3/HXW+ky/bbU2jadxXtcdQ+u03BCXToFK/TxWcNn5w+0Bwi3qQe7y9Mu3IRJxN1yeYAGwXkeI2Si6fvdHduMQOMYlTthRg7xKmQeSU/nFB1G7avuZx1nYFsTyYqcBlpw6/kF7rBXjj3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5334c4d6829so847998e87.2;
        Thu, 22 Aug 2024 04:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724325061; x=1724929861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZx9YVY8ZIeuuZzJSDlsVuVT1aDZ60Yc2IAovrKHMGA=;
        b=QXeHiPmW/DcdbDb7zCtkxrLNB712pzoJJYqzJNR0nwVYwIKoedYLkYqppEts081P7t
         w+XHARu+hIr5lMhu8gG4OdnhLg7Rplc43V0xahVI9nrEZDepCGghGH7050sFcJ4YkjYe
         wRvi/r4eyR8wrFfPQIcahhQl+8vUmCs4MfPz0hZeaKa3pwp3WomG2BJ4XPw66IfvEElE
         7P/geu/28SasNZkvOeUX52KPgXEexXLZTvDo5ZUXogSHFqld1ZXRdKPfitPCBd1PDbNd
         wI7gNgSGsSMQ4pmgehGYGgSXxBS8v9J8sCd9raXbuVXpEpT4btYyO8mrnQCd8xo/Zmz8
         5b4g==
X-Forwarded-Encrypted: i=1; AJvYcCXuzhZZSnzT+xWXwF8PAPYOfnyNSVzL30MUS+ewxMaHlOX1Wi3RRZ7AH4PWm1Y3ljG5ysojVwNXdS611Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6Xxs6N5mid4xRVea3SCQokQC6pw/OniRWsyj2hreIlBCOUO1
	+09ideRP2315MEdaQ70v+GBJZhiXQxl44b5hasa0cIzHMZRciXED
X-Google-Smtp-Source: AGHT+IHTHuQ0MGCqudLIhxRo4X20vpMQcyVoNL7rf48zA/KqVPKXVYRyloPKzvl3XzjzacOt5kpt3g==
X-Received: by 2002:a05:6512:3c9e:b0:52c:d905:9645 with SMTP id 2adb3069b0e04-53348550fa1mr3214401e87.13.1724325059995;
        Thu, 22 Aug 2024 04:10:59 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220142sm106263066b.18.2024.08.22.04.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:10:59 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/2] netconsole: Populate dynamic entry even if netpoll fails
Date: Thu, 22 Aug 2024 04:10:46 -0700
Message-ID: <20240822111051.179850-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of netconsole removes the entry and fails
entirely if netpoll fails to initialize. This approach is suboptimal, as
it prevents reconfiguration or re-enabling of the target through
configfs.

While this issue might seem minor if it were rare, it actually occurs
frequently when the network module is configured as a loadable module.

In such cases, the network is unavailable when netconsole initializes,
causing netpoll to fail. This failure forces users to reconfigure the
target from scratch, discarding any settings provided via the command
line.

The proposed change would keep the target available in configfs, albeit
in a disabled state. This modification allows users to adjust settings
or simply re-enable the target once the network module has loaded,
providing a more flexible and user-friendly solution.

Changelog:

v3:
  * Remove patch 2, that was only pr_err() at netconsole (Jakub)
  * Rework the "if" loop to be more readable (Jakub)
  * Print the cmdline number in the error log (Jakub)

v2:
  * Avoid late cleanup, and always returning an np in a clear slate when
    failing (Paolo)
  * Added another commit to log (pr_err) when netconsole doesn't fail,
    avoiding silent failures.
  * https://lore.kernel.org/all/20240819103616.2260006-1-leitao@debian.org/

v1:
  * https://lore.kernel.org/all/20240809161935.3129104-1-leitao@debian.org/

Breno Leitao (2):
  netpoll: Ensure clean state on setup failures
  net: netconsole: Populate dynamic entry even if netpoll fails

 drivers/net/netconsole.c | 15 +++++++++++----
 net/core/netpoll.c       | 15 ++++++++++-----
 2 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.43.5


