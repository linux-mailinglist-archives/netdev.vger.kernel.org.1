Return-Path: <netdev+bounces-227049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B025BA7825
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 23:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFCA7AB28A
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 21:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC4029C343;
	Sun, 28 Sep 2025 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dnMrIEla"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B529BD83
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759093881; cv=none; b=QDanH7AcNoJuIqBG4ysQnhIbwS9TabK2RP9kK0zcaMksbkQGs+jnkGoyPjKnTWofyZZYx8OpSoXJOcJyRlREWyKvBY945gdcMXa6aQrinW0fjC2Gf2kizDjv2+Us4HABlB8syJazN4rCsFTJfAAejWLki4LVEa8//gaTEzr7pKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759093881; c=relaxed/simple;
	bh=2WutnJMSjx/tlVTggiTq270RlFcGDjrZKvKJKGu3jOw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OX1heDGaf//FPXlH6UYuiXun/9ELcO9tBD38NThrhcRdJxVzGrAn4mglGzoNeY2ov9eb5DF5nRYfSw7KUEoK2JJ0eWwcE6rvndRE4r984Y1NaYr/RA/TLRGOUwN/8L/Zh8lZSBc8I+P4X6cLOrrXXzfHFRt9yM0Gpd2f7coxM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dnMrIEla; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4258ac8f64dso37389655ab.0
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759093878; x=1759698678; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2CtyGjaKoFTpWcOtehpSu1UKfzRtFMQx8MVWa1Gk1A=;
        b=dnMrIElaL66HRDTkGyYnpgkwF9BHH0AaFZXcBaB1XCM18jMyPlLAg/b42WuVB21yoW
         hCNcPS9luAmll9h9Q+2cCnvsr6GjsS9+J/D/rwCzcK3ymxkBDfEK0KqHtolkhkKCA0ZY
         /IqL2w89o6n0PBT911ZAf088jpxnSK3SP/BXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759093878; x=1759698678;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x2CtyGjaKoFTpWcOtehpSu1UKfzRtFMQx8MVWa1Gk1A=;
        b=cAEkEWf2u8qkeEvxqRKTjXCHmnm9nqznAZfeI2VcnQlDvS0ytIHUqnEDvEZSeyWDvi
         BEYt+UmFbbnSJbhHUrdLMOTbG3D4aiPSRhrL3VeuRl21Y4TEukvH+WpvHNTUuyEphAl6
         Qo0ZWuiCFHyHpLtdif9q6Gc5Nrhz2JaFZRTOb03UqFkRPZMl1l8qcoML9RFflkRNtO5e
         IOZsyOkv3OseKlsHuPA/CLTnG9Pfo032+yJKcU6BM9124sPrxbL/WROi529z5cEmlqGW
         jINKmdiuZZVeFqqYkQnQ667ZKh5BLz643Qp+sodlW6NpmspGiX0g2BoWf91VZg1wCNpZ
         r/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0MRBSJrGokDORKBbtsnCRX6M6oNCAXn5KW1Lmvk8lAgKoQRkSVxcn8u8g0UlapERGMkoeYe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLl3STyDzDqaopSUtnvaNcmHql6OhfNl74mVhwSZakKNgcOgm+
	Zr4SfcOmkxQ5STqg1IzGYe3zqguozNi4aaWWQsRdhBg1inVCJXfWjjb2mVitb035L8M=
X-Gm-Gg: ASbGncvJ8cKZ7DJtlYjPjIJyJw7uERNSbpnzTH/1dIEAxAbIBeAE8GJJlQjkgkV6rEK
	Ua9B3wc+VjLZ5ZjAMmZawHwrV3rjRluQjknQo3KY1moPfYrVmCbEzp0aesSmeaCZVYq73co7NLw
	Os6aTpgtSuvPae3R19JMVTjV5aa2EJJQI17YyJZpQQ9fAotzt5RVQzwtSFgOM+YVthQ1pq1kL0f
	zp7kT5HVUyW9nOgLheElPr4sSfIa8WDI9zlKHWTXYVCXfLs/nlkP0ZIfwoB/MBKiGrooxF1XZF3
	WbWyNW2XnRNcL+oz+0q+vlK375QW04zS+iQDgYZD97chPmegxzJykBnAPMo1q53ymCmaK+UaUVn
	rLLPk40dz0GllkRqt+jEKpEIXaT0WArYTR1p96guVCJk8Gg==
X-Google-Smtp-Source: AGHT+IHqp7ALrXM+DvPJjeZMY1xmr69x803hbF1blrS69ctYlZzUIH/zHItwG4gHcHpIU/0U87BM3Q==
X-Received: by 2002:a05:6e02:3a0d:b0:425:7ab4:d61 with SMTP id e9e14a558f8ab-4259563bb2bmr235228455ab.25.1759093878404;
        Sun, 28 Sep 2025 14:11:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425bff834fasm49570665ab.37.2025.09.28.14.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 14:11:17 -0700 (PDT)
Message-ID: <47b370c2-9ab2-419f-9d43-8da310fedb4a@linuxfoundation.org>
Date: Sun, 28 Sep 2025 15:11:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 David Gow <davidgow@google.com>, johannes.berg@intel.com
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Networking <netdev@vger.kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: Error during building on next-20250926 - kunit.py run --alltests run
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas and David,

I am seeing the following error during "kunit.py run --alltests run"
next-20250926.

$ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=16
ERROR:root:/usr/bin/ld: drivers/net/wireless/intel/iwlwifi/tests/devinfo.o: in function `devinfo_pci_ids_config':
devinfo.c:(.text+0x2d): undefined reference to `iwl_bz_mac_cfg'
collect2: error: ld returned 1 exit status
make[3]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
make[2]: *** [/linux/linux_next/Makefile:1242: vmlinux] Error 2
make[1]: *** [/linux/linux_next/Makefile:248: __sub-make] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Possile intearction between these two commits: Note: linux-kselftext
kunit branch is fine I am going send kunit pr to Linus later today.
Heads up that "kunit.py run --alltests run" is failing on next-20250926


commit 031cdd3bc3f369553933c1b0f4cb18000162c8ff
Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Date:   Mon Sep 8 09:03:38 2025 +0200

     kunit: Enable PCI on UML without triggering WARN()


commit 137b0bb916f1addb2ffbefd09a6e3e9d15fe6100
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon Sep 15 11:34:28 2025 +0300

     wifi: iwlwifi: tests: check listed PCI IDs have configs

Note: linux-kselftext build just fine.

thanks,
-- Shuah


