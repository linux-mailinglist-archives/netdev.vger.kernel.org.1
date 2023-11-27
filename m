Return-Path: <netdev+bounces-51387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319207FA7DA
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86A4281608
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3073B37179;
	Mon, 27 Nov 2023 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA4VXGQ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8B4189
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 09:20:14 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-332fd78fa9dso953452f8f.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 09:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701105612; x=1701710412; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltPV5wJpDHhxNQTBDRpiKw9/jf5mjTGr9mK1u9JuiMM=;
        b=fA4VXGQ18b8DtFuSVKllrbxcGFZfp9/H9MEjnumz43d9IVD0W4ZmPTwk2+0eD9qVvf
         QE5OKC5gvozIHhg6zD7bYlwTNoMc7FI89Vv+h9g3GzT/gxwpAJt9vfqsoJF+c/8mdKl0
         tDf2fmpN/RJ4wAp7qeCBU7+0VeYPP4iB8vlIxSi961glyyEPw9ErsP5OI38tnDcJtFw+
         TJJ+WI857iYBLqLkeyuHY2rPnlhjgpF4IQvorrnL6IPKKvVAIHSjnQiBbTB7V/LSJ/li
         YjwvzUz+d+6Dozxa1rPRHkrCX63BR66MyDcKtLxqleipOUbPKvXTM1nbSkd4wtcRuA4D
         ODQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701105612; x=1701710412;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltPV5wJpDHhxNQTBDRpiKw9/jf5mjTGr9mK1u9JuiMM=;
        b=CiGn5gYAUl/VD8UoC/fFrtUAzKJoWSygqUd4yvWvooZ6eAy0Rflfu8lC7Ptm8vdQ/W
         4PxZd/scntkH3WWqjLVO6pWRFVQZ/DFkLOiCEAeLk8wBGVRIURFB0gP2SI5WAl2qHgKn
         GhhbcdFqrAecU+xmjiOyckXmjn9o+Pt3msTX8gE+OcLverfX6N6TqAf9JIyuYNNcxF3H
         xegKBTV2hVd6l4lvUIfBdHePXcRlm34dgoqM3KwuQl3TJRsf9Ssc0rbyOAYxmT+jQzfX
         9eukGI1zIyct4IdPdOB23YA9sW9dduFt1iHhjCgPyzlr6pzjNMQ6fEnFVv5Vih8/EKUy
         TV/w==
X-Gm-Message-State: AOJu0YxOoVXbtG9UmEPreZLwiSPKZwynRWRRhBfFF0YC+r5jEegZO3CE
	s9RWXD7xwmVQGtEFtP9OIvY=
X-Google-Smtp-Source: AGHT+IGaEQQ7Zskblfyyd8KloGi+9diiN+mIAFq//3gvpKwGzrIcJSNANpeNmEr7mSllWBSEijuG9Q==
X-Received: by 2002:a05:6000:181b:b0:332:ca1e:679f with SMTP id m27-20020a056000181b00b00332ca1e679fmr8646186wrh.52.1701105612042;
        Mon, 27 Nov 2023 09:20:12 -0800 (PST)
Received: from ?IPV6:2a01:c23:b815:5700:a463:59a7:865f:2563? (dynamic-2a01-0c23-b815-5700-a463-59a7-865f-2563.c23.pool.telefonica.de. [2a01:c23:b815:5700:a463:59a7:865f:2563])
        by smtp.googlemail.com with ESMTPSA id w12-20020adfee4c000000b00332f82265b7sm6359293wro.20.2023.11.27.09.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 09:20:11 -0800 (PST)
Message-ID: <c65873a3-7394-4107-99a7-83f20030779c@gmail.com>
Date: Mon, 27 Nov 2023 18:20:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: improve handling task scheduling
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

If we know that the task is going to be a no-op, don't even schedule it.
And remove the check for netif_running() in the worker function, the
check for flag RTL_FLAG_TASK_ENABLED is sufficient. Note that we can't
remove the check for flag RTL_FLAG_TASK_ENABLED in the worker function
because we have no guarantee when it will be executed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b74d7cc50..91d9dc5a7 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2228,6 +2228,9 @@ u16 rtl8168h_2_get_adc_bias_ioffset(struct rtl8169_private *tp)
 
 static void rtl_schedule_task(struct rtl8169_private *tp, enum rtl_flag flag)
 {
+	if (!test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
+		return;
+
 	set_bit(flag, tp->wk.flags);
 	schedule_work(&tp->wk.work);
 }
@@ -4468,8 +4471,7 @@ static void rtl_task(struct work_struct *work)
 
 	rtnl_lock();
 
-	if (!netif_running(tp->dev) ||
-	    !test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
+	if (!test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
 		goto out_unlock;
 
 	if (test_and_clear_bit(RTL_FLAG_TASK_TX_TIMEOUT, tp->wk.flags)) {
-- 
2.43.0


