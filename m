Return-Path: <netdev+bounces-165487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116EA3249B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 12:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE8A18822A8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 11:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBA520ADF0;
	Wed, 12 Feb 2025 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKnKNN+R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5020ADD5
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358956; cv=none; b=fkwQlGITkXxbQrWxhmyhvwifkgGCP0FH8x1zBJwESQ9bUEOzyD5CvHj/+lELId6n2RCY/8Jwo9qMPC6yJnvnj7u4MZ1OlWdrmiFTky0mhpYeLCnxl5fuuF3pZucQlGf3tv4rG58AsA2DVqFOYr40tKSlhvWxXeo1+7Q+qoif+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358956; c=relaxed/simple;
	bh=KmLVO3U+iYEBCW5o4eq2WIngopSvAfgV6pjFjxxYZ5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f9izC5geT4BJ7DnMn7EFP4yjCNfCEEa2gG1IIcIIOAC8/fWLgGTlN5SMU2xACDt79CbtiWX4G3NcqHGOPlukCLHAev9e9KakQgzMMrEX2FrAJIRWG+TVpFFnU/Hs/x5j9J5XrPnVVkUjf01Wd7jWuU1fNuj4LcM0/G32fx0P6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iKnKNN+R; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dcc6bfbccso2948821f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739358952; x=1739963752; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWxCp0GqUGglcxropI6IErz42Kj74gEydU4plAioMCA=;
        b=iKnKNN+R7tePyntGwRysOoG/b4ZHGPKpSRPTognZfRc9J8kR9Qk8b5EuJtZTjkmvKC
         T65zey4BdRtBVr3bNo7wA43zTExEyzjVio54RUU28kRAjtujLRrZGgU9P2eSil4wkMDx
         sSV2jTzd1ejdroDVj3GU69/VnEH2Sc0yWxmxE+V5kDIJcWhr+yjz9sLbJ8wuuWsvr/Xt
         99rJmG+1NihsjOQuzA90/pK0HUcld+O6Hk8gOtoOoestzH725EqS2wCjh+efAPIDQ2mH
         xAu00eYJRI/nFj5I8RMAiox9G4wBEhgbmimYCyp9JIKMhrfJZdBkKwrNhJ3PWuFMFx5a
         zWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739358952; x=1739963752;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWxCp0GqUGglcxropI6IErz42Kj74gEydU4plAioMCA=;
        b=jE29020rLnvxsIh3dGvd4h1BgZodiSx4SSWMceBEVdj4s+7gy2OSt+ZZUJP7HoDr1z
         s5otuRZDOvep5Kg5Z9sbxZKxNVfnViM1fjZHb3qa1ss7BILI0QH3/hiIwnnSo4bypbsv
         LrQiVfZfmBtDGNBgecis6rIKYHFRjsHCErbvy1WyZFtRvoRVg41yatHuYVT6Bov1M+jA
         3yb5ebV9czL0t+95zjnWIMJFp6Pb0H+eUOmf5H/zYtxlVY5FkA45c61BNfdLutvw+DwI
         s4vPNEgtWjiLk7gZ9FFT9AaevnA4m7K6GJwtdkXE+0RZA9cUiWWjmS8GRaop10fKF95d
         jOXw==
X-Gm-Message-State: AOJu0Ywo0QoDcTrOegmpDoScWEz2K4U2yqeJGsDcDGh2wzDWogamSBk+
	sLxk5uUwAcF5iTC/o0g11pon5GoMbon4dFaLa8xVbIbNXCSE8hURK8LcZMRZglY=
X-Gm-Gg: ASbGncuKxtKkV3IRyqk0WOgXLNntHr1XiYZCb8SimypUs2GFQP2vrsVzTzMK6Gy/Qdj
	nYsRS985BCfdRUoTXL4ol3ifL9zcae3e+AuiEHJoS75K6xZDRAxa5ovQaQQb/UUpURHtsjlkf/d
	wgqmUTUkbBRp5+56fE2yO0yPJOA+b1XSYqWusUyoJtS6XQTf+017n0TnSoODt4qWVtfNU4TRdZK
	WkQ8kMb46gJl4qXi0tjf5zBG7bXVVA82jtMGGkQ96yvOrP5SFRLZlDIFzqEyUoyh+TK4QQ4QsV+
	hN5Bg7c35s4tfB0eCnIEZBc=
X-Google-Smtp-Source: AGHT+IEB8DPUJVTBcgIwTQ6Z6zvG98TpNWXfZaHucYN4Dxa3b44v/ASA0iItfsERoar6F0CFs4PV1Q==
X-Received: by 2002:adf:e60e:0:b0:38b:f4dc:4483 with SMTP id ffacd0b85a97d-38dea28c1e0mr1755786f8f.29.1739358952465;
        Wed, 12 Feb 2025 03:15:52 -0800 (PST)
Received: from [127.0.0.2] ([92.206.191.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a07ce08sm16538325e9.39.2025.02.12.03.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:15:52 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 12:15:35 +0100
Subject: [PATCH net-next] net: wwan: mhi_wwan_mbim: Silence sequence number
 glitch errors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>
X-B4-Tracking: v=1; b=H4sIANaCrGcC/x3MQQrCMBAF0KuUWTsQI3XhVcRFJ/k2A2bUJNpC6
 d0NLt/mbVRRFJUuw0YFX636tI7jYaCQJpvBGrvJOz86786ck/KyTMZZNHPF+wML4PmhLSQOUaK
 PMspJhPrxKrjr+v+vZGhsWBvd9v0HyF3ou3kAAAA=
X-Change-ID: 20250206-mhi-wwan-mbim-sequence-glitch-cdbd2db5b3bb
To: Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2

When using the Qualcomm X55 modem on the ThinkPad X13s, the kernel log is
constantly being filled with errors related to a "sequence number glitch",
e.g.:

	[ 1903.284538] sequence number glitch prev=16 curr=0
	[ 1913.812205] sequence number glitch prev=50 curr=0
	[ 1923.698219] sequence number glitch prev=142 curr=0
	[ 2029.248276] sequence number glitch prev=1555 curr=0
	[ 2046.333059] sequence number glitch prev=70 curr=0
	[ 2076.520067] sequence number glitch prev=272 curr=0
	[ 2158.704202] sequence number glitch prev=2655 curr=0
	[ 2218.530776] sequence number glitch prev=2349 curr=0
	[ 2225.579092] sequence number glitch prev=6 curr=0

Internet connectivity is working fine, so this error seems harmless. It
looks like modem does not preserve the sequence number when entering low
power state; the amount of errors depends on how actively the modem is
being used.

A similar issue has also been seen on USB-based MBIM modems [1]. However,
in cdc_ncm.c the "sequence number glitch" message is a debug message
instead of an error. Apply the same to the mhi_wwan_mbim.c driver to
silence these errors when using the modem.

[1]: https://lists.freedesktop.org/archives/libmbim-devel/2016-November/000781.html

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/net/wwan/mhi_wwan_mbim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index d5a9360323d29df4b6665bef0949e017c90876a4..8755c5e6a65b302c9ba2fe463e9eac58d956eaff 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -220,7 +220,7 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
 	if (mbim->rx_seq + 1 != le16_to_cpu(nth16->wSequence) &&
 	    (mbim->rx_seq || le16_to_cpu(nth16->wSequence)) &&
 	    !(mbim->rx_seq == 0xffff && !le16_to_cpu(nth16->wSequence))) {
-		net_err_ratelimited("sequence number glitch prev=%d curr=%d\n",
+		net_dbg_ratelimited("sequence number glitch prev=%d curr=%d\n",
 				    mbim->rx_seq, le16_to_cpu(nth16->wSequence));
 	}
 	mbim->rx_seq = le16_to_cpu(nth16->wSequence);

---
base-commit: 4e41231249f4083a095085ff86e317e29313c2c3
change-id: 20250206-mhi-wwan-mbim-sequence-glitch-cdbd2db5b3bb

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


