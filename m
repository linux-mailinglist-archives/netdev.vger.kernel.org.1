Return-Path: <netdev+bounces-117091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3765D94C9B1
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 07:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08A6B217AE
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515C16C6A4;
	Fri,  9 Aug 2024 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFYL3E8D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05612E7E;
	Fri,  9 Aug 2024 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723182142; cv=none; b=RbPmNvUJ77Da06/8bI4G8JUEFLF5Ccl8Z+F6Cf1BfcHOhMSQSb6b8KX+xM0jV/R2rEShkaTKpp8RZtzrNh/YMUrxVcngniWIs8bCVUYxrpM5sS9XW1YtF+EinI4CXkwCm9L3rtEZFaERznaMGZReB3lo2DBGRjQbKIKuEabvZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723182142; c=relaxed/simple;
	bh=y71pVoZKTdKKHdxGfKfSxKEi+h6PYacutsiEOdrN9Fg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fS/3gcEB+UxvlxIsAfMOJfhDXH8b5ByH7CYd6JDiUQRk7/KORwjxCatIHj7ydUGmUV4GS0ZMUmA3vx8VnIwemdeGCP814yngXJgmPi26Cz1+riliujc4xVgVom8uUAqKAgQH3mXOwjXrZjYK2UUmK01B/Ho38ULx6ucqvAL7EaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFYL3E8D; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a92098ec97so1321845a12.2;
        Thu, 08 Aug 2024 22:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723182140; x=1723786940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y71pVoZKTdKKHdxGfKfSxKEi+h6PYacutsiEOdrN9Fg=;
        b=JFYL3E8DRm5Mpu5bDqAP9Y0/GL9prI3tg0TJV6vMLVdrFj3j8nyIXrNyJLtesuhTYf
         8Z/ox00e9tXDbBZOTUOMDVK/3hEtpXxit1L2ydk4ja4ljzkfhHVRdYHXBTDL7VtMuZlc
         Y/uXGMoCme3wDmWbuE0ZZHe+xheJ8ZiAnaCL/cCgRBaQwDoZdgPM+cG24WYq74lVmcI0
         Vf6dtspEBb9jiW7nqlampXHD3NdTa/QJe2Vy2sSCDukgRcOnnBESxuaTUbCITvMlyOxO
         ncF0Wo+3zMz4vnHFgzmQexexBykky8vroASRg3yfdi0dVHbW/wFnsaXSqo5H5SQ0etqT
         QGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723182140; x=1723786940;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y71pVoZKTdKKHdxGfKfSxKEi+h6PYacutsiEOdrN9Fg=;
        b=KozdhKD5U/bJeBiC/Ezw1EJ0Dcwrk+rK03MBc7Uiyw7f2KrQo0lYdFtySUhehWx5hz
         JCEo2u73FEJzgAbzdQL8M1yRuTi4tS6tvb75UUumb0KB7L1FHWtpbUTkchJIeKjsBoEB
         N4waQq0DNGwVmWpLUmrntJh9jQORdviEiRdjwh0Sc9OHGzZ79wURWdr1s7C0zDaCAOfd
         7UZw/LEmj3t4s22ZzEnanmeI37JGYRnWDGL4c067y3yg0Fa7Y69iN8T5FPDultZ4pmYb
         EfqOMgQRwcGZXyn2jlRjS2jCkkkXbqbBw3+4OnyJIfqHvobVuxHE7xL41DRaAn2QmmHX
         /BtA==
X-Forwarded-Encrypted: i=1; AJvYcCVrEf16YXnquE3n7EQtALmIOJeekhr1Ogf+OQumj8+RBaFpxBJfU62wCZPMgJjbrW9MNjNp5JhrFG0WQ4CgGpvcU2SR4BVzWqivMd7vK4xQ71SyIr+peDoSInm8swZFgkHF4bt8
X-Gm-Message-State: AOJu0YyhllLwlIRshc+Wa6oBsGpgwmf4P68ELkUNH3ZRzLPykK1PV8r7
	s/o5zfu3TwLtAn3rJxLF5+ip7EO9Sk7waMWJC3BC9seo4Sp68+6Cr4IKjPdGrUInEhucHe5Ukj0
	Snpn7l0XM+bAoJakPrwPE9g7K4Yw=
X-Google-Smtp-Source: AGHT+IFIFF9mIsinZE9JHaj/JIl9r1ax+khm2LOD0ZgkOgZeK8ldLrm7kM9Xp9bIH9SLAAXyWuPQfr/zvUiCWajG1oE=
X-Received: by 2002:a05:6a20:c78c:b0:1c2:8e96:f767 with SMTP id
 adf61e73a8af0-1c89ff8080amr742333637.31.1723182140072; Thu, 08 Aug 2024
 22:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daiwei Li <daiweili@gmail.com>
Date: Thu, 8 Aug 2024 22:42:08 -0700
Message-ID: <CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [iwl-net v2 2/2] igb: Fix missing time sync events
To: vinicius.gomes@intel.com
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com, 
	intel-wired-lan@lists.osuosl.org, jeffrey.t.kirsher@intel.com, 
	jesse.brandeburg@intel.com, kuba@kernel.org, kurt@linutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, sasha.neftin@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi,

It appears this change breaks PTP on the 82580 controller, as ptp4l reports:

> timed out while polling for tx timestamp increasing tx_timestamp_timeout or
> increasing kworker priority may correct this issue, but a driver bug likely
> causes it

The 82580 controller has a hardware bug in which reading TSICR doesn't clear
it. See this thread
https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/ where the
bug was confirmed by an Intel employee. Any chance we could add back the ack
for 82580 specifically? Thanks!

