Return-Path: <netdev+bounces-74408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B6E8612E5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D299D1C22686
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DBF7F46E;
	Fri, 23 Feb 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1pfL0Nj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418127E773
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695577; cv=none; b=sE+As9pFyn34JhM3K2Xp2C3URQralNRoeu7QBtw3EcQbotnRNOYxTVgmuO0l7qPuLj26yCZ9OpwLJYxZWAYIrmkrhQSsPJOY1kKCYEMWu67U7DWM5gqO56mABps2gm0fEBofxCTtH5MPMAbNFKdVKTCNq2FwIf3yuv6gUuVDVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695577; c=relaxed/simple;
	bh=Twp7tfSTw0JcrYxColLY4Ax9TG/pkPRhM7VLYkZRS4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XXpapI9Fnh4tbeQjd7dTDs6yhOOBap+CzSCbVO9EMNyxH03eYJvyyYCxsHF4rVESEptK6RX4SkvZYqe7eqSN2wBSCgZXFVqJulcQSTq3G3x+qpmxSltmxh4BB67NwpeG0Hr86AvsVzuI0QOZq2XnQvE5vx7XJCzPfAquMqZJG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O1pfL0Nj; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c40863de70so44332139f.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708695575; x=1709300375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4x2sMmK8Ljy9DYC/W73ZknuhG0GdB53Q7DPx/D50TQ=;
        b=O1pfL0NjKwcPNi6v4TRbX29zYKLHT9rMUoyBA4x2AZuL0ZSjaepb9uKDoEpUo3cMzk
         pJ9Imwnzko2bF3xyF4oqRTx3yD+bDoWAtWke12lKiK1u8FVmMYJGv8J2C24svYf45wow
         xTp4qQ7ZXEjU1BbrXn5OZ5+fmmRd7M2ERjJrtmT00sj5N8j1m7DmsgMNOtWy11a1fKPo
         hcJpWg8Baju6GSUd/gPvjBVW95iGZhqW/sUnGZfMc8y420mj4lABxgkkREtMgbtuiX7t
         x5sulLg0C39I3Dyt0Tk4ZZ6wxXAdpSwCzpD1TyKtIhVYM2/ckv/0/PlqMbrtc+tbvB9/
         pxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695575; x=1709300375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4x2sMmK8Ljy9DYC/W73ZknuhG0GdB53Q7DPx/D50TQ=;
        b=eKCc5Q/PbLnvo+hhRkb42e2ieSzxpWzByjFQaeVAEtW+NefQuT6r3WYXxNIV25THHD
         Fru7Cb0ByAtK2awKLlfg50CGc3bsi7aBAojTu/UfHPcDBkRoU/97MMVtmXIqBUE7mCLU
         DzBSgPil81IAhylXjcOuI/8kR+QYUKinYXQz1FoGUlBckV2YgfjIM86s5kb64gFPN7Ij
         HwXh8k0TKaLKgZIj05fGqPvKE7GoIy2D0pLqXKjm4Kb69QU9RlRLqt3UD2P1zSKp36Gv
         zZS6asD29aigppfH1lJKa7/HP/KrLkcadMXS6x47jUpKqmCbv855N+XQuN43uJ4xBk0w
         hljg==
X-Forwarded-Encrypted: i=1; AJvYcCX2obJ1gkrI0kxvdISyScgfpYzRZEXz1MwtxO5slU1mq7GzNvOluI+b/+DpnCX4l/bpQeOwjWkLzWkU4XybLCOvy4FsWF8T
X-Gm-Message-State: AOJu0YxeZyJKnWt1z8jG6RGRcU9+UE/8RaiYSW7dMERJc5E/gsHstZHy
	ZX2/6fpJljXXrDq2ohrpxx78Gsp+md2TGkWSNkR4H7m+KKTuMqLlHIFLJ8RwfF8=
X-Google-Smtp-Source: AGHT+IFrz5R0BlotlFi4jZ+FPrD+nKWN+cqkiTi9yfrUfHfyDhCGmqbGauLW7N/Kb+gQyn8NGnS1AQ==
X-Received: by 2002:a6b:c90e:0:b0:7c7:9185:e58e with SMTP id z14-20020a6bc90e000000b007c79185e58emr1936714iof.12.1708695575154;
        Fri, 23 Feb 2024 05:39:35 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id p11-20020a6b630b000000b007c76a2d6a98sm1836838iog.53.2024.02.23.05.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:39:34 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] net: ipa: don't abort system suspend
Date: Fri, 23 Feb 2024 07:39:24 -0600
Message-Id: <20240223133930.582041-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the IPA code aborts an in-progress system suspend if an
IPA interrupt arrives before the suspend completes.  There is no
need to do that though, because the IPA driver handles a forced
suspend correctly, quiescing any hardware activity before finally 
turning off clocks and interconnects.

This series drops the call to pm_wakeup_dev_event() if an IPA
SUSPEND interrupt arrives during system suspend.  Doing this
makes the two remaining IPA power flags unnecessary, and allows
some additional code to be cleaned up--and best of all, removed.
The result is much simpler (and I'm really glad not to be using
these flags any more).

The first patch implements the main change.  The second and
third remove the flags that were used to determine whether to
call pm_wakeup_dev_event().  The next two remove a function that
becomes a trivial wrapper, and the last one just avoids writing
a register unnecessarily.

Note that the first two patches will have checkpatch warnings,
because checkpatch disagrees with my compiler on what to do when
a block contains only a semicolon.  I went with what the compiler
recommends.

clang says: warning: suggest braces around empty body
checkpatch: WARNING: braces {} are not necessary for single statement blocks

					-Alex

Alex Elder (6):
  net: ipa: don't bother aborting system resume
  net: ipa: kill IPA_POWER_FLAG_SYSTEM
  net: ipa: kill the IPA_POWER_FLAG_RESUMED flag
  net: ipa: move ipa_interrupt_suspend_clear_all() up
  net: ipa: kill ipa_power_suspend_handler()
  net: ipa: don't bother zeroing an already zero register

 drivers/net/ipa/ipa_interrupt.c | 50 ++++++++++++++++-----------------
 drivers/net/ipa/ipa_interrupt.h |  8 ------
 drivers/net/ipa/ipa_power.c     | 33 ----------------------
 drivers/net/ipa/ipa_power.h     | 11 --------
 4 files changed, 25 insertions(+), 77 deletions(-)

-- 
2.40.1


