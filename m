Return-Path: <netdev+bounces-64989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1DB838B8B
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 11:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA8A1C221A2
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5805A110;
	Tue, 23 Jan 2024 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTbn21Y9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990E5D730
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005011; cv=none; b=t9AXfrbcpAkV0afuCLB1AbNlHh4Fb3HAuGiV+zqpQc0f9Wj8FsUttLICR5rGTwQAiLSr/maCF9MFECkznC+9Gw6UxHVdNpb44WjPipJrLBU1oyHR6UOesDAmW+ut4/HjIp8zAlcIoFu1MtjKircmeS5gUvQdQOuO2R13Jv3GsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005011; c=relaxed/simple;
	bh=JHPL37lMRTAQU9k37XOFKfrRK07Q7igx+/VPXDQzLlY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LasHgoIHverkX54LYGRxvVPXU+RTRIH+QOFFLxrwbwOyc9vUOmuu2g/u2omSkP6WYol7TJi8BFXiYc/TxGyRdIa7/Hc6E9PxKhRdVsnRxByOuSFQc0fDSKK2kL7UV597dN6e6oeS0RKR1TjlhQIKkuRB5x2H6q7uqaYSP2gAVw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTbn21Y9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so53167895e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 02:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706005008; x=1706609808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++wEB47Brii4fgK+9R3Z1chBpDu4mJDkxZzUYYgThbM=;
        b=hTbn21Y9kI+5qt9fwOT0a5EBEYMsehl0j0ZTwfU3HegjeQlLvIjZ9ovocNWyp6Cb6w
         Mn1W5qNiJF9Jr5oFUMK1cBd3PjRooCRxzQkAZFzqb1P1wGktoBRItalMSkg+z4naNOsG
         TkhWhG5A+kn6YYdpMtiFj5PiuVaEjualyAgqtt0W+YV3HXGPsZgjq6f4nBf74laT3UZ6
         ymNweixPmAAlxO9ktfE0uZxTs64+1F63HKnW2j8CNWhE+npcQKTS0/QuUTDTYC+YJCsT
         IFPSIAQNelKHzAOtp231c9gYaO0keaDmCTcPPF8xDkYLMEIUtHuXG5YhsdZGwkFaHh3c
         MoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706005008; x=1706609808;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++wEB47Brii4fgK+9R3Z1chBpDu4mJDkxZzUYYgThbM=;
        b=a3z9YUQTrgnZh79B3nbbRGOFGMPTSFvrwkSd6dIv01lROoE7SbpinLvScrAAYB1fwq
         RjMbDsDOYHPE108qrsDjmcFwBB9CAV4UY+ylt10CVllohfzObJUk3+6NVexuLFYLIDNC
         yYeyTC0JBXzf3s9fEQSgpxe+A64z63bKk2FLiEpEo3x0QapoVIl8N/7Mc8Sk7wi1qRS3
         gVuWfNnuwrtiEW4CB7acfGo1b5vXdsGRONCH1/8/rb71m7WJSxSYPsz3OgYdd39Y5MuP
         gV/CTrRS33Tx7F/XeDC/0vBvkzHDS23XkBhysHbXGsrgMTYsGIvmXDj4CBjjJYxsjQid
         PDpA==
X-Gm-Message-State: AOJu0Yy3yj6kfA6jBtcmjut39onRUbjJjVkVTAb+BeQa2jMn8mCV/c9G
	av69pjn6UNfwL6Up5mhe7IFGrJeI02+Ejptt2J8W9XLv7ADS/fg=
X-Google-Smtp-Source: AGHT+IF4N8jSOXqT+kHed67TSMvfDzhzJdkOh3r4hXbzGtCIADALYFTY/T4SPZGCWBMhnH9XZhwiyQ==
X-Received: by 2002:a7b:ce15:0:b0:40e:44ad:2e47 with SMTP id m21-20020a7bce15000000b0040e44ad2e47mr389450wmc.185.1706005008510;
        Tue, 23 Jan 2024 02:16:48 -0800 (PST)
Received: from p183 ([46.53.248.133])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0040e53f24ceasm41830850wmq.16.2024.01.23.02.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 02:16:48 -0800 (PST)
Date: Tue, 23 Jan 2024 13:16:46 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH 2/2] connector, linux++: fix <uapi/linux/cn_proc.h> header
Message-ID: <3878dc5a-9046-4d7a-bf9e-70dcdc5d9265@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Rules around enums are stricter in C++, they decay to ints just as
easily but don't convert back to enums:

	#define PROC_EVENT_ALL (PROC_EVENT_FORK|...)
	enum proc_cn_event ev_type;
	ev_type &= PROC_EVENT_ALL;

main.cc: In function ‘proc_cn_event valid_event(proc_cn_event)’:
main.cc:91:17: error: invalid conversion from ‘unsigned int’ to ‘proc_cn_event’ [-fpermissive]
   91 |         ev_type &= PROC_EVENT_ALL;
      |                 ^
      |                 |
      |                 unsigned int

Use casts so that both C and C++ compilers are satisfied.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/uapi/linux/cn_proc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -69,8 +69,7 @@ struct proc_input {
 
 static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
 {
-	ev_type &= PROC_EVENT_ALL;
-	return ev_type;
+	return (enum proc_cn_event)(ev_type & PROC_EVENT_ALL)
 }
 
 /*
-- 
2.43.0


