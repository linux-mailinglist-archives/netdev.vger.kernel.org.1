Return-Path: <netdev+bounces-205613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CEBAFF69F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1944B1893215
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1055126F476;
	Thu, 10 Jul 2025 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kin4KQ7c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E9F3B280;
	Thu, 10 Jul 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752113674; cv=none; b=P6dyHyqVqH0wS520XxGtxCCwyWGb7qRDCEJc9P9JW3goM94Uyk9+15d6PYHSXjMXPiYWXD0ZZyuCCn1/dxK8GHEdxYAInvXvdUlS8v0vWDhcDhlzUOQi6+4ZiWSfDY9SLZKNifEVzHZzTm5n56oEN4sUOTW/w04DxUbsLUEqCHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752113674; c=relaxed/simple;
	bh=+azszdyQm5njzjmL/a2/eU9Cs1h5KPI+v0vM3MsgPDU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TtxX7qQ2ZuqgP2AnwxlRwiDksaGvv/KERrgZr4GlAl1/K93ZBRMZVobwqVFlXg8w0pY+nAyK2+rJ7LrXdoixjifSCyvyfdcDUHv3H0EFG20OxF8JMCUBuMBNgLzvZxnAWIsxWO6PZAXCvM9xSieVlG1LzdBNwnJFePsigX9Dn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kin4KQ7c; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a77ea7ed49so18865651cf.0;
        Wed, 09 Jul 2025 19:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752113671; x=1752718471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXsEAAyu4t7vtaCznBWRPCj9NkFi9mudpkMQgscxhVo=;
        b=Kin4KQ7c8+UzZDOkrFQM1Nbk4kCO8b7EokDwOskzCe9xOuw0LrT8anllxHSqxQmqKW
         3IzYxPshtaneSo4KURyRA3WhSZtLjgr5fvopDHt386xX4uomcgemod7KoSQrb9CES6Sa
         nlcz6gFnnm5+UD/uoohJwBQbmmwFZ7ktSJjqEaFl2RH+WwPjIfwHEGlekPhg6osyN3UR
         MIYvHYecAXqm8eD22NPTDM1eGTmnH3goQii1F82X3ke0KRucDy1mt+tgPyC+2n3LQO0k
         8OgJ3Ky0aJuVqaZeh4lNLnurLQs/CvZXxgiK243Jya+U/wt28dxU/pyDdziNmatqoN8T
         K0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752113671; x=1752718471;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXsEAAyu4t7vtaCznBWRPCj9NkFi9mudpkMQgscxhVo=;
        b=dSYtc/bCdOhChYtKITnv14xcqnuG1dsk/YiM067yGB9qsEja+7xfUQJSAL+SjvjsIs
         bWKAgZvkaDNr2kSeBohmbVAHVubx0A37CHdYeZn4p8ERzisbhx8az7CCiXfIwyMwNruS
         aTDyXzxGvIlOxqMXfGA/5qkCnaeF6VkwVTC3GObXimEqnjAihTAhCDTk4hYFrayalqTZ
         +z+1s2M1Ka6+H+drvW774eGvRbbvP4MS/aYFWOjkgn7b6e/Grhgt/zpYkO92mpxhgzwN
         YP1g9cOut1PlEqyK0z1iln8nR4eumB9171jsNCq86c0v1ts6xfGTuOxoPc2LDstErTFQ
         JkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2JI8OFFLVLSVlstppC8Xc5Wdhy6CmrL8TLwLBZ5060ElxniV2k6Xx0/fxVjd4Gxb27Y8tT2XiSRpN2Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5+ZOnDOCCrU/4OqNKZzuNSya3kGJRukLMRNMA0KgdeFCj6U/
	tRRLpI+/SAh6jfp3tNjB/e73vk5g6vmGKgV1Uhp0XDNyRwwf7cfScjDnTM8AQFdqKFZ2v5IGzcs
	1+3LYSSNL+MwQue4xVzUKBPqRfYL/3jE=
X-Gm-Gg: ASbGncsf2yDHyU4JBiHkow4avjTt+YHaQ7jIbZq0m33xf55jdTIQkbiXfMen8KKpQ1/
	1oCy14DuMtorpn2KJqgYrBpvqpCnsbqaCev+4JxVY07Hj92aZbUqEetbsPNUm4EkN6M0vAQg+bW
	cg4FT8ZRDubQoz+UQhVb12ef8A749OPVxrOD9sewmyKfmMPluzVkDf9W2qPqnioO7DFtPih8tDQ
	++aBA==
X-Google-Smtp-Source: AGHT+IE9DApePSErGAA/ORAQHxnV30HsTM4QpHddNc+G6o57lBF/3CS1dyuBiazqktGCA2RBfIDLSVJaKXTKcVOXJI8=
X-Received: by 2002:a05:622a:53c4:b0:4a7:6408:b449 with SMTP id
 d75a77b69052e-4a9e9bf79afmr30573991cf.2.1752113671158; Wed, 09 Jul 2025
 19:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wang Haoran <haoranwangsec@gmail.com>
Date: Thu, 10 Jul 2025 10:14:18 +0800
X-Gm-Features: Ac12FXy4sA3Y5p93FIgkC7LpgCNGIxnS7GA1E20rAtELB4505qbwURa952QE8d8
Message-ID: <CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com>
Subject: We found a bug in i40e_debugfs.c for the latest linux
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, my name is Wang Haoran. We found a bug in the
i40e_dbg_command_read function located in
drivers/net/ethernet/intel/i40e/i40e_debugfs.c in the latest Linux
kernel (version 6.15.5).
The buffer "i40e_dbg_command_buf" has a size of 256. When formatted
together with the network device name (name), a newline character, and
a null terminator, the total formatted string length may exceed the
buffer size of 256 bytes.
Since "snprintf" returns the total number of bytes that would have
been written (the length of  "%s: %s\n" ), this value may exceed the
buffer length passed to copy_to_user(), this will ultimatly cause
function "copy_to_user" report a buffer overflow error.
Replacing snprintf with scnprintf ensures the return value never
exceeds the specified buffer size, preventing such issues.

--- i40e_debugfs.c 2025-07-06 17:04:26.000000000 +0800
+++ i40e_debugfs.c 2025-07-09 15:51:47.259130500 +0800
@@ -70,7 +70,7 @@
  return -ENOSPC;

  main_vsi = i40e_pf_get_main_vsi(pf);
- len = snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
+ len = scnprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
        i40e_dbg_command_buf);

  bytes_not_copied = copy_to_user(buffer, buf, len);

Best regards,
Wang Haoran

