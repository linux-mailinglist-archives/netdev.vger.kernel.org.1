Return-Path: <netdev+bounces-173737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FC8A5B84C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 06:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AE4170704
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 05:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88021E231E;
	Tue, 11 Mar 2025 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEY8ksQK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8441C72
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 05:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670169; cv=none; b=PT5880EVKLGqJ8EMmofODZQsx9+V+mGuIEo47queljSZ0mfFzImbwqJRhHrpiOOCHuLJ7cPNUzyCxvoV6bCF0U+ECRX17i0HEyGLlddbbrgC1WZ7NLS2FhXgflC8hshspq9LlBEhR4Hps/B7kE1fzSArPlIRQpszBqHB5N9Z2Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670169; c=relaxed/simple;
	bh=If8TTXT/Wai6M4qRo3feeR4EXUWakyg46ExpYc0jMXQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=oRxjOKjSn62jRofST7TUyh+n997OK4JVkmv9L4EvxaAuIqA+AIoWOqel7fPpfSsSq1kYjMKweg6ycZ/mR6DPT02p9BtH+gkjr3hSrtdXZ3ApEVxzxNcvpSoSrESrNEXewZU7usF1oPPv0FIQkDhja06jCqEpEy7tM8h2QBeQJ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEY8ksQK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f42992f608so8442645a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 22:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741670167; x=1742274967; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLdloximMvRWgEEGkWNTCSJkS0eV4oAKG5hy6Bb4LfE=;
        b=hEY8ksQKuP/L1b0OGF7cYPlHRsuMd+OcgMdw1aW1071q1cs8BZC0C32Z1TgGNhyCZb
         NX4rHpEpWBRYVUohUJ9PkQDBPYcrkdYm1naKiBajOV9QBRWLhRDpSS3ortV+e7KaF6sG
         S/CRLZEreO+mHyeRX2ItiuiTZ56XHVQzvxlhcIHmiMI24/euerORQHhmtYByIEIXz8S/
         nQR0cvIiFKs3qUTAuOuyfOZebNq/FaHeX0JtWSz5pTsd6AL1km+1fpmaTsaBv01n6MYq
         QsEimjRkb+xhxly56L65woE+A4FGFURB+dwAhpM1VA41smxZvVC/p7ZB3iJhmDQYmS8M
         mmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741670167; x=1742274967;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gLdloximMvRWgEEGkWNTCSJkS0eV4oAKG5hy6Bb4LfE=;
        b=Wg6/ihfOZkKZm458x4OTYYXYggTJnSvjnZFd+FrM2CtUhM0fP6CjrcICKILzvE8XVC
         koLvhvBAT0v58st2g6EKHB3pFGTZkUhrHD9zttmdPz3c0pAirkAyU5alGoZWqe+lCind
         ptRdtexiceLYHynPe2wqbHwA99FWpStBGvj/ao0OvcCii/qAXbgKk4A0lLbNfSgAnl2M
         F5kXsbuZvmXIYTETYpiuehB2htln61hWUTp6YxaWA5quw+d179RpxbfzBAZnxzfT4vIu
         HUmb2IygPTM1FOimqvNUkwjiSPfs81i7EnlwlGD+Q+1WZKhlBbrMUxMdu8+IeSA6o6Hj
         LM2A==
X-Forwarded-Encrypted: i=1; AJvYcCV88bHj7rsIAlI61I1qiCDood/4HXQD0h28eMxqayEgWNBLkKp4QMU7ofFECxN9gQ94dP48wO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCf48/mdGw723UQCYZ+lzrlaXCrkyKh2Wv7qUXgw3QpxP/epN
	ojRua8QQYU2G6OIR5f/sc03vo5IG4roaMC+/ny4Tx5gKyS/hFlxe
X-Gm-Gg: ASbGnctsoWvWkh2j89kesRFDKPl4HpFbCh2W8Ba6qMwZJq7A/ebEkf3L5GoLjA+0HR8
	Hl89x3xVby/jgxDdKA9hSDgPwa7P9DFcNyvp+f7lJ3PJLMJVZ2zhY7rzxL+c2ZA59NMi+X/2ra/
	zidrv3HV8dxd24GjNuw0KypIvwrD7CPe4gdKkZIr4ZFQ8XQQmmV1YsrT+P9G9zFDueMKE/tkK1g
	qnGYFWllwcOghj1r253dewAIMZNnjJkRD9V3sb2hE+96WQYIYuKQ3J3eA+Q0Z+uMtcUD8Or+dj1
	7reFL7KZcI7J4sWzdlcLWzuHk8Bb4hpKb5Kjj61WOsnIsz29ACyyn8Y=
X-Google-Smtp-Source: AGHT+IFAtmecsBqXBSwYoPthA8fUaN2nJlg0QONOJ+jC1nVEU/KTQhxfhegnqcnJlYqJSVPEqBHA1A==
X-Received: by 2002:a05:6a21:4910:b0:1f5:8179:4f47 with SMTP id adf61e73a8af0-1f5817954aamr8270747637.20.1741670166166;
        Mon, 10 Mar 2025 22:16:06 -0700 (PDT)
Received: from [147.47.189.163] ([147.47.189.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cf005d87sm4063798b3a.49.2025.03.10.22.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 22:16:05 -0700 (PDT)
Message-ID: <e7e4e5d5-931d-4506-9d75-b87783011379@gmail.com>
Date: Tue, 11 Mar 2025 14:16:02 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
From: Kyungwook Boo <bookyungwook@gmail.com>
Subject: [PATCH iwl-next v2] i40e: fix MMIO write access to an invalid page in
 i40e_clear_hw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When the device sends a specific input, an integer underflow can occur, leading
to MMIO write access to an invalid page.

Prevent the integer underflow by changing the type of related variables.

Signed-off-by: Kyungwook Boo <bookyungwook@gmail.com>
Link: https://lore.kernel.org/lkml/ffc91764-1142-4ba2-91b6-8c773f6f7095@gmail.com/T/
---
Changes in v2:
- Formatting properly
- Fix variable shadowing
- Link to v1: https://lore.kernel.org/netdev/55acc5dc-8d5a-45bc-a59c-9304071e4579@gmail.com/
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 370b4bddee44..b11c35e307ca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -817,10 +817,11 @@ int i40e_pf_reset(struct i40e_hw *hw)
 void i40e_clear_hw(struct i40e_hw *hw)
 {
 	u32 num_queues, base_queue;
-	u32 num_pf_int;
-	u32 num_vf_int;
+	s32 num_pf_int;
+	s32 num_vf_int;
 	u32 num_vfs;
-	u32 i, j;
+	s32 i;
+	u32 j;
 	u32 val;
 	u32 eol = 0x7ff;
 
---
base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627

Best regards,
Kyungwook Boo

