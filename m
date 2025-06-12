Return-Path: <netdev+bounces-196790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0C0AD65D1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 04:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D3917EF9C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C12E1C3039;
	Thu, 12 Jun 2025 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsgZ6rGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFCF80BEC;
	Thu, 12 Jun 2025 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749696029; cv=none; b=K64Gwyr9/oDlFvLnGZ79ElmAI+4VMKZbAIfvH2bM36lz9I1xfnKp5VEMzIugRWx8n6xmJUA4WUCi2n3ghtrXN1jHQd68krQu9VUmJeCZp9D124OE/4OWVXfdmuRARmDQix7lDKM4d8IOUiOmxF+IF7Q6fbcvrJTzjg9nPjffz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749696029; c=relaxed/simple;
	bh=TyXUoHWRblLyZxPzeqprpQxDUOMQRrRF9VVZTWs2yGY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ch+IU4u32ddq0I2lNY+0cu4pOBYcokLPWp+tk3s39rwCooY8Fj8ci5axN9Hy0pf7tt+NFLG/1nJBSzHzAhyn+8amnw0yHEXyXhSh7uOjr9SHRz2DxC/dZroKXXDU7zM0omrgtbTB3AJnIVJSeFjUrQtEPELR5JiUHuFhSJqNg90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsgZ6rGJ; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4c6cf5e4cd5so276073137.2;
        Wed, 11 Jun 2025 19:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749696027; x=1750300827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TyXUoHWRblLyZxPzeqprpQxDUOMQRrRF9VVZTWs2yGY=;
        b=nsgZ6rGJ5yqMc/4O8voSKtUKF4dgcG115+RLg7OMFhXA5midJv2BeLOvFebZBwwC6U
         bgHf/YraPiOOQPryy1WoM2V79QQX+dL92xljQPqa0XzZqT75wmNpBBAhoRy2DixaQXnk
         VZgc3frcS7TM7IsFFS7RIQgPM6x3V4oX5Ajt8VgEmUslRFVd00lPK/4vL9ustS2kL1YH
         TrPAOj0Idd0WItxT3XZx/fZyf4D6ssEFKhHH7JNuT6Kv1hripBt9rV5a53+DYhj7G4Wf
         kEdsHtkQeZ/G5wOPrRWJddl81wy1H/Tlvvdb7xwAoqLxTtBLLB4swX2QokC/otrrSQLw
         cuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749696027; x=1750300827;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyXUoHWRblLyZxPzeqprpQxDUOMQRrRF9VVZTWs2yGY=;
        b=SMbexOaPs6HpdlVem0FYbY8sLBCg3yc6ZhxH3uYfD6cI1YR96AApRAMw3spPbdmpLW
         YFShv+ysc5IAmCjCtPU1VuRNDaunsQDNozihQ5gQOostJ3YUIqpy4bfFQWbMTJnPkKRv
         MT5zXkbHGjm9QdHqJlV9h6WjUVZHVpMpAGAvLW4KkmIRQZE78+Ie4tZbbSKu2HDjo8YI
         VlcBCh7QVlMxcFvQXlYBgr11DXCw6Q8BathjoTCey8HZveOoo1v0hucn4ZA83QPeZzjh
         /OOAuOXkjTUYfdg3CHocKi86Pgm8ue4Vq9bMrGHgGnHLhbAKYWqxNO15k36cwk4eNiJA
         mFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQHzw+J2zALTdzBHA0EiN2Go7rOZ0wYJKUayUIgG2hBgLgJczJKltYvfbQiElCz4dzA57URf/Gtezamhg=@vger.kernel.org, AJvYcCV+XK6gg9BM3IlEm3CZbRuyH53D5Gu41qK5aI/PxOQ0d/HYyWbfWQ+cn4Q1rrDua8ijgyyPeJ12@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQbHTzsz1fb21PK9ZE7ZWPXdWh0Z/pvVqg2BybB+6kXdHn0Lf
	3lfXdG/vQApSY2YvWQSznCRhhoAkuyzOc0IyPHp3DphFDytc7gLQnDw3bSKV+f0cQG7p2BuMRmx
	rolT88eLKPmRBOMTknM9ygNUOcHeotoc=
X-Gm-Gg: ASbGncsBI8S1NP4inzvUYCYludHr8+Ll885QuXAWNc4UpDxTStb6web1ZQSmeeVIAxu
	FA+0goA/ZameKiAHhEXgT+jisgT8qQspFoE+wZ0lIeUkjWZbeh411yoY3hgVlMbJOognpUTWjlN
	sGVk63CJhdfhnBgfRgv5HkPCvOorBI/MjjJdIZgXN64kCk
X-Google-Smtp-Source: AGHT+IFejaz2zqnpM2yJymPgysqoL6UoljVq0Q1NNvA7yQG6Tbtwl6NxO3p85yJLkwUNfooUosLCBSML4V6/FG2QVcM=
X-Received: by 2002:a05:6102:149b:b0:4e2:82c3:661c with SMTP id
 ada2fe7eead31-4e7bae9c726mr6252618137.11.1749696026678; Wed, 11 Jun 2025
 19:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Thu, 12 Jun 2025 10:40:11 +0800
X-Gm-Features: AX0GCFtY_taNWQHaUe6h0nM9AD1in2faPz9H8AVrPVu0yswdZn9OP-PGtZLblI8
Message-ID: <CAOU40uDOh7JY7nVmrS1Pr013zMP2Y=qLwiJeANvgEupNvuHnWw@mail.gmail.com>
Subject: [BUG] BUG_Address_NUMNUMac1414bbbb_on_device_lo_is_missing_its_host_route
To: dsahern@kernel.org
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I discovered a kernel BUG described as
"BUG_Address_NUMNUMac1414bbbb_on_device_lo_is_missing_its_host_route."
This issue occurs in the IPv6 address configuration logic in the
function addrconf_add_ifaddr() within net/ipv6/addrconf.c, where a
BUG() assertion is triggered due to a missing host route for an IPv6
address assigned to the loopback interface (lo).

In the triggering sequence, the loopback interface is assigned a
unicast IPv6 address (e.g., 200:0:ac14:14bb::bb) and subsequently used
in a bind() or connect() system call by an IPv6 socket. During this
process, the kernel attempts to create a host route for the newly
assigned address using ipv6_generate_host_route(), but the route
installation fails, triggering a fatal BUG().

Suggested fix direction:

Investigate the logic in ipv6_generate_host_route() and
addrconf_add_ifaddr() to ensure that assigning an IPv6 address to lo
always either installs the appropriate host route or gracefully fails.
Consider special casing the loopback device to avoid invalid or
unnecessary host route installations.
Add error handling or a fallback to prevent fatal BUG() when
ipv6_generate_host_route() fails.

his can be reproduced on:

HEAD commit:

fac04efc5c793dccbd07e2d59af9f90b7fc0dca4

report: https://pastebin.com/raw/xe3fvj5Z

console output : https://pastebin.com/raw/8XXmK7B8

kernel config : https://pastebin.com/raw/6iC2wRBj

C reproducer : https://pastebin.com/raw/SN7zKXeN

Let me know if you need more details or testing.

Best regards,

Xianying

